Return-Path: <bpf+bounces-72212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8914C0A2A9
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 05:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAC43B2CAF
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 04:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D22258ECE;
	Sun, 26 Oct 2025 04:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VVYanjcz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C56C15D5B6;
	Sun, 26 Oct 2025 04:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761453887; cv=none; b=rLTPv9GGROYHc5LZxT2SkhL6lBLKP4KtmC8Vff7rUh9HGpWxtaq1JELy38BLoA5tN0Al3oRYoZxioZ7bQGuO7zaD023QXHF0Tu118E+ZkzD4ng3sULwuc9QVDsqSG9vxj7jeeGizmqMDuApWuzRayTvfz2kH2x0P9NwYFjiWf0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761453887; c=relaxed/simple;
	bh=K14gYDkP3HowqXFY8VVUwqVY0rTYiAZ+Es9ijFsW2qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7N25Bm5K2veHE2KmN0E8dd7DCs/DerlaTYftH/MQNJ9lA6DBk1nkeUS4KZxdx/TdfC8A5OtLSYWu/CAChGCgpkqcvu2lAJPsIDiujbNB+hu9Pw04t+o3v9PZOyGxOY20zj7kqIKnPGbsrZsmR+cPzFjU1kJjlwC1OCDhvVjOQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VVYanjcz; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761453886; x=1792989886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K14gYDkP3HowqXFY8VVUwqVY0rTYiAZ+Es9ijFsW2qM=;
  b=VVYanjczsmofELOm51Xx2FuOJfkyzYK0vXuKu1Zd6UE17l0KZ4am3xJ3
   ZpEV2icGKaqAOLDIxIlRU1M5RBLiIrnc7SljvQBWsM2xTBF3Wi7ExaG7z
   dmefk/K92/nlX0UXu3Pv7twcmvFFbreATrt/DZylPNCaKALYZs/K09YmH
   lrFUjpS7SuvoHzaJLnAi8YwKSbBFQXaQPSfKNr6lcNCT1OXKpKIB+WIj4
   hJiyr6hLhTdIMqy9xHRuCyv+ZPFhsmy6NizfQDjhyHDELpJWzqNTMkTCQ
   FpkOD7rr1JiQUEniYVUvIm4XNlShJBx3bGRWFwaVPnfb6W4w3jXhrYa4R
   g==;
X-CSE-ConnectionGUID: lBgUDEM+SpiPg3fjUR9F1Q==
X-CSE-MsgGUID: zLq7Zgj+T5u6aB8da7WASw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66187894"
X-IronPort-AV: E=Sophos;i="6.19,256,1754982000"; 
   d="scan'208";a="66187894"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2025 21:44:45 -0700
X-CSE-ConnectionGUID: GDS0Z1SIRHGeje471Z1IRg==
X-CSE-MsgGUID: 7YbqpuzNS4OE3DxxayX9BQ==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 25 Oct 2025 21:44:41 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCscK-000Fsn-1I;
	Sun, 26 Oct 2025 04:44:34 +0000
Date: Sun, 26 Oct 2025 12:42:28 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
	jolsa@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
	leon.hwang@linux.dev, jiang.biao@linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 2/7] bpf: add two kfunc for TRACE_SESSION
Message-ID: <202510261253.qRd57kJv-lkp@intel.com>
References: <20251026030143.23807-3-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026030143.23807-3-dongml2@chinatelecom.cn>

Hi Menglong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/bpf-add-tracing-session-support/20251026-110720
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251026030143.23807-3-dongml2%40chinatelecom.cn
patch subject: [PATCH bpf-next v3 2/7] bpf: add two kfunc for TRACE_SESSION
config: i386-buildonly-randconfig-003-20251026 (https://download.01.org/0day-ci/archive/20251026/202510261253.qRd57kJv-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251026/202510261253.qRd57kJv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510261253.qRd57kJv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/bpf_trace.c: In function '____bpf_trace_printk':
   kernel/trace/bpf_trace.c:377:9: warning: function '____bpf_trace_printk' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     377 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
         |         ^~~
   kernel/trace/bpf_trace.c: In function '____bpf_trace_vprintk':
   kernel/trace/bpf_trace.c:433:9: warning: function '____bpf_trace_vprintk' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     433 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
         |         ^~~
   kernel/trace/bpf_trace.c: In function '____bpf_seq_printf':
   kernel/trace/bpf_trace.c:475:9: warning: function '____bpf_seq_printf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     475 |         seq_bprintf(m, fmt, data.bin_args);
         |         ^~~~~~~~~~~
   kernel/trace/bpf_trace.c: In function 'bpf_fsession_cookie':
>> kernel/trace/bpf_trace.c:3379:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    3379 |         return (u64 *)((u64 *)ctx)[nr_args + 2];
         |                ^

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for I2C_K1
   Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && (ARCH_SPACEMIT || COMPILE_TEST [=y]) && OF [=n]
   Selected by [y]:
   - MFD_SPACEMIT_P1 [=y] && HAS_IOMEM [=y] && (ARCH_SPACEMIT || COMPILE_TEST [=y]) && I2C [=y]


vim +3379 kernel/trace/bpf_trace.c

  3372	
  3373	__bpf_kfunc u64 *bpf_fsession_cookie(void *ctx)
  3374	{
  3375		/* This helper call is inlined by verifier. */
  3376		u64 nr_args = ((u64 *)ctx)[-1];
  3377	
  3378		/* ctx[nr_args + 2] is the session cookie address */
> 3379		return (u64 *)((u64 *)ctx)[nr_args + 2];
  3380	}
  3381	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

