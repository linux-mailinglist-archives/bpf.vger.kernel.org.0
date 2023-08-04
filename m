Return-Path: <bpf+bounces-6966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8836076FC36
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 10:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69EF51C2172D
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 08:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A8BA954;
	Fri,  4 Aug 2023 08:41:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2355AA928;
	Fri,  4 Aug 2023 08:41:24 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2134.outbound.protection.outlook.com [40.107.14.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F9D30EA;
	Fri,  4 Aug 2023 01:41:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGht4VM2C95AE1dpqYU6KxUYSt81/gHi65azZq5hoL8Mp6o2xA4NZVy5ZEoKVIIL2Uv+AVAAP36kZ5mMf73d/r9kkspF33kzaJwMC/Hsxwkf6v6RhYF8v2iiCGKMWP4HMY4ocXka27uXLFqm7oVXHrLeO8SRU6ZFEHH344d/XPs1Q4tr/a3w+H/GE4H/Z7KaTZESTD1KghbgQGx2tHrJXCN+2i3YjMzDkXKN4xf7XrnwnLpNGuvKSoBtiq/cMLMnWMUIEk4ITqo32NSo0YZ/FPgjKdsmVP/4Krsr4HjL/LKtuPb5Hh4wPNMfJWytSayNwMBxCBl6PtIFAXT6SJObZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaEbAZIFxK95/V2PAoipCmnKr3ze+ASqw9v6lWyB8as=;
 b=f8BiMXastAce1WVumo4dyA8fSkYn4U8+txdCt7tSp/Dtrp127Iu63KXG7xM6tBaSMbFqS47+wKT+CChK2U59hxYv2emuX/mmrCzOu6dg3GIfcw59Ys4dRVem/eZRehH/nGINzMDYpB/Y96dzYsReCIqbvqlkct0Uwblfw/lA01wEdlgLBU+nwgrmuPk7vFBKxqJKmbBCaieXk8A3E4HreL0iaW8kmUw1kMR5AYJW1AdLVHvbmTF/ebSMNRXgGxw9FgxIsON1EhZ6cDkrP0BtZ6OFTyOBa6/GRLukZjH9LtQ9yL+dLG9pPEg/I5Iz0KSur6TjHu/CZDQp/H7a/t1tfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaEbAZIFxK95/V2PAoipCmnKr3ze+ASqw9v6lWyB8as=;
 b=eIAAtB4SfXBJlH/lI5qbDzj3MktsmCc7RBFDZe9djZOS1UIlImxHHtJpC0kiPczYjv/LBOzyZuEqI4zzkZm1Jyw2oiw56J9iG08ojk1WmUYr+0LDm4PUpQtQIufaXIn+JJWXeBtzQoitbm/fD4Ho+XKWX0sKLAvhn3ojWPBoCLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by VI1P18901MB0736.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:122::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 08:41:14 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6609.032; Fri, 4 Aug 2023
 08:41:14 +0000
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
Subject: [PATCH iwl-next v4 3/4] igb: add AF_XDP zero-copy Rx support
Date: Fri,  4 Aug 2023 10:40:50 +0200
Message-Id: <20230804084051.14194-4-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804084051.14194-1-sriram.yagnaraman@est.tech>
References: <20230804084051.14194-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF000000CE.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:2:0:5) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|VI1P18901MB0736:EE_
X-MS-Office365-Filtering-Correlation-Id: 6608d4a3-d7ab-4f2b-5b12-08db94c68fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2xabIAM2pTeMvfy1EVD4IEGgINB5WYB8XPp56NuJ15w1X3AY6shY/m0pc/FVWEo5NFL0CcEHxTEOEvMzj9A6zrfqtrubXFygOabxKsS2wZ6SK3NbaY79kaYVlSm2QYZ6/Io1qvSbZv8Wo9l2hfGDygN/4fab22Oj92EHoJpksz/rprK1ksX7yWLxa/ae8OTZaKzLgWbmGFzcL5JcnEFHg1EPSgEs4tUVdaOpWwhtSR7eF4SaYNDpT1z7o1Lgpbg3ATbz21htcG+iurk6bDiEKND4QHVce4SC/tG5ZFaw1uS3akG3LMcHr+5/Sj+g45jwB1ONITG9aIWeGFj3R6+/HX8A38D9qokg/UAf/hyPNT8JPmrs8878tGeSpsMVCiSIPEK+sTnwlINJrdXFHR3NOVijxt6xEDMwlFu1cAq9Q2XcGZgGlV0RXmYS0IK900WRbBESdbmfkRmahniWSucoB037swYwLygq3dQbun8HmcbX1kFlCy+8aGPpNqSDYn0SZlbcYb5DB9VQ9DCIWKJEuq/o0/ZsgKoQggPqCAxqX2TfwwmI6yHQqM8iNNC4IfNUzm3BnM43Dex/c5VYZWiIwGkK+6H4SgZycjacoD+IlQZw8wlTgFboloMy65yzfgmpoE3jIJCfHyfz/Bd/OY8t2Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(39830400003)(346002)(451199021)(109986019)(1800799003)(186006)(6506007)(1076003)(26005)(38100700002)(2616005)(83380400001)(36756003)(2906002)(5660300002)(7416002)(30864003)(44832011)(8676002)(478600001)(54906003)(86362001)(6512007)(6666004)(6486002)(41300700001)(316002)(8936002)(4326008)(66556008)(66476007)(70586007)(66946007)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?asXoJiNmedMXlUKiA17Wj+JBf4+kznDkZu5OpELhyjWEfb5UFdIDvR/JN9+S?=
 =?us-ascii?Q?/fDGO02TAkjWQJcHE5AZNNpIy01FyEyinVFCa7nxOlrlF/mAkjzp+OEAHO0y?=
 =?us-ascii?Q?Y6kkkUzu111iR2jdb1Qc9lCEf7sJ9xG0NQ4abH/xDDqyaiJjkZ3+w5pkmMjO?=
 =?us-ascii?Q?Z93aTOl5IUZyRT3mRrd4x8+KXgvbQKHhAIuzT00ssi3TFK9JEthhnc05K9QE?=
 =?us-ascii?Q?141SeveO0xkS/swBtgUbByoPdnuFrJ+unVaooWBFHH2tc9nH+kaONRHVCUDG?=
 =?us-ascii?Q?aIbEMWz5gpuSIZWrEMzPycToEqN6VZ1ekHtKGarh7BIccWRLYIdouReADueh?=
 =?us-ascii?Q?uDosJWLgy6TQRdkLb3HdtTvKteMBltz35qeBz7tqlL1rV3cdrfkNssetMWAB?=
 =?us-ascii?Q?ZvXcWEN9BfZJ1mhmyQ5Pyq5eAzEEKtLLx76c2OWf1htc6J1Ryft5Pz6eHVBx?=
 =?us-ascii?Q?CS45/AqhMQHwUmdTxrMNorF/SetKrbD9iKcywctDkmscXojp7diezemQF8SX?=
 =?us-ascii?Q?cAYT7/NIGS1yK3u7kgQK6bbHC6DIBEXZ6ADG8XMyeC2/CG9e9+oW9zB/AV9U?=
 =?us-ascii?Q?qd5n3BL5hx6q2dP+LEensJpf4HXGYjYiYF7Ai3Oj2UMdZmrTkxquNgPNHIiS?=
 =?us-ascii?Q?aJz17aelkLNa+ULtIUfpQZnfdi69Skh6jlG5G1Gcv9T+ZZLwHSGCt+hOI083?=
 =?us-ascii?Q?jjds9T3JkfflMlmh4fm23dFNj6WVWFpFlxkIc7FyzINZ6Lm2tLWeGOE0ioCI?=
 =?us-ascii?Q?GDnJOQD96f7rUd3kFa9NUTxeZ5GUvR0s8tixQ0Ary8GyzNTl6cdAYoVN7K/D?=
 =?us-ascii?Q?zznyTddCbD7UrXBmUQ+b/tApEzxOimfncwMKsdkcSAotBGnrHjedtzJi5HQ7?=
 =?us-ascii?Q?rVLH+RH5VR5jNclDEM+RaWc6R6V3j18KkiUnLAQLTCq0trxXB6hUvchITklp?=
 =?us-ascii?Q?065qbErPdJh/HQCFYhYMTInpWGPoODuv0UxkgoZqvZOKWAqHAwXh2Lrm1tCn?=
 =?us-ascii?Q?LqwlgQI6KNVvS5/cGDB8cg4wbgH0LBbelk8EQXSfiwghPnWfddjO9DD3bPCz?=
 =?us-ascii?Q?e1QWYm7ulkA7ExrMbwAg58LWAq7rwT33G+KuNHV/5xZtmUh+vm36s1/ck+Ia?=
 =?us-ascii?Q?vO+kq/vIujBip3+FZzJG4OtV08miFXMjerqdpuKbUDqOVQc2g4Xwkw7uoR3+?=
 =?us-ascii?Q?NwXm8caXfbAaRHfxYJfyUdVJ2tX6ji7WReJspnUaWS4Du/TWqEOIVzkF9jh0?=
 =?us-ascii?Q?Y6SHcQSgsFuYCU/59ID7DtaMU30Nk+mTpZOJy3/TvDM2jw4Wwl2SkizHbGa+?=
 =?us-ascii?Q?jYyd+Fh4J6q7Uq7kiD5wgJD7oaXKhdxDUeATwg2mBydKEjhOKP9u2e4qvX0E?=
 =?us-ascii?Q?5s4zy076gcBqPr1pn9YX7Y7JTZz+ZU3hKVX4d+0NhtmZeMifgcr+/F9GPR2w?=
 =?us-ascii?Q?W0sTK0tWCxatgd/EDfAB/iGgweU42WtVPso8PII368A+rvf6z/LzyU63Ohx6?=
 =?us-ascii?Q?U3zNZlanNv2sAmjb5eODwXHS5zmbiYbyYjcc4HwEsruOshJ+expdGED8HjgH?=
 =?us-ascii?Q?jI/KXqrib/OnpJuomMn8dKtM/uzaHRiNTyJS7Qo6qYGM4raClxGtArplKmge?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 6608d4a3-d7ab-4f2b-5b12-08db94c68fe4
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 08:41:14.3138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Avv69/qCPSkkGWY7PYvhbHktZtNni4U/YIs1pcHrw8GUs9ZtYixp6uwDlbRLUBapgyCkLCzbVJZaLOaUe6ydYAXtxU1IJ8LB1sBqqsGI5LQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P18901MB0736
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for AF_XDP zero-copy receive path.

When AF_XDP zero-copy is enabled, the rx buffers are allocated from the
xsk buff pool using igb_alloc_rx_buffers_zc.

Use xsk_pool_get_rx_frame_size to set SRRCTL rx buf size when zero-copy
is enabled.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 drivers/net/ethernet/intel/igb/igb.h      |   4 +
 drivers/net/ethernet/intel/igb/igb_main.c |  92 ++++++--
 drivers/net/ethernet/intel/igb/igb_xsk.c  | 262 +++++++++++++++++++++-
 3 files changed, 336 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 1af1a0423fba..39202c40116a 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -87,6 +87,7 @@ struct igb_adapter;
 #define IGB_XDP_CONSUMED	BIT(0)
 #define IGB_XDP_TX		BIT(1)
 #define IGB_XDP_REDIR		BIT(2)
+#define IGB_XDP_EXIT		BIT(3)
 
 struct vf_data_storage {
 	unsigned char vf_mac_addresses[ETH_ALEN];
@@ -832,6 +833,9 @@ struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
 int igb_xsk_pool_setup(struct igb_adapter *adapter,
 		       struct xsk_buff_pool *pool,
 		       u16 qid);
+bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring, u16 count);
+void igb_clean_rx_ring_zc(struct igb_ring *rx_ring);
+int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector, const int budget);
 int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags);
 
 #endif /* _IGB_H_ */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 2c1e1d70bcf9..b13cc94ac178 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -502,12 +502,17 @@ static void igb_dump(struct igb_adapter *adapter)
 
 		for (i = 0; i < rx_ring->count; i++) {
 			const char *next_desc;
-			struct igb_rx_buffer *buffer_info;
-			buffer_info = &rx_ring->rx_buffer_info[i];
+			dma_addr_t dma = (dma_addr_t)NULL;
+			struct igb_rx_buffer *buffer_info = NULL;
 			rx_desc = IGB_RX_DESC(rx_ring, i);
 			u0 = (struct my_u0 *)rx_desc;
 			staterr = le32_to_cpu(rx_desc->wb.upper.status_error);
 
+			if (!rx_ring->xsk_pool) {
+				buffer_info = &rx_ring->rx_buffer_info[i];
+				dma = buffer_info->dma;
+			}
+
 			if (i == rx_ring->next_to_use)
 				next_desc = " NTU";
 			else if (i == rx_ring->next_to_clean)
@@ -527,11 +532,11 @@ static void igb_dump(struct igb_adapter *adapter)
 					"R  ", i,
 					le64_to_cpu(u0->a),
 					le64_to_cpu(u0->b),
-					(u64)buffer_info->dma,
+					(u64)dma,
 					next_desc);
 
 				if (netif_msg_pktdata(adapter) &&
-				    buffer_info->dma && buffer_info->page) {
+				    buffer_info && dma && buffer_info->page) {
 					print_hex_dump(KERN_INFO, "",
 					  DUMP_PREFIX_ADDRESS,
 					  16, 1,
@@ -2011,7 +2016,10 @@ static void igb_configure(struct igb_adapter *adapter)
 	 */
 	for (i = 0; i < adapter->num_rx_queues; i++) {
 		struct igb_ring *ring = adapter->rx_ring[i];
-		igb_alloc_rx_buffers(ring, igb_desc_unused(ring));
+		if (ring->xsk_pool)
+			igb_alloc_rx_buffers_zc(ring, igb_desc_unused(ring));
+		else
+			igb_alloc_rx_buffers(ring, igb_desc_unused(ring));
 	}
 }
 
@@ -3360,7 +3368,8 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
-	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
 	/* MTU range: 68 - 9216 */
 	netdev->min_mtu = ETH_MIN_MTU;
@@ -4740,12 +4749,17 @@ void igb_setup_srrctl(struct igb_adapter *adapter, struct igb_ring *ring)
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
@@ -4777,9 +4791,17 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
 	u32 rxdctl = 0;
 
 	xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
-	WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
-					   MEM_TYPE_PAGE_SHARED, NULL));
 	ring->xsk_pool = igb_xsk_pool(adapter, ring);
+	if (ring->xsk_pool) {
+		WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
+						   MEM_TYPE_XSK_BUFF_POOL,
+						   NULL));
+		xsk_pool_set_rxq_info(ring->xsk_pool, &ring->xdp_rxq);
+	} else {
+		WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
+						   MEM_TYPE_PAGE_SHARED,
+						   NULL));
+	}
 
 	/* disable the queue */
 	wr32(E1000_RXDCTL(reg_idx), 0);
@@ -4806,9 +4828,12 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
 	rxdctl |= IGB_RX_HTHRESH << 8;
 	rxdctl |= IGB_RX_WTHRESH << 16;
 
-	/* initialize rx_buffer_info */
-	memset(ring->rx_buffer_info, 0,
-	       sizeof(struct igb_rx_buffer) * ring->count);
+	if (ring->xsk_pool)
+		memset(ring->rx_buffer_info_zc, 0,
+		       sizeof(*ring->rx_buffer_info_zc) * ring->count);
+	else
+		memset(ring->rx_buffer_info, 0,
+		       sizeof(*ring->rx_buffer_info) * ring->count);
 
 	/* initialize Rx descriptor 0 */
 	rx_desc = IGB_RX_DESC(ring, 0);
@@ -4992,8 +5017,13 @@ void igb_free_rx_resources(struct igb_ring *rx_ring)
 
 	rx_ring->xdp_prog = NULL;
 	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
-	vfree(rx_ring->rx_buffer_info);
-	rx_ring->rx_buffer_info = NULL;
+	if (rx_ring->xsk_pool) {
+		vfree(rx_ring->rx_buffer_info_zc);
+		rx_ring->rx_buffer_info_zc = NULL;
+	} else {
+		vfree(rx_ring->rx_buffer_info);
+		rx_ring->rx_buffer_info = NULL;
+	}
 
 	/* if not set, then don't free */
 	if (!rx_ring->desc)
@@ -5031,6 +5061,11 @@ void igb_clean_rx_ring(struct igb_ring *rx_ring)
 	dev_kfree_skb(rx_ring->skb);
 	rx_ring->skb = NULL;
 
+	if (rx_ring->xsk_pool) {
+		igb_clean_rx_ring_zc(rx_ring);
+		goto skip_for_xsk;
+	}
+
 	/* Free all the Rx ring sk_buffs */
 	while (i != rx_ring->next_to_alloc) {
 		struct igb_rx_buffer *buffer_info = &rx_ring->rx_buffer_info[i];
@@ -5058,6 +5093,7 @@ void igb_clean_rx_ring(struct igb_ring *rx_ring)
 			i = 0;
 	}
 
+skip_for_xsk:
 	rx_ring->next_to_alloc = 0;
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
@@ -8226,7 +8262,9 @@ static int igb_poll(struct napi_struct *napi, int budget)
 		clean_complete = igb_clean_tx_irq(q_vector, budget);
 
 	if (q_vector->rx.ring) {
-		int cleaned = igb_clean_rx_irq(q_vector, budget);
+		int cleaned = q_vector->rx.ring->xsk_pool ?
+			igb_clean_rx_irq_zc(q_vector, budget) :
+			igb_clean_rx_irq(q_vector, budget);
 
 		work_done += cleaned;
 		if (cleaned >= budget)
@@ -8634,8 +8672,15 @@ struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
 		break;
 	case XDP_REDIRECT:
 		err = xdp_do_redirect(adapter->netdev, xdp, xdp_prog);
-		if (err)
+		if (err) {
+			if (rx_ring->xsk_pool &&
+			    xsk_uses_need_wakeup(rx_ring->xsk_pool) &&
+			    err == -ENOBUFS)
+				result = IGB_XDP_EXIT;
+			else
+				result = IGB_XDP_CONSUMED;
 			goto out_failure;
+		}
 		result = IGB_XDP_REDIR;
 		break;
 	default:
@@ -8892,12 +8937,14 @@ static void igb_put_rx_buffer(struct igb_ring *rx_ring,
 
 static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 {
+	unsigned int total_bytes = 0, total_packets = 0;
 	struct igb_adapter *adapter = q_vector->adapter;
 	struct igb_ring *rx_ring = q_vector->rx.ring;
-	struct sk_buff *skb = rx_ring->skb;
-	unsigned int total_bytes = 0, total_packets = 0;
 	u16 cleaned_count = igb_desc_unused(rx_ring);
+	struct sk_buff *skb = rx_ring->skb;
+	int cpu = smp_processor_id();
 	unsigned int xdp_xmit = 0;
+	struct netdev_queue *nq;
 	struct xdp_buff xdp;
 	u32 frame_sz = 0;
 	int rx_buf_pgcnt;
@@ -9025,7 +9072,10 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 	if (xdp_xmit & IGB_XDP_TX) {
 		struct igb_ring *tx_ring = igb_xdp_tx_queue_mapping(adapter);
 
+		nq = txring_txq(tx_ring);
+		__netif_tx_lock(nq, cpu);
 		igb_xdp_ring_update_tail(tx_ring);
+		__netif_tx_unlock(nq);
 	}
 
 	u64_stats_update_begin(&rx_ring->rx_syncp);
diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index 925bf97f7caa..5e0244772914 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -66,7 +66,10 @@ static void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid)
 	 * at least 1 descriptor unused to make sure
 	 * next_to_use != next_to_clean
 	 */
-	igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
+	if (rx_ring->xsk_pool)
+		igb_alloc_rx_buffers_zc(rx_ring, igb_desc_unused(rx_ring));
+	else
+		igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
 
 	/* Rx/Tx share the same napi context. */
 	napi_enable(&rx_ring->q_vector->napi);
@@ -172,6 +175,263 @@ int igb_xsk_pool_setup(struct igb_adapter *adapter,
 		igb_xsk_pool_disable(adapter, qid);
 }
 
+static u16 igb_fill_rx_descs(struct xsk_buff_pool *pool, struct xdp_buff **xdp,
+			     union e1000_adv_rx_desc *rx_desc, u16 count)
+{
+	dma_addr_t dma;
+	u16 buffs;
+	int i;
+
+	/* nothing to do */
+	if (!count)
+		return 0;
+
+	buffs = xsk_buff_alloc_batch(pool, xdp, count);
+	for (i = 0; i < buffs; i++) {
+		dma = xsk_buff_xdp_get_dma(*xdp);
+		rx_desc->read.pkt_addr = cpu_to_le64(dma);
+		rx_desc->wb.upper.length = 0;
+
+		rx_desc++;
+		xdp++;
+	}
+
+	return buffs;
+}
+
+bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring, u16 count)
+{
+	u32 nb_buffs_extra = 0, nb_buffs = 0;
+	union e1000_adv_rx_desc *rx_desc;
+	u16 ntu = rx_ring->next_to_use;
+	u16 total_count = count;
+	struct xdp_buff **xdp;
+
+	rx_desc = IGB_RX_DESC(rx_ring, ntu);
+	xdp = &rx_ring->rx_buffer_info_zc[ntu];
+
+	if (ntu + count >= rx_ring->count) {
+		nb_buffs_extra = igb_fill_rx_descs(rx_ring->xsk_pool, xdp,
+						   rx_desc,
+						   rx_ring->count - ntu);
+		if (nb_buffs_extra != rx_ring->count - ntu) {
+			ntu += nb_buffs_extra;
+			goto exit;
+		}
+		rx_desc = IGB_RX_DESC(rx_ring, 0);
+		xdp = rx_ring->rx_buffer_info_zc;
+		ntu = 0;
+		count -= nb_buffs_extra;
+	}
+
+	nb_buffs = igb_fill_rx_descs(rx_ring->xsk_pool, xdp, rx_desc, count);
+	ntu += nb_buffs;
+	if (ntu == rx_ring->count)
+		ntu = 0;
+
+	/* clear the length for the next_to_use descriptor */
+	rx_desc = IGB_RX_DESC(rx_ring, ntu);
+	rx_desc->wb.upper.length = 0;
+
+exit:
+	if (rx_ring->next_to_use != ntu) {
+		rx_ring->next_to_use = ntu;
+
+		/* Force memory writes to complete before letting h/w
+		 * know there are new descriptors to fetch.  (Only
+		 * applicable for weak-ordered memory model archs,
+		 * such as IA-64).
+		 */
+		wmb();
+		writel(ntu, rx_ring->tail);
+	}
+
+	return total_count == (nb_buffs + nb_buffs_extra);
+}
+
+void igb_clean_rx_ring_zc(struct igb_ring *rx_ring)
+{
+	u16 ntc = rx_ring->next_to_clean;
+	u16 ntu = rx_ring->next_to_use;
+
+	while (ntc != ntu) {
+		struct xdp_buff *xdp = rx_ring->rx_buffer_info_zc[ntc];
+
+		xsk_buff_free(xdp);
+		ntc++;
+		if (ntc >= rx_ring->count)
+			ntc = 0;
+	}
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
+	unsigned int total_bytes = 0, total_packets = 0;
+	struct igb_ring *rx_ring = q_vector->rx.ring;
+	int cpu = smp_processor_id();
+	unsigned int xdp_xmit = 0;
+	struct netdev_queue *nq;
+	bool failure = false;
+	u16 entries_to_alloc;
+	struct sk_buff *skb;
+
+	while (likely(total_packets < budget)) {
+		union e1000_adv_rx_desc *rx_desc;
+		struct xdp_buff *xdp;
+		ktime_t timestamp = 0;
+		unsigned int size;
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
+		xdp = rx_ring->rx_buffer_info_zc[rx_ring->next_to_clean];
+		xsk_buff_set_size(xdp, size);
+		xsk_buff_dma_sync_for_cpu(xdp, rx_ring->xsk_pool);
+
+		/* pull rx packet timestamp if available and valid */
+		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
+			int ts_hdr_len;
+
+			ts_hdr_len = igb_ptp_rx_pktstamp(rx_ring->q_vector,
+							 xdp->data,
+							 &timestamp);
+
+			xdp->data += ts_hdr_len;
+			xdp->data_meta += ts_hdr_len;
+			size -= ts_hdr_len;
+		}
+
+		skb = igb_run_xdp(adapter, rx_ring, xdp);
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
+				xsk_buff_free(xdp);
+			}
+
+			total_packets++;
+			total_bytes += size;
+
+			igb_update_ntc(rx_ring);
+			continue;
+		}
+
+		skb = igb_construct_skb_zc(rx_ring, xdp, timestamp);
+
+		/* exit if we failed to retrieve a buffer */
+		if (!skb) {
+			rx_ring->rx_stats.alloc_failed++;
+			break;
+		}
+
+		xsk_buff_free(xdp);
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
+	entries_to_alloc = igb_desc_unused(rx_ring);
+	if (entries_to_alloc >= IGB_RX_BUFFER_WRITE)
+		failure |= !igb_alloc_rx_buffers_zc(rx_ring, entries_to_alloc);
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
 int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
 {
 	struct igb_adapter *adapter = netdev_priv(dev);
-- 
2.34.1


