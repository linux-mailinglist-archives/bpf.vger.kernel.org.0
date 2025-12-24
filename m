Return-Path: <bpf+bounces-77390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00147CDAF8B
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 01:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5739E30E7E2F
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 00:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F7F3191CC;
	Wed, 24 Dec 2025 00:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jeRlx3ID"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AB431813F
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 00:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536388; cv=none; b=GVhsj+nIrLzf40j39fdynscHGdpi44TCHyXN43zu9SPt0d7KvX1luhH8jz75JaKoSh87KNuhg3YuyrSIgoMPHWnocWFlFlX5vWeCWRQNg5xXsU4EzM2i3q/WIi5QDYCUdX2JsCUnWT4DgzzLQeXJDydKzg1aZg1iFav6EzMHJTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536388; c=relaxed/simple;
	bh=sc/21pFHzi4ubu5IS0OgNd+vZt50kE9eCh7PGamP2iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYv2d8WNmlWr12K8D1LXD6kywJm+jtY+SWE7tJIUnqTZwi6/iGmyxjJh/4+EDKEEn7fb9bse4MDRnmLY3/NKLHfc6w2gBZBbl2x/Cefi1k79D4j4LFl8SL6QP1fe8NMQqZnF88TPvWy9IfugtzypLAqxZw75iGXu+bwiKgBkN8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jeRlx3ID; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766536387; x=1798072387;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sc/21pFHzi4ubu5IS0OgNd+vZt50kE9eCh7PGamP2iY=;
  b=jeRlx3IDhdNstNI51wGaWFcDtvKFSu+6pik/ShV2RjaoQoiqzJ68imND
   IRy+S70BOcxQG6T6rJmV1xL/l8eltSsfsaJErgxbjRWuVYFJRtNcsCC25
   H47kv0aLzBjtPM+oUeMXNjAtb6CoQObRRSt2dByWCstHl4newiWu8LxNP
   kreyAsUbEKsOKwATdw+arMr075aqLslGubH/qiPaB8U1XaKHSDdVrB+IE
   ixKdZDyUjHehZ1nZTMQSoLeB7vEH9C0h3WJ2aH8FS9abd9j3Q4zXg9ZoN
   7/D7NPOxkuSubID2um7sLgTa2OPzimbYEYSIYZVvcCzTBH6v2A+IC3TME
   A==;
X-CSE-ConnectionGUID: DKeuaU/aRfukK/F8aXZlfw==
X-CSE-MsgGUID: pBqlObqETQSAfEnLiiaxnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="72010300"
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="72010300"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 16:33:07 -0800
X-CSE-ConnectionGUID: buiGrgzcTvytMMUaO37q0Q==
X-CSE-MsgGUID: V5zvbk7rTXObV3Jws+UL4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="230557269"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 23 Dec 2025 16:33:03 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYCoE-000000002Vp-13K0;
	Wed, 24 Dec 2025 00:32:58 +0000
Date: Wed, 24 Dec 2025 08:32:08 +0800
From: kernel test robot <lkp@intel.com>
To: Yazhou Tang <tangyazhou@zju.edu.cn>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com, ziye@zju.edu.cn
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add interval and tnum analysis for
 signed and unsigned BPF_DIV
Message-ID: <202512240848.WegL0AOr-lkp@intel.com>
References: <20251223091120.2413435-2-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223091120.2413435-2-tangyazhou@zju.edu.cn>

Hi Yazhou,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yazhou-Tang/bpf-Add-interval-and-tnum-analysis-for-signed-and-unsigned-BPF_DIV/20251223-171652
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251223091120.2413435-2-tangyazhou%40zju.edu.cn
patch subject: [PATCH bpf-next v2 1/2] bpf: Add interval and tnum analysis for signed and unsigned BPF_DIV
config: alpha-randconfig-r131-20251224 (https://download.01.org/0day-ci/archive/20251224/202512240848.WegL0AOr-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251224/202512240848.WegL0AOr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512240848.WegL0AOr-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/bpf/tnum.c:16:19: sparse: sparse: symbol 'tnum_empty' was not declared. Should it be static?

vim +/tnum_empty +16 kernel/bpf/tnum.c

    11	
    12	#define TNUM(_v, _m)	(struct tnum){.value = _v, .mask = _m}
    13	/* A completely unknown value */
    14	const struct tnum tnum_unknown = { .value = 0, .mask = -1 };
    15	/* Not well-formed Tnum, whose concrete value is empty set. */
  > 16	const struct tnum tnum_empty = { .value = -1, .mask = -1 };
    17	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

