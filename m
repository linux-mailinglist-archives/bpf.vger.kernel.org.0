Return-Path: <bpf+bounces-43345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7989B3F1A
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 01:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19F1283AFD
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 00:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F3BA937;
	Tue, 29 Oct 2024 00:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buhlFMtU"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A5E17BA9;
	Tue, 29 Oct 2024 00:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161426; cv=none; b=Ro3XpI9F3fJDyc9gma6OqeT20r2k3al0irpZp/EOEObYtTBInZLVcFSrUKCeRN+lo+x6RL1xVlheeP/rpBFj0U8vVoYngZBlvUwSfzm+uY1OMYA39nLNH6v5q2SBEsQiXdaXtdWYfwF2M6BerTm+Ycks1KlzsXwu+6mDnKUkRNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161426; c=relaxed/simple;
	bh=neSRulGg21VOz6IX1JMC+NsXnEMdJGtny2SHtH3jLko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPZRYcG2newY6ssiyH8u5/2XclHgeV+cwfMID17AHsZJ0K7UVoAVypctq01PTCv5a7eVFFgmdMkggtzSZD1GQuxt9CosmXarKADQV21SP57ycOOo2QQwweKn0vdJC5BwHj/ODnApZikexrMiRh4C1Wd2MVtYFbKXo4HTbZU/fbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=buhlFMtU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730161424; x=1761697424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=neSRulGg21VOz6IX1JMC+NsXnEMdJGtny2SHtH3jLko=;
  b=buhlFMtUWvGS6xX8I89Z+Oh6ZXj0AVEnd1dIIXkz56IGnGGNDuJ9ng0Q
   iImM3Q+S/uRMBPW0rC5o6iiRWM1JL68vzUu5BvQrQ57WfC3StvoV0+3El
   JCSz5Kug5KmVL/hVkX1ff/8frvQ+geSMvt6ttFCjC382hnQT6ATTiEmU0
   BlNLDLHC3hnV+lsOgwfpvRnJVjW/lOiaRxBkIwTzw53urDYyXee3qRPLU
   bp06Ghnkd6MSIW2aVsEgNY2hoVhmAl6Cvujja8NYwMow5erwJhhP+nuZ4
   u/3Ba1SkMtSegsQb9vDs1koR3pYTdsqmat1x1K7CiUqdXZVfApfvTAXzy
   A==;
X-CSE-ConnectionGUID: RXSMix+QQOi1rTgplGTlZA==
X-CSE-MsgGUID: hSvRSwQYRQuhslMwjKKpiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29684363"
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="29684363"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 17:23:38 -0700
X-CSE-ConnectionGUID: 3ZaieECdSAG/34BnJsoN6w==
X-CSE-MsgGUID: 7PbfxnPeTIuS8TDtxy2//A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="81880925"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 28 Oct 2024 17:23:33 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5a1C-000d3Y-2Y;
	Tue, 29 Oct 2024 00:23:30 +0000
Date: Tue, 29 Oct 2024 08:23:03 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3 04/14] net-timestamp: introduce
 TS_SCHED_OPT_CB to generate dev xmit timestamp
Message-ID: <202410290828.ZqgMO8Xc-lkp@intel.com>
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
config: arm-randconfig-001-20241029 (https://download.01.org/0day-ci/archive/20241029/202410290828.ZqgMO8Xc-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241029/202410290828.ZqgMO8Xc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410290828.ZqgMO8Xc-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/core/skbuff.c: In function 'timestamp_call_bpf':
>> net/core/skbuff.c:5640:9: error: implicit declaration of function 'BPF_CGROUP_RUN_PROG_SOCK_OPS_SK'; did you mean 'BPF_CGROUP_RUN_PROG_SOCK_OPS'? [-Wimplicit-function-declaration]
    5640 |         BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         BPF_CGROUP_RUN_PROG_SOCK_OPS


vim +5640 net/core/skbuff.c

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

