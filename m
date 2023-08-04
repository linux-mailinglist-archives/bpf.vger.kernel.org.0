Return-Path: <bpf+bounces-6963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5988176FC2E
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 10:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1951C217A7
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 08:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE5F9467;
	Fri,  4 Aug 2023 08:41:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E028D9453;
	Fri,  4 Aug 2023 08:41:19 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2098.outbound.protection.outlook.com [40.107.22.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1671C30EA;
	Fri,  4 Aug 2023 01:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoui5fKjpRCJrXkQYYQIvJkWeRgtfDiQTo1Ra2YsC/rkOrmUIBy6gWNkZ1/3J+1YdjX2Zf3N2ol4WhIsF7aeFHWAUPXkxEeu4selzarOcPuTXFi0oxzASym0qHf8QSLlLf1derj3eGwn6q39VcgcgTtikCHmUCVrusyPv4WTfdkNiRijg1Py7ooo2f6YT9SWzMoiU4qeduR+IIKpMfGBMc1seVWbFqryRl8xjPNrB99t4xjErpsKB8BjWbX0WopqDY3OESxT5+WIkXdksbtr9HDuALlY04mPjX5Oc3RAyuYLjewIrHMFWGzjcy2bxpNJF/rNjXyTtjzTb2doYKbJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3GIAfDJcM4NKZSpm5MHxiQ/8+BYY0pRKLseuA30vMs=;
 b=Uy26tUo2jxuPgi3D+B+PLDgPSiRKP9tpOZiowb+Q0n6o46YWgR3WoVFL6d8RuN9st6kBi6eSAA5exGKENFaadktZJabNc2lsXOgXkJQtdbMWysJGG1qn7tbshs78Hc5MiS0eu2mKoGmN77NEea5Sj7/ubtWz+BBvMESwfesMgBmlAZJycEMp95uBFaUfGGldOROIEqL8dUmlJlM/Lv9xeY+K+YDwTbr+ZV6E2AbGTLp4ZG/lXzz8uU/8Lt5+KMbDM26ykAkHs19xRYze4shg/lLPcfmrIclFH6Wqg8I69HxgA+NTxcoch1zww0kGgbJEqjFccU883yJ1dNKZMkpD5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3GIAfDJcM4NKZSpm5MHxiQ/8+BYY0pRKLseuA30vMs=;
 b=AkAGPzmtLConqBUBYDUMH6KL0vqSUxa6OqSeRMwH+nqvBaXIEGOfR1uxaJMNl9vkZMdbY714EfriwF7bE88bn7CdRLegB0UrFitMo+2wWok8U4W9zinfCHfz4pNNhKh6E6OA51JVxOKPR/G5eG7Ilb38/mNG5D/ejw5kg1VAVno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by AS1P189MB1861.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:48c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 08:41:13 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6609.032; Fri, 4 Aug 2023
 08:41:13 +0000
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
Subject: [PATCH iwl-next v4 1/4] igb: prepare for AF_XDP zero-copy support
Date: Fri,  4 Aug 2023 10:40:48 +0200
Message-Id: <20230804084051.14194-2-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804084051.14194-1-sriram.yagnaraman@est.tech>
References: <20230804084051.14194-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF000000CF.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:2:0:8) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|AS1P189MB1861:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f5667e-f8c5-40cf-494f-08db94c68f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g/dCnbV7UM5XomEba3C1id4BhDT3nKbWSK0CQNGGA9BgRMStDWJO5m6r4O0BBy5ONs2RVm2t/FBQ2YUJzgDjY4LkL1BE7PwBj7AXIofsm284+WbNiN1dEcR5NAQqu9EBejwNL8WUjEcBggeRZXmonF8EPLmI5u7har2BYaFeZtmwSpMVqkSCQpYyn3cazkszw6XuL+mPxJ7vo5GRoTL4LQJcZ9+5wQHmTGX63xvUW4jzuZKINXYMRxqHTgQcH69B5VIKCB2DDhFc+ixM5Asrqxs6RnmyLC8OE/YWJCglLrjeSYj9ZBwv5ZAZejeEyBhL3wM7ONvieWXPHiU4CKHrJLpKxN6AoDG0VBP+fS6BguvnIkzY/03R0uB3vWEgilIxTthREC7sVCp+4VuYMoliaMK5CPjwfIWVZ0cQWadxM7HOcN/2m9GUaySbdIT+ALcLaoWa/1cp8Er4RLo3GSrb5ssVjX6IdOifUcI7Ffu8chv/9IV7pH4rdGouJHgwfFcg33oQGQjaNf2onb4Lvtrk7OAJFXq8peqH3XuhhlNM+FppQEersIa5bLuE9OIE5f6l7+l29XaTuwpWhbIiRjO2qCxHEgIIZnmuhpDODOzxa9eDHp06BUBXN8q8yBVSBwyxuGn0rQ+1UXPWHYZPtljqxBOvcujoqwdY18iSprrytkQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(136003)(346002)(396003)(376002)(451199021)(109986019)(1800799003)(186006)(83380400001)(2616005)(316002)(66556008)(66476007)(70586007)(66946007)(4326008)(41300700001)(38100700002)(6506007)(44832011)(26005)(8676002)(8936002)(1076003)(7416002)(5660300002)(6666004)(6486002)(6512007)(478600001)(86362001)(54906003)(36756003)(2906002)(266003)(37730700002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SFkR2Xy4bJSvfzGoq2Ft24iyo7HwVP+rvexon75arMquLNO3wX0ybSfwPtpG?=
 =?us-ascii?Q?TyGh0XLMVuQJzdl+gloS2C8fQUJJnimyW+aj+KD2Qced46oNXxNPXU15wWfZ?=
 =?us-ascii?Q?Byqcl7jBQwLM2Uk93pUZ3YGlku3zTb7+gdHOhGx1cXTKpTCq2v/KucJfcaPE?=
 =?us-ascii?Q?f2GseNtMCE0BUzXLF2ln3DUPbyYrwQwWSaFUg/tGZ1k4kMtjzfNeGOnfefrY?=
 =?us-ascii?Q?VflS5HUHpi1hvjGrXOxOXgyasLcEtzhXaXlRB5edHe3A5ReyCOGC4wO/NdBy?=
 =?us-ascii?Q?tC+TkK7/iyO/G4xtL9KKPmHlDSw7or+0ts4DAmbMmPbfEiLo/h05o3dQwdGg?=
 =?us-ascii?Q?WEpd7EQnOLlibyEEtVTRA+b4IaYGP2T7fF7wlIVjGUKhyvLwheSHwOUtgYRv?=
 =?us-ascii?Q?mHQ+LNb+YMTb4tOQiC3yOVz4+VHJjrHL1RLqdyFr0g+56SEBYUUoFDM3N9kt?=
 =?us-ascii?Q?kMMoP/lWu//K6xGvQamdF12hgCFzASQb2Z6ziVQDJyBTyjpN6xJsmwB/kW6R?=
 =?us-ascii?Q?8U1kejkVbttBhteZwQxa34CahuxGoU9OTf18uHsNBSokVBucKQRfm2p3gc+0?=
 =?us-ascii?Q?MFqnw6xplL8qF+9TYswQOE3YTfXX18t3Kd8z0h0M5TpVDtzFfF4cBrbkJLw+?=
 =?us-ascii?Q?mKnx264th/5OJhR43wyDPI9nFkAF0JkVMciySl6oxB/ts78FJ25/2wLiPNAl?=
 =?us-ascii?Q?uG6jxsC7xE9H7EAYxaCWCI539jvTGTeZ/HSX0V889fVeLJW4MJb49VeoyZsf?=
 =?us-ascii?Q?ZzdUuLuN1w15J2JDk8rThBNaRZvxnK69Ooimd5f4Uk5cMvjPgDTFHI+oEKHJ?=
 =?us-ascii?Q?Egog/jlHt7plHue8RXt73G93IwLNftEucF6HOyeORMU0bny4BJcrNfF8kWal?=
 =?us-ascii?Q?aEmv4ZzXsaJKFLDxBn6JItanyR6JWfTGOy8FhBEH/yI9LIYTBi60lmqQATQi?=
 =?us-ascii?Q?9LAe5t8HlT3v+5u0TXVT+osXKh/+LC5YkcsKknhCKLUm1rZjm0AFkzEJAVum?=
 =?us-ascii?Q?3pHksOYV+tDPtm92hcZz7pcV4LKBJ0bz8vgRV9SYizzN/mR7H155ge7R5LWQ?=
 =?us-ascii?Q?7rwgzKP7cf6hq6SpZbDf4gVjD0iflBBhGIcThiX1p7KF9PuGiewJ6pLfGnAI?=
 =?us-ascii?Q?NU0ogPpGrlYITfrbpLfVugvjaTB5pr1KaJLCnZB+jybNxCq7sbu/8DU2vjD4?=
 =?us-ascii?Q?GYF8a0LUX5IYWMuFmJd+ixJRdrjEhGcrPse0AcahVc+Kn5NP/qwo8KAaBu3U?=
 =?us-ascii?Q?IQRmCC+otpHfR6CtrHlLm+7zn6VrVpu0h1PSDfjJixqXGgQ+3QQvHJYKrz6S?=
 =?us-ascii?Q?Mq4AxO5lGewh8n3cT+s6uqY/9LWo0SyOXqf5cj2zFymZS8GUaUeZb2XJ6lJt?=
 =?us-ascii?Q?qMOjaMGcCUigT35rRyBD5y1/JU4JNPz3P3yEQkT9Je4UQ++i5S5voKufD+II?=
 =?us-ascii?Q?jmV+0PH610LMTZ0mvOJHJ0Zm7z3inBi022HdUIIQuA9EpQxd30YFicrb52D+?=
 =?us-ascii?Q?euDNCqPgBQ5u5nf1GyzWwH0qFYDda+vJ4hMZjeVDg+gAIXBEK5uuSyrK1V2m?=
 =?us-ascii?Q?QY1q3AY4RntgY81PhYvJHv0U/4ijItfLLWWzYUXKr5K2hehSJNEcSYK/b6uT?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f5667e-f8c5-40cf-494f-08db94c68f04
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 08:41:12.9995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WaIstCOki8fOotXe8MKAxRyuTGiDY7SYIHFvP8HvrjaROrmseAHuIowpBfOy2cpMO9RJpBO+sXLL7yEbp8gIyv3lXpHshTaNhKjHARTYDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P189MB1861
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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


