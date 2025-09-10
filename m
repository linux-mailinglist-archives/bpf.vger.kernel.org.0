Return-Path: <bpf+bounces-68010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15826B51641
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 13:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5682565A9B
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 11:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D7A31196F;
	Wed, 10 Sep 2025 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0OAgWT2"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAC6245031;
	Wed, 10 Sep 2025 11:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757505499; cv=none; b=Lqt60MO3l3+PHh3egtCxIQIsLJfURrtIaQaFkyhTepF4pcCK4cgORXu/dr//1g10ttk4x8XDXOY3+zj0pfLChL3X3tfLpRVj6kqUrdetlxF2Vv8yccZ6BqucapFdZB8fl+lUV3C6JwJb2pTri8rN2Cjxq7huvlw8OVqoQ1nA3p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757505499; c=relaxed/simple;
	bh=YgHoSlMyGCwyBPFYKxKiq0pYJf9NvlcVUq+xwRtrf+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3dKk5eBeewHuIkhOuHlt7hceeJmr6qOHAmW62ishS8QlcPFoPRuGsqZUYWAZk5DmxQdDFzAqZUK1SPMD4trL1KUOp2W2P/0jije1pMDDJVsVuiQQNNMP9A0YWIk3fMg17sF3QIocdO2K46ysJzL3y1q3YbHs/uo2JctFHO8pW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0OAgWT2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757505497; x=1789041497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YgHoSlMyGCwyBPFYKxKiq0pYJf9NvlcVUq+xwRtrf+A=;
  b=T0OAgWT2AL/hoKfqv5/oLH6WCUNCMiMLn7XW96OQWgxobdOb5UtL36+z
   CNXacYawLAlL0lgxnlTcVyKMxwQxVxTErD6aVS2nBrBTxdq3nEL1GhIRa
   RL7NSAsW9rID1TZAixao1CYxfp57PRs4TtHAbqFyyoT/BkrFzYgajtBhJ
   Ad8x5I09kllYFXg0yBwqnEwkSw1oQgc1SsTkhDH9ge5a9LqwWvKikOMVA
   CHWk7hSPMAzLooBPySvisdlmkA2ng4tFf37sdVFLl689FpgQMN7bLF4BJ
   TZQoQshcCDJOyLMqAFTMAzc/bn55mn3N0ytol4qXabgNdlWRvPncGa7Ch
   Q==;
X-CSE-ConnectionGUID: 24rspeXyRDqlMEiGNndBdA==
X-CSE-MsgGUID: BBK3fxuLQy6wCE9teVD9Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="70911868"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="70911868"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 04:58:15 -0700
X-CSE-ConnectionGUID: cQXzNYOUQDyxOUWUNGJnrQ==
X-CSE-MsgGUID: mP/ModIiRNmkZaym8tqETw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="197042998"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 10 Sep 2025 04:58:11 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwJSi-0005tf-1K;
	Wed, 10 Sep 2025 11:58:08 +0000
Date: Wed, 10 Sep 2025 19:57:39 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
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
Subject: Re: [PATCH v7 bpf-next/net 3/6] net-memcg: Introduce
 net.core.memcg_exclusive sysctl.
Message-ID: <202509101912.ROjtP2uL-lkp@intel.com>
References: <20250909204632.3994767-4-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909204632.3994767-4-kuniyu@google.com>

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/tcp-Save-lock_sock-for-memcg-in-inet_csk_accept/20250910-044928
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250909204632.3994767-4-kuniyu%40google.com
patch subject: [PATCH v7 bpf-next/net 3/6] net-memcg: Introduce net.core.memcg_exclusive sysctl.
config: um-randconfig-001-20250910 (https://download.01.org/0day-ci/archive/20250910/202509101912.ROjtP2uL-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7fb1dc08d2f025aad5777bb779dfac1197e9ef87)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250910/202509101912.ROjtP2uL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509101912.ROjtP2uL-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: warning: .tmp_vmlinux1 has a LOAD segment with RWX permissions
   /usr/bin/ld: mm/memcontrol.o: in function `mem_cgroup_sk_set':
>> memcontrol.c:(.text+0xa1e0): undefined reference to `init_net'
   clang: error: linker command failed with exit code 1 (use -v to see invocation)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

