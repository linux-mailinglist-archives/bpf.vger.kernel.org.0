Return-Path: <bpf+bounces-68922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE059B888B5
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 11:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0F816534F
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 09:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1AC2F3C2B;
	Fri, 19 Sep 2025 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AfSWwwmy"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2D2BEFE3;
	Fri, 19 Sep 2025 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758273981; cv=none; b=i7kar3pcS7qXkvo09eNpDasHvi/eL0LBmWCejAM5mkt8ILOr4rnstmJHpkjbkDcqwKyDIU/orBYfQZW/t98Ln3mkTnB8d918jo5kPCz4lW1GwkLof7otwQV2CqAwe6yKBbnbnhw9itcxAVHfbPbGU6DZLpDb3dw0FoA2IzGIXM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758273981; c=relaxed/simple;
	bh=zgXZIJagpXiZ3iWlFQfUgyi+88NHsoZv+XH2Gsx0/4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lh3DosPM6C1FEroTQAyWP5XRULtYnwwjpRey3Cr4KAenRr6M21pjldQfw8IFgMXBfpLQxFE6MH//rO5LpVjX1lpoobkghdfBPJFxB9YnIboVxd7OyqQ/CAezfRSXRhcCLBuXfobFO6B2fP5YCnPfLKIbTblIz7Ke1t/s5t9Ig+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AfSWwwmy; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758273979; x=1789809979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zgXZIJagpXiZ3iWlFQfUgyi+88NHsoZv+XH2Gsx0/4Y=;
  b=AfSWwwmyk6Z6ED4GOMftfjwBcPTjVAdqDZsBlA98CgSNK9COOBQ1GBja
   x5qyJEiuOXK/j23JyEKFuswcTIH8vpFCxN+g9xL9SDJLM7NwUqjLeZy+R
   KpsevlA8DrvUMMPr7a1kZJJALXY8ut1eT/lfSf/XDga6klG9qQ1TJXH7G
   KBpASr7vBEj8pue+zLMvgZeWUk5h8mBtHOMtbgCRffx6dt7peYWmcBiau
   xPk143VSPD96kjMefgWZXG4SWlZzxKQFzFaVp02Je9tmukRXa7iacmZSg
   q0pT40e1E4N31gNiZ7Nq8DSzZwoechbkoo0iiQhezaVvfUUUMIvtD7wIJ
   Q==;
X-CSE-ConnectionGUID: t54w6ivISMuoF9yW5FwNIg==
X-CSE-MsgGUID: 2V+qsLciToG7U905h61eRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="59838574"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="59838574"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 02:26:18 -0700
X-CSE-ConnectionGUID: Qf+m+2HWSpOrHpu9RX/wUA==
X-CSE-MsgGUID: 62U0HtHTQImBVz3xoHrz0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="176192176"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 19 Sep 2025 02:26:13 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzXNb-0004AB-0B;
	Fri, 19 Sep 2025 09:26:11 +0000
Date: Fri, 19 Sep 2025 17:25:28 +0800
From: kernel test robot <lkp@intel.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, sdf@google.com,
	haoluo@google.com, yhs@fb.com, edumazet@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
	mjambigi@linux.ibm.com, wenjia@linux.ibm.com, wintera@linux.ibm.com,
	dust.li@linux.alibaba.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, netdev@vger.kernel.org, sidraya@linux.ibm.com,
	jaka@linux.ibm.com
Subject: Re: [PATCH bpf-next v2 2/4] net/smc: bpf: Introduce generic hook for
 handshake flow
Message-ID: <202509191742.19csfvEU-lkp@intel.com>
References: <20250918080342.25041-3-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918080342.25041-3-alibuda@linux.alibaba.com>

Hi Wythe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/D-Wythe/bpf-export-necessary-symbols-for-modules-with-struct_ops/20250918-160530
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250918080342.25041-3-alibuda%40linux.alibaba.com
patch subject: [PATCH bpf-next v2 2/4] net/smc: bpf: Introduce generic hook for handshake flow
config: i386-randconfig-063-20250919 (https://download.01.org/0day-ci/archive/20250919/202509191742.19csfvEU-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250919/202509191742.19csfvEU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509191742.19csfvEU-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/ipv4/tcp_output.c:776:33: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smc_hs_ctrl *ctrl @@     got struct smc_hs_ctrl [noderef] __rcu * @@
   net/ipv4/tcp_output.c:776:33: sparse:     expected struct smc_hs_ctrl *ctrl
   net/ipv4/tcp_output.c:776:33: sparse:     got struct smc_hs_ctrl [noderef] __rcu *
   net/ipv4/tcp_output.c:796:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smc_hs_ctrl *ctrl @@     got struct smc_hs_ctrl [noderef] __rcu * @@
   net/ipv4/tcp_output.c:796:34: sparse:     expected struct smc_hs_ctrl *ctrl
   net/ipv4/tcp_output.c:796:34: sparse:     got struct smc_hs_ctrl [noderef] __rcu *
--
>> net/smc/smc_sysctl.c:59:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct smc_hs_ctrl [noderef] __rcu *__ret @@     got struct smc_hs_ctrl *[assigned] ctrl @@
   net/smc/smc_sysctl.c:59:16: sparse:     expected struct smc_hs_ctrl [noderef] __rcu *__ret
   net/smc/smc_sysctl.c:59:16: sparse:     got struct smc_hs_ctrl *[assigned] ctrl
>> net/smc/smc_sysctl.c:59:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smc_hs_ctrl *[assigned] ctrl @@     got struct smc_hs_ctrl [noderef] __rcu *[assigned] __ret @@
   net/smc/smc_sysctl.c:59:14: sparse:     expected struct smc_hs_ctrl *[assigned] ctrl
   net/smc/smc_sysctl.c:59:14: sparse:     got struct smc_hs_ctrl [noderef] __rcu *[assigned] __ret

vim +776 net/ipv4/tcp_output.c

   767	
   768	static void smc_set_option(struct tcp_sock *tp,
   769				   struct tcp_out_options *opts,
   770				   unsigned int *remaining)
   771	{
   772	#if IS_ENABLED(CONFIG_SMC)
   773		struct sock *sk = &tp->inet_conn.icsk_inet.sk;
   774	
   775		if (static_branch_unlikely(&tcp_have_smc) && tp->syn_smc) {
 > 776			tp->syn_smc = !!smc_call_hsbpf(1, sk, syn_option, tp);
   777			/* re-check syn_smc */
   778			if (tp->syn_smc &&
   779			    *remaining >= TCPOLEN_EXP_SMC_BASE_ALIGNED) {
   780				opts->options |= OPTION_SMC;
   781				*remaining -= TCPOLEN_EXP_SMC_BASE_ALIGNED;
   782			}
   783		}
   784	#endif
   785	}
   786	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

