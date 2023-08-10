Return-Path: <bpf+bounces-7421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A37D777045
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 08:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F76281EC5
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 06:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0591C28;
	Thu, 10 Aug 2023 06:25:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A884C1100
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 06:25:16 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457A410F5
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 23:25:15 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RLxhd2HLcz1L9XK;
	Thu, 10 Aug 2023 14:24:01 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 14:25:12 +0800
From: Ziyang Xuan <william.xuanziyang@huawei.com>
To: <martin.lau@linux.dev>, <daniel@iogearbox.net>,
	<john.fastabend@gmail.com>, <ast@kernel.org>, <andrii@kernel.org>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH bpf-next 1/2] bpf: Update h_proto of ethhdr when the outer protocol changed
Date: Thu, 10 Aug 2023 14:25:01 +0800
Message-ID: <70fc4e7bf2c760b045898b3d004a0838902f7e08.1691639830.git.william.xuanziyang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691639830.git.william.xuanziyang@huawei.com>
References: <cover.1691639830.git.william.xuanziyang@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When use bpf_skb_adjust_room() to encapsulate or decapsulate packet,
and outer protocol changed, we can update h_proto of ethhdr directly.

Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
---
 net/core/filter.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index a094694899c9..0c156550c757 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3409,6 +3409,14 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
 					  BPF_ADJ_ROOM_ENCAP_L2_MASK) | \
 					 BPF_F_ADJ_ROOM_DECAP_L3_MASK)
 
+static inline void skb_update_protocol(struct sk_buff *skb, __be16 protocol)
+{
+	struct ethhdr *hdr = eth_hdr(skb);
+
+	hdr->h_proto = protocol;
+	skb->protocol = protocol;
+}
+
 static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 			    u64 flags)
 {
@@ -3491,13 +3499,13 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 			skb_set_transport_header(skb, mac_len + nh_len);
 		}
 
-		/* Match skb->protocol to new outer l3 protocol */
+		/* Match skb->protocol and ethhdr->h_proto to new outer l3 protocol */
 		if (skb->protocol == htons(ETH_P_IP) &&
 		    flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)
-			skb->protocol = htons(ETH_P_IPV6);
+			skb_update_protocol(skb, htons(ETH_P_IPV6));
 		else if (skb->protocol == htons(ETH_P_IPV6) &&
 			 flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4)
-			skb->protocol = htons(ETH_P_IP);
+			skb_update_protocol(skb, htons(ETH_P_IP));
 	}
 
 	if (skb_is_gso(skb)) {
@@ -3540,13 +3548,13 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 	if (unlikely(ret < 0))
 		return ret;
 
-	/* Match skb->protocol to new outer l3 protocol */
+	/* Match skb->protocol and ethhdr->h_proto to new outer l3 protocol */
 	if (skb->protocol == htons(ETH_P_IP) &&
 	    flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
-		skb->protocol = htons(ETH_P_IPV6);
+		skb_update_protocol(skb, htons(ETH_P_IPV6));
 	else if (skb->protocol == htons(ETH_P_IPV6) &&
 		 flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
-		skb->protocol = htons(ETH_P_IP);
+		skb_update_protocol(skb, htons(ETH_P_IP));
 
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
-- 
2.25.1


