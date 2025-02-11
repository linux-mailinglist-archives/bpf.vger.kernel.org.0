Return-Path: <bpf+bounces-51173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1529A31439
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 19:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5D13A7179
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 18:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE96262D17;
	Tue, 11 Feb 2025 18:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXvKR3iF"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA993253B43;
	Tue, 11 Feb 2025 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739299195; cv=none; b=NKjCjD7DorLNQ/D+6yOZiY7u4JHD16XbMiTy3guASm30YqTPkqtk8GEVj4jEcNaS18xnLau+zPqJ+yzXdiN9aO0JeXjitAIi4r0ldbYbNM8ygRuMv7oT960z1rJgW1myqviVrfU5dn9RqC/FsXt9iip2Wn+2u4i8yiLzDiVxrvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739299195; c=relaxed/simple;
	bh=2X0p8yfjjhftBFMiKokboj/5SlYdERseeftmcHZfhnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGGOzyfNAj2rWoWLQg+ojJtIjODmo2QOkVcXk/ZA7fNGnGPsVludZgxSE7RapgoYypH/FBY7y5ge4QgT+TSdoS1V0puVK2kLiZjrJL8rYNWOuvSobbvYGussvETs7h1Sxnbjl/ZT2lhmxyBfsD8ubWpkFW7xI7fXw2DsRbZITYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXvKR3iF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739299194; x=1770835194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2X0p8yfjjhftBFMiKokboj/5SlYdERseeftmcHZfhnk=;
  b=NXvKR3iFIMQMBLhFyYagCBz3futuL0t9YBIe3k1E/m1eIJp7F/HieT8S
   08N60nfFgdtAadous2W/ZioMJtO9sCQiVeR1poM9sU3mFX7GyOO7gijXn
   YYNXQ58QAmoMVA+7GVaIUp4dzr/Yv/DgBwWt0Eq8+p97VV7MjpxWP7yaX
   FPyA9VkdW+efiPE30PfvUJKSavZK/YmfUriT4wMhN1kYHLc+BlBtc4b6i
   Y7VWhFZ3Y38JJCvmrKSCNsQkYxJE3wlVjs3BXtEZwQvWGaSO69dT2VLfU
   CaWJemjOnpWH5fR8gdDHEGOquK3ijiJv91RzuhYM14eViEPph0KLuyKjw
   Q==;
X-CSE-ConnectionGUID: JqfpLawvQNScm7VJqn56/A==
X-CSE-MsgGUID: 9TUjyHACSBuCOf0nYpxJZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="57467849"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="57467849"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 10:39:53 -0800
X-CSE-ConnectionGUID: aIjXXl5KRTeTSWn44N5JOA==
X-CSE-MsgGUID: pwysVRBqS3K55qtxvr71SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117213225"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 11 Feb 2025 10:39:47 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1thvAf-0014Zb-0f;
	Tue, 11 Feb 2025 18:39:45 +0000
Date: Wed, 12 Feb 2025 02:39:18 +0800
From: kernel test robot <lkp@intel.com>
To: Meghana Malladi <m-malladi@ti.com>, rogerq@kernel.org,
	danishanwar@ti.com, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	u.kleine-koenig@baylibre.com, krzysztof.kozlowski@linaro.org,
	dan.carpenter@linaro.org, m-malladi@ti.com, schnelle@linux.ibm.com,
	glaroque@baylibre.com, rdunlap@infradead.org, diogo.ivo@siemens.com,
	jan.kiszka@siemens.com, john.fastabend@gmail.com, hawk@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next v2 3/3] net: ti: icssg-prueth: Add XDP support
Message-ID: <202502120205.w04H4d0q-lkp@intel.com>
References: <20250210103352.541052-4-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210103352.541052-4-m-malladi@ti.com>

Hi Meghana,

kernel test robot noticed the following build errors:

[auto build test ERROR on acdefab0dcbc3833b5a734ab80d792bb778517a0]

url:    https://github.com/intel-lab-lkp/linux/commits/Meghana-Malladi/net-ti-icssg-prueth-Use-page_pool-API-for-RX-buffer-allocation/20250210-183805
base:   acdefab0dcbc3833b5a734ab80d792bb778517a0
patch link:    https://lore.kernel.org/r/20250210103352.541052-4-m-malladi%40ti.com
patch subject: [PATCH net-next v2 3/3] net: ti: icssg-prueth: Add XDP support
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20250212/202502120205.w04H4d0q-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250212/202502120205.w04H4d0q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502120205.w04H4d0q-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/ti/icssg/icssg_prueth.c:568:50: error: no member named 'napi_id' in 'struct xdp_rxq_info'
     568 |         ret = xdp_rxq_info_reg(rxq, emac->ndev, 0, rxq->napi_id);
         |                                                    ~~~  ^
   1 error generated.


vim +568 drivers/net/ethernet/ti/icssg/icssg_prueth.c

   561	
   562	static int prueth_create_xdp_rxqs(struct prueth_emac *emac)
   563	{
   564		struct xdp_rxq_info *rxq = &emac->rx_chns.xdp_rxq;
   565		struct page_pool *pool = emac->rx_chns.pg_pool;
   566		int ret;
   567	
 > 568		ret = xdp_rxq_info_reg(rxq, emac->ndev, 0, rxq->napi_id);
   569		if (ret)
   570			return ret;
   571	
   572		ret = xdp_rxq_info_reg_mem_model(rxq, MEM_TYPE_PAGE_POOL, pool);
   573		if (ret)
   574			xdp_rxq_info_unreg(rxq);
   575	
   576		return ret;
   577	}
   578	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

