/*
libmodplug module for SoLoud audio engine
Copyright (c) 2014 Jari Komppa

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

#ifndef MODPLUG_H
#define MODPLUG_H

#include "soloud.h"

namespace SoLoud
{
	class Modplug;
	class File;

	class ModplugInstance : public AudioSourceInstance
	{
		Modplug *mParent;
		void *mModplugfile;
		int mPlaying;

	public:
		ModplugInstance(Modplug *aParent);
		virtual ~ModplugInstance();
		virtual unsigned int getAudio(float *aBuffer, unsigned int aSamplesToRead, unsigned int aBufferSize);
		virtual bool hasEnded();
		virtual void mpInit(Modplug *aParent);

		void seekOrder(unsigned int order);
		int getCurrentOrder();
		int getCurrentPattern();
		int getCurrentRow();
		int getCurrentTempo();
		int getCurrentSpeed();
	};

	class Modplug : public AudioSource
	{
	public:
		char *mData;
		unsigned int mDataLen;
		Modplug();
		virtual ~Modplug();
		result load(const char* aFilename);
		result loadMem(unsigned char *aMem, unsigned int aLength, bool aCopy = false, bool aTakeOwnership = true);
		result loadFile(File *aFile);
		virtual AudioSourceInstance *createInstance();
	};
};

#endif