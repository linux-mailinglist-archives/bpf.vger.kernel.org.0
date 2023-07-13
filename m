Return-Path: <bpf+bounces-4951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAAA751F41
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 12:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF202813EC
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 10:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D319810963;
	Thu, 13 Jul 2023 10:47:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A482310791;
	Thu, 13 Jul 2023 10:47:28 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2100.outbound.protection.outlook.com [40.107.22.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC3D212E;
	Thu, 13 Jul 2023 03:47:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbGp4ybPRE7MUIwzrx/ggm5hdNsF8esgpKYX274/wtTxmfIwxfAgcyOmlxEYMwjhPfrmaMgHxzZ69ofTg6VYoJw5jrv9Hb8sh4CqkzxtwhDDwyKF81PXSkmFbebRa6nNjr2Mf8hez1Ys8rVOVGqKiWbZ66XT5pk8l3fn+fzWTS0ax2RLOf6yVLQHw48KnHCxtvJWwBbITgszOqabb6dbSm5OBzcyDX8av1kF5mtfKOIl6cC4lpFgR+Ghds8LfVaKmmcMw2F7JvN8NkNABdhnVrZV49f7dR+sOD6wMbxTeHoR3FqUYelIN9KIgHD6YXZPpChh5Tb0xgMyLODXBIft1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3GIAfDJcM4NKZSpm5MHxiQ/8+BYY0pRKLseuA30vMs=;
 b=fBAxU7WiMwBLLGl9QtZ6bxT3Owl5YC1/uZjmKAboZsMAFHpsnf7YViuUGGTFsoUSVM1y/NF05Q/PUeF+W0oR4wgupgYF4Rz8qPZQeXmNmS7gLP5u9iCgfTMcSKW6hssPG6hSgMe6OEfTTO2pQKlbrCjKW963hm9dDk2eVWePsTcyi8JqA8lSNkPL2+haMQf8WcoPIn+a2i8UhSP1qKzShfky6L8Zn58FbXIbZLntebWhmxI/R8Y7cMi9R+y9YDkDAabWeMSQzs3TnYBGChhh0ZTFTEHYbH2NVkWHXAYePmTNHxiVqCYMf2A+TOyQi78Eqv3+4DbE+toVQmf2OsY0Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3GIAfDJcM4NKZSpm5MHxiQ/8+BYY0pRKLseuA30vMs=;
 b=eSX/vXhQBZS/2SB/MrAnSTLXK7ISbvXJSrg8icLHrbt4J/IKn5Rf1LRndKDB1c7ZwMusqoh8UN0Rb2DNyQJRGBFYp4Pj2ccYAHNHLbVDgpyLFuxIGcYXGTdkCmvpkVTirxS/0obG3Foseb3voBFhEsojKeWdKTy+syVyIecwSEs=
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
Subject: [PATCH iwl-next v3 1/4] igb: prepare for AF_XDP zero-copy support
Date: Thu, 13 Jul 2023 12:47:14 +0200
Message-Id: <20230713104717.29475-2-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713104717.29475-1-sriram.yagnaraman@est.tech>
References: <20230713104717.29475-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF000000DC.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:2:0:a) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|AS4P189MB1917:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c746fd-1916-4bd1-fed7-08db838e89e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F5UZOqi+mrY0M+7ecT8Zsf+MXycukoYTDMMIQ4SbPuR0hYPveYeFOmiZJ7ft1vEQ3JiEAAqGpvgqgPlvDRQPrg4a9dxPii/aMvQhK303usLRBueiafAw35xmBcB7IENHpj1ZxdaP//rdZCDZd3SlVb6apg53ujCkv45m7xaeK+F1bCGgSoxL116KJz8OgxH2O4jFsJ+syMZm53RxAsgRnpa0RYCIqd7NwklKmgWAdP9qYmDPFffzmV9k68o5c9REGs+xPCGJ2Isa5/haPCdOVtSTq1ueNxZHv0pcGRwmG1rPC2IFZB4itPHr7gORpQTTA/VooFz12ude4163s0tEY98DcB4w2ur993mdx+RP7sgpqudhT7kHmZ2gNFIyIBNY6RgnL/b7mWbyEn9m4YjuhUIL35uZe4/7HasRYpF2wcIYFhyUTFwMZtEij5mcKQddyWZSTro48B9BOxeQren4e8MdmZKGY/FgPfYwe04Q8tMySfA6XHVcj0EA1n1p18bqgvEEoxJcPxdNdfck/fe/lU3nyXaanevXwAlqFRrq6LpT/NsBeZwWUuq7VYqEvKCJNmAwDmwertPHBm7hRq5Tbly1IHyZjkHFFNYmskvUqSUi5ijlHzSyfdffyWwF7MA0RDLZVGFUQ1k2+TEU7Dw1qc4+J5har+khRDaXVG0Hcns=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(376002)(396003)(136003)(346002)(451199021)(109986019)(2906002)(41300700001)(316002)(44832011)(7416002)(5660300002)(8676002)(8936002)(36756003)(86362001)(6512007)(478600001)(6486002)(6666004)(83380400001)(2616005)(26005)(1076003)(186003)(38100700002)(6506007)(54906003)(66556008)(66476007)(66946007)(4326008)(70586007)(266003)(37730700002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LFHGVU+w0hX3sQ0XZyLVTG5CB7KKYNJBN9yP8vlbbY7CRT0GuGuaIIASCHko?=
 =?us-ascii?Q?eUM0kMOhW5VIUEQABLnok/PanE53dw0MjLNvrDORsu2x3Dt9YkEbPgzmAhAB?=
 =?us-ascii?Q?Hs5+mf8z+x6iTGWY4h4qtQUVHMnGcyY7akJlSZLp4cjvR4x1dhSRksSaiBVc?=
 =?us-ascii?Q?Lmr6LnwbtrN+DHXxxh5wTTj82/hzC2fqsy68yVEcCgPmgrOLgumu07Gy85S4?=
 =?us-ascii?Q?5DLgQusJG5nV49XZQm4ICLpg7rtPjvvO+zs5I8+/7vl6Eh9Mrwo50msYXAAG?=
 =?us-ascii?Q?Gx0/GslFbQwxRFS+44bLXuzsgjfuLQ85g6iACZEcbizoA+j9XsS1Ylkuk6Bd?=
 =?us-ascii?Q?6Ro+kuZ2pMEAQT4x1dzSCnpM/8fcUKunCKZf8l1CJ3WQwoFnqjvmJaJsWXm5?=
 =?us-ascii?Q?9mP05/wE0XPpdL8UPmGCjZ0dPQFzXLmYc5DgzZJImkRk5QR/kqoj+/iA/f7J?=
 =?us-ascii?Q?AxvygnSEaSiN3fiiIhxIvqisOpZLtZAH84UXkjz9Jeyi28ukk4u/19ehOvaH?=
 =?us-ascii?Q?QxA4+3yJ7799K+CsFATUM2H4CkTYF+XWPHiBhr7CFzDAkZfyZHIK3yr2mXSU?=
 =?us-ascii?Q?IF6LQCZ1dkddCo6pLeqUKjHmKmkUAjnpD8PR3bxIOCwwRtP125g9Yr6raom2?=
 =?us-ascii?Q?C3TPJu4iaUJXXMgo7liCm0UkkfNS9Qgf+O3WpD/MGzHK2RSVVvU4DbcnlaAD?=
 =?us-ascii?Q?F7XPQHbq/A/cfe7CiwXOuEtEhNPDuN8sxA70UEpKE5d9/laj9Nm9oPygz/ld?=
 =?us-ascii?Q?aCG7KAfiVjarnT3NcBVmMSM4EnYzSBdkZjks74GGFvfDm0D8vQ61OVxfAcIX?=
 =?us-ascii?Q?WBcoW7Frtj8xIkljGXrZ9jgTgnUuVV3KelAyPYzEl4MAF0YRrKqTJt56UvKA?=
 =?us-ascii?Q?302XuNVvyPw7ryBNSseznla4lJNQuCmjrACFE48MMHxYKjNbx/YupmKemRe7?=
 =?us-ascii?Q?nV+m9tmwT8pHXXCKs8TTWz+4xv73Zi+LIpCuiosehhDUKdK4YaD3lzudJIMY?=
 =?us-ascii?Q?CwYjbsXjqI+KuOfPFeASrAZtmikeyZnFuFWjaLQUwIciHxZwHM30A7HX4fyK?=
 =?us-ascii?Q?yEJqhEnEPUSwclJftjMWQSEQ2ltWgu/E0fJ18wSk9YAI3XomAqu0+52qRlwh?=
 =?us-ascii?Q?V3EUgdvojSiURqutT1V9g1A4ScDYJEjbIEusyuVuvAGCc0E9IX0Ettdv3Zy1?=
 =?us-ascii?Q?OZ+VGWtLQxbXPfvW4yui9LJpcOofAgJZozhObCxVtm2Edw6cYi101LDyDVH4?=
 =?us-ascii?Q?TKIxKMYEvUybx9QDW5wD4+5fzxZdODARhKZk41yUs230EqqzQeN2KAsbI6jD?=
 =?us-ascii?Q?E8u6xAf1Gv0rIIQe5vbDhGMtlttl3hEqZRYkFzjq7jGMDFtYgG5jUwnmkCtr?=
 =?us-ascii?Q?oz5xsgZVdyVQ3U1CMHdmbTrh6Je+DnjF6O+kUxPHZKNbELuC4HRVzzmK912p?=
 =?us-ascii?Q?bMHq/Cg3zK/gMEfkt/H0T5HA0Fb+5OdywIDOV4mlORJKfPeEatrWyVGZscbx?=
 =?us-ascii?Q?6RKgfcCTdcYzRnpulwHogLmBezmlSSp9Da+anCbEttenKKcvhP/t7CbdecMx?=
 =?us-ascii?Q?rz2Svd9Ro1Fa55TsxFbFOUHQepyB0euQOJHTb+MCW8BYSJaK4hv4SZxJOQlY?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c746fd-1916-4bd1-fed7-08db838e89e9
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 10:47:22.7057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trVb2KHzH94T1N+TjrcxG6EOuGFYWMAwnTqkDoFrHfK/OB7bJJo9FHPYZpzSn28PjlinfOJ8toNDxkt76ZIJ+2Mi+fU+A8ThyUXXdnGWYxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB1917
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Always call igb_xdp_ring_update_tail under __netif_tx_lock, add a
comment to indicate that. This is needed to share the same TX ring
between XDP, XSK and slow paths.

Remove static qualifiers on the following functions to be able to call
from XSK specific file that is added in the later patches
- igb_xdp_tx_queue_mapping
- igb_xdp_ring_update_tail
- igb_clean_tx_ring
- igb_clean_rx_ring
- igb_run_xdp
- igb_process_skb_fields

Introduce igb_xdp_is_enabled() to check if an XDP program is assigned to
the device.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 drivers/net/ethernet/intel/igb/igb.h      | 15 ++++++++++++
 drivers/net/ethernet/intel/igb/igb_main.c | 29 +++++++++++------------
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 015b78144114..58e79eb69f92 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -718,6 +718,8 @@ extern char igb_driver_name[];
 int igb_xmit_xdp_ring(struct igb_adapter *adapter,
 		      struct igb_ring *ring,
 		      struct xdp_frame *xdpf);
+struct igb_ring *igb_xdp_tx_queue_mapping(struct igb_adapter *adapter);
+void igb_xdp_ring_update_tail(struct igb_ring *ring);
 int igb_open(struct net_device *netdev);
 int igb_close(struct net_device *netdev);
 int igb_up(struct igb_adapter *);
@@ -731,12 +733,20 @@ int igb_setup_tx_resources(struct igb_ring *);
 int igb_setup_rx_resources(struct igb_ring *);
 void igb_free_tx_resources(struct igb_ring *);
 void igb_free_rx_resources(struct igb_ring *);
+void igb_clean_tx_ring(struct igb_ring *tx_ring);
+void igb_clean_rx_ring(struct igb_ring *rx_ring);
 void igb_configure_tx_ring(struct igb_adapter *, struct igb_ring *);
 void igb_configure_rx_ring(struct igb_adapter *, struct igb_ring *);
 void igb_setup_tctl(struct igb_adapter *);
 void igb_setup_rctl(struct igb_adapter *);
 void igb_setup_srrctl(struct igb_adapter *, struct igb_ring *);
 netdev_tx_t igb_xmit_frame_ring(struct sk_buff *, struct igb_ring *);
+struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
+			    struct igb_ring *rx_ring,
+			    struct xdp_buff *xdp);
+void igb_process_skb_fields(struct igb_ring *rx_ring,
+			    union e1000_adv_rx_desc *rx_desc,
+			    struct sk_buff *skb);
 void igb_alloc_rx_buffers(struct igb_ring *, u16);
 void igb_update_stats(struct igb_adapter *);
 bool igb_has_link(struct igb_adapter *adapter);
@@ -797,6 +807,11 @@ static inline struct netdev_queue *txring_txq(const struct igb_ring *tx_ring)
 	return netdev_get_tx_queue(tx_ring->netdev, tx_ring->queue_index);
 }
 
+static inline bool igb_xdp_is_enabled(struct igb_adapter *adapter)
+{
+	return !!adapter->xdp_prog;
+}
+
 int igb_add_filter(struct igb_adapter *adapter,
 		   struct igb_nfc_filter *input);
 int igb_erase_filter(struct igb_adapter *adapter,
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 9a2561409b06..775c78df73fb 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -117,8 +117,6 @@ static void igb_configure_tx(struct igb_adapter *);
 static void igb_configure_rx(struct igb_adapter *);
 static void igb_clean_all_tx_rings(struct igb_adapter *);
 static void igb_clean_all_rx_rings(struct igb_adapter *);
-static void igb_clean_tx_ring(struct igb_ring *);
-static void igb_clean_rx_ring(struct igb_ring *);
 static void igb_set_rx_mode(struct net_device *);
 static void igb_update_phy_info(struct timer_list *);
 static void igb_watchdog(struct timer_list *);
@@ -2939,7 +2937,8 @@ static int igb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	}
 }
 
-static void igb_xdp_ring_update_tail(struct igb_ring *ring)
+/* This function assumes __netif_tx_lock is held by the caller. */
+void igb_xdp_ring_update_tail(struct igb_ring *ring)
 {
 	/* Force memory writes to complete before letting h/w know there
 	 * are new descriptors to fetch.
@@ -2948,7 +2947,7 @@ static void igb_xdp_ring_update_tail(struct igb_ring *ring)
 	writel(ring->next_to_use, ring->tail);
 }
 
-static struct igb_ring *igb_xdp_tx_queue_mapping(struct igb_adapter *adapter)
+struct igb_ring *igb_xdp_tx_queue_mapping(struct igb_adapter *adapter)
 {
 	unsigned int r_idx = smp_processor_id();
 
@@ -3025,11 +3024,11 @@ static int igb_xdp_xmit(struct net_device *dev, int n,
 		nxmit++;
 	}
 
-	__netif_tx_unlock(nq);
-
 	if (unlikely(flags & XDP_XMIT_FLUSH))
 		igb_xdp_ring_update_tail(tx_ring);
 
+	__netif_tx_unlock(nq);
+
 	return nxmit;
 }
 
@@ -4897,7 +4896,7 @@ static void igb_free_all_tx_resources(struct igb_adapter *adapter)
  *  igb_clean_tx_ring - Free Tx Buffers
  *  @tx_ring: ring to be cleaned
  **/
-static void igb_clean_tx_ring(struct igb_ring *tx_ring)
+void igb_clean_tx_ring(struct igb_ring *tx_ring)
 {
 	u16 i = tx_ring->next_to_clean;
 	struct igb_tx_buffer *tx_buffer = &tx_ring->tx_buffer_info[i];
@@ -5016,7 +5015,7 @@ static void igb_free_all_rx_resources(struct igb_adapter *adapter)
  *  igb_clean_rx_ring - Free Rx Buffers per Queue
  *  @rx_ring: ring to free buffers from
  **/
-static void igb_clean_rx_ring(struct igb_ring *rx_ring)
+void igb_clean_rx_ring(struct igb_ring *rx_ring)
 {
 	u16 i = rx_ring->next_to_clean;
 
@@ -6631,7 +6630,7 @@ static int igb_change_mtu(struct net_device *netdev, int new_mtu)
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	int max_frame = new_mtu + IGB_ETH_PKT_HDR_PAD;
 
-	if (adapter->xdp_prog) {
+	if (igb_xdp_is_enabled(adapter)) {
 		int i;
 
 		for (i = 0; i < adapter->num_rx_queues; i++) {
@@ -8600,9 +8599,9 @@ static struct sk_buff *igb_build_skb(struct igb_ring *rx_ring,
 	return skb;
 }
 
-static struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
-				   struct igb_ring *rx_ring,
-				   struct xdp_buff *xdp)
+struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
+			    struct igb_ring *rx_ring,
+			    struct xdp_buff *xdp)
 {
 	int err, result = IGB_XDP_PASS;
 	struct bpf_prog *xdp_prog;
@@ -8798,9 +8797,9 @@ static bool igb_cleanup_headers(struct igb_ring *rx_ring,
  *  order to populate the hash, checksum, VLAN, timestamp, protocol, and
  *  other fields within the skb.
  **/
-static void igb_process_skb_fields(struct igb_ring *rx_ring,
-				   union e1000_adv_rx_desc *rx_desc,
-				   struct sk_buff *skb)
+void igb_process_skb_fields(struct igb_ring *rx_ring,
+			    union e1000_adv_rx_desc *rx_desc,
+			    struct sk_buff *skb)
 {
 	struct net_device *dev = rx_ring->netdev;
 
-- 
2.34.1


