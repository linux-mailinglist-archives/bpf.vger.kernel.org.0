Return-Path: <bpf+bounces-37237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E723E9527CC
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 04:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83312B2114D
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 02:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163A763B9;
	Thu, 15 Aug 2024 02:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mkHiE5H3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234B010F1
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 02:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723687376; cv=none; b=GUSSFCn2c6Lcbo79Edyef54P4xpZAqY0LlkN3vqOqZXFqsbUPMRF3WcsnZ77xa327NBNv1YnBJcb1IM/6/UtYdilKa0wT0iDfmPZOSd7z9jVIPtD9s63PiRyNOKkVVKfuSCFpzIMDL09EXZCvtpWnyX2fGbtsh7f0qV4ScUEFoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723687376; c=relaxed/simple;
	bh=K/bGJmxpTIiuJmmI7TOBjEMsEU9kmHsp+pnWJh3kP9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpmiHQt0yJh21DXsj/GvH4zGu/NobjLUd0cXyKrkKJArLCfQzKq7cnFZkgTjCmvGHRGHbcyTLYzajZIwOMX3SNEzEIldP+4MdVd9aD1f+BK4bjx7azxWQE1XKL6FlNMY+50leGF+npkFVEH9xKdTSFpMswj+tgnpZxPXdOxrgKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mkHiE5H3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723687375; x=1755223375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K/bGJmxpTIiuJmmI7TOBjEMsEU9kmHsp+pnWJh3kP9Y=;
  b=mkHiE5H3rplywOtA+r+DYONzFySQ7XoJjz/x8nFhiMa4MwD/nX2EZoPn
   DEBfto5hK4/W2e2uvqLn44OjeTpc+lDF8OD0Zkng/ybVMGHz26wziaYsZ
   l9T6eKeJfUkuiZCtzzSyj+SCoXkUeMeDc4z5e8sZkD3X5S4tp4R+jycmC
   LQd1k0d+vO0o2X+yR1rx1wMXDK4ln5vuE7m5UkkiP+LuzMH799WzaaVtt
   nUSl0kr6DGP/1Md4gRhAq6lYSuhiMT6ZouDIzPOJ/Y7RQY1qN1PhZMUcg
   oHgYc4pEdsFFDyB0seuEKRC6ohwzRPgA/XP1y9aVBf1Ki3IEKFntr2uZm
   w==;
X-CSE-ConnectionGUID: zkHOwJcrRHW8GIlp2sg5wQ==
X-CSE-MsgGUID: XFPIGPY2SSKmiu+fQ1E/Hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="33347854"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="33347854"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 19:02:52 -0700
X-CSE-ConnectionGUID: tYtrasGiTFK3oZTP9/VDwQ==
X-CSE-MsgGUID: I9VXDLE5SDKcj/iCvwlTeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="59367639"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 14 Aug 2024 19:02:50 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sePp9-00034q-3A;
	Thu, 15 Aug 2024 02:02:47 +0000
Date: Thu, 15 Aug 2024 10:02:33 +0800
From: kernel test robot <lkp@intel.com>
To: Jordan Rome <linux@jordanrome.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>, sinquersw@gmail.com
Subject: Re: [bpf-next v4 1/2] bpf: Add bpf_copy_from_user_str kfunc
Message-ID: <202408150928.HuDSmPPF-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-002-20240815 (https://download.01.org/0day-ci/archive/20240815/202408150928.HuDSmPPF-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240815/202408150928.HuDSmPPF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408150928.HuDSmPPF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/helpers.c: In function 'bpf_copy_from_user_str':
>> kernel/bpf/helpers.c:2972:20: warning: suggest explicit braces to avoid ambiguous 'else' [-Wdangling-else]
    2972 |                 if (ret <= count)
         |                    ^


vim +/else +2972 kernel/bpf/helpers.c

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
> 2972			if (ret <= count)
  2973				if (flags & BPF_ZERO_BUFFER)
  2974					memset((char *)dst + ret, 0, dst__szk - ret);
  2975				else
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

