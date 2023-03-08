Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54FD6B1054
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 18:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjCHRl4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 12:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCHRlo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 12:41:44 -0500
Received: from mail-ed1-x564.google.com (mail-ed1-x564.google.com [IPv6:2a00:1450:4864:20::564])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2AAC4E99
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 09:41:15 -0800 (PST)
Received: by mail-ed1-x564.google.com with SMTP id u9so69008130edd.2
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 09:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1678297273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U5/HqLOR/DLW8wSfO9JppHulM9FF7/EygUD+stIJLE8=;
        b=MOiGV0qwjhJ7Bw2XXcFG7k+LMJjfDviPUuA1DntfhipLGle3D9zfpVJ838P8pSB2qu
         B0Us2hqYIKIVDO1P2VWVFCG33hEvM3KQ0+2zxQBfSwzBetNbEb6OysyBQiIg6m9QtCod
         I6nmeGSTHw54kbIGstm+hEuGdugQ3N0MdC8zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678297273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5/HqLOR/DLW8wSfO9JppHulM9FF7/EygUD+stIJLE8=;
        b=VpenxmjeCiYrWL8ODX+IUQX2kyZWfycT6w6umKrXAfcepePlnpjVTO/VqskCZU3qyX
         9H6Z0bFE8MIwhNGFxvJl5ZiaN1YYS9TTg+TDVw8Fh6ClehIo1ez7HhbCPxZJ+Yj+4n07
         Lh+JRxmt52Cyjdj8ECanLeRg63tgykOgqdfmFouRtvSMQSqYKCHurdRy6IOmkFE8tRBC
         IEeu2t33/0gtriGMs2B/EgEj8Rovx+X9mnL2ewS/PnLb4/tNzgVC1iJR7Ry8Shd5Lrfk
         aZkf07RGlvsmPEIkILEOTvUOUsKzefhhVenUCQpMc4ecoisw96z9QAfRw7ndzovNUX0+
         vfKw==
X-Gm-Message-State: AO0yUKVdVi3r4uXbd0LjV0ADQGt2sCzqfOaOaa75zRXs3EVGTjJRCapV
        dL7qS5zwGLCojLezgr3mblF9xhv99K5a4NGP9Xz4chNfhVkG
X-Google-Smtp-Source: AK7set8dmLaJMlUEk2OeA5ELu+EcbvmG6cqbP6NCMljre70jn78Fyy6U2jzGJrRLf6vgaQFzNxUXiYaFlMPP
X-Received: by 2002:a17:907:a406:b0:909:385:da4a with SMTP id sg6-20020a170907a40600b009090385da4amr22359539ejc.54.1678297273099;
        Wed, 08 Mar 2023 09:41:13 -0800 (PST)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id h18-20020a1709063c1200b008c60f160f54sm3451896ejg.62.2023.03.08.09.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 09:41:13 -0800 (PST)
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
Subject: [PATCH bpf v3] xsk: Add missing overflow check in xdp_umem_reg
Date:   Wed,  8 Mar 2023 18:40:13 +0100
Message-Id: <20230308174013.1114745-1-kal.conley@dectris.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The number of chunks can overflow u32. Make sure to return -EINVAL on
overflow.

Also remove a redundant u32 cast assigning umem->npgs.

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

