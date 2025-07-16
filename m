Return-Path: <bpf+bounces-63462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 069BFB07B0E
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 18:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A77718826D7
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 16:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12FF2F7D18;
	Wed, 16 Jul 2025 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AXTZTlOW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17A22F7D05
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682700; cv=none; b=bCEj58bo44uxfYgr9wrYzTbJbNYWxvHNbfpdeADcN2XArLcuRc7L8sYQ7ECac1sQaJ4YTnQ1mBW5CP+cW0n5cmqgND2L+60qIOBIxFH4uzi6pm2ytgzzgIPaE/8NxBCKALDIYxTzqSBgCILNxMW2C7t+4mShWs9J8aHAF10dcWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682700; c=relaxed/simple;
	bh=duMKK44JnKpe4MGN8M6YKC4qDTC52JONh/TP9d9AdL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iUfLM14GUkMElbrxPfS8PcADj6dJpVjVyxkqRggDax/eJE3+mtRmdjp0PVlMhYXWz1Sv5u4Phl5YUnakqN1veQuCSzMioT80kbUbyBbxV0GTXhbFZYZkHD3WnDq7pgtYw2UJ/JnPIptD4oTEJaU1FdtQndUnL5LqRrwyaoMfCQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AXTZTlOW; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55628eaec6cso56296e87.0
        for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 09:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752682697; x=1753287497; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvuGGpBWHPa+xyjonBcXXcpvK68Zk52Wi7ziORp+6ao=;
        b=AXTZTlOWav+tA2HFSfskIbelPxRSH1nQx/Wq9PzwRQtwg9HajTG/tPkQxbkkiIBsDy
         RbPYsc+gDdKyD28ry4L/Dc6XnVbBrXI2VsJBOHqjmpLG3wSgdi65Fn/QunTm/+rpcTs+
         9LjImEAVBYWSFuCBsQO15FaxYvh49TgTSeDkbcxhFDTJZsZp/MVqj3hTIG6nefatMSCS
         aNn+wnRZw1d963gvkFdc6rlas4dvNioEQnNnATOr5YuvrmzBqXyV6Y9/GC/vfi7VvsTE
         mCJbY4BehBOEjRe9ni3Mr8xpgzzAuWb+rY4HgCmUDd3YajRa8k2bg0JK6Afn/8LZ2KtT
         f5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682697; x=1753287497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvuGGpBWHPa+xyjonBcXXcpvK68Zk52Wi7ziORp+6ao=;
        b=SzPz51b/fwaXQqNMkEDV7JYultetDBIxkp5EgopPA6FuRLK6qbU8kzKTPl+s3QIC2n
         Biy4/qzPJfZ5dx5KvxG3fzSRDkFc6UJMQW/VNRxHPYbqZB5isAJKL+fw3SW2okV/s180
         XwByyPOdCN2CPaXoV3pRL4Yl0aOC8UJOqeP32uD+bZinTFjWoexqdJrfCsPpUxtBaUZk
         6zwxy+tbuA6QGi/WXvajVqvL2d9R8WCt86/y1KrCzDjzcbflfoPdb5JgtH+T8/setVcn
         bMXbUuSFcqNPAt5t7eLlydwbpqokkw3h6AOBIAnozRSLv72ozVMbgcU/s1xMH5yUEx0r
         MLiA==
X-Gm-Message-State: AOJu0YwQyyTs9YpwkwkFYtfj5AuwwufGV5vBZm8pe/bLyGChAfzoENje
	4euQLhAubn2wLFyp2c3yQxJZahgd2nMHC92awzDJIHvXVOVR8Br/NZTT9zJNwUxmzus=
X-Gm-Gg: ASbGncvobiOE5V5wwP6RvjoawwHRolLaREnAbVUzrTesOKdgLmABUs1r352pqZFqV2P
	trM0raA8fKbRQ8M9VHh6NYjUZEm1v2YJ+Xai/LfUgH5017gnPBy5Snv9BraepJhFPiXG6TCSIEZ
	RtELu6ehMGL+zuX3I3sFU3G9Tl7ZagKu5u4OWQ2HpjYNne6pI5Odj0nsCZXTx210IEcQukBsL78
	SbCZoKGja5BFCBypvi2Tgain9Tke7MkH2nqbyqyppkN4spnOc/JyYrCnWlaK4jymJ0HwlnW6WVN
	mwfpFbD9KNmJscj8YMcPdBjPg1r6CSCuCRRT+Wsq3AFZzAFhOzv6JoNp3A0Kotv4v4kaCkKKQy6
	8bF/ub2cZOyjh6kdu1rTb95NVXzhO9vbHJh09LRF8hj2BkhB4E4W6GRumoAjdejaNq4+j
X-Google-Smtp-Source: AGHT+IF7HzUntdyqtyy1x/CT6VXhG4wFS+7dSrnFz7I4YDxzUAhN13WMV4j9nvW3preyWI11ntdvgQ==
X-Received: by 2002:ac2:57c5:0:b0:553:a339:2c34 with SMTP id 2adb3069b0e04-55a233dd351mr1025284e87.44.1752682696790;
        Wed, 16 Jul 2025 09:18:16 -0700 (PDT)
Received: from cloudflare.com (79.184.150.73.ipv4.supernova.orange.pl. [79.184.150.73])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b7324bsm2704254e87.202.2025.07.16.09.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:18:15 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 16 Jul 2025 18:16:55 +0200
Subject: [PATCH bpf-next v2 11/13] selftests/bpf: Cover read/write to skb
 metadata at an offset
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-skb-metadata-thru-dynptr-v2-11-5f580447e1df@cloudflare.com>
References: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
In-Reply-To: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Exercise r/w access to skb metadata through an offset-adjusted dynptr,
read/write helper with an offset argument, and a slice starting at an
offset.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          |  5 ++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 73 ++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 79c4c58276e6..602fa69afecb 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -375,6 +375,11 @@ void test_xdp_context_tuntap(void)
 			    skel->progs.ing_cls_dynptr_slice_rdwr,
 			    skel->progs.ing_cls_dynptr_slice,
 			    skel->maps.test_result);
+	if (test__start_subtest("dynptr_offset"))
+		test_tuntap(skel->progs.ing_xdp_zalloc_meta,
+			    skel->progs.ing_cls_dynptr_offset_wr,
+			    skel->progs.ing_cls_dynptr_offset_rd,
+			    skel->maps.test_result);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index e7879860f403..8f61aa997f74 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -122,6 +122,79 @@ int ing_cls_dynptr_slice_rdwr(struct __sk_buff *ctx)
 	return TC_ACT_UNSPEC; /* pass */
 }
 
+/*
+ * Read skb metadata in chunks from various offsets in different ways.
+ */
+SEC("tc")
+int ing_cls_dynptr_offset_rd(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+	const __u32 chunk_len = META_SIZE / 4;
+	const __u32 zero = 0;
+	__u8 *dst, *src;
+
+	dst = bpf_map_lookup_elem(&test_result, &zero);
+	if (!dst)
+		return TC_ACT_SHOT;
+
+	/* 1. Regular read */
+	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+	bpf_dynptr_read(dst, chunk_len, &meta, 0, 0);
+	dst += chunk_len;
+
+	/* 2. Read from an offset-adjusted dynptr */
+	bpf_dynptr_adjust(&meta, chunk_len, bpf_dynptr_size(&meta));
+	bpf_dynptr_read(dst, chunk_len, &meta, 0, 0);
+	dst += chunk_len;
+
+	/* 3. Read at an offset */
+	bpf_dynptr_read(dst, chunk_len, &meta, chunk_len, 0);
+	dst += chunk_len;
+
+	/* 4. Read from a slice starting at an offset */
+	src = bpf_dynptr_slice(&meta, 2 * chunk_len, NULL, chunk_len);
+	if (!src)
+		return TC_ACT_SHOT;
+	__builtin_memcpy(dst, src, chunk_len);
+
+	return TC_ACT_SHOT;
+}
+
+/* Write skb metadata in chunks at various offsets in different ways. */
+SEC("tc")
+int ing_cls_dynptr_offset_wr(struct __sk_buff *ctx)
+{
+	const __u32 chunk_len = META_SIZE / 4;
+	__u8 payload[META_SIZE];
+	struct bpf_dynptr meta;
+	__u8 *dst, *src;
+
+	bpf_skb_load_bytes(ctx, sizeof(struct ethhdr), payload, sizeof(payload));
+	src = payload;
+
+	/* 1. Regular write */
+	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+	bpf_dynptr_write(&meta, 0, src, chunk_len, 0);
+	src += chunk_len;
+
+	/* 2. Write to an offset-adjusted dynptr */
+	bpf_dynptr_adjust(&meta, chunk_len, bpf_dynptr_size(&meta));
+	bpf_dynptr_write(&meta, 0, src, chunk_len, 0);
+	src += chunk_len;
+
+	/* 3. Write at an offset */
+	bpf_dynptr_write(&meta, chunk_len, src, chunk_len, 0);
+	src += chunk_len;
+
+	/* 4. Write to a slice starting at an offset */
+	dst = bpf_dynptr_slice_rdwr(&meta, 2 * chunk_len, NULL, chunk_len);
+	if (!dst)
+		return TC_ACT_SHOT;
+	__builtin_memcpy(dst, src, chunk_len);
+
+	return TC_ACT_UNSPEC; /* pass */
+}
+
 /* Reserve and clear space for metadata but don't populate it */
 SEC("xdp")
 int ing_xdp_zalloc_meta(struct xdp_md *ctx)

-- 
2.43.0


