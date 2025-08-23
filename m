Return-Path: <bpf+bounces-66365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88866B3284D
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 13:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A235B5E5AF8
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 11:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CAC24DFE6;
	Sat, 23 Aug 2025 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2VCbaVG"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1B4242909;
	Sat, 23 Aug 2025 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755946988; cv=none; b=r3M/j4UhZDTN6/uehxac9Y7vpq7pA0TblRxcmKEGKReCqTz8/MvG+O1Q/LfSJl6S8A+cJefDDlf3mAPBX04jHtgqyTRQN8WmQAqvhxOc0FtRAiA+APtiDcMjX17Eop8BoCtTlgSu56n9WsbOGwn8Ak0MBuAMpzjHXujRfvaDu/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755946988; c=relaxed/simple;
	bh=6kGf+TvhXqaSHAVb3yjyK5xzlqwfsC/vzMY1T+lP7iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZI1eQ0T35u0FfqU9vGqGbNB/P4I77uVpRktV1Agc0cza923fUO9Vrcfl2wxUyZncjl8rMZqnAQ5QBgd2UJz26Gnnf6mVBg0u4cTa2TPpYphvX2hEU4Y98O2nVcuyxsTwvGVc8lzdpTxjUM62spss17pH+PrzZ7UQ5A6Mm12ynA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2VCbaVG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755946987; x=1787482987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6kGf+TvhXqaSHAVb3yjyK5xzlqwfsC/vzMY1T+lP7iw=;
  b=V2VCbaVGjfM4wifuQofBMPIobVEq3a4JOIfo+9LbP1Nz7/srfNXdEuUd
   Y551+A3EBfleD8BzHtguaTLoj+80V1LoEeqLon5xfdePuboIfvTRQJNGz
   bWU11QhSFrppuImUEVtCzHEH3cm6+47iqenwCBto3jbsuA7QvfmFofHUB
   19tuDkK8QhZrjLLjrnXCjO7+lQrAbGKE/CpdU0QjXeUB3v6AxZ4LW1Vrt
   y2G4zmeTPU1GjGQw54bTt1oDH+afsvZbenuMtH9MPq0O2mBGw4qO+gpv4
   kvKFrvDxz39Oh8VuZdwz8FnHlyeAaZpdqAr3XnOPYzttxnp29lMR81ahg
   g==;
X-CSE-ConnectionGUID: 8c5JKkouQGCNhuissKtXCQ==
X-CSE-MsgGUID: pWBjltcaTt6qHreaTD6cmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58332603"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58332603"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 04:03:06 -0700
X-CSE-ConnectionGUID: OxcfLRT7S/yAxALmbRJ4Ow==
X-CSE-MsgGUID: OaOBDkmQRC2KMS54laKfSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168121474"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 23 Aug 2025 04:03:01 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upm1T-000MGV-01;
	Sat, 23 Aug 2025 11:02:59 +0000
Date: Sat, 23 Aug 2025 19:02:39 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next/net 2/8] bpf: Add a bpf hook in
 __inet_accept().
Message-ID: <202508231842.8DrS8EwE-lkp@intel.com>
References: <20250822221846.744252-3-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822221846.744252-3-kuniyu@google.com>

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/tcp-Save-lock_sock-for-memcg-in-inet_csk_accept/20250823-062322
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250822221846.744252-3-kuniyu%40google.com
patch subject: [PATCH v1 bpf-next/net 2/8] bpf: Add a bpf hook in __inet_accept().
config: x86_64-buildonly-randconfig-001-20250823 (https://download.01.org/0day-ci/archive/20250823/202508231842.8DrS8EwE-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250823/202508231842.8DrS8EwE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508231842.8DrS8EwE-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/ipv4/af_inet.c: In function '__inet_accept':
>> net/ipv4/af_inet.c:766:9: error: implicit declaration of function 'BPF_CGROUP_RUN_PROG_INET_SOCK_ACCEPT'; did you mean 'BPF_CGROUP_RUN_PROG_INET_SOCK_RELEASE'? [-Werror=implicit-function-declaration]
     766 |         BPF_CGROUP_RUN_PROG_INET_SOCK_ACCEPT(newsk);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         BPF_CGROUP_RUN_PROG_INET_SOCK_RELEASE
   cc1: some warnings being treated as errors


vim +766 net/ipv4/af_inet.c

   753	
   754	void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *newsk)
   755	{
   756		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
   757	
   758		/* TODO: use sk_clone_lock() in SCTP and remove protocol checks */
   759		if (mem_cgroup_sockets_enabled &&
   760		    (!IS_ENABLED(CONFIG_IP_SCTP) ||
   761		     sk_is_tcp(newsk) || sk_is_mptcp(newsk))) {
   762			mem_cgroup_sk_alloc(newsk);
   763			kmem_cache_charge(newsk, gfp);
   764		}
   765	
 > 766		BPF_CGROUP_RUN_PROG_INET_SOCK_ACCEPT(newsk);
   767	
   768		if (mem_cgroup_sk_enabled(newsk)) {
   769			int amt;
   770	
   771			/* The socket has not been accepted yet, no need
   772			 * to look at newsk->sk_wmem_queued.
   773			 */
   774			amt = sk_mem_pages(newsk->sk_forward_alloc +
   775					   atomic_read(&newsk->sk_rmem_alloc));
   776			if (amt)
   777				mem_cgroup_sk_charge(newsk, amt, gfp);
   778		}
   779	
   780		sock_rps_record_flow(newsk);
   781		WARN_ON(!((1 << newsk->sk_state) &
   782			  (TCPF_ESTABLISHED | TCPF_SYN_RECV |
   783			   TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 |
   784			   TCPF_CLOSING | TCPF_CLOSE_WAIT |
   785			   TCPF_CLOSE)));
   786	
   787		if (test_bit(SOCK_SUPPORT_ZC, &sock->flags))
   788			set_bit(SOCK_SUPPORT_ZC, &newsock->flags);
   789		sock_graft(newsk, newsock);
   790	
   791		newsock->state = SS_CONNECTED;
   792	}
   793	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

