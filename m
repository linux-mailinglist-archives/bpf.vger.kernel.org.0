Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DD36B050A
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 11:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjCHKxV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 05:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjCHKxR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 05:53:17 -0500
Received: from mail-wm1-x361.google.com (mail-wm1-x361.google.com [IPv6:2a00:1450:4864:20::361])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E6B60A82
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 02:53:14 -0800 (PST)
Received: by mail-wm1-x361.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so865815wmq.1
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 02:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1678272793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFnIaNLO1jYcGQ/rd76lvHww9TyGOc8wkDjH2xbQ2vY=;
        b=cnhxBf5cTTpw1N9mDdNPt84ISNLvvjn801q368baQ2Qu3+yzPGVdIGdEPXvepil4V8
         UHmhsTR1+SAVaXMEjPHENYMCPKGgm8U19Uj/ohgFmguOdJWr+KlHZu7MpVigjCy2tAjN
         iDY7ixtO0z104mcy60yjjfoALQqgr5suSr338=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678272793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFnIaNLO1jYcGQ/rd76lvHww9TyGOc8wkDjH2xbQ2vY=;
        b=LKgEXDAMEZSyOKRqvjMjNYvnXy2Km3QjYVj7iy2VzPrKr5DUocxIq5Bmd8fqds5gaX
         smbSkjL9BYSBwnFhZrwmVK+Cj+fzQgBt5/oNZZaZMGyPyJIqZh1/1yBvpf/xbLCA/yA9
         6E/E/eUj6gTVF2R0tjPkh0Kyrj23tP+lFpmyta/A/yrpQq/eHaHX6cx+vpHp7QLW5GeM
         VG1yr8ZeZCY8bfX9p8oiKY2eSolx+uNFthhE/2tr1v06fyY0tggq9lyLovUHLiirHOBj
         4VV8m7dQr9xJTFnblnJBhZaWzyMrzuPa+/2Qb1cFi3JOxQ9m0Fi8EdBElTwxU9Dk3jyy
         wpWA==
X-Gm-Message-State: AO0yUKXRlB0r22Qkyb4Bzrvsy72ymWXPZ2059XMazZMH4XgUUFMRU/a0
        mr6+FEGmavtiihXzbJQBcpbxVRN1lT9uJPKyYzaelBWpW8sw
X-Google-Smtp-Source: AK7set/Kr0OA0KJtw2a+BX2EdMHPKeyQkkYCTFTEZBgEbbs/r0pMvzWLlEx+48YsTajHW/JgospqlxFfBIdq
X-Received: by 2002:a05:600c:450f:b0:3e2:19b0:887d with SMTP id t15-20020a05600c450f00b003e219b0887dmr15666002wmo.25.1678272793197;
        Wed, 08 Mar 2023 02:53:13 -0800 (PST)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id f11-20020adff8cb000000b002c5a302d158sm2125188wrq.51.2023.03.08.02.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 02:53:13 -0800 (PST)
X-Relaying-Domain: dectris.com
From:   Kal Conley <kal.conley@dectris.com>
To:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Kal Conley <kal.conley@dectris.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xsk: Add missing overflow check in xdp_umem_reg
Date:   Wed,  8 Mar 2023 11:51:30 +0100
Message-Id: <20230308105130.1113833-1-kal.conley@dectris.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307172306.786657-1-kal.conley@dectris.com>
References: <20230307172306.786657-1-kal.conley@dectris.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The number of chunks can overflow u32. Make sure to return -EINVAL on
overflow.

Fixes: bbff2f321a86 ("xsk: new descriptor addressing scheme")
Signed-off-by: Kal Conley <kal.conley@dectris.com>
---
 net/xdp/xdp_umem.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 4681e8e8ad94..02207e852d79 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -150,10 +150,11 @@ static int xdp_umem_account_pages(struct xdp_umem *umem)
 
 static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 {
-	u32 npgs_rem, chunk_size = mr->chunk_size, headroom = mr->headroom;
 	bool unaligned_chunks = mr->flags & XDP_UMEM_UNALIGNED_CHUNK_FLAG;
-	u64 npgs, addr = mr->addr, size = mr->len;
-	unsigned int chunks, chunks_rem;
+	u32 chunk_size = mr->chunk_size, headroom = mr->headroom;
+	u64 addr = mr->addr, size = mr->len;
+	u32 chunks_rem, npgs_rem;
+	u64 chunks, npgs;
 	int err;
 
 	if (chunk_size < XDP_UMEM_MIN_CHUNK_SIZE || chunk_size > PAGE_SIZE) {
@@ -188,8 +189,8 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	if (npgs > U32_MAX)
 		return -EINVAL;
 
-	chunks = (unsigned int)div_u64_rem(size, chunk_size, &chunks_rem);
-	if (chunks == 0)
+	chunks = div_u64_rem(size, chunk_size, &chunks_rem);
+	if (!chunks || chunks > U32_MAX)
 		return -EINVAL;
 
 	if (!unaligned_chunks && chunks_rem)
@@ -202,7 +203,7 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	umem->headroom = headroom;
 	umem->chunk_size = chunk_size;
 	umem->chunks = chunks;
-	umem->npgs = (u32)npgs;
+	umem->npgs = npgs;
 	umem->pgs = NULL;
 	umem->user = NULL;
 	umem->flags = mr->flags;
-- 
2.39.2

