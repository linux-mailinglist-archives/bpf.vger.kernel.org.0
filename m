Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310036667BE
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 01:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbjALAeB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 19:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbjALAdI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 19:33:08 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FA54103C
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 16:32:55 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id t12-20020a17090a3e4c00b00225cb4e761cso7308842pjm.3
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 16:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfJO+GQYze9TOg5vw18ss4rmZmF2LBjdqaB1j+Nx9Ls=;
        b=MNN9w+Nkh/ZccIep7WExqmWKm+6gGKyRw6rZXDLYMoWswZMxph+Kc0KzWPHUYOzEnW
         j/+mgIJDuluXpGJ5osuIQ8wks6r9lwI6DbmVqXJlXdkVP4tvWLuTQo7eOtd9xPQ4ODRN
         MY63d7Cda6rUC+fenbutfJ4MbAevtXT6DZD6PlBSIv42oT9fXO3F/3jnQg+RW4hMYazE
         krz4QNn+QXzIN/OgRcsUK3DSwBHhUsxsbUIz7QqHxMKjQY4ULTkxBh2Y0Wu3dqnPnL9a
         H83ZDsxBXa76J1N1OJPrA8lvW1JNftxkPD38kd6oYU1Hbi9LPAmWmnQNMn1DH81/qxrc
         RlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rfJO+GQYze9TOg5vw18ss4rmZmF2LBjdqaB1j+Nx9Ls=;
        b=QhTgdMerIxzHHLwxIMNwsrUlQubK2es5+XikQ/Vkt0P9Kh4N5rgjTLK76NBR4gBbsq
         N6VjWC22JXXmLP7CYB0W9K9R2qBqxDSOugpe932o7QrtXMJFhz+3qe2D1DevuUSnNJpx
         cNSqSERXW2tg+eBZhvCUci6sZiASFxm/sHU0qzNek6aajBAKB6S+fvOz8U2c9bBSWaVs
         Wz9Oh4mn+7Ag6swOSKX5rTFCv0wMywuf6dygVSh0T37yzCmu4FSD+/jiBlgTwMB8JiwW
         2+VrI3vMRs9wSJA4htsqSXOLlfFNg3fABSCKp1v647D2Gp5wpnz4CzqrWt+iWJF2bMkR
         ZMCg==
X-Gm-Message-State: AFqh2kqhXAPPOy829g4qRR2SwpDruX21qAyCQMbkeda9gqFqBPyDHZ6V
        mvIocjAfCzysRW+9Z309nJZ8e2OBmfOaBCcj1+D8euAOKc8SE7tQH46sxnt1dwFB3G93kiQ93nx
        2QZnBbI8QCYPLqq6g2LNyuFCQqINafcNwmx+w7MVUgSP0lEr1EQ==
X-Google-Smtp-Source: AMrXdXvPDC2WKfBiLM6HUbbUbv2YDnJ3aSNzXOS91uUtYO9tQ60VpIw0Ekhh3Gp1BjJB5Yut76MwTVc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:9d82:b0:228:d2c5:5b35 with SMTP id
 k2-20020a17090a9d8200b00228d2c55b35mr572306pjp.98.1673483575307; Wed, 11 Jan
 2023 16:32:55 -0800 (PST)
Date:   Wed, 11 Jan 2023 16:32:27 -0800
In-Reply-To: <20230112003230.3779451-1-sdf@google.com>
Mime-Version: 1.0
References: <20230112003230.3779451-1-sdf@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230112003230.3779451-15-sdf@google.com>
Subject: [PATCH bpf-next v7 14/17] xsk: Add cb area to struct xdp_buff_xsk
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        "=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Add an area after the xdp_buff in struct xdp_buff_xsk that drivers can use
to stash extra information to use in metadata kfuncs. The maximum size of
24 bytes means the full xdp_buff_xsk structure will take up exactly two
cache lines (with the cb field spanning both). Also add a macro drivers can
use to check their own wrapping structs against the available size.

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
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/net/xsk_buff_pool.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index f787c3f524b0..3e952e569418 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -19,8 +19,11 @@ struct xdp_sock;
 struct device;
 struct page;
=20
+#define XSK_PRIV_MAX 24
+
 struct xdp_buff_xsk {
 	struct xdp_buff xdp;
+	u8 cb[XSK_PRIV_MAX];
 	dma_addr_t dma;
 	dma_addr_t frame_dma;
 	struct xsk_buff_pool *pool;
@@ -28,6 +31,8 @@ struct xdp_buff_xsk {
 	struct list_head free_list_node;
 };
=20
+#define XSK_CHECK_PRIV_TYPE(t) BUILD_BUG_ON(sizeof(t) > offsetofend(struct=
 xdp_buff_xsk, cb))
+
 struct xsk_dma_map {
 	dma_addr_t *dma_pages;
 	struct device *dev;
--=20
2.39.0.314.g84b9a713c41-goog

