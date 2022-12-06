Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB10643B7D
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 03:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbiLFCrE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 21:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbiLFCq1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 21:46:27 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADC625C70
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 18:46:11 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id r126-20020a632b84000000b004393806c06eso11229808pgr.4
        for <bpf@vger.kernel.org>; Mon, 05 Dec 2022 18:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZy6zkebzShtYgGpy5Q+YTSoYFTyeOrDSEuSxWCy75g=;
        b=gEkfVyQr2QEqHozM41NVEezWgDGZdZIBfvzgPcTfCPyceYMSkeXlrqRMw7zaQqL8MO
         hR4VBqJDzmJNJTWNgC4OYelhGM/7M08tKcdVxcsDaVNCfRuwn84eeRgZ5N9h7bUppixg
         u/wKNuKOdbQDs3QTNCcFvnVaZbdpoWt+rf6lu9cdhL5R45pNci/OjGriKv/hm0T3aQLz
         qrOU2ySKoSm0qcVAt2zhN5qnNQgRXsMgmqmwZ9HCid1BEk1J9PLO7OLO+WBg9VP84mOJ
         Q7/raNxMa+xuCB+3Em+2NMc10SDyX5PatQ1+Vjbt6yZ91S8Wzb0mItKwIE/JomAJyMl5
         /N6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UZy6zkebzShtYgGpy5Q+YTSoYFTyeOrDSEuSxWCy75g=;
        b=Ua2/8/nbId6fmA6vfSLqCx+mAXU/EjnR+i3+oR7znxyy1wKtqCbWq+mfJMKvqQMBBR
         Gy+4KyhxU58IsD5CSswv5iVl+pDlT458PAe9baGyrYLZRvLNn8DX/eldLoBCxWRtheR9
         J4rjTfhxOncaP2KqVAJifmncVMMaTqObGiYhs9cIGlgHjLWL6M0Klo6kLaDrtR9Rrlys
         hSzhrxf6eCZsOzlPwYRQizTCtbHzb4KJ/DBBvn5rtnx5T8mdJ6nLBvfdg2bDtkrihFlk
         dekGeFx/b2oFrWseyxjW6/RHfziOiAP0Zc8viy6ZqZbq83+hPQi9f3jM+qkN92WBk5LC
         6lbg==
X-Gm-Message-State: ANoB5pkJXVHL0/8zkZR/8v4mQVktIxkNXnkRB+G4USLD0dhA3Em12WJw
        /xhrt5K+PIyoN5eImc0oxmOuu1hHSkWVYI6WkOjDcsTzE5SM/1E4wJ/V/bJbuJdW1CmY8E5UldS
        9kuTd3OeZ3f+Dqh1txYcRrBzycl2xsHlFQSeC4Pd3pUEwIWWWDg==
X-Google-Smtp-Source: AA0mqf4UnF9Fm2sPRgnEv5gKJQEmAPOG7F3MItD2A0LrJSE/fNUiN5si6iC2lnB4PRUxcUoxSy2nLOo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:22ca:b0:56e:64c8:f222 with SMTP id
 f10-20020a056a0022ca00b0056e64c8f222mr89232750pfj.71.1670294771338; Mon, 05
 Dec 2022 18:46:11 -0800 (PST)
Date:   Mon,  5 Dec 2022 18:45:51 -0800
In-Reply-To: <20221206024554.3826186-1-sdf@google.com>
Mime-Version: 1.0
References: <20221206024554.3826186-1-sdf@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221206024554.3826186-10-sdf@google.com>
Subject: [PATCH bpf-next v3 09/12] xsk: Add cb area to struct xdp_buff_xsk
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
2.39.0.rc0.267.gcb52ba06e7-goog

