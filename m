Return-Path: <bpf+bounces-63907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE14B0C1C9
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 12:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682103B33FC
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 10:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9446A295511;
	Mon, 21 Jul 2025 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fCKJB0wX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A602294A06
	for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 10:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095223; cv=none; b=g9Mj1q4T2BXDngEwx4BvppYrugmVJD/A/S31J8h0hq/Oeq24SCqngc6NSdh3dH3Fg08+pWRVtnJtAH5CqMcfiDJzOdXDyzdifNVy2t2hTuqpfcWZ3zEQqW+t0m3/XlSwoD1/OSw2TKZ/UddcVqAKy+CYfxWgIDk0E/rdv5WPGpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095223; c=relaxed/simple;
	bh=duMKK44JnKpe4MGN8M6YKC4qDTC52JONh/TP9d9AdL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ew8uCnFnuhpXfYYCuXMJfAhi5AsdFlZRKIR6hLc7tbk4TOVByjmtzq+lKpz+aFEIddcTu1nsH6JwdbbtqG4rLM+ZmwYVelDHJL1etKEmIwmN/xmkc9hjAyZnGogK2+BHx3HPsheNeHH/hsDph3yGsvOku30nfAtaXJtR9BSnO/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fCKJB0wX; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-612a8e6f675so6032935a12.3
        for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 03:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753095220; x=1753700020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvuGGpBWHPa+xyjonBcXXcpvK68Zk52Wi7ziORp+6ao=;
        b=fCKJB0wXFagYmy1Rov8SNNaQLjZWL/M2JC5yJpV/aVRp3kdpQDAhTgj3SViR2ExHo4
         I2tIPDA6J7tV6BuIBnYoB8BbSOzUzDhDRF5a8Gz0HHq+9CYWcjxk06dXUjXIQACkERZb
         fTaNAsz0zz5HtOVwuqxJutqtT7yoxO38GwgAbrH7a4UbCTzc6oSuaFSl0neORWYP5YCU
         VejAWnIB8Dc/lGvrYrGI6f3r9BqrFU3nfOEZsA3HKpmOCwrW+VPc441BVYL8EkhRYSEc
         YIGCnRQnRpXr3hQ3MxSkzgMWPdsXvWdoUQYGNmZHFst7lROGnmXD+K6/LCFVYSfmAfSF
         GVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753095220; x=1753700020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvuGGpBWHPa+xyjonBcXXcpvK68Zk52Wi7ziORp+6ao=;
        b=nuaZPfLE78Hg1gzPl2Pr+3gHH1986fxtgDaqXBBoVZ63os67PVAJAj/YuOZXDxBOmF
         K1b8H3uVh8qPcHuQ167YpqFDWIqX69aj1l6zdF59VWsB5m3aBqkpaLxAJTp/Ia/lpd95
         tmOz8yJYmsNeNi/z53T9yfPlJe8ytMW4yAIkth0v9utxX8bWYdtIaDoRDx2OTELfgS4m
         NEjoISW5U+SbaX+xaGV1GhZX1F1u6L/2KR34hPW3TCd5/iUrJcHA8DjjXgCP3lKpDav0
         Th3nkjRhAHw6MEQiklIwlFY1IP3ms5pBjql27OVazUs5jRRwiY5ZZLmZaCsXB8kJXG8Y
         i1Iw==
X-Gm-Message-State: AOJu0YzLluVxlNbEjW3ie6FYXmpd5+Vtt+iC/Xw7AnYGFb6knniai6eB
	dYb7qq2D6DQ14vnmWEmYxjebWzcElOE+TN/EP5YKWX4MITsq/k6mSjMCIrtOMskcsxQ=
X-Gm-Gg: ASbGncu2jIzReaGijTuRarCrmqDREAbyic+BtOLPLH4RqhPyCvR8UivsORWAzPqoGfe
	EINlsX2KFsV7yj05Z3dwUw/pBI/5S9x48YGvDdKgOJZjjk85K1LyK7jkvylkLbnSynKI6Sfx9Xs
	HP3BpmZ2HAO7P3FhJvjosgXrPRRlyEfH8UMghN+wiLGyUAY5iuud+vR/emPHndSsM6WaiAyaxxv
	A8l4wuSK24mahPd7Kr2TQpoAktsGd9SMUWeskOWwmkMlYivzURNKk6qn9kk1ju2ZHSpaDpEJPvr
	9gY6N/jmqGuy4viP7YfHZkXGH7Td2t2d7+Z7a3GJeTm2tXHDHtZrEGeW+rsm7wpV7tWAQ+K1WFQ
	HqTPSLyOpmH8Glw==
X-Google-Smtp-Source: AGHT+IFAoidyNVqKZ7GAejKUZ+B0AVj6CgjEFfUPywn4GX2Om1tQCrB3MkvYFjo6kxay0MG6toDHew==
X-Received: by 2002:a17:906:c105:b0:ae4:107f:dba2 with SMTP id a640c23a62f3a-ae9cddf128dmr1900275066b.13.1753095219671;
        Mon, 21 Jul 2025 03:53:39 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca2f19csm652127766b.70.2025.07.21.03.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:53:38 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 21 Jul 2025 12:52:48 +0200
Subject: [PATCH bpf-next v3 10/10] selftests/bpf: Cover read/write to skb
 metadata at an offset
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-skb-metadata-thru-dynptr-v3-10-e92be5534174@cloudflare.com>
References: <20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
In-Reply-To: <20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>, 
 Stanislav Fomichev <sdf@fomichev.me>
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


