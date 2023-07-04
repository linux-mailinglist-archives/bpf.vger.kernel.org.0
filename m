Return-Path: <bpf+bounces-3955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7B5746E29
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 12:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449B0280E88
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 10:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47305680;
	Tue,  4 Jul 2023 09:59:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E085675;
	Tue,  4 Jul 2023 09:59:31 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2127.outbound.protection.outlook.com [40.107.104.127])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBCBD8;
	Tue,  4 Jul 2023 02:59:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auZM0887El8mWDXSgdZXcRPaYX92w0GplhlJd4UOmZDZed/9JCJrQNtQV5BHQGoUjhwvHdVYiqKeF8m14HBY3KayQc197mPjFCc0erXbd5WsqpxYWQMBW3C/NdLzTeN7w30GECQ+R1N/a0DxJTriuZ1AqSUe1RK9HXblL5Vk2Z2fDxvmB9gD4XJdtsA2prwKDTalkGwrAMwzfs5mCYiPDkF340uok07KmxezSttyAiPUMXySmdViNQ1php/U+QHG3QcTAugJtPqsNMUk3Lik1jXlUCNoBIsKRlMUY/RwZJRJXL9Jwmk5QUpmJ18TdnSNuxy6jE46G1ABZ1tFmHDCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qw1EF8drZGNNP3tA0KIsCrzE+OpJ//eA1Ms/6WzqSR4=;
 b=AG8G0486BRqEtWohdXlvqqvy6R4TtsK6872fn5XTqc8HQCqa2DDhI+WdO62BQj24ZOLG+ajI/nEZb6nBBterGhFuaypxorJz3bLgNl/r8XqAd4tVdhxBDo5Il0iEgNv3d3ODLUATMDjZ/vMJedb34vAWcMkQ2ItbP5tUS2nR4e34HfdBpjwF5yGbmb8DLnVD9D+fE63VJxs/oPgpuG2aexcCU7aTOPF8XwuBd02eiYva8oX6btIf92DLLrX0zbz6VOobC6nzNZJ8+vltnbW/fgqSsBqfncln7RaXIoxdWl/1lPfCniBCJgEJxZMqjQyBCPpVJ8y+APwKhziNVKbx5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qw1EF8drZGNNP3tA0KIsCrzE+OpJ//eA1Ms/6WzqSR4=;
 b=UIokEjrbUPGqwVTCUaUiMWr1gnFxOH4i0YJhhehppSh6/iVuiL9Mw3PVSrqcKesoYarPdGxAgvqjTuY+sACDDch7UOfMA4FUBsFGHv3c0nsP+B4gY6gPTcse2OPZgiZzDeY7AwP3ouEGYRPeFy99kcWufXYaNr8sRIE9VA2ELqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by VI1P18901MB0783.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:123::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 09:59:24 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6%4]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 09:59:23 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To:
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Subject: [PATCH 3/4] igb: add AF_XDP zero-copy Rx support
Date: Tue,  4 Jul 2023 11:59:14 +0200
Message-Id: <20230704095915.9750-4-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704095915.9750-1-sriram.yagnaraman@est.tech>
References: <20230704095915.9750-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF000000FF.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:1:0:9) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|VI1P18901MB0783:EE_
X-MS-Office365-Filtering-Correlation-Id: a5eb64e5-aaf3-4fbc-9734-08db7c75577c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nCsPodp5VJG7IasUbvOh5LE/Rasrvioblpo0lmKXRW5ngS64xBnZMJOt6urMWsUS6bMUYUa7KPZY6lWahuiu2T28DJDaX+fXj+S3R0rZGbGRFdWmoZrWjtV9rtWDsG1ztuzZzo8XfIyCntDC8Jx32/BpAZ5CfiCkXidHl0Zf8txaXkdR0mclfzmo8HWg6qcXHPyDIUN7PqYzNyHENYZdShquC8pJdRneaOZtXDR6wn/8AYqCgGlkbr7nAqVSQlOi9W+P/m2fjp19toN+OzT264ta9gtGG7Jy1RkGKeJMoeWdU/JMtXkNTDj5/ozpAMn3CHIAnWF32O2l2pyjym5JcAwWJOgcoCZH091Ce8OdFJgv0VQFjn+mxD2WajL2P9q17eYPnlLyB91Gl5NKrnVDpCfk+/lyMO60bmltPMYXMmDT7uWZXR6m5H4NawH41l/BzdJkLumjs78dv+VEc6cRjZTwVvtXbvuKPZ9OKWFR19//e2Z3rPZIUVqzVfIIXJsYtQw67ax8av4VfeUb79B9YGJK0EYBzOu9PS8M4kQk/UK5+F0dJOoHULypay75aR8waEvP3E2U5Pw0uDtHAdJJLQtxJEpfjAg+ZRzyjOtFu7L/4hCZHmQGbT1ctL+fEub/WKE9S62zSZJPY/H51BeC4g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(39830400003)(376002)(346002)(136003)(451199021)(109986019)(316002)(41300700001)(6512007)(6486002)(26005)(83380400001)(6506007)(1076003)(2616005)(186003)(478600001)(66899021)(6666004)(54906003)(38100700002)(44832011)(66556008)(66476007)(4326008)(66946007)(70586007)(5660300002)(7416002)(86362001)(30864003)(36756003)(8936002)(2906002)(8676002)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+KBm1UWvEbSTbgcgE9zGGSvMh3MhmbLROocnw97GCRtD9m4vUug3bf8s98FH?=
 =?us-ascii?Q?QxDPGvEtv7+/VQ2MAHi7cEuFXLHnzer++1LCP8BJ1RTzP8bgS08lU46syFWI?=
 =?us-ascii?Q?4cJcULL64EvOLBj+PPXXPOWuoVBvfQyzikaLKKTDwIOh1u+umNXDSI0A8l0t?=
 =?us-ascii?Q?w1ZOQIeOdMQBJwTfRxGSgN2kShghGsQAiomsNTRAMpWUjDPWddz0akHBsL6V?=
 =?us-ascii?Q?SR5Qluaql9xNmIFd2TDsFO36ef1E6r6rrnMjIQycRDnqyof94u/ZZO6HDSPa?=
 =?us-ascii?Q?j7xfeGqszuxiaUYbfBCJkrPP8Bty0K1fP9jJM61qurw1xUqa9ejk1lloD67b?=
 =?us-ascii?Q?eOtU2fLALrnYm2OEvRGP38K1X4tLAYYu0oQ5/nEIFeFqKgrUSWr9jUgb8KZc?=
 =?us-ascii?Q?sQS23eBIqtDT40k0+qUH+WBKsyRqcqarjMbpWCyblpHvgfhI1WVuAvM425Fx?=
 =?us-ascii?Q?eZnA+TxqwIKmibpUcujUUn++qIwjH7+e/pf1Xx9a4nbKnu0xpdgHbwfepc84?=
 =?us-ascii?Q?PuO7UmooxxSiYYek5sGsHOj7jIpIiHQIR33MsfJj3eRS+9kysCS0qJwb8vhL?=
 =?us-ascii?Q?IijXUEJuMd3zAgAT72hdlX0CAVnpe43g3Z3UYx4Tmo5fP0fYLvjHbwJJCqoH?=
 =?us-ascii?Q?xDXIoLq8u2IB9JB85azaG6hZVLfzB1mr2xR9fx/YWE9QmX1nxDnfbYOLxgr9?=
 =?us-ascii?Q?Y/uDlSsupDW87WpbpEidd3YllyCFjuJNn7Eb3GSFNGhXdFmPt8Gf3ER3r3kT?=
 =?us-ascii?Q?opfn+PcZKyV1r6EZevHB8uUPr79tUUcqJ60xhtBu5rT895YXBflQdd+5pKey?=
 =?us-ascii?Q?jVmvpEaeFXqIhGwagHdwNdyXt3b/BD4BO8ELVl/DuIYnknmijqbELoLgnKbW?=
 =?us-ascii?Q?e0TY+MWYI9xYXgFTaqFwzGpbtQkW30mraHSQqReCwwOHoWYMTfMHEVwHtZs5?=
 =?us-ascii?Q?uVM0qJ8Ds3BgqGLlLFfseG6yqEB0Pp+zU26ZJ7TCTGnV0lrs/G8PtsTpGYEP?=
 =?us-ascii?Q?7AhZXrOkBbHwCK1m2/46jgHlnDwBzbsH57+19TE5mwagD1C9vuRk1CvrX9v0?=
 =?us-ascii?Q?+/wEyaT5LBS+FNp9W+wLSyWwwFaZeTf83YxXumbwVhaaYxfGZ6JFmufPDa0Y?=
 =?us-ascii?Q?37y4ypMnSOPLpMGqO7ZmyGpPVN/iVsbZ1y8NdA1Y14ZJvVVHSEazdyeyfxw4?=
 =?us-ascii?Q?zlDB7XOc4MLSl7An2ic6+On+/S7qNbR9kHap7bNxdYIFUNbwTYefUvw9f/j4?=
 =?us-ascii?Q?qZL49/Ba3KxTMi2NQRG8q9+YXXcf4VTDpB+K4ptD1lhX1ZJk/Lm795aigxi6?=
 =?us-ascii?Q?JgZm7rAA+QrW4yBxHC6BlXJHWqMFOqER3KHN3NF9xBm08dm7TckGmj7GGKwj?=
 =?us-ascii?Q?mFyU2aA7os/1/9mwhfdc3HPMA9UHcbvDmKiVxTtdMHboChWpfRr7PFvkwmZb?=
 =?us-ascii?Q?VV96lPi+l+5q5UGI8Pk/+Pptp1fw8czGtrMe7J8m/+o9zvczLveJJgY+WfY3?=
 =?us-ascii?Q?PWIA4yklXk6e10mk5Uu5/2FB3GOdKr3fzHKhIahb1I/ICoWgVp5QIRXKWMWL?=
 =?us-ascii?Q?lRX42lvRDrRrX1bPbdsIKH5TQB2J/BgBJjkJ5ETaEnLc1gcBDrIfbFrcf7FQ?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: a5eb64e5-aaf3-4fbc-9734-08db7c75577c
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 09:59:22.5405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qF12Gg3QEicec8tsGpQjNP+qhyHgbyTABUryP3riBJEKyowyWqOfBjDOugKU4gm/YX18ebhlGp17j8y78DcHDqA2cQaCSg1eBBo/HGycWpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P18901MB0783
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for AF_XDP zero-copy receive path.

Add IGB_RING_FLAG_AF_XDP_ZC ring flag to indicate that a ring has AF_XDP
zero-copy support. This flag is used in igb_configure_rx_ring to
register XSK_BUFF_POOL (if zero-copy is enabled) memory model or the
default PAGE_SHARED model otherwise.

When AF_XDP zero-copy is enabled, the rx buffers are allocated from the
xsk buff pool using igb_alloc_rx_buffers_zc.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 drivers/net/ethernet/intel/igb/Makefile   |   2 +-
 drivers/net/ethernet/intel/igb/igb.h      |  34 +-
 drivers/net/ethernet/intel/igb/igb_main.c |  72 ++++-
 drivers/net/ethernet/intel/igb/igb_xsk.c  | 373 ++++++++++++++++++++++
 4 files changed, 463 insertions(+), 18 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/igb/igb_xsk.c

diff --git a/drivers/net/ethernet/intel/igb/Makefile b/drivers/net/ethernet/intel/igb/Makefile
index 394c1e0656b9..86d25dba507d 100644
--- a/drivers/net/ethernet/intel/igb/Makefile
+++ b/drivers/net/ethernet/intel/igb/Makefile
@@ -8,4 +8,4 @@ obj-$(CONFIG_IGB) += igb.o
 
 igb-objs := igb_main.o igb_ethtool.o e1000_82575.o \
 	    e1000_mac.o e1000_nvm.o e1000_phy.o e1000_mbx.o \
-	    e1000_i210.o igb_ptp.o igb_hwmon.o
+	    e1000_i210.o igb_ptp.o igb_hwmon.o igb_xsk.o
diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 5fa011c6ef2f..4f474d7338b5 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -20,6 +20,7 @@
 #include <linux/mdio.h>
 
 #include <net/xdp.h>
+#include <net/xdp_sock_drv.h>
 
 struct igb_adapter;
 
@@ -86,6 +87,7 @@ struct igb_adapter;
 #define IGB_XDP_CONSUMED	BIT(0)
 #define IGB_XDP_TX		BIT(1)
 #define IGB_XDP_REDIR		BIT(2)
+#define IGB_XDP_EXIT		BIT(3)
 
 struct vf_data_storage {
 	unsigned char vf_mac_addresses[ETH_ALEN];
@@ -278,14 +280,23 @@ struct igb_tx_buffer {
 };
 
 struct igb_rx_buffer {
-	dma_addr_t dma;
-	struct page *page;
+	union {
+		struct {
+			struct sk_buff *skb;
+			dma_addr_t dma;
+			struct page *page;
 #if (BITS_PER_LONG > 32) || (PAGE_SIZE >= 65536)
-	__u32 page_offset;
+		__u32 page_offset;
 #else
-	__u16 page_offset;
+		__u16 page_offset;
 #endif
-	__u16 pagecnt_bias;
+			__u16 pagecnt_bias;
+		};
+		struct {
+			struct xdp_buff *xdp;
+		};
+	};
+
 };
 
 struct igb_tx_queue_stats {
@@ -357,6 +368,7 @@ struct igb_ring {
 		};
 	};
 	struct xdp_rxq_info xdp_rxq;
+	struct xsk_buff_pool *xsk_pool;
 } ____cacheline_internodealigned_in_smp;
 
 struct igb_q_vector {
@@ -385,7 +397,8 @@ enum e1000_ring_flags_t {
 	IGB_RING_FLAG_RX_LB_VLAN_BSWAP,
 	IGB_RING_FLAG_TX_CTX_IDX,
 	IGB_RING_FLAG_TX_DETECT_HANG,
-	IGB_RING_FLAG_TX_DISABLED
+	IGB_RING_FLAG_TX_DISABLED,
+	IGB_RING_FLAG_AF_XDP_ZC
 };
 
 #define ring_uses_large_buffer(ring) \
@@ -823,4 +836,13 @@ int igb_add_mac_steering_filter(struct igb_adapter *adapter,
 int igb_del_mac_steering_filter(struct igb_adapter *adapter,
 				const u8 *addr, u8 queue, u8 flags);
 
+struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
+				   struct igb_ring *ring);
+int igb_xsk_pool_setup(struct igb_adapter *adapter,
+		       struct xsk_buff_pool *pool,
+		       u16 qid);
+bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring, u16 count);
+int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector, const int budget);
+int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags);
+
 #endif /* _IGB_H_ */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 391c0eb136d9..f4dbb75d6eac 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2013,7 +2013,9 @@ static void igb_configure(struct igb_adapter *adapter)
 	 */
 	for (i = 0; i < adapter->num_rx_queues; i++) {
 		struct igb_ring *ring = adapter->rx_ring[i];
-		igb_alloc_rx_buffers(ring, igb_desc_unused(ring));
+		ring->xsk_pool ?
+			igb_alloc_rx_buffers_zc(ring, igb_desc_unused(ring)) :
+			igb_alloc_rx_buffers(ring, igb_desc_unused(ring));
 	}
 }
 
@@ -2931,9 +2933,14 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
 
 static int igb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 {
+	struct igb_adapter *adapter = netdev_priv(dev);
+
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
 		return igb_xdp_setup(dev, xdp);
+	case XDP_SETUP_XSK_POOL:
+		return igb_xsk_pool_setup(adapter, xdp->xsk.pool,
+					  xdp->xsk.queue_id);
 	default:
 		return -EINVAL;
 	}
@@ -3010,6 +3017,9 @@ static int igb_xdp_xmit(struct net_device *dev, int n,
 	if (unlikely(!tx_ring))
 		return -ENXIO;
 
+	if (unlikely(test_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags)))
+		return -ENXIO;
+
 	nq = txring_txq(tx_ring);
 	__netif_tx_lock(nq, cpu);
 
@@ -3060,6 +3070,7 @@ static const struct net_device_ops igb_netdev_ops = {
 	.ndo_setup_tc		= igb_setup_tc,
 	.ndo_bpf		= igb_xdp,
 	.ndo_xdp_xmit		= igb_xdp_xmit,
+	.ndo_xsk_wakeup         = igb_xsk_wakeup,
 };
 
 /**
@@ -3356,7 +3367,8 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
-	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
 	/* MTU range: 68 - 9216 */
 	netdev->min_mtu = ETH_MIN_MTU;
@@ -4734,12 +4746,17 @@ void igb_setup_srrctl(struct igb_adapter *adapter, struct igb_ring *ring)
 	struct e1000_hw *hw = &adapter->hw;
 	int reg_idx = ring->reg_idx;
 	u32 srrctl = 0;
+	u32 buf_size;
 
-	srrctl = IGB_RX_HDR_LEN << E1000_SRRCTL_BSIZEHDRSIZE_SHIFT;
-	if (ring_uses_large_buffer(ring))
-		srrctl |= IGB_RXBUFFER_3072 >> E1000_SRRCTL_BSIZEPKT_SHIFT;
+	if (ring->xsk_pool)
+		buf_size = xsk_pool_get_rx_frame_size(ring->xsk_pool);
+	else if (ring_uses_large_buffer(ring))
+		buf_size = IGB_RXBUFFER_3072;
 	else
-		srrctl |= IGB_RXBUFFER_2048 >> E1000_SRRCTL_BSIZEPKT_SHIFT;
+		buf_size = IGB_RXBUFFER_2048;
+
+	srrctl = IGB_RX_HDR_LEN << E1000_SRRCTL_BSIZEHDRSIZE_SHIFT;
+	srrctl |= buf_size >> E1000_SRRCTL_BSIZEPKT_SHIFT;
 	srrctl |= E1000_SRRCTL_DESCTYPE_ADV_ONEBUF;
 	if (hw->mac.type >= e1000_82580)
 		srrctl |= E1000_SRRCTL_TIMESTAMP;
@@ -4771,8 +4788,16 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
 	u32 rxdctl = 0;
 
 	xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
-	WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
-					   MEM_TYPE_PAGE_SHARED, NULL));
+	ring->xsk_pool = igb_xsk_pool(adapter, ring);
+	if (ring->xsk_pool) {
+		WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
+						   MEM_TYPE_XSK_BUFF_POOL,
+						   NULL));
+		xsk_pool_set_rxq_info(ring->xsk_pool, &ring->xdp_rxq);
+	} else {
+		WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
+						   MEM_TYPE_PAGE_SHARED, NULL));
+	}
 
 	/* disable the queue */
 	wr32(E1000_RXDCTL(reg_idx), 0);
@@ -4892,7 +4917,9 @@ void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid)
 	 * at least 1 descriptor unused to make sure
 	 * next_to_use != next_to_clean
 	 */
-	igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
+	rx_ring->xsk_pool ?
+		igb_alloc_rx_buffers_zc(rx_ring, igb_desc_unused(rx_ring)) :
+		igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
 
 	clear_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
 }
@@ -5069,6 +5096,13 @@ static void igb_clean_rx_ring(struct igb_ring *rx_ring)
 	while (i != rx_ring->next_to_alloc) {
 		struct igb_rx_buffer *buffer_info = &rx_ring->rx_buffer_info[i];
 
+		if (rx_ring->xsk_pool) {
+			if (buffer_info->xdp)
+				xsk_buff_free(buffer_info->xdp);
+			buffer_info->xdp = NULL;
+			goto skip_for_xsk;
+		}
+
 		/* Invalidate cache lines that may have been written to by
 		 * device so that we avoid corrupting memory.
 		 */
@@ -5087,6 +5121,7 @@ static void igb_clean_rx_ring(struct igb_ring *rx_ring)
 		__page_frag_cache_drain(buffer_info->page,
 					buffer_info->pagecnt_bias);
 
+skip_for_xsk:
 		i++;
 		if (i == rx_ring->count)
 			i = 0;
@@ -6518,6 +6553,9 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
 		return NETDEV_TX_BUSY;
 	}
 
+	if (unlikely(test_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags)))
+		return NETDEV_TX_BUSY;
+
 	/* record the location of the first descriptor for this packet */
 	first = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
 	first->type = IGB_TYPE_SKB;
@@ -8260,7 +8298,9 @@ static int igb_poll(struct napi_struct *napi, int budget)
 		clean_complete = igb_clean_tx_irq(q_vector, budget);
 
 	if (q_vector->rx.ring) {
-		int cleaned = igb_clean_rx_irq(q_vector, budget);
+		int cleaned = q_vector->rx.ring->xsk_pool ?
+			igb_clean_rx_irq_zc(q_vector, budget) :
+			igb_clean_rx_irq(q_vector, budget);
 
 		work_done += cleaned;
 		if (cleaned >= budget)
@@ -8668,8 +8708,13 @@ struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
 		break;
 	case XDP_REDIRECT:
 		err = xdp_do_redirect(adapter->netdev, xdp, xdp_prog);
-		if (err)
+		if (err) {
+			if (xsk_uses_need_wakeup(rx_ring->xsk_pool) && err == -ENOBUFS)
+				result = IGB_XDP_EXIT;
+			else
+				result = IGB_XDP_CONSUMED;
 			goto out_failure;
+		}
 		result = IGB_XDP_REDIR;
 		break;
 	default:
@@ -8929,6 +8974,8 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 	struct igb_adapter *adapter = q_vector->adapter;
 	struct igb_ring *rx_ring = q_vector->rx.ring;
 	struct sk_buff *skb = rx_ring->skb;
+	int cpu = smp_processor_id();
+	struct netdev_queue *nq;
 	unsigned int total_bytes = 0, total_packets = 0;
 	u16 cleaned_count = igb_desc_unused(rx_ring);
 	unsigned int xdp_xmit = 0;
@@ -9059,7 +9106,10 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 	if (xdp_xmit & IGB_XDP_TX) {
 		struct igb_ring *tx_ring = igb_xdp_tx_queue_mapping(adapter);
 
+		nq = txring_txq(tx_ring);
+		__netif_tx_lock(nq, cpu);
 		igb_xdp_ring_update_tail(tx_ring);
+		__netif_tx_unlock(nq);
 	}
 
 	u64_stats_update_begin(&rx_ring->rx_syncp);
diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
new file mode 100644
index 000000000000..eae616e7608c
--- /dev/null
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2018 Intel Corporation. */
+
+#include <linux/bpf_trace.h>
+#include <net/xdp_sock_drv.h>
+#include <net/xdp.h>
+
+#include "e1000_hw.h"
+#include "igb.h"
+
+struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
+				   struct igb_ring *ring)
+{
+	int qid = ring->queue_index;
+
+	if (!igb_xdp_is_enabled(adapter) ||
+	    !test_bit(IGB_RING_FLAG_AF_XDP_ZC, &ring->flags))
+		return NULL;
+
+	return xsk_get_pool_from_qid(adapter->netdev, qid);
+}
+
+static int igb_xsk_pool_enable(struct igb_adapter *adapter,
+			       struct xsk_buff_pool *pool,
+			       u16 qid)
+{
+	struct net_device *netdev = adapter->netdev;
+	struct igb_ring *rx_ring;
+	bool if_running;
+	int err;
+
+	if (qid >= adapter->num_rx_queues)
+		return -EINVAL;
+
+	if (qid >= netdev->real_num_rx_queues)
+		return -EINVAL;
+
+	err = xsk_pool_dma_map(pool, &adapter->pdev->dev, IGB_RX_DMA_ATTR);
+	if (err)
+		return err;
+
+	rx_ring = adapter->rx_ring[qid];
+	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
+	if (if_running)
+		igb_txrx_ring_disable(adapter, qid);
+
+	set_bit(IGB_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
+
+	if (if_running) {
+		igb_txrx_ring_enable(adapter, qid);
+
+		/* Kick start the NAPI context so that receiving will start */
+		err = igb_xsk_wakeup(adapter->netdev, qid, XDP_WAKEUP_RX);
+		if (err) {
+			clear_bit(IGB_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
+			xsk_pool_dma_unmap(pool, IGB_RX_DMA_ATTR);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int igb_xsk_pool_disable(struct igb_adapter *adapter, u16 qid)
+{
+	struct igb_ring *rx_ring;
+	struct xsk_buff_pool *pool;
+	bool if_running;
+
+	pool = xsk_get_pool_from_qid(adapter->netdev, qid);
+	if (!pool)
+		return -EINVAL;
+
+	rx_ring = adapter->rx_ring[qid];
+	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
+	if (if_running)
+		igb_txrx_ring_disable(adapter, qid);
+
+	xsk_pool_dma_unmap(pool, IGB_RX_DMA_ATTR);
+	clear_bit(IGB_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
+
+	if (if_running)
+		igb_txrx_ring_enable(adapter, qid);
+
+	return 0;
+}
+
+int igb_xsk_pool_setup(struct igb_adapter *adapter,
+		       struct xsk_buff_pool *pool,
+		       u16 qid)
+{
+	return pool ? igb_xsk_pool_enable(adapter, pool, qid) :
+		igb_xsk_pool_disable(adapter, qid);
+}
+
+bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring, u16 count)
+{
+	union e1000_adv_rx_desc *rx_desc;
+	struct igb_rx_buffer *buffer_info;
+	u16 i = rx_ring->next_to_use;
+	dma_addr_t dma;
+	bool ok = true;
+
+	/* nothing to do */
+	if (!count)
+		return true;
+
+	rx_desc = IGB_RX_DESC(rx_ring, i);
+	buffer_info = &rx_ring->rx_buffer_info[i];
+	i -= rx_ring->count;
+
+	do {
+		buffer_info->xdp = xsk_buff_alloc(rx_ring->xsk_pool);
+		if (!buffer_info->xdp) {
+			ok = false;
+			break;
+		}
+
+		dma = xsk_buff_xdp_get_dma(buffer_info->xdp);
+
+		/* Refresh the desc even if buffer_addrs didn't change
+		 * because each write-back erases this info.
+		 */
+		rx_desc->read.pkt_addr = cpu_to_le64(dma);
+
+		rx_desc++;
+		buffer_info++;
+		i++;
+		if (unlikely(!i)) {
+			rx_desc = IGB_RX_DESC(rx_ring, 0);
+			buffer_info = rx_ring->rx_buffer_info;
+			i -= rx_ring->count;
+		}
+
+		/* clear the length for the next_to_use descriptor */
+		rx_desc->wb.upper.length = 0;
+
+		count--;
+	} while (count);
+
+	i += rx_ring->count;
+
+	if (rx_ring->next_to_use != i) {
+		rx_ring->next_to_use = i;
+
+		/* Force memory writes to complete before letting h/w
+		 * know there are new descriptors to fetch.  (Only
+		 * applicable for weak-ordered memory model archs,
+		 * such as IA-64).
+		 */
+		wmb();
+		writel(i, rx_ring->tail);
+	}
+
+	return ok;
+}
+
+static struct sk_buff *igb_construct_skb_zc(struct igb_ring *rx_ring,
+					    struct xdp_buff *xdp,
+					    ktime_t timestamp)
+{
+	unsigned int totalsize = xdp->data_end - xdp->data_meta;
+	unsigned int metasize = xdp->data - xdp->data_meta;
+	struct sk_buff *skb;
+
+	net_prefetch(xdp->data_meta);
+
+	/* allocate a skb to store the frags */
+	skb = __napi_alloc_skb(&rx_ring->q_vector->napi, totalsize,
+			       GFP_ATOMIC | __GFP_NOWARN);
+	if (unlikely(!skb))
+		return NULL;
+
+	if (timestamp)
+		skb_hwtstamps(skb)->hwtstamp = timestamp;
+
+	memcpy(__skb_put(skb, totalsize), xdp->data_meta,
+	       ALIGN(totalsize, sizeof(long)));
+
+	if (metasize) {
+		skb_metadata_set(skb, metasize);
+		__skb_pull(skb, metasize);
+	}
+
+	return skb;
+}
+
+static void igb_update_ntc(struct igb_ring *rx_ring)
+{
+	u32 ntc = rx_ring->next_to_clean + 1;
+
+	/* fetch, update, and store next to clean */
+	ntc = (ntc < rx_ring->count) ? ntc : 0;
+	rx_ring->next_to_clean = ntc;
+
+	prefetch(IGB_RX_DESC(rx_ring, ntc));
+}
+
+int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector, const int budget)
+{
+	struct igb_adapter *adapter = q_vector->adapter;
+	struct igb_ring *rx_ring = q_vector->rx.ring;
+	struct sk_buff *skb;
+	int cpu = smp_processor_id();
+	struct netdev_queue *nq;
+	unsigned int total_bytes = 0, total_packets = 0;
+	u16 cleaned_count = igb_desc_unused(rx_ring);
+	unsigned int xdp_xmit = 0;
+	bool failure = false;
+
+	while (likely(total_packets < budget)) {
+		union e1000_adv_rx_desc *rx_desc;
+		struct igb_rx_buffer *rx_buffer;
+		ktime_t timestamp = 0;
+		unsigned int size;
+
+		/* return some buffers to hardware, one at a time is too slow */
+		if (cleaned_count >= IGB_RX_BUFFER_WRITE) {
+			igb_alloc_rx_buffers_zc(rx_ring, cleaned_count);
+			cleaned_count = 0;
+		}
+
+		rx_desc = IGB_RX_DESC(rx_ring, rx_ring->next_to_clean);
+		size = le16_to_cpu(rx_desc->wb.upper.length);
+		if (!size)
+			break;
+
+		/* This memory barrier is needed to keep us from reading
+		 * any other fields out of the rx_desc until we know the
+		 * descriptor has been written back
+		 */
+		dma_rmb();
+
+		rx_buffer = &rx_ring->rx_buffer_info[rx_ring->next_to_clean];
+		rx_buffer->xdp->data_end = rx_buffer->xdp->data + size;
+		xsk_buff_dma_sync_for_cpu(rx_buffer->xdp, rx_ring->xsk_pool);
+
+		/* pull rx packet timestamp if available and valid */
+		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
+			int ts_hdr_len;
+
+			ts_hdr_len = igb_ptp_rx_pktstamp(rx_ring->q_vector,
+							 rx_buffer->xdp->data,
+							 &timestamp);
+
+			rx_buffer->xdp->data += ts_hdr_len;
+			rx_buffer->xdp->data_meta += ts_hdr_len;
+			size -= ts_hdr_len;
+		}
+
+		skb = igb_run_xdp(adapter, rx_ring, rx_buffer->xdp);
+
+		if (IS_ERR(skb)) {
+			unsigned int xdp_res = -PTR_ERR(skb);
+
+			if (likely(xdp_res & (IGB_XDP_TX | IGB_XDP_REDIR))) {
+				xdp_xmit |= xdp_res;
+			} else if (xdp_res == IGB_XDP_EXIT) {
+				failure = true;
+				break;
+			} else if (xdp_res == IGB_XDP_CONSUMED) {
+				xsk_buff_free(rx_buffer->xdp);
+			}
+
+			total_packets++;
+			total_bytes += size;
+
+			rx_buffer->xdp = NULL;
+			cleaned_count++;
+			igb_update_ntc(rx_ring);
+			continue;
+		}
+
+		skb = igb_construct_skb_zc(rx_ring, rx_buffer->xdp, timestamp);
+
+		/* exit if we failed to retrieve a buffer */
+		if (!skb) {
+			rx_ring->rx_stats.alloc_failed++;
+			break;
+		}
+
+		xsk_buff_free(rx_buffer->xdp);
+		rx_buffer->xdp = NULL;
+		cleaned_count++;
+		igb_update_ntc(rx_ring);
+
+		if (eth_skb_pad(skb))
+			continue;
+
+		/* probably a little skewed due to removing CRC */
+		total_bytes += skb->len;
+
+		/* populate checksum, timestamp, VLAN, and protocol */
+		igb_process_skb_fields(rx_ring, rx_desc, skb);
+
+		napi_gro_receive(&q_vector->napi, skb);
+
+		/* reset skb pointer */
+		skb = NULL;
+
+		/* update budget accounting */
+		total_packets++;
+	}
+
+	if (xdp_xmit & IGB_XDP_REDIR)
+		xdp_do_flush();
+
+	if (xdp_xmit & IGB_XDP_TX) {
+		struct igb_ring *tx_ring = igb_xdp_tx_queue_mapping(adapter);
+
+		nq = txring_txq(tx_ring);
+		__netif_tx_lock(nq, cpu);
+		igb_xdp_ring_update_tail(tx_ring);
+		__netif_tx_unlock(nq);
+	}
+
+	u64_stats_update_begin(&rx_ring->rx_syncp);
+	rx_ring->rx_stats.packets += total_packets;
+	rx_ring->rx_stats.bytes += total_bytes;
+	u64_stats_update_end(&rx_ring->rx_syncp);
+	q_vector->rx.total_packets += total_packets;
+	q_vector->rx.total_bytes += total_bytes;
+
+	if (cleaned_count)
+		igb_alloc_rx_buffers_zc(rx_ring, cleaned_count);
+
+	if (xsk_uses_need_wakeup(rx_ring->xsk_pool)) {
+		if (failure || rx_ring->next_to_clean == rx_ring->next_to_use)
+			xsk_set_rx_need_wakeup(rx_ring->xsk_pool);
+		else
+			xsk_clear_rx_need_wakeup(rx_ring->xsk_pool);
+
+		return (int)total_packets;
+	}
+	return failure ? budget : (int)total_packets;
+}
+
+int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
+{
+	struct igb_adapter *adapter = netdev_priv(dev);
+	struct igb_ring *ring;
+	struct e1000_hw *hw = &adapter->hw;
+	u32 eics = 0;
+
+	if (test_bit(__IGB_DOWN, &adapter->state))
+		return -ENETDOWN;
+
+	if (!igb_xdp_is_enabled(adapter))
+		return -EINVAL;
+
+	if (qid >= adapter->num_tx_queues)
+		return -EINVAL;
+
+	ring = adapter->tx_ring[qid];
+
+	if (test_bit(IGB_RING_FLAG_TX_DISABLED, &ring->flags))
+		return -ENETDOWN;
+
+	if (!ring->xsk_pool)
+		return -EINVAL;
+
+	if (!napi_if_scheduled_mark_missed(&ring->q_vector->napi)) {
+		/* Cause software interrupt to ensure Rx ring is cleaned */
+		if (adapter->flags & IGB_FLAG_HAS_MSIX) {
+			eics |= ring->q_vector->eims_value;
+			wr32(E1000_EICS, eics);
+		} else {
+			wr32(E1000_ICS, E1000_ICS_RXDMT0);
+		}
+	}
+
+	return 0;
+}
-- 
2.34.1


