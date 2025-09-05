Return-Path: <bpf+bounces-67556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDBEB45854
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 14:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3EF3B1715
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 12:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3CC350D6C;
	Fri,  5 Sep 2025 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RByg8Bal"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE38350D6A
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757077100; cv=none; b=vCFlbDvYiZFCpvHTCl5B/hGNBcDvf+tDm54BV1LPWy3T5PK5duFdjAXwcV7R91lQZC2bve430ZmS7hEbHwxKZOMsdMWk/z+Yb6LJt/x9gPBNc9en69CDo7mZl0v8IREIu4j+YrWs13uHMdighnfAN007JZhXIzUqFizRoGV+lBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757077100; c=relaxed/simple;
	bh=iGjbl+n7A/isMFwClIK0HGmlFZPp4JAsUaY9WH81aBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bds4hUSItaIgv9+MY8S3IPz1AuveCsGOSFS7Ce/ljPuJQShuEYVelKzrlPrcJRT5EGkwKiGf/oxgv88G1uA2GI4OBK/218qS1K+79nykfTOtVPrWzTqJNtZvSUOg3LO92XsmAv6carRkHTr6ctMxxL8DNlujKm/ut7mqetGPc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RByg8Bal; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757077099; x=1788613099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iGjbl+n7A/isMFwClIK0HGmlFZPp4JAsUaY9WH81aBc=;
  b=RByg8Bal5qQ5VEBGq1jeXxVbuPla192lI0dXmL4AMDY0r/HZTFmPsXHx
   mTvEeYxlX9p5/AlbkVfWZ0Tj5YNxPolUqcyU4zLH9HI4yznXwBOSMW6rv
   N21EEBOWmZC6HkY2JYZWKLU52l7MEk7jMbc/DDcvNzZyMN6dt2JrlkcT5
   Yuo4OPoIk/VhSBNoO/bTpIoKgqMyY7Wmz9xOSmxndoRMlpO+SrTNAhVEt
   I4N7zZsb1obfJKxL3iiVxJICma4H0jhXdQ9q86uGQjW4k7P1Vo1uvFRB+
   cdSp37QM/SBeWPs+WZSp27SGrxSkXYCJtpZ/QuFgcF0WlZFTlQppIvtGs
   A==;
X-CSE-ConnectionGUID: rZHoPD0eQzmWE7PWOSZViA==
X-CSE-MsgGUID: PmH85ATrTuqdoCQMFPMzKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="58639085"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="58639085"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 05:58:18 -0700
X-CSE-ConnectionGUID: WfNLJx51R6+ofOyeVrtSbw==
X-CSE-MsgGUID: F0YGoQ3FTeO6USh3KYCONQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="172509401"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 05 Sep 2025 05:58:16 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuW17-0000QV-2G;
	Fri, 05 Sep 2025 12:58:13 +0000
Date: Fri, 5 Sep 2025 20:57:29 +0800
From: kernel test robot <lkp@intel.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: Refactor cleanup of
 bpf_prog_test_run_skb
Message-ID: <202509052000.sL96WwEb-lkp@intel.com>
References: <6fda7c7fd57e6134ff70d12b622c9c7c3cf0b226.1756983952.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fda7c7fd57e6134ff70d12b622c9c7c3cf0b226.1756983952.git.paul.chaignon@gmail.com>

Hi Paul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Chaignon/bpf-Refactor-cleanup-of-bpf_prog_test_run_skb/20250904-201515
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/6fda7c7fd57e6134ff70d12b622c9c7c3cf0b226.1756983952.git.paul.chaignon%40gmail.com
patch subject: [PATCH bpf-next 1/4] bpf: Refactor cleanup of bpf_prog_test_run_skb
config: i386-buildonly-randconfig-006-20250905 (https://download.01.org/0day-ci/archive/20250905/202509052000.sL96WwEb-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250905/202509052000.sL96WwEb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509052000.sL96WwEb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/bpf/test_run.c:1011:6: warning: variable 'sk' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    1011 |         if (IS_ERR(ctx)) {
         |             ^~~~~~~~~~~
   net/bpf/test_run.c:1142:6: note: uninitialized use occurs here
    1142 |         if (sk)
         |             ^~
   net/bpf/test_run.c:1011:2: note: remove the 'if' if its condition is always false
    1011 |         if (IS_ERR(ctx)) {
         |         ^~~~~~~~~~~~~~~~~~
    1012 |                 ret = PTR_ERR(ctx);
         |                 ~~~~~~~~~~~~~~~~~~~
    1013 |                 goto out;
         |                 ~~~~~~~~~
    1014 |         }
         |         ~
   net/bpf/test_run.c:996:17: note: initialize the variable 'sk' to silence this warning
     996 |         struct sock *sk;
         |                        ^
         |                         = NULL
>> net/bpf/test_run.c:1032:6: warning: variable 'skb' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    1032 |         if (!sk) {
         |             ^~~
   net/bpf/test_run.c:1140:12: note: uninitialized use occurs here
    1140 |         kfree_skb(skb);
         |                   ^~~
   net/bpf/test_run.c:1032:2: note: remove the 'if' if its condition is always false
    1032 |         if (!sk) {
         |         ^~~~~~~~~~
    1033 |                 ret = -ENOMEM;
         |                 ~~~~~~~~~~~~~~
    1034 |                 goto out;
         |                 ~~~~~~~~~
    1035 |         }
         |         ~
   net/bpf/test_run.c:1011:6: warning: variable 'skb' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    1011 |         if (IS_ERR(ctx)) {
         |             ^~~~~~~~~~~
   net/bpf/test_run.c:1140:12: note: uninitialized use occurs here
    1140 |         kfree_skb(skb);
         |                   ^~~
   net/bpf/test_run.c:1011:2: note: remove the 'if' if its condition is always false
    1011 |         if (IS_ERR(ctx)) {
         |         ^~~~~~~~~~~~~~~~~~
    1012 |                 ret = PTR_ERR(ctx);
         |                 ~~~~~~~~~~~~~~~~~~~
    1013 |                 goto out;
         |                 ~~~~~~~~~
    1014 |         }
         |         ~
   net/bpf/test_run.c:995:21: note: initialize the variable 'skb' to silence this warning
     995 |         struct sk_buff *skb;
         |                            ^
         |                             = NULL
   3 warnings generated.


vim +1011 net/bpf/test_run.c

435b08ec0094ac Daniel Borkmann     2021-09-27   983  
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30   984  int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30   985  			  union bpf_attr __user *uattr)
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30   986  {
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30   987  	bool is_l2 = false, is_direct_pkt_access = false;
21594c44083c37 Dmitry Yakunin      2020-08-03   988  	struct net *net = current->nsproxy->net_ns;
21594c44083c37 Dmitry Yakunin      2020-08-03   989  	struct net_device *dev = net->loopback_dev;
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30   990  	u32 size = kattr->test.data_size_in;
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30   991  	u32 repeat = kattr->test.repeat;
b0b9395d865e30 Stanislav Fomichev  2019-04-09   992  	struct __sk_buff *ctx = NULL;
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30   993  	u32 retval, duration;
6e6fddc7832353 Daniel Borkmann     2018-07-11   994  	int hh_len = ETH_HLEN;
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30   995  	struct sk_buff *skb;
2cb494a36c9827 Song Liu            2018-10-19   996  	struct sock *sk;
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30   997  	void *data;
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30   998  	int ret;
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30   999  
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1000  	if ((kattr->test.flags & ~BPF_F_TEST_SKB_CHECKSUM_COMPLETE) ||
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1001  	    kattr->test.cpu || kattr->test.batch_size)
1b4d60ec162f82 Song Liu            2020-09-25  1002  		return -EINVAL;
1b4d60ec162f82 Song Liu            2020-09-25  1003  
be3d72a2896cb2 Lorenzo Bianconi    2022-01-21  1004  	data = bpf_test_init(kattr, kattr->test.data_size_in,
be3d72a2896cb2 Lorenzo Bianconi    2022-01-21  1005  			     size, NET_SKB_PAD + NET_IP_ALIGN,
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1006  			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1007  	if (IS_ERR(data))
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1008  		return PTR_ERR(data);
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1009  
b0b9395d865e30 Stanislav Fomichev  2019-04-09  1010  	ctx = bpf_ctx_init(kattr, sizeof(struct __sk_buff));
b0b9395d865e30 Stanislav Fomichev  2019-04-09 @1011  	if (IS_ERR(ctx)) {
ed22fb43432aaa Paul Chaignon       2025-09-04  1012  		ret = PTR_ERR(ctx);
ed22fb43432aaa Paul Chaignon       2025-09-04  1013  		goto out;
b0b9395d865e30 Stanislav Fomichev  2019-04-09  1014  	}
b0b9395d865e30 Stanislav Fomichev  2019-04-09  1015  
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1016  	switch (prog->type) {
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1017  	case BPF_PROG_TYPE_SCHED_CLS:
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1018  	case BPF_PROG_TYPE_SCHED_ACT:
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1019  		is_l2 = true;
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  1020  		fallthrough;
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1021  	case BPF_PROG_TYPE_LWT_IN:
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1022  	case BPF_PROG_TYPE_LWT_OUT:
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1023  	case BPF_PROG_TYPE_LWT_XMIT:
ed3e469d021cba Mahe Tardy          2024-11-25  1024  	case BPF_PROG_TYPE_CGROUP_SKB:
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1025  		is_direct_pkt_access = true;
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1026  		break;
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1027  	default:
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1028  		break;
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1029  	}
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1030  
435b08ec0094ac Daniel Borkmann     2021-09-27  1031  	sk = sk_alloc(net, AF_UNSPEC, GFP_USER, &bpf_dummy_proto, 1);
2cb494a36c9827 Song Liu            2018-10-19 @1032  	if (!sk) {
ed22fb43432aaa Paul Chaignon       2025-09-04  1033  		ret = -ENOMEM;
ed22fb43432aaa Paul Chaignon       2025-09-04  1034  		goto out;
2cb494a36c9827 Song Liu            2018-10-19  1035  	}
2cb494a36c9827 Song Liu            2018-10-19  1036  	sock_init_data(NULL, sk);
2cb494a36c9827 Song Liu            2018-10-19  1037  
ce098da1497c6d Kees Cook           2022-12-07  1038  	skb = slab_build_skb(data);
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1039  	if (!skb) {
ed22fb43432aaa Paul Chaignon       2025-09-04  1040  		ret = -ENOMEM;
ed22fb43432aaa Paul Chaignon       2025-09-04  1041  		goto out;
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1042  	}
2cb494a36c9827 Song Liu            2018-10-19  1043  	skb->sk = sk;
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1044  
586f8525979ad9 David Miller        2017-05-02  1045  	skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1046  	__skb_put(skb, size);
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1047  
ed22fb43432aaa Paul Chaignon       2025-09-04  1048  	data = NULL; /* data released via kfree_skb */
ed22fb43432aaa Paul Chaignon       2025-09-04  1049  
21594c44083c37 Dmitry Yakunin      2020-08-03  1050  	if (ctx && ctx->ifindex > 1) {
21594c44083c37 Dmitry Yakunin      2020-08-03  1051  		dev = dev_get_by_index(net, ctx->ifindex);
21594c44083c37 Dmitry Yakunin      2020-08-03  1052  		if (!dev) {
21594c44083c37 Dmitry Yakunin      2020-08-03  1053  			ret = -ENODEV;
21594c44083c37 Dmitry Yakunin      2020-08-03  1054  			goto out;
21594c44083c37 Dmitry Yakunin      2020-08-03  1055  		}
21594c44083c37 Dmitry Yakunin      2020-08-03  1056  	}
21594c44083c37 Dmitry Yakunin      2020-08-03  1057  	skb->protocol = eth_type_trans(skb, dev);
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1058  	skb_reset_network_header(skb);
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1059  
fa5cb548ced61b Dmitry Yakunin      2020-08-03  1060  	switch (skb->protocol) {
fa5cb548ced61b Dmitry Yakunin      2020-08-03  1061  	case htons(ETH_P_IP):
fa5cb548ced61b Dmitry Yakunin      2020-08-03  1062  		sk->sk_family = AF_INET;
fa5cb548ced61b Dmitry Yakunin      2020-08-03  1063  		if (sizeof(struct iphdr) <= skb_headlen(skb)) {
fa5cb548ced61b Dmitry Yakunin      2020-08-03  1064  			sk->sk_rcv_saddr = ip_hdr(skb)->saddr;
fa5cb548ced61b Dmitry Yakunin      2020-08-03  1065  			sk->sk_daddr = ip_hdr(skb)->daddr;
fa5cb548ced61b Dmitry Yakunin      2020-08-03  1066  		}
fa5cb548ced61b Dmitry Yakunin      2020-08-03  1067  		break;
fa5cb548ced61b Dmitry Yakunin      2020-08-03  1068  #if IS_ENABLED(CONFIG_IPV6)
fa5cb548ced61b Dmitry Yakunin      2020-08-03  1069  	case htons(ETH_P_IPV6):
fa5cb548ced61b Dmitry Yakunin      2020-08-03  1070  		sk->sk_family = AF_INET6;
fa5cb548ced61b Dmitry Yakunin      2020-08-03  1071  		if (sizeof(struct ipv6hdr) <= skb_headlen(skb)) {
fa5cb548ced61b Dmitry Yakunin      2020-08-03  1072  			sk->sk_v6_rcv_saddr = ipv6_hdr(skb)->saddr;
fa5cb548ced61b Dmitry Yakunin      2020-08-03  1073  			sk->sk_v6_daddr = ipv6_hdr(skb)->daddr;
fa5cb548ced61b Dmitry Yakunin      2020-08-03  1074  		}
fa5cb548ced61b Dmitry Yakunin      2020-08-03  1075  		break;
fa5cb548ced61b Dmitry Yakunin      2020-08-03  1076  #endif
fa5cb548ced61b Dmitry Yakunin      2020-08-03  1077  	default:
fa5cb548ced61b Dmitry Yakunin      2020-08-03  1078  		break;
fa5cb548ced61b Dmitry Yakunin      2020-08-03  1079  	}
fa5cb548ced61b Dmitry Yakunin      2020-08-03  1080  
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1081  	if (is_l2)
6e6fddc7832353 Daniel Borkmann     2018-07-11  1082  		__skb_push(skb, hh_len);
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1083  	if (is_direct_pkt_access)
6aaae2b6c4330a Daniel Borkmann     2017-09-25  1084  		bpf_compute_data_pointers(skb);
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1085  
b0b9395d865e30 Stanislav Fomichev  2019-04-09  1086  	ret = convert___skb_to_skb(skb, ctx);
b0b9395d865e30 Stanislav Fomichev  2019-04-09  1087  	if (ret)
b0b9395d865e30 Stanislav Fomichev  2019-04-09  1088  		goto out;
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1089  
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1090  	if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1091  		const int off = skb_network_offset(skb);
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1092  		int len = skb->len - off;
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1093  
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1094  		skb->csum = skb_checksum(skb, off, len, 0);
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1095  		skb->ip_summed = CHECKSUM_COMPLETE;
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1096  	}
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1097  
f23c4b3924d2e9 Björn Töpel         2019-12-13  1098  	ret = bpf_test_run(prog, skb, repeat, &retval, &duration, false);
b0b9395d865e30 Stanislav Fomichev  2019-04-09  1099  	if (ret)
b0b9395d865e30 Stanislav Fomichev  2019-04-09  1100  		goto out;
6e6fddc7832353 Daniel Borkmann     2018-07-11  1101  	if (!is_l2) {
6e6fddc7832353 Daniel Borkmann     2018-07-11  1102  		if (skb_headroom(skb) < hh_len) {
6e6fddc7832353 Daniel Borkmann     2018-07-11  1103  			int nhead = HH_DATA_ALIGN(hh_len - skb_headroom(skb));
6e6fddc7832353 Daniel Borkmann     2018-07-11  1104  
6e6fddc7832353 Daniel Borkmann     2018-07-11  1105  			if (pskb_expand_head(skb, nhead, 0, GFP_USER)) {
b0b9395d865e30 Stanislav Fomichev  2019-04-09  1106  				ret = -ENOMEM;
b0b9395d865e30 Stanislav Fomichev  2019-04-09  1107  				goto out;
6e6fddc7832353 Daniel Borkmann     2018-07-11  1108  			}
6e6fddc7832353 Daniel Borkmann     2018-07-11  1109  		}
6e6fddc7832353 Daniel Borkmann     2018-07-11  1110  		memset(__skb_push(skb, hh_len), 0, hh_len);
6e6fddc7832353 Daniel Borkmann     2018-07-11  1111  	}
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1112  
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1113  	if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1114  		const int off = skb_network_offset(skb);
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1115  		int len = skb->len - off;
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1116  		__wsum csum;
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1117  
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1118  		csum = skb_checksum(skb, off, len, 0);
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1119  
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1120  		if (csum_fold(skb->csum) != csum_fold(csum)) {
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1121  			ret = -EBADMSG;
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1122  			goto out;
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1123  		}
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1124  	}
a3cfe84cca28f2 Vadim Fedorenko     2024-06-06  1125  
b0b9395d865e30 Stanislav Fomichev  2019-04-09  1126  	convert_skb_to___skb(skb, ctx);
6e6fddc7832353 Daniel Borkmann     2018-07-11  1127  
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1128  	size = skb->len;
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1129  	/* bpf program can never convert linear skb to non-linear */
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1130  	if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1131  		size = skb_headlen(skb);
7855e0db150ad8 Lorenzo Bianconi    2022-01-21  1132  	ret = bpf_test_finish(kattr, uattr, skb->data, NULL, size, retval,
7855e0db150ad8 Lorenzo Bianconi    2022-01-21  1133  			      duration);
b0b9395d865e30 Stanislav Fomichev  2019-04-09  1134  	if (!ret)
b0b9395d865e30 Stanislav Fomichev  2019-04-09  1135  		ret = bpf_ctx_finish(kattr, uattr, ctx,
b0b9395d865e30 Stanislav Fomichev  2019-04-09  1136  				     sizeof(struct __sk_buff));
b0b9395d865e30 Stanislav Fomichev  2019-04-09  1137  out:
21594c44083c37 Dmitry Yakunin      2020-08-03  1138  	if (dev && dev != net->loopback_dev)
21594c44083c37 Dmitry Yakunin      2020-08-03  1139  		dev_put(dev);
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1140  	kfree_skb(skb);
ed22fb43432aaa Paul Chaignon       2025-09-04  1141  	kfree(data);
ed22fb43432aaa Paul Chaignon       2025-09-04  1142  	if (sk)
435b08ec0094ac Daniel Borkmann     2021-09-27  1143  		sk_free(sk);
b0b9395d865e30 Stanislav Fomichev  2019-04-09  1144  	kfree(ctx);
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1145  	return ret;
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1146  }
1cf1cae963c2e6 Alexei Starovoitov  2017-03-30  1147  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

