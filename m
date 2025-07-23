Return-Path: <bpf+bounces-64201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C16B0F979
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 19:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8B41655CB
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 17:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7993D246779;
	Wed, 23 Jul 2025 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bhVFvens"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1710B242D70
	for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292226; cv=none; b=CSEaLAIIuRGlsU9ipcRG2Z+Tw9uP5PKBf9uD/2YOaom5rzlyqWu59JjjH9OVb17ifRmP04iSO/5L4dvPYytbUHGx7us7NG+0U5b+zxfWHSeSbnxV+jyqD2o28Duau21NAd0dgbjriHPeXXhUHhENLsqhWqp2FrCDEH/kIf/0RPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292226; c=relaxed/simple;
	bh=ZdWC8dc9bcf9bebUOUUL6dsSV4GwxjE/zf3sMRTdS8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pn/WnFlXeJ1Dbjz7v52B/RPs2oxBMtncw3mTnq/RBLVbnSRtZV5/+Y1U37EWbRtnDn/++8MOIjMvkM2L8EiFMx6XmrCWlpxZjfiuQ/+8m8DSqBkjnHJduxotELmOXnmSWk62qp7YMj6TLcvzyyfEOBFGCfhKueouL7IX2R8uPkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bhVFvens; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so223123a12.2
        for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 10:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753292223; x=1753897023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8pB8VN9MFwmxNix8cyZZQ7rAZN5StauQsln4/SihEow=;
        b=bhVFvens+T2RElXV02/pA/Ix3N7YkjKdcgaAjAbyurMoLXP2tdYPAZfQYAqlcJhVva
         iOXX+FG7RYYnBZL6Bc5Cm/iiD+AdLseOxizN/hCW7ogGXEN2i27orPtNq3MBwGremrcA
         0ClFqUo0eHQlCiGIDBuHvJPiZgDfB5XOfWfQx8SjXQpzeqfy4XFY4sd4wp360N45APVe
         OjvP4t+8C8kzr9mfSGg0sedTA8pak6PbycJia/ylMEtgQ5IEEFnty66YtaE6hRGi66vf
         cf+PR/OiF6WI/RruQu+Djga2NtOxQdoY7Nzl3j6UAwzFcNN2rG5yN2/rsazM6wPw3AGy
         8x7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753292223; x=1753897023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pB8VN9MFwmxNix8cyZZQ7rAZN5StauQsln4/SihEow=;
        b=RTr1hKDsrgTSAK+WX0EVHyhAw/HEVHtFY7CteyGfBsNhLM0C2llLptDw6ur10AMU92
         cK1qPBhImlqTFy01ZD6RdLnYovyVZLeeGfja7ttU6+Rr1/CjSNJmL0chslw3wQwGfdx0
         jdgzVi1bvtKtPAdcZ5lWCqH4OOuYj1ZskX/7i+ZXRnfWFDG3bwDCuvtxnGtiVTHYmKKT
         Pm6g65HlV7UBOpoWRu/98zmgJupaFVol5mzt9twMdSc34eYRaWmhw7VN/wLqI1MhpVas
         3wFUIvZ18RGLsl0qf864I0eBjOPEMof3g8/4cOpTS0HLTN5KvhR39phf8Ct+mvphrZVv
         tHjQ==
X-Gm-Message-State: AOJu0YzZhopC08gK7O6DpTihF1h/YpnRjsYjmX1OVEVgyVExqXial67Y
	2YWmrbXz9MeNPQQbVlr/TxiRnnEN6I9latD1BNeiEu7o9LkIq6hf9S4VEgj3uBVklUo=
X-Gm-Gg: ASbGnctwGJCoQN3WjGNzAYaUBXEkqqJ8HkpS9UvLMfs4mpDLNmz65hd4hzJ+RUYPvxP
	z1Fsa2L4zaAkjQ6W0OVDeuKiQJm0woEbZdHKgjDIQ+wz/PAeLn9CXMP4pT5vYUqhk5TKH1Chy3M
	/6LhR4HdBAoPSsuZWhAAmm33EEwRjqOhHyqmAqNPnz0oejwCYnitw3AjneQK53uQL9OOdJJz5BC
	onuv4R5o67aDa8swJ56TW0OFiKY7Y5zKdQa4CeUTuV+TKlSyRbKni7jx9tt9caC8ad9AIlHqbpO
	DBkA4+6j2RlHlM4GuZ918NO76Cw8kEtXs6RpLTlBTajSGdmA8q3b0TiW7eQRVyHMPtZs5Mhaul7
	r96qPeQyazA0bdEE1IBodN9o9TUsojxVceL6OeUtaT97kEgwupuvxXWj4EZRGslaR9R+MRXz19u
	ZhN5zvbA==
X-Google-Smtp-Source: AGHT+IGai89R6Ps0k0EIfh0snFvrHiImQej3jQTU2YfE1WOBBREIaHq0IVK1tOMChMgVom+Idr6t+A==
X-Received: by 2002:a05:6402:34c4:b0:612:dc41:c622 with SMTP id 4fb4d7f45d1cf-6149b42ee6fmr3572877a12.9.1753292222524;
        Wed, 23 Jul 2025 10:37:02 -0700 (PDT)
Received: from cloudflare.com (79.184.149.187.ipv4.supernova.orange.pl. [79.184.149.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f36f6bsm8809654a12.27.2025.07.23.10.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 10:37:01 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 23 Jul 2025 19:36:53 +0200
Subject: [PATCH bpf-next v4 8/8] selftests/bpf: Cover read/write to skb
 metadata at an offset
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-skb-metadata-thru-dynptr-v4-8-a0fed48bcd37@cloudflare.com>
References: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
In-Reply-To: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
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


