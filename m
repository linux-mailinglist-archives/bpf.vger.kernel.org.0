Return-Path: <bpf+bounces-3959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D060B746E3C
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 12:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85EBB280F4E
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 10:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2D25673;
	Tue,  4 Jul 2023 10:04:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639D1566C;
	Tue,  4 Jul 2023 10:04:58 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2109.outbound.protection.outlook.com [40.107.6.109])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A0DE52;
	Tue,  4 Jul 2023 03:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0/jljdPyQZK4acWFKB2eKv7dhHT8A7wHDydEd5zRKLovVZHgQ3wU/tlI1GVGAxKOKGF2Ljji1MgwACj5enMKxNGOpeHyGYiIpjo9Nqdfr88QY1D+7gr6r33B5LQxZEjCssp9UGhFf7rFd+g2ic2vsGZd9MCJDkf1EKB3SHWpdoocTWWxKu9JNVbfHlezrASZ+zT1uIpXaiKNVAT1qTHm8iqwmvx70+qeIEXs/EDdBwBu2yOs+GRRPu5sfvTRc/pwZahYxvfIj1188rCrfN/8ofp6dL2euJZMgL2J1fwF8j0D5Zh2hrmlFyryQYHHyspIGpDCUj5EvHhsVrsHeU8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyccUYh2pEpQWEmch0Qj4pn+fn6yEzbnJjPn0aC669Q=;
 b=JcCJL3FUIdsByRdBTuxPdivdIPM6uDjHN8gJCgR/rdqcm7YNCzTxvwYrE9yI24wSgTts3FC0919/nrBpBc5bQ6O7z2GT927iT38MncYOk2b3ynZMq8owfJbocN0ARo3wgoZ7LaRlOxATXugNjvCyyrJsQr68Elyn3jpDXHY5WnxlV7zyge6TEVWaonX5ybXRhTFfyRoGlta15xiLGoTDGLoS3kREMjauxhdGiWdYvobF3ByMeko3SaqTjOCACDB9PG5HNWCpdr5F24sd/gNcm2acUJyKrue+8QyWTwN6S6XoE7o4LbDFjqXVoFt4BEA5rZYgB1puqQty3SHNlLCjUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyccUYh2pEpQWEmch0Qj4pn+fn6yEzbnJjPn0aC669Q=;
 b=bjKH72fMcCbUjTPixy8obj7lt+k9xaEDSHrJfasWdYPFwYvC9oV7kzfjdf9l5CHRF/1nlMRufnmk8BZlQYL1xdO+Crc0dyyV4b6jAdH+w/jaQEAQ8lHFke4O9SesS1geH90aVLfwfsc5UqX+7y4wsMswPDkMzKu3lRLsvGRUu8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by DB3P189MB2624.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:438::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 10:04:15 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6%4]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 10:04:14 +0000
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
Date: Tue,  4 Jul 2023 11:59:13 +0200
Message-Id: <20230704095915.9750-3-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704095915.9750-1-sriram.yagnaraman@est.tech>
References: <20230704095915.9750-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF000000D5.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:2:0:1e) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|DB3P189MB2624:EE_
X-MS-Office365-Filtering-Correlation-Id: b768c1ce-32a8-4e80-b3a3-08db7c7605ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UplPeRPknJnru7CfhLc+VJXr2gtqdnANp1XwaaBfI7prWplUuO9YHwwrs27r2rXaKyjPy1Tx62ZvRMh5M6uaMJHi8MWm3wgYb3DCUiyuHf0baX7VAZEl85DqBaDrIuM+/DUo5SqpURXRx8jPXz/uSl6BFkoIwfFDwErQUMfqzAZ9VC8+O2sM6FtV0vxLmTIL5bc6bumPMkFWA4v7EvGi6seN3EErZiFvivSqzKsknWT++se5w3aynm8MJZoxEXdgTbpYjmFExaVVL6rWiJmFvSIiB5V81CIA8btIMK1Aq62lQU1Cp9QZxYIscER6+l5ro4knpjWZbBg3hsomc7P+hVWwJGn0obsJTc9SsYl8fYbIFYTTW35eVRxhBOKOdov2TjuQo3/m2LoIKQRnuV6OgBbAFX2qeCgHZ2R+9RqAnZjHbfd/FHgY6JNcvixHN2piTz1pUNrUgSnp7qMEuSlwpJ8qbeOAXwuxcIpUnlzSNHPKGhX3h6d16Sk85Va41m7HsN3d2mtvk6HINYG7lkGzrR0cEkU/n8WZJ7t2etV/AUHyr4QcY3PBE7kagFDsn1MwJ8qr4iRkqqS3JAJznSFlaJef7PG09pFuI1iDhOxswKsKYo6++998pLe+43A9a2+TZ8MkXW1W0QmyHzqgmXW7wA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(39830400003)(346002)(376002)(136003)(109986019)(451199021)(54906003)(6512007)(26005)(44832011)(186003)(86362001)(8676002)(7416002)(2906002)(8936002)(36756003)(6486002)(5660300002)(41300700001)(478600001)(38100700002)(1076003)(6506007)(66556008)(4326008)(66946007)(66476007)(70586007)(2616005)(83380400001)(316002)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O5JoL16tYzx7zLNIk9ZuB3fJvr3j3rIT35lYmEfw30eajSztFvRL5MnuHywS?=
 =?us-ascii?Q?l5ghnexPbw37RGkwuu1rRbZxvNAuYaRp1mVQ4sH0al6JM81OuWGW5ywFIcVH?=
 =?us-ascii?Q?Aqvsb7kDEPGibdIQGWyw3dNYGCollHm1aVAvWfM3spaspek02s584VB22fpG?=
 =?us-ascii?Q?Q65smNENY4oBN0/akXFILFqkJWVAPoDuKG43S/G9Zm+DxFaGxjUGT66NnlFF?=
 =?us-ascii?Q?NUe52QrgZaOZ/5NK2yDMp0faX2JsU+6yTHW6R8X+yp6+KBmR+7gNUMZMSZOJ?=
 =?us-ascii?Q?ziAZX3WI/91PM/votCe4opBGNXX0RrzosyMWNXBx2/2QhVdqevkVnHAYGPml?=
 =?us-ascii?Q?7jU/HyWYKYnBXWp/k7fyX9+UJyxRd8NExeeuCsP8Iplw4aaFHsvib5rWcysw?=
 =?us-ascii?Q?GvFVzJAXQk2mhxgKfw0G/39oXpkR8QQYg+67aOhauRAesQGXfrc77zxpd+5C?=
 =?us-ascii?Q?n4eZrMZew/kIUB7/ydJPt0sdQXdEetbk5hquVGJCdf58aISwbKHQiMuUIo9X?=
 =?us-ascii?Q?GP9L6orKr6Ab+lHxotnwmCAeVzVsn/BY+4v/PUJhiaYEq8QTsSrZbGYxY8uM?=
 =?us-ascii?Q?RIqSn712859/2VJYbu2yKtHq7LhtQ4ZNr2FZnoLF+cppmr+YTOo90VjM5HjD?=
 =?us-ascii?Q?lOfJNWXJsNoQ8wbtw308n+BOGc7NZ4KsamOneZPDrEYtVPrRTN846cWpQIb1?=
 =?us-ascii?Q?9PdwpXGtbV1JK6UbY4jPM5kEmdIjJogss8OIXVGJRAQHu9VBxyyhsY14U/mH?=
 =?us-ascii?Q?r3aqGJm7ng0vd7UeGJOwtNOBHSBeBFAVSfbZa5NeGmpndyBLefpj01WxBCdz?=
 =?us-ascii?Q?uZkgxzSJ52DXCcRzb7jNLHiPFy5uUXLy4yjQ1eMbYLpOKtW7ltNIHMxw/Tos?=
 =?us-ascii?Q?IdpMMdxvu6pXJA6Ilqk4ndhglUfuHZXl3sMkwfqwrbcFxQG/80MoyGJrxGON?=
 =?us-ascii?Q?APIdEpt3VHARcuGhrT5XRNvvgAWd2VB9T7sgwLbF3viDPKbES4D1vToXN4jQ?=
 =?us-ascii?Q?J1qmXQFqlONtwymWMOt0FCkSQdPvrW3Z7sXFLUGG9oAawnMeCXpQBNeqtHIH?=
 =?us-ascii?Q?AxOfkhSg7EKYlGudx+bFfds+6QWj4lkNmTYzfnz9xPoOBT648rTKq4fCB1QJ?=
 =?us-ascii?Q?+6Drx/YrXh1X47vY0EluTkrDjadSB5E5/nL4Mx0S+KQoXgZ7F1vGHAHD4qOx?=
 =?us-ascii?Q?8BccXZJGXLud4DGVq5Pa+kYtlFKmylMAKATms/J0hqj7o6zG5fhPOLcPafKr?=
 =?us-ascii?Q?qIdj9xiskIh6MuO4QINhTMzGqBGLi1ElmNX+8wSA6ZlXleD6pPWeNvLuzY0j?=
 =?us-ascii?Q?SEL/vJK8UWaiVLPiDGRBJBTA7jvOpJSmWWputZw8Duum9jL4oAuwqSBPCJLx?=
 =?us-ascii?Q?QZc2QeFvjqf7duAY5huYELQnZJli6YTBtBDtx1NILwJeg0Z23pGYWCE025pr?=
 =?us-ascii?Q?MqLjx8s1vNPiA+rK9GyIre4GQqf1ZYSY5+Usy0K+tOEagXlE0u3CVWePhYfP?=
 =?us-ascii?Q?cKIXaGJtLmtm8cxYRVsPsd+bi3BMUV4w4w4bz7gL7s+cQ035b/Y1E/JgeAvq?=
 =?us-ascii?Q?9nsqHN3cRaaLTzFjfutJaNn/ZSqgD9x4t0I/acD32qxiYGAdSvLnhFBT5jwf?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: b768c1ce-32a8-4e80-b3a3-08db7c7605ac
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 10:04:14.7479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmUtjT7qPc8KEY3NYztXwNHmqrRANM94z/yyd4aIN43isbjwoCaZBQVChxHjtgdkCN9DU7HJNVYTYc1WGd3b0LsnJdVIqBX6fWFUR5NN4Qs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3P189MB2624
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
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


