Return-Path: <bpf+bounces-46369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CDE9E8A57
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 05:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85A8280D17
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 04:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EDD1662E9;
	Mon,  9 Dec 2024 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXd3n6nB"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFFB156228;
	Mon,  9 Dec 2024 04:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733718751; cv=none; b=ZdpUXb3fdtlCoOYxYLfWIjzDd4gHhy3f7BjlWQi0zZtpA5gTk/9zGNcYPpOb00Z8h6OqRzzvArvUM/KHgmYcMsx7KJ6dCVw1Inn1ekWcKroNAcx405GOhjkrbMf70PMUVBvKiSAkYw29F72RtWRt27cR/48YeUl3g1hk8iD+9yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733718751; c=relaxed/simple;
	bh=Ghijc7E8MmComqWc050r3kLhpq7yal+Fp77MyT1v39Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0/RVcQpgd5itgeaLZ6JHXTU/V3kl79NT6ThcROOOvdrsN2eBN06kioO25NRDeWCTjpUvQ8mzLnOFSm10YDTDUjJduE3tCelC5I2T6bpb7zjCcnY3MLvIQ8L75kHK9s6bCVktW9kTK1mVq2XowR83yuEmqbWugTpAEh1o46SRUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXd3n6nB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733718749; x=1765254749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ghijc7E8MmComqWc050r3kLhpq7yal+Fp77MyT1v39Q=;
  b=QXd3n6nB5g1NaQJyHzwz3Q65XYcsZQIGYbHgjN/TB20v9/FaL3FI809e
   YCoIudHHOPLYv0jKLhCU6wTqJjgLpO5kus3MgNdNoPpsT9mFUHoewJFsU
   w1S24RqmhCdCC6rHPCOG1/wA2z5emCnLot8MotWMw+PmnewnDeAyjKIVh
   nskz9HVCO6CnkFvBCDqErkvobFQh7mmwl9JgJhT00qXZaToVaBNVXG2fD
   UUKbc1CqPU7qTKidU281WpmoIO+aabmfP2xOMp2NXYECCQyVzbLiNFp+V
   Akcoo2qmEefnatMwqdUit+7gUJoMDKf+Ha1yr96CiQ60/ow1EZndWwDFn
   w==;
X-CSE-ConnectionGUID: oWfeRT+2Q96ySldpndPsPg==
X-CSE-MsgGUID: rfoRkHasSx6C2KCDHaW7VQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="37931096"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="37931096"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:32:25 -0800
X-CSE-ConnectionGUID: ot+ewKTgT7KT2i7CIrG8eA==
X-CSE-MsgGUID: N9gjHNrRT++KP3VqdoApNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="94825381"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Dec 2024 20:32:19 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVRQ-0003s5-0h;
	Mon, 09 Dec 2024 04:32:16 +0000
Date: Mon, 9 Dec 2024 12:31:52 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v4 01/11] net-timestamp: add support for
 bpf_setsockopt()
Message-ID: <202412080629.IyOW2oUA-lkp@intel.com>
References: <20241207173803.90744-2-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207173803.90744-2-kerneljasonxing@gmail.com>

Hi Jason,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/net-timestamp-add-support-for-bpf_setsockopt/20241208-014111
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241207173803.90744-2-kerneljasonxing%40gmail.com
patch subject: [PATCH net-next v4 01/11] net-timestamp: add support for bpf_setsockopt()
config: x86_64-buildonly-randconfig-004-20241208 (https://download.01.org/0day-ci/archive/20241208/202412080629.IyOW2oUA-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241208/202412080629.IyOW2oUA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412080629.IyOW2oUA-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/core/filter.c:21:
   In file included from include/linux/bpf_verifier.h:7:
   In file included from include/linux/bpf.h:21:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   net/core/filter.c:1726:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    1726 |         .arg3_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:2041:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    2041 |         .arg1_type      = ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   net/core/filter.c:2043:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    2043 |         .arg3_type      = ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   net/core/filter.c:2580:35: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    2580 |         .arg2_type      = ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   net/core/filter.c:4643:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    4643 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:4657:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    4657 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:4857:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    4857 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:4885:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    4885 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5057:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5057 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5071:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5071 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5120:45: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5120 |         .arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON | PTR_MAYBE_NULL,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
>> net/core/filter.c:5232:6: error: no member named 'sk_bpf_cb_flags' in 'struct sock'
    5232 |         sk->sk_bpf_cb_flags = sk_bpf_cb_flags;
         |         ~~  ^
   net/core/filter.c:5577:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5577 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5611:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5611 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5645:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5645 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5679:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5679 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:5854:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5854 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6391:46: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6391 |         .arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_WRITE | MEM_ALIGNED,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~
   net/core/filter.c:6403:46: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6403 |         .arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_WRITE | MEM_ALIGNED,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~
   net/core/filter.c:6489:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6489 |         .arg3_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   net/core/filter.c:6499:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6499 |         .arg3_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   21 warnings and 1 error generated.


vim +5232 net/core/filter.c

  5049	
  5050	static const struct bpf_func_proto bpf_xdp_event_output_proto = {
  5051		.func		= bpf_xdp_event_output,
  5052		.gpl_only	= true,
  5053		.ret_type	= RET_INTEGER,
  5054		.arg1_type	= ARG_PTR_TO_CTX,
  5055		.arg2_type	= ARG_CONST_MAP_PTR,
  5056		.arg3_type	= ARG_ANYTHING,
> 5057		.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
  5058		.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
  5059	};
  5060	
  5061	BTF_ID_LIST_SINGLE(bpf_xdp_output_btf_ids, struct, xdp_buff)
  5062	
  5063	const struct bpf_func_proto bpf_xdp_output_proto = {
  5064		.func		= bpf_xdp_event_output,
  5065		.gpl_only	= true,
  5066		.ret_type	= RET_INTEGER,
  5067		.arg1_type	= ARG_PTR_TO_BTF_ID,
  5068		.arg1_btf_id	= &bpf_xdp_output_btf_ids[0],
  5069		.arg2_type	= ARG_CONST_MAP_PTR,
  5070		.arg3_type	= ARG_ANYTHING,
  5071		.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
  5072		.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
  5073	};
  5074	
  5075	BPF_CALL_1(bpf_get_socket_cookie, struct sk_buff *, skb)
  5076	{
  5077		return skb->sk ? __sock_gen_cookie(skb->sk) : 0;
  5078	}
  5079	
  5080	static const struct bpf_func_proto bpf_get_socket_cookie_proto = {
  5081		.func           = bpf_get_socket_cookie,
  5082		.gpl_only       = false,
  5083		.ret_type       = RET_INTEGER,
  5084		.arg1_type      = ARG_PTR_TO_CTX,
  5085	};
  5086	
  5087	BPF_CALL_1(bpf_get_socket_cookie_sock_addr, struct bpf_sock_addr_kern *, ctx)
  5088	{
  5089		return __sock_gen_cookie(ctx->sk);
  5090	}
  5091	
  5092	static const struct bpf_func_proto bpf_get_socket_cookie_sock_addr_proto = {
  5093		.func		= bpf_get_socket_cookie_sock_addr,
  5094		.gpl_only	= false,
  5095		.ret_type	= RET_INTEGER,
  5096		.arg1_type	= ARG_PTR_TO_CTX,
  5097	};
  5098	
  5099	BPF_CALL_1(bpf_get_socket_cookie_sock, struct sock *, ctx)
  5100	{
  5101		return __sock_gen_cookie(ctx);
  5102	}
  5103	
  5104	static const struct bpf_func_proto bpf_get_socket_cookie_sock_proto = {
  5105		.func		= bpf_get_socket_cookie_sock,
  5106		.gpl_only	= false,
  5107		.ret_type	= RET_INTEGER,
  5108		.arg1_type	= ARG_PTR_TO_CTX,
  5109	};
  5110	
  5111	BPF_CALL_1(bpf_get_socket_ptr_cookie, struct sock *, sk)
  5112	{
  5113		return sk ? sock_gen_cookie(sk) : 0;
  5114	}
  5115	
  5116	const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto = {
  5117		.func		= bpf_get_socket_ptr_cookie,
  5118		.gpl_only	= false,
  5119		.ret_type	= RET_INTEGER,
  5120		.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON | PTR_MAYBE_NULL,
  5121	};
  5122	
  5123	BPF_CALL_1(bpf_get_socket_cookie_sock_ops, struct bpf_sock_ops_kern *, ctx)
  5124	{
  5125		return __sock_gen_cookie(ctx->sk);
  5126	}
  5127	
  5128	static const struct bpf_func_proto bpf_get_socket_cookie_sock_ops_proto = {
  5129		.func		= bpf_get_socket_cookie_sock_ops,
  5130		.gpl_only	= false,
  5131		.ret_type	= RET_INTEGER,
  5132		.arg1_type	= ARG_PTR_TO_CTX,
  5133	};
  5134	
  5135	static u64 __bpf_get_netns_cookie(struct sock *sk)
  5136	{
  5137		const struct net *net = sk ? sock_net(sk) : &init_net;
  5138	
  5139		return net->net_cookie;
  5140	}
  5141	
  5142	BPF_CALL_1(bpf_get_netns_cookie, struct sk_buff *, skb)
  5143	{
  5144		return __bpf_get_netns_cookie(skb && skb->sk ? skb->sk : NULL);
  5145	}
  5146	
  5147	static const struct bpf_func_proto bpf_get_netns_cookie_proto = {
  5148		.func           = bpf_get_netns_cookie,
  5149		.ret_type       = RET_INTEGER,
  5150		.arg1_type      = ARG_PTR_TO_CTX_OR_NULL,
  5151	};
  5152	
  5153	BPF_CALL_1(bpf_get_netns_cookie_sock, struct sock *, ctx)
  5154	{
  5155		return __bpf_get_netns_cookie(ctx);
  5156	}
  5157	
  5158	static const struct bpf_func_proto bpf_get_netns_cookie_sock_proto = {
  5159		.func		= bpf_get_netns_cookie_sock,
  5160		.gpl_only	= false,
  5161		.ret_type	= RET_INTEGER,
  5162		.arg1_type	= ARG_PTR_TO_CTX_OR_NULL,
  5163	};
  5164	
  5165	BPF_CALL_1(bpf_get_netns_cookie_sock_addr, struct bpf_sock_addr_kern *, ctx)
  5166	{
  5167		return __bpf_get_netns_cookie(ctx ? ctx->sk : NULL);
  5168	}
  5169	
  5170	static const struct bpf_func_proto bpf_get_netns_cookie_sock_addr_proto = {
  5171		.func		= bpf_get_netns_cookie_sock_addr,
  5172		.gpl_only	= false,
  5173		.ret_type	= RET_INTEGER,
  5174		.arg1_type	= ARG_PTR_TO_CTX_OR_NULL,
  5175	};
  5176	
  5177	BPF_CALL_1(bpf_get_netns_cookie_sock_ops, struct bpf_sock_ops_kern *, ctx)
  5178	{
  5179		return __bpf_get_netns_cookie(ctx ? ctx->sk : NULL);
  5180	}
  5181	
  5182	static const struct bpf_func_proto bpf_get_netns_cookie_sock_ops_proto = {
  5183		.func		= bpf_get_netns_cookie_sock_ops,
  5184		.gpl_only	= false,
  5185		.ret_type	= RET_INTEGER,
  5186		.arg1_type	= ARG_PTR_TO_CTX_OR_NULL,
  5187	};
  5188	
  5189	BPF_CALL_1(bpf_get_netns_cookie_sk_msg, struct sk_msg *, ctx)
  5190	{
  5191		return __bpf_get_netns_cookie(ctx ? ctx->sk : NULL);
  5192	}
  5193	
  5194	static const struct bpf_func_proto bpf_get_netns_cookie_sk_msg_proto = {
  5195		.func		= bpf_get_netns_cookie_sk_msg,
  5196		.gpl_only	= false,
  5197		.ret_type	= RET_INTEGER,
  5198		.arg1_type	= ARG_PTR_TO_CTX_OR_NULL,
  5199	};
  5200	
  5201	BPF_CALL_1(bpf_get_socket_uid, struct sk_buff *, skb)
  5202	{
  5203		struct sock *sk = sk_to_full_sk(skb->sk);
  5204		kuid_t kuid;
  5205	
  5206		if (!sk || !sk_fullsock(sk))
  5207			return overflowuid;
  5208		kuid = sock_net_uid(sock_net(sk), sk);
  5209		return from_kuid_munged(sock_net(sk)->user_ns, kuid);
  5210	}
  5211	
  5212	static const struct bpf_func_proto bpf_get_socket_uid_proto = {
  5213		.func           = bpf_get_socket_uid,
  5214		.gpl_only       = false,
  5215		.ret_type       = RET_INTEGER,
  5216		.arg1_type      = ARG_PTR_TO_CTX,
  5217	};
  5218	
  5219	static int sk_bpf_set_cb_flags(struct sock *sk, sockptr_t optval, bool getopt)
  5220	{
  5221		int sk_bpf_cb_flags;
  5222	
  5223		if (getopt)
  5224			return -EINVAL;
  5225	
  5226		if (copy_from_sockptr(&sk_bpf_cb_flags, optval, sizeof(sk_bpf_cb_flags)))
  5227			return -EFAULT;
  5228	
  5229		if (sk_bpf_cb_flags & ~SK_BPF_CB_MASK)
  5230			return -EINVAL;
  5231	
> 5232		sk->sk_bpf_cb_flags = sk_bpf_cb_flags;
  5233	
  5234		return 0;
  5235	}
  5236	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

