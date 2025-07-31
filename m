Return-Path: <bpf+bounces-64837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA900B176D5
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 21:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2AB71AA5C72
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 19:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FE5253B64;
	Thu, 31 Jul 2025 19:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ff7fQ4/D"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AF223ABB4;
	Thu, 31 Jul 2025 19:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753991796; cv=none; b=boIE8EW06PcHzzaojYEFA7tVqTR9ndhPxufqpT7eXGugFsVOd3NCmndpClvqVllDwdArxIcqOKKJFqXTieXXpB/yHzyJdDpsRsgCy5+EkxtgZyp6c8p3k/7+QeilGXLZipOt5ZXWLNJwGkI6ymz+Lb53fZ5AvV3yAoQTLwnLjgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753991796; c=relaxed/simple;
	bh=vErjyams3kwQ75voWQ/4xnzX0MZwKXtaLAcuOY/iq2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZV+mZ8muTHNYH6WB2Jb99PobAkwwciLSkX93EycI22DuB/ECPuB25DaqWzstIfWsBziWZcFNRIDcNVkRBys9bAQjMxK0uTk4jT/8C46G+caJT6VX26Xyy+cp05Rjv5FRbY3FEGWxvJEhVPgo74WRznBaljHZaY8QURkgwND03UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ff7fQ4/D; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753991795; x=1785527795;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vErjyams3kwQ75voWQ/4xnzX0MZwKXtaLAcuOY/iq2s=;
  b=ff7fQ4/DZqU22WdqicQhVJV4f1ccTqflpR4M/fvkasZby8ELYu5hKdem
   f+1ZFdFAeiTgw6umRsrqcB+dy895E7jQhkBUv4a1fB235Kof1G4bpkBvh
   l4P5Dpd7MirPLBQngGXE1EJv2qdYae8Sr33A/0Aah4YKivOfxi1qnSpnV
   h8EwspKaxdyLEf8nvHJ4ZOs8nrnVzKcXprJsOfKNiY7bNoXmSwP+WohPE
   K95ub2jVan64nHzVT2BBI3YNOfCnA9dOlxxB/c/mELyFxyLkr45PYh83O
   AvdYbBbLJcxchXHe9nGRokLGs25vZibpVh3BfSLDXfvjPG1/V4kgjQ3Sc
   Q==;
X-CSE-ConnectionGUID: NjLuLkBSREyn18RTbcZ0ig==
X-CSE-MsgGUID: MGXQxY3zT1G1bBFMPHe+Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56476765"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="56476765"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 12:56:34 -0700
X-CSE-ConnectionGUID: N9A53Q1iTQe4KTcJiiBjuQ==
X-CSE-MsgGUID: 5xHMQwDNQJOY8k0kjKQhNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="162627827"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 31 Jul 2025 12:56:25 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhZO2-000436-2T;
	Thu, 31 Jul 2025 19:56:22 +0000
Date: Fri, 1 Aug 2025 03:55:24 +0800
From: kernel test robot <lkp@intel.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, sdf@google.com,
	haoluo@google.com, yhs@fb.com, edumazet@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
	Mahanta.Jambigi@ibm.com, Sidraya.Jayagond@ibm.com,
	wenjia@linux.ibm.com, wintera@linux.ibm.com,
	dust.li@linux.alibaba.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, netdev@vger.kernel.org, jaka@linux.ibm.com
Subject: Re: [PATCH bpf-next 3/5] net/smc: bpf: Introduce generic hook for
 handshake flow
Message-ID: <202508010316.wuSPjSOr-lkp@intel.com>
References: <20250731084240.86550-4-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731084240.86550-4-alibuda@linux.alibaba.com>

Hi Wythe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/D-Wythe/bpf-export-necessary-sympols-for-modules-with-struct_ops/20250731-164431
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250731084240.86550-4-alibuda%40linux.alibaba.com
patch subject: [PATCH bpf-next 3/5] net/smc: bpf: Introduce generic hook for handshake flow
config: arm-randconfig-003-20250801 (https://download.01.org/0day-ci/archive/20250801/202508010316.wuSPjSOr-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250801/202508010316.wuSPjSOr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508010316.wuSPjSOr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ipv4/tcp_output.c: In function 'smc_set_option':
>> net/ipv4/tcp_output.c:773:15: warning: unused variable 'sk' [-Wunused-variable]
     773 |  struct sock *sk = &tp->inet_conn.icsk_inet.sk;
         |               ^~
   net/ipv4/tcp_output.c: In function 'smc_set_option_cond':
   net/ipv4/tcp_output.c:794:21: warning: unused variable 'sk' [-Wunused-variable]
     794 |  const struct sock *sk = &tp->inet_conn.icsk_inet.sk;
         |                     ^~


vim +/sk +773 net/ipv4/tcp_output.c

   767	
   768	static void smc_set_option(struct tcp_sock *tp,
   769				   struct tcp_out_options *opts,
   770				   unsigned int *remaining)
   771	{
   772	#if IS_ENABLED(CONFIG_SMC)
 > 773		struct sock *sk = &tp->inet_conn.icsk_inet.sk;
   774		if (static_branch_unlikely(&tcp_have_smc)) {
   775			if (tp->syn_smc) {
   776				tp->syn_smc = !!smc_call_hsbpf(1, sk, syn_option, tp);
   777				/* re-check syn_smc */
   778				if (tp->syn_smc &&
   779				    *remaining >= TCPOLEN_EXP_SMC_BASE_ALIGNED) {
   780					opts->options |= OPTION_SMC;
   781					*remaining -= TCPOLEN_EXP_SMC_BASE_ALIGNED;
   782				}
   783			}
   784		}
   785	#endif
   786	}
   787	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

