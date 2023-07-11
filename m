Return-Path: <bpf+bounces-4756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B02574ED3F
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 13:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40416281781
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 11:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAAD18C15;
	Tue, 11 Jul 2023 11:49:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5622018C0F;
	Tue, 11 Jul 2023 11:49:22 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2096.outbound.protection.outlook.com [40.107.6.96])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26205E77;
	Tue, 11 Jul 2023 04:49:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQxLtwrkxxKg+XfgqTb81x6tyJoQyd1oM5eY0K+IzG+Dq2TEqBrO8PozlZn70hIMZdKsdX98+9I0CQbp1j2tYNu46qg9sybFe7NC0fLxXDWEaz9mXmLHwZii/1xODk73wtdxPI9iZ9cnlr7ivC2ShdtYVk+0XTdTjGaPST1C2l75xh/PooR0inQGfduT6WIewMHOG6FChHEQyH9OnZ6vZx082myL5kRQoFV6pGdJ/XjnMdsyVy5S7kK4fuvRhZNOEkIdIHCcvmYWpthmNzdQKO2IldeCUxuMC3Cck1W4AWZND8lRWF02H5hfkLu/2XGgf81E6/1QJbVranByrYeWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ec8tI81n3emaORjojzJTfh9xzHGICKi45AOXMsqZKJI=;
 b=YatRAN1I3DQL1H361/qumsT9psmydtU5QxINKqJWLUDd9456OdEB+QA9Fx8wQa72HIrM4WRz+gJlHVl1A5NX9wLNyS/SEKXujR6dCJyLzjaEfW1CzjNYY43DBj/4NNdTI7LrwH79E8dxESqpk+0mkrDFJgv87nqK9Sqhhmc31T2gBYU/kVTjhjRVkCAg5IyrLMP64iKyl0uA0Y9XYBMgqeCsCU9szSFXbDSOUAYxtYIA25WvbcZZqnghD3+3D7Bh4WvNAE61/j3+OKAxWncKcuOTyOgvjdv2BswbQBTXMY6fY3rJvzWj2YdxRwaJE0TIa4OXhRHzy7y8FEbpla4wFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ec8tI81n3emaORjojzJTfh9xzHGICKi45AOXMsqZKJI=;
 b=aDofssom+AmhujOGwFQ8CSgDjeoRuIqIdxibqxndEG7+m5XawI6I/OYSZ5FGnd/GqAS6iVMV+5kx6qjjJfuoYAieQPN7gpo07QCsBMu4W0G3hQUAKPx/XLtE1FhaHgcLBKqzTSeBlu0ThmLONHPzjQKjK1YWk4AH2kqo9NbVN+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by AS4P189MB2088.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:517::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 11:49:15 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 11:49:15 +0000
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
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Subject: [PATCH iwl-next v2 2/4] igb: Introduce XSK data structures and helpers
Date: Tue, 11 Jul 2023 13:47:03 +0200
Message-Id: <20230711114705.22428-3-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230711114705.22428-1-sriram.yagnaraman@est.tech>
References: <20230711114705.22428-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0089.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::13) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|AS4P189MB2088:EE_
X-MS-Office365-Filtering-Correlation-Id: 385d2fec-2cb0-4fef-8ce1-08db8204d9e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LUlezJuQhexIClRPoTXK1Xw9k2LOoRnlhu148O18E+HKhDMQwthISSoRlaHoYsvIPFhaFUpHxsTFb8HN+haSyeNgoLdXjA5KlKBxmYu7PkGyk7VHFb04CggriBSe51zkdtyT4DqGhyotLrRuMna6QZy3VqtWEg0mADhuDabghK/4axkIXC26bZfSgc5OXtj+lDJo3K9+Y65MW+pe5Dbm9yF0+pW7bgnj630AQ2PJxGWnrHXd0w+X5dN70D4/6vl9bwEgCENVUiO00ajS39Apxc2jGJZEYMZrPlmyxVW+qzM0EZXiFHzSnjk5i61FAQso/C6RrC3MrGi4XgsaIu7MrCuNVIVYZhGvsKj9fKxyu4YG7lJeR6pcAfoMYyLwPd9YqfTZq9Db2oHTL38SuPaWX4CLtIxg0gOFSESJMD5DeK5g8A0rHxakQzcInSpl1lRU9hGYWJ2Igje0qmB3VPnqUe/Wf/L6q/aI/JwFAtNAS/rxmnj/KIq5eb0mVihMK0IrM4syEdNlbPS8rTnKCQMUz5RUWN9gamYb7lRou3mkyhmpDqqafaKajpbGu6elQlxEqCFTXl/Ba/tXbHpF4hZTmzMgbfsmaaZvpdvHBMh3JXiAzKH+qIWabEffy2poDS0i+U0RySq9nYQ/sbnfiEdXew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(39840400004)(376002)(451199021)(109986019)(6486002)(4326008)(66946007)(70586007)(66476007)(66556008)(478600001)(6666004)(26005)(1076003)(6506007)(38100700002)(54906003)(66899021)(41300700001)(6512007)(316002)(8936002)(8676002)(86362001)(5660300002)(7416002)(44832011)(186003)(83380400001)(2616005)(2906002)(36756003)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z/RZ+57kLhgq7xjfKTs5v6yxZnXIoc11wOEAdqLVVg6E0sphIZCMmBIVojTL?=
 =?us-ascii?Q?7D0m8wKaSUUbnFmAXXxLKXHivw9fy96li12h1d+jWaHDouVLErGFGPsFVNEI?=
 =?us-ascii?Q?htmZjzZAOoH+NsRKoFwpo1ITgG3TrIyxQRrWBeE688L6m63PenNKNh4iGB9E?=
 =?us-ascii?Q?moKv+NF4SdIZCevvR7HixmB84KiqwuWubiGK/tMD1YKyjTPrda/3ASAadeLW?=
 =?us-ascii?Q?5L3lNN7rGSzBydMGL+Jb7COHsxlcafTgD2hbAoCWPowrTwXVdmNQ5CZs+og7?=
 =?us-ascii?Q?VtqQd/X5EPwGqnaAdaj6K2Nz2H7KrHKVWZs11LdGlmxowRLZQupz8+A1dpcJ?=
 =?us-ascii?Q?wj4fcpPnf2hyK9DY8eO6bDm2ma4ggBoPkq9hSHOgeStdLiLwZyMeTWF/XN3j?=
 =?us-ascii?Q?v6ekPATvTL9lOg258DRoU+X/OiWx+I68u5Vt/dP4DkxZS7ZLWJ0VNygGNfXD?=
 =?us-ascii?Q?eBtAheZiJisBTlegIZOABwLLrPVVPY4/8hELi16qvKGkohLnMm5IJWe0x8cZ?=
 =?us-ascii?Q?qvCjdCInn7b6XBKifuw87msr7Ta6lQXMGVcHsjhNnJ+17eY08nQuVdTtSyI7?=
 =?us-ascii?Q?uGgFJqWBDgX/WOiKLkkQChFGDNAGSIg2o1FNFZsUs7gbjrQH5ZeJw/wUWXxY?=
 =?us-ascii?Q?xZSSg0k3Cw/NQMIqf6WD5SS4eNvjSGn7u+ucJt5TrthyH3/rDiOu1lnHmFrX?=
 =?us-ascii?Q?uoZ4Bl+6kBeYuVmJM1O6Pk/HgOcA2qbIrT8RHJlqV40vNx9DU8BdrCHNeMLf?=
 =?us-ascii?Q?jE8MSWhQAbMSunGgD8F0r9FiNMD+S3E+NucNHzRIOUuo0D6GtwwrbZoQ3J1Q?=
 =?us-ascii?Q?13XRb0/ZcjWiC9jBpv9cvmYQcvNjVdZ+UiFVaxWgZ2NWoilC8z/RJ0+jE4un?=
 =?us-ascii?Q?0uMaR+9vjTKG4W3tBLGf5R+2T2MRDCFqgGZFsDXcrEvU5+OwuJHU2ICkUrVG?=
 =?us-ascii?Q?fZeEbDZV2VobxaQ1Qzqwdz6pW2QuJope2lvSWrUYpVW80E4aGG0TMxWImOt2?=
 =?us-ascii?Q?uRkl409DarJrzxYWH0YXn8pLf1cZg5PeHNDxe0RJGazZ3Q0xQSmIPnK6ulmR?=
 =?us-ascii?Q?GkSQCjkWz3VkRQf3M+ZJJPJiG+qe8pwGa9/qx/FfGU8+UEZayXgdUrYyVbwk?=
 =?us-ascii?Q?faKLLB2h4crOGkxY4MqDg3A3AdvKt8Ae+6rAQGfYEZ/W2UmKzLXr3CM42wdA?=
 =?us-ascii?Q?meAFfkg7emCc5AVBx+J8eFFvYLfkss/TGCqUinw5Ke4jxEQpcjWLoG22AnI0?=
 =?us-ascii?Q?bppvoHGaAAXOyiEJjdaWIZQNSFb0+egB5cnMvGTP2o3Tz9PTFP0qZqhogjLT?=
 =?us-ascii?Q?yWxTGgtlNBqe7cYn9mtzcuLZJBwswRg2gFKPmGBt0KRN4KEcZ3jXbC44DIpF?=
 =?us-ascii?Q?RV77jTlQF91RBQX+UUtEa2Ak/YpXC32FJkh3aXOBLQp8g2jbSnLOCn7hJdXp?=
 =?us-ascii?Q?IfXsLeVtZbPBXQJaPZI0P3KpwWzwK80Xh1/dIRKNTZiscwHtY4rnx8vrG1cv?=
 =?us-ascii?Q?maTbnIjp6PpFDxgzOt+Uvk/n5XINdQmDs4veQQY5c8lb/DS4Whqh+ycl6fIl?=
 =?us-ascii?Q?rot8T/uG2ClwuLiv89vcXFAnWa9M9pE5OxFs90ei7e/ePCHnxZcN91y7n8Pa?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 385d2fec-2cb0-4fef-8ce1-08db8204d9e5
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 11:49:15.1534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOLJSzt806KOIfHyQEU2oSJZjv+Bciy4mziZ/TU7B3wOVz6a/LkGB0Oipt9dWQjpp0MfNzg8e+HwSfQl2Pyz4cW8BcFcCvFawZaI1PiBoiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB2088
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add the following ring flags
- IGB_RING_FLAG_TX_DISABLED (when xsk pool is being setup)
- IGB_RING_FLAG_AF_XDP_ZC (xsk pool is active)

Add a xdp_buff array for use with XSK receive batch API, and a pointer
to xsk_pool in igb_adapter.

Add enable/disable functions for TX and RX rings
Add enable/disable functions for XSK pool
Add xsk wakeup function

None of the above functionality will be active until
NETDEV_XDP_ACT_XSK_ZEROCOPY is advertised in netdev->xdp_features.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 drivers/net/ethernet/intel/igb/Makefile   |   2 +-
 drivers/net/ethernet/intel/igb/igb.h      |  14 +-
 drivers/net/ethernet/intel/igb/igb_main.c |   9 +
 drivers/net/ethernet/intel/igb/igb_xsk.c  | 210 ++++++++++++++++++++++
 4 files changed, 233 insertions(+), 2 deletions(-)
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
index 58e79eb69f92..1af1a0423fba 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -20,6 +20,7 @@
 #include <linux/mdio.h>
 
 #include <net/xdp.h>
+#include <net/xdp_sock_drv.h>
 
 struct igb_adapter;
 
@@ -320,6 +321,7 @@ struct igb_ring {
 	union {				/* array of buffer info structs */
 		struct igb_tx_buffer *tx_buffer_info;
 		struct igb_rx_buffer *rx_buffer_info;
+		struct xdp_buff **rx_buffer_info_zc;
 	};
 	void *desc;			/* descriptor ring memory */
 	unsigned long flags;		/* ring specific flags */
@@ -357,6 +359,7 @@ struct igb_ring {
 		};
 	};
 	struct xdp_rxq_info xdp_rxq;
+	struct xsk_buff_pool *xsk_pool;
 } ____cacheline_internodealigned_in_smp;
 
 struct igb_q_vector {
@@ -384,7 +387,9 @@ enum e1000_ring_flags_t {
 	IGB_RING_FLAG_RX_SCTP_CSUM,
 	IGB_RING_FLAG_RX_LB_VLAN_BSWAP,
 	IGB_RING_FLAG_TX_CTX_IDX,
-	IGB_RING_FLAG_TX_DETECT_HANG
+	IGB_RING_FLAG_TX_DETECT_HANG,
+	IGB_RING_FLAG_TX_DISABLED,
+	IGB_RING_FLAG_AF_XDP_ZC
 };
 
 #define ring_uses_large_buffer(ring) \
@@ -822,4 +827,11 @@ int igb_add_mac_steering_filter(struct igb_adapter *adapter,
 int igb_del_mac_steering_filter(struct igb_adapter *adapter,
 				const u8 *addr, u8 queue, u8 flags);
 
+struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
+				   struct igb_ring *ring);
+int igb_xsk_pool_setup(struct igb_adapter *adapter,
+		       struct xsk_buff_pool *pool,
+		       u16 qid);
+int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags);
+
 #endif /* _IGB_H_ */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 775c78df73fb..2c1e1d70bcf9 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2929,9 +2929,14 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
 
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
@@ -3058,6 +3063,7 @@ static const struct net_device_ops igb_netdev_ops = {
 	.ndo_setup_tc		= igb_setup_tc,
 	.ndo_bpf		= igb_xdp,
 	.ndo_xdp_xmit		= igb_xdp_xmit,
+	.ndo_xsk_wakeup         = igb_xsk_wakeup,
 };
 
 /**
@@ -4376,6 +4382,8 @@ void igb_configure_tx_ring(struct igb_adapter *adapter,
 	u64 tdba = ring->dma;
 	int reg_idx = ring->reg_idx;
 
+	ring->xsk_pool = igb_xsk_pool(adapter, ring);
+
 	wr32(E1000_TDLEN(reg_idx),
 	     ring->count * sizeof(union e1000_adv_tx_desc));
 	wr32(E1000_TDBAL(reg_idx),
@@ -4771,6 +4779,7 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
 	xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
 	WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
 					   MEM_TYPE_PAGE_SHARED, NULL));
+	ring->xsk_pool = igb_xsk_pool(adapter, ring);
 
 	/* disable the queue */
 	wr32(E1000_RXDCTL(reg_idx), 0);
diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
new file mode 100644
index 000000000000..925bf97f7caa
--- /dev/null
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -0,0 +1,210 @@
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
+static int igb_realloc_rx_buffer_info(struct igb_ring *ring, bool pool_present)
+{
+	int size = pool_present ?
+		sizeof(*ring->rx_buffer_info_zc) * ring->count :
+		sizeof(*ring->rx_buffer_info) * ring->count;
+	void *buff_info = vmalloc(size);
+
+	if (!buff_info)
+		return -ENOMEM;
+
+	if (pool_present) {
+		vfree(ring->rx_buffer_info);
+		ring->rx_buffer_info = NULL;
+		ring->rx_buffer_info_zc = buff_info;
+	} else {
+		vfree(ring->rx_buffer_info_zc);
+		ring->rx_buffer_info_zc = NULL;
+		ring->rx_buffer_info = buff_info;
+	}
+
+	return 0;
+}
+
+static void igb_txrx_ring_disable(struct igb_adapter *adapter, u16 qid)
+{
+	struct igb_ring *tx_ring = adapter->tx_ring[qid];
+	struct igb_ring *rx_ring = adapter->rx_ring[qid];
+	struct e1000_hw *hw = &adapter->hw;
+
+	set_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
+
+	wr32(E1000_TXDCTL(tx_ring->reg_idx), 0);
+	wr32(E1000_RXDCTL(rx_ring->reg_idx), 0);
+
+	/* Rx/Tx share the same napi context. */
+	napi_disable(&rx_ring->q_vector->napi);
+
+	igb_clean_tx_ring(tx_ring);
+	igb_clean_rx_ring(rx_ring);
+
+	memset(&rx_ring->rx_stats, 0, sizeof(rx_ring->rx_stats));
+	memset(&tx_ring->tx_stats, 0, sizeof(tx_ring->tx_stats));
+}
+
+static void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid)
+{
+	struct igb_ring *tx_ring = adapter->tx_ring[qid];
+	struct igb_ring *rx_ring = adapter->rx_ring[qid];
+
+	igb_configure_tx_ring(adapter, tx_ring);
+	igb_configure_rx_ring(adapter, rx_ring);
+
+	clear_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
+
+	/* call igb_desc_unused which always leaves
+	 * at least 1 descriptor unused to make sure
+	 * next_to_use != next_to_clean
+	 */
+	igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
+
+	/* Rx/Tx share the same napi context. */
+	napi_enable(&rx_ring->q_vector->napi);
+}
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
+	struct igb_ring *tx_ring, *rx_ring;
+	bool if_running;
+	int err;
+
+	if (qid >= adapter->num_rx_queues)
+		return -EINVAL;
+
+	if (qid >= netdev->real_num_rx_queues ||
+	    qid >= netdev->real_num_tx_queues)
+		return -EINVAL;
+
+	err = xsk_pool_dma_map(pool, &adapter->pdev->dev, IGB_RX_DMA_ATTR);
+	if (err)
+		return err;
+
+	tx_ring = adapter->tx_ring[qid];
+	rx_ring = adapter->rx_ring[qid];
+	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
+	if (if_running)
+		igb_txrx_ring_disable(adapter, qid);
+
+	set_bit(IGB_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
+	set_bit(IGB_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
+
+	if (if_running) {
+		err = igb_realloc_rx_buffer_info(rx_ring, true);
+		if (!err) {
+			igb_txrx_ring_enable(adapter, qid);
+			/* Kick start the NAPI context so that receiving will start */
+			err = igb_xsk_wakeup(adapter->netdev, qid, XDP_WAKEUP_RX);
+		}
+
+		if (err) {
+			clear_bit(IGB_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
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
+	struct igb_ring *tx_ring, *rx_ring;
+	struct xsk_buff_pool *pool;
+	bool if_running;
+	int err;
+
+	pool = xsk_get_pool_from_qid(adapter->netdev, qid);
+	if (!pool)
+		return -EINVAL;
+
+	tx_ring = adapter->tx_ring[qid];
+	rx_ring = adapter->rx_ring[qid];
+	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
+	if (if_running)
+		igb_txrx_ring_disable(adapter, qid);
+
+	xsk_pool_dma_unmap(pool, IGB_RX_DMA_ATTR);
+	clear_bit(IGB_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
+	clear_bit(IGB_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
+
+	if (if_running) {
+		err = igb_realloc_rx_buffer_info(rx_ring, false);
+		if (err)
+			return err;
+
+		igb_txrx_ring_enable(adapter, qid);
+	}
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
+int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
+{
+	struct igb_adapter *adapter = netdev_priv(dev);
+	struct e1000_hw *hw = &adapter->hw;
+	struct igb_ring *ring;
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


