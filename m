Return-Path: <bpf+bounces-40330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A06986B66
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 05:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F242A1F222B6
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 03:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16962172BCC;
	Thu, 26 Sep 2024 03:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d9TOdf48"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE221D5ADF;
	Thu, 26 Sep 2024 03:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727321695; cv=none; b=cMWoAImFpKXUmmBLp2q4yJmLGp7dmlpUdaIq7r0NPnfh9uYhXdPeCrjl97DuF+L09zhO3Os4UQn4/L/rK2j7CFlSUZVM6c2yiVsC1ThdN4HYx975B33o9oyaypu/O044ViVqx+mzpqcCWbLGf1NLGxPKvrLWqCxevToXGndDIBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727321695; c=relaxed/simple;
	bh=/At0ZfQKDRKqgXRUC/2vl4ZDoABUmTw1R9MYz/wjx+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQX4DsKRzBrRHGb9XRtCdFm5VVtboN2fyMfJzCy38ThzvJTJ+feay60iss69V7WtwGjHjMZdYjNgJhL2zwL2XJNBD2L9giGzQMnT1DeWRQpNavreyAZkkHRy4PhJRZG49Xrna2W52Me66V1lvDAcbeBuEcWbBRTLoVC2rRtjEPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d9TOdf48; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727321694; x=1758857694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/At0ZfQKDRKqgXRUC/2vl4ZDoABUmTw1R9MYz/wjx+o=;
  b=d9TOdf48uLPTm1rsMciPPTm4q9ftkflen3WdYqAEwZYr6JU8f2An0/dt
   vMdAD6HaoeSn+FDvnza2l6LPMmPlv2Dhe2qUE2r+gLeTFNSR6bz1lOO35
   FAeSERrrLc6t7K7Q7EbtLtHDUEDoptktQwMWgsDSdxh3+aY3r4sEgdUDl
   GRSccWaCoXr0eqoQ6yzWzE0wRJnisP2ywsB1d4KPfh+O+qvPFxBeYJkW9
   oLXPEoDKAc6VIs0viVZC0uu4hpoQLOVvkUvCjZxyfs/mTxp9dc6ksIlhA
   RdoU6tcl3y1vn4qEaXap6YaiBPMELpJhZI8n7d0b+oDJYC1JdD9RqIXqX
   w==;
X-CSE-ConnectionGUID: hu5gJIagS8qAEHeF4rTUgw==
X-CSE-MsgGUID: r0+/JxJZQ1+Ln0/NCQdXvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="37543177"
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="37543177"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 20:34:53 -0700
X-CSE-ConnectionGUID: wfbmaoPlRAyGIvvLNywPQw==
X-CSE-MsgGUID: ncJ91KxCR6G2NdMIJoaDeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="102818880"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 25 Sep 2024 20:34:49 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stfHC-000KB5-39;
	Thu, 26 Sep 2024 03:34:46 +0000
Date: Thu, 26 Sep 2024 11:34:19 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Yan <eric.yan@oppo.com>, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev,
	song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, eric.yan@oppo.com
Subject: Re: [PATCH] Add BPF Kernel Function bpf_ptrace_vprintk
Message-ID: <202409261116.risxWG3M-lkp@intel.com>
References: <20240925100254.436-1-eric.yan@oppo.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925100254.436-1-eric.yan@oppo.com>

Hi Eric,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]
[also build test WARNING on bpf/master linus/master next-20240925]
[cannot apply to v6.11]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Yan/Add-BPF-Kernel-Function-bpf_ptrace_vprintk/20240925-180530
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240925100254.436-1-eric.yan%40oppo.com
patch subject: [PATCH] Add BPF Kernel Function bpf_ptrace_vprintk
config: x86_64-buildonly-randconfig-003-20240926 (https://download.01.org/0day-ci/archive/20240926/202409261116.risxWG3M-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240926/202409261116.risxWG3M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409261116.risxWG3M-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/helpers.c:2530: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * same as bpf_trace_vprintk, except for a trace_marker format requirement


vim +2530 kernel/bpf/helpers.c

  2528	
  2529	/**
> 2530	 * same as bpf_trace_vprintk, except for a trace_marker format requirement
  2531	 */
  2532	__bpf_kfunc int bpf_ptrace_vprintk(char *fmt, u32 fmt_size, const void *args, u32 args__sz)
  2533	{
  2534		struct bpf_bprintf_data data = {
  2535			.get_bin_args	= true,
  2536			.get_buf	= true,
  2537		};
  2538		int ret, num_args;
  2539	
  2540		if (args__sz & 7 || args__sz > MAX_BPRINTF_VARARGS * 8 || (args__sz && !args))
  2541			return -EINVAL;
  2542		num_args = args__sz / 8;
  2543	
  2544		ret = bpf_bprintf_prepare(fmt, fmt_size, args, num_args, &data);
  2545		if (ret < 0)
  2546			return ret;
  2547	
  2548		ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
  2549	
  2550		tracing_mark_write(data.buf);
  2551	
  2552		bpf_bprintf_cleanup(&data);
  2553	
  2554		return ret;
  2555	}
  2556	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

