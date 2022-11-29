Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78E163C882
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 20:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbiK2Tfn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 14:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbiK2Tfa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 14:35:30 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBE8528A9
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 11:35:08 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id z10-20020a170902ccca00b001898329db72so8493928ple.21
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 11:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWDX6e0cj1Yq+chnlf+AJrNTZ0k1bmxGFANkxMRBzk8=;
        b=mwzFMQHXcovMhDNjapMZrvpGoUMIZ4+kq6mJGv0IWid5yeUAAvLE3+JoeOuWj2Onw4
         waaywLZoFbAj7HcTA+DuY/qPgWH/6VUHIrm5B3hibvKFeXZ1mfclW3axlOfHZgjOZoGC
         OINq0yCAZJFVTYf1Vx2eo5CmE7gtkpfRD0iPWU5DeTos3Sb4HrKFi8WJwP+EW4+cFMBz
         twhXpEb9jT0U+ZfuX75T6AerjhkECb2KQCqdkDQHrpgbpaqRldJ1jVgb07QKY8XMSMPg
         mnjdF7eD23/lnVfQTEQ+DW/7ZByil4IDp4pkiEwwsfKoBo1HGdC7KQmgXg/LrDCMMedL
         iTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LWDX6e0cj1Yq+chnlf+AJrNTZ0k1bmxGFANkxMRBzk8=;
        b=AZyFxnSKnGX+wUgYUz/m8fLu+yBPKv6uLRd1Qasd7XFfSxvOVQ/jz7is5A5o+uctsB
         UNHIsscWfVNvVVCfDJh///kR+pZcQGjpjwPSorZxnVnaTyRrRahQtBHa3KSgLw7XLgD7
         9ruqplO39YSnMNwR4a1/wU3ORZw6R81rQd9hAEA4SlhOkQs4GhqDr46iJ5/ibOuf+ZHI
         Woul3VGRugoRQEGmKLfpv2Js8zqb3hDlxLyXIySjzSVZeGZuDWomFY6ODem/epMgnzvE
         gPTikdIl7i/4+zMZxudoGKNAHhTi/c0Lkh0GsyNj1Q/MxGhAxGbceW+LVhawRbUEERsv
         CCrg==
X-Gm-Message-State: ANoB5plRjX39aWeHJyxAxjdH/wAksYLHkAFfQqUbeZ9s/B4oqxrYW6jf
        iWKLj7tqzHrcnJT1FR6kbLWpN51sUYucbv4dJcd6XlohDo88Tj9MBPhhCUB3LaCmbuI5Y71ijKP
        vM162osNv1NzfaoPp3xbIXfX7h61W0fyDUqlljZq4hZ66obRQ3Q==
X-Google-Smtp-Source: AA0mqf6AVwgAGav6M+opXS21wbL57Jq4TD/QP4soKIby0MQez1x5WQlLFQwvuHxAVY/ksjaj6TSBkCc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:1659:0:b0:46e:f23a:e9aa with SMTP id
 25-20020a631659000000b0046ef23ae9aamr35336799pgw.428.1669750507608; Tue, 29
 Nov 2022 11:35:07 -0800 (PST)
Date:   Tue, 29 Nov 2022 11:34:49 -0800
In-Reply-To: <20221129193452.3448944-1-sdf@google.com>
Mime-Version: 1.0
References: <20221129193452.3448944-1-sdf@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221129193452.3448944-9-sdf@google.com>
Subject: [PATCH bpf-next v3 08/11] xsk: Add cb area to struct xdp_buff_xsk
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
2.38.1.584.g0f3c55d4c2-goog

