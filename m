Return-Path: <bpf+bounces-70553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6188ABC2EF7
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 01:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2523C359F
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 23:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F015625F98A;
	Tue,  7 Oct 2025 23:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJn1hHYe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE9025B1D2;
	Tue,  7 Oct 2025 23:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759879627; cv=none; b=SNSVLPectg4QOJV0FvKFfJsNL27I6H1pQmqmJ3MI1IJ848nT/BCgdeBxNPJETWj+rq9537MGhJkJZr37nbRTsVl8t5OsMyUlKNhM/OYLH1Oj9pIwjdll5NtQxQeJzGb2IKz+9K1eCT9FrSe/IhQzlHvjwL2xBUC+cFz07uQh1/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759879627; c=relaxed/simple;
	bh=FZp/QJgmUeFs62yBV0C+XcnnFXtFRRU0YETbztvBe9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LL6v914lUNR77vFR0Z6kftmlt2V2Vg9cN/LDgreq+sh7WWIUBeVc/hUawpuRTwLT6Ry697ZrklzkvVG2TNhz6Sirf70ghyV9476URDza1kSkI0xq/+Skv3HkzIh5rx8IaCnv6zNuuem6c5zC217Ukn9r2OegBIWvesLAD/ARfhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJn1hHYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2129C4CEF7;
	Tue,  7 Oct 2025 23:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759879627;
	bh=FZp/QJgmUeFs62yBV0C+XcnnFXtFRRU0YETbztvBe9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BJn1hHYeHpTo/6JXCdasQJ3AnNRjFQh2ACMUIiu6zflai195N8D8SUggdt7AvRRIk
	 KTuH0jDJWpYgZ9589qz+KGddLyjjXk2DGEXKim79j8HXJJUuU6NiSm40xjI16ryxq9
	 +MIWBubl63pTmRrFZpj+tFpyuxcNuZgBGzppZQQT8n0YgWlNr1xoAMF/HTNhw4q/Du
	 1txFYFaJDP+l82LguiuLHZw62+9QWraOSU9yzsEXH4+ufan3nYeEAkQvVZlOoD8tU/
	 oW1cXQJafZ1FFfSBbpN6Ayk3CT+6Ilub9jeWGMc9Z1qVYroYEOoHtyVwruGYmxr7Aa
	 U/2hqMxV7iAew==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	alexanderduyck@fb.com,
	sdf@fomichev.me,
	mohsin.bashr@gmail.com
Subject: [PATCH net v2 2/9] eth: fbnic: fix accounting of XDP packets
Date: Tue,  7 Oct 2025 16:26:46 -0700
Message-ID: <20251007232653.2099376-3-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007232653.2099376-1-kuba@kernel.org>
References: <20251007232653.2099376-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make XDP-handled packets appear in the Rx stats. The driver has been
counting XDP_TX packets on the Tx ring, but there wasn't much accounting
on the Rx side (the Rx bytes appear to be incremented on XDP_TX but
XDP_DROP / XDP_ABORT are only counted as Rx drops).

Counting XDP_TX packets (not just bytes) in Rx stats looks like
a simple bug of omission.

The XDP_DROP handling appears to be intentional. Whether XDP_DROP
packets should be counted in interface-level Rx stats is a bit
unclear historically. When we were defining qstats, however,
we clarified based on operational experience that in this context:

  name: rx-packets
  doc: |
    Number of wire packets successfully received and passed to the stack.
    For drivers supporting XDP, XDP is considered the first layer
    of the stack, so packets consumed by XDP are still counted here.

fbnic does not obey this requirement. Since XDP support has been added
in current release cycle, instead of splitting interface and qstat
handling - make them both follow the qstat definition.

Another small tweak here is that we count bytes as received on the wire
rather than post-XDP bytes (xdp_get_buff_len() vs skb->len).

Reviewed-by: Simon Horman <horms@kernel.org>
Fixes: 5213ff086344 ("eth: fbnic: Collect packet statistics for XDP")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - remove now unnecessary adjustment to bytes

CC: alexanderduyck@fb.com
CC: sdf@fomichev.me
CC: mohsin.bashr@gmail.com
CC: bpf@vger.kernel.org
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 30 ++++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index cf773cc78e40..a56dc148f66d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1242,6 +1242,7 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 	/* Walk the completion queue collecting the heads reported by NIC */
 	while (likely(packets < budget)) {
 		struct sk_buff *skb = ERR_PTR(-EINVAL);
+		u32 pkt_bytes;
 		u64 rcd;
 
 		if ((*raw_rcd & cpu_to_le64(FBNIC_RCD_DONE)) == done)
@@ -1272,37 +1273,38 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 			/* We currently ignore the action table index */
 			break;
 		case FBNIC_RCD_TYPE_META:
-			if (unlikely(pkt->add_frag_failed))
-				skb = NULL;
-			else if (likely(!fbnic_rcd_metadata_err(rcd)))
+			if (likely(!fbnic_rcd_metadata_err(rcd) &&
+				   !pkt->add_frag_failed)) {
+				pkt_bytes = xdp_get_buff_len(&pkt->buff);
 				skb = fbnic_run_xdp(nv, pkt);
+			}
 
 			/* Populate skb and invalidate XDP */
 			if (!IS_ERR_OR_NULL(skb)) {
 				fbnic_populate_skb_fields(nv, rcd, skb, qt,
 							  &csum_complete,
 							  &csum_none);
-
-				packets++;
-				bytes += skb->len;
-
 				napi_gro_receive(&nv->napi, skb);
 			} else if (skb == ERR_PTR(-FBNIC_XDP_TX)) {
 				pkt_tail = nv->qt[0].sub1.tail;
-				bytes += xdp_get_buff_len(&pkt->buff);
+			} else if (PTR_ERR(skb) == -FBNIC_XDP_CONSUME) {
+				fbnic_put_pkt_buff(qt, pkt, 1);
 			} else {
-				if (!skb) {
+				if (!skb)
 					alloc_failed++;
-					dropped++;
-				} else if (skb == ERR_PTR(-FBNIC_XDP_LEN_ERR)) {
+
+				if (skb == ERR_PTR(-FBNIC_XDP_LEN_ERR))
 					length_errors++;
-				} else {
+				else
 					dropped++;
-				}
 
 				fbnic_put_pkt_buff(qt, pkt, 1);
+				goto next_dont_count;
 			}
 
+			packets++;
+			bytes += pkt_bytes;
+next_dont_count:
 			pkt->buff.data_hard_start = NULL;
 
 			break;
@@ -1319,8 +1321,6 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 	u64_stats_update_begin(&rcq->stats.syncp);
 	rcq->stats.packets += packets;
 	rcq->stats.bytes += bytes;
-	/* Re-add ethernet header length (removed in fbnic_build_skb) */
-	rcq->stats.bytes += ETH_HLEN * packets;
 	rcq->stats.dropped += dropped;
 	rcq->stats.rx.alloc_failed += alloc_failed;
 	rcq->stats.rx.csum_complete += csum_complete;
-- 
2.51.0


