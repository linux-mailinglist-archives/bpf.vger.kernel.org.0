Return-Path: <bpf+bounces-18078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B81C815718
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 04:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F781F23B13
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 03:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEBB6AD8;
	Sat, 16 Dec 2023 03:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dEQDETk6"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198F146A7;
	Sat, 16 Dec 2023 03:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702698007; x=1734234007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7R/IuFR5FZNJvpmjLiBZEn2SwykJelg8Grq1wWQdd9Y=;
  b=dEQDETk6W6HDz9AlBinQFSSWuFDVgUXvnUdgCTEQAZYUok724wnGX+p0
   tg4t3kQImdGzZGRcL3u6HZOqC+S4fYaQzfi74MXvOwmQ+Jl25CACdbRGC
   RDmn486x+2Xt+SczlOI2jDHTlWVNVgnpXQOCqcqc+nzfhblv3cqA8TV5J
   LdZGzdUlq8UuB02aaG0P6dR7gDjCOOLIPAvIqF+Za+kwbdkgO9UjFhyNk
   vvRB3HaeMnVJP9fUMQpDiPMjxNcyzg3ZCtAtemmQLk3qKqP+Xmqh1GbtI
   Iu+Uy8iyPXTOFgpufAD1Al1wtAKzEp/vLemdHY9jCr5ixbVf2iwoKfrJx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="394230250"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="394230250"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 19:40:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="840865507"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="840865507"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 15 Dec 2023 19:39:59 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rELWv-00016a-0V;
	Sat, 16 Dec 2023 03:39:57 +0000
Date: Sat, 16 Dec 2023 11:39:29 +0800
From: kernel test robot <lkp@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	David Ahern <dsahern@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 12/24] seg6: Use nested-BH locking for
 seg6_bpf_srh_states.
Message-ID: <202312161151.k1MBvXUD-lkp@intel.com>
References: <20231215171020.687342-13-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215171020.687342-13-bigeasy@linutronix.de>

Hi Sebastian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Andrzej-Siewior/locking-local_lock-Introduce-guard-definition-for-local_lock/20231216-011911
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231215171020.687342-13-bigeasy%40linutronix.de
patch subject: [PATCH net-next 12/24] seg6: Use nested-BH locking for seg6_bpf_srh_states.
config: x86_64-randconfig-r131-20231216 (https://download.01.org/0day-ci/archive/20231216/202312161151.k1MBvXUD-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312161151.k1MBvXUD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312161151.k1MBvXUD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/ipv6/seg6_local.c:1431:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct local_lock_t [usertype] *l @@     got struct local_lock_t [noderef] __percpu * @@
   net/ipv6/seg6_local.c:1431:9: sparse:     expected struct local_lock_t [usertype] *l
   net/ipv6/seg6_local.c:1431:9: sparse:     got struct local_lock_t [noderef] __percpu *

vim +1431 net/ipv6/seg6_local.c

  1410	
  1411	static int input_action_end_bpf(struct sk_buff *skb,
  1412					struct seg6_local_lwt *slwt)
  1413	{
  1414		struct seg6_bpf_srh_state *srh_state;
  1415		struct ipv6_sr_hdr *srh;
  1416		int ret;
  1417	
  1418		srh = get_and_validate_srh(skb);
  1419		if (!srh) {
  1420			kfree_skb(skb);
  1421			return -EINVAL;
  1422		}
  1423		advance_nextseg(srh, &ipv6_hdr(skb)->daddr);
  1424	
  1425		/* The access to the per-CPU buffer srh_state is protected by running
  1426		 * always in softirq context (with disabled BH). On PREEMPT_RT the
  1427		 * required locking is provided by the following local_lock_nested_bh()
  1428		 * statement. It is also accessed by the bpf_lwt_seg6_* helpers via
  1429		 * bpf_prog_run_save_cb().
  1430		 */
> 1431		scoped_guard(local_lock_nested_bh, &seg6_bpf_srh_states.bh_lock) {
  1432			srh_state = this_cpu_ptr(&seg6_bpf_srh_states);
  1433			srh_state->srh = srh;
  1434			srh_state->hdrlen = srh->hdrlen << 3;
  1435			srh_state->valid = true;
  1436	
  1437			rcu_read_lock();
  1438			bpf_compute_data_pointers(skb);
  1439			ret = bpf_prog_run_save_cb(slwt->bpf.prog, skb);
  1440			rcu_read_unlock();
  1441	
  1442			switch (ret) {
  1443			case BPF_OK:
  1444			case BPF_REDIRECT:
  1445				break;
  1446			case BPF_DROP:
  1447				goto drop;
  1448			default:
  1449				pr_warn_once("bpf-seg6local: Illegal return value %u\n", ret);
  1450				goto drop;
  1451			}
  1452	
  1453			if (srh_state->srh && !seg6_bpf_has_valid_srh(skb))
  1454				goto drop;
  1455		}
  1456	
  1457		if (ret != BPF_REDIRECT)
  1458			seg6_lookup_nexthop(skb, NULL, 0);
  1459	
  1460		return dst_input(skb);
  1461	
  1462	drop:
  1463		kfree_skb(skb);
  1464		return -EINVAL;
  1465	}
  1466	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

