Return-Path: <bpf+bounces-15502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8317F2535
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 06:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2CC1C20F1B
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 05:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC7D18C2A;
	Tue, 21 Nov 2023 05:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gepj/oud"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098FBE7;
	Mon, 20 Nov 2023 21:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700544106; x=1732080106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U/vzE5xUw7htLBY4ClpNy7HJvmH36d/i2p290QfaiAQ=;
  b=Gepj/oud+COkOXxPlZtd0IeNCocTwgp0HuzEvfvGF2de4/qHb6J02DIp
   d0OdU2HClZPc/6hvwv2DY1iByMILqwvBXvg/JiMc5psxFMWbaqYmyB9XP
   IrlX5P8vc1NjeW6Al3sjVpUP5G6YVt5b5T/AfN6PpwrkOik1Hp9ItMQlA
   x2gMlIqe6t4Uh4R4V5AmMeFY9B8fkNPh6gOflcRPTyIBOAcNqYBOV0pwW
   Xh0AQSQhJf405IEy3qyv6Fv0PEEtHDIhCSfWCdS8YSIzjeAiGFfAoiphZ
   20fkQiFZtfMP7OtQSz5C8rXbiWJ5jmvxuO2oHD0qYyhKQVBlLuX9OE6Bm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="458263438"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="458263438"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 21:21:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="7781920"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 20 Nov 2023 21:21:40 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5JCY-0007Ky-1x;
	Tue, 21 Nov 2023 05:21:34 +0000
Date: Tue, 21 Nov 2023 13:17:40 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 10/11] bpf: tcp: Support arbitrary SYN Cookie.
Message-ID: <202311211310.E8pJEsnT-lkp@intel.com>
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
config: arm-spear3xx_defconfig (https://download.01.org/0day-ci/archive/20231121/202311211310.E8pJEsnT-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211310.E8pJEsnT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311211310.E8pJEsnT-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/core/sock.c:142:
   In file included from include/net/tcp.h:32:
>> include/net/inet_hashtables.h:472:22: error: use of undeclared identifier 'sock_pfree'
                           skb->destructor = sock_pfree;
                                             ^
   1 error generated.
--
   In file included from net/core/filter.c:39:
   In file included from include/linux/skmsg.h:13:
   In file included from include/net/tcp.h:32:
>> include/net/inet_hashtables.h:472:22: error: use of undeclared identifier 'sock_pfree'
                           skb->destructor = sock_pfree;
                                             ^
   net/core/filter.c:11812:13: warning: declaration of 'struct tcp_cookie_attributes' will not be visible outside of this function [-Wvisibility]
                                           struct tcp_cookie_attributes *attr,
                                                  ^
   net/core/filter.c:11821:24: error: invalid application of 'sizeof' to an incomplete type 'struct tcp_cookie_attributes'
           if (attr__sz != sizeof(*attr))
                                 ^~~~~~~
   net/core/filter.c:11812:13: note: forward declaration of 'struct tcp_cookie_attributes'
                                           struct tcp_cookie_attributes *attr,
                                                  ^
   net/core/filter.c:11851:10: error: incomplete definition of type 'struct tcp_cookie_attributes'
           if (attr->tcp_opt.mss_clamp < min_mss) {
               ~~~~^
   net/core/filter.c:11812:13: note: forward declaration of 'struct tcp_cookie_attributes'
                                           struct tcp_cookie_attributes *attr,
                                                  ^
   net/core/filter.c:11856:10: error: incomplete definition of type 'struct tcp_cookie_attributes'
           if (attr->tcp_opt.wscale_ok &&
               ~~~~^
   net/core/filter.c:11812:13: note: forward declaration of 'struct tcp_cookie_attributes'
                                           struct tcp_cookie_attributes *attr,
                                                  ^
   net/core/filter.c:11857:10: error: incomplete definition of type 'struct tcp_cookie_attributes'
               attr->tcp_opt.snd_wscale > TCP_MAX_WSCALE) {
               ~~~~^
   net/core/filter.c:11812:13: note: forward declaration of 'struct tcp_cookie_attributes'
                                           struct tcp_cookie_attributes *attr,
                                                  ^
   net/core/filter.c:11875:17: error: incomplete definition of type 'struct tcp_cookie_attributes'
           req->mss = attr->tcp_opt.mss_clamp;
                      ~~~~^
   net/core/filter.c:11812:13: note: forward declaration of 'struct tcp_cookie_attributes'
                                           struct tcp_cookie_attributes *attr,
                                                  ^
   net/core/filter.c:11877:25: error: incomplete definition of type 'struct tcp_cookie_attributes'
           ireq->snd_wscale = attr->tcp_opt.snd_wscale;
                              ~~~~^
   net/core/filter.c:11812:13: note: forward declaration of 'struct tcp_cookie_attributes'
                                           struct tcp_cookie_attributes *attr,
                                                  ^
   net/core/filter.c:11878:24: error: incomplete definition of type 'struct tcp_cookie_attributes'
           ireq->wscale_ok = attr->tcp_opt.wscale_ok;
                             ~~~~^
   net/core/filter.c:11812:13: note: forward declaration of 'struct tcp_cookie_attributes'
                                           struct tcp_cookie_attributes *attr,
                                                  ^
   net/core/filter.c:11879:24: error: incomplete definition of type 'struct tcp_cookie_attributes'
           ireq->tstamp_ok = attr->tcp_opt.tstamp_ok;
                             ~~~~^
   net/core/filter.c:11812:13: note: forward declaration of 'struct tcp_cookie_attributes'
                                           struct tcp_cookie_attributes *attr,
                                                  ^
   net/core/filter.c:11880:22: error: incomplete definition of type 'struct tcp_cookie_attributes'
           ireq->sack_ok = attr->tcp_opt.sack_ok;
                           ~~~~^
   net/core/filter.c:11812:13: note: forward declaration of 'struct tcp_cookie_attributes'
                                           struct tcp_cookie_attributes *attr,
                                                  ^
   net/core/filter.c:11881:21: error: incomplete definition of type 'struct tcp_cookie_attributes'
           ireq->ecn_ok = attr->ecn_ok;
                          ~~~~^
   net/core/filter.c:11812:13: note: forward declaration of 'struct tcp_cookie_attributes'
                                           struct tcp_cookie_attributes *attr,
                                                  ^
   net/core/filter.c:11883:26: error: incomplete definition of type 'struct tcp_cookie_attributes'
           treq->req_usec_ts = attr->usec_ts_ok;
                               ~~~~^
   net/core/filter.c:11812:13: note: forward declaration of 'struct tcp_cookie_attributes'
                                           struct tcp_cookie_attributes *attr,
                                                  ^
>> net/core/filter.c:11887:20: error: use of undeclared identifier 'sock_pfree'
           skb->destructor = sock_pfree;
                             ^
   1 warning and 13 errors generated.


vim +/sock_pfree +472 include/net/inet_hashtables.h

   451	
   452	static inline
   453	struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int doff,
   454				     const __be32 saddr, const __be16 sport,
   455				     const __be32 daddr, const __be16 dport,
   456				     bool *refcounted, inet_ehashfn_t *ehashfn)
   457	{
   458		struct sock *sk, *reuse_sk;
   459		bool prefetched;
   460	
   461		sk = skb_steal_sock(skb, refcounted, &prefetched);
   462		if (!sk)
   463			return NULL;
   464	
   465		if (!prefetched)
   466			return sk;
   467	
   468		if (sk->sk_state == TCP_NEW_SYN_RECV) {
   469			if (inet_reqsk(sk)->syncookie) {
   470				*refcounted = false;
   471				skb->sk = sk;
 > 472				skb->destructor = sock_pfree;
   473				return inet_reqsk(sk)->rsk_listener;
   474			}
   475			return sk;
   476		} else if (sk->sk_state == TCP_TIME_WAIT) {
   477			return sk;
   478		}
   479	
   480		if (sk->sk_protocol == IPPROTO_TCP) {
   481			if (sk->sk_state != TCP_LISTEN)
   482				return sk;
   483		} else if (sk->sk_protocol == IPPROTO_UDP) {
   484			if (sk->sk_state != TCP_CLOSE)
   485				return sk;
   486		} else {
   487			return sk;
   488		}
   489	
   490		reuse_sk = inet_lookup_reuseport(net, sk, skb, doff,
   491						 saddr, sport, daddr, ntohs(dport),
   492						 ehashfn);
   493		if (!reuse_sk)
   494			return sk;
   495	
   496		/* We've chosen a new reuseport sock which is never refcounted. This
   497		 * implies that sk also isn't refcounted.
   498		 */
   499		WARN_ON_ONCE(*refcounted);
   500	
   501		return reuse_sk;
   502	}
   503	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

