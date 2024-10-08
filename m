Return-Path: <bpf+bounces-41172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC4C993C64
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 03:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1891C24678
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 01:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051251BF37;
	Tue,  8 Oct 2024 01:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXHudlNa"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C48C139;
	Tue,  8 Oct 2024 01:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728351753; cv=none; b=oENxAB6CEByHL4KtJyI+yWmLKd9ElvvPiJo3+dwV35hiAc78ToRJNZo6LmE2WKXnJa2tTqYTRuJhNdNvAMYca7jXtLZG8zBeBVXH+3giKFM+PE411NZrQU4DAx7zEt/ej07EblB7vN9CpwY+nBWwe6EJxsFYHAIi2+z3JSF314M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728351753; c=relaxed/simple;
	bh=FNFsaXqP0nwWX8RikWnlBRWuPNEkZ7KWAUYK1+lLn0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNr8VhowGYOu7lp9fFpP5IRpoI7QTZB1Lm1+cwZ3danW9vZSSt6e4gs4ZloYj3abl8fBL9l+Ah7CjpqqiHfKhcrRF5ObnfJ0Q3/jlnDNBG6JwmWlnC7CBfv5Ircq0D91OkWnCo9kWaQKqenZhY+EB1UNTDAE3SCh8MKUHixAqpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXHudlNa; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728351752; x=1759887752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FNFsaXqP0nwWX8RikWnlBRWuPNEkZ7KWAUYK1+lLn0E=;
  b=aXHudlNak0iR2Qaoab3EyQovzZ+WnsGwniH0CcTy3MkSpWbg8kNclMZ0
   NuJKwX/Lz4w2k0CaSd7wc0RiwBwxLWNZn1en2S/A86tguSsHRVMPeqvpe
   dNV9Vddtb6PInT3r5azEnZD8MlMGk6ZhSrtwxClQUb3Ha8xi5nyuhy3gd
   9YlgWIC/PGPyGCpF8yEaOMWlhyJPjRU4G+uLGePx9XV0laYRb+8Ovrj+y
   qc76luM7auRA0eP0LVy1Jb7v1a7tahFFQkBLOsEAH279degdOiwdXf7Jl
   vxzFIwslw6peLbj1ti3ThvVaVt6X5bLflSRKZ2pRqObpzKz6vFydSugI8
   w==;
X-CSE-ConnectionGUID: GEzXAwzSQJW7kQhil56Bnw==
X-CSE-MsgGUID: /9hMkFhtS/abB+UHBnvKSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="45047019"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="45047019"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 18:42:30 -0700
X-CSE-ConnectionGUID: Ngz0fYPJSFaCipsQk5m18A==
X-CSE-MsgGUID: zdOZU/66QZOblCEadUcPrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="80278421"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 07 Oct 2024 18:42:27 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxzF2-0005ky-32;
	Tue, 08 Oct 2024 01:42:24 +0000
Date: Tue, 8 Oct 2024 09:41:36 +0800
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
Message-ID: <202410080907.DFxFxfor-lkp@intel.com>
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
config: i386-randconfig-141-20241008 (https://download.01.org/0day-ci/archive/20241008/202410080907.DFxFxfor-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241008/202410080907.DFxFxfor-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410080907.DFxFxfor-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/bpf_trace.c: In function 'bpf_send_signal_common':
>> kernel/trace/bpf_trace.c:839:43: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     839 |                 info.si_value.sival_ptr = (void *)value;
         |                                           ^


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

