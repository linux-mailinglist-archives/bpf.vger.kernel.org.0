Return-Path: <bpf+bounces-3957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E51C7746E31
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 12:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2148E1C20907
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 10:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148505667;
	Tue,  4 Jul 2023 10:01:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0C053A5;
	Tue,  4 Jul 2023 10:01:31 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2103.outbound.protection.outlook.com [40.107.104.103])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99859184;
	Tue,  4 Jul 2023 03:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6RI9uIXvB+uFgqTjPVg16flUC0FMQ/VTkZmzIwkBimRD1XAKQXSXvoag6a7jdz8M1O5D8NC+kKEs9QQMIQPvgYDTZVxU9kt9s4H/GklNYmVCxXrTonOjw2r+aoPLpObInikpb5Sd9XvYsjtUvW4cxZI0C9UWzBzLtoaYTULZ1u/GkwZpf5D3zsy+qTCOsiHEnZl5H7JUK2xeTA32rAZGeYle0F+9SI7bDlarf6EJMYX6CarX0umvwoyP3gRJn43tTtVfCZB0qWwdHqgoVrMJmYKKOnusyE85y2+JU0uKWucgR0zP72ED/Dpbx3Pdsmyf8SL11kgJT6g3rv73uw68A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyccUYh2pEpQWEmch0Qj4pn+fn6yEzbnJjPn0aC669Q=;
 b=bLDU+bQJHWoFyGiSL1m0La50IV3Q6Ot6vG6oU/uf5pIwmmZIFl7yGKBPJniTdUWqqs4H8nHhMV67xNjpcoHchIXEVPWbbhwFk1xrLIiaAuD23abc0z11gtec3mGNscMi3rNiC2+u/vWWN68W9MxEzI2pWoe+KP5HMnJD91IU3uHT8yNMUTOkxiyh/gRgpm+8n+rrp0p+m/NsO4Lv05wp8dgAqIw/WBK053Q20tkXD/p0Dw+MPzCSH55OfN03dQERp1mGlQ33qw1ptztaU9ImJj1ggvJC73eQEwQ7/XTZjM+BXmXXlv+FXxZwbdFTLqsx7bJH4N5ZoDUuOGygInNUkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyccUYh2pEpQWEmch0Qj4pn+fn6yEzbnJjPn0aC669Q=;
 b=VN6ayClDRy0EL42BzG2LrkCwTB/JL08ND6c7eA33t3ukem2E/qox1ile43tpiL++YlP/us3ci/o2IMnHxp1p1ZEj2cR7jUzRG4Ftlep0UvC5KZOCdeDig+ATL//FgruOzfOKgHIrNy+REVa5FSidBRAtO9RAMh8pbEkts3QU+58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by VI1P18901MB0783.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:123::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 10:01:21 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6%4]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 10:01:20 +0000
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
Subject: [PATCH 2/4] igb: Introduce txrx ring enable/disable functions
Date: Tue,  4 Jul 2023 12:01:17 +0200
Message-Id: <20230704100117.10472-1-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0027.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::26) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|VI1P18901MB0783:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e3b29e-34e7-4563-e1d3-08db7c759d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K1zw9iejbHZZpsISiWTvdfHVPTSbtyxD5/jBVWiB0qlbVVct6lObXUyu0ItuG+P7yIc65TKJOTGCGx30UZDY0x13DcdqwvsnbXDKczaeSHa1RuawoDVunXhEbwfPSe3ILozd8RWujFLlAUiRVdPa8egmYFl6hMz/0JnxkWhWTNqYpomItfVwPeZD/q915HNgM/deJE+HRlAlV6TF1MuSWVcUMZWqMQ7RJIyLks7V/SxAQr6zIDVulJPXU696U0kRvhVxEq/zN33cpaGfkcB42gW+aCTfoRS4wRm7j96zPs/B8Vwf8yNHW8Xwc3738tazsyVQIizBKaNeI0YFuXQdu4Y35BN9U3eWFpHqDJrdKvmnI3/nGSR4jPfc6822B0sLsfPT/mvZIuP63fCoUWX5O+V8w05VLbKqNhuM+nSkm0yGvTuC6mEWQTnIjqLFlX+a+GxxOp/hdXdkWziCTe22OpoaO5eLg26OGQ7p4t+QTTp5pvD1CU0VEkGARqdQi2fFsJBzNXKgXAnVREz1XlyjZXELQxRmObTyC6nvz1mnZrnv3Kvff4mLwAp982cMcacuo9TOf69dBcUPj1O0uy9hhgZzQs+jKW8QfcgYaSdqPSEWPXm5bcdPdRXthvvWQCKAvwX4X5Co/7SaNCLLPYJfWg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(39830400003)(376002)(346002)(136003)(451199021)(109986019)(316002)(41300700001)(6512007)(6486002)(26005)(83380400001)(6506007)(1076003)(2616005)(186003)(478600001)(6666004)(54906003)(38100700002)(44832011)(66556008)(66476007)(4326008)(66946007)(70586007)(5660300002)(7416002)(86362001)(36756003)(8936002)(2906002)(8676002)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?evp4t4n7OXwBIg5jlY9PD/wqLxRZPw4ZZukInjlKR8yrNV8IcflsgKzQhY7I?=
 =?us-ascii?Q?VZ973fOLUg/X+mxols/EscGvijJpKPrSZR+KUVWaDClpX5+HWB1PbVFDDYY2?=
 =?us-ascii?Q?Ugu+OBV6uLabrhAQZnfIzZ7kUn24V51WoU5uWAQHkToa1RTKjQbZ7OGkkNTH?=
 =?us-ascii?Q?IAo0x+Gp7VREZk+If+WlzmvktNWr+PQ3YVYUgQHns6kNbEwcsn5fsb+7YH4S?=
 =?us-ascii?Q?xpaG0chkiCfIqfPIDr48h8rgoHGrk29reve/S5ZPAUWXdkQqTMeGPuKQPsUi?=
 =?us-ascii?Q?szSw5VxVvor2t5pZOAQ6yxeZFUk+RGj1WSXLZHevmFULrDdutdg0KridKx7I?=
 =?us-ascii?Q?UTHBmmXPF7JbxAFYMFHGJ7z2kjRvVzx3LNzmLUoVKGzu3i5jI+hEg8ADuc5Y?=
 =?us-ascii?Q?dW7Iyr6pr+Fd9bFMY4i/vXYwnLlnNvC5A7Tjji3EEzEv6ejNGLpEvn3IDQxz?=
 =?us-ascii?Q?8vCu1c4gUmO/Kp6jWeyRT6YhvVYmmP5gtfWv1Nzcb2uq4Ll1kb8VJ1ZV0x+n?=
 =?us-ascii?Q?AhlVcPckp4K8Dy6IaMmJmBP/DEuz0d1pNE0ysgeOScD/4zEdfkrJhVY/gSJc?=
 =?us-ascii?Q?dlelPHw8EmoKB1eef99Z7iNFxVpUAKS4LNujgNEeqY02VXnLjBSLDg3/m6s8?=
 =?us-ascii?Q?JlkcVpNxt+qj6xhZRH+FJdGgP65/TGv9e2535j18I2Ye2QjnOmkSF9eb8v1+?=
 =?us-ascii?Q?5aAcQzaYrBCgsg1bemcIIrfWvzeLvb4kOF5Ka+dKnofLCyL6c8BLzvRku4nv?=
 =?us-ascii?Q?/8+mdkM6Ubj/t4DvuDeB2yEFFpK6l9KbR360xK2ZiwZp/a+zhQq96Q4wbZLi?=
 =?us-ascii?Q?cjCfIHhPJ1IvfI9/wp0keskIBLY5gsX45ELtkpkvpb2/eNRh5AO6HtMDyxYV?=
 =?us-ascii?Q?ysGEJoBaQ7ojhLRfp1F/GrC6CGpzAEDE6/HagJiV/oJq9UrASCeaJCAAcvZX?=
 =?us-ascii?Q?VBwV0tqxRnI4Uppyi4R9uvY3+3VYZ3Fy99tijCahU7YIggPgkFdyEOeBPBiP?=
 =?us-ascii?Q?ImDs4aAO6H2GOSHYUph4gbY3PCA4Mo/79qHbgn97mJI5/I1F/wsn+Jnm+jYN?=
 =?us-ascii?Q?MwW00dRFPz8J+3Kg8j7PKZUxnPoFRhGDmH7nFs7/ww6A+gel8WMXSjlnsZ0o?=
 =?us-ascii?Q?t0983eajEWF1754wDfPcglcpZ4B+CIs68g47iYkt89G8hl2GQ1vpKI02JFeH?=
 =?us-ascii?Q?Szhjebl0i/Wiae85NURM9lKeHMS+8JbzuVDkSDMIwBtGt6b2quOwyLNFP5Q1?=
 =?us-ascii?Q?1ZUIpA4vUJpFrze1N6bZIck+PK/1bZSDoZxRTFanP+i2jBdj8PNlJ/UePl/C?=
 =?us-ascii?Q?ngCRG0nGxz6SB/06xoU9kqlOS4dCX5oORIUgZV8KxuYwByYgYkXZL7OOsBWd?=
 =?us-ascii?Q?ESNaAxITwqvxxQRSIXWWeXo/EcokccZ5FYw0MQLXtAZY+FwYQFulpDDrs5+2?=
 =?us-ascii?Q?ymIiNygCJYr4LqR4n98wo75/L+PQ6p68V6R0NbYfCoPzlqbXLI456IYg6gkk?=
 =?us-ascii?Q?rDqrZFd4ay6W82dqrR59B8S9VzpVrEUVQQiN8RUyGRat1A2qQpajYYoLgSmU?=
 =?us-ascii?Q?2j2/O4vwo3nxnfYYXlX5vX6Ht1FcKNPEm6WI8BDueBRiUiuPMF2L6UtFpjVr?=
 =?us-ascii?Q?iw=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e3b29e-34e7-4563-e1d3-08db7c759d86
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 10:01:20.0019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Q7NIw7E8xf9xZm5qyM62uG8R1eeA7SiWb/Qt42rmgD692h4/lyT6b/p8ljZGYzMv/uy2jKlATgsCs9qTtlf4/9yevqucZo7shROWgChxfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P18901MB0783
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add enable/disable functions for TX and RX rings, will be used in later
patches when AF_XDP zero-copy support is added.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 drivers/net/ethernet/intel/igb/igb.h      |  5 ++-
 drivers/net/ethernet/intel/igb/igb_main.c | 41 +++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 94440af6cf4b..5fa011c6ef2f 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -384,7 +384,8 @@ enum e1000_ring_flags_t {
 	IGB_RING_FLAG_RX_SCTP_CSUM,
 	IGB_RING_FLAG_RX_LB_VLAN_BSWAP,
 	IGB_RING_FLAG_TX_CTX_IDX,
-	IGB_RING_FLAG_TX_DETECT_HANG
+	IGB_RING_FLAG_TX_DETECT_HANG,
+	IGB_RING_FLAG_TX_DISABLED
 };
 
 #define ring_uses_large_buffer(ring) \
@@ -735,6 +736,8 @@ void igb_free_tx_resources(struct igb_ring *);
 void igb_free_rx_resources(struct igb_ring *);
 void igb_configure_tx_ring(struct igb_adapter *, struct igb_ring *);
 void igb_configure_rx_ring(struct igb_adapter *, struct igb_ring *);
+void igb_txrx_ring_disable(struct igb_adapter *adapter, u16 qid);
+void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid);
 void igb_setup_tctl(struct igb_adapter *);
 void igb_setup_rctl(struct igb_adapter *);
 void igb_setup_srrctl(struct igb_adapter *, struct igb_ring *);
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index dadc3d423cfd..391c0eb136d9 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4856,6 +4856,47 @@ static void igb_configure_rx(struct igb_adapter *adapter)
 	}
 }
 
+void igb_txrx_ring_disable(struct igb_adapter *adapter, u16 qid)
+{
+	struct e1000_hw *hw = &adapter->hw;
+	struct igb_ring *tx_ring = adapter->tx_ring[qid];
+	struct igb_ring *rx_ring = adapter->rx_ring[qid];
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
+void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid)
+{
+	struct igb_ring *tx_ring = adapter->tx_ring[qid];
+	struct igb_ring *rx_ring = adapter->rx_ring[qid];
+
+	/* Rx/Tx share the same napi context. */
+	napi_enable(&rx_ring->q_vector->napi);
+
+	igb_configure_tx_ring(adapter, tx_ring);
+	igb_configure_rx_ring(adapter, rx_ring);
+
+	/* call igb_desc_unused which always leaves
+	 * at least 1 descriptor unused to make sure
+	 * next_to_use != next_to_clean
+	 */
+	igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
+
+	clear_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
+}
+
 /**
  *  igb_free_tx_resources - Free Tx Resources per Queue
  *  @tx_ring: Tx descriptor ring for a specific queue
-- 
2.34.1


