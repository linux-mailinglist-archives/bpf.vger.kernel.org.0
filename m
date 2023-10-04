Return-Path: <bpf+bounces-11413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C007B9887
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 01:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B52DB281DF9
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 23:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A39826E03;
	Wed,  4 Oct 2023 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGCqI7Ss"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA173266A4;
	Wed,  4 Oct 2023 23:06:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF35C6;
	Wed,  4 Oct 2023 16:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696460780; x=1727996780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rU/Y7DSRWyAW4QLfPI60iKyOGFzRjME3dikwjTxWxTs=;
  b=BGCqI7SsWEci8J3cDrCo1Rot+m3uLDn7xfZV2XFl7COONqodiVRiX6ha
   p7ocHhH6s2yF/XPbijNYL+yW8qholBaUg3kuOxFmiCzcuLtRoD7djjFGp
   LMLpkE2aDRxWmJGVFE7O0uzja6B2z6y/cIBlYW2dOcKANOy1G7PCRLaZR
   IfQag0tvuWJNzccohxWkVpWxoaX7Qvgg44Y/kisrpxs4RD3tv/Y/SG94r
   GlkGFZHdCfRPX51jdHzV4UV4rr3njH5jKxOBzgvvDrvaYGv9UIALFyx8E
   WaRGTFFdCCSN+Y1OYmpE29KsVzWX1Vsc+TGVXRd3nWk2rBkYwUcQsflCX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="363610292"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="363610292"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 16:06:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="786709522"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="786709522"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 04 Oct 2023 16:06:12 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qoAwU-000Kim-0c;
	Wed, 04 Oct 2023 23:06:10 +0000
Date: Thu, 5 Oct 2023 07:05:48 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	kuba@kernel.org, toke@kernel.org, willemb@google.com,
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org,
	maciej.fijalkowski@intel.com, hawk@kernel.org,
	yoong.siang.song@intel.com, netdev@vger.kernel.org,
	xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v3 05/10] net: stmmac: Add Tx HWTS support to
 XDP ZC
Message-ID: <202310050607.UQ0bU3ct-lkp@intel.com>
References: <20231003200522.1914523-6-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003200522.1914523-6-sdf@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Stanislav,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Fomichev/xsk-Support-tx_metadata_len/20231004-040718
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231003200522.1914523-6-sdf%40google.com
patch subject: [PATCH bpf-next v3 05/10] net: stmmac: Add Tx HWTS support to XDP ZC
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20231005/202310050607.UQ0bU3ct-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231005/202310050607.UQ0bU3ct-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310050607.UQ0bU3ct-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c: In function 'stmmac_xdp_xmit_zc':
>> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:2554:17: error: implicit declaration of function 'xsk_tx_metadata_to_compl'; did you mean 'xsk_tx_metadata_complete'? [-Werror=implicit-function-declaration]
    2554 |                 xsk_tx_metadata_to_compl(meta, &tx_q->tx_skbuff_dma[entry].xsk_meta);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
         |                 xsk_tx_metadata_complete
   cc1: some warnings being treated as errors


vim +2554 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

  2464	
  2465	static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
  2466	{
  2467		struct netdev_queue *nq = netdev_get_tx_queue(priv->dev, queue);
  2468		struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
  2469		struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[queue];
  2470		struct xsk_buff_pool *pool = tx_q->xsk_pool;
  2471		unsigned int entry = tx_q->cur_tx;
  2472		struct dma_desc *tx_desc = NULL;
  2473		struct xdp_desc xdp_desc;
  2474		bool work_done = true;
  2475		u32 tx_set_ic_bit = 0;
  2476		unsigned long flags;
  2477	
  2478		/* Avoids TX time-out as we are sharing with slow path */
  2479		txq_trans_cond_update(nq);
  2480	
  2481		budget = min(budget, stmmac_tx_avail(priv, queue));
  2482	
  2483		while (budget-- > 0) {
  2484			struct stmmac_metadata_request meta_req;
  2485			struct xsk_tx_metadata *meta = NULL;
  2486			dma_addr_t dma_addr;
  2487			bool set_ic;
  2488	
  2489			/* We are sharing with slow path and stop XSK TX desc submission when
  2490			 * available TX ring is less than threshold.
  2491			 */
  2492			if (unlikely(stmmac_tx_avail(priv, queue) < STMMAC_TX_XSK_AVAIL) ||
  2493			    !netif_carrier_ok(priv->dev)) {
  2494				work_done = false;
  2495				break;
  2496			}
  2497	
  2498			if (!xsk_tx_peek_desc(pool, &xdp_desc))
  2499				break;
  2500	
  2501			if (likely(priv->extend_desc))
  2502				tx_desc = (struct dma_desc *)(tx_q->dma_etx + entry);
  2503			else if (tx_q->tbs & STMMAC_TBS_AVAIL)
  2504				tx_desc = &tx_q->dma_entx[entry].basic;
  2505			else
  2506				tx_desc = tx_q->dma_tx + entry;
  2507	
  2508			dma_addr = xsk_buff_raw_get_dma(pool, xdp_desc.addr);
  2509			meta = xsk_buff_get_metadata(pool, xdp_desc.addr);
  2510			xsk_buff_raw_dma_sync_for_device(pool, dma_addr, xdp_desc.len);
  2511	
  2512			tx_q->tx_skbuff_dma[entry].buf_type = STMMAC_TXBUF_T_XSK_TX;
  2513	
  2514			/* To return XDP buffer to XSK pool, we simple call
  2515			 * xsk_tx_completed(), so we don't need to fill up
  2516			 * 'buf' and 'xdpf'.
  2517			 */
  2518			tx_q->tx_skbuff_dma[entry].buf = 0;
  2519			tx_q->xdpf[entry] = NULL;
  2520	
  2521			tx_q->tx_skbuff_dma[entry].map_as_page = false;
  2522			tx_q->tx_skbuff_dma[entry].len = xdp_desc.len;
  2523			tx_q->tx_skbuff_dma[entry].last_segment = true;
  2524			tx_q->tx_skbuff_dma[entry].is_jumbo = false;
  2525	
  2526			stmmac_set_desc_addr(priv, tx_desc, dma_addr);
  2527	
  2528			tx_q->tx_count_frames++;
  2529	
  2530			if (!priv->tx_coal_frames[queue])
  2531				set_ic = false;
  2532			else if (tx_q->tx_count_frames % priv->tx_coal_frames[queue] == 0)
  2533				set_ic = true;
  2534			else
  2535				set_ic = false;
  2536	
  2537			meta_req.priv = priv;
  2538			meta_req.tx_desc = tx_desc;
  2539			meta_req.set_ic = &set_ic;
  2540			xsk_tx_metadata_request(meta, &stmmac_xsk_tx_metadata_ops, &meta_req);
  2541	
  2542			if (set_ic) {
  2543				tx_q->tx_count_frames = 0;
  2544				stmmac_set_tx_ic(priv, tx_desc);
  2545				tx_set_ic_bit++;
  2546			}
  2547	
  2548			stmmac_prepare_tx_desc(priv, tx_desc, 1, xdp_desc.len,
  2549					       true, priv->mode, true, true,
  2550					       xdp_desc.len);
  2551	
  2552			stmmac_enable_dma_transmission(priv, priv->ioaddr);
  2553	
> 2554			xsk_tx_metadata_to_compl(meta, &tx_q->tx_skbuff_dma[entry].xsk_meta);
  2555	
  2556			tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
  2557			entry = tx_q->cur_tx;
  2558		}
  2559		flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
  2560		txq_stats->tx_set_ic_bit += tx_set_ic_bit;
  2561		u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
  2562	
  2563		if (tx_desc) {
  2564			stmmac_flush_tx_descriptors(priv, queue);
  2565			xsk_tx_release(pool);
  2566		}
  2567	
  2568		/* Return true if all of the 3 conditions are met
  2569		 *  a) TX Budget is still available
  2570		 *  b) work_done = true when XSK TX desc peek is empty (no more
  2571		 *     pending XSK TX for transmission)
  2572		 */
  2573		return !!budget && work_done;
  2574	}
  2575	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

