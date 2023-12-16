Return-Path: <bpf+bounces-18083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4376B815794
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 05:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78B10B2122E
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 04:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BA11118E;
	Sat, 16 Dec 2023 04:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iIiWkd0u"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9548E13FF3;
	Sat, 16 Dec 2023 04:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702702450; x=1734238450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hbCzV9FRyfR9WQHmArq5wOV7koxOXpFFbjy3k1iOVwE=;
  b=iIiWkd0u+l++9NKvsnPOdvQNOK+esIE9ooleHcK1qNVY1Clp5fUO2A0H
   EiGbwxJ8hr7LcUeajNCRXYXgNSmLdUqsw50hCl8lOS1V50JgjFqy9Ec3F
   s3+WlJqHFoWsWSp9yUIEqM6X0LHVMroRIeLrOpew5fgz+BdSaEfY8Nph6
   ff3FnItSc8bxbHnnIwIqOdN6zqQtD0bK1zVZV98XD2txAdCsfyJabIcpe
   e0W6N4xBwcU8jEekyEMtTPK0t8k7hjOkZeN7QkNXWcwEpJ3GHGWov57AG
   yVlZ5lMZCr4VO+a0nVVK7MkUQJE8kfE4MmRBKieNEU+ya3GVi1gSJQMpZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="385777633"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="385777633"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 20:54:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="751162050"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="751162050"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Dec 2023 20:54:04 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEMga-0001Ac-1s;
	Sat, 16 Dec 2023 04:54:01 +0000
Date: Sat, 16 Dec 2023 12:53:43 +0800
From: kernel test robot <lkp@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next 20/24] net: intel: Use nested-BH locking for XDP
 redirect.
Message-ID: <202312161212.D5tju5i6-lkp@intel.com>
References: <20231215171020.687342-21-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215171020.687342-21-bigeasy@linutronix.de>

Hi Sebastian,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Andrzej-Siewior/locking-local_lock-Introduce-guard-definition-for-local_lock/20231216-011911
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231215171020.687342-21-bigeasy%40linutronix.de
patch subject: [PATCH net-next 20/24] net: intel: Use nested-BH locking for XDP redirect.
config: arm-defconfig (https://download.01.org/0day-ci/archive/20231216/202312161212.D5tju5i6-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312161212.D5tju5i6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312161212.D5tju5i6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/igb/igb_main.c:8620:3: error: cannot jump from this goto statement to its label
                   goto xdp_out;
                   ^
   drivers/net/ethernet/intel/igb/igb_main.c:8624:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
           guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
           ^
   include/linux/cleanup.h:142:15: note: expanded from macro 'guard'
           CLASS(_name, __UNIQUE_ID(guard))
                        ^
   include/linux/compiler.h:180:29: note: expanded from macro '__UNIQUE_ID'
   #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                               ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
   #define __PASTE(a,b) ___PASTE(a,b)
                        ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
   #define ___PASTE(a,b) a##b
                         ^
   <scratch space>:52:1: note: expanded from here
   __UNIQUE_ID_guard753
   ^
   1 error generated.


vim +8620 drivers/net/ethernet/intel/igb/igb_main.c

b1bb2eb0a0deb0 Alexander Duyck           2017-02-06  8608  
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8609  static struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8610  				   struct igb_ring *rx_ring,
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8611  				   struct xdp_buff *xdp)
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8612  {
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8613  	int err, result = IGB_XDP_PASS;
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8614  	struct bpf_prog *xdp_prog;
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8615  	u32 act;
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8616  
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8617  	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8618  
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8619  	if (!xdp_prog)
9cbc948b5a20c9 Sven Auhagen              2020-09-02 @8620  		goto xdp_out;
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8621  
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8622  	prefetchw(xdp->data_hard_start); /* xdp_frame write */
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8623  
d568b111738dbb Sebastian Andrzej Siewior 2023-12-15  8624  	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8625  	act = bpf_prog_run_xdp(xdp_prog, xdp);
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8626  	switch (act) {
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8627  	case XDP_PASS:
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8628  		break;
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8629  	case XDP_TX:
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8630  		result = igb_xdp_xmit_back(adapter, xdp);
74431c40b9c5fa Magnus Karlsson           2021-05-10  8631  		if (result == IGB_XDP_CONSUMED)
74431c40b9c5fa Magnus Karlsson           2021-05-10  8632  			goto out_failure;
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8633  		break;
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8634  	case XDP_REDIRECT:
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8635  		err = xdp_do_redirect(adapter->netdev, xdp, xdp_prog);
74431c40b9c5fa Magnus Karlsson           2021-05-10  8636  		if (err)
74431c40b9c5fa Magnus Karlsson           2021-05-10  8637  			goto out_failure;
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8638  		result = IGB_XDP_REDIR;
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8639  		break;
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8640  	default:
c8064e5b4adac5 Paolo Abeni               2021-11-30  8641  		bpf_warn_invalid_xdp_action(adapter->netdev, xdp_prog, act);
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8642  		fallthrough;
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8643  	case XDP_ABORTED:
74431c40b9c5fa Magnus Karlsson           2021-05-10  8644  out_failure:
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8645  		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8646  		fallthrough;
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8647  	case XDP_DROP:
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8648  		result = IGB_XDP_CONSUMED;
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8649  		break;
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8650  	}
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8651  xdp_out:
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8652  	return ERR_PTR(-result);
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8653  }
9cbc948b5a20c9 Sven Auhagen              2020-09-02  8654  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

