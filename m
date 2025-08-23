Return-Path: <bpf+bounces-66367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00C9B329A9
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 17:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5904A7A38B1
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 15:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C642E7F39;
	Sat, 23 Aug 2025 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dtuglmsZ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F4F2E7BDC;
	Sat, 23 Aug 2025 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755963536; cv=none; b=Gv+6yWjFxus0d0BK2NAtBLztwMT2mCYPpWObnieY5Jg1bDMUXSquxs0RciiXtdngeLcOpyylVg2LEtPb/1NJ3MiJbYTYWD8QMcwXqj3U8zjRbVh+oaR68Ijti9gXZpReeeDEaqSL2trsAeTpRuSSp7lCKT48tCBaI+dA+VtEfr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755963536; c=relaxed/simple;
	bh=2CKFaXXEg2LYAIZZ/UOO6SOKp9zzgRvKhyBppqFbZxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxkBxIjJwrhmCWox4h7EzLdeT3FPksvrLk0x4iDH7hCuLsdtk+Fwt8BaWt0A1VnZjQNNtJknurVsIQRiZGvMAvOlbERuuMQEeg/qc1yunor8En0SnMeWZQ+d4xV5H9BaEq8KF5Y9Yv7Ng0/6HHfuJsiqHlpJ5jCKk3AH/OwNHXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dtuglmsZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755963535; x=1787499535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2CKFaXXEg2LYAIZZ/UOO6SOKp9zzgRvKhyBppqFbZxA=;
  b=dtuglmsZ4ghXk+nfKeCQIRZE9gWaWLjqDhrjdGmGSS5kUE9K/S5moBHN
   ckWCok+PlFsl2Xz7V61ZxRyM70Lr4q1Vl7OXU4/imjSQ6Tgs4ddxJTFPZ
   eFwtSqMDby+pz7i2C1D6+D/iOnAgsokS/GjC2fJzm8PvLr3eucRZ4ByE+
   dhyeBvuES6D6Ku2NNLRY85UR2d06VBobcLvtk/eC7HyVcE+vhK4V3rGjM
   Q8PQUtIWZxehxsdYWzi/tIDP3ovuTfnatXTlYZm8KBW2uAS4DIgdYoyKE
   PdgzVOO3ARBh9gSBNnO4Rq4wAYOwnQ7aH/TXIZ35GmR1iUQaje16y9sUo
   Q==;
X-CSE-ConnectionGUID: FnH8i//5QtSoORDvWQp/Hg==
X-CSE-MsgGUID: O2okVptrR2+AVUwkIh3Ycg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="57262174"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="57262174"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 08:38:53 -0700
X-CSE-ConnectionGUID: Wes7r59DTYKOEuQgrvtJNA==
X-CSE-MsgGUID: NoleGkrySXu7qGfTOn6smQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168164859"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 23 Aug 2025 08:38:49 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upqKM-000MNn-0p;
	Sat, 23 Aug 2025 15:38:46 +0000
Date: Sat, 23 Aug 2025 23:38:06 +0800
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
Subject: Re: [PATCH v1 bpf-next/net 6/8] bpf: Introduce SK_BPF_MEMCG_FLAGS
 and SK_BPF_MEMCG_SOCK_ISOLATED.
Message-ID: <202508232331.rxOqu50j-lkp@intel.com>
References: <20250822221846.744252-7-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822221846.744252-7-kuniyu@google.com>

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/tcp-Save-lock_sock-for-memcg-in-inet_csk_accept/20250823-062322
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250822221846.744252-7-kuniyu%40google.com
patch subject: [PATCH v1 bpf-next/net 6/8] bpf: Introduce SK_BPF_MEMCG_FLAGS and SK_BPF_MEMCG_SOCK_ISOLATED.
config: arc-randconfig-002-20250823 (https://download.01.org/0day-ci/archive/20250823/202508232331.rxOqu50j-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250823/202508232331.rxOqu50j-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508232331.rxOqu50j-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/core/filter.c: In function 'sk_bpf_set_get_memcg_flags':
>> net/core/filter.c:5290:9: error: implicit declaration of function 'mem_cgroup_sk_set_flags'; did you mean 'mem_cgroup_sk_get_flags'? [-Werror=implicit-function-declaration]
    5290 |         mem_cgroup_sk_set_flags(sk, *optval);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
         |         mem_cgroup_sk_get_flags
   cc1: some warnings being treated as errors


vim +5290 net/core/filter.c

  5269	
  5270	static int sk_bpf_set_get_memcg_flags(struct sock *sk, int *optval, bool getopt)
  5271	{
  5272		if (!mem_cgroup_sk_enabled(sk))
  5273			return -EOPNOTSUPP;
  5274	
  5275		if (getopt) {
  5276			*optval = mem_cgroup_sk_get_flags(sk);
  5277			return 0;
  5278		}
  5279	
  5280		/* Don't allow once sk has been published to userspace.
  5281		 * INET_CREATE is called without lock_sock() but with sk_socket
  5282		 * INET_ACCEPT is called with lock_sock() but without sk_socket
  5283		 */
  5284		if (sock_owned_by_user_nocheck(sk) && sk->sk_socket)
  5285			return -EBUSY;
  5286	
  5287		if (*optval <= 0 || *optval >= SK_BPF_MEMCG_FLAG_MAX)
  5288			return -EINVAL;
  5289	
> 5290		mem_cgroup_sk_set_flags(sk, *optval);
  5291	
  5292		return 0;
  5293	}
  5294	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

