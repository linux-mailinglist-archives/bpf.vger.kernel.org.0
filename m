Return-Path: <bpf+bounces-52831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B155A48D81
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 01:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6079716DD6E
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 00:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF5C849C;
	Fri, 28 Feb 2025 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1aXp4Su"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FBC211C;
	Fri, 28 Feb 2025 00:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740703446; cv=none; b=r4ceSurpjahqJBaHirVwzKG1V3jHu0g5XK+2sZUxUekKLA2JvonB1KJ+5Yw3V4HArwdP6+ju8GHM2nFlYMhRGSn6PAUPE+mkEnVtWvVDUfGz2tVb+pjISlIZU6fe0CFdOvnBPZKdnhw/XNzOaKIb3apInQFVVNxzSKAaT8C0dOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740703446; c=relaxed/simple;
	bh=eLeJvveqOt8R8zNm/BD89sPpR/xN6v9RWVXKbMNVdSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keopDDFIMxI/0coiB1LxP4d17nUfc3uu23rdCCQUQRj5/y/ujOgD8lf6OIQSrscCZAIOni1T05HRVexK0lteNwNTGdy741hcEVgdPeozR2iPo6hk82y7A+lRAA1isBxKsjAkwCVSEMu40nmRIrh21IOeaqe16EtB8v2pfzLFfCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1aXp4Su; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740703445; x=1772239445;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eLeJvveqOt8R8zNm/BD89sPpR/xN6v9RWVXKbMNVdSw=;
  b=Q1aXp4SuVPVe+2lljuaQMTlRP5jBe67Qj9Q2ASbTlUR2xkW7nLpuVDCE
   FGyEw20bS95LRtJYFa6sozVPNFE9ZxcuPuZg5QDTJbRgDDVHSTtqJ2A25
   B95HCQioBlADJH1IAlB3F9EnUYAX91SIomdHGvDjkoCuAfjSvQpbx24i0
   GZh/3iM7SWE/xvDgfJBOYIHRq9gtBldNV36fxGC4bwtx6neqWd6If2OxS
   oFrOZl/jsYzrnDevo9ydlz2M/PxKSsvW4oq9nTnTMtDi8SW6ymTDQotGL
   50jvt51t4zmdxsdD9g6RlGysAEC0kbBdH8JgGEFgvGuGYyGTR1sRKVGPy
   Q==;
X-CSE-ConnectionGUID: VmBGSBWsQra8S3aRo5OvbA==
X-CSE-MsgGUID: zElCPIsDROmKpmX9mD99kA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45402598"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="45402598"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 16:43:52 -0800
X-CSE-ConnectionGUID: byxxMEs1TTiX2LpHkc1grg==
X-CSE-MsgGUID: jshEyU3CSAGftBCl95s7dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="122313669"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 27 Feb 2025 16:43:45 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnoTe-000EFG-2u;
	Fri, 28 Feb 2025 00:43:42 +0000
Date: Fri, 28 Feb 2025 08:43:12 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, rostedt@goodmis.org,
	mark.rutland@arm.com, alexei.starovoitov@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, catalin.marinas@arm.com, will@kernel.org,
	mhiramat@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, mathieu.desnoyers@efficios.com, nathan@kernel.org,
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
	dongml2@chinatelecom.cn, akpm@linux-foundation.org, rppt@kernel.org,
	graf@amazon.com, dan.j.williams@intel.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v2] add function metadata support
Message-ID: <202502280842.nI3PwNwz-lkp@intel.com>
References: <20250226121537.752241-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226121537.752241-1-dongml2@chinatelecom.cn>

Hi Menglong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/add-function-metadata-support/20250226-202312
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250226121537.752241-1-dongml2%40chinatelecom.cn
patch subject: [PATCH bpf-next v2] add function metadata support
config: i386-buildonly-randconfig-002-20250227 (https://download.01.org/0day-ci/archive/20250228/202502280842.nI3PwNwz-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250228/202502280842.nI3PwNwz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502280842.nI3PwNwz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/kfunc_md.c: In function 'kfunc_md_get_next':
>> kernel/trace/kfunc_md.c:98:20: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      98 |         free_pages((u64)mds, order);
         |                    ^

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for CALL_PADDING
   Depends on [n]: CC_HAS_ENTRY_PADDING [=y] && OBJTOOL [=n]
   Selected by [y]:
   - FUNCTION_METADATA [=y]


vim +98 kernel/trace/kfunc_md.c

    47	
    48	/* Get next usable function metadata. On success, return the usable
    49	 * kfunc_md and store the index of it to *index. If no usable kfunc_md is
    50	 * found in kfunc_mds, a larger array will be allocated.
    51	 */
    52	static struct kfunc_md *kfunc_md_get_next(u32 *index)
    53	{
    54		struct kfunc_md *new_mds, *mds;
    55		u32 i, order;
    56	
    57		mds = rcu_dereference(kfunc_mds);
    58		if (mds == NULL) {
    59			order = kfunc_md_page_order();
    60			new_mds = (void *)__get_free_pages(GFP_KERNEL, order);
    61			if (!new_mds)
    62				return NULL;
    63			kfunc_md_init(new_mds, 0, kfunc_md_count);
    64			/* The first time to initialize kfunc_mds, so it is not
    65			 * used anywhere yet, and we can update it directly.
    66			 */
    67			rcu_assign_pointer(kfunc_mds, new_mds);
    68			mds = new_mds;
    69		}
    70	
    71		if (likely(kfunc_md_used < kfunc_md_count)) {
    72			/* maybe we can manage the used function metadata entry
    73			 * with a bit map ?
    74			 */
    75			for (i = 0; i < kfunc_md_count; i++) {
    76				if (!mds[i].users) {
    77					kfunc_md_used++;
    78					*index = i;
    79					mds[i].users++;
    80					return mds + i;
    81				}
    82			}
    83		}
    84	
    85		order = kfunc_md_page_order();
    86		/* no available function metadata, so allocate a bigger function
    87		 * metadata array.
    88		 */
    89		new_mds = (void *)__get_free_pages(GFP_KERNEL, order + 1);
    90		if (!new_mds)
    91			return NULL;
    92	
    93		memcpy(new_mds, mds, kfunc_md_count * sizeof(*new_mds));
    94		kfunc_md_init(new_mds, kfunc_md_count, kfunc_md_count * 2);
    95	
    96		rcu_assign_pointer(kfunc_mds, new_mds);
    97		synchronize_rcu();
  > 98		free_pages((u64)mds, order);
    99	
   100		mds = new_mds + kfunc_md_count;
   101		*index = kfunc_md_count;
   102		kfunc_md_count <<= 1;
   103		kfunc_md_used++;
   104		mds->users++;
   105	
   106		return mds;
   107	}
   108	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

