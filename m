Return-Path: <bpf+bounces-43352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E759E9B3F74
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 02:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC51E1C21904
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 01:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6836C199B8;
	Tue, 29 Oct 2024 01:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QjMflzLL"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC304EAFA;
	Tue, 29 Oct 2024 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730163943; cv=none; b=UjV1Fg8n9iXOyXQwxqx4pMy+aPjK/VYoJcEeiXABJM/QCqgnznbPmIQgbSjFrjxgza83hnOL+2XpgxgOlrGv3KNH4Mdwsz6vst3JkmJRcBtjXbO/FeaFB4DSf2HRXdnQItRIZApoYNuQkyRNv1bRWwLoHBbXmNjujKssr5sOnNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730163943; c=relaxed/simple;
	bh=M+VRhdqMapP8KDDuQAlS4MNq/YBZkEIPR+/5g6NFM/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQDDwc1SXP/5gq2uMEShP1wyiEBAPTAsPRbzo91WijUf5YVD60V8jEizIWIgWc9DEUCbm7xZyF4cdr2FjZ2PZxu9HCVeq6TLXNyHFeARmEfkun2tHcIzjL/JpU2zwfPwio2zkDU9Etf4H9gmay05ybwIdBRXm4RCksaVoxM+gIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QjMflzLL; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730163941; x=1761699941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M+VRhdqMapP8KDDuQAlS4MNq/YBZkEIPR+/5g6NFM/Q=;
  b=QjMflzLL3IHXSYlZpuepS8yp8tJ9T+z0HUk185PbN354OjeUJCVE52LK
   5FgJQp64ReigZ7wTeNZQefpsfISQ0D9QdQY9CsUt2b4/VglZOiPOSZbb8
   BQoZk1NV4Wx1LH2ku2h4hkuMKLExXvxYHvJuDgrptSayyLm8W2zgRnaEL
   uXZTcjSHUMV3eGDJ2Zncawk8QqXq0bgwfRt72HcWxBvLxmJRCiXmUZ/SN
   VetZB9Kk6cfk9P4XWTlgSDv8wrPvu1wmLbInjLctRwyrIYvIzR77F/br2
   arxnw5AGh3HL8EClYbj913Y5xkb5mxZDyMzJRW//tk3qPzjq78VKCQVg4
   w==;
X-CSE-ConnectionGUID: XgkJ8BWASX+q+U9yAB0PkA==
X-CSE-MsgGUID: v3vmRqrIQzSIeifZ5bQ4kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29216577"
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="29216577"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 18:05:40 -0700
X-CSE-ConnectionGUID: /5wNJOEqToGqpXAT0JYG6g==
X-CSE-MsgGUID: 274QFWMzSGOViE8oo4LeyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="119250597"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 28 Oct 2024 18:05:33 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5afr-000d5A-1o;
	Tue, 29 Oct 2024 01:05:31 +0000
Date: Tue, 29 Oct 2024 09:04:36 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3 04/14] net-timestamp: introduce
 TS_SCHED_OPT_CB to generate dev xmit timestamp
Message-ID: <202410290852.PLcWZ1Yo-lkp@intel.com>
References: <20241028110535.82999-5-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028110535.82999-5-kerneljasonxing@gmail.com>

Hi Jason,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/net-timestamp-reorganize-in-skb_tstamp_tx_output/20241028-192036
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241028110535.82999-5-kerneljasonxing%40gmail.com
patch subject: [PATCH net-next v3 04/14] net-timestamp: introduce TS_SCHED_OPT_CB to generate dev xmit timestamp
config: arm64-randconfig-001-20241029 (https://download.01.org/0day-ci/archive/20241029/202410290852.PLcWZ1Yo-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241029/202410290852.PLcWZ1Yo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410290852.PLcWZ1Yo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/core/skbuff.c:5640:2: error: call to undeclared function 'BPF_CGROUP_RUN_PROG_SOCK_OPS_SK'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    5640 |         BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk);
         |         ^
   1 error generated.


vim +/BPF_CGROUP_RUN_PROG_SOCK_OPS_SK +5640 net/core/skbuff.c

  5624	
  5625	static void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
  5626	{
  5627		struct bpf_sock_ops_kern sock_ops;
  5628	
  5629		memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
  5630		if (sk_fullsock(sk)) {
  5631			sock_ops.is_fullsock = 1;
  5632			sock_owned_by_me(sk);
  5633		}
  5634	
  5635		sock_ops.sk = sk;
  5636		sock_ops.op = op;
  5637		if (nargs > 0)
  5638			memcpy(sock_ops.args, args, nargs * sizeof(*args));
  5639	
> 5640		BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk);
  5641	}
  5642	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

