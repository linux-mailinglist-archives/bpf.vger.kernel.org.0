Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35DA652900
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 23:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbiLTWXF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 17:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbiLTWWZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 17:22:25 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157121FCDD
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 14:21:14 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 69-20020a630148000000b00478118684c4so7932212pgb.20
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 14:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfJO+GQYze9TOg5vw18ss4rmZmF2LBjdqaB1j+Nx9Ls=;
        b=QU5rXZY51IYDtIPXczKfRymujAQRVfDedJDPJkcGvEijVm6FuEUYqMxlAuZ12pL6CW
         77vlD+T9su0alS4MyN1dVME5HLHAKa5YJOd/pYprasBYX6DHO+Ypo/gncdzjdgPsRSS2
         BsQl81SFjSFHy+dLj/WYPCgJSpgU3nBddGV2TBVw2/QCgq15ogVrhqoRDmbNjsM2X/kN
         x1p2gCGxhUxkXBVsXtld3REegAQGAskmKEnMCkD7MDxKGZHb2e8CZAYowodzh02P4+Uj
         SW/dYye/TcT4ZZkLRN+7oNXeX8wyes3GukvtcSyD70D34+Tttsvs2gkOCK1+Vbo9r01s
         4SnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rfJO+GQYze9TOg5vw18ss4rmZmF2LBjdqaB1j+Nx9Ls=;
        b=oux8qM56X7XMm3947ayYcYEiV0ziQaWfshFq/p48YWranmsn/d1D5XDKmUDXrYVS5d
         82j/G5aOzN3rzA9R1q8/LzEjP89tUVrGmj5ZM6GIR/msFWX3QFFIolOwmWIZLV6rNwsp
         hX72AjDKeJ8uQQ4WtY7d/p5J4QQKcGqj8+m7VlQuXKz4CSGnsBYb0pJwB4aoZr0IHDBb
         zlvR2W5FMRYVf4o0hml+SU/LhwVyDwc2QMq47mDhkMmti2oC8GYegd7uZpDBgnu8FwqE
         husxcuUD1Wb9/wcfsiPEVMWA5mrVPEE8rANxhApZi3xuXVQKhPA5UfV0w7pVe5aNXcC4
         YPlQ==
X-Gm-Message-State: ANoB5pm35kIveGMoa2+9AjFWBcyVYEw48KKK3bNa6ARppEb7sCoIwVss
        DnqhDdLToHrH95Qo/LdUCamiySunKjFNp87Oi1qocYuU7F1FDBCapzh3kEV9ISTyKhBPWCMza1J
        y9tD8Ud8w/QErNu1HYQXzdbhQ1OU3pZD57hO/Ur1SC8mXahf+mQ==
X-Google-Smtp-Source: AA0mqf71FV3cUaHj89bBiQjY0b5r796mRu/GfHEUXAkRixdUA4v/absSYPLS6h9WtMd/hBG2Kwqiuzk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:4420:0:b0:479:3eee:a727 with SMTP id
 r32-20020a634420000000b004793eeea727mr1699661pga.56.1671574870508; Tue, 20
 Dec 2022 14:21:10 -0800 (PST)
Date:   Tue, 20 Dec 2022 14:20:40 -0800
In-Reply-To: <20221220222043.3348718-1-sdf@google.com>
Mime-Version: 1.0
References: <20221220222043.3348718-1-sdf@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221220222043.3348718-15-sdf@google.com>
Subject: [PATCH bpf-next v5 14/17] xsk: Add cb area to struct xdp_buff_xsk
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
2.39.0.314.g84b9a713c41-goog

