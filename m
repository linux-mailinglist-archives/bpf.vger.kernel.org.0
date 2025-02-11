Return-Path: <bpf+bounces-51187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA50DA31881
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 23:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4A0168635
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 22:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177C426A093;
	Tue, 11 Feb 2025 22:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VmXuRd7M"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A03268FE6;
	Tue, 11 Feb 2025 22:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739312482; cv=none; b=WNvUkUEPVeA/4b0nRZlqsE61qEzN7nLHJjKq3SDE2vDH1Ze03Wv03sZU1rgE7XexqNjClynbkNerNU0tTNF+ZvyoitgQ/8WT/I3l5+1QvKRVr/bhDUAy/D9AVDXwwJWLNHdrMgpkW3aj0oPdAeKgpZr/y/hsHOx4on+ZL6pjoj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739312482; c=relaxed/simple;
	bh=KmQ+tXg/m4ZK8Xhj8IZwShtRHzkqTHlubFqibbJilzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmTBT6ATO8APNP35FcFNB7PKlbywArkpSrliFJMiESUut9DDfMMVRlPAzjHj4sc8VdZtEpXpUEZPA77tVHyLbfoMNooevdeR0E+Z99CPpl18cVSZJGi+NsTdYVMIZ98Vd5n6ttXY2JrqJZMq5lMh2ZPJylj9ruQScEg6v4YSm3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VmXuRd7M; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739312480; x=1770848480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KmQ+tXg/m4ZK8Xhj8IZwShtRHzkqTHlubFqibbJilzM=;
  b=VmXuRd7M+lRQwSnB/3n2J0WqOpiKZqOOi0EFt+uUMC7nDJ0ZVx+LH6uH
   NcPZ0t0AyNQ/Av0z1m3gcLWvVPNELxzc3FY0Z1oLP+5EahDRtm7Lbq6tU
   pNK4s4lRiu+n4rWLoF2JraRB8IR0BhJPpO7RVaCVjFE2ZD/IsIUVgZ7G9
   XF217Q4mPXezhPHd8KZTQof5TA7kmkBnnYLWUpyffCvvDnp/vH8f9fZBS
   VUtou+U1Wlv7eyrH22/pY9WMMZ85cROfIkHGxnrirhfWKkLRZni1vy2OM
   SM3+TkxVNJCPOfdoTU2X+Pc6pcCB/jH/jIU1iKO5W4DeXM9kh8byojBdt
   w==;
X-CSE-ConnectionGUID: xeUpkHVhRROW5iMq123JDQ==
X-CSE-MsgGUID: tRSaIwW5Tw6P9DFbnW721w==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50938308"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="50938308"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 14:21:19 -0800
X-CSE-ConnectionGUID: Mnc4Nd50QAuuH5O4SxIE9A==
X-CSE-MsgGUID: 2ZhjGQPqQMavXeVcEpA1iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113529562"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 11 Feb 2025 14:21:12 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1thycv-0014lb-2H;
	Tue, 11 Feb 2025 22:21:09 +0000
Date: Wed, 12 Feb 2025 06:20:14 +0800
From: kernel test robot <lkp@intel.com>
To: Meghana Malladi <m-malladi@ti.com>, rogerq@kernel.org,
	danishanwar@ti.com, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, u.kleine-koenig@baylibre.com,
	krzysztof.kozlowski@linaro.org, dan.carpenter@linaro.org,
	m-malladi@ti.com, schnelle@linux.ibm.com, glaroque@baylibre.com,
	rdunlap@infradead.org, diogo.ivo@siemens.com,
	jan.kiszka@siemens.com, john.fastabend@gmail.com, hawk@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next v2 3/3] net: ti: icssg-prueth: Add XDP support
Message-ID: <202502120546.Y6ri4qi6-lkp@intel.com>
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
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20250212/202502120546.Y6ri4qi6-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250212/202502120546.Y6ri4qi6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502120546.Y6ri4qi6-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/ti/icssg/icssg_prueth.c: In function 'prueth_create_xdp_rxqs':
>> drivers/net/ethernet/ti/icssg/icssg_prueth.c:568:55: error: 'struct xdp_rxq_info' has no member named 'napi_id'
     568 |         ret = xdp_rxq_info_reg(rxq, emac->ndev, 0, rxq->napi_id);
         |                                                       ^~


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

