/*
Openmpt module for SoLoud audio engine
Copyright (c) 2016 Jari Komppa

This software is provided 'as-is', without any express or implied
warranty. In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

   1. The origin of this software must not be misrepresented; you must not
   claim that you wrote the original software. If you use this software
   in a product, an acknowledgment in the product documentation would be
   appreciated but is not required.

   2. Altered source versions must be plainly marked as such, and must not be
   misrepresented as being the original software.

   3. This notice may not be removed or altered from any source
   distribution.
*/

#include <stdlib.h>
#include <stdio.h>
#include "soloud_openmpt.h"
#include "soloud_file.h"

extern "C"
{
	void * openmpt_module_create_from_memory(const void * filedata, size_t filesize, void *logfunc, void * user,void * ctls);
	void openmpt_module_destroy(void * mod);
	int openmpt_module_read_float_stereo(void * mod, int samplerate, size_t count, float * left, float * right);
	void openmpt_module_set_repeat_count(void* mod, int repeat_count);
	void openmpt_module_set_position_order_row(void* mod, int order, int row);
	int openmpt_module_get_current_speed(void* mod);
	int openmpt_module_get_current_tempo(void* mod);
	int openmpt_module_get_current_order(void* mod);
	int openmpt_module_get_current_pattern(void* mod);
	int openmpt_module_get_current_row(void* mod);
}

namespace SoLoud
{
	OpenmptInstance::OpenmptInstance(Openmpt *aParent)
	{
		mParent = aParent;
		mModfile = openmpt_module_create_from_memory((const void*)mParent->mData, mParent->mDataLen, NULL, NULL, NULL);		
		openmpt_module_set_repeat_count(mModfile, -1);
		mPlaying = mModfile != NULL;		
	}

	unsigned int OpenmptInstance::getAudio(float *aBuffer, unsigned int aSamplesToRead, unsigned int aBufferSize)
	{
		if (mModfile == NULL)
			return 0;
		int s = aSamplesToRead;
		unsigned int outofs = 0;
		
		while (s && mPlaying)
		{
			int samples = 512;
			if (s < samples) samples = s;
			int res = openmpt_module_read_float_stereo(mModfile, (int)floor(mSamplerate), samples, aBuffer + outofs, aBuffer + outofs + aBufferSize);
			if (res == 0)
			{
				mPlaying = 0;
				return outofs;
			}
			outofs += samples;
			s -= samples;
		}

		return outofs;
	}

	bool OpenmptInstance::hasEnded()
	{
		return !mPlaying;
	}

	OpenmptInstance::~OpenmptInstance()
	{
		if (mModfile)
		{
			openmpt_module_destroy(mModfile);
		}
		mModfile = 0;
	}

	void OpenmptInstance::setPositionOrderRow(int order, int row)
	{
		if (mModfile)
			openmpt_module_set_position_order_row(mModfile, order, row);
	}

	int OpenmptInstance::getCurrentSpeed()
	{
		if (mModfile)
			return openmpt_module_get_current_speed(mModfile);

        return SOLOUD_ERRORS::FILE_NOT_FOUND;
	}

	int OpenmptInstance::getCurrentTempo()
	{
		if (mModfile)
			return openmpt_module_get_current_tempo(mModfile);

        return SOLOUD_ERRORS::FILE_NOT_FOUND;
	}

	int OpenmptInstance::getCurrentOrder()
	{
		if (mModfile)
			return openmpt_module_get_current_order(mModfile);

        return SOLOUD_ERRORS::FILE_NOT_FOUND;
	}

	int OpenmptInstance::getCurrentPattern()
	{
		if (mModfile)
			return openmpt_module_get_current_pattern(mModfile);

        return SOLOUD_ERRORS::FILE_NOT_FOUND;
	}

	int OpenmptInstance::getCurrentRow()
	{
		if (mModfile)
			return openmpt_module_get_current_row(mModfile);

        return SOLOUD_ERRORS::FILE_NOT_FOUND;
	}

	result Openmpt::loadMem(const unsigned char *aMem, unsigned int aLength, bool aCopy, bool aTakeOwnership)
	{
		MemoryFile mf;
		int res = mf.openMem(aMem, aLength, aCopy, aTakeOwnership);
		if (res != SO_NO_ERROR)
			return res;
		return loadFile(&mf);
	}

	result Openmpt::load(const char *aFilename)
	{
		DiskFile df;
		int res = df.open(aFilename);
		if (res != SO_NO_ERROR)
			return res;
		return loadFile(&df);
	}

	result Openmpt::loadFile(File *aFile)
	{
		delete[] mData;

		mDataLen = aFile->length();
		mData = new char[mDataLen];
		if (!mData)
		{
			mData = 0;
			mDataLen = 0;
			return OUT_OF_MEMORY;
		}
		aFile->read((unsigned char*)mData, mDataLen);

		void *mpf = openmpt_module_create_from_memory((const void*)mData, mDataLen, NULL, NULL, NULL);
		if (!mpf)
		{
			delete[] mData;
			mData = 0;
			mDataLen = 0;
			return FILE_LOAD_FAILED;
		}
		openmpt_module_destroy(mpf);
		return 0;
	}

	Openmpt::Openmpt()
	{
		mBaseSamplerate = 44100;
		mChannels = 2;
		mData = 0;
		mDataLen = 0;
	}

	Openmpt::~Openmpt()
	{
		stop();
		if (mData)
		{
			delete[] mData;
			mData = 0;
		}
		mDataLen = 0;
	}

	AudioSourceInstance * Openmpt::createInstance()
	{
		return new OpenmptInstance(this);
	}

};
