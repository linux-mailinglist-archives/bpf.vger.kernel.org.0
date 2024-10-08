Return-Path: <bpf+bounces-41188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCC5993EC0
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 08:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2941F2258C
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 06:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAEB18C93F;
	Tue,  8 Oct 2024 06:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oxa6nOQ8"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D3517C7C6;
	Tue,  8 Oct 2024 06:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368383; cv=none; b=jrxkBQQ0PfwRxjXDV1H2Rb7M1f7QClDBObgStXOyXstOvxTrJy2p7AOIWqQJolYK6+s/ck8g0mpamVRQ7gB/3GAfx97vnQk2Gm2DnN9BmCWay3j3tu7criaFph1U8Ha2mUmfH3evmha9XqjopYVPUVNuccCFiZmO0/kJx7r3I08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368383; c=relaxed/simple;
	bh=9/cAtOyeoqfcoMdj6oFodLlnbOe7lWY5jYZsIuvI8jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMFOmQOMoT/ew6g7KDp5oAjtdYf7sXIBhSl4YvM7qEQtR2fb3PDtoxLtCwOTUBi/ahyL2XtLBcL/JGQLdRPcD8sTYQLG/MSs5osnLbO5T4CRxFnj+5lH9dt9Ib1OzPdbjSBWl7z222Lkyl+AjMSs1JU0XyzIYTigSGUy0usA7CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oxa6nOQ8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728368382; x=1759904382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9/cAtOyeoqfcoMdj6oFodLlnbOe7lWY5jYZsIuvI8jo=;
  b=Oxa6nOQ839xazrwRShekYgUE6sce3hKXAHXQwi2PCAhrat3Ae2iQyXBz
   uUuGTA/PDCH3cjWCjxDUGDSygYFLfnY0O1dSVkNmxnHZ2pp79nRyKJOmB
   9MhYksNTygIru9Bladg+I4CtuUDaP4QPX1xANVBzrRZQ0HZw0ctE9mLRC
   eklRKcJl5kbWOJgy9ApLjeR3gx7tIe9Oo2N3Zusam5ruZ2xoh8HHNaDUj
   ClY0Ww2DkgIceTLNSERtOgh57MEPrZOOH9RlR404MjHfiGfV5yfj0i+Jy
   7EupXr+DnJb7BujYxP5vJpTUGLqek6HiGPxXdJ5xuD1IF6XKYtHxFmw50
   g==;
X-CSE-ConnectionGUID: 4B4KRJTPR6K5Shpu19alXA==
X-CSE-MsgGUID: YJPJ24/FTW2OGZwd4+Rr7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="31238492"
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="31238492"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 23:19:42 -0700
X-CSE-ConnectionGUID: pZn01ajnRgieV7brOfNpiA==
X-CSE-MsgGUID: fzv5U/I4QwiPuAvz4ZSf/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="75400397"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 07 Oct 2024 23:19:38 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sy3ZI-0005yu-0x;
	Tue, 08 Oct 2024 06:19:36 +0000
Date: Tue, 8 Oct 2024 14:18:38 +0800
From: kernel test robot <lkp@intel.com>
To: Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, puranjay12@gmail.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH bpf-next v3 1/2] bpf: implement bpf_send_signal_task()
 kfunc
Message-ID: <202410081401.fYRMhL8t-lkp@intel.com>
References: <20241007103426.128923-2-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007103426.128923-2-puranjay@kernel.org>

Hi Puranjay,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Puranjay-Mohan/bpf-implement-bpf_send_signal_task-kfunc/20241007-183648
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241007103426.128923-2-puranjay%40kernel.org
patch subject: [PATCH bpf-next v3 1/2] bpf: implement bpf_send_signal_task() kfunc
config: x86_64-randconfig-121-20241008 (https://download.01.org/0day-ci/archive/20241008/202410081401.fYRMhL8t-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241008/202410081401.fYRMhL8t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410081401.fYRMhL8t-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/trace/bpf_trace.c:839:41: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *[addressable] [assigned] [usertype] sival_ptr @@     got void * @@
   kernel/trace/bpf_trace.c:839:41: sparse:     expected void [noderef] __user *[addressable] [assigned] [usertype] sival_ptr
   kernel/trace/bpf_trace.c:839:41: sparse:     got void *
   kernel/trace/bpf_trace.c: note: in included file (through include/linux/smp.h, include/linux/lockdep.h, include/linux/spinlock.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   kernel/trace/bpf_trace.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   include/linux/rcupdate.h:880:25: sparse: sparse: context imbalance in 'uprobe_prog_run' - unexpected unlock

vim +839 kernel/trace/bpf_trace.c

   822	
   823	static int bpf_send_signal_common(u32 sig, enum pid_type type, struct task_struct *tsk, u64 value)
   824	{
   825		struct send_signal_irq_work *work = NULL;
   826		kernel_siginfo_t info;
   827		bool has_siginfo = false;
   828	
   829		if (!tsk) {
   830			tsk = current;
   831		} else {
   832			has_siginfo = true;
   833			clear_siginfo(&info);
   834			info.si_signo = sig;
   835			info.si_errno = 0;
   836			info.si_code = SI_KERNEL;
   837			info.si_pid = 0;
   838			info.si_uid = 0;
 > 839			info.si_value.sival_ptr = (void *)value;
   840		}
   841	
   842		/* Similar to bpf_probe_write_user, task needs to be
   843		 * in a sound condition and kernel memory access be
   844		 * permitted in order to send signal to the current
   845		 * task.
   846		 */
   847		if (unlikely(tsk->flags & (PF_KTHREAD | PF_EXITING)))
   848			return -EPERM;
   849		if (unlikely(!nmi_uaccess_okay()))
   850			return -EPERM;
   851		/* Task should not be pid=1 to avoid kernel panic. */
   852		if (unlikely(is_global_init(tsk)))
   853			return -EPERM;
   854	
   855		if (irqs_disabled()) {
   856			/* Do an early check on signal validity. Otherwise,
   857			 * the error is lost in deferred irq_work.
   858			 */
   859			if (unlikely(!valid_signal(sig)))
   860				return -EINVAL;
   861	
   862			work = this_cpu_ptr(&send_signal_work);
   863			if (irq_work_is_busy(&work->irq_work))
   864				return -EBUSY;
   865	
   866			/* Add the current task, which is the target of sending signal,
   867			 * to the irq_work. The current task may change when queued
   868			 * irq works get executed.
   869			 */
   870			work->task = get_task_struct(tsk);
   871			work->has_siginfo = has_siginfo;
   872			work->info = info;
   873			work->sig = sig;
   874			work->type = type;
   875			irq_work_queue(&work->irq_work);
   876			return 0;
   877		}
   878	
   879		if (has_siginfo)
   880			return group_send_sig_info(sig, &info, tsk, type);
   881	
   882		return group_send_sig_info(sig, SEND_SIG_PRIV, tsk, type);
   883	}
   884	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

