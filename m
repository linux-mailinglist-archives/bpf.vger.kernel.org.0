Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84606618F02
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 04:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiKDD1c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 23:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiKDD0P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 23:26:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4105938F
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 20:25:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h9-20020a25e209000000b006cbc4084f2eso3831124ybe.23
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 20:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LmbtQXfRONLBh7ffBd4bAoho6T1l6iyjip9uOPJH4mk=;
        b=Lw1af5FpHUm//u0lneQQXILnQQOe094KHIbDHo04ndW9Wm0QYP/Utudp0RwLDKflC7
         mWVEfBsBrHd+y79qCH6wlEOcerziq4X7Ob1YOGYymJqg4jWPCRvjeIZgSdW5Rr6T3P1g
         Hj9KqnMx1aD7dTSZ3PelqdO/Sz+cjzUnoaQKT2be31CMSzLdlMEyj4fRiXVf+DIzJbMc
         MV8ydpUdA5p3hgcZgIR3sAX+f+h4CPdH0IQ4lrqXTS4rz50/YXzzpdROHsPSOl7sbqpO
         /niw+87K1NzYu5SNmxkGiY5RhsMl5WL3yE8gD5UWlVDSBhFd2pFraZUmfmSmkK6KVtW3
         DhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LmbtQXfRONLBh7ffBd4bAoho6T1l6iyjip9uOPJH4mk=;
        b=ZQsV/fu88n3dKcXTlOWiWCRZXDl0SKha0mGUbtE2La/y9IRPWYtX2ztHErY515BmP8
         TimwcKbOhL+RE6WWDPQVfXRaL8QOv441gcBCunYwclH8W6/oNeGYkXbRjh9b+X6eFMKA
         sl2dmUctIaozZc6E8/hi8cFHqxbB0wl9vEcF3EmFp/SYbFpyiLuKI8AkxcXB06D2et7U
         gmvDbi7FcCHMyka7+fLCz5KC+kOgfbvBc8qAP2Qt4vOee17WqSr4lSNaXVTgj7rxEX7X
         a3RZBeM6eqg81LcdlE4hGfYsC0QFqdih7PnQMyTlubT/pPvMPPNvGIxXmiDUPt3EpDDI
         dMNA==
X-Gm-Message-State: ACrzQf3lzrsdxsqDJ2OFLY4YujHxhTb75NEZ5QQkVUUHkgTQaM0ykfxZ
        iDObaja6E60VbNqa68O/6Ir43gJHs65vB4VtxLMdZj58p1/PPRgOTZCRQeHzePJfxnducET2KN1
        lcm2JkY6rXjjacUnAC2aoF4lqL3bmEyrr03COtrcJ+mVptA9bnQ==
X-Google-Smtp-Source: AMsMyM6oXVRxlUxBPOoqUVjc0pj8sEzbe1fz3rRjT8kX5DdfBDV7EJoYLV0dYixcNK52Ik4vHwwMmu4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:e6d8:0:b0:6cb:72c:d06f with SMTP id
 d207-20020a25e6d8000000b006cb072cd06fmr30997529ybh.389.1667532353925; Thu, 03
 Nov 2022 20:25:53 -0700 (PDT)
Date:   Thu,  3 Nov 2022 20:25:29 -0700
In-Reply-To: <20221104032532.1615099-1-sdf@google.com>
Mime-Version: 1.0
References: <20221104032532.1615099-1-sdf@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104032532.1615099-12-sdf@google.com>
Subject: [RFC bpf-next v2 11/14] mlx4: Introduce mlx4_xdp_buff wrapper for xdp_buff
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

No functional changes. Boilerplate to allow stuffing more data after xdp_buff.

Cc: John Fastabend <john.fastabend@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Maryam Tahhan <mtahhan@redhat.com>
Cc: xdp-hints@xdp-project.net
Cc: netdev@vger.kernel.org
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_rx.c | 26 +++++++++++++---------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 8f762fc170b3..467356633172 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -661,17 +661,21 @@ static int check_csum(struct mlx4_cqe *cqe, struct sk_buff *skb, void *va,
 #define MLX4_CQE_STATUS_IP_ANY (MLX4_CQE_STATUS_IPV4)
 #endif
 
+struct mlx4_xdp_buff {
+	struct xdp_buff xdp;
+};
+
 int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int budget)
 {
 	struct mlx4_en_priv *priv = netdev_priv(dev);
 	int factor = priv->cqe_factor;
 	struct mlx4_en_rx_ring *ring;
+	struct mlx4_xdp_buff mxbuf;
 	struct bpf_prog *xdp_prog;
 	int cq_ring = cq->ring;
 	bool doorbell_pending;
 	bool xdp_redir_flush;
 	struct mlx4_cqe *cqe;
-	struct xdp_buff xdp;
 	int polled = 0;
 	int index;
 
@@ -681,7 +685,7 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
 	ring = priv->rx_ring[cq_ring];
 
 	xdp_prog = rcu_dereference_bh(ring->xdp_prog);
-	xdp_init_buff(&xdp, priv->frag_info[0].frag_stride, &ring->xdp_rxq);
+	xdp_init_buff(&mxbuf.xdp, priv->frag_info[0].frag_stride, &ring->xdp_rxq);
 	doorbell_pending = false;
 	xdp_redir_flush = false;
 
@@ -776,24 +780,24 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
 						priv->frag_info[0].frag_size,
 						DMA_FROM_DEVICE);
 
-			xdp_prepare_buff(&xdp, va - frags[0].page_offset,
+			xdp_prepare_buff(&mxbuf.xdp, va - frags[0].page_offset,
 					 frags[0].page_offset, length, false);
-			orig_data = xdp.data;
+			orig_data = mxbuf.xdp.data;
 
-			act = bpf_prog_run_xdp(xdp_prog, &xdp);
+			act = bpf_prog_run_xdp(xdp_prog, &mxbuf.xdp);
 
-			length = xdp.data_end - xdp.data;
-			if (xdp.data != orig_data) {
-				frags[0].page_offset = xdp.data -
-					xdp.data_hard_start;
-				va = xdp.data;
+			length = mxbuf.xdp.data_end - mxbuf.xdp.data;
+			if (mxbuf.xdp.data != orig_data) {
+				frags[0].page_offset = mxbuf.xdp.data -
+					mxbuf.xdp.data_hard_start;
+				va = mxbuf.xdp.data;
 			}
 
 			switch (act) {
 			case XDP_PASS:
 				break;
 			case XDP_REDIRECT:
-				if (likely(!xdp_do_redirect(dev, &xdp, xdp_prog))) {
+				if (likely(!xdp_do_redirect(dev, &mxbuf.xdp, xdp_prog))) {
 					ring->xdp_redirect++;
 					xdp_redir_flush = true;
 					frags[0].page = NULL;
-- 
2.38.1.431.g37b22c650d-goog

