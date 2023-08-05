Return-Path: <bpf+bounces-7079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A634977103D
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 16:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C091C20A8F
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 14:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F01C2C4;
	Sat,  5 Aug 2023 14:54:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B04C14E;
	Sat,  5 Aug 2023 14:54:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA8C4224;
	Sat,  5 Aug 2023 07:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691247279; x=1722783279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SNpO8s2Puaea/gNGT1ZAF0hZB1LiLcNevTA2WkJ2yiI=;
  b=fjORrm2DurZI4KD7x1ycG0gxp8ql5MLrhXZBqxERjri61SVilhKaeDu1
   igUpv0yFCU8OHW3Ay2xxiA4i4aLjonaUelPE5ubQbddwafSU1tv28Wq3t
   C4xMMQQk4rsYJaNj9QoEj6Wg1B8DMaW+XLf1Q/8HolqhLDnsb17FS90eH
   UGJYmV6TwcNNeK1JKEY/hvECUAvX5oF3Tc/hKpFWViLsPCnFTROEWjaao
   U3/i6z/w9tSCoX2irf9caHeNz54XP509h8/RUNFG6gHwu7gly0vjZ3giP
   94fA6Y1mCgP4O6bqjCubzbzyVde0H9CG+T6hWyhWmkx4ES2hoCi7+5JlX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="360383217"
X-IronPort-AV: E=Sophos;i="6.01,257,1684825200"; 
   d="scan'208";a="360383217"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2023 07:54:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="873745442"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Aug 2023 07:54:37 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qSIfp-0003ZL-0U;
	Sat, 05 Aug 2023 14:54:33 +0000
Date: Sat, 5 Aug 2023 22:54:09 +0800
From: kernel test robot <lkp@intel.com>
To: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc: oe-kbuild-all@lists.linux.dev, Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, intel-wired-lan@lists.osuosl.org,
	bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Magnus Karlsson <magnus.karlsson@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 3/4] igb: add AF_XDP
 zero-copy Rx support
Message-ID: <202308052204.SQxxKnNI-lkp@intel.com>
References: <20230804084051.14194-4-sriram.yagnaraman@est.tech>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804084051.14194-4-sriram.yagnaraman@est.tech>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Sriram,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tnguy-next-queue/dev-queue]

url:    https://github.com/intel-lab-lkp/linux/commits/Sriram-Yagnaraman/igb-prepare-for-AF_XDP-zero-copy-support/20230804-164354
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20230804084051.14194-4-sriram.yagnaraman%40est.tech
patch subject: [Intel-wired-lan] [PATCH iwl-next v4 3/4] igb: add AF_XDP zero-copy Rx support
config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/20230805/202308052204.SQxxKnNI-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230805/202308052204.SQxxKnNI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308052204.SQxxKnNI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/igb/igb_main.c: In function 'igb_dump':
>> drivers/net/ethernet/intel/igb/igb_main.c:505:42: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     505 |                         dma_addr_t dma = (dma_addr_t)NULL;
         |                                          ^


vim +505 drivers/net/ethernet/intel/igb/igb_main.c

   348	
   349	/* igb_dump - Print registers, Tx-rings and Rx-rings */
   350	static void igb_dump(struct igb_adapter *adapter)
   351	{
   352		struct net_device *netdev = adapter->netdev;
   353		struct e1000_hw *hw = &adapter->hw;
   354		struct igb_reg_info *reginfo;
   355		struct igb_ring *tx_ring;
   356		union e1000_adv_tx_desc *tx_desc;
   357		struct my_u0 { __le64 a; __le64 b; } *u0;
   358		struct igb_ring *rx_ring;
   359		union e1000_adv_rx_desc *rx_desc;
   360		u32 staterr;
   361		u16 i, n;
   362	
   363		if (!netif_msg_hw(adapter))
   364			return;
   365	
   366		/* Print netdevice Info */
   367		if (netdev) {
   368			dev_info(&adapter->pdev->dev, "Net device Info\n");
   369			pr_info("Device Name     state            trans_start\n");
   370			pr_info("%-15s %016lX %016lX\n", netdev->name,
   371				netdev->state, dev_trans_start(netdev));
   372		}
   373	
   374		/* Print Registers */
   375		dev_info(&adapter->pdev->dev, "Register Dump\n");
   376		pr_info(" Register Name   Value\n");
   377		for (reginfo = (struct igb_reg_info *)igb_reg_info_tbl;
   378		     reginfo->name; reginfo++) {
   379			igb_regdump(hw, reginfo);
   380		}
   381	
   382		/* Print TX Ring Summary */
   383		if (!netdev || !netif_running(netdev))
   384			goto exit;
   385	
   386		dev_info(&adapter->pdev->dev, "TX Rings Summary\n");
   387		pr_info("Queue [NTU] [NTC] [bi(ntc)->dma  ] leng ntw timestamp\n");
   388		for (n = 0; n < adapter->num_tx_queues; n++) {
   389			struct igb_tx_buffer *buffer_info;
   390			tx_ring = adapter->tx_ring[n];
   391			buffer_info = &tx_ring->tx_buffer_info[tx_ring->next_to_clean];
   392			pr_info(" %5d %5X %5X %016llX %04X %p %016llX\n",
   393				n, tx_ring->next_to_use, tx_ring->next_to_clean,
   394				(u64)dma_unmap_addr(buffer_info, dma),
   395				dma_unmap_len(buffer_info, len),
   396				buffer_info->next_to_watch,
   397				(u64)buffer_info->time_stamp);
   398		}
   399	
   400		/* Print TX Rings */
   401		if (!netif_msg_tx_done(adapter))
   402			goto rx_ring_summary;
   403	
   404		dev_info(&adapter->pdev->dev, "TX Rings Dump\n");
   405	
   406		/* Transmit Descriptor Formats
   407		 *
   408		 * Advanced Transmit Descriptor
   409		 *   +--------------------------------------------------------------+
   410		 * 0 |         Buffer Address [63:0]                                |
   411		 *   +--------------------------------------------------------------+
   412		 * 8 | PAYLEN  | PORTS  |CC|IDX | STA | DCMD  |DTYP|MAC|RSV| DTALEN |
   413		 *   +--------------------------------------------------------------+
   414		 *   63      46 45    40 39 38 36 35 32 31   24             15       0
   415		 */
   416	
   417		for (n = 0; n < adapter->num_tx_queues; n++) {
   418			tx_ring = adapter->tx_ring[n];
   419			pr_info("------------------------------------\n");
   420			pr_info("TX QUEUE INDEX = %d\n", tx_ring->queue_index);
   421			pr_info("------------------------------------\n");
   422			pr_info("T [desc]     [address 63:0  ] [PlPOCIStDDM Ln] [bi->dma       ] leng  ntw timestamp        bi->skb\n");
   423	
   424			for (i = 0; tx_ring->desc && (i < tx_ring->count); i++) {
   425				const char *next_desc;
   426				struct igb_tx_buffer *buffer_info;
   427				tx_desc = IGB_TX_DESC(tx_ring, i);
   428				buffer_info = &tx_ring->tx_buffer_info[i];
   429				u0 = (struct my_u0 *)tx_desc;
   430				if (i == tx_ring->next_to_use &&
   431				    i == tx_ring->next_to_clean)
   432					next_desc = " NTC/U";
   433				else if (i == tx_ring->next_to_use)
   434					next_desc = " NTU";
   435				else if (i == tx_ring->next_to_clean)
   436					next_desc = " NTC";
   437				else
   438					next_desc = "";
   439	
   440				pr_info("T [0x%03X]    %016llX %016llX %016llX %04X  %p %016llX %p%s\n",
   441					i, le64_to_cpu(u0->a),
   442					le64_to_cpu(u0->b),
   443					(u64)dma_unmap_addr(buffer_info, dma),
   444					dma_unmap_len(buffer_info, len),
   445					buffer_info->next_to_watch,
   446					(u64)buffer_info->time_stamp,
   447					buffer_info->skb, next_desc);
   448	
   449				if (netif_msg_pktdata(adapter) && buffer_info->skb)
   450					print_hex_dump(KERN_INFO, "",
   451						DUMP_PREFIX_ADDRESS,
   452						16, 1, buffer_info->skb->data,
   453						dma_unmap_len(buffer_info, len),
   454						true);
   455			}
   456		}
   457	
   458		/* Print RX Rings Summary */
   459	rx_ring_summary:
   460		dev_info(&adapter->pdev->dev, "RX Rings Summary\n");
   461		pr_info("Queue [NTU] [NTC]\n");
   462		for (n = 0; n < adapter->num_rx_queues; n++) {
   463			rx_ring = adapter->rx_ring[n];
   464			pr_info(" %5d %5X %5X\n",
   465				n, rx_ring->next_to_use, rx_ring->next_to_clean);
   466		}
   467	
   468		/* Print RX Rings */
   469		if (!netif_msg_rx_status(adapter))
   470			goto exit;
   471	
   472		dev_info(&adapter->pdev->dev, "RX Rings Dump\n");
   473	
   474		/* Advanced Receive Descriptor (Read) Format
   475		 *    63                                           1        0
   476		 *    +-----------------------------------------------------+
   477		 *  0 |       Packet Buffer Address [63:1]           |A0/NSE|
   478		 *    +----------------------------------------------+------+
   479		 *  8 |       Header Buffer Address [63:1]           |  DD  |
   480		 *    +-----------------------------------------------------+
   481		 *
   482		 *
   483		 * Advanced Receive Descriptor (Write-Back) Format
   484		 *
   485		 *   63       48 47    32 31  30      21 20 17 16   4 3     0
   486		 *   +------------------------------------------------------+
   487		 * 0 | Packet     IP     |SPH| HDR_LEN   | RSV|Packet|  RSS |
   488		 *   | Checksum   Ident  |   |           |    | Type | Type |
   489		 *   +------------------------------------------------------+
   490		 * 8 | VLAN Tag | Length | Extended Error | Extended Status |
   491		 *   +------------------------------------------------------+
   492		 *   63       48 47    32 31            20 19               0
   493		 */
   494	
   495		for (n = 0; n < adapter->num_rx_queues; n++) {
   496			rx_ring = adapter->rx_ring[n];
   497			pr_info("------------------------------------\n");
   498			pr_info("RX QUEUE INDEX = %d\n", rx_ring->queue_index);
   499			pr_info("------------------------------------\n");
   500			pr_info("R  [desc]      [ PktBuf     A0] [  HeadBuf   DD] [bi->dma       ] [bi->skb] <-- Adv Rx Read format\n");
   501			pr_info("RWB[desc]      [PcsmIpSHl PtRs] [vl er S cks ln] ---------------- [bi->skb] <-- Adv Rx Write-Back format\n");
   502	
   503			for (i = 0; i < rx_ring->count; i++) {
   504				const char *next_desc;
 > 505				dma_addr_t dma = (dma_addr_t)NULL;
   506				struct igb_rx_buffer *buffer_info = NULL;
   507				rx_desc = IGB_RX_DESC(rx_ring, i);
   508				u0 = (struct my_u0 *)rx_desc;
   509				staterr = le32_to_cpu(rx_desc->wb.upper.status_error);
   510	
   511				if (!rx_ring->xsk_pool) {
   512					buffer_info = &rx_ring->rx_buffer_info[i];
   513					dma = buffer_info->dma;
   514				}
   515	
   516				if (i == rx_ring->next_to_use)
   517					next_desc = " NTU";
   518				else if (i == rx_ring->next_to_clean)
   519					next_desc = " NTC";
   520				else
   521					next_desc = "";
   522	
   523				if (staterr & E1000_RXD_STAT_DD) {
   524					/* Descriptor Done */
   525					pr_info("%s[0x%03X]     %016llX %016llX ---------------- %s\n",
   526						"RWB", i,
   527						le64_to_cpu(u0->a),
   528						le64_to_cpu(u0->b),
   529						next_desc);
   530				} else {
   531					pr_info("%s[0x%03X]     %016llX %016llX %016llX %s\n",
   532						"R  ", i,
   533						le64_to_cpu(u0->a),
   534						le64_to_cpu(u0->b),
   535						(u64)dma,
   536						next_desc);
   537	
   538					if (netif_msg_pktdata(adapter) &&
   539					    buffer_info && dma && buffer_info->page) {
   540						print_hex_dump(KERN_INFO, "",
   541						  DUMP_PREFIX_ADDRESS,
   542						  16, 1,
   543						  page_address(buffer_info->page) +
   544							      buffer_info->page_offset,
   545						  igb_rx_bufsz(rx_ring), true);
   546					}
   547				}
   548			}
   549		}
   550	
   551	exit:
   552		return;
   553	}
   554	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

