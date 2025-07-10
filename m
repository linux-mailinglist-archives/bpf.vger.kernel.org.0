Return-Path: <bpf+bounces-62985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BF9B00E6A
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 00:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C615F542C91
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 22:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4160291C2E;
	Thu, 10 Jul 2025 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGMVIElJ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AEC2253FD
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 22:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752184986; cv=none; b=u5roIfxBQiM+FVUB4OIaVzsyqV+O1/NC2Ev9vyfQB82vdJXunWPhkN8yxjLTdCfA7UIu3/V8+/ApUj0jUnYRy5BDe3CvBFQh+OhsQ28jA48ROYYD26c/r1/lk9qB1k+w7sduejRDv70tNxtucb4olHVcQsdOh5dSoYlnon8DMDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752184986; c=relaxed/simple;
	bh=RNfL6xXua6BldJx8pgCExOG+bjcuoCUjjrTaGgP5OFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3ewWxhjKqMh5Atac171u/QLbtr/ELFfy9U2EKQZU0qjGoRiEchAmCR7Ae++bx5Uak7VK4dbbkN8wLQYxYkZu+5YjW/RatZKCDJac9hS7vzDhI6X6qW+eTt8aoGsXVSixlnN2d/iWcAog3SNbYcyQwidFacNvIYp18GtrTIwLo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGMVIElJ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752184984; x=1783720984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RNfL6xXua6BldJx8pgCExOG+bjcuoCUjjrTaGgP5OFE=;
  b=mGMVIElJwuKlAgqWpCBu9y/mJe95l5yB/F5nKk6/2fzTDYowxbH8H6Hb
   zMU+tXIX6KCnD1ZMs5o4u6+pNaGE/4UEbsYwdZvBae+r4j3ajHcuJ58Cm
   YBKkYUBAsnkuqvL3I8FPz539TK1ycrZtUMRUu60tgI+I26AqoDpAA/ZnP
   AnWh6in5d6aLNX/Og+vBFF5xTJgtrYlFH8LLMTEe7KBUFdM4J52D26Zsz
   /bYI33x6Mh+W4nQ3/dctRHPRV99Po4iuRhw5dvsi+4NQEuOg0eenw1Xql
   2IMgtQ18RJ7KTjTrJpY/DH5qGUnZ7rsXlr48lG5T6AP3rvtFuzjDhrB3r
   Q==;
X-CSE-ConnectionGUID: EkUep0QvQAWyvKvKIiQSqA==
X-CSE-MsgGUID: 1FhtrpuwSgyLbsg36GcH/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65178723"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="65178723"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 15:03:03 -0700
X-CSE-ConnectionGUID: 5l/p8POnQwaghtPqoeXJuQ==
X-CSE-MsgGUID: Mnq+8THgSmyoLGmcLsLFZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="160221451"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jul 2025 15:03:01 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZzM3-0005Vv-1H;
	Thu, 10 Jul 2025 22:02:59 +0000
Date: Fri, 11 Jul 2025 06:02:14 +0800
From: kernel test robot <lkp@intel.com>
To: Mahe Tardy <mahe.tardy@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, martin.lau@linux.dev,
	daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
	andrii@kernel.org, Mahe Tardy <mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/4] net: move netfilter
 nf_reject6_fill_skb_dst to core ipv6
Message-ID: <202507110529.9ZuNSyQU-lkp@intel.com>
References: <20250710102607.12413-3-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710102607.12413-3-mahe.tardy@gmail.com>

Hi Mahe,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Mahe-Tardy/net-move-netfilter-nf_reject_fill_skb_dst-to-core-ipv4/20250710-182905
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250710102607.12413-3-mahe.tardy%40gmail.com
patch subject: [PATCH bpf-next v1 2/4] net: move netfilter nf_reject6_fill_skb_dst to core ipv6
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20250711/202507110529.9ZuNSyQU-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250711/202507110529.9ZuNSyQU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507110529.9ZuNSyQU-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/ipv6/netfilter/nf_reject_ipv6.c: In function 'nf_send_unreach6':
>> net/ipv6/netfilter/nf_reject_ipv6.c:386:13: error: implicit declaration of function 'ip6_reply_fill_dst' [-Werror=implicit-function-declaration]
     386 |             ip6_reply_fill_dst(skb_in) < 0)
         |             ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/ip6_reply_fill_dst +386 net/ipv6/netfilter/nf_reject_ipv6.c

   375	
   376	void nf_send_unreach6(struct net *net, struct sk_buff *skb_in,
   377			      unsigned char code, unsigned int hooknum)
   378	{
   379		if (!reject6_csum_ok(skb_in, hooknum))
   380			return;
   381	
   382		if (hooknum == NF_INET_LOCAL_OUT && skb_in->dev == NULL)
   383			skb_in->dev = net->loopback_dev;
   384	
   385		if ((hooknum == NF_INET_PRE_ROUTING || hooknum == NF_INET_INGRESS) &&
 > 386		    ip6_reply_fill_dst(skb_in) < 0)
   387			return;
   388	
   389		icmpv6_send(skb_in, ICMPV6_DEST_UNREACH, code, 0);
   390	}
   391	EXPORT_SYMBOL_GPL(nf_send_unreach6);
   392	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

