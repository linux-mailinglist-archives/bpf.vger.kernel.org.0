Return-Path: <bpf+bounces-2980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7F77379E3
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 05:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D8E1C20D97
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 03:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F3B1FAF;
	Wed, 21 Jun 2023 03:50:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E57A17F5;
	Wed, 21 Jun 2023 03:50:05 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F4EB4;
	Tue, 20 Jun 2023 20:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687319402; x=1718855402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TOhW2dCrEqO92/S8khU2VP1aE9OJwgUs2zYb9lyiKPU=;
  b=YcTAyeOy+kTlFrdAKIrxpyLvyxSlTTl1r/4UqgL+ydTidjkl2QltqUaS
   KFM4BFy5YNH9hxu3GPBQZyxNvaGumY4tRIGB3DUpiqTjk7Wk8VDTMSVDB
   rDos5ncsb4BmDKeduoZo6lJcxRL4lAQLH6YfEjg/gs2UEhOCClwwsSin0
   KFML1Qb3NZ+ouJ+SdSZIPjsFktbsp5Uom+5TkAyaXAYDWWl9RuyJ27jCX
   5pgiksRcBj5eb2j/DvrM8hcVL7USckht2SetFUSKZ1DtqoVqkdmbhOSQ1
   WHmV2Zuic6tMr2LgqOOiQReDBRDr35vffv63jB/RnStIcxV6DWVn6l0VF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="446431954"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="446431954"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 20:50:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="744008593"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="744008593"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Jun 2023 20:49:56 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qBoqx-0006XH-0k;
	Wed, 21 Jun 2023 03:49:55 +0000
Date: Wed, 21 Jun 2023 11:49:17 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	linux-omap@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mao Wenan <maowenan@huawei.com>, Andrew Lunn <andrew@lunn.ch>,
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Roger Quadros <rogerq@kernel.org>,
	Simon Horman <simon.horman@corigine.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 3/3] net: ethernet: ti-cpsw: fix linking built-in code to
 modules
Message-ID: <202306211136.w0yw4Tmn-lkp@intel.com>
References: <20230612124024.520720-3-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612124024.520720-3-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Arnd,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main soc/for-next linus/master v6.4-rc7 next-20230620]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnd-Bergmann/net-ethernet-ti-cpsw-rename-soft_reset-function/20230612-211612
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230612124024.520720-3-arnd%40kernel.org
patch subject: [PATCH 3/3] net: ethernet: ti-cpsw: fix linking built-in code to modules
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230621/202306211136.w0yw4Tmn-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230621/202306211136.w0yw4Tmn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306211136.w0yw4Tmn-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.o: in function `cpsw_intr_enable':
>> drivers/net/ethernet/ti/cpsw_priv.c:42: undefined reference to `cpdma_ctlr_int_ctrl'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.o: in function `cpsw_intr_disable':
   drivers/net/ethernet/ti/cpsw_priv.c:51: undefined reference to `cpdma_ctlr_int_ctrl'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.o: in function `cpsw_misc_interrupt':
>> drivers/net/ethernet/ti/cpsw_priv.c:129: undefined reference to `cpdma_ctlr_eoi'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.o: in function `cpsw_rx_interrupt':
   drivers/net/ethernet/ti/cpsw_priv.c:112: undefined reference to `cpdma_ctlr_eoi'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.o: in function `cpsw_tx_mq_poll':
>> drivers/net/ethernet/ti/cpsw_priv.c:145: undefined reference to `cpdma_ctrl_txchs_state'
>> aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.c:156: undefined reference to `cpdma_chan_process'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.o: in function `cpsw_rx_mq_poll':
>> drivers/net/ethernet/ti/cpsw_priv.c:197: undefined reference to `cpdma_ctrl_rxchs_state'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.c:208: undefined reference to `cpdma_chan_process'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.o: in function `cpsw_need_resplit':
>> drivers/net/ethernet/ti/cpsw_priv.c:348: undefined reference to `cpdma_chan_get_rate'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.o: in function `cpsw_split_res':
   drivers/net/ethernet/ti/cpsw_priv.c:373: undefined reference to `cpdma_chan_get_rate'
>> aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.c:422: undefined reference to `cpdma_chan_set_weight'
>> aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.c:409: undefined reference to `cpdma_chan_get_rate'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.c:427: undefined reference to `cpdma_chan_set_weight'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.o: in function `cpsw_init_common':
>> drivers/net/ethernet/ti/cpsw_priv.c:548: undefined reference to `cpdma_ctlr_create'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.o: in function `cpsw_create_rx_pool':
>> drivers/net/ethernet/ti/cpsw_priv.c:1197: undefined reference to `cpdma_chan_get_rx_buf_num'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.o: in function `cpsw_xdp_tx_frame':
>> drivers/net/ethernet/ti/cpsw_priv.c:1336: undefined reference to `cpdma_chan_submit_mapped'
>> aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.c:1342: undefined reference to `cpdma_chan_submit'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.o: in function `cpsw_tx_poll':
>> drivers/net/ethernet/ti/cpsw_priv.c:175: undefined reference to `cpdma_chan_process'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.o: in function `cpsw_rx_poll':
   drivers/net/ethernet/ti/cpsw_priv.c:227: undefined reference to `cpdma_chan_process'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.o: in function `cpsw_tx_interrupt':
   drivers/net/ethernet/ti/cpsw_priv.c:95: undefined reference to `cpdma_ctlr_eoi'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.o: in function `cpsw_fill_rx_channels':
   drivers/net/ethernet/ti/cpsw_priv.c:1138: undefined reference to `cpdma_chan_get_rx_buf_num'
>> aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.c:1151: undefined reference to `cpdma_chan_idle_submit_mapped'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.o: in function `cpsw_intr_disable':
   drivers/net/ethernet/ti/cpsw_priv.c:51: undefined reference to `cpdma_ctlr_int_ctrl'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.o: in function `cpsw_ndo_tx_timeout':
>> drivers/net/ethernet/ti/cpsw_priv.c:314: undefined reference to `cpdma_chan_stop'
>> aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.c:315: undefined reference to `cpdma_chan_start'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.o: in function `cpsw_intr_enable':
>> drivers/net/ethernet/ti/cpsw_priv.c:42: undefined reference to `cpdma_ctlr_int_ctrl'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.o: in function `cpsw_ndo_set_tx_maxrate':
>> drivers/net/ethernet/ti/cpsw_priv.c:766: undefined reference to `cpdma_chan_get_min_rate'
>> aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_priv.c:782: undefined reference to `cpdma_chan_set_rate'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_ethtool.o: in function `cpsw_update_channels_res':
>> drivers/net/ethernet/ti/cpsw_ethtool.c:575: undefined reference to `cpdma_chan_create'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_ethtool.c:593: undefined reference to `cpdma_chan_destroy'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_ethtool.o: in function `cpsw_suspend_data_pass':
   drivers/net/ethernet/ti/cpsw_ethtool.c:503: undefined reference to `cpdma_ctlr_stop'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_ethtool.o: in function `cpsw_resume_data_pass':
   drivers/net/ethernet/ti/cpsw_ethtool.c:518: undefined reference to `cpdma_ctlr_start'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_ethtool.o: in function `cpsw_get_ringparam':
   drivers/net/ethernet/ti/cpsw_ethtool.c:689: undefined reference to `cpdma_get_num_tx_descs'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_ethtool.c:691: undefined reference to `cpdma_get_num_rx_descs'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_ethtool.o: in function `cpsw_get_ethtool_stats':
   drivers/net/ethernet/ti/cpsw_ethtool.c:295: undefined reference to `cpdma_chan_get_stats'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_ethtool.c:304: undefined reference to `cpdma_chan_get_stats'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_ethtool.o: in function `cpsw_set_ringparam':
   drivers/net/ethernet/ti/cpsw_ethtool.c:710: undefined reference to `cpdma_get_num_rx_descs'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_ethtool.c:716: undefined reference to `cpdma_set_num_rx_descs'
   aarch64-linux-ld: drivers/net/ethernet/ti/cpsw_ethtool.c:735: undefined reference to `cpdma_set_num_rx_descs'


vim +42 drivers/net/ethernet/ti/cpsw_priv.c

51a9533797b07b Grygorii Strashko 2019-11-20   36  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   37  void cpsw_intr_enable(struct cpsw_common *cpsw)
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   38  {
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   39  	writel_relaxed(0xFF, &cpsw->wr_regs->tx_en);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   40  	writel_relaxed(0xFF, &cpsw->wr_regs->rx_en);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   41  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  @42  	cpdma_ctlr_int_ctrl(cpsw->dma, true);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   43  }
c8722a36e372f4 Arnd Bergmann     2023-06-12   44  EXPORT_SYMBOL_GPL(cpsw_intr_enable);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   45  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   46  void cpsw_intr_disable(struct cpsw_common *cpsw)
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   47  {
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   48  	writel_relaxed(0, &cpsw->wr_regs->tx_en);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   49  	writel_relaxed(0, &cpsw->wr_regs->rx_en);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   50  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  @51  	cpdma_ctlr_int_ctrl(cpsw->dma, false);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   52  }
c8722a36e372f4 Arnd Bergmann     2023-06-12   53  EXPORT_SYMBOL_GPL(cpsw_intr_disable);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   54  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   55  void cpsw_tx_handler(void *token, int len, int status)
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   56  {
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   57  	struct cpsw_meta_xdp	*xmeta;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   58  	struct xdp_frame	*xdpf;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   59  	struct net_device	*ndev;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   60  	struct netdev_queue	*txq;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   61  	struct sk_buff		*skb;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   62  	int			ch;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   63  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   64  	if (cpsw_is_xdpf_handle(token)) {
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   65  		xdpf = cpsw_handle_to_xdpf(token);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   66  		xmeta = (void *)xdpf + CPSW_XMETA_OFFSET;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   67  		ndev = xmeta->ndev;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   68  		ch = xmeta->ch;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   69  		xdp_return_frame(xdpf);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   70  	} else {
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   71  		skb = token;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   72  		ndev = skb->dev;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   73  		ch = skb_get_queue_mapping(skb);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   74  		cpts_tx_timestamp(ndev_to_cpsw(ndev)->cpts, skb);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   75  		dev_kfree_skb_any(skb);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   76  	}
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   77  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   78  	/* Check whether the queue is stopped due to stalled tx dma, if the
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   79  	 * queue is stopped then start the queue as we have free desc for tx
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   80  	 */
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   81  	txq = netdev_get_tx_queue(ndev, ch);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   82  	if (unlikely(netif_tx_queue_stopped(txq)))
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   83  		netif_tx_wake_queue(txq);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   84  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   85  	ndev->stats.tx_packets++;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   86  	ndev->stats.tx_bytes += len;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   87  }
c8722a36e372f4 Arnd Bergmann     2023-06-12   88  EXPORT_SYMBOL_GPL(cpsw_tx_handler);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   89  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   90  irqreturn_t cpsw_tx_interrupt(int irq, void *dev_id)
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   91  {
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   92  	struct cpsw_common *cpsw = dev_id;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   93  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   94  	writel(0, &cpsw->wr_regs->tx_en);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  @95  	cpdma_ctlr_eoi(cpsw->dma, CPDMA_EOI_TX);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   96  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   97  	if (cpsw->quirk_irq) {
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   98  		disable_irq_nosync(cpsw->irqs_table[1]);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20   99  		cpsw->tx_irq_disabled = true;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  100  	}
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  101  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  102  	napi_schedule(&cpsw->napi_tx);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  103  	return IRQ_HANDLED;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  104  }
c8722a36e372f4 Arnd Bergmann     2023-06-12  105  EXPORT_SYMBOL_GPL(cpsw_tx_interrupt);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  106  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  107  irqreturn_t cpsw_rx_interrupt(int irq, void *dev_id)
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  108  {
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  109  	struct cpsw_common *cpsw = dev_id;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  110  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  111  	writel(0, &cpsw->wr_regs->rx_en);
51302f77bedab8 Grygorii Strashko 2019-12-06 @112  	cpdma_ctlr_eoi(cpsw->dma, CPDMA_EOI_RX);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  113  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  114  	if (cpsw->quirk_irq) {
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  115  		disable_irq_nosync(cpsw->irqs_table[0]);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  116  		cpsw->rx_irq_disabled = true;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  117  	}
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  118  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  119  	napi_schedule(&cpsw->napi_rx);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  120  	return IRQ_HANDLED;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  121  }
c8722a36e372f4 Arnd Bergmann     2023-06-12  122  EXPORT_SYMBOL_GPL(cpsw_rx_interrupt);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  123  
84ea9c0a95d7b3 Grygorii Strashko 2020-04-23  124  irqreturn_t cpsw_misc_interrupt(int irq, void *dev_id)
84ea9c0a95d7b3 Grygorii Strashko 2020-04-23  125  {
84ea9c0a95d7b3 Grygorii Strashko 2020-04-23  126  	struct cpsw_common *cpsw = dev_id;
84ea9c0a95d7b3 Grygorii Strashko 2020-04-23  127  
84ea9c0a95d7b3 Grygorii Strashko 2020-04-23  128  	writel(0, &cpsw->wr_regs->misc_en);
84ea9c0a95d7b3 Grygorii Strashko 2020-04-23 @129  	cpdma_ctlr_eoi(cpsw->dma, CPDMA_EOI_MISC);
84ea9c0a95d7b3 Grygorii Strashko 2020-04-23  130  	cpts_misc_interrupt(cpsw->cpts);
84ea9c0a95d7b3 Grygorii Strashko 2020-04-23  131  	writel(0x10, &cpsw->wr_regs->misc_en);
84ea9c0a95d7b3 Grygorii Strashko 2020-04-23  132  
84ea9c0a95d7b3 Grygorii Strashko 2020-04-23  133  	return IRQ_HANDLED;
84ea9c0a95d7b3 Grygorii Strashko 2020-04-23  134  }
c8722a36e372f4 Arnd Bergmann     2023-06-12  135  EXPORT_SYMBOL_GPL(cpsw_misc_interrupt);
84ea9c0a95d7b3 Grygorii Strashko 2020-04-23  136  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  137  int cpsw_tx_mq_poll(struct napi_struct *napi_tx, int budget)
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  138  {
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  139  	struct cpsw_common	*cpsw = napi_to_cpsw(napi_tx);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  140  	int			num_tx, cur_budget, ch;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  141  	u32			ch_map;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  142  	struct cpsw_vector	*txv;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  143  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  144  	/* process every unprocessed channel */
c5013ac1dd0e11 Grygorii Strashko 2019-11-20 @145  	ch_map = cpdma_ctrl_txchs_state(cpsw->dma);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  146  	for (ch = 0, num_tx = 0; ch_map & 0xff; ch_map <<= 1, ch++) {
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  147  		if (!(ch_map & 0x80))
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  148  			continue;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  149  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  150  		txv = &cpsw->txv[ch];
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  151  		if (unlikely(txv->budget > budget - num_tx))
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  152  			cur_budget = budget - num_tx;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  153  		else
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  154  			cur_budget = txv->budget;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  155  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20 @156  		num_tx += cpdma_chan_process(txv->ch, cur_budget);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  157  		if (num_tx >= budget)
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  158  			break;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  159  	}
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  160  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  161  	if (num_tx < budget) {
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  162  		napi_complete(napi_tx);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  163  		writel(0xff, &cpsw->wr_regs->tx_en);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  164  	}
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  165  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  166  	return num_tx;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  167  }
c8722a36e372f4 Arnd Bergmann     2023-06-12  168  EXPORT_SYMBOL_GPL(cpsw_tx_mq_poll);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  169  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  170  int cpsw_tx_poll(struct napi_struct *napi_tx, int budget)
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  171  {
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  172  	struct cpsw_common *cpsw = napi_to_cpsw(napi_tx);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  173  	int num_tx;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  174  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20 @175  	num_tx = cpdma_chan_process(cpsw->txv[0].ch, budget);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  176  	if (num_tx < budget) {
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  177  		napi_complete(napi_tx);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  178  		writel(0xff, &cpsw->wr_regs->tx_en);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  179  		if (cpsw->tx_irq_disabled) {
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  180  			cpsw->tx_irq_disabled = false;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  181  			enable_irq(cpsw->irqs_table[1]);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  182  		}
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  183  	}
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  184  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  185  	return num_tx;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  186  }
c8722a36e372f4 Arnd Bergmann     2023-06-12  187  EXPORT_SYMBOL_GPL(cpsw_tx_poll);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  188  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  189  int cpsw_rx_mq_poll(struct napi_struct *napi_rx, int budget)
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  190  {
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  191  	struct cpsw_common	*cpsw = napi_to_cpsw(napi_rx);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  192  	int			num_rx, cur_budget, ch;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  193  	u32			ch_map;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  194  	struct cpsw_vector	*rxv;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  195  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  196  	/* process every unprocessed channel */
c5013ac1dd0e11 Grygorii Strashko 2019-11-20 @197  	ch_map = cpdma_ctrl_rxchs_state(cpsw->dma);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  198  	for (ch = 0, num_rx = 0; ch_map; ch_map >>= 1, ch++) {
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  199  		if (!(ch_map & 0x01))
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  200  			continue;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  201  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  202  		rxv = &cpsw->rxv[ch];
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  203  		if (unlikely(rxv->budget > budget - num_rx))
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  204  			cur_budget = budget - num_rx;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  205  		else
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  206  			cur_budget = rxv->budget;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  207  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20 @208  		num_rx += cpdma_chan_process(rxv->ch, cur_budget);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  209  		if (num_rx >= budget)
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  210  			break;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  211  	}
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  212  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  213  	if (num_rx < budget) {
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  214  		napi_complete_done(napi_rx, num_rx);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  215  		writel(0xff, &cpsw->wr_regs->rx_en);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  216  	}
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  217  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  218  	return num_rx;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  219  }
c8722a36e372f4 Arnd Bergmann     2023-06-12  220  EXPORT_SYMBOL_GPL(cpsw_rx_mq_poll);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  221  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  222  int cpsw_rx_poll(struct napi_struct *napi_rx, int budget)
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  223  {
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  224  	struct cpsw_common *cpsw = napi_to_cpsw(napi_rx);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  225  	int num_rx;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  226  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20 @227  	num_rx = cpdma_chan_process(cpsw->rxv[0].ch, budget);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  228  	if (num_rx < budget) {
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  229  		napi_complete_done(napi_rx, num_rx);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  230  		writel(0xff, &cpsw->wr_regs->rx_en);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  231  		if (cpsw->rx_irq_disabled) {
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  232  			cpsw->rx_irq_disabled = false;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  233  			enable_irq(cpsw->irqs_table[0]);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  234  		}
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  235  	}
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  236  
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  237  	return num_rx;
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  238  }
c8722a36e372f4 Arnd Bergmann     2023-06-12  239  EXPORT_SYMBOL_GPL(cpsw_rx_poll);
c5013ac1dd0e11 Grygorii Strashko 2019-11-20  240  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

