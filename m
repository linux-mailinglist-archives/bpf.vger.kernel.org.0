Return-Path: <bpf+bounces-37242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E33952863
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 05:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74E1284CFA
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 03:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D434C38DE1;
	Thu, 15 Aug 2024 03:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f5VYfPxf"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6B828E0F
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 03:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723693679; cv=none; b=Edb8SQnJruDhmrSwXF+/i1hndeRESE8IFSAsVv5+wEB51AEGhzDpq1BupUzCIhtN1dibZ2i2eMgGfHzTuFNok5euLHYEbqlD7RZziwYiyKQTMJSoP2yy5c7+9il0Epcf3RcTHjVc/pyeP+f7nrqtgeDiRM6aBKQ2IVDeWFe6ltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723693679; c=relaxed/simple;
	bh=Qnwj3BM3znaT0XQhcd4BTVo1LcYK+Q2UP+biZQIh41A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ic8aac+vsnnhhJuRfsfsuH79e+31z5FyY8UwVhvIxVMZujyVMis90uyLauGHbl/wVMk5LNtS1ByK7y1TKbiSexxX8ShvMDRpXS0l2vQF5/eXoYHVhlvNjQbptJkp10wOPSP8qvUwlRE+nKbSTQs9qApokpeoDqhtjwBYUAx9pjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f5VYfPxf; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723693677; x=1755229677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qnwj3BM3znaT0XQhcd4BTVo1LcYK+Q2UP+biZQIh41A=;
  b=f5VYfPxfepgHkXdn/8iHWplKm/yQwwI9cZBC5jOsY4C+JnTTPkmjW3Oh
   QtxihrQVPG5EuXzrIKbZceT1MlF6//DqRo5LOT0ZWCGz0VwUFK0+2+utf
   1HOb6f2tW2k3DaSS4Sc1UTleQp4fCD2I7FQgmgnVo8Rf6GKcPsySNj169
   FtDYUCZLSp8qxxu8UhSvkskhbAnL371X/iA7lFmCoq81gwLm4C7KGHfI+
   vO+EawQK2oi3sx84PX4clzrqWFGKAs+lTsEyKR+EtQSS3066sBnKWJm3D
   N3x2Tb7bOTbfSGLxE+O3Hvi5hc/gfRHlVAH+eInlIy7Tbb3xYg/mvy2kr
   Q==;
X-CSE-ConnectionGUID: 4+N9ekB1RsmmezxBFJEhwg==
X-CSE-MsgGUID: JdTGszLZRy2ifi3FhRXBtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="33331253"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="33331253"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 20:47:56 -0700
X-CSE-ConnectionGUID: Y6c3+1W2QHOBYFsPWjb0iQ==
X-CSE-MsgGUID: /TP5HWLgRmeDWu2ufgW/tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="59389059"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 14 Aug 2024 20:47:54 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seRSp-00039i-2C;
	Thu, 15 Aug 2024 03:47:51 +0000
Date: Thu, 15 Aug 2024 11:47:48 +0800
From: kernel test robot <lkp@intel.com>
To: Jordan Rome <linux@jordanrome.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>, sinquersw@gmail.com
Subject: Re: [bpf-next v4 1/2] bpf: Add bpf_copy_from_user_str kfunc
Message-ID: <202408151130.79yPpdxy-lkp@intel.com>
References: <20240814004531.352157-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814004531.352157-1-linux@jordanrome.com>

Hi Jordan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Jordan-Rome/bpf-Add-tests-for-bpf_copy_from_user_str-kfunc/20240814-232043
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240814004531.352157-1-linux%40jordanrome.com
patch subject: [bpf-next v4 1/2] bpf: Add bpf_copy_from_user_str kfunc
config: i386-buildonly-randconfig-002-20240815 (https://download.01.org/0day-ci/archive/20240815/202408151130.79yPpdxy-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240815/202408151130.79yPpdxy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408151130.79yPpdxy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/helpers.c:2975:4: warning: add explicit braces to avoid dangling else [-Wdangling-else]
    2975 |                         else
         |                         ^
   1 warning generated.


vim +2975 kernel/bpf/helpers.c

  2941	
  2942	/**
  2943	 * bpf_copy_from_user_str() - Copy a string from an unsafe user address
  2944	 * @dst:             Destination address, in kernel space.  This buffer must be at
  2945	 *                   least @dst__szk bytes long.
  2946	 * @dst__szk:        Maximum number of bytes to copy, including the trailing NUL.
  2947	 * @unsafe_ptr__ign: Source address, in user space.
  2948	 * @flags:           The only supported flag is BPF_ZERO_BUFFER
  2949	 *
  2950	 * Copies a NUL-terminated string from userspace to BPF space. If user string is
  2951	 * too long this will still ensure zero termination in the dst buffer unless
  2952	 * buffer size is 0.
  2953	 *
  2954	 * If BPF_ZERO_BUFFER flag is set, memset the tail of @dst to 0 on success.
  2955	 */
  2956	__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk, const void __user *unsafe_ptr__ign, u64 flags)
  2957	{
  2958		int ret;
  2959		int count;
  2960	
  2961		if (unlikely(!dst__szk))
  2962			return 0;
  2963	
  2964		count = dst__szk - 1;
  2965		if (unlikely(!count)) {
  2966			((char *)dst)[0] = '\0';
  2967			return 1;
  2968		}
  2969	
  2970		ret = strncpy_from_user(dst, unsafe_ptr__ign, count);
  2971		if (ret >= 0) {
  2972			if (ret <= count)
  2973				if (flags & BPF_ZERO_BUFFER)
  2974					memset((char *)dst + ret, 0, dst__szk - ret);
> 2975				else
  2976					((char *)dst)[ret] = '\0';
  2977			ret++;
  2978		}
  2979	
  2980		return ret;
  2981	}
  2982	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

