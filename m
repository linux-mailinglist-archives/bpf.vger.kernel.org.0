Return-Path: <bpf+bounces-30401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9098CD5A2
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 16:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B381C21814
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 14:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAE014BF89;
	Thu, 23 May 2024 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bD1ekbqg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D606C146D79;
	Thu, 23 May 2024 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474219; cv=none; b=GeBdRwjxPb+adqn4zemiHVwjX6ov0O4EcocSbO2uPxAQRTSpFjxiSMU43Hdqoe4E0FALBSdFaf3+y6R524VL50+Xn3kIN++eK5DB7De37XS+gOoWCcv2FRkixvCQyZI1L8YtEr99i40uDpmbHdsbZVo409rPzCdQL+axVeCHs6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474219; c=relaxed/simple;
	bh=4VzasgoIp8iJLru273gUC7Xd/2sk70oHQiDhBedMMCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTOJISDplEXZBTI3Z6gmcBkvDUcNwgoyrMq36qKJpVCU/aPIkBFnFIp2QAinnLwcudpHnp1bB7wMnoL+u1GY86/RQOOVifD9qPGQy0icRnyo9fDor9KGU+kjD4TpyJAcEKswpBf79nfQtqNA+q0FBM+hZn5j1dBXyfRu+RR0rgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bD1ekbqg; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716474216; x=1748010216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4VzasgoIp8iJLru273gUC7Xd/2sk70oHQiDhBedMMCg=;
  b=bD1ekbqgzVpQXZb5h1UWVtDp7Opuh5hRBBX8N91vPvC211NKp8qDWsr3
   U0/WBCqQvfmzP7+ETOl2+E/Y6ZNGlIzstRj9UblFRNMB+pZ+/WnzRfC5g
   V8FQOoJBuWwdwjOpH4C7vL1XX0B0LoUUK8SZki4o5xkNKIxUqd6KAoak/
   d9E6drf+Sejys+xEZMfCgEa8hj5h3Zlds3GfNYsF8bJAa0MEFmDjVCcrg
   j4B54vgl4ETvRllbKZZKPvQ8elEjH0iLnKNFikm75uLfnZ2LomeR40TeR
   bwwcmMuRCCVxZtPDYvIdb0wErcWhms/XQkiwE8j6gMjOEKpgUGsPV93Dg
   A==;
X-CSE-ConnectionGUID: g7a+o12BRyilohoStH6POw==
X-CSE-MsgGUID: IlypowyQTHGQWg9E2bhXdw==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12970413"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="12970413"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 07:23:36 -0700
X-CSE-ConnectionGUID: M0o0v+VlStSju+7ngdqoRQ==
X-CSE-MsgGUID: gX6pI8JsQOCgJtA9p4Gcfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="38463983"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 23 May 2024 07:23:34 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sA9Lu-0002yb-2g;
	Thu, 23 May 2024 14:23:30 +0000
Date: Thu, 23 May 2024 22:22:44 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Jakub Kicinski <kuba@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: add CHECKSUM_COMPLETE to bpf test progs
Message-ID: <202405232220.e9PuO2yW-lkp@intel.com>
References: <20240522145712.3523593-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522145712.3523593-1-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/selftests-bpf-validate-CHECKSUM_COMPLETE-option/20240522-225856
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240522145712.3523593-1-vadfed%40meta.com
patch subject: [PATCH bpf-next 1/2] bpf: add CHECKSUM_COMPLETE to bpf test progs
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240523/202405232220.e9PuO2yW-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240523/202405232220.e9PuO2yW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405232220.e9PuO2yW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/bpf/test_run.c: In function 'bpf_prog_test_run_skb':
>> net/bpf/test_run.c:978:17: warning: unused variable 'sum' [-Wunused-variable]
     978 |         __sum16 sum;
         |                 ^~~


vim +/sum +978 net/bpf/test_run.c

   963	
   964	int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
   965				  union bpf_attr __user *uattr)
   966	{
   967		bool is_l2 = false, is_direct_pkt_access = false;
   968		struct net *net = current->nsproxy->net_ns;
   969		struct net_device *dev = net->loopback_dev;
   970		u32 size = kattr->test.data_size_in;
   971		u32 repeat = kattr->test.repeat;
   972		struct __sk_buff *ctx = NULL;
   973		u32 retval, duration;
   974		int hh_len = ETH_HLEN;
   975		struct sk_buff *skb;
   976		struct sock *sk;
   977		__wsum csum;
 > 978		__sum16 sum;
   979		void *data;
   980		int ret;
   981	
   982		if ((kattr->test.flags & ~BPF_F_TEST_SKB_CHECKSUM_COMPLETE) ||
   983		    kattr->test.cpu || kattr->test.batch_size)
   984			return -EINVAL;
   985	
   986		data = bpf_test_init(kattr, kattr->test.data_size_in,
   987				     size, NET_SKB_PAD + NET_IP_ALIGN,
   988				     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
   989		if (IS_ERR(data))
   990			return PTR_ERR(data);
   991	
   992		ctx = bpf_ctx_init(kattr, sizeof(struct __sk_buff));
   993		if (IS_ERR(ctx)) {
   994			kfree(data);
   995			return PTR_ERR(ctx);
   996		}
   997	
   998		switch (prog->type) {
   999		case BPF_PROG_TYPE_SCHED_CLS:
  1000		case BPF_PROG_TYPE_SCHED_ACT:
  1001			is_l2 = true;
  1002			fallthrough;
  1003		case BPF_PROG_TYPE_LWT_IN:
  1004		case BPF_PROG_TYPE_LWT_OUT:
  1005		case BPF_PROG_TYPE_LWT_XMIT:
  1006			is_direct_pkt_access = true;
  1007			break;
  1008		default:
  1009			break;
  1010		}
  1011	
  1012		sk = sk_alloc(net, AF_UNSPEC, GFP_USER, &bpf_dummy_proto, 1);
  1013		if (!sk) {
  1014			kfree(data);
  1015			kfree(ctx);
  1016			return -ENOMEM;
  1017		}
  1018		sock_init_data(NULL, sk);
  1019	
  1020		skb = slab_build_skb(data);
  1021		if (!skb) {
  1022			kfree(data);
  1023			kfree(ctx);
  1024			sk_free(sk);
  1025			return -ENOMEM;
  1026		}
  1027		skb->sk = sk;
  1028	
  1029		skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
  1030		__skb_put(skb, size);
  1031	
  1032		if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
  1033			skb->csum = skb_checksum(skb, 0, skb->len, 0);
  1034			skb->ip_summed = CHECKSUM_COMPLETE;
  1035		}
  1036	
  1037		if (ctx && ctx->ifindex > 1) {
  1038			dev = dev_get_by_index(net, ctx->ifindex);
  1039			if (!dev) {
  1040				ret = -ENODEV;
  1041				goto out;
  1042			}
  1043		}
  1044		skb->protocol = eth_type_trans(skb, dev);
  1045		skb_reset_network_header(skb);
  1046	
  1047		switch (skb->protocol) {
  1048		case htons(ETH_P_IP):
  1049			sk->sk_family = AF_INET;
  1050			if (sizeof(struct iphdr) <= skb_headlen(skb)) {
  1051				sk->sk_rcv_saddr = ip_hdr(skb)->saddr;
  1052				sk->sk_daddr = ip_hdr(skb)->daddr;
  1053			}
  1054			break;
  1055	#if IS_ENABLED(CONFIG_IPV6)
  1056		case htons(ETH_P_IPV6):
  1057			sk->sk_family = AF_INET6;
  1058			if (sizeof(struct ipv6hdr) <= skb_headlen(skb)) {
  1059				sk->sk_v6_rcv_saddr = ipv6_hdr(skb)->saddr;
  1060				sk->sk_v6_daddr = ipv6_hdr(skb)->daddr;
  1061			}
  1062			break;
  1063	#endif
  1064		default:
  1065			break;
  1066		}
  1067	
  1068		if (is_l2)
  1069			__skb_push(skb, hh_len);
  1070		if (is_direct_pkt_access)
  1071			bpf_compute_data_pointers(skb);
  1072		ret = convert___skb_to_skb(skb, ctx);
  1073		if (ret)
  1074			goto out;
  1075		ret = bpf_test_run(prog, skb, repeat, &retval, &duration, false);
  1076		if (ret)
  1077			goto out;
  1078		if (!is_l2) {
  1079			if (skb_headroom(skb) < hh_len) {
  1080				int nhead = HH_DATA_ALIGN(hh_len - skb_headroom(skb));
  1081	
  1082				if (pskb_expand_head(skb, nhead, 0, GFP_USER)) {
  1083					ret = -ENOMEM;
  1084					goto out;
  1085				}
  1086			}
  1087			memset(__skb_push(skb, hh_len), 0, hh_len);
  1088		}
  1089		convert_skb_to___skb(skb, ctx);
  1090	
  1091		if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
  1092			csum = skb_checksum(skb, 0, skb->len, 0);
  1093			if (skb->csum != csum) {
  1094				ret = -EINVAL;
  1095				goto out;
  1096			}
  1097		}
  1098	
  1099		size = skb->len;
  1100		/* bpf program can never convert linear skb to non-linear */
  1101		if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
  1102			size = skb_headlen(skb);
  1103		ret = bpf_test_finish(kattr, uattr, skb->data, NULL, size, retval,
  1104				      duration);
  1105		if (!ret)
  1106			ret = bpf_ctx_finish(kattr, uattr, ctx,
  1107					     sizeof(struct __sk_buff));
  1108	out:
  1109		if (dev && dev != net->loopback_dev)
  1110			dev_put(dev);
  1111		kfree_skb(skb);
  1112		sk_free(sk);
  1113		kfree(ctx);
  1114		return ret;
  1115	}
  1116	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

