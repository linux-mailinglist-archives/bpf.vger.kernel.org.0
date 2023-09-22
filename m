Return-Path: <bpf+bounces-10609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB2C7AA72F
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 05:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 89ECB282025
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 03:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC686EDC;
	Fri, 22 Sep 2023 03:00:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8548B64C;
	Fri, 22 Sep 2023 03:00:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C798F;
	Thu, 21 Sep 2023 20:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695351605; x=1726887605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QltdyQ5UE0fnQZfOVgAuavBny+Gjji38QKmh+97005k=;
  b=guFBsH+cY1aGdq7HZoWmOKVja4+BCbJC90HE3MfLB9MGhNGvUYTFTte0
   NsT0FC1/6Jjope8TGCtegDmBhdh8emYkkRFvuZgBuT0o6i4gOBFVzRuP/
   bcXd1VacTyaZsEDRM7wCgj//9etjOJfDC5g+PQdWRLFdtBits97DOPX7v
   1CJVE/ODWxlLTbMQ+5aByWOCi8dT5xH+d9woS8Ty8xe3U44PfNNjeks5C
   +9Mvs7VKViP5WGFAlvqSWo9w7YlMnAN6xdz9Xyg96lLRiNK8c/qORGPQV
   v0Picbh8ynSpPNKEncgic3G2Ldx3t6UYTVsaOk/5FWPCLQZgLT5bhGO2Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="444830854"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="444830854"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 20:00:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="782479798"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="782479798"
Received: from lkp-server02.sh.intel.com (HELO b77866e22201) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 21 Sep 2023 20:00:03 -0700
Received: from kbuild by b77866e22201 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qjWOf-0000j7-0M;
	Fri, 22 Sep 2023 03:00:01 +0000
Date: Fri, 22 Sep 2023 10:59:02 +0800
From: kernel test robot <lkp@intel.com>
To: Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev, kernel-team@meta.com, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 2/9] bpf: Propagate modified uaddrlen from
 cgroup sockaddr programs
Message-ID: <202309221052.Tb6xh9pg-lkp@intel.com>
References: <20230921120913.566702-3-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921120913.566702-3-daan.j.demeyer@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Daan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Daan-De-Meyer/selftests-bpf-Add-missing-section-name-tests-for-getpeername-getsockname/20230922-032515
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230921120913.566702-3-daan.j.demeyer%40gmail.com
patch subject: [PATCH bpf-next v5 2/9] bpf: Propagate modified uaddrlen from cgroup sockaddr programs
config: arm-defconfig (https://download.01.org/0day-ci/archive/20230922/202309221052.Tb6xh9pg-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230922/202309221052.Tb6xh9pg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309221052.Tb6xh9pg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ipv4/af_inet.c: In function 'inet_getname':
>> net/ipv4/af_inet.c:791:13: warning: unused variable 'sin_addr_len' [-Wunused-variable]
     791 |         int sin_addr_len = sizeof(*sin);
         |             ^~~~~~~~~~~~


vim +/sin_addr_len +791 net/ipv4/af_inet.c

   781	
   782	/*
   783	 *	This does both peername and sockname.
   784	 */
   785	int inet_getname(struct socket *sock, struct sockaddr *uaddr,
   786			 int peer)
   787	{
   788		struct sock *sk		= sock->sk;
   789		struct inet_sock *inet	= inet_sk(sk);
   790		DECLARE_SOCKADDR(struct sockaddr_in *, sin, uaddr);
 > 791		int sin_addr_len = sizeof(*sin);
   792	
   793		sin->sin_family = AF_INET;
   794		lock_sock(sk);
   795		if (peer) {
   796			if (!inet->inet_dport ||
   797			    (((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_SYN_SENT)) &&
   798			     peer == 1)) {
   799				release_sock(sk);
   800				return -ENOTCONN;
   801			}
   802			sin->sin_port = inet->inet_dport;
   803			sin->sin_addr.s_addr = inet->inet_daddr;
   804			BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &sin_addr_len,
   805					       CGROUP_INET4_GETPEERNAME);
   806		} else {
   807			__be32 addr = inet->inet_rcv_saddr;
   808			if (!addr)
   809				addr = inet->inet_saddr;
   810			sin->sin_port = inet->inet_sport;
   811			sin->sin_addr.s_addr = addr;
   812			BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &sin_addr_len,
   813					       CGROUP_INET4_GETSOCKNAME);
   814		}
   815		release_sock(sk);
   816		memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
   817		return sizeof(*sin);
   818	}
   819	EXPORT_SYMBOL(inet_getname);
   820	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

