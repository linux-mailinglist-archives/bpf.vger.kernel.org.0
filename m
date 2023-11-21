Return-Path: <bpf+bounces-15503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D5F7F253A
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 06:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9FF71C21914
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 05:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF8918E06;
	Tue, 21 Nov 2023 05:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxgvS25m"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8F3E7;
	Mon, 20 Nov 2023 21:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700544214; x=1732080214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JDM+sJou2R6avgWQNXVVJZe/VBsI2UTfU5lcwqkBEv8=;
  b=kxgvS25mKtRe9/JlVgTFNvytyxWEApSFdEGlM/Imy5KUFrJmFKDkveI4
   cIaBuDTGA1166vITwy4a1nJ458MMUq15cZg6jr7GZrnrnoJD7jB9UxtsJ
   uPXX0X5zDjCGAQsshmVmIzKWU/ojhpOxWoB5ucKQaBpUdjNivx5Xlp6fu
   MUOsAeCuJ3jhAKDjyuJ8prUyv5/jlybdHw2UsMZIGH/eNt8BwH01G8aTE
   v/Uol+I0brzkPtrIJfzWjxvmnkDetOdgvhCSwS15YFoCAUmNz0kEOK0Sr
   n+VvdEnnhQMstypgdXK/FKhfpvv5+4lP6ikB3TR39oQVP2xsqBtVjHPGx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="382160663"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="382160663"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 21:23:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="14793459"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 20 Nov 2023 21:23:29 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5JEJ-0007LQ-21;
	Tue, 21 Nov 2023 05:23:24 +0000
Date: Tue, 21 Nov 2023 13:21:15 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 10/11] bpf: tcp: Support arbitrary SYN Cookie.
Message-ID: <202311211344.cgnPKNbc-lkp@intel.com>
References: <20231120222341.54776-11-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120222341.54776-11-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/tcp-Clean-up-reverse-xmas-tree-in-cookie_v-46-_check/20231121-063036
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231120222341.54776-11-kuniyu%40amazon.com
patch subject: [PATCH v2 bpf-next 10/11] bpf: tcp: Support arbitrary SYN Cookie.
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20231121/202311211344.cgnPKNbc-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211344.cgnPKNbc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311211344.cgnPKNbc-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/core/filter.c:11812:13: warning: 'struct tcp_cookie_attributes' declared inside parameter list will not be visible outside of this definition or declaration
         struct tcp_cookie_attributes *attr,
                ^~~~~~~~~~~~~~~~~~~~~
   net/core/filter.c: In function 'bpf_sk_assign_tcp_reqsk':
>> net/core/filter.c:11821:25: error: dereferencing pointer to incomplete type 'struct tcp_cookie_attributes'
     if (attr__sz != sizeof(*attr))
                            ^~~~~


vim +11821 net/core/filter.c

 11810	
 11811	__bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct sk_buff *skb, struct sock *sk,
 11812						struct tcp_cookie_attributes *attr,
 11813						int attr__sz)
 11814	{
 11815		const struct request_sock_ops *ops;
 11816		struct inet_request_sock *ireq;
 11817		struct tcp_request_sock *treq;
 11818		struct request_sock *req;
 11819		__u16 min_mss;
 11820	
 11821		if (attr__sz != sizeof(*attr))
 11822			return -EINVAL;
 11823	
 11824		if (!sk)
 11825			return -EINVAL;
 11826	
 11827		if (!skb_at_tc_ingress(skb))
 11828			return -EINVAL;
 11829	
 11830		if (dev_net(skb->dev) != sock_net(sk))
 11831			return -ENETUNREACH;
 11832	
 11833		switch (skb->protocol) {
 11834		case htons(ETH_P_IP):
 11835			ops = &tcp_request_sock_ops;
 11836			min_mss = 536;
 11837			break;
 11838	#if IS_BUILTIN(CONFIG_IPV6)
 11839		case htons(ETH_P_IPV6):
 11840			ops = &tcp6_request_sock_ops;
 11841			min_mss = IPV6_MIN_MTU - 60;
 11842			break;
 11843	#endif
 11844		default:
 11845			return -EINVAL;
 11846		}
 11847	
 11848		if (sk->sk_type != SOCK_STREAM || sk->sk_state != TCP_LISTEN)
 11849			return -EINVAL;
 11850	
 11851		if (attr->tcp_opt.mss_clamp < min_mss) {
 11852			__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESFAILED);
 11853			return -EINVAL;
 11854		}
 11855	
 11856		if (attr->tcp_opt.wscale_ok &&
 11857		    attr->tcp_opt.snd_wscale > TCP_MAX_WSCALE) {
 11858			__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESFAILED);
 11859			return -EINVAL;
 11860		}
 11861	
 11862		if (sk_is_mptcp(sk))
 11863			req = mptcp_subflow_reqsk_alloc(ops, sk, false);
 11864		else
 11865			req = inet_reqsk_alloc(ops, sk, false);
 11866	
 11867		if (!req)
 11868			return -ENOMEM;
 11869	
 11870		ireq = inet_rsk(req);
 11871		treq = tcp_rsk(req);
 11872	
 11873		req->syncookie = 1;
 11874		req->rsk_listener = sk;
 11875		req->mss = attr->tcp_opt.mss_clamp;
 11876	
 11877		ireq->snd_wscale = attr->tcp_opt.snd_wscale;
 11878		ireq->wscale_ok = attr->tcp_opt.wscale_ok;
 11879		ireq->tstamp_ok	= attr->tcp_opt.tstamp_ok;
 11880		ireq->sack_ok = attr->tcp_opt.sack_ok;
 11881		ireq->ecn_ok = attr->ecn_ok;
 11882	
 11883		treq->req_usec_ts = attr->usec_ts_ok;
 11884	
 11885		skb_orphan(skb);
 11886		skb->sk = req_to_sk(req);
 11887		skb->destructor = sock_pfree;
 11888	
 11889		return 0;
 11890	}
 11891	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

