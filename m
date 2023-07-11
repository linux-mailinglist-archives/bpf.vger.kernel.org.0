Return-Path: <bpf+bounces-4755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DDD74ED3D
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 13:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024CA1C20D5D
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 11:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1FF18C05;
	Tue, 11 Jul 2023 11:49:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5D718AEE;
	Tue, 11 Jul 2023 11:49:18 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2096.outbound.protection.outlook.com [40.107.6.96])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6246136;
	Tue, 11 Jul 2023 04:49:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFwSqE+YrgdZ0aH2P/oxmvACnOl+u/pFQI5QYhtMcEf4vZZS5ClblX8124KRko8nkcjowySua+Ydp8NktDsHJgvmoZtcHLO11DrUU+kjMNVRWyE2yoPgU3CocrhSn/8k3YScq/Zz6W3Xr7F6anZBMVIM76I0AHNQgLm1/d/JimrN+5QZoDqiXenuKn/fO6JtYBqsK6BWmDXsPP0odJxg6q0N2LkKSEckpbYhbuB5uT1Ocef14CvUPm4I4ks+IjkwR3j37j+kglt9i3qets9zOqKbgLM5OzoAB67xCyL+Hff6DRpjN458gW/Oao2w+58RThkgp4HVgIGkfr51YV0J7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3GIAfDJcM4NKZSpm5MHxiQ/8+BYY0pRKLseuA30vMs=;
 b=T4426Iq9JpUWwdeioaWNiz7b28J8lVFMlw9hBa0dRx7cBmmc2wP99p4CnGTbTZcV8MpYa6H13i4H3pcWWeH2UOQqUbJJaObZ5Aa8zCJ2h0G3YPoYqlGJASpBbn7ovJfhlFAEeMxnpB1pVxYGO89Gmv0dFINwQWvSwUl3JT6wTttNtBkddvXvlz7KwLGf13jVACgEUFZbEMGduRb3OUDHiAnJOJ6IkluqgEUfTTvDIPHEFh4H+ax8qdn8QRqDvZtJ8jtzO/AQTWkPf8SrIXbi5woGX07ogeraSOk3atc4CwC+E7e7fYW+q9yryGl35pRcMce086Y7jH4646ZCZzYfNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3GIAfDJcM4NKZSpm5MHxiQ/8+BYY0pRKLseuA30vMs=;
 b=BEcq1uidEHwzLy1WWkp1TRCDrjElcVwKyFyQjFIV7dSfpbUBc31+b8LcrMuf62uniX+rLhOQIDYgMChjFdzapLQF1yz2+Lu5QM69BCrgQLceHhOUvp3G/Rht/FzNVGzWxe8aWO6EDodOh7ha8rkWWagY4MW+bvAQT+MO2VJ+Seo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by AS4P189MB2088.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:517::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 11:49:14 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 11:49:14 +0000
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
Subject: [PATCH iwl-next v2 1/4] igb: prepare for AF_XDP zero-copy support
Date: Tue, 11 Jul 2023 13:47:02 +0200
Message-Id: <20230711114705.22428-2-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230711114705.22428-1-sriram.yagnaraman@est.tech>
References: <20230711114705.22428-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0077.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::33) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|AS4P189MB2088:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b87d250-4b04-4bd8-ebe8-08db8204d939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BPVyB2FT05jgDGSA0Ikrv2jSL4nMUXtaP2QYj/kOL5YbThV+5L/mdMUtiNwZ3pGq6hhObsSwDEXRaVWfGDDtj2HcfCfJD7Xb2S9DAiKIjhCjs+dU5JG/8vMeE9/m/MwPMzIJsBzIA36A0H/HxlBJUVvSc6rMGlzRCUj4CWOBsOk5AzwVsWrR+1Z8cryJ/ZN2kXSspOOYYCR9F3A1T05E0XotRh2nwphm6GxZtWqWMjc0QjtFCXKET1WbM5QexsBqHHFsHJDnt7JvIoyeEPGrkjuiEHzayjoVL6XvrV374k7JpRh+dG1EGwumxblqEwwwCbReUQdY9+yhH2NN8KeNFAHisFZkd91zCOe2pVgj0kk6GF3lLel9mlt4ob43T9fRjgMWpoREZqs/74saiLcnNoqHbSlSG4zXP94f8HjNQnu6yL1SrFnGHOGi5WXWa3EaQ8c5u6xhUuQZCOAe9Yu6ZOOLKfNvPv0K8h0kHvy9J1mWxlOo/nNPqckoZTwZG8XiRbB8VCRgKxAHKmRqdpAhhl/YGKRB5Edc02zVG4jDZB7FSF65el2XpV7H1J3raAyB0pqphtiCF2A1/9sDzmDn/Lu/iuTsJ27yyLuyxtOjCP5nnEFM+3mShNjCdSMZcSK1ziUMWj0JsUMErLybOKRcHUWbYsKbjS6mZn6dn1DOeR8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(39840400004)(376002)(451199021)(109986019)(6486002)(4326008)(66946007)(70586007)(66476007)(66556008)(478600001)(6666004)(26005)(1076003)(6506007)(38100700002)(54906003)(41300700001)(6512007)(316002)(8936002)(8676002)(86362001)(5660300002)(7416002)(44832011)(186003)(83380400001)(2616005)(2906002)(36756003)(266003)(37730700002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?alfaWAROz4AIF/1zMtvnv1CteTKVlM45qBd/xNi6BW2HfmLz8u2WElsSLoeC?=
 =?us-ascii?Q?mwSYl4GHxQKNTryxT6oSjM20MyyvvTcwizs1zHm7t5p0HxdixTYjqk8WZWuS?=
 =?us-ascii?Q?gBJZhWm0r1y2U2VuWKAzKpo7xMSobTmyAerEAMNdsm+kl08Z0YsnKXIFkhgX?=
 =?us-ascii?Q?SWO1v2GreraBktkyOtvVuqcXRA5EqUNwv67qrepA9YBbHkfvehC02cOWgmrz?=
 =?us-ascii?Q?xnUZi47nj9JKd4lTGrVVH5aJA4GhZnBDGqrUtNqIauDWfrafv6D3zVpCAFNd?=
 =?us-ascii?Q?chBP7ehhEd83KbVXSF/T1GK05/uVn2RckVoMb+0pX2f25TfyUNojw6soSJCd?=
 =?us-ascii?Q?l4rTkrxBLlxAG+xONv5w+Cw3E64ZKX5P4b8SkChtw+Ye4AweRBMdO7CVPCR+?=
 =?us-ascii?Q?/eT8b8DAUgi1eHbd6JurEhkSRNuD48yFQ0CHSJ/VxyCwbf4AChajZpKeMJOa?=
 =?us-ascii?Q?SizHUVVw7KiiwAWKpPh5i+SySwudzA49OllMUor7il1/FzrLsDwE352ee1au?=
 =?us-ascii?Q?G2DbIt8Q4KWkXP9lTmSlPnkr15L9EbLg0hhFxGtDwk7L8XdPimGnyG0qGZ8K?=
 =?us-ascii?Q?8Hf7pN+y8pcR3jbkqyck67WjozkN5VeSkf55mXwZ4WDEj56B6N1p1jKnwmuo?=
 =?us-ascii?Q?RdGRcvQBRss6yYFap2kA4YLLCj2ejIacc+GoY8opB6AlTjy/MD7jGwWoJklG?=
 =?us-ascii?Q?jwSDbsOl//bT/7iS5JXB+ARBTuikqzWxlFM1HRsQkBcq4lk7IWYZ1gjYIDeO?=
 =?us-ascii?Q?UNspEteusuhSCPkOlzW+6rXA89gnhYulNvcFT553dqUZMvyUg8FlNXbdZUWG?=
 =?us-ascii?Q?gIweHtSLVlEQnUpni26PDFQMQEHJKvblXUfO8Y52Mxy8vvvHpxHLdrL/uHui?=
 =?us-ascii?Q?7iMSASUAKhFKrVCnvM81cLNTzFdWsj1zhF754Oj3jLd/EpsQ+4x9cy9F3oEM?=
 =?us-ascii?Q?K4nK0jJOb3Slz3iTV5wgOh0mKPqFDJ4f/2gRA90FQGNwPq2AjHOFbUAp12D8?=
 =?us-ascii?Q?swy7SO4xqEyaZoW/OwE84cvW3KNeVV6Mov5HGV85e5iUqRhjxc4cmAQU/Z2s?=
 =?us-ascii?Q?JpCqpVofwLflEI4OurcllXuGDDFQgtj4dyPJkkF5Qi8ClNgBo5I2C4MGlUdJ?=
 =?us-ascii?Q?D6dIvQzA2Dk6Qwg8ISPZNCbIyLFeovKzk6L2T3idPH4pxNBNTOsjGvkuO+JX?=
 =?us-ascii?Q?Iqbo+/B7BIup2OoQiEL6DvBHBZ2nhIPe1Wv0716EEFyv1Av2DtNwBAv80ze3?=
 =?us-ascii?Q?2ioDDwhj8GYEDmUq7KLGmy7qb4QpWSZvlr3Y8E1DQpt9pRH0QGQhPi9SCbSq?=
 =?us-ascii?Q?cGCvKZYbkMqqsE8aGithdlyzShe0ZZOcHrkq0NO91UZ1jil6wuucl0qpwVGj?=
 =?us-ascii?Q?Pq7O7MRA3ATnD4eLS3Hnq6p6Ph/kmAoDUVCTW/cdkw3fdZUTbNQG6DDSBnJE?=
 =?us-ascii?Q?0ALTkq4PtiZzvVer4TfgkN6HSHAWMK/UCTrAoK8Ve8ak2pTfna88roNexRCL?=
 =?us-ascii?Q?/XPnyza/Nat7FlJH3DQ/o1mD4gNobTIphk4gJ2TgsOFemU8FP6ojenF959xQ?=
 =?us-ascii?Q?Y/QDy33mEDB1SlqW+b6cPfStMwpU/A5UUL70u+ASJDJ/AD8t7Cj0xUUbps6F?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b87d250-4b04-4bd8-ebe8-08db8204d939
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 11:49:14.0086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZsXI3xH5O9tAqqXeC6fXJ/VfPbaDdCiCiAMNmo4sC8lnQ4aFQcIW8F9bBEUAlBE7DKdzUcrmB09nA0GWi9FQCUiQbU3vhV+ag8Ex4V1Go8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB2088
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


