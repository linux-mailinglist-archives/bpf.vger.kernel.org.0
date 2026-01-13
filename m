Return-Path: <bpf+bounces-78679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D96D17A6F
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 10:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D4DE305EFB9
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 09:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F96538B9AA;
	Tue, 13 Jan 2026 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NFsTs781"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39423816F3;
	Tue, 13 Jan 2026 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296660; cv=none; b=S00JDqIGmthDkFeKsPfEbhwfZDMhT8nm8/da2HGA24HbSu0gUHxo5ply4DN6YRI8/FUZXURLMzWm/GCRrTtD9Wu93QWSrnuFhn/ywjDwhd7rRZaFEGMvdFGs7tCV3EZP3lwyTpNcBQeA9cG+QXLyH0U1qt7N2nUybixs3wP1uk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296660; c=relaxed/simple;
	bh=msk/tauSQ6PJoieOyol1fe1LeWfeLYbroHLDA1WX8do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ntx68N/7RsxWQUwCGPiDiXY4sG3h/GUrSgnBLpgZIj357k0Wg6XPrL1zdX1Ld+tzkyhsrlWKpaqTy+zEBi+wivxl6KH7f3JwmANEPJ6nqWDe6vvI9yehI8mLyDjLhJLUNHFY77KwGyxJEEnuHxU+l70SG2Q18InVnw2JrsBJx+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NFsTs781; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768296657; x=1799832657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=msk/tauSQ6PJoieOyol1fe1LeWfeLYbroHLDA1WX8do=;
  b=NFsTs781d94TK3bv36A4hRqdwpdeVRzy1a9Rt1ZedyXqFFSifLEtWX3Q
   0aVDqPC0uAdOcCHobrLZBhU5Oc3H+P35NdUEFxMSyiV/YBYDck1PXXh9m
   TbVGExUDaNayoyw81k2Go8o7z/dv+kuLcLc6rxpL/KY+GK71akCicgH/n
   V1Rc2ehJ54ci7HQ4Ea4Hv6Zl5OnnnTuKtPdF5Mxubya2QL6WLlNukumaC
   +n1xRLKftKqoBbO4uTuvFKPWgVEg9gEr9Rh8obzBSR1bSN9V9jgrewyx0
   Q3ZEZ2LRAeCQgUySdKESnqZuKQ4M6PgHro7cYYHG9WxnMDRv2a5UH71lR
   w==;
X-CSE-ConnectionGUID: dM9hMuPBTX6om57Kefnpjw==
X-CSE-MsgGUID: 1n2g0C75S+qwGVNncaOhJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="95052424"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="95052424"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 01:30:55 -0800
X-CSE-ConnectionGUID: GpcKksRDRniwK+tQiUUz5A==
X-CSE-MsgGUID: 3fWlMPCcTJaN/AF6wpHrUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="203550699"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 13 Jan 2026 01:30:51 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vfajf-00000000EXw-3oXr;
	Tue, 13 Jan 2026 09:30:47 +0000
Date: Tue, 13 Jan 2026 17:29:55 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Fang <wei.fang@nxp.com>, shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com, frank.li@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 11/11] net: fec: add AF_XDP zero-copy support
Message-ID: <202601131736.i41CNo5A-lkp@intel.com>
References: <20260113032939.3705137-12-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113032939.3705137-12-wei.fang@nxp.com>

Hi Wei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Fang/net-fec-add-fec_txq_trigger_xmit-helper/20260113-113607
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260113032939.3705137-12-wei.fang%40nxp.com
patch subject: [PATCH net-next 11/11] net: fec: add AF_XDP zero-copy support
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20260113/202601131736.i41CNo5A-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260113/202601131736.i41CNo5A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601131736.i41CNo5A-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/freescale/fec_main.c: In function 'fec_enet_rx_queue_xsk':
>> drivers/net/ethernet/freescale/fec_main.c:2261:20: warning: variable 'dma' set but not used [-Wunused-but-set-variable]
    2261 |         dma_addr_t dma;
         |                    ^~~


vim +/dma +2261 drivers/net/ethernet/freescale/fec_main.c

  2245	
  2246	static int fec_enet_rx_queue_xsk(struct fec_enet_private *fep, int queue,
  2247					 int budget, struct bpf_prog *prog)
  2248	{
  2249		u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
  2250		struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
  2251		struct net_device *ndev = fep->netdev;
  2252		struct bufdesc *bdp = rxq->bd.cur;
  2253		u32 sub_len = 4 + fep->rx_shift;
  2254		int cpu = smp_processor_id();
  2255		bool wakeup_xsk = false;
  2256		struct xdp_buff *xsk;
  2257		int pkt_received = 0;
  2258		struct sk_buff *skb;
  2259		u16 status, pkt_len;
  2260		u32 xdp_res = 0;
> 2261		dma_addr_t dma;
  2262		int index, err;
  2263		u32 act;
  2264	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

