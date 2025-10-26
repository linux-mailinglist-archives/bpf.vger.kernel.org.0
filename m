Return-Path: <bpf+bounces-72243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CB3C0A9A2
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 15:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DCE3B1E53
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 14:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486252EB5B9;
	Sun, 26 Oct 2025 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UoMpqz8N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EAB2EA486
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488337; cv=none; b=lyhg/HekbMVBgtSjoGXnQmXsziMyFuXWQkVZ0o+klrCeeJ2oUtVym+ONZJbNlnmMIeXnYr2/irKHFPUQXZz+RdIZNfVYEY+TdS/DRaHnrczSeEjD1UoSgVYQIGlziRcSR3ose6hX1E173Vh+wj3F4ea2FpxOC6CQ3LBDDECYKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488337; c=relaxed/simple;
	bh=rMAOddCnwpQMRpzHFuKexeU7cSR3uEoOGKv1P7BBOPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WKTzspXYHNp2OoAuDRtZ/Lo5t/pMqiFpHtv4Ls2kLsAmaQFBDYBg2USuk7Cc8/mSMuhRsxO28C1jPAt2cg6Em0MdtVp87+PrfASj1wOyzuLPnBCn4UK6Wm1VQfK8rC67rBbICFwZeTYs9rcvGDrqtCNOXoiEEoMM+dHZPY3G314=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UoMpqz8N; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b472842981fso507883366b.1
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 07:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488334; x=1762093134; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxUmsCmg+F1fck+zVSrF1/SNIEdF36QqL9+DX1Du6rA=;
        b=UoMpqz8NTnbQBpmpo407CWDOsZEeKDyjAwgRgKTvoYjxEIAVI3/zffoQ46I8GMxuYO
         TkWR172OE4VjDXxp7yDvZS/TfRVPSciugiRP4/1bXReZa+ervuWxKJgrN28BFPYbC4Xw
         I4Ng1Np8toc7okCnZ/LjGwIPNLyYGfNepaqfNQlTvgZgLJOZiOouVl18q0fe4wZjlzze
         5u8vWyR8OpDdH8tzBlCJT882XXvE1uYAVlgWWv8n3FnqEsjaqAsWyyHdUNRjGkyj92A3
         10s5XOjiNmBMcxW2TxX7BYTPe1gadtPsrgoGJzgK/5hBnUb9yroNywo/06RFBGtx3t+B
         qGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488334; x=1762093134;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxUmsCmg+F1fck+zVSrF1/SNIEdF36QqL9+DX1Du6rA=;
        b=G20EhI7VfvFEydrfTbLbdkqsKjeda+1Lzlof+hAN+N83xCZucildgYo+TIHZ9kKcu6
         Ng7EVelMXo0jo7Vcsm9q0czLm5pgeDEPbodouBYNgSZdlR0FH95K0qY4JZjAkpLa0ZVj
         +1/kIUIERvXoYGjoKNXXV+cPIxqD9i3tNixWw5yjDIAojwk99tN8lJWOZGlSCfu+8JU5
         9/T/Tumv0V8A4OuBr22CVZgIA63e8FR+8A268u5qDkzPMeKKrx4cq5HiO4unvJhzgONC
         NlDZha8EcHFWQq2K+pU84R5zZ4RlVaaCueV/URb+IoAFWbM8RYdFtQBZ3rmbKNqjE+uN
         Iy3g==
X-Gm-Message-State: AOJu0YzCe85hcs+vEmxJG9VBPNf2ecx0OQK71N6V4dcmiM/IF6fjLvmj
	pFvaV/egyM4+G1zhVAOwjdb2JkSKgTkxWpruH4NkQgHZPNYQdE8/XjgibEaGGvH9sF4=
X-Gm-Gg: ASbGncvp322CzqH7Vrj3QSdjBwhRhyn0rsKBWOuiD6l3tJ6/hZRc5OYfU5kGM1Z5rhX
	N6Gto9aFTT2zxh2nYZ8Z4y8LlB/SIdYKRedpqYISQWjswuCUoq7K6WVi5PKi70cBE5gIgRX/L8o
	Lt+0wipfULYdfuChe3ak6HJCf5r6Mox+fINV6dV9qYQwT7qRj3bnMI6ViLIDO6gvz7F5KzBGotU
	eW5CrtGrFDbQrOxnAOsZik0s1YxSX7MgYe07SpPbHqck8L0VudFrKSdtbyujw86xAbFBwCo7CeQ
	1HstYnmMfM+T6/8hXj4DARZ6qW2WB70WiOr/Yg6PVFEWiVRm6HcxrDu+PdzuTVb9CSrOoRorDIh
	LQq5+ZJ+wUuAHLNbmQWXPaUvDvvvCCiq+e5iWPquWBnBS0JfLqlmyI1GfW6VvN2Kut93SVlzln2
	DbN0No4PEQIlpmry9R2M+5eqwEFFFUCqMxWc6lLLcPnwgSoN0C0FQP26VDDV608D2sK6M=
X-Google-Smtp-Source: AGHT+IGrfXymyKwITdCzYd+9tEH7x/ATpznC1Oj9S6quvxny+ieR8DEw0HjIDza5oocBCTwGcyZwCg==
X-Received: by 2002:a17:907:3e8d:b0:b6d:7db1:49aa with SMTP id a640c23a62f3a-b6d7db14fffmr733004466b.63.1761488333928;
        Sun, 26 Oct 2025 07:18:53 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85398463sm464594266b.34.2025.10.26.07.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:53 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:32 +0100
Subject: [PATCH bpf-next v3 12/16] selftests/bpf: Expect unclone to
 preserve skb metadata
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-12-37cceebb95d3@cloudflare.com>
References: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
In-Reply-To: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Since pskb_expand_head() no longer clears metadata on unclone, update tests
for cloned packets to expect metadata to remain intact.

Also simplify the clone_dynptr_kept_on_{data,meta}_slice_write tests.
Creating an r/w dynptr slice is sufficient to trigger an unclone in the
prologue, so remove the extraneous writes to the data/meta slice.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          |  24 ++---
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 118 ++++++++++++---------
 2 files changed, 79 insertions(+), 63 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index db3027564261..a129c3057202 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -454,29 +454,29 @@ void test_xdp_context_tuntap(void)
 			    skel->progs.ing_cls_dynptr_offset_oob,
 			    skel->progs.ing_cls,
 			    &skel->bss->test_pass);
-	if (test__start_subtest("clone_data_meta_empty_on_data_write"))
+	if (test__start_subtest("clone_data_meta_survives_data_write"))
 		test_tuntap_mirred(skel->progs.ing_xdp,
-				   skel->progs.clone_data_meta_empty_on_data_write,
+				   skel->progs.clone_data_meta_survives_data_write,
 				   &skel->bss->test_pass);
-	if (test__start_subtest("clone_data_meta_empty_on_meta_write"))
+	if (test__start_subtest("clone_data_meta_survives_meta_write"))
 		test_tuntap_mirred(skel->progs.ing_xdp,
-				   skel->progs.clone_data_meta_empty_on_meta_write,
+				   skel->progs.clone_data_meta_survives_meta_write,
 				   &skel->bss->test_pass);
-	if (test__start_subtest("clone_dynptr_empty_on_data_slice_write"))
+	if (test__start_subtest("clone_meta_dynptr_survives_data_slice_write"))
 		test_tuntap_mirred(skel->progs.ing_xdp,
-				   skel->progs.clone_dynptr_empty_on_data_slice_write,
+				   skel->progs.clone_meta_dynptr_survives_data_slice_write,
 				   &skel->bss->test_pass);
-	if (test__start_subtest("clone_dynptr_empty_on_meta_slice_write"))
+	if (test__start_subtest("clone_meta_dynptr_survives_meta_slice_write"))
 		test_tuntap_mirred(skel->progs.ing_xdp,
-				   skel->progs.clone_dynptr_empty_on_meta_slice_write,
+				   skel->progs.clone_meta_dynptr_survives_meta_slice_write,
 				   &skel->bss->test_pass);
-	if (test__start_subtest("clone_dynptr_rdonly_before_data_dynptr_write"))
+	if (test__start_subtest("clone_meta_dynptr_rw_before_data_dynptr_write"))
 		test_tuntap_mirred(skel->progs.ing_xdp,
-				   skel->progs.clone_dynptr_rdonly_before_data_dynptr_write,
+				   skel->progs.clone_meta_dynptr_rw_before_data_dynptr_write,
 				   &skel->bss->test_pass);
-	if (test__start_subtest("clone_dynptr_rdonly_before_meta_dynptr_write"))
+	if (test__start_subtest("clone_meta_dynptr_rw_before_meta_dynptr_write"))
 		test_tuntap_mirred(skel->progs.ing_xdp,
-				   skel->progs.clone_dynptr_rdonly_before_meta_dynptr_write,
+				   skel->progs.clone_meta_dynptr_rw_before_meta_dynptr_write,
 				   &skel->bss->test_pass);
 
 	test_xdp_meta__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 74d7e2aab2ef..ee89e1124cd8 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -321,12 +321,13 @@ int ing_xdp(struct xdp_md *ctx)
 }
 
 /*
- * Check that skb->data_meta..skb->data is empty if prog writes to packet
- * _payload_ using packet pointers. Applies only to cloned skbs.
+ * Check that, when operating on a cloned packet, skb->data_meta..skb->data is
+ * kept intact if prog writes to packet _payload_ using packet pointers.
  */
 SEC("tc")
-int clone_data_meta_empty_on_data_write(struct __sk_buff *ctx)
+int clone_data_meta_survives_data_write(struct __sk_buff *ctx)
 {
+	__u8 *meta_have = ctx_ptr(ctx, data_meta);
 	struct ethhdr *eth = ctx_ptr(ctx, data);
 
 	if (eth + 1 > ctx_ptr(ctx, data_end))
@@ -335,8 +336,10 @@ int clone_data_meta_empty_on_data_write(struct __sk_buff *ctx)
 	if (eth->h_proto != 0)
 		goto out;
 
-	/* Expect no metadata */
-	if (ctx->data_meta != ctx->data)
+	if (meta_have + META_SIZE > eth)
+		goto out;
+
+	if (!check_metadata(meta_have))
 		goto out;
 
 	/* Packet write to trigger unclone in prologue */
@@ -348,14 +351,14 @@ int clone_data_meta_empty_on_data_write(struct __sk_buff *ctx)
 }
 
 /*
- * Check that skb->data_meta..skb->data is empty if prog writes to packet
- * _metadata_ using packet pointers. Applies only to cloned skbs.
+ * Check that, when operating on a cloned packet, skb->data_meta..skb->data is
+ * kept intact if prog writes to packet _metadata_ using packet pointers.
  */
 SEC("tc")
-int clone_data_meta_empty_on_meta_write(struct __sk_buff *ctx)
+int clone_data_meta_survives_meta_write(struct __sk_buff *ctx)
 {
+	__u8 *meta_have = ctx_ptr(ctx, data_meta);
 	struct ethhdr *eth = ctx_ptr(ctx, data);
-	__u8 *md = ctx_ptr(ctx, data_meta);
 
 	if (eth + 1 > ctx_ptr(ctx, data_end))
 		goto out;
@@ -363,25 +366,29 @@ int clone_data_meta_empty_on_meta_write(struct __sk_buff *ctx)
 	if (eth->h_proto != 0)
 		goto out;
 
-	if (md + 1 > ctx_ptr(ctx, data)) {
-		/* Expect no metadata */
-		test_pass = true;
-	} else {
-		/* Metadata write to trigger unclone in prologue */
-		*md = 42;
-	}
+	if (meta_have + META_SIZE > eth)
+		goto out;
+
+	if (!check_metadata(meta_have))
+		goto out;
+
+	/* Metadata write to trigger unclone in prologue */
+	*meta_have = 42;
+
+	test_pass = true;
 out:
 	return TC_ACT_SHOT;
 }
 
 /*
- * Check that skb_meta dynptr is writable but empty if prog writes to packet
- * _payload_ using a dynptr slice. Applies only to cloned skbs.
+ * Check that, when operating on a cloned packet, metadata remains intact if
+ * prog creates a r/w slice to packet _payload_.
  */
 SEC("tc")
-int clone_dynptr_empty_on_data_slice_write(struct __sk_buff *ctx)
+int clone_meta_dynptr_survives_data_slice_write(struct __sk_buff *ctx)
 {
 	struct bpf_dynptr data, meta;
+	__u8 meta_have[META_SIZE];
 	struct ethhdr *eth;
 
 	bpf_dynptr_from_skb(ctx, 0, &data);
@@ -392,29 +399,26 @@ int clone_dynptr_empty_on_data_slice_write(struct __sk_buff *ctx)
 	if (eth->h_proto != 0)
 		goto out;
 
-	/* Expect no metadata */
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
-	if (bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) > 0)
+	bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0);
+	if (!check_metadata(meta_have))
 		goto out;
 
-	/* Packet write to trigger unclone in prologue */
-	eth->h_proto = 42;
-
 	test_pass = true;
 out:
 	return TC_ACT_SHOT;
 }
 
 /*
- * Check that skb_meta dynptr is writable but empty if prog writes to packet
- * _metadata_ using a dynptr slice. Applies only to cloned skbs.
+ * Check that, when operating on a cloned packet, metadata remains intact if
+ * prog creates an r/w slice to packet _metadata_.
  */
 SEC("tc")
-int clone_dynptr_empty_on_meta_slice_write(struct __sk_buff *ctx)
+int clone_meta_dynptr_survives_meta_slice_write(struct __sk_buff *ctx)
 {
 	struct bpf_dynptr data, meta;
 	const struct ethhdr *eth;
-	__u8 *md;
+	__u8 *meta_have;
 
 	bpf_dynptr_from_skb(ctx, 0, &data);
 	eth = bpf_dynptr_slice(&data, 0, NULL, sizeof(*eth));
@@ -424,16 +428,13 @@ int clone_dynptr_empty_on_meta_slice_write(struct __sk_buff *ctx)
 	if (eth->h_proto != 0)
 		goto out;
 
-	/* Expect no metadata */
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
-	if (bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) > 0)
+	meta_have = bpf_dynptr_slice_rdwr(&meta, 0, NULL, META_SIZE);
+	if (!meta_have)
 		goto out;
 
-	/* Metadata write to trigger unclone in prologue */
-	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
-	md = bpf_dynptr_slice_rdwr(&meta, 0, NULL, sizeof(*md));
-	if (md)
-		*md = 42;
+	if (!check_metadata(meta_have))
+		goto out;
 
 	test_pass = true;
 out:
@@ -441,14 +442,17 @@ int clone_dynptr_empty_on_meta_slice_write(struct __sk_buff *ctx)
 }
 
 /*
- * Check that skb_meta dynptr is read-only before prog writes to packet payload
- * using dynptr_write helper. Applies only to cloned skbs.
+ * Check that, when operating on a cloned packet, skb_meta dynptr is read-write
+ * before prog writes to packet _payload_ using dynptr_write helper and metadata
+ * remains intact before and after the write.
  */
 SEC("tc")
-int clone_dynptr_rdonly_before_data_dynptr_write(struct __sk_buff *ctx)
+int clone_meta_dynptr_rw_before_data_dynptr_write(struct __sk_buff *ctx)
 {
 	struct bpf_dynptr data, meta;
+	__u8 meta_have[META_SIZE];
 	const struct ethhdr *eth;
+	int err;
 
 	bpf_dynptr_from_skb(ctx, 0, &data);
 	eth = bpf_dynptr_slice(&data, 0, NULL, sizeof(*eth));
@@ -458,17 +462,20 @@ int clone_dynptr_rdonly_before_data_dynptr_write(struct __sk_buff *ctx)
 	if (eth->h_proto != 0)
 		goto out;
 
-	/* Expect read-only metadata before unclone */
+	/* Expect read-write metadata before unclone */
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
-	if (!bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) != META_SIZE)
+	if (bpf_dynptr_is_rdonly(&meta))
+		goto out;
+
+	err = bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0);
+	if (err || !check_metadata(meta_have))
 		goto out;
 
 	/* Helper write to payload will unclone the packet */
 	bpf_dynptr_write(&data, offsetof(struct ethhdr, h_proto), "x", 1, 0);
 
-	/* Expect no metadata after unclone */
-	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
-	if (bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) != 0)
+	err = bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0);
+	if (err || !check_metadata(meta_have))
 		goto out;
 
 	test_pass = true;
@@ -477,14 +484,17 @@ int clone_dynptr_rdonly_before_data_dynptr_write(struct __sk_buff *ctx)
 }
 
 /*
- * Check that skb_meta dynptr is read-only if prog writes to packet
- * metadata using dynptr_write helper. Applies only to cloned skbs.
+ * Check that, when operating on a cloned packet, skb_meta dynptr is read-write
+ * before prog writes to packet _metadata_ using dynptr_write helper and
+ * metadata remains intact before and after the write.
  */
 SEC("tc")
-int clone_dynptr_rdonly_before_meta_dynptr_write(struct __sk_buff *ctx)
+int clone_meta_dynptr_rw_before_meta_dynptr_write(struct __sk_buff *ctx)
 {
 	struct bpf_dynptr data, meta;
+	__u8 meta_have[META_SIZE];
 	const struct ethhdr *eth;
+	int err;
 
 	bpf_dynptr_from_skb(ctx, 0, &data);
 	eth = bpf_dynptr_slice(&data, 0, NULL, sizeof(*eth));
@@ -494,14 +504,20 @@ int clone_dynptr_rdonly_before_meta_dynptr_write(struct __sk_buff *ctx)
 	if (eth->h_proto != 0)
 		goto out;
 
-	/* Expect read-only metadata */
+	/* Expect read-write metadata before unclone */
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
-	if (!bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) != META_SIZE)
+	if (bpf_dynptr_is_rdonly(&meta))
 		goto out;
 
-	/* Metadata write. Expect failure. */
-	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
-	if (bpf_dynptr_write(&meta, 0, "x", 1, 0) != -EINVAL)
+	err = bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0);
+	if (err || !check_metadata(meta_have))
+		goto out;
+
+	/* Helper write to metadata will unclone the packet */
+	bpf_dynptr_write(&meta, 0, &meta_have[0], 1, 0);
+
+	err = bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0);
+	if (err || !check_metadata(meta_have))
 		goto out;
 
 	test_pass = true;

-- 
2.43.0


