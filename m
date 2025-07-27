Return-Path: <bpf+bounces-64458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50864B12D66
	for <lists+bpf@lfdr.de>; Sun, 27 Jul 2025 03:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D7FA7A5EF5
	for <lists+bpf@lfdr.de>; Sun, 27 Jul 2025 01:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CBD1386B4;
	Sun, 27 Jul 2025 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ai6Hwucq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BCC1C6BE;
	Sun, 27 Jul 2025 01:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753580993; cv=none; b=Pet2kOyL6wRCwOr5CQILPyrv5mhh+rxipE+5Rkte5kpSz6cEsedmSO+963BlfCxJ7kbcSfoa4g+q5gauXrHVzGvmObN1dayS7vApaxfWavYxp6O5sAzW2S11GUANhW+QgSlaOhSzkocD4ZmLuMT8GM73qDQW3aX2YXOwVlbDYkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753580993; c=relaxed/simple;
	bh=48HdYVTlvbAhAr9UW9P0s9pgRZ85PBMkdsOGtT/jmfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMQAzEQ4J0t7UhPhnE7IChr/OBmONCWj2+gbM2aVWnYMnODUIGGxh1zvNJW+91oFnbXYKqMUStscegj8OzSKiqyeAG283adZGfBw+gHx5oFoUCA7VIrze9L8yqC1zHw3q7lkPgTxMvE494In+buHrqTTC4w1M5HfgJSpm8NY3sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ai6Hwucq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753580991; x=1785116991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=48HdYVTlvbAhAr9UW9P0s9pgRZ85PBMkdsOGtT/jmfA=;
  b=Ai6HwucqwzPRbVwx/UnjJKxoeXXicef3zltVPdly0LRQH2GGhZ1coU+I
   rBsMywAlFOp+XMM9bgvDboMTIUjtXgFgJM/eXkVUo8o4D1MmHn+eXhlyk
   ifgalCAFkfLHXwrgYPcfoCwdX0sli9HOFWtlStYa4UcpD1kGHLbBHBrwR
   qIwpF+HK7GuXPdUu+LZpW8/0HG3x+Nr3xJ3FJBpYoCFQQ7bAEMhoqoc1I
   qI/+Goanyv5lNJ+1//drL5s7hqj/N6RZ2/PWfIhd8FKRG3hlZtP7xpOSt
   dsEGwKJeAQ5agmDEriqWz83HY47wo+0yGB8DPXLTSAYoU2rA9gti8yus5
   w==;
X-CSE-ConnectionGUID: TU4jbamDSmOMw63N26XWLQ==
X-CSE-MsgGUID: +HmzWrVaQDmOVB6NfnaGBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="55568465"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55568465"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 18:49:50 -0700
X-CSE-ConnectionGUID: qnxRWMUuTrKEzUDpyD74eA==
X-CSE-MsgGUID: mRHTiYVsTpq65n1Qu/1AmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="162385034"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 26 Jul 2025 18:49:46 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufqWG-000MOB-0U;
	Sun, 27 Jul 2025 01:49:44 +0000
Date: Sun, 27 Jul 2025 09:49:36 +0800
From: kernel test robot <lkp@intel.com>
To: Mahe Tardy <mahe.tardy@gmail.com>, alexei.starovoitov@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, andrii@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	mahe.tardy@gmail.com, martin.lau@linux.dev, fw@strlen.de,
	netfilter-devel@vger.kernel.org, pablo@netfilter.org,
	netdev@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH bpf-next v2 3/4] bpf: add bpf_icmp_send_unreach
 cgroup_skb kfunc
Message-ID: <202507270940.kXGmRbg5-lkp@intel.com>
References: <20250725185342.262067-4-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725185342.262067-4-mahe.tardy@gmail.com>

Hi Mahe,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Mahe-Tardy/net-move-netfilter-nf_reject_fill_skb_dst-to-core-ipv4/20250726-030109
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250725185342.262067-4-mahe.tardy%40gmail.com
patch subject: [PATCH bpf-next v2 3/4] bpf: add bpf_icmp_send_unreach cgroup_skb kfunc
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20250727/202507270940.kXGmRbg5-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250727/202507270940.kXGmRbg5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507270940.kXGmRbg5-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: net/core/filter.o: in function `bpf_icmp_send_unreach':
>> net/core/filter.c:12184:(.text+0x14574): undefined reference to `ip6_route_reply_fetch_dst'


vim +12184 net/core/filter.c

 12152	
 12153	__bpf_kfunc int bpf_icmp_send_unreach(struct __sk_buff *__skb, int code)
 12154	{
 12155		struct sk_buff *skb = (struct sk_buff *)__skb;
 12156		struct sk_buff *nskb;
 12157	
 12158		switch (skb->protocol) {
 12159		case htons(ETH_P_IP):
 12160			if (code < 0 || code > NR_ICMP_UNREACH)
 12161				return -EINVAL;
 12162	
 12163			nskb = skb_clone(skb, GFP_ATOMIC);
 12164			if (!nskb)
 12165				return -ENOMEM;
 12166	
 12167			if (ip_route_reply_fetch_dst(nskb) < 0) {
 12168				kfree_skb(nskb);
 12169				return -EHOSTUNREACH;
 12170			}
 12171	
 12172			icmp_send(nskb, ICMP_DEST_UNREACH, code, 0);
 12173			kfree_skb(nskb);
 12174			break;
 12175	#if IS_ENABLED(CONFIG_IPV6)
 12176		case htons(ETH_P_IPV6):
 12177			if (code < 0 || code > ICMPV6_REJECT_ROUTE)
 12178				return -EINVAL;
 12179	
 12180			nskb = skb_clone(skb, GFP_ATOMIC);
 12181			if (!nskb)
 12182				return -ENOMEM;
 12183	
 12184			if (ip6_route_reply_fetch_dst(nskb) < 0) {
 12185				kfree_skb(nskb);
 12186				return -EHOSTUNREACH;
 12187			}
 12188	
 12189			icmpv6_send(nskb, ICMPV6_DEST_UNREACH, code, 0);
 12190			kfree_skb(nskb);
 12191			break;
 12192	#endif
 12193		default:
 12194			return -EPROTONOSUPPORT;
 12195		}
 12196	
 12197		return SK_DROP;
 12198	}
 12199	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

