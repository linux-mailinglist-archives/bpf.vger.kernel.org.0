Return-Path: <bpf+bounces-15499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7705E7F24FF
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 06:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E8528286A
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 05:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B53168CC;
	Tue, 21 Nov 2023 05:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZYveiw3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65B5E8;
	Mon, 20 Nov 2023 21:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700543220; x=1732079220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xsJ2jdm5gaiq6XhW9D52xVPjBy5soH7QBVayFGPR96Q=;
  b=QZYveiw3FAVARNL2T4mLjy59qnvWumzBuU6LThbvDc/+Ajbu4EZC7Clg
   7/cnlWQHS1/3XVnxGuY3NjyDfGXUk+PLVYfv95u8AkZfnpzRcMXpGZ/JZ
   VMZ2Bpl3Zf+9uwf3zIFtJqqcTDT6ez/kS8W0PNh2pyOeRwHJwCKH8WGJu
   ZOESkYseOmpavN+Xm+nzec1PnGpixxulvBNZ8ocJPN69mCd1bhozVZIy6
   5D+1wIe10roA+Y0RrqqMM/Ywk/wrD5MgtbtnUUgKapOZSto737MhI9hpu
   l8hEitlIU7Y8TOh02LXD2l1OQrNd/U744d1uQnux/HOHeiKNRGWiY0Izi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371937475"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="371937475"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 21:07:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="836946215"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="836946215"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 20 Nov 2023 21:06:55 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5IyL-0007KM-0p;
	Tue, 21 Nov 2023 05:06:53 +0000
Date: Tue, 21 Nov 2023 13:06:23 +0800
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
Message-ID: <202311211229.8GAmfTPp-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/tcp-Clean-up-reverse-xmas-tree-in-cookie_v-46-_check/20231121-063036
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231120222341.54776-11-kuniyu%40amazon.com
patch subject: [PATCH v2 bpf-next 10/11] bpf: tcp: Support arbitrary SYN Cookie.
config: arm-randconfig-001-20231121 (https://download.01.org/0day-ci/archive/20231121/202311211229.8GAmfTPp-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211229.8GAmfTPp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311211229.8GAmfTPp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/core/filter.c:11812:48: warning: 'struct tcp_cookie_attributes' declared inside parameter list will not be visible outside of this definition or declaration
   11812 |                                         struct tcp_cookie_attributes *attr,
         |                                                ^~~~~~~~~~~~~~~~~~~~~
   net/core/filter.c: In function 'bpf_sk_assign_tcp_reqsk':
   net/core/filter.c:11821:31: error: invalid application of 'sizeof' to incomplete type 'struct tcp_cookie_attributes'
   11821 |         if (attr__sz != sizeof(*attr))
         |                               ^
   net/core/filter.c:11851:17: error: invalid use of undefined type 'struct tcp_cookie_attributes'
   11851 |         if (attr->tcp_opt.mss_clamp < min_mss) {
         |                 ^~
   net/core/filter.c:11856:17: error: invalid use of undefined type 'struct tcp_cookie_attributes'
   11856 |         if (attr->tcp_opt.wscale_ok &&
         |                 ^~
   net/core/filter.c:11857:17: error: invalid use of undefined type 'struct tcp_cookie_attributes'
   11857 |             attr->tcp_opt.snd_wscale > TCP_MAX_WSCALE) {
         |                 ^~
   net/core/filter.c:11875:24: error: invalid use of undefined type 'struct tcp_cookie_attributes'
   11875 |         req->mss = attr->tcp_opt.mss_clamp;
         |                        ^~
   net/core/filter.c:11877:32: error: invalid use of undefined type 'struct tcp_cookie_attributes'
   11877 |         ireq->snd_wscale = attr->tcp_opt.snd_wscale;
         |                                ^~
   net/core/filter.c:11878:31: error: invalid use of undefined type 'struct tcp_cookie_attributes'
   11878 |         ireq->wscale_ok = attr->tcp_opt.wscale_ok;
         |                               ^~
   net/core/filter.c:11879:31: error: invalid use of undefined type 'struct tcp_cookie_attributes'
   11879 |         ireq->tstamp_ok = attr->tcp_opt.tstamp_ok;
         |                               ^~
   net/core/filter.c:11880:29: error: invalid use of undefined type 'struct tcp_cookie_attributes'
   11880 |         ireq->sack_ok = attr->tcp_opt.sack_ok;
         |                             ^~
   net/core/filter.c:11881:28: error: invalid use of undefined type 'struct tcp_cookie_attributes'
   11881 |         ireq->ecn_ok = attr->ecn_ok;
         |                            ^~
   net/core/filter.c:11883:33: error: invalid use of undefined type 'struct tcp_cookie_attributes'
   11883 |         treq->req_usec_ts = attr->usec_ts_ok;
         |                                 ^~


vim +11812 net/core/filter.c

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

