Return-Path: <bpf+bounces-74855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B957BC67515
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 06:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D7CF4E96DD
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 05:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC5B2C21DF;
	Tue, 18 Nov 2025 05:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QR8MtWW/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FC31B4257;
	Tue, 18 Nov 2025 05:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763442649; cv=none; b=kmoA3Kjb/1ION1zfOq1bf8J713TdDpExDNYVQ0dXmSWPchDLXNqkDDJVnJ3CBHeXSR/nNyGu2KCNOkRG/3jIV2NMZHeQkwC+GFocqot/NUSCxD4lC/ZEHxrNwARL0RxmxmDTeqaAh4g0ZCD3Dj9H0LNAl+v8OBRLNQNBpKSDHW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763442649; c=relaxed/simple;
	bh=nysuNHsnjzYweFkpkBcFz9Cfx4ziANgAATwL2AHh0qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKjPUCmulASbkubAAoU9KR1CaKhF4hFwmpsXqqkZYUNH/O8CuLXtdKgX3kTBQhEJeSFZJhXUSB5N4grepLk8gvNuNPR8dmYA27eieBmokr0TphnlZzHGWDtt4jos2SzBWWemK0eZToLn4q+ken25GmIHuKS/Nn3wtdLOUU7GnlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QR8MtWW/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763442647; x=1794978647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nysuNHsnjzYweFkpkBcFz9Cfx4ziANgAATwL2AHh0qg=;
  b=QR8MtWW/WsSQPRmMMqfKEsqzXKIh3r55ETVmktI2hwic+htcGqjtMysw
   JtIHS751p0uXaXElJt6g2JUHSb9peT3R/DwXc8RSsDARZfw78QncnL0Ud
   2qY5InVnXdYJTdR+Yt8iALWM43J/m49d6daYWdMD+yhayV8bcrZULrK1k
   fTO/HluykJDOGMK2t/GOj8yctggQ6Dg07Se3GBnxxYzC3UQ4wPXZNRkSS
   Fjy7URPt5nJkWCV3DHq0eke0S6Dbu4o7YSG9uL6c6qwkPZRARPja+31Mc
   EcUHbne4VPzC9/giOo3R6H9w0WE9Pr1DeLoYSO+fbBMtS0GDZHZ7vkClg
   A==;
X-CSE-ConnectionGUID: iMWpEZqOSSOWAnkbF3FFRA==
X-CSE-MsgGUID: +rEeyqMYQUeHLPlB/lr0Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="69323200"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="69323200"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 21:10:46 -0800
X-CSE-ConnectionGUID: dDs7TSpnSxqn3XQFrQ60SQ==
X-CSE-MsgGUID: rreijx+8Q2CY6PwtnA0rsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="189917362"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 17 Nov 2025 21:10:41 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLDzC-0001Lr-0k;
	Tue, 18 Nov 2025 05:10:38 +0000
Date: Tue, 18 Nov 2025 13:09:39 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
	rostedt@goodmis.org
Cc: oe-kbuild-all@lists.linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, mhiramat@kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, jiang.biao@linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 6/6] bpf: implement "jmp" mode for trampoline
Message-ID: <202511181238.cVO5ERaA-lkp@intel.com>
References: <20251117034906.32036-7-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117034906.32036-7-dongml2@chinatelecom.cn>

Hi Menglong,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/ftrace-introduce-FTRACE_OPS_FL_JMP/20251117-115243
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251117034906.32036-7-dongml2%40chinatelecom.cn
patch subject: [PATCH bpf-next v2 6/6] bpf: implement "jmp" mode for trampoline
config: riscv-randconfig-001-20251118 (https://download.01.org/0day-ci/archive/20251118/202511181238.cVO5ERaA-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251118/202511181238.cVO5ERaA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511181238.cVO5ERaA-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/trampoline.c: In function 'bpf_trampoline_update':
>> kernel/bpf/trampoline.c:500:11: error: invalid use of undefined type 'struct ftrace_ops'
     500 |   tr->fops->flags |= FTRACE_OPS_FL_JMP;
         |           ^~
>> kernel/bpf/trampoline.c:500:22: error: 'FTRACE_OPS_FL_JMP' undeclared (first use in this function)
     500 |   tr->fops->flags |= FTRACE_OPS_FL_JMP;
         |                      ^~~~~~~~~~~~~~~~~
   kernel/bpf/trampoline.c:500:22: note: each undeclared identifier is reported only once for each function it appears in
   kernel/bpf/trampoline.c:502:11: error: invalid use of undefined type 'struct ftrace_ops'
     502 |   tr->fops->flags &= ~FTRACE_OPS_FL_JMP;
         |           ^~
   kernel/bpf/trampoline.c:534:12: error: invalid use of undefined type 'struct ftrace_ops'
     534 |    tr->fops->flags |= FTRACE_OPS_FL_JMP;
         |            ^~
   kernel/bpf/trampoline.c:536:12: error: invalid use of undefined type 'struct ftrace_ops'
     536 |    tr->fops->flags &= ~FTRACE_OPS_FL_JMP;
         |            ^~


vim +500 kernel/bpf/trampoline.c

   470	
   471		size = arch_bpf_trampoline_size(&tr->func.model, tr->flags,
   472						tlinks, tr->func.addr);
   473		if (size < 0) {
   474			err = size;
   475			goto out;
   476		}
   477	
   478		if (size > PAGE_SIZE) {
   479			err = -E2BIG;
   480			goto out;
   481		}
   482	
   483		im = bpf_tramp_image_alloc(tr->key, size);
   484		if (IS_ERR(im)) {
   485			err = PTR_ERR(im);
   486			goto out;
   487		}
   488	
   489		err = arch_prepare_bpf_trampoline(im, im->image, im->image + size,
   490						  &tr->func.model, tr->flags, tlinks,
   491						  tr->func.addr);
   492		if (err < 0)
   493			goto out_free;
   494	
   495		err = arch_protect_bpf_trampoline(im->image, im->size);
   496		if (err)
   497			goto out_free;
   498	
   499		if (bpf_trampoline_use_jmp(tr->flags))
 > 500			tr->fops->flags |= FTRACE_OPS_FL_JMP;
   501		else
   502			tr->fops->flags &= ~FTRACE_OPS_FL_JMP;
   503	
   504		WARN_ON(tr->cur_image && total == 0);
   505		if (tr->cur_image)
   506			/* progs already running at this address */
   507			err = modify_fentry(tr, orig_flags, tr->cur_image->image,
   508					    im->image, lock_direct_mutex);
   509		else
   510			/* first time registering */
   511			err = register_fentry(tr, im->image);
   512	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

