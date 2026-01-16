Return-Path: <bpf+bounces-79243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF897D3119F
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 13:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE43730B786D
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 12:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198CB1A3166;
	Fri, 16 Jan 2026 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsRsJEf/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF28E1DE4EF;
	Fri, 16 Jan 2026 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768566550; cv=none; b=jx/LU4Wn7cpZK2fIqEJcaF+YcAKvRknSFttYveOywTdf5gZSMHFJ/Q6A4nBeY5QW0Dnskr1SFn2DRMT3u8/ThDR61/VyGbGwhFWv4aIVYJryujUTjx1K4mq84MtHob9xnZiArJaXOmrvobJuSV+hh4Fvhuk7qDMwwx4TV+xdRe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768566550; c=relaxed/simple;
	bh=xi6zM5CVklLfECdqHMYOBwNT/HjrbAQtzgaoZogHnGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbwpwxcaK8Ti6qammFdYw1vQZ7rQR9Gp+WfTgS2bbNX2JlDyRNWWtE+n3R4tqZmmguYf+s8XYeTi3yiTja8hqpJYUJY8mjSVOcTYxcZeLbQUaF+JimQwWG3PrH3ievKnHuqbNMXN0HSUyCqRozBlI7ZTpaNOYpaVbIDmPoC/COs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZsRsJEf/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768566545; x=1800102545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xi6zM5CVklLfECdqHMYOBwNT/HjrbAQtzgaoZogHnGk=;
  b=ZsRsJEf/vK1anXUXmW7JYtGZI282edn0MHA6+wReWxYztmKTHpMC5ssy
   tAHadgkXSvFTXQZBnpI08iAUsaCxSRSLRcoUP2f64bYleEpVExjBPAUpr
   Y/HUImRlOzUfUTZFMhBM5aAh2Wu2b+bh3DKmouWkoFNnXe1IhDF+bRND5
   C3VN8/ZS06CCSDGzCNr1NaY5hFWQB+0KNB5ycJosHRESJ5kxhw7etBt8M
   NB3MORhHypmQRX9aeCRlTG5DFSZP91k90JVu1R2PegFsC+txzQDkXh3P/
   k8PdBPu+2Va0N+OQSsXFUhfQoXOgjgkbL0c/IcSpLhLAgqosPDPQ8JcIm
   Q==;
X-CSE-ConnectionGUID: Rkx3tlRwQLybkafiz5dH/g==
X-CSE-MsgGUID: oRSfnv43TKOv3/QHR2b6ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="68889869"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="68889869"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 04:29:04 -0800
X-CSE-ConnectionGUID: cciyI+moRiCnC1gkccgIFw==
X-CSE-MsgGUID: M4jROaV+Qo67aryhk+swUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="204384752"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 16 Jan 2026 04:28:59 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgiwi-00000000KpE-0KSC;
	Fri, 16 Jan 2026 12:28:56 +0000
Date: Fri, 16 Jan 2026 20:28:23 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Fang <wei.fang@nxp.com>, shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com, frank.li@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH v2 net-next 14/14] net: fec: add AF_XDP zero-copy support
Message-ID: <202601162115.ATDIXPBp-lkp@intel.com>
References: <20260116074027.1603841-15-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116074027.1603841-15-wei.fang@nxp.com>

Hi Wei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Fang/net-fec-add-fec_txq_trigger_xmit-helper/20260116-154834
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260116074027.1603841-15-wei.fang%40nxp.com
patch subject: [PATCH v2 net-next 14/14] net: fec: add AF_XDP zero-copy support
config: arm-imx_v4_v5_defconfig (https://download.01.org/0day-ci/archive/20260116/202601162115.ATDIXPBp-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260116/202601162115.ATDIXPBp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601162115.ATDIXPBp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/freescale/fec_main.c:1040:4: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
    1040 |                         default:
         |                         ^
   drivers/net/ethernet/freescale/fec_main.c:1040:4: note: insert 'break;' to avoid fall-through
    1040 |                         default:
         |                         ^
         |                         break; 
   1 warning generated.


vim +1040 drivers/net/ethernet/freescale/fec_main.c

61a4427b955f79d drivers/net/ethernet/freescale/fec_main.c Nimrod Andy    2014-06-12   970  
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26   971  /* Init RX & TX buffer descriptors
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26   972   */
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26   973  static void fec_enet_bd_init(struct net_device *dev)
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26   974  {
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26   975  	struct fec_enet_private *fep = netdev_priv(dev);
4d494cdc92b3b9a drivers/net/ethernet/freescale/fec_main.c Fugang Duan    2014-09-13   976  	struct fec_enet_priv_tx_q *txq;
4d494cdc92b3b9a drivers/net/ethernet/freescale/fec_main.c Fugang Duan    2014-09-13   977  	struct fec_enet_priv_rx_q *rxq;
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26   978  	struct bufdesc *bdp;
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26   979  	unsigned int i;
59d0f746564495c drivers/net/ethernet/freescale/fec_main.c Frank Li       2014-09-13   980  	unsigned int q;
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26   981  
59d0f746564495c drivers/net/ethernet/freescale/fec_main.c Frank Li       2014-09-13   982  	for (q = 0; q < fep->num_rx_queues; q++) {
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26   983  		/* Initialize the receive buffer descriptors. */
59d0f746564495c drivers/net/ethernet/freescale/fec_main.c Frank Li       2014-09-13   984  		rxq = fep->rx_queue[q];
7355f2760620b38 drivers/net/ethernet/freescale/fec_main.c Troy Kisky     2016-02-05   985  		bdp = rxq->bd.base;
4d494cdc92b3b9a drivers/net/ethernet/freescale/fec_main.c Fugang Duan    2014-09-13   986  
7355f2760620b38 drivers/net/ethernet/freescale/fec_main.c Troy Kisky     2016-02-05   987  		for (i = 0; i < rxq->bd.ring_size; i++) {
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26   988  
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26   989  			/* Initialize the BD for every fragment in the page. */
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26   990  			if (bdp->cbd_bufaddr)
5cfa30397bc3677 drivers/net/ethernet/freescale/fec_main.c Johannes Berg  2016-01-24   991  				bdp->cbd_sc = cpu_to_fec16(BD_ENET_RX_EMPTY);
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26   992  			else
5cfa30397bc3677 drivers/net/ethernet/freescale/fec_main.c Johannes Berg  2016-01-24   993  				bdp->cbd_sc = cpu_to_fec16(0);
7355f2760620b38 drivers/net/ethernet/freescale/fec_main.c Troy Kisky     2016-02-05   994  			bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26   995  		}
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26   996  
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26   997  		/* Set the last buffer to wrap */
7355f2760620b38 drivers/net/ethernet/freescale/fec_main.c Troy Kisky     2016-02-05   998  		bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
bd31490718b47d9 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2025-11-19   999  		bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26  1000  
7355f2760620b38 drivers/net/ethernet/freescale/fec_main.c Troy Kisky     2016-02-05  1001  		rxq->bd.cur = rxq->bd.base;
59d0f746564495c drivers/net/ethernet/freescale/fec_main.c Frank Li       2014-09-13  1002  	}
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26  1003  
59d0f746564495c drivers/net/ethernet/freescale/fec_main.c Frank Li       2014-09-13  1004  	for (q = 0; q < fep->num_tx_queues; q++) {
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26  1005  		/* ...and the same for transmit */
59d0f746564495c drivers/net/ethernet/freescale/fec_main.c Frank Li       2014-09-13  1006  		txq = fep->tx_queue[q];
7355f2760620b38 drivers/net/ethernet/freescale/fec_main.c Troy Kisky     2016-02-05  1007  		bdp = txq->bd.base;
7355f2760620b38 drivers/net/ethernet/freescale/fec_main.c Troy Kisky     2016-02-05  1008  		txq->bd.cur = bdp;
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26  1009  
7355f2760620b38 drivers/net/ethernet/freescale/fec_main.c Troy Kisky     2016-02-05  1010  		for (i = 0; i < txq->bd.ring_size; i++) {
81725cc0fbfea44 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2026-01-16  1011  			struct page *page;
81725cc0fbfea44 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2026-01-16  1012  
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26  1013  			/* Initialize the BD for every fragment in the page. */
5cfa30397bc3677 drivers/net/ethernet/freescale/fec_main.c Johannes Berg  2016-01-24  1014  			bdp->cbd_sc = cpu_to_fec16(0);
81725cc0fbfea44 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2026-01-16  1015  
81725cc0fbfea44 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2026-01-16  1016  			switch (txq->tx_buf[i].type) {
81725cc0fbfea44 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2026-01-16  1017  			case FEC_TXBUF_T_SKB:
178e5f57a8d8f8f drivers/net/ethernet/freescale/fec_main.c Fugang Duan    2017-12-22  1018  				if (bdp->cbd_bufaddr &&
178e5f57a8d8f8f drivers/net/ethernet/freescale/fec_main.c Fugang Duan    2017-12-22  1019  				    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
178e5f57a8d8f8f drivers/net/ethernet/freescale/fec_main.c Fugang Duan    2017-12-22  1020  					dma_unmap_single(&fep->pdev->dev,
178e5f57a8d8f8f drivers/net/ethernet/freescale/fec_main.c Fugang Duan    2017-12-22  1021  							 fec32_to_cpu(bdp->cbd_bufaddr),
178e5f57a8d8f8f drivers/net/ethernet/freescale/fec_main.c Fugang Duan    2017-12-22  1022  							 fec16_to_cpu(bdp->cbd_datlen),
178e5f57a8d8f8f drivers/net/ethernet/freescale/fec_main.c Fugang Duan    2017-12-22  1023  							 DMA_TO_DEVICE);
af6f4791380c320 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2023-08-15  1024  				dev_kfree_skb_any(txq->tx_buf[i].buf_p);
81725cc0fbfea44 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2026-01-16  1025  				break;
81725cc0fbfea44 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2026-01-16  1026  			case FEC_TXBUF_T_XDP_NDO:
20f797399035a80 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2023-07-06  1027  				dma_unmap_single(&fep->pdev->dev,
20f797399035a80 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2023-07-06  1028  						 fec32_to_cpu(bdp->cbd_bufaddr),
20f797399035a80 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2023-07-06  1029  						 fec16_to_cpu(bdp->cbd_datlen),
20f797399035a80 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2023-07-06  1030  						 DMA_TO_DEVICE);
af6f4791380c320 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2023-08-15  1031  				xdp_return_frame(txq->tx_buf[i].buf_p);
81725cc0fbfea44 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2026-01-16  1032  				break;
81725cc0fbfea44 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2026-01-16  1033  			case FEC_TXBUF_T_XDP_TX:
81725cc0fbfea44 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2026-01-16  1034  				page = txq->tx_buf[i].buf_p;
65589e860a80369 drivers/net/ethernet/freescale/fec_main.c Byungchul Park 2025-07-21  1035  				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
f1d89a02b16bcdc drivers/net/ethernet/freescale/fec_main.c Wei Fang       2026-01-16  1036  						   page, 0, false);
81725cc0fbfea44 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2026-01-16  1037  				break;
f9806afd55c4ab1 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2026-01-16  1038  			case FEC_TXBUF_T_XSK_TX:
f9806afd55c4ab1 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2026-01-16  1039  				xsk_buff_free(txq->tx_buf[i].buf_p);
81725cc0fbfea44 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2026-01-16 @1040  			default:
81725cc0fbfea44 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2026-01-16  1041  				break;
81725cc0fbfea44 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2026-01-16  1042  			};
20f797399035a80 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2023-07-06  1043  
af6f4791380c320 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2023-08-15  1044  			txq->tx_buf[i].buf_p = NULL;
20f797399035a80 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2023-07-06  1045  			/* restore default tx buffer type: FEC_TXBUF_T_SKB */
20f797399035a80 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2023-07-06  1046  			txq->tx_buf[i].type = FEC_TXBUF_T_SKB;
5cfa30397bc3677 drivers/net/ethernet/freescale/fec_main.c Johannes Berg  2016-01-24  1047  			bdp->cbd_bufaddr = cpu_to_fec32(0);
7355f2760620b38 drivers/net/ethernet/freescale/fec_main.c Troy Kisky     2016-02-05  1048  			bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26  1049  		}
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26  1050  
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26  1051  		/* Set the last buffer to wrap */
7355f2760620b38 drivers/net/ethernet/freescale/fec_main.c Troy Kisky     2016-02-05  1052  		bdp = fec_enet_get_prevdesc(bdp, &txq->bd);
bd31490718b47d9 drivers/net/ethernet/freescale/fec_main.c Wei Fang       2025-11-19  1053  		bdp->cbd_sc |= cpu_to_fec16(BD_ENET_TX_WRAP);
4d494cdc92b3b9a drivers/net/ethernet/freescale/fec_main.c Fugang Duan    2014-09-13  1054  		txq->dirty_tx = bdp;
14109a59caf93e6 drivers/net/ethernet/freescale/fec.c      Frank Li       2013-03-26  1055  	}
59d0f746564495c drivers/net/ethernet/freescale/fec_main.c Frank Li       2014-09-13  1056  }
59d0f746564495c drivers/net/ethernet/freescale/fec_main.c Frank Li       2014-09-13  1057  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

