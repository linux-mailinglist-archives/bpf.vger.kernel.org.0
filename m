Return-Path: <bpf+bounces-7789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9D077C70F
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 07:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25341C20C02
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 05:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95996525A;
	Tue, 15 Aug 2023 05:26:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416275241;
	Tue, 15 Aug 2023 05:26:41 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0905D1FE4;
	Mon, 14 Aug 2023 22:26:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjP9i82oJ7CQrV4+oxi7VBtUr0OK8vijRswfvF414jgeNsSDVKqu3jGEGVeJ8Ky1Y978gz8AszhHOnAoxPiJ8gWuw6Xe1kynqRo+c/GIJ7peMd0NMzSdRFuk6uLGMv6MDW1h95UGylwz3A4qoaSAYHJBJxP6GQD6VG70xlMkAadcxfs7DJcz/80+THbTR/6LZEb9nk003QcTkzljB6eqHXE7/JMr/OKqUV0AZ0lob64qeDWWFa7a8GPcD5pgIpVrp72niZMP1PhOeaURmLlrWrL34qBRna3D0lPFsOvJcJpyMmlD176bb7POHGLL87w16xouW8t97UmuBnhCBl860w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEKmPGZiijHuGEOd8vsxrZRMdDxt/xOVbdVMWUBBgHM=;
 b=Iy5JRReNMQmKiVwHbX+3Q3O6TLjHbcEBQce1dq6TRAldeDnpuMT9GoUI/LlgCox8MnNdZgkgKbET2B4UHSfgWvdT0QP6z4rlKnAzB5KvuYzQGPHKz4UQ1Q4jNMtbl0SSj17NIqFpnvf71Eas2BSwEfC+VDXYW8TWoGcbE+B8ZV6R8L0AI0pyWC5c6s2DNmkMhQ6iXUX2maa30i3JUUJVJgruspPfEHrzjgBT2oCyIj5U/vQNzGUbHmRdAFSHDl+cn4rT3qDXQnEixsQeH54pEzIwHeQq8qtjuucL28oa7me56HtINNFtr7j/IJ05iI9OYrtvyuNMO/bsbhXdZz+rrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEKmPGZiijHuGEOd8vsxrZRMdDxt/xOVbdVMWUBBgHM=;
 b=rJqbfKCA3JgMRE+I/5i4i6e8mOcY0XAo9DjNcnZqn9ZC02zj1xzqKBz0IBqwlklfZuCpZfvF49JXxEcRTapPQa6ux3jLGythjjELDjj4QqHwytL+masAjr+bbP9ncrZOZyg/HuNlUFmfav4BC0aY7d0FyT+RQ1WXgO8vSE6J6cw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DB9PR04MB8380.eurprd04.prod.outlook.com (2603:10a6:10:243::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 05:26:31 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 05:26:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	jbrouer@redhat.com,
	netdev@vger.kernel.org
Cc: linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH V6 net-next 1/2] net: fec: add XDP_TX feature support
Date: Tue, 15 Aug 2023 13:19:54 +0800
Message-Id: <20230815051955.150298-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815051955.150298-1-wei.fang@nxp.com>
References: <20230815051955.150298-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096::14) To
 AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|DB9PR04MB8380:EE_
X-MS-Office365-Filtering-Correlation-Id: c4744bab-0815-4d4b-cdea-08db9d502edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LrKp+YZZBnR/g/bnJqzntz/yUAq1nyoP3DFb9vC7uFdRyjyIsMoBgsC+TkBe1iJqzTjpOzyFJZOlD9rLav+GT6C9psm+ocd3ZUbpXzIKs3q6GZTPgH6wxnUPHDGiHxrMH4euHW/FKjVz4Yhr2xgkmGZaWYKeL+DErCBoLr9ujRwbCp6W0O6HMS7feeAOkt6JoAk94wz2G+wLcJ8kRee5Eg/IxTjW3+MYCxToqNorowEQfc2UxI8GQ7/eZXZw+HPbQ23LDZM35GUMczR7b27fhheU55KHCisYYICnA98jWoNEGvAFN15qrmw2qDYCgcHVCISzY4LB87o96khSNpkurou15s/HdbsTmEDecY2ArgpVJXATkSZmpZ4rWK3b/2D8wCCiDO3FxGb54WEan9LGHZQ2yNhPay7oxtIdxL6wMfRfpj49m7FNEwpIiI1hO+iVknb828tQlf42Vg4H4x04c+cVejlyOce8Wzse9J+UQ0lYZtC877JXVCu4g1yr6Nf5lxq2yl1AP9KMdCEzhdLlpYP/4fY4udjATKiFCmHUMAaTvNBdq7uqNXNFWVPAm0Uvzb4nS9ekWFlN1g1iTbu4X1qm2zBCLrpK93JsefUYD/YM2kcbHcVoeS/RSiJCnDIV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(186006)(1800799006)(26005)(6506007)(1076003)(966005)(6512007)(52116002)(6486002)(2616005)(6666004)(83380400001)(5660300002)(44832011)(7416002)(8676002)(8936002)(2906002)(30864003)(478600001)(316002)(41300700001)(66476007)(66556008)(66946007)(4326008)(86362001)(36756003)(38100700002)(38350700002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WJWP3dImI3d7eScIJUz+UrTQZ42BXx9VjhlGnkVWFYn2iDd7hBP7nPJwAPAR?=
 =?us-ascii?Q?5Ls/avwmtfhiVrHsLF3wTl856pWjJDhOgVukiHkZniC5oibmYLsMj+Sh5QjZ?=
 =?us-ascii?Q?YQIehfmsdKmQyv9/SVndRumLGnjGymaL9O3blf6a0PFbQKDav9lNwsz/49pa?=
 =?us-ascii?Q?eXUad5yqvsfGm7rax9BV3G95a24Czwj0faXdW9nFFO0WUzLrCX0leEhFedBq?=
 =?us-ascii?Q?QwTGD7zXejulhF+wA3dupfDFNBBZhnRAMInqmEuNcmEmPMoHLMaKafitEcwz?=
 =?us-ascii?Q?O7DypCly/p98SHotAK93ywUVr7fEgU6NmzXChj+LV3VW+xXPjwPmHUgeFrbq?=
 =?us-ascii?Q?LKvWxeWs8W4TecrKVrK32GMm8EM7DeTYpRd+b1HHDsUK+9IkvRj6XchM2gGP?=
 =?us-ascii?Q?+qRgWtVEyYXsFMYlIiT+SdSHgBOZf44GelApnUNl2G64hA/dkz1Wakt1CeU0?=
 =?us-ascii?Q?r/pnqAjiZ8uZd3a09r1jxNZHDkWG29bD5na6UsXN/RfC6hhBz6GZ7mRuDMwd?=
 =?us-ascii?Q?qMFxUF9ZQxriZQ7Ne989zE1nTiU64NkTXNjflGsBmR0NbCKIcdHBnrEaroNB?=
 =?us-ascii?Q?3weVxOXr5x4t2rhvP7sE6oHHF64fzX5ngDpyILA58lwEpeSDIMKOIEHvsArL?=
 =?us-ascii?Q?NvnjcPve2rWEphjBQpiyXSkXEWeqJ+bp8dpGCi7B3LsKxn33Li+Z4cPS6xIR?=
 =?us-ascii?Q?i2JaTm1dnbTvbHInQ+9w/QwUjJW5A/ld4QfM6MNJsNrK7CTlsIkSyxQ/gkH7?=
 =?us-ascii?Q?qVnrkLtCRHLOOFpj22NxeHEr85cZ1QfeETmeD/MME6NRAoA3yYWGT32ZsKX0?=
 =?us-ascii?Q?2DGZ9+X2YfKODJPBZyOss3CYIelaoaIKhqqpWH0KtSduzkBCFp7E0ztPZ0Yi?=
 =?us-ascii?Q?FbCHqBvj/XW3W7LIxwac6XGdykWfFo1txsX3OcdR7rAC+xAs8cvbk2Z8S9w1?=
 =?us-ascii?Q?xwuaPNWmD+x6zT25G9NooQ8rt0xOSoKKGwmhVhotXiUrJHmHqkntaBatZPyc?=
 =?us-ascii?Q?n666bu5PSd8yUBZwI+16yN0f0Bi59yzJniVdjKl3FhDaHCdYRYMkukfnET0U?=
 =?us-ascii?Q?HK8Q+QNlTDZV5cHr8E/XW0+JSHTsAM4+8ob8+twuXs5nD+cOmADEtgNhezmM?=
 =?us-ascii?Q?ToPeD2DTNQLhVJfC1QHm9UNdSZMQdGDik2F/CEJ91vkLlocrMce5LTfxB9k9?=
 =?us-ascii?Q?bVnOpLS3fWUKBQDlFJQ8QHMRNqQVIX0GyEgipbVUFA8C2sm2EglBgJunuJRt?=
 =?us-ascii?Q?zMIMRm7k01b28ECY2pQ0OizatE1Dc0xxxGOCxl1ruXDf06/6ugyxXVZjSI4J?=
 =?us-ascii?Q?pGtUf1mb6Gc7bJ+UxjeuuGf5SbMGXGeVKPyUpxMcXKu7LN5SuzDmZ/BlcgH4?=
 =?us-ascii?Q?1IWmr1XWop2S/FoQakzZibn+skRsYtLmJi8vyQTFgdw8whAXR/N5ssgVWjaq?=
 =?us-ascii?Q?f4uALGj9kZY+rG4evc7mIYdosZmqgEOLCwgVCVM9Nbn5n7O5IFadwUZCzf38?=
 =?us-ascii?Q?hrbvQLJA3rYeHN7Pfs0WWjTZpDDx8ZryBV3yHj16quqhUqpdhvEkJbAKZpvl?=
 =?us-ascii?Q?oG9UkJ0cV0BmOw8jDoluQ+fnEDFKjMItYOCog1ei?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4744bab-0815-4d4b-cdea-08db9d502edc
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 05:26:31.4838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4fbUxCEQbWEqZGIMQwI5rHOn2nNhjgOo3GuyTeDaiz03301zowzzl4N4FBbS/YGHP6eAReSjxLu40XSQ0ki/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8380
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The XDP_TX feature is not supported before, and all the frames
which are deemed to do XDP_TX action actually do the XDP_DROP
action. So this patch adds the XDP_TX support to FEC driver.

I tested the performance of XDP_TX in XDP_DRV mode and XDP_SKB
mode respectively on i.MX8MP-EVK platform, and as suggested by
Jesper, I also tested the performance of XDP_REDIRECT on the
same platform. And the test steps and results are as follows.

XDP_TX test:
Step 1: One board is used as generator and connects to switch,and
the FEC port of DUT also connects to the switch. Both boards with
flow control off. Then the generator runs the
pktgen_sample03_burst_single_flow.sh script to generate and send
burst traffic to DUT. Note that the size of packet was set to 64
bytes and the procotol of packet was UDP in my test scenario. In
addition, the SMAC of the packet need to be different from the MAC
of the generator, because the xdp2 program will swap the DMAC and
SMAC of the packet and send it back to the generator. If the SMAC
of the generated packet is the MAC of the generator, the generator
will receive the returned traffic which increase the CPU loading
and significantly degrade the transmit speed of the generator, and
finally it affects the test of XDP_TX performance.

Step 2: The DUT runs the xdp2 program to transmit received UDP
packets back out on the same port where they were received.

root@imx8mpevk:~# ./xdp2 eth0
proto 17:     353918 pkt/s
proto 17:     352923 pkt/s
proto 17:     353900 pkt/s
proto 17:     352672 pkt/s
proto 17:     353912 pkt/s
proto 17:     354219 pkt/s

root@imx8mpevk:~# ./xdp2 -S eth0
proto 17:     160604 pkt/s
proto 17:     160708 pkt/s
proto 17:     160564 pkt/s
proto 17:     160684 pkt/s
proto 17:     160640 pkt/s
proto 17:     160720 pkt/s

The above results show that the XDP_TX performance of XDP_DRV mode
is much better than XDP_SKB mode, more than twice that of XDP_SKB
mode, which is in line with our expectation.

XDP_REDIRECT test:
Step1: Both the generator and the FEC port of the DUT connet to the
switch port. All the ports with flow control off, then the generator
runs the pktgen script to generate and send burst traffic to DUT.
Note that the size of packet was set to 64 bytes and the procotol of
packet was UDP in my test scenario.

Step2: The DUT runs the xdp_redirect program to redirect the traffic
from the FEC port to the FEC port itself.

root@imx8mpevk:~# ./xdp_redirect eth0 eth0
Redirecting from eth0 (ifindex 2; driver fec) to eth0
(ifindex 2; driver fec)
Summary        232,302 rx/s        0 err,drop/s      232,344 xmit/s
Summary        234,579 rx/s        0 err,drop/s      234,577 xmit/s
Summary        235,548 rx/s        0 err,drop/s      235,549 xmit/s
Summary        234,704 rx/s        0 err,drop/s      234,703 xmit/s
Summary        235,504 rx/s        0 err,drop/s      235,504 xmit/s
Summary        235,223 rx/s        0 err,drop/s      235,224 xmit/s
Summary        234,509 rx/s        0 err,drop/s      234,507 xmit/s
Summary        235,481 rx/s        0 err,drop/s      235,482 xmit/s
Summary        234,684 rx/s        0 err,drop/s      234,683 xmit/s
Summary        235,520 rx/s        0 err,drop/s      235,520 xmit/s
Summary        235,461 rx/s        0 err,drop/s      235,461 xmit/s
Summary        234,627 rx/s        0 err,drop/s      234,627 xmit/s
Summary        235,611 rx/s        0 err,drop/s      235,611 xmit/s
  Packets received    : 3,053,753
  Average packets/s   : 234,904
  Packets transmitted : 3,053,792
  Average transmit/s  : 234,907

Compared the performance of XDP_TX with XDP_REDIRECT, XDP_TX is also
much better than XDP_REDIRECT. It's also in line with our expectation.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
V2 changes:
According to Jakub's comments, the V2 patch adds two changes.
1. Call txq_trans_cond_update() in fec_enet_xdp_tx_xmit() to avoid
tx timeout as XDP shares the queues with kernel stack.
2. Tx processing shouldn't call any XDP (or page pool) APIs if the
"budget" is 0.

V3 changes:
1. Remove the second change in V2, because this change has been
separated into another patch and it has been submmitted to the
upstream [1].
[1] https://lore.kernel.org/r/20230725074148.2936402-1-wei.fang@nxp.com

V4 changes:
1. Based on Jakub's comments, add trace_xdp_exception() for the
error path of XDP_TX.

V5 changes:
1. Implement Jesper's "sync_dma_len" suggestion and simultaneously
use page_pool_put_page(pool, page, 0, true) for XDP_TX to avoid
the DMA sync on page recycle, which is suggested by Jakub.
2. Based on Jesper's suggestion, add a benchmark comparison between
XDP_TX and XDP_REDIRECT. So the commit message is also modified
synchronously.

V6 changes:
Add some annotations to the code and fix a typo in commit message.
---
 drivers/net/ethernet/freescale/fec.h      |   1 +
 drivers/net/ethernet/freescale/fec_main.c | 107 +++++++++++++++++-----
 2 files changed, 87 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 5ca9906d7c6a..7bb02a9da2a6 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -548,6 +548,7 @@ enum {
 enum fec_txbuf_type {
 	FEC_TXBUF_T_SKB,
 	FEC_TXBUF_T_XDP_NDO,
+	FEC_TXBUF_T_XDP_TX,
 };
 
 struct fec_tx_buffer {
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 43f14cec91e9..38301c4b04e2 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -68,6 +68,7 @@
 #include <soc/imx/cpuidle.h>
 #include <linux/filter.h>
 #include <linux/bpf.h>
+#include <linux/bpf_trace.h>
 
 #include <asm/cacheflush.h>
 
@@ -75,6 +76,9 @@
 
 static void set_multicast_list(struct net_device *ndev);
 static void fec_enet_itr_coal_set(struct net_device *ndev);
+static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
+				int cpu, struct xdp_buff *xdp,
+				u32 dma_sync_len);
 
 #define DRIVER_NAME	"fec"
 
@@ -960,7 +964,8 @@ static void fec_enet_bd_init(struct net_device *dev)
 					txq->tx_buf[i].skb = NULL;
 				}
 			} else {
-				if (bdp->cbd_bufaddr)
+				if (bdp->cbd_bufaddr &&
+				    txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO)
 					dma_unmap_single(&fep->pdev->dev,
 							 fec32_to_cpu(bdp->cbd_bufaddr),
 							 fec16_to_cpu(bdp->cbd_datlen),
@@ -1423,13 +1428,14 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 				break;
 
 			xdpf = txq->tx_buf[index].xdp;
-			if (bdp->cbd_bufaddr)
+			if (bdp->cbd_bufaddr &&
+			    txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO)
 				dma_unmap_single(&fep->pdev->dev,
 						 fec32_to_cpu(bdp->cbd_bufaddr),
 						 fec16_to_cpu(bdp->cbd_datlen),
 						 DMA_TO_DEVICE);
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			if (!xdpf) {
+			if (unlikely(!xdpf)) {
 				txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
 				goto tx_buf_done;
 			}
@@ -1482,7 +1488,16 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			/* Free the sk buffer associated with this last transmit */
 			dev_kfree_skb_any(skb);
 		} else {
-			xdp_return_frame(xdpf);
+			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
+				xdp_return_frame_rx_napi(xdpf);
+			} else { /* recycle pages of XDP_TX frames */
+				struct page *page = virt_to_head_page(xdpf->data);
+
+				/* The dma_sync_size = 0 as XDP_TX has already
+				 * synced DMA for_device.
+				 */
+				page_pool_put_page(page->pp, page, 0, true);
+			}
 
 			txq->tx_buf[index].xdp = NULL;
 			/* restore default tx buffer type: FEC_TXBUF_T_SKB */
@@ -1541,7 +1556,7 @@ static void fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
 
 static u32
 fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
-		 struct xdp_buff *xdp, struct fec_enet_priv_rx_q *rxq, int index)
+		 struct xdp_buff *xdp, struct fec_enet_priv_rx_q *rxq, int cpu)
 {
 	unsigned int sync, len = xdp->data_end - xdp->data;
 	u32 ret = FEC_ENET_XDP_PASS;
@@ -1551,8 +1566,10 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
 
 	act = bpf_prog_run_xdp(prog, xdp);
 
-	/* Due xdp_adjust_tail: DMA sync for_device cover max len CPU touch */
-	sync = xdp->data_end - xdp->data_hard_start - FEC_ENET_XDP_HEADROOM;
+	/* Due xdp_adjust_tail and xdp_adjust_head: DMA sync for_device cover
+	 * max len CPU touch
+	 */
+	sync = xdp->data_end - xdp->data;
 	sync = max(sync, len);
 
 	switch (act) {
@@ -1573,11 +1590,19 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
 		}
 		break;
 
-	default:
-		bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
-		fallthrough;
-
 	case XDP_TX:
+		err = fec_enet_xdp_tx_xmit(fep, cpu, xdp, sync);
+		if (unlikely(err)) {
+			ret = FEC_ENET_XDP_CONSUMED;
+			page = virt_to_head_page(xdp->data);
+			page_pool_put_page(rxq->page_pool, page, sync, true);
+			trace_xdp_exception(fep->netdev, prog, act);
+		} else {
+			ret = FEC_ENET_XDP_TX;
+		}
+		break;
+
+	default:
 		bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
 		fallthrough;
 
@@ -1619,6 +1644,7 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
 	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
 	u32 data_start = FEC_ENET_XDP_HEADROOM;
+	int cpu = smp_processor_id();
 	struct xdp_buff xdp;
 	struct page *page;
 	u32 sub_len = 4;
@@ -1697,7 +1723,7 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
 			/* subtract 16bit shift and FCS */
 			xdp_prepare_buff(&xdp, page_address(page),
 					 data_start, pkt_len - sub_len, false);
-			ret = fec_enet_run_xdp(fep, xdp_prog, &xdp, rxq, index);
+			ret = fec_enet_run_xdp(fep, xdp_prog, &xdp, rxq, cpu);
 			xdp_result |= ret;
 			if (ret != FEC_ENET_XDP_PASS)
 				goto rx_processing_done;
@@ -3766,7 +3792,8 @@ fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
 
 static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 				   struct fec_enet_priv_tx_q *txq,
-				   struct xdp_frame *frame)
+				   struct xdp_frame *frame,
+				   u32 dma_sync_len, bool ndo_xmit)
 {
 	unsigned int index, status, estatus;
 	struct bufdesc *bdp;
@@ -3786,10 +3813,24 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 
 	index = fec_enet_get_bd_index(bdp, &txq->bd);
 
-	dma_addr = dma_map_single(&fep->pdev->dev, frame->data,
-				  frame->len, DMA_TO_DEVICE);
-	if (dma_mapping_error(&fep->pdev->dev, dma_addr))
-		return -ENOMEM;
+	if (ndo_xmit) {
+		dma_addr = dma_map_single(&fep->pdev->dev, frame->data,
+					  frame->len, DMA_TO_DEVICE);
+		if (dma_mapping_error(&fep->pdev->dev, dma_addr))
+			return -ENOMEM;
+
+		txq->tx_buf[index].type = FEC_TXBUF_T_XDP_NDO;
+	} else {
+		struct page *page = virt_to_page(frame->data);
+
+		dma_addr = page_pool_get_dma_addr(page) + sizeof(*frame) +
+			   frame->headroom;
+		dma_sync_single_for_device(&fep->pdev->dev, dma_addr,
+					   dma_sync_len, DMA_BIDIRECTIONAL);
+		txq->tx_buf[index].type = FEC_TXBUF_T_XDP_TX;
+	}
+
+	txq->tx_buf[index].xdp = frame;
 
 	status |= (BD_ENET_TX_INTR | BD_ENET_TX_LAST);
 	if (fep->bufdesc_ex)
@@ -3808,9 +3849,6 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 		ebdp->cbd_esc = cpu_to_fec32(estatus);
 	}
 
-	txq->tx_buf[index].type = FEC_TXBUF_T_XDP_NDO;
-	txq->tx_buf[index].xdp = frame;
-
 	/* Make sure the updates to rest of the descriptor are performed before
 	 * transferring ownership.
 	 */
@@ -3836,6 +3874,33 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 	return 0;
 }
 
+static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
+				int cpu, struct xdp_buff *xdp,
+				u32 dma_sync_len)
+{
+	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
+	struct fec_enet_priv_tx_q *txq;
+	struct netdev_queue *nq;
+	int queue, ret;
+
+	if (unlikely(!xdpf))
+		return -EFAULT;
+
+	queue = fec_enet_xdp_get_tx_queue(fep, cpu);
+	txq = fep->tx_queue[queue];
+	nq = netdev_get_tx_queue(fep->netdev, queue);
+
+	__netif_tx_lock(nq, cpu);
+
+	/* Avoid tx timeout as XDP shares the queue with kernel stack */
+	txq_trans_cond_update(nq);
+	ret = fec_enet_txq_xmit_frame(fep, txq, xdpf, dma_sync_len, false);
+
+	__netif_tx_unlock(nq);
+
+	return ret;
+}
+
 static int fec_enet_xdp_xmit(struct net_device *dev,
 			     int num_frames,
 			     struct xdp_frame **frames,
@@ -3858,7 +3923,7 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 	/* Avoid tx timeout as XDP shares the queue with kernel stack */
 	txq_trans_cond_update(nq);
 	for (i = 0; i < num_frames; i++) {
-		if (fec_enet_txq_xmit_frame(fep, txq, frames[i]) < 0)
+		if (fec_enet_txq_xmit_frame(fep, txq, frames[i], 0, true) < 0)
 			break;
 		sent_frames++;
 	}
-- 
2.25.1


