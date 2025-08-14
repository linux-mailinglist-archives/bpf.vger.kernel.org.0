Return-Path: <bpf+bounces-65630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76091B261D6
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 12:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB191BC58B0
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 10:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC772FDC28;
	Thu, 14 Aug 2025 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Rfofjw1H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244F52FD7A5
	for <bpf@vger.kernel.org>; Thu, 14 Aug 2025 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165608; cv=none; b=WHejq4cP3frl5BBZVUj/dGEOxnciR9m9nD74OF5mQFoTxi6npy/Vn7A3kVp260/4tOzdw36MmqAfnj5pV1QAyvusL8Q9chgnq2izl5lXU4pm4wqxjbONc7I34Y7/i/agXL++ldGG/By46xMOcG8F/3sn8LMWe1W1cnUmmWa2Uf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165608; c=relaxed/simple;
	bh=6Q0K1QIZOOFau5ZctzVpe7zO1m+/DOuCPLw8+uCeHKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A6zZ0OmaH8/gOZLzVKwl7wjTrk+JK4KHq+x02XeNyuU73gU7BV9XD1iPdf585MjoTr7b1ThcvUVfyWIbjEmsyIhQBOh+EQ7ofPkpJ2Uk4PlAkSOG6N14feAgyr/iR0qpjqpfnvAv8LoYyScyYLJ+5cQomfEhjvGGHfiOz4x99s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Rfofjw1H; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7a0550cso126596266b.2
        for <bpf@vger.kernel.org>; Thu, 14 Aug 2025 03:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755165605; x=1755770405; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZ04Y6i2iJ0+tBid0GHRu2U+46Amz8TcC4hTojaCtjc=;
        b=Rfofjw1H/YIPvjYZj7lT4C3FQ7VTOHKyGoxwQ5e1akdHz1iYLELQ1AF5jY++TO8rEy
         x2m5tSFuzdapQW9yDlUvMl92GjNgkitgmLTFWSZ5K7/muDg+LdTlKbg7+X02twKAuXtE
         TIGCpq+DfluUfQz2ZcQugy0RgwYQdLE0Lcnrk2R3BIKvbcKE+AR0jWhyiVxitZapap19
         /Vi1ToFlPFNjQZq3FwPrG68kD3PEKLkyWXWgTHiRJzYGi/Jl3oFrtRf5tbFljgQ3HvGx
         pWF3ZUCADFFicF8UPa+1+1MmNGL2g3CX1OuuglSoS/eGJGn+kr7j7q8Q4pLX2mBfE+ry
         YsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755165605; x=1755770405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZ04Y6i2iJ0+tBid0GHRu2U+46Amz8TcC4hTojaCtjc=;
        b=VeJpCWSFHfrv2TDmCd1HSHTGcZRZLlXbCccWLbeQjAgiHgOrwkVwQeCn5w5G/Amboh
         MBHb15aIM6AhajteUHqE3l5ksNSwCFGmrpR5eMRc9GmgRVxHu6i/202Hm0Uix/VXPsWj
         TUZusXPJYOrmmoHVNJ0VZCVDEt1i/xWxFMG65oZ8D1GYwYzO+SjHV/KXG9sRprR5kEzy
         Mgc6kLsr8aEc8y1zlqmwIWztKN7sc2GxIiLb49+24yqmz/gT9YujncMimQsSsDm0qqE5
         Sl1B/8Pj4feV52TGiu29G1tdozAybs3612yU/YbNceGtKb/B3fLIPLTAByYjuCwmtEjv
         RjgA==
X-Gm-Message-State: AOJu0YxuEcUqrCUXTcwvfy+lQlESzQsA/9tuyblZyD4JBY5fDBiNFR9S
	AGX9WrqhqDXPEBfwCFXcYahhgSkh21XpPhJWG6w3Y9Jc3ymHbnnfWY3Zel9XHMSwuVM=
X-Gm-Gg: ASbGnctq1njFQUjDFAKCuh4My2p12CDNbBNQcJJqHFE2duUMFIeHA2Za4+VNRR/+GuO
	RWodwzvzt7zaJvuyfhanZPtPE7weiLalC1QoPTBFQ56fiq0Kc/oUpAw0UlK1K5vGMgflAwL6EUh
	h94UTCmCa9lz7akwByejmO+ewZ6r6EstLnoThf8Fle2G/E6ESlH6Dnw5Bu03TUmQl3wrMntwuwy
	m5TwJqauVne/yCZSPFC+DXVRurST6plTldfqX24TJTXqufokaZQCghbOGck+poAuhpznbegpTbK
	bkF6xfBMymHJMfVLggPaTidjMmL6/TrHB1u+1xdxUWGCdAdtx4fpY8VEq8n9Sl9YsadeWNrT1Wi
	yCChQQoei8niRgBQ=
X-Google-Smtp-Source: AGHT+IGJYs39Lx1DfMVweyVUICM0ojnvYxtOHEqMlMDosKbzmlDjObPVtDfYY/qwD/iPLbdOZZHBWQ==
X-Received: by 2002:a17:907:3f25:b0:ae3:7022:b210 with SMTP id a640c23a62f3a-afcbe02bd50mr200184666b.12.1755165601075;
        Thu, 14 Aug 2025 03:00:01 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:f6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c0f4sm2545627866b.106.2025.08.14.03.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:00:00 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 14 Aug 2025 11:59:34 +0200
Subject: [PATCH bpf-next v7 8/9] selftests/bpf: Cover read/write to skb
 metadata at an offset
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-skb-metadata-thru-dynptr-v7-8-8a39e636e0fb@cloudflare.com>
References: <20250814-skb-metadata-thru-dynptr-v7-0-8a39e636e0fb@cloudflare.com>
In-Reply-To: <20250814-skb-metadata-thru-dynptr-v7-0-8a39e636e0fb@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Eduard Zingerman <eddyz87@gmail.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Exercise r/w access to skb metadata through an offset-adjusted dynptr,
read/write helper with an offset argument, and a slice starting at an
offset.

Also check for the expected errors when the offset is out of bounds.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          |  10 ++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 119 +++++++++++++++++++++
 2 files changed, 129 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 79c4c58276e6..24a7b4b7fdb6 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -375,6 +375,16 @@ void test_xdp_context_tuntap(void)
 			    skel->progs.ing_cls_dynptr_slice_rdwr,
 			    skel->progs.ing_cls_dynptr_slice,
 			    skel->maps.test_result);
+	if (test__start_subtest("dynptr_offset"))
+		test_tuntap(skel->progs.ing_xdp_zalloc_meta,
+			    skel->progs.ing_cls_dynptr_offset_wr,
+			    skel->progs.ing_cls_dynptr_offset_rd,
+			    skel->maps.test_result);
+	if (test__start_subtest("dynptr_offset_oob"))
+		test_tuntap(skel->progs.ing_xdp,
+			    skel->progs.ing_cls_dynptr_offset_oob,
+			    skel->progs.ing_cls,
+			    skel->maps.test_result);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index e7879860f403..ee3d8adf5e9c 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1,5 +1,6 @@
 #include <stdbool.h>
 #include <linux/bpf.h>
+#include <linux/errno.h>
 #include <linux/if_ether.h>
 #include <linux/pkt_cls.h>
 
@@ -122,6 +123,124 @@ int ing_cls_dynptr_slice_rdwr(struct __sk_buff *ctx)
 	return TC_ACT_UNSPEC; /* pass */
 }
 
+/* Read skb metadata in chunks from various offsets in different ways. */
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
+/* Pass an OOB offset to dynptr read, write, adjust, slice. */
+SEC("tc")
+int ing_cls_dynptr_offset_oob(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+	__u8 md, *p;
+	int err;
+
+	err = bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+	if (err)
+		goto fail;
+
+	/* read offset OOB */
+	err = bpf_dynptr_read(&md, sizeof(md), &meta, META_SIZE, 0);
+	if (err != -E2BIG)
+		goto fail;
+
+	/* write offset OOB */
+	err = bpf_dynptr_write(&meta, META_SIZE, &md, sizeof(md), 0);
+	if (err != -E2BIG)
+		goto fail;
+
+	/* adjust end offset OOB */
+	err = bpf_dynptr_adjust(&meta, 0, META_SIZE + 1);
+	if (err != -ERANGE)
+		goto fail;
+
+	/* adjust start offset OOB */
+	err = bpf_dynptr_adjust(&meta, META_SIZE + 1, META_SIZE + 1);
+	if (err != -ERANGE)
+		goto fail;
+
+	/* slice offset OOB */
+	p = bpf_dynptr_slice(&meta, META_SIZE, NULL, sizeof(*p));
+	if (p)
+		goto fail;
+
+	/* slice rdwr offset OOB */
+	p = bpf_dynptr_slice_rdwr(&meta, META_SIZE, NULL, sizeof(*p));
+	if (p)
+		goto fail;
+
+	return TC_ACT_UNSPEC;
+fail:
+	return TC_ACT_SHOT;
+}
+
 /* Reserve and clear space for metadata but don't populate it */
 SEC("xdp")
 int ing_xdp_zalloc_meta(struct xdp_md *ctx)

-- 
2.43.0


