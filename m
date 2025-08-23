Return-Path: <bpf+bounces-66372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A96DB32C9D
	for <lists+bpf@lfdr.de>; Sun, 24 Aug 2025 01:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560DA3BE0E8
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 23:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1435F2D7DDB;
	Sat, 23 Aug 2025 23:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HbE3MS0o"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF312192B7D;
	Sat, 23 Aug 2025 23:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755993560; cv=none; b=ZPtUsMhqIBflqZTxhTqtiaAHPtY+tfeT2i6bq4jcZ1nW4nseXCtZxoHXNTqRpHZ9Ry9BpweR3WUe79NEol74NqYNqwR6+3a2Oc87QU3xMtFx8pzF16WzpsBrhV7VBHiZRqFhstGXTP2arSv+DidqX2YUy+OcEuPns7l0ryteO+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755993560; c=relaxed/simple;
	bh=w2cA3bdxWk74x40XqEhRqPOGCRlrl1fklqZbfR2uSY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQikIR4aWwC03dG/Wr1SIMon72Y3VpwOO2YeyRwIhMAQL6UePOBzajW6nW/Bu3LZHQZPVP5ACg94SLJ49KkysnTSq+HDl4ToYoYiLsZCCUP+FdT8TJ2hbMerpYLQ5OGcbvWC9dgQM5G427RnfkIPdwWifxuz768j+Cg2+7OESS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HbE3MS0o; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755993559; x=1787529559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w2cA3bdxWk74x40XqEhRqPOGCRlrl1fklqZbfR2uSY4=;
  b=HbE3MS0oF3vMT5YcINpF7QRTM5n3fSVgFYbGXoLS4BXRxIsNtZ8U0BeE
   K7Fzl1JEER38Kq6BrAeCebXtfoRqzNR/srtzFd90ajIqsX093TzvzTJ5S
   OFwotdRPU4fBCaqtMgTDC9hWKTCSBqExm8v83dA6+7q0SqAdJR+aAgoiT
   PAjcNE3BsmDlcSRE25UP+Gr2d/x21fC/pmEm6CK1NKjU/3gkafz8huHEE
   WJ2obyItYcfERM7xL0AQi3xwIPNv7QRKIykKIjlxDGMBVhDc3C64Ohpz8
   tZBbxK4yObC7mv325hemPQT6OprSSVNlhjv4uA7a7g6liOecfdizHnDua
   A==;
X-CSE-ConnectionGUID: DFzB+N4ITfS4iiYvTQ8wfw==
X-CSE-MsgGUID: ixTmRnZPSbi6xbtyqf9eCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62069293"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62069293"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 16:59:18 -0700
X-CSE-ConnectionGUID: xmPdUvB1RGqfRAd93+Ihww==
X-CSE-MsgGUID: 9aaYefKBTdiezdASp+RaZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="206147438"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 23 Aug 2025 16:59:13 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upy8c-000Mf9-2H;
	Sat, 23 Aug 2025 23:59:10 +0000
Date: Sun, 24 Aug 2025 07:58:55 +0800
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
Subject: Re: [PATCH v1 bpf-next/net 5/8] bpf: Support bpf_setsockopt() for
 BPF_CGROUP_INET_SOCK_(CREATE|ACCEPT).
Message-ID: <202508240731.UPB4k4Uo-lkp@intel.com>
References: <20250822221846.744252-6-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822221846.744252-6-kuniyu@google.com>

Hi Kuniyuki,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/net]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/tcp-Save-lock_sock-for-memcg-in-inet_csk_accept/20250823-062322
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250822221846.744252-6-kuniyu%40google.com
patch subject: [PATCH v1 bpf-next/net 5/8] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_(CREATE|ACCEPT).
config: arm-randconfig-r131-20250824 (https://download.01.org/0day-ci/archive/20250824/202508240731.UPB4k4Uo-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250824/202508240731.UPB4k4Uo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508240731.UPB4k4Uo-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/core/filter.c:6322:9: sparse: sparse: switch with no cases
   net/core/filter.c:6363:9: sparse: sparse: switch with no cases
   net/core/filter.c:1440:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sock_filter const *filter @@     got struct sock_filter [noderef] __user *filter @@
   net/core/filter.c:1440:39: sparse:     expected struct sock_filter const *filter
   net/core/filter.c:1440:39: sparse:     got struct sock_filter [noderef] __user *filter
   net/core/filter.c:1518:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sock_filter const *filter @@     got struct sock_filter [noderef] __user *filter @@
   net/core/filter.c:1518:39: sparse:     expected struct sock_filter const *filter
   net/core/filter.c:1518:39: sparse:     got struct sock_filter [noderef] __user *filter
>> net/core/filter.c:5752:29: sparse: sparse: symbol 'bpf_sock_setsockopt_proto' was not declared. Should it be static?
>> net/core/filter.c:5769:29: sparse: sparse: symbol 'bpf_unlocked_sock_setsockopt_proto' was not declared. Should it be static?
   net/core/filter.c:11166:31: sparse: sparse: symbol 'cg_skb_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:11172:27: sparse: sparse: symbol 'cg_skb_prog_ops' was not declared. Should it be static?
   net/core/filter.c:11216:31: sparse: sparse: symbol 'cg_sock_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:11222:27: sparse: sparse: symbol 'cg_sock_prog_ops' was not declared. Should it be static?
   net/core/filter.c:11225:31: sparse: sparse: symbol 'cg_sock_addr_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:11231:27: sparse: sparse: symbol 'cg_sock_addr_prog_ops' was not declared. Should it be static?
   net/core/filter.c:1948:43: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __wsum [usertype] diff @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1948:43: sparse:     expected restricted __wsum [usertype] diff
   net/core/filter.c:1948:43: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:1951:36: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be16 [usertype] old @@     got unsigned long long [usertype] from @@
   net/core/filter.c:1951:36: sparse:     expected restricted __be16 [usertype] old
   net/core/filter.c:1951:36: sparse:     got unsigned long long [usertype] from
   net/core/filter.c:1951:42: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be16 [usertype] new @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1951:42: sparse:     expected restricted __be16 [usertype] new
   net/core/filter.c:1951:42: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:1954:36: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 [usertype] from @@     got unsigned long long [usertype] from @@
   net/core/filter.c:1954:36: sparse:     expected restricted __be32 [usertype] from
   net/core/filter.c:1954:36: sparse:     got unsigned long long [usertype] from
   net/core/filter.c:1954:42: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be32 [usertype] to @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1954:42: sparse:     expected restricted __be32 [usertype] to
   net/core/filter.c:1954:42: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:2000:59: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __wsum [usertype] diff @@     got unsigned long long [usertype] to @@
   net/core/filter.c:2000:59: sparse:     expected restricted __wsum [usertype] diff
   net/core/filter.c:2000:59: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:2003:52: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be16 [usertype] from @@     got unsigned long long [usertype] from @@
   net/core/filter.c:2003:52: sparse:     expected restricted __be16 [usertype] from
   net/core/filter.c:2003:52: sparse:     got unsigned long long [usertype] from
   net/core/filter.c:2003:58: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __be16 [usertype] to @@     got unsigned long long [usertype] to @@
   net/core/filter.c:2003:58: sparse:     expected restricted __be16 [usertype] to
   net/core/filter.c:2003:58: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:2006:52: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be32 [usertype] from @@     got unsigned long long [usertype] from @@
   net/core/filter.c:2006:52: sparse:     expected restricted __be32 [usertype] from
   net/core/filter.c:2006:52: sparse:     got unsigned long long [usertype] from
   net/core/filter.c:2006:58: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __be32 [usertype] to @@     got unsigned long long [usertype] to @@
   net/core/filter.c:2006:58: sparse:     expected restricted __be32 [usertype] to
   net/core/filter.c:2006:58: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:2073:35: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long long @@     got restricted __wsum [usertype] csum @@
   net/core/filter.c:2073:35: sparse:     expected unsigned long long
   net/core/filter.c:2073:35: sparse:     got restricted __wsum [usertype] csum

vim +/bpf_sock_setsockopt_proto +5752 net/core/filter.c

  5751	
> 5752	const struct bpf_func_proto bpf_sock_setsockopt_proto = {
  5753		.func		= bpf_sock_setsockopt,
  5754		.gpl_only	= false,
  5755		.ret_type	= RET_INTEGER,
  5756		.arg1_type	= ARG_PTR_TO_CTX,
  5757		.arg2_type	= ARG_ANYTHING,
  5758		.arg3_type	= ARG_ANYTHING,
  5759		.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
  5760		.arg5_type	= ARG_CONST_SIZE,
  5761	};
  5762	
  5763	BPF_CALL_5(bpf_unlocked_sock_setsockopt, struct sock *, sk, int, level,
  5764		   int, optname, char *, optval, int, optlen)
  5765	{
  5766		return _bpf_setsockopt(sk, level, optname, optval, optlen);
  5767	}
  5768	
> 5769	const struct bpf_func_proto bpf_unlocked_sock_setsockopt_proto = {
  5770		.func		= bpf_unlocked_sock_setsockopt,
  5771		.gpl_only	= false,
  5772		.ret_type	= RET_INTEGER,
  5773		.arg1_type	= ARG_PTR_TO_CTX,
  5774		.arg2_type	= ARG_ANYTHING,
  5775		.arg3_type	= ARG_ANYTHING,
  5776		.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
  5777		.arg5_type	= ARG_CONST_SIZE,
  5778	};
  5779	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

