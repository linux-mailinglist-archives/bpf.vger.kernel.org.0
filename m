Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F046367462B
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 23:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjASWdo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 17:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjASWcZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 17:32:25 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D21AED90
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:15:59 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id dc11-20020a056a0035cb00b00589a6a97519so1489096pfb.8
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=htMN/yzUsrFUezfiiz6iUmUodbGMSzyJrDiLh/3CZfc=;
        b=OnZrCG8Fes3S9z5UlbLAprSa+gggNK8dF3D+Y46RgTPKHlW3GYccgfFYJiVoNZDeRw
         uXtjAP2DMPZ6iKlUme7ZjLh/IhCK0Jum1dkwjbrDqlM89Hv/KpKeTku2eOGrrpG8qPAO
         f8YAwo21Il0IhkcoQ+8EowawFKzeFMo2LBOw344HSMhfcYvdJLR9xA2VS750xaozt60S
         JJqPkJ6FZVE0KMX+1llWjmEx9njubd03bUkj8kOwm/N7B2EC/L+W0tOkgwNcA0IllJF6
         DtIUnf/prvBXJ3Zosr4N2TnsPJMDVMQsReaIH4otbkVDLQaTZS5pktoLmY6qslR+4R0E
         UBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=htMN/yzUsrFUezfiiz6iUmUodbGMSzyJrDiLh/3CZfc=;
        b=sYu4nRBPU1LyVCM9LqXfbRnGNAm9NHeJIOaGzhtbWj6MK3ikmNw+5fBEc22cumR+QG
         NeaOpG8i7uA06z2iplFjNaZzkdTIg0V8OXmCvuViO6LIfyxy0rNZsdbsgBLmU+YXSqor
         0e6noUt7/aDOgUdB10kTYbvy7y4yEE7aj0VCiW/sSKB31g4kJNOEIvEI9KVZ/D5jMDTY
         MHevuc14ME/Mr+fhP7RusFm3WeGwYbKfM3aTouxTmIcs/gCQhMZQJ04Vtkw/97GMq/6E
         gram3TYia0ofShT5TCm8heYcTCw/ZVASr9lhUvvb/H+q134QEa8j0FGsObJr2a/EFKRh
         rFjQ==
X-Gm-Message-State: AFqh2kq1NkWev+JV0Az/puYRfTUnJ1RV5O/UOXG+C9TZiRxk8x8MC7j8
        EDG/FvkdnHZo3w54LR85kF1/NntZ7EIT/az8ASSmdGzTw5j411X7IdVgWa0shU/M6FSfud1tOzJ
        Vf8cd79ewuOaIfULiIIi2XFjPpUt49zRsbOiTLTajdkAkbw7D8g==
X-Google-Smtp-Source: AMrXdXv96HQmhJZtdtK+pZpLEoS1Yryn+acdzVeHX0QPn1y2VmlmeL8LoCtkThSoGYusc8VkiQdCJro=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a62:5215:0:b0:57e:5b23:12cd with SMTP id
 g21-20020a625215000000b0057e5b2312cdmr1247951pfb.81.1674166558668; Thu, 19
 Jan 2023 14:15:58 -0800 (PST)
Date:   Thu, 19 Jan 2023 14:15:31 -0800
In-Reply-To: <20230119221536.3349901-1-sdf@google.com>
Mime-Version: 1.0
References: <20230119221536.3349901-1-sdf@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230119221536.3349901-13-sdf@google.com>
Subject: [PATCH bpf-next v8 12/17] net/mlx4_en: Introduce wrapper for xdp_buff
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
        netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
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
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_rx.c | 26 +++++++++++++---------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 8f762fc170b3..014a80af2813 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -661,9 +661,14 @@ static int check_csum(struct mlx4_cqe *cqe, struct sk_buff *skb, void *va,
 #define MLX4_CQE_STATUS_IP_ANY (MLX4_CQE_STATUS_IPV4)
 #endif
 
+struct mlx4_en_xdp_buff {
+	struct xdp_buff xdp;
+};
+
 int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int budget)
 {
 	struct mlx4_en_priv *priv = netdev_priv(dev);
+	struct mlx4_en_xdp_buff mxbuf = {};
 	int factor = priv->cqe_factor;
 	struct mlx4_en_rx_ring *ring;
 	struct bpf_prog *xdp_prog;
@@ -671,7 +676,6 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
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
2.39.0.246.g2a6d74b583-goog

