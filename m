Return-Path: <bpf+bounces-43196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7481D9B13D4
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 02:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA3C1F22D08
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 00:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124EF217F37;
	Sat, 26 Oct 2024 00:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKKw+N15"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B71C12E4A
	for <bpf@vger.kernel.org>; Sat, 26 Oct 2024 00:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729902824; cv=none; b=VGxR53LDyz//WMyej0e9L8OMSZ+Yf0+HLtSUjFqsx8rdeHe8hE/8BQzrtUrwjwPAMv6qy8FBcpZBOwxANMYXlveS5Ft4px+wmLjAdVk1+YWBH+4N2FLnaXwh2CAv9Nc8OgULHsRPHTOBckhjEZRVUJoXqEAlkB/zbJav1Db0e04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729902824; c=relaxed/simple;
	bh=xA3cc1k9dNaf/KNRdH4+0cl4OTGf6oAOyVWudiB4Cck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIQwsfmZ9b2SHqGeKdwjmJfDipVWwNqXU440+T1aKEIzlwwwJ6grMPvQfZPHC22aapuWsO97e0N84gYKBF/MTd6j2w0Oz6REjqINKpGwW/c7PU/a+URrfLaiNSgJKcVoU5B993mVM1DWxbD/F5IJwaGKNWmgGvjeNVNRBzFN/rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hKKw+N15; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729902822; x=1761438822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xA3cc1k9dNaf/KNRdH4+0cl4OTGf6oAOyVWudiB4Cck=;
  b=hKKw+N15q3GOMsxABfqJHH8C2zGHXtXLJc7Lo+jr7EOEdmkq4JaeITz6
   Yq5QiPvFs1cOtWNdAkYXjFkMkMLtAngGonwHB7L+h7A8wbhUPAnYXYF6d
   KBBZvYuEAsUhETS/PssAN5ThCkwEFGJQt6DwohEIOJiXbU+Osp4E5sNG7
   snYWJxpgcVIGSwiORk/+Vq2uJINfrTAL85jwMwfgvXxptHBgtJca1bZY/
   t1WezJqgffKDiY847kgZ7W1gqLyF9md1vksV3ja/GCSkms7hrFlyCFHKB
   8mOpugh0HrDjhRxVdw48pKGj5C1+XuWse+i6oiz9C99weXy5+UPkoeMkM
   w==;
X-CSE-ConnectionGUID: GZwxYphdRZuHuv9CEQJ05Q==
X-CSE-MsgGUID: NcqdxSKzSyaRLzLFUJLNbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29037948"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="29037948"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 17:33:41 -0700
X-CSE-ConnectionGUID: W+ReqEyHR1yHcLHii44B4g==
X-CSE-MsgGUID: beMkMjE/SwyQ0xSPJM58Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="111881647"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 25 Oct 2024 17:33:39 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4UkK-000Z5i-37;
	Sat, 26 Oct 2024 00:33:36 +0000
Date: Sat, 26 Oct 2024 08:32:49 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, x86@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add bpf_get_hw_counter kfunc
Message-ID: <202410260829.tdMd3ywG-lkp@intel.com>
References: <20241024205113.762622-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024205113.762622-1-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/selftests-bpf-add-selftest-to-check-rdtsc-jit/20241025-045340
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241024205113.762622-1-vadfed%40meta.com
patch subject: [PATCH bpf-next v2 1/2] bpf: add bpf_get_hw_counter kfunc
config: m68k-sun3_defconfig (https://download.01.org/0day-ci/archive/20241026/202410260829.tdMd3ywG-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241026/202410260829.tdMd3ywG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410260829.tdMd3ywG-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/vdso/datapage.h:17,
                    from kernel/bpf/helpers.c:26:
>> include/vdso/processor.h:10:10: fatal error: asm/vdso/processor.h: No such file or directory
      10 | #include <asm/vdso/processor.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +10 include/vdso/processor.h

d8bb6993d871f5 Vincenzo Frascino 2020-03-20   9  
d8bb6993d871f5 Vincenzo Frascino 2020-03-20 @10  #include <asm/vdso/processor.h>
d8bb6993d871f5 Vincenzo Frascino 2020-03-20  11  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

