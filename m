Return-Path: <bpf+bounces-74812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 87185C667B7
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 23:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id BAD3D2A407
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 22:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B8E342514;
	Mon, 17 Nov 2025 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzgI7Myr"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1564239E7D;
	Mon, 17 Nov 2025 22:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763419811; cv=none; b=kFEFWm9w1p4HQt9GV2e169f9X9a8f0r86XhqJyyZQ1M8QXhlpGV5xnH+W3nE5yI0tuEEuDz8q0pYeLNaP4cZ/wppcMJyQptivKPO/2dlkbpwyGaMVG31ufN0HrkuKA2AdV4V15tmL+88oDxRFGfVdiONrvFIeaEIq4sZgiRyeh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763419811; c=relaxed/simple;
	bh=ho1p3QGA7T1hhyD52Dd36WHe1Q9s1Ct6l/6u2zLQ20A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJTDGRxe7dJyb6kNQKoDTis94IfMBnf4zBNJpkafAxjeJpd1kqqtUA1vH3HTGmdjQldVt85ZCwCXIrzmJqDXhXR69zNc0Iy2BHZvBY59EADaWieP89KIYfKmjtyupsyeALJXRQAar9D1WQKOalUHdZOrnsy9wFrkHcT2V5Fr/L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dzgI7Myr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763419808; x=1794955808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ho1p3QGA7T1hhyD52Dd36WHe1Q9s1Ct6l/6u2zLQ20A=;
  b=dzgI7MyrWYItYeDkjZaBwIvNEErQBlmBlpHmwutKQn8crtMRBZA2zWlC
   0Ag46fAjYolxFc2YJFEBrKlYKkJLnb/M5hFj0t9S4r3P8I/pcbcFfVH6f
   aepgZGiUQ5TvQT8GEOC3tiF4phMFfKQTpRnBG8zMfY4ceCau/JdiVf8SN
   BXLcILPBEsOZP7JAmai9FtX6V5i/5D5nRyEdcUXLYlmm5wJarVUWM1lH6
   CZPXETVnGwA/iyeCMxa2C8VMEJCsN0oOii5biWBhfP7jKjrmBv0LkBsTq
   5c9k5b6MvcG5vWrk5nhDqY9onJcCO/UgToNOh9Wvr2uaKhrAlcGL/RLoD
   g==;
X-CSE-ConnectionGUID: YTQrUMVnSKC6TYAUPlMyeg==
X-CSE-MsgGUID: JAXOd9kMRX2XwFpq5iVGjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="76533893"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="76533893"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 14:50:05 -0800
X-CSE-ConnectionGUID: xK3yYl6ATSG32EPXWS2EjQ==
X-CSE-MsgGUID: WhMk9VMjQ+eqOU4N8nUaFw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 17 Nov 2025 14:50:01 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vL82n-00017f-37;
	Mon, 17 Nov 2025 22:49:57 +0000
Date: Tue, 18 Nov 2025 06:49:40 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
	rostedt@goodmis.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, mhiramat@kernel.org,
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 6/6] bpf: implement "jmp" mode for trampoline
Message-ID: <202511180613.Om7k1nP1-lkp@intel.com>
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
config: arm64-randconfig-002-20251118 (https://download.01.org/0day-ci/archive/20251118/202511180613.Om7k1nP1-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 0bba1e76581bad04e7d7f09f5115ae5e2989e0d9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251118/202511180613.Om7k1nP1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511180613.Om7k1nP1-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/trampoline.c:500:11: error: incomplete definition of type 'struct ftrace_ops'
     500 |                 tr->fops->flags |= FTRACE_OPS_FL_JMP;
         |                 ~~~~~~~~^
   include/linux/ftrace.h:40:8: note: forward declaration of 'struct ftrace_ops'
      40 | struct ftrace_ops;
         |        ^
>> kernel/bpf/trampoline.c:500:22: error: use of undeclared identifier 'FTRACE_OPS_FL_JMP'
     500 |                 tr->fops->flags |= FTRACE_OPS_FL_JMP;
         |                                    ^~~~~~~~~~~~~~~~~
   kernel/bpf/trampoline.c:502:11: error: incomplete definition of type 'struct ftrace_ops'
     502 |                 tr->fops->flags &= ~FTRACE_OPS_FL_JMP;
         |                 ~~~~~~~~^
   include/linux/ftrace.h:40:8: note: forward declaration of 'struct ftrace_ops'
      40 | struct ftrace_ops;
         |        ^
   kernel/bpf/trampoline.c:502:23: error: use of undeclared identifier 'FTRACE_OPS_FL_JMP'
     502 |                 tr->fops->flags &= ~FTRACE_OPS_FL_JMP;
         |                                     ^~~~~~~~~~~~~~~~~
   kernel/bpf/trampoline.c:534:12: error: incomplete definition of type 'struct ftrace_ops'
     534 |                         tr->fops->flags |= FTRACE_OPS_FL_JMP;
         |                         ~~~~~~~~^
   include/linux/ftrace.h:40:8: note: forward declaration of 'struct ftrace_ops'
      40 | struct ftrace_ops;
         |        ^
   kernel/bpf/trampoline.c:534:23: error: use of undeclared identifier 'FTRACE_OPS_FL_JMP'
     534 |                         tr->fops->flags |= FTRACE_OPS_FL_JMP;
         |                                            ^~~~~~~~~~~~~~~~~
   kernel/bpf/trampoline.c:536:12: error: incomplete definition of type 'struct ftrace_ops'
     536 |                         tr->fops->flags &= ~FTRACE_OPS_FL_JMP;
         |                         ~~~~~~~~^
   include/linux/ftrace.h:40:8: note: forward declaration of 'struct ftrace_ops'
      40 | struct ftrace_ops;
         |        ^
   kernel/bpf/trampoline.c:536:24: error: use of undeclared identifier 'FTRACE_OPS_FL_JMP'
     536 |                         tr->fops->flags &= ~FTRACE_OPS_FL_JMP;
         |                                             ^~~~~~~~~~~~~~~~~
   8 errors generated.


vim +/FTRACE_OPS_FL_JMP +500 kernel/bpf/trampoline.c

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

