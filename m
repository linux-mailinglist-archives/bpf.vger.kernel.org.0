Return-Path: <bpf+bounces-64641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ECBB15265
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 19:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003555430B0
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 17:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3D6299922;
	Tue, 29 Jul 2025 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nyMNSaUn"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7EC2980B8;
	Tue, 29 Jul 2025 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753811696; cv=none; b=D+zF634Z964o6V1tisz4ikVFoHJivqXRCsqAmGWuAYLl7OYpse8Ch4Kc5KUdESrUKNL9on7m5g5N6jDG3asOjIqwTRnk3OczJvjMZJOqkAV/gJoYb9we8pDOWODHNSKbPeckigHuXGcfJ3KxrdJDKg5j0X4R1z+2FVhOJcCUO7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753811696; c=relaxed/simple;
	bh=6KIbPA/EaHB5zy//h0D6S9v9PCr7IQU7sflH936pN20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtJxw9t8hQJuejIAGKFbZiu29FGttZMeYoj9rDjXCsxHa5OepCVrB9TcUD7SW41ie6DIEEjvnJUDF6C6s3WF0HPYMZnspi0UywXtXikjFtXVbFLjIeM1l/WbCSBA1xxqnPib/ULzrHW9fY4rGZRKZkZtk+v919N9Sid+kgP7skg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nyMNSaUn; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753811694; x=1785347694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6KIbPA/EaHB5zy//h0D6S9v9PCr7IQU7sflH936pN20=;
  b=nyMNSaUn3cD3nq7d/BnNoBGWyQpqcgZFPyIov0ACIoZXj413Hn0xHWex
   EUcXm1RTo7K5Kx+9Vw+b7Uexg234rjMEN9KUjG4oiA6i/xka2xaunVq1S
   gy7C4xEpAOYHjLPjiQdQsx/eWBZxVgGnL8nfCyWqSOBEJJirvjNgvbjV0
   dPluybak/ZKPoR/1P28rMvL3KPOMtc5o4/ez9tyRw2J2RCkmHye9ZA2aG
   /ncUPsZtouvdNYc0P1XxVJHNOotsTk2D2NsHGCT0XEzvI+5kRIuGCQjYb
   e0SIEGfOaPn2+4SRaTFniWTZlNmSbQH22zL2QxfT0lz2B0rnd2f8q4DCd
   Q==;
X-CSE-ConnectionGUID: ZpOnOSJaTCGMgWtVeUSXpA==
X-CSE-MsgGUID: 6XwnpZgmQpyR8zYXKANtsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="58719600"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="58719600"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 10:54:53 -0700
X-CSE-ConnectionGUID: hKsGkZjiR5yd2xZ2OXwKsg==
X-CSE-MsgGUID: NIeHohyJTjWA/hm3kYBUAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="167024455"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 29 Jul 2025 10:54:49 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ugoXG-0001XT-2S;
	Tue, 29 Jul 2025 17:54:46 +0000
Date: Wed, 30 Jul 2025 01:54:21 +0800
From: kernel test robot <lkp@intel.com>
To: Sami Tolvanen <samitolvanen@google.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: crypto: Use the correct destructor
 kfunc type
Message-ID: <202507300122.RpqIKqFR-lkp@intel.com>
References: <20250728202656.559071-7-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728202656.559071-7-samitolvanen@google.com>

Hi Sami,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5b4c54ac49af7f486806d79e3233fc8a9363961c]

url:    https://github.com/intel-lab-lkp/linux/commits/Sami-Tolvanen/bpf-crypto-Use-the-correct-destructor-kfunc-type/20250729-042936
base:   5b4c54ac49af7f486806d79e3233fc8a9363961c
patch link:    https://lore.kernel.org/r/20250728202656.559071-7-samitolvanen%40google.com
patch subject: [PATCH bpf-next v3 1/4] bpf: crypto: Use the correct destructor kfunc type
config: alpha-randconfig-r111-20250729 (https://download.01.org/0day-ci/archive/20250730/202507300122.RpqIKqFR-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250730/202507300122.RpqIKqFR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507300122.RpqIKqFR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/bpf/crypto.c:264:18: sparse: sparse: symbol 'bpf_crypto_ctx_release_dtor' was not declared. Should it be static?

vim +/bpf_crypto_ctx_release_dtor +264 kernel/bpf/crypto.c

   263	
 > 264	__bpf_kfunc void bpf_crypto_ctx_release_dtor(void *ctx)
   265	{
   266		bpf_crypto_ctx_release(ctx);
   267	}
   268	CFI_NOSEAL(bpf_crypto_ctx_release_dtor);
   269	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

