Return-Path: <bpf+bounces-16012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0C57FAE7C
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 00:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA74AB21278
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 23:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A8049F6F;
	Mon, 27 Nov 2023 23:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuudT2jW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275F546455;
	Mon, 27 Nov 2023 23:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136F8C433C9;
	Mon, 27 Nov 2023 23:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701128336;
	bh=OP9pFvTtBocrekjm3I1I/EiiFMe+iBP2KL9HIYzUNSI=;
	h=From:To:Cc:Subject:Date:From;
	b=cuudT2jWSs91YKbtzL/2EpIMFsjFm/LslPE/gq2jjnZfheBO3ufnWdzA+/XTlJahz
	 xQAOitOW+WtCT6DMYGVD1UYF+9T1+rMWyyscLEC5aFLw+2rnyDRDQeiQYzEJ149dkC
	 gMoN8VepkUGmdW0trAfsy5Rg/7wpMkI+YeVdpLnEnGfs9dJ4uoAvRVsB0vrLvtCy1z
	 It3u3CfqUVWuHSCGS0wZd45K8KgL9h2IohXblEkOt5sc3720kupblryU1aJ2hqvr9V
	 u5wLPLWXAVLcJq8cL/UdvLRBF0W1R4Yr/M4WVubHYKFdX9K84WGRrGT7XGb5fBplw+
	 /oJuu9SKdS46g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lorenzo.bianconi@redhat.com,
	bpf@vger.kernel.org,
	hawk@kernel.org,
	toke@redhat.com
Subject: [PATCH net-next] xdp: add multi-buff support for xdp running in generic mode
Date: Tue, 28 Nov 2023 00:38:32 +0100
Message-ID: <c928f7c698de070b33d38f230081fd4f993f2567.1701128026.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to native xdp, do not always linearize the skb in
netif_receive_generic_xdp routine but create a non-linear xdp_buff to be
processed by the eBPF program. This allow to add multi-buffer support
for xdp running in generic mode.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/core/dev.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 3950ced396b5..5a58f3e28657 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4853,6 +4853,12 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	xdp_init_buff(xdp, frame_sz, &rxqueue->xdp_rxq);
 	xdp_prepare_buff(xdp, hard_start, skb_headroom(skb) - mac_len,
 			 skb_headlen(skb) + mac_len, true);
+	if (skb_is_nonlinear(skb)) {
+		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
+		xdp_buff_set_frags_flag(xdp);
+	} else {
+		xdp_buff_clear_frags_flag(xdp);
+	}
 
 	orig_data_end = xdp->data_end;
 	orig_data = xdp->data;
@@ -4882,6 +4888,14 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 		skb->len += off; /* positive on grow, negative on shrink */
 	}
 
+	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
+	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
+	 */
+	if (xdp_buff_has_frags(xdp))
+		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
+	else
+		skb->data_len = 0;
+
 	/* check if XDP changed eth hdr such SKB needs update */
 	eth = (struct ethhdr *)xdp->data;
 	if ((orig_eth_type != eth->h_proto) ||
@@ -4927,9 +4941,9 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
 	if (skb_is_redirected(skb))
 		return XDP_PASS;
 
-	/* XDP packets must be linear and must have sufficient headroom
-	 * of XDP_PACKET_HEADROOM bytes. This is the guarantee that also
-	 * native XDP provides, thus we need to do it here as well.
+	/* XDP packets must have sufficient headroom of XDP_PACKET_HEADROOM
+	 * bytes. This is the guarantee that also native XDP provides,
+	 * thus we need to do it here as well.
 	 */
 	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
 	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
@@ -4943,8 +4957,12 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
 				     hroom > 0 ? ALIGN(hroom, NET_SKB_PAD) : 0,
 				     troom > 0 ? troom + 128 : 0, GFP_ATOMIC))
 			goto do_drop;
-		if (skb_linearize(skb))
-			goto do_drop;
+
+		/* XDP does not support fraglist */
+		if (skb_has_frag_list(skb) || !xdp_prog->aux->xdp_has_frags) {
+			if (skb_linearize(skb))
+				goto do_drop;
+		}
 	}
 
 	act = bpf_prog_run_generic_xdp(skb, xdp, xdp_prog);
-- 
2.43.0


