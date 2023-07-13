Return-Path: <bpf+bounces-4952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A99B751F4A
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 12:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5F6281DAC
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 10:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8065111A7;
	Thu, 13 Jul 2023 10:47:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863EB1097C;
	Thu, 13 Jul 2023 10:47:31 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2100.outbound.protection.outlook.com [40.107.22.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C96212B;
	Thu, 13 Jul 2023 03:47:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLBvTJgmaTFNleHSmKkMPBnif87Kp2noRzbk3v79/z89XMPija+d4uaSSNEKmD6hj9DUCAseOuH9zw6FAXzDL9TDbrmRB7j3/mbKoYFmCKBRePp91Vi69XcqUMVBp1P4jOocRVGN7M6QAbXjhLADsGWD93OUB0iHP4LONyBCagCSiyeoDrICYtmr+EgdcMP8uqkFJPs/qyO2X/33GXLUBtfUfkPlO3c5kk62RSHuSpfM81FPYMfxsKRdw8gPan6Y7L+vxZfydFn3tfqQM8v+hzo/8vadRtcOHZIqqif85wugXMNa3nnmkUyWSDdifr6rFd1bv5V5ork4kGpS5tO1jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ec8tI81n3emaORjojzJTfh9xzHGICKi45AOXMsqZKJI=;
 b=Hz0aOliygdn8b3SFl5nehiw8U38WJRyOzQ7AYFh6Jf+7UGm96dYv3FTv3IvDsAwaCbosKB1AWZbVwVMhfqgzpSux+HklQldwgs60ATbg4aojsJVYsiXwVJgJSQRxbmE3XRYzx6t0yEkqJrDJqjbL+LyIKfqVNP872wBT6LbEZ+AyqFEjEPXFZlkCZY03fsoNcUtb6CuesoXo81gSbKEj+u1ZbmLeTrO5HGXyna3XNoNPdRYoNoCBvM7MGe5147wMOr2nZeVXsEucf6RiAGnrhSN9XquVFY1BGma7xSjDYlk8uXck3JQFlXOG3NvN/C1M0gxFCaCRnpQujVBVIPDK0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ec8tI81n3emaORjojzJTfh9xzHGICKi45AOXMsqZKJI=;
 b=Xe8u8TLgB30OGwm6upj/r7H66Iews9yFR7GVUbQNBJjm2I3zITJ0ODdGM6EYjRhU925FFSNPvWBwRpE3oTtYYR9jxjIuy+nkCNmevw46RzUSaZENN7IP+ciQMvkEdg1PD41POSAyWaAm7BErX3zApHU1c0TxbfrM6SSjQmzwIwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by AS4P189MB1917.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:4b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 10:47:23 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6%4]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 10:47:23 +0000
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
        Simon Horman <simon.horman@corigine.com>,
        Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Subject: [PATCH iwl-next v3 2/4] igb: Introduce XSK data structures and helpers
Date: Thu, 13 Jul 2023 12:47:15 +0200
Message-Id: <20230713104717.29475-3-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713104717.29475-1-sriram.yagnaraman@est.tech>
References: <20230713104717.29475-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF000000D0.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:2:0:15) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|AS4P189MB1917:EE_
X-MS-Office365-Filtering-Correlation-Id: 5abc70a2-fd40-4820-f969-08db838e8a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w1m8AMYYKWux9Z3gyMYSoEidTGGlWq+EawZu1iCxTKKwT7p+y6HvtnzedRnzIOS8+oGCcqiQBtCEjjNSRqsXpGnRavh4+9s79s2IhnUxKk83veJKNzfaMFsXyuLHUtdWlsow3zc5m211LK/To+WFaEuNcSKNvdcb00T0i3Aqg/pnGUG98F+GReVnzZNp9H3wisLhL+kfHelwBx7ObSnxrQfkXVGAwVO7uZq0yQ9Nw7ef37/iLuERU+c1EIZsTfOumAveaMInr8OqopZEuCYKIVIGNQlJwv2G3IyD0oPmnbqForALjoPJ75v4vGi0hJoEn27Z9iuhDrusD3KhozlVBZ3yGRvSbbeUE1qJMM9mD/xv+NzkLNfo72ZkfgXyIyTH7BvvSRNByc9f7i15xRFRZOamj2EssFRGbxCcSGoJp28X26BI5vUYFCVMrvVwLKfzxkPXYv2oqRTPZy60LDYU+ffdePW4aD9rNZDFOiWdgAOQlzQ1WBdepk6cXUYJ1rup6K0x8ywCs22RNWYEfRIKSOcyHvJ3UcgsbdF+HF5dvakQWjF33amWWucLJQ5bAxVjIKXcVoWjLk/DkYwF5eR0+6mEA2kdefRyMidQk4fAVbdEnzXKgMe+Zj8wOK99MOWSupVNuiNSuC9UIA/hfMDe4Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(376002)(396003)(136003)(346002)(451199021)(109986019)(2906002)(66899021)(41300700001)(316002)(44832011)(7416002)(5660300002)(8676002)(8936002)(36756003)(86362001)(6512007)(478600001)(6486002)(6666004)(83380400001)(2616005)(26005)(1076003)(186003)(38100700002)(6506007)(54906003)(66556008)(66476007)(66946007)(4326008)(70586007)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TkfeCy9iGjwH/GmjX1fm6z4HqStPbLHckG9xno67fG6nSJ40ZtBCwHL4ttpA?=
 =?us-ascii?Q?/0FCZegBD5ilPRZt4En5IQwv/l6ot4BrjU/syGvb+mxfzye6F6cAE8317t8O?=
 =?us-ascii?Q?sBrPh8Bxus0KAeCXXhp7MjxyoaNNS3JAOAU7vvGSRncbqCfU05Mt3F+jOKcb?=
 =?us-ascii?Q?vnw7DZFn14OfkSLbELpAWhLiGYBTK3lbRse950AaT205aJCcZAw1iz18UbAx?=
 =?us-ascii?Q?2XxovZetx9OrfdEbChpRLRybhHcWFOmttLYfh5Wu9ks2po4tDzfMl9O+sz14?=
 =?us-ascii?Q?pIVmWjI+g+i6OGgdKTOtDyjfdXXXw1AorJ4zHy6kOf1g36yL8CQa1UPfAsVN?=
 =?us-ascii?Q?IYUC1zc82OjzIVnoLB6DB5QD+Zr/YvSEKfIJQN7ga5vTVroAQxdvmrjWzhZP?=
 =?us-ascii?Q?zBeJqQndVElzsFLKEYSwCv2kQq079/2sChZ8BIYFgFeoa7c2RLi1DqqWIEL3?=
 =?us-ascii?Q?O9a3AmeyokZfbEXxbLFyVdKD55DTiE1fgwlPdwlhIFsMtPmNn94sAZeSMQBa?=
 =?us-ascii?Q?3JHOfJMfRMvYqyLlUwTpkuZJlrjLWUhAevIt8oN5zLunt7KecV3m2kRLIzUW?=
 =?us-ascii?Q?9XOFXBY05T8JxokcL+VFKD5/46TrR7fcmJELwbh2SIHwmSlTV5nKTiS7rJbq?=
 =?us-ascii?Q?5vDis8JGhLj1pDcDz5Eg/5ZCmgeDM1tmvpmuTPOUAHb8JBGW1lo4c4wjmD4m?=
 =?us-ascii?Q?btzDfvCqTIw6tFjdXaPKvMoqmF/T3rJCUMfJRdZOVrsip7RYzlcq8ukC5q7F?=
 =?us-ascii?Q?GOp7PvHrIEwAp74cf2RmDjD2A8DlPLyKYZJAS7ErRY1SudfDLZhkHsRZQe5Z?=
 =?us-ascii?Q?eHrawGTLiM5x+SSiJBvaxyVxrJvnn1sGetXn5J+dEfjbBUtBnSereb9CGoDE?=
 =?us-ascii?Q?YJLgcNaQ+IDNXLgotuT1DtGcWwq2ceSdNY1/m2yCLoU8+WtfvOhkavlV5BNY?=
 =?us-ascii?Q?jPUMmOE6iTvsYFG+XZ+XIut0uNwKqMi6NV5DGwGsOyD11dUbzVlUQi4lGMhX?=
 =?us-ascii?Q?wC5CpMJuGorPqb1UsTPaS590+Xf5TvQliaikP2bGVanB32T5ezTD18/rDdwU?=
 =?us-ascii?Q?sWTz1WkZrsbcAfvd2VZvDDZ/Q63nwfro2GsXoxf0bp4gePKecUJ+y3jGJ08h?=
 =?us-ascii?Q?CDBjKKNHH0JQqxVpcQp/SPefT5O8cZ1gandlfI8ryGtjNL32M1v7T7Ix7Fdc?=
 =?us-ascii?Q?5eA2INxKBTnJePOwPpp4hK+iYzJLDZ2rfRHOWfD1M4yVdwiZXzzGQTkPSSam?=
 =?us-ascii?Q?pArL8d68CU8AXLXrAYU+7OKURlqSHLw9duiOOfbMqsNFBTYwuFkwaticlL4t?=
 =?us-ascii?Q?ZJPOh7sUI7x/Jpj66MH6nr4w0BIcKanuUVS61/lN+ms1TDo/EVU3XR3VaB2X?=
 =?us-ascii?Q?2r4Un5KJc9S+ZH3QO8IZWfm+njyxGHajZeG6aqMeJLd/v0/kBc+aIHKJo8Fw?=
 =?us-ascii?Q?TDL1j2lAEJQCsTac9jWWc1+CDsqkqHk85Rk3DF+Aer43os+p2mN90KZA2EhL?=
 =?us-ascii?Q?6ZphEfZljPQxvrHIw9CQRB5zhrCAWMeo3O8pwdHYOZYIrCUzOH865hLqSB1p?=
 =?us-ascii?Q?Fr3SfjI1xdWxW1InXO3fzeViuwxJNQRYtyCAP68I2N61GhXx69tZlCBZOk0K?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abc70a2-fd40-4820-f969-08db838e8a08
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 10:47:22.8555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FuEWcnHjV/C5nTWxYGY+Jhlx3tUlUlimO1cVlR0yKdmBloAAqgxr8GVt3D5NcRGthqvyoYLoKYL3d9Zdz+LAg0v4rdwVFZsIcnGnv5hOyNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB1917
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


