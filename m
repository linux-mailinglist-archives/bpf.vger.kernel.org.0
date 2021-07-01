Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872403B8B45
	for <lists+bpf@lfdr.de>; Thu,  1 Jul 2021 02:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbhGAAca (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Jun 2021 20:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236734AbhGAAc3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Jun 2021 20:32:29 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CEFC061756;
        Wed, 30 Jun 2021 17:30:00 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h4so4420321pgp.5;
        Wed, 30 Jun 2021 17:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pu6s/bZWRTuBtOPeO5jualkpubf/IINLtS9eFBKRQso=;
        b=PdX6RKKOGJrv6kvWCgF9zQlBNmqZRxLH9LK5yDqb1OWn6hpBjqRK21ap8ELgA1AqwQ
         oetj7LRrHJBZTi4smNBb4zfWcCrRT5/uCy7+Gm2b3sN1lNNRFqNla19dpeGdVnuQ4BLY
         S8ZnF9Iw7JWTtCCWi2qet68vqeQvz4Ry7xdP6aEAfNF22cygjuXKorxzPjAYP5fFvora
         gqh5TrOXAdWlEdh915zL7RC7TOkgWwHac/a088cAI684r4bny/8fkf8mbHIyX344W7kL
         AM3b0ejxk3Fj4XN9DQ/nllu6sNDq5FVbTdGBGL/1o/N7qTwH4gHf0wtoi+r49zstmwie
         1MSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pu6s/bZWRTuBtOPeO5jualkpubf/IINLtS9eFBKRQso=;
        b=BiG6aEcutbskRBtSc47gn6noYMSh3hG48THXMsdL/pXxImbuuS0VrDyvvfIij60TD9
         zpdCHy1GQjLhUYdZPsDGORYPtl3MLt/g8ntLoew+rny6Znr8wGHq8KKnn5PbmBaH5mt8
         VoG8kQ3qJmthlRwqsIAQtd4F9wL2rxYuH5TE1tEnf9x+jeI6dELLKDUrZDjTDZY33Bs4
         gA0Q18lq5QbCex8W7uWCsvNn6Z8dybOjsL5SqTizMYtYtv8JikSQKfSJ+Sx/XMgEtKUg
         nxv6UfxbdOxgTgGyILe5RF9Abb7FiLEpdfsL3VbqCn9GSgANDQq/WUVoNg7jjO/O14ct
         oZnQ==
X-Gm-Message-State: AOAM5339Z5vzncKrcHxGN2zXQzJRW8RngFEBOlbwei2ZtZvISCHEjVnk
        RWupWAeO/zDv2w4mCbE5R1gqYgNPH/4=
X-Google-Smtp-Source: ABdhPJxP19XIUIx80Qil3bc2zMDihIP4g2SCxld7uNKjcjzjRZT1Yx3xh5Y3wXlYWRFRW7ttOtV07Q==
X-Received: by 2002:aa7:989c:0:b029:30a:13ef:2bbd with SMTP id r28-20020aa7989c0000b029030a13ef2bbdmr28175685pfl.20.1625099399870;
        Wed, 30 Jun 2021 17:29:59 -0700 (PDT)
Received: from localhost ([2402:3a80:11db:6f6:e6a8:37a6:1da7:fbc7])
        by smtp.gmail.com with ESMTPSA id k35sm24545840pgi.21.2021.06.30.17.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 17:29:59 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org
Subject: [PATCH net-next v5 1/5] net: core: split out code to run generic XDP prog
Date:   Thu,  1 Jul 2021 05:57:55 +0530
Message-Id: <20210701002759.381983-2-memxor@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210701002759.381983-1-memxor@gmail.com>
References: <20210701002759.381983-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This helper can later be utilized in code that runs cpumap and devmap
programs in generic redirect mode and adjust skb based on changes made
to xdp_buff.

When returning XDP_REDIRECT/XDP_TX, it invokes __skb_push, so whenever a
generic redirect path invokes devmap/cpumap prog if set, it must
__skb_pull again as we expect mac header to be pulled.

It also drops the skb_reset_mac_len call after do_xdp_generic, as the
mac_header and network_header are advanced by the same offset, so the
difference (mac_len) remains constant.

Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/netdevice.h |  2 +
 net/core/dev.c            | 84 ++++++++++++++++++++++++---------------
 2 files changed, 55 insertions(+), 31 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index be1dcceda5e4..90472ea70db2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3984,6 +3984,8 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
 	__dev_kfree_skb_any(skb, SKB_REASON_CONSUMED);
 }
 
+u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
+			     struct bpf_prog *xdp_prog);
 void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog);
 int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb);
 int netif_rx(struct sk_buff *skb);
diff --git a/net/core/dev.c b/net/core/dev.c
index 991d09b67bd9..ad5ab33cbd39 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4740,45 +4740,18 @@ static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
 	return rxqueue;
 }
 
-static u32 netif_receive_generic_xdp(struct sk_buff *skb,
-				     struct xdp_buff *xdp,
-				     struct bpf_prog *xdp_prog)
+u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
+			     struct bpf_prog *xdp_prog)
 {
 	void *orig_data, *orig_data_end, *hard_start;
 	struct netdev_rx_queue *rxqueue;
-	u32 metalen, act = XDP_DROP;
 	bool orig_bcast, orig_host;
 	u32 mac_len, frame_sz;
 	__be16 orig_eth_type;
 	struct ethhdr *eth;
+	u32 metalen, act;
 	int off;
 
-	/* Reinjected packets coming from act_mirred or similar should
-	 * not get XDP generic processing.
-	 */
-	if (skb_is_redirected(skb))
-		return XDP_PASS;
-
-	/* XDP packets must be linear and must have sufficient headroom
-	 * of XDP_PACKET_HEADROOM bytes. This is the guarantee that also
-	 * native XDP provides, thus we need to do it here as well.
-	 */
-	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
-	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
-		int hroom = XDP_PACKET_HEADROOM - skb_headroom(skb);
-		int troom = skb->tail + skb->data_len - skb->end;
-
-		/* In case we have to go down the path and also linearize,
-		 * then lets do the pskb_expand_head() work just once here.
-		 */
-		if (pskb_expand_head(skb,
-				     hroom > 0 ? ALIGN(hroom, NET_SKB_PAD) : 0,
-				     troom > 0 ? troom + 128 : 0, GFP_ATOMIC))
-			goto do_drop;
-		if (skb_linearize(skb))
-			goto do_drop;
-	}
-
 	/* The XDP program wants to see the packet starting at the MAC
 	 * header.
 	 */
@@ -4833,6 +4806,13 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
 		skb->protocol = eth_type_trans(skb, skb->dev);
 	}
 
+	/* Redirect/Tx gives L2 packet, code that will reuse skb must __skb_pull
+	 * before calling us again on redirect path. We do not call do_redirect
+	 * as we leave that up to the caller.
+	 *
+	 * Caller is responsible for managing lifetime of skb (i.e. calling
+	 * kfree_skb in response to actions it cannot handle/XDP_DROP).
+	 */
 	switch (act) {
 	case XDP_REDIRECT:
 	case XDP_TX:
@@ -4843,6 +4823,49 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
 		if (metalen)
 			skb_metadata_set(skb, metalen);
 		break;
+	}
+
+	return act;
+}
+
+static u32 netif_receive_generic_xdp(struct sk_buff *skb,
+				     struct xdp_buff *xdp,
+				     struct bpf_prog *xdp_prog)
+{
+	u32 act = XDP_DROP;
+
+	/* Reinjected packets coming from act_mirred or similar should
+	 * not get XDP generic processing.
+	 */
+	if (skb_is_redirected(skb))
+		return XDP_PASS;
+
+	/* XDP packets must be linear and must have sufficient headroom
+	 * of XDP_PACKET_HEADROOM bytes. This is the guarantee that also
+	 * native XDP provides, thus we need to do it here as well.
+	 */
+	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
+	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
+		int hroom = XDP_PACKET_HEADROOM - skb_headroom(skb);
+		int troom = skb->tail + skb->data_len - skb->end;
+
+		/* In case we have to go down the path and also linearize,
+		 * then lets do the pskb_expand_head() work just once here.
+		 */
+		if (pskb_expand_head(skb,
+				     hroom > 0 ? ALIGN(hroom, NET_SKB_PAD) : 0,
+				     troom > 0 ? troom + 128 : 0, GFP_ATOMIC))
+			goto do_drop;
+		if (skb_linearize(skb))
+			goto do_drop;
+	}
+
+	act = bpf_prog_run_generic_xdp(skb, xdp, xdp_prog);
+	switch (act) {
+	case XDP_REDIRECT:
+	case XDP_TX:
+	case XDP_PASS:
+		break;
 	default:
 		bpf_warn_invalid_xdp_action(act);
 		fallthrough;
@@ -5308,7 +5331,6 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 			ret = NET_RX_DROP;
 			goto out;
 		}
-		skb_reset_mac_len(skb);
 	}
 
 	if (eth_type_vlan(skb->protocol)) {
-- 
2.31.1

