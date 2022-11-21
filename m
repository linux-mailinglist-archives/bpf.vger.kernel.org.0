Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2C9632C13
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 19:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiKUS0X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 13:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiKUS0V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 13:26:21 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C62BD06D5
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 10:26:05 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id f12-20020a170902ce8c00b0018928092ec9so1790109plg.22
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 10:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mZqP3yNBrpAwk4TJsSnLiwPq87Wubt3mJUNd7RioCb8=;
        b=n5EeXpIol277FfH8pVgfNkp0LXATkS74tOOiofe8A4P24VMW2KShluIJzFmIxha/IL
         xqncVwIdIQIiRDzOvq88kcaINR78SbKb5sTbNuKg2OOjquU0O+Ml9tmuaPXC6oWuRmNe
         q9J4g1w5mKmX5iZa/VdZdy+y/4X/ViKVDVyaWRxTF4ZRwIE5XJZVbIhOx+Q+utCp0plH
         nM9eYGUgJsbKUqqZPucB8Q9vToTJb581zJu/PbSHJP3tx8u/7HkqwrL3fiEarhdZzTZg
         mPOFcHrmD4Nx+0Aqv9U9DBGNgP9ETuJq7uLW1AOsGzM5ckXe9G70nRGmiBEl70XGC3cQ
         TwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZqP3yNBrpAwk4TJsSnLiwPq87Wubt3mJUNd7RioCb8=;
        b=CltRsICH8UlQfv6Lr1YWgx0AB7ZkOo34YV+9H1CXFhuKgRd6Xc7iKqfvDQ05pwVShd
         BLg9ugEsolPdQ8ZhHRRs/E2yxf1x0UywQg1RFd/EfnN8jFWJ+at7YoUqkHZl/Ff7D1CN
         J0biECgpqqz3o7G8tV7Nv1aaPwYsBuldPABdkmQV//pcTt84rGoHe97Fp+mSF49GAHBU
         tziweY6OrJhRqt4p8W4OUAeu4rydQU6kPQnND9JJCwyDVEMacZO7dNQYpqhant3QwOuv
         jebjjZkra4jaoIImkKnnqi1srpwjQJNVrlNj4zdIn6p5M9UjF16iixqMSWAIqDOABarY
         oRYA==
X-Gm-Message-State: ANoB5pmwq5NGUWvBi/W9N31HKbYcnESAloPftjANzSrUtIFD3keyw66s
        4K4WZ9F/NTZ53ddQWnmjFCWFF0B/I9gIrvUmD367eVQ3IyLHG5//AcDbCpsiGbcfV4D0gg4QYZ2
        CFKTO32SwDr38BSna1eHD8B3JwxgHcoaRd+h7JTuZnTtQirURww==
X-Google-Smtp-Source: AA0mqf4IdK+Ed1+mNhKMzH5S4cC4/t5Tc7FBAGO03ycP1MeB/RalnXA5jDvqks2Bs1nqsSDs+wEWRv0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:aa7:880c:0:b0:573:3397:f804 with SMTP id
 c12-20020aa7880c000000b005733397f804mr4367415pfo.86.1669055164507; Mon, 21
 Nov 2022 10:26:04 -0800 (PST)
Date:   Mon, 21 Nov 2022 10:25:50 -0800
In-Reply-To: <20221121182552.2152891-1-sdf@google.com>
Mime-Version: 1.0
References: <20221121182552.2152891-1-sdf@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221121182552.2152891-7-sdf@google.com>
Subject: [PATCH bpf-next v2 6/8] mlx4: Introduce mlx4_xdp_buff wrapper for xdp_buff
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Tariq Toukan <tariqt@nvidia.com>,
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

No functional changes. Boilerplate to allow stuffing more data after xdp_buff.

Cc: Tariq Toukan <tariqt@nvidia.com>
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
2.38.1.584.g0f3c55d4c2-goog

