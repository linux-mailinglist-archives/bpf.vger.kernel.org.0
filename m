Return-Path: <bpf+bounces-5202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE17B75891B
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 01:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C5A1C20E8F
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 23:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D53B17ADF;
	Tue, 18 Jul 2023 23:40:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641BA17AAD;
	Tue, 18 Jul 2023 23:40:27 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4E7EC;
	Tue, 18 Jul 2023 16:40:25 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b9b427b4fcso4399252a34.3;
        Tue, 18 Jul 2023 16:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689723625; x=1692315625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=skEsIwBhAgXoALBlSSMqAp81nCwKF7Rh+zIuXQcHpVA=;
        b=g9q1jFGnkyM8hyKVbh+8h7bHVZA2EQ7Ybkv3KrVuaue1fbWoGJjr8I2cE+OcOis9SM
         hJVC9q6sPb9TsTpNLFkRnDByi9CcEcYcSycV03PXeE9c8WDmx6wXgOvB52DU8jYkm6Tz
         GbxYQyS1hQlPhcNtqpYd5nbfgEBaCI9AxiN51Npw5A+FaUs5sv7Abdo0XivxCBSx5zos
         OCg37BsTkXUgIG8yMUwRP5oxqZsuMN+nAwbpHR3RoHCO+nr415IV0gav9rydoPFzrBG3
         cnSvB6yTVhXYBgliAQC4EpT6A1rmjjE2FTcUNwZNMk+SqklAVUxPf32ZtkUUCxH5rpF5
         zc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689723625; x=1692315625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skEsIwBhAgXoALBlSSMqAp81nCwKF7Rh+zIuXQcHpVA=;
        b=YvrkBwqTXFqtdHtKfVnFzd7RMw2uBp8D9NN8A5n+EhCuNZpt5r0xuGPwI3nNOejAoU
         vIuB8e2X4fPdUvrJy6l1TRipwNEal9OhZIHn7n7h5IwKu6YWH/1uZDICINN6teaXwgGQ
         kCr30mTJZM/2z27O/zMbomt2fcqIFv02hDP0K8tYfh4/0NsHlXmGeDascnjMF+2ZIZ5t
         HSKHeuKceQghNu9VzLCgZyW4jEDbsdGbs+aCV+qOmLdkSwiYKNia667ePFbGJBCqCbps
         VIlxWuhALstSkaGJIZRl/CUUe2MQrwI+tEksA+az72Vepzn29woiH8BjER7NzTin+zWj
         NYIw==
X-Gm-Message-State: ABy/qLaReeutaRjeTLd0+NeqwDr8JBCqqxQHi9XGnTs1Nl3Pxb0ZZRk/
	nWEu6h4+R9a61i6dIU0yM/zLmYdDn/4=
X-Google-Smtp-Source: APBJJlFGpwFw+uZ+vMiib+sCW5y0EsncXSHxk4U7XExM37pJOP884RhmZhFLJs1KeRB3BOhvwzPsNQ==
X-Received: by 2002:a05:6358:2904:b0:134:f28f:aa47 with SMTP id y4-20020a056358290400b00134f28faa47mr5198928rwb.23.1689723625038;
        Tue, 18 Jul 2023 16:40:25 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:3b4d])
        by smtp.gmail.com with ESMTPSA id l20-20020a639854000000b00553ad4ae5e5sm25285pgo.22.2023.07.18.16.40.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Jul 2023 16:40:24 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	andrii@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next] bpf, net: Introduce skb_pointer_if_linear().
Date: Tue, 18 Jul 2023 16:40:21 -0700
Message-Id: <20230718234021.43640-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Alexei Starovoitov <ast@kernel.org>

Network drivers always call skb_header_pointer() with non-null buffer.
Remove !buffer check to prevent accidental misuse of skb_header_pointer().
Introduce skb_pointer_if_linear() instead.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/skbuff.h | 10 +++++++++-
 kernel/bpf/helpers.c   |  5 ++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 91ed66952580..f276d0e9816f 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4023,7 +4023,7 @@ __skb_header_pointer(const struct sk_buff *skb, int offset, int len,
 	if (likely(hlen - offset >= len))
 		return (void *)data + offset;
 
-	if (!skb || !buffer || unlikely(skb_copy_bits(skb, offset, buffer, len) < 0))
+	if (!skb || unlikely(skb_copy_bits(skb, offset, buffer, len) < 0))
 		return NULL;
 
 	return buffer;
@@ -4036,6 +4036,14 @@ skb_header_pointer(const struct sk_buff *skb, int offset, int len, void *buffer)
 				    skb_headlen(skb), buffer);
 }
 
+static inline void * __must_check
+skb_pointer_if_linear(const struct sk_buff *skb, int offset, int len)
+{
+	if (likely(skb_headlen(skb) - offset >= len))
+		return skb->data + offset;
+	return NULL;
+}
+
 /**
  *	skb_needs_linearize - check if we need to linearize a given skb
  *			      depending on the given device features.
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9e80efa59a5d..b8ab3bea71b7 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2239,7 +2239,10 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
 	case BPF_DYNPTR_TYPE_RINGBUF:
 		return ptr->data + ptr->offset + offset;
 	case BPF_DYNPTR_TYPE_SKB:
-		return skb_header_pointer(ptr->data, ptr->offset + offset, len, buffer__opt);
+		if (buffer__opt)
+			return skb_header_pointer(ptr->data, ptr->offset + offset, len, buffer__opt);
+		else
+			return skb_pointer_if_linear(ptr->data, ptr->offset + offset, len);
 	case BPF_DYNPTR_TYPE_XDP:
 	{
 		void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset + offset, len);
-- 
2.34.1


