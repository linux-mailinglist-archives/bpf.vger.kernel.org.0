Return-Path: <bpf+bounces-69348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5069B94DC6
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 09:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A58B480909
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 07:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1F2318141;
	Tue, 23 Sep 2025 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3HIODO9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7613164D8;
	Tue, 23 Sep 2025 07:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613936; cv=none; b=AWK+SkW9pSyz1rJEzo97qm738hz2eko6wTa85nen38xUWIClzDQbeOrU2ntebJp8UtEsALeuXgJH1SH3x5iy7DOVLqNU02Y05zdcL/TcrJf/U7p4bRoxi73k8/9yOb00pDZHeZTs9a6PO+N9xq+2R4K/Yvy8CbMjwLFHYsKNi8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613936; c=relaxed/simple;
	bh=licSeWjFUdzBHCsxcp537nwdX+A34/7NtoD2kX8d7ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1DfrvX1HPE9gTfUaAMsGGc0GFQ/6QDRHh70wWuXX26gm7VB9MwdDZ2nqvo+1yn5oTHD0/4jwLhO2MDe4pVBsfDZvlYmhJ3etMJDbYSbzNktWs0GsmLoKZFTTo6HRtlwtwZ34gFzuAREyQWpv7St00AHixjV6d3oWVRwq4pIbug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3HIODO9; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758613935; x=1790149935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=licSeWjFUdzBHCsxcp537nwdX+A34/7NtoD2kX8d7ys=;
  b=T3HIODO9fdhfJ8xjLAHpIS9zXzcK/I79dlA/guMvsRnhJMdZJf0MChbQ
   hxz23ll3p5HFodAVgpsyEE+w67Zve+yHxPBu4iqXJQZEu3PGDiwak/k8y
   /aQlyUC9uP/VzTTmu84M2z+EKI6USDR8ekLqMZboxjdvPqFkM0BoGHysh
   PHsot8WFfjDbG9/1gIoLayTZyeb8gs//w8pjzlyC+AyC6NroOJWCHdyjM
   6FyFHBt+MfRwz66n1VHTfkZmO4ECbQLtinUqClYpo/COk5LEW0ofh9WTt
   CUCuT07fAMYr2/93g4MJwAnaePWQ5AAyVouJ1vkWumeJE6QjTqCFuMmzP
   Q==;
X-CSE-ConnectionGUID: asVuIpXDSea65eN9R50yIg==
X-CSE-MsgGUID: RXvx1x50QVW2yQAIH4KKLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60942159"
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="60942159"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 00:52:14 -0700
X-CSE-ConnectionGUID: ky0FkstCS4y0RA7/+g+A0Q==
X-CSE-MsgGUID: 7rquwNaGRXC45vaKXV5jgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="176774466"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 23 Sep 2025 00:52:09 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0xok-0002sP-2l;
	Tue, 23 Sep 2025 07:52:06 +0000
Date: Tue, 23 Sep 2025 15:52:05 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, jolsa@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kpsingh@kernel.org,
	mattbobrowski@google.com, song@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, sdf@fomichev.me, haoluo@google.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: remove is_return in struct
 bpf_session_run_ctx
Message-ID: <202509231550.BWhLcP9e-lkp@intel.com>
References: <20250922095705.252519-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922095705.252519-1-dongml2@chinatelecom.cn>

Hi Menglong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/bpf-remove-is_return-in-struct-bpf_session_run_ctx/20250922-175833
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250922095705.252519-1-dongml2%40chinatelecom.cn
patch subject: [PATCH bpf-next] bpf: remove is_return in struct bpf_session_run_ctx
config: i386-randconfig-r113-20250923 (https://download.01.org/0day-ci/archive/20250923/202509231550.BWhLcP9e-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250923/202509231550.BWhLcP9e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509231550.BWhLcP9e-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/trace/bpf_trace.c:833:41: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *[addressable] [assigned] [usertype] sival_ptr @@     got void * @@
   kernel/trace/bpf_trace.c:833:41: sparse:     expected void [noderef] __user *[addressable] [assigned] [usertype] sival_ptr
   kernel/trace/bpf_trace.c:833:41: sparse:     got void *
>> kernel/trace/bpf_trace.c:3059:62: sparse: sparse: dubious: x | !y
   kernel/trace/bpf_trace.c:3512:52: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/bpf_trace.c:3526:56: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/bpf_trace.c:3540:52: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/bpf_trace.c:3547:56: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/bpf_trace.c:3555:52: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/bpf_trace.c:3563:56: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/bpf_trace.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   include/linux/rcupdate.h:869:9: sparse: sparse: context imbalance in 'uprobe_prog_run' - unexpected unlock

vim +3059 kernel/trace/bpf_trace.c

  3050	
  3051	static int uprobe_prog_run(struct bpf_uprobe *uprobe,
  3052				   unsigned long entry_ip,
  3053				   struct pt_regs *regs,
  3054				   bool is_return, void *data)
  3055	{
  3056		struct bpf_uprobe_multi_link *link = uprobe->link;
  3057		struct bpf_uprobe_multi_run_ctx run_ctx = {
  3058			.session_ctx = {
> 3059				.data = (void *)((unsigned long)data | !!is_return),
  3060			},
  3061			.entry_ip = entry_ip,
  3062			.uprobe = uprobe,
  3063		};
  3064		struct bpf_prog *prog = link->link.prog;
  3065		bool sleepable = prog->sleepable;
  3066		struct bpf_run_ctx *old_run_ctx;
  3067		int err;
  3068	
  3069		if (link->task && !same_thread_group(current, link->task))
  3070			return 0;
  3071	
  3072		if (sleepable)
  3073			rcu_read_lock_trace();
  3074		else
  3075			rcu_read_lock();
  3076	
  3077		migrate_disable();
  3078	
  3079		old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
  3080		err = bpf_prog_run(link->link.prog, regs);
  3081		bpf_reset_run_ctx(old_run_ctx);
  3082	
  3083		migrate_enable();
  3084	
  3085		if (sleepable)
  3086			rcu_read_unlock_trace();
  3087		else
  3088			rcu_read_unlock();
  3089		return err;
  3090	}
  3091	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

