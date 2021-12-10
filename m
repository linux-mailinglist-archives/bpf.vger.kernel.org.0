Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401744702D8
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 15:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbhLJOcp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 09:32:45 -0500
Received: from mga03.intel.com ([134.134.136.65]:51220 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234631AbhLJOco (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Dec 2021 09:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639146549; x=1670682549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3C+MVwjjmOatWKtY3ZFoK7khOXGmGx87sWonlywNrqE=;
  b=C4wfZGDA2DcqA2Viu4tELV/kg7iabYo2zMib/h587R1XMcJ22GheXysa
   pbHdBV22MrvaReoK3nt7LiHUNzyXh4IPYjvfs7VjZmI14yb2xJ3LVMqVC
   KH0yHkv/50dt5G58Eu5+bx64IggdWuoXtEMSl2a9f7cvS9q6LPVAdhT0g
   Cj31NPUMNF+3AAJdGzRLkot1WSUu6f6InfGn3NV+BRdave+WDnXfZDabt
   FN8X2SHtcEFhXtAMBcE/WMk49UgielvTbhJ/skycSEE23uV+EZGmaYtto
   uDFatwu5UYSqUuYkRyiqPZwfZhoRqx6Ui8JQLQr2nGno6Mgoxm7hxe4ob
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="238296701"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="238296701"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 06:29:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="612941677"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 10 Dec 2021 06:29:06 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvgtV-0003H6-Hb; Fri, 10 Dec 2021 14:29:05 +0000
Date:   Fri, 10 Dec 2021 22:28:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Maxim Mikityanskiy <maximmi@nvidia.com>,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH bpf-next v3 7/9] net/netfilter: Add unstable CT lookup
 helpers for XDP and TC-BPF
Message-ID: <202112102230.6cj0WCoX-lkp@intel.com>
References: <20211210130230.4128676-8-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210130230.4128676-8-memxor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Kumar,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Kumar-Kartikeya-Dwivedi/Introduce-unstable-CT-lookup-helpers/20211210-210439
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: arc-randconfig-r043-20211210 (https://download.01.org/0day-ci/archive/20211210/202112102230.6cj0WCoX-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/683d78cc594f7867b8dae78b357ab82a5ee69484
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Kumar-Kartikeya-Dwivedi/Introduce-unstable-CT-lookup-helpers/20211210-210439
        git checkout 683d78cc594f7867b8dae78b357ab82a5ee69484
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash net/netfilter/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/netfilter/nf_conntrack_core.c:2566:17: warning: no previous prototype for 'bpf_xdp_ct_lookup' [-Wmissing-prototypes]
    2566 | struct nf_conn *bpf_xdp_ct_lookup(struct xdp_md *xdp_ctx,
         |                 ^~~~~~~~~~~~~~~~~
>> net/netfilter/nf_conntrack_core.c:2610:17: warning: no previous prototype for 'bpf_skb_ct_lookup' [-Wmissing-prototypes]
    2610 | struct nf_conn *bpf_skb_ct_lookup(struct __sk_buff *skb_ctx,
         |                 ^~~~~~~~~~~~~~~~~
>> net/netfilter/nf_conntrack_core.c:2648:6: warning: no previous prototype for 'bpf_ct_release' [-Wmissing-prototypes]
    2648 | void bpf_ct_release(struct nf_conn *nfct)
         |      ^~~~~~~~~~~~~~


vim +/bpf_xdp_ct_lookup +2566 net/netfilter/nf_conntrack_core.c

  2549	
  2550	/* bpf_xdp_ct_lookup - Lookup CT entry for the given tuple, and acquire a
  2551	 *		       reference to it
  2552	 *
  2553	 * Parameters:
  2554	 * @xdp_ctx	- Pointer to ctx (xdp_md) in XDP program
  2555	 *		    Cannot be NULL
  2556	 * @bpf_tuple	- Pointer to memory representing the tuple to look up
  2557	 *		    Cannot be NULL
  2558	 * @len__tuple	- Length of the tuple structure
  2559	 *		    Must be one of sizeof(bpf_tuple->ipv4) or
  2560	 *		    sizeof(bpf_tuple->ipv6)
  2561	 * @opts	- Additional options for lookup (documented above)
  2562	 *		    Cannot be NULL
  2563	 * @len__opts	- Length of the bpf_ct_opts structure
  2564	 *		    Must be NF_BPF_CT_OPTS_SZ (12)
  2565	 */
> 2566	struct nf_conn *bpf_xdp_ct_lookup(struct xdp_md *xdp_ctx,
  2567					  struct bpf_sock_tuple *bpf_tuple,
  2568					  u32 len__tuple, struct bpf_ct_opts *opts,
  2569					  u32 len__opts)
  2570	{
  2571		struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
  2572		struct net *caller_net;
  2573		struct nf_conn *nfct;
  2574	
  2575		BUILD_BUG_ON(sizeof(struct bpf_ct_opts) != NF_BPF_CT_OPTS_SZ);
  2576	
  2577		if (!opts)
  2578			return NULL;
  2579		if (!bpf_tuple || opts->reserved[0] || opts->reserved[1] ||
  2580		    opts->reserved[2] || len__opts != NF_BPF_CT_OPTS_SZ) {
  2581			opts->error = -EINVAL;
  2582			return NULL;
  2583		}
  2584		caller_net = dev_net(ctx->rxq->dev);
  2585		nfct = __bpf_nf_ct_lookup(caller_net, bpf_tuple, len__tuple, opts->l4proto,
  2586					  opts->netns_id);
  2587		if (IS_ERR(nfct)) {
  2588			opts->error = PTR_ERR(nfct);
  2589			return NULL;
  2590		}
  2591		return nfct;
  2592	}
  2593	
  2594	/* bpf_skb_ct_lookup - Lookup CT entry for the given tuple, and acquire a
  2595	 *		       reference to it
  2596	 *
  2597	 * Parameters:
  2598	 * @skb_ctx	- Pointer to ctx (__sk_buff) in TC program
  2599	 *		    Cannot be NULL
  2600	 * @bpf_tuple	- Pointer to memory representing the tuple to look up
  2601	 *		    Cannot be NULL
  2602	 * @len__tuple	- Length of the tuple structure
  2603	 *		    Must be one of sizeof(bpf_tuple->ipv4) or
  2604	 *		    sizeof(bpf_tuple->ipv6)
  2605	 * @opts	- Additional options for lookup (documented above)
  2606	 *		    Cannot be NULL
  2607	 * @len__opts	- Length of the bpf_ct_opts structure
  2608	 *		    Must be NF_BPF_CT_OPTS_SZ (12)
  2609	 */
> 2610	struct nf_conn *bpf_skb_ct_lookup(struct __sk_buff *skb_ctx,
  2611					  struct bpf_sock_tuple *bpf_tuple,
  2612					  u32 len__tuple, struct bpf_ct_opts *opts,
  2613					  u32 len__opts)
  2614	{
  2615		struct sk_buff *skb = (struct sk_buff *)skb_ctx;
  2616		struct net *caller_net;
  2617		struct nf_conn *nfct;
  2618	
  2619		BUILD_BUG_ON(sizeof(struct bpf_ct_opts) != NF_BPF_CT_OPTS_SZ);
  2620	
  2621		if (!opts)
  2622			return NULL;
  2623		if (!bpf_tuple || opts->reserved[0] || opts->reserved[1] ||
  2624		    opts->reserved[2] || len__opts != NF_BPF_CT_OPTS_SZ) {
  2625			opts->error = -EINVAL;
  2626			return NULL;
  2627		}
  2628		caller_net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
  2629		nfct = __bpf_nf_ct_lookup(caller_net, bpf_tuple, len__tuple, opts->l4proto,
  2630					  opts->netns_id);
  2631		if (IS_ERR(nfct)) {
  2632			opts->error = PTR_ERR(nfct);
  2633			return NULL;
  2634		}
  2635		return nfct;
  2636	}
  2637	
  2638	/* bpf_ct_release - Release acquired nf_conn object
  2639	 *
  2640	 * This must be invoked for referenced PTR_TO_BTF_ID, and the verifier rejects
  2641	 * the program if any references remain in the program in all of the explored
  2642	 * states.
  2643	 *
  2644	 * Parameters:
  2645	 * @nf_conn	 - Pointer to referenced nf_conn object, obtained using
  2646	 *		   bpf_xdp_ct_lookup or bpf_skb_ct_lookup.
  2647	 */
> 2648	void bpf_ct_release(struct nf_conn *nfct)
  2649	{
  2650		if (!nfct)
  2651			return;
  2652		nf_ct_put(nfct);
  2653	}
  2654	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
