Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EDF643B79
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 03:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbiLFCqo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 21:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbiLFCq0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 21:46:26 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C02F25C58
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 18:46:09 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id u9-20020a170902e80900b0018939ccbeedso15227360plg.20
        for <bpf@vger.kernel.org>; Mon, 05 Dec 2022 18:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nQeMNAXSvtEuYcIlZ03Sp5Z7s1yFLSbG448s72LvA8E=;
        b=jzKf5vuX89qjI4b5fE8iPrTEg2hyI8Yym1a3qyQFKi2JpBKl939zlQdC0MnUhaqktt
         ABOKSg9mtDi2UsCKoJkd0BXwqvKr/72JcVqZOndBMBpZ4ozhxR4nyNxowx8UHmA9purW
         uX1Xq1vmpQgFAw1KZkoW2JdmWwxRRadm/+cTyyXc0d/Y+ggtK0fO3fCdZRp7JqMybI23
         uribklVJNAJ56GZzrisSD/qUmPZcVwRn7aj+kzu84OPdZurXjPlDW/OUA7fnUX/wQcOV
         MPHQjfHe1Eu/t1romkuybo1EroJOaGI70UF+qYa0XGx3JHp3C/fE/g2q4KiAEHy2Qfkv
         KxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQeMNAXSvtEuYcIlZ03Sp5Z7s1yFLSbG448s72LvA8E=;
        b=CXe9KEiZ7qgvAO9K8yfH/GV99cRGUa6PGncDDKLDxRPyqHcBFFlttFvCsonhfOK0Wt
         +2WeCACSW62vRUj2wIjbFvcneT3j+Q7ebIRI6E69PZAPc2+dgKwisa6kEVLxKe/8bcA3
         KM8BdHadFNlzgwcOMT3UpcYiF9/JrUUiY3mpngvSniEXa4KrBn8MjrcE4wwZCzgcRZMm
         CF4LSibqRtyQBdgxhOZVVHv4aUvVHKUuNyGuuZ4W+RI1tij3q+fgcy7FvJYvbuSJqwhD
         WOch8gI3r4lQofm4sP4IjIz31wLyem/CPX73etKFJoQUBsFleH9Q3+K1mPABNlBnUSDA
         FoGA==
X-Gm-Message-State: ANoB5pnsLz7wmyuoxc7OiyZB//snTQaD5Z/jgASuk59dEc2XbTAjoWKA
        z/eVjuyfVviGZOnh8wzP6nI8PGizX2Ydf/PoX3rfkFJRWX86yj5YBRB8gwUOYkddiR6Iwnj6cSa
        tYkavM22Gg/oxi4qY7WPD1xrZxz7j2h4/fpHnINbYKuo9DY/3Hw==
X-Google-Smtp-Source: AA0mqf6MWZkcAPR7Ml+lQGeM7JUCA+2NSWk7DEjakG7MnoqPJmllJ8KlzYpAuEH/yTiYaUoF5JqYv3c=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:d086:b0:219:227d:d91f with SMTP id
 k6-20020a17090ad08600b00219227dd91fmr4694402pju.0.1670294767948; Mon, 05 Dec
 2022 18:46:07 -0800 (PST)
Date:   Mon,  5 Dec 2022 18:45:49 -0800
In-Reply-To: <20221206024554.3826186-1-sdf@google.com>
Mime-Version: 1.0
References: <20221206024554.3826186-1-sdf@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221206024554.3826186-8-sdf@google.com>
Subject: [PATCH bpf-next v3 07/12] mlx4: Introduce mlx4_xdp_buff wrapper for xdp_buff
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
index 8f762fc170b3..9c114fc723e3 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -661,9 +661,14 @@ static int check_csum(struct mlx4_cqe *cqe, struct sk_buff *skb, void *va,
 #define MLX4_CQE_STATUS_IP_ANY (MLX4_CQE_STATUS_IPV4)
 #endif
 
+struct mlx4_xdp_buff {
+	struct xdp_buff xdp;
+};
+
 int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int budget)
 {
 	struct mlx4_en_priv *priv = netdev_priv(dev);
+	struct mlx4_xdp_buff mxbuf = {};
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
2.39.0.rc0.267.gcb52ba06e7-goog

