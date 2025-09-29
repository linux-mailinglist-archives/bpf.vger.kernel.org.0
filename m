Return-Path: <bpf+bounces-69960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7312ABA9802
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 16:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E541759A9
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 14:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA4230BF5A;
	Mon, 29 Sep 2025 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ICJCksc+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B3B30BB9C
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 14:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154977; cv=none; b=m2jPvfLgXiW+6dEV5gbqXcpcauXULXWE34eGpmjKA86lni2y4bpxr0cCURxBcfefcrf5wZX0bcOKGSYtMozO712CCL3Q1pRhIhDt5lfWRq0UEoJGySNT5R8iJ8GrWZGpkfBXUGiefyoxbCcBSyQ45266umPuFCkPgVnZkN7y4oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154977; c=relaxed/simple;
	bh=uClrBHYDm/Uygic+25dRH8YU2SO+kz7x7OV6Hh5pfAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u9EDo66c5br6dyta8SZVEBrQu/0yjgsGWhOyVIgMqw+IelAvrum4gJDJ4a1h1Wwtg+w38jfKIrBhcc81T59zVVinKbgUjANgJbNrkBkZOa1YIQHkO01BC8jwhYBeOc2SPiggZod64Tx/5TO80BUEm3diZSqbWZsDBhbujMBfoW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ICJCksc+; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3727611d76so648563466b.2
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 07:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1759154974; x=1759759774; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyuHlu34uB78cop0fIFW9VKAyQp9Lgnd/uCJqWdrqzI=;
        b=ICJCksc+taUPy9NRWWJpvHoKWuxWYFiMMJGN4o3ySbM4NdiwPFcVTEA1Kpzy3WVHxg
         dXXeQ1cv4L7PXrFiKeNnQEdmGJQrBpfY0fUP+UJMTH1S1lxucCLVnAXxGlq6Gwzk65xH
         Q1kgbp3QvgAnvcv2Z/y9tygpDLGmS2p0/+szOb5U1HJlpGnYtaNq05OPWl5conr8Fe8j
         IagVlalPnlJOwA4KpezCqX8/BAAhIhoIhPtZPmM2zANbxsXXRuWjZeANwFS0zGq6rhuH
         Xc+a2L49h9UVKcKW09YzbuedvEtmIqUF6KHshAWA5LV3unw8bLrFduLlA0ihg6fRL0Tw
         ysSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154974; x=1759759774;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyuHlu34uB78cop0fIFW9VKAyQp9Lgnd/uCJqWdrqzI=;
        b=baLdaqrYhVBratDCEpnQzKBW3664hERqDKIFRT0lxMwvO/W8o6hyjUxBaXhaSyXH+U
         MMKwjCa0N/VA87hHnjgGh1cIZUBoWAl/JLoSvZ6F2EBI7oNWkeZIr8U7MTw22QlTDKe/
         dFFMSSt8NhCLtIvVillIiVaT1A7SN2HGBnnh9/uNgJViaqEw4pW6fyAvL/VRLLBfKAZ+
         DZY+0WwLHkHR1CoaZhBHW0lYLQIAPK8W120eaGSPq+0BXRD8OhMH19ymBU99UyPbtlLV
         znPCx8mvDH+0WIodzwi0mNDu1o7tlZrUv1OL0UxCo42HJtobDCCOo47kmsaT3Ulux1HF
         zMCg==
X-Gm-Message-State: AOJu0Yz0vL+CWgR3TQjUwS+RNk83GBcy8J6dqfQhzgP9b+z/cP/EaDS6
	KVrqqbr6WCwSxoZW3vDR9uIgQNF8Ayu2FuT3mCNgZsmTwUHwaTpO5+hvQff/j8NygQM=
X-Gm-Gg: ASbGncu7sP1pvZ4lttI1R8Dhyk43EJVrvxEsRBwbMnbYA/ZeJb2gx2AKKn1Do1y7Jit
	gwpopbbB4ni9TTcVy1Y4UfRSic97vvEAt1J/O6UvyndggGAlDvHA7P5W2/vE+jwAwLrI+F4fJ14
	4bnW0jOcPsncEy9CDopio784gPJxKLyiemjDdx0H+ks6Ib1QyP455xwCbc68jzvA1ujFIxDs948
	WjeZKWOU8l5gjfzALJEqwU0oR6084+6f5wi+KgtnCVkescDXn4lap47Cm3hrFmnU2XSfwO6MO6k
	WAirxMTKz9rfeEsagS3ZmSCTv61g+MnZuhrx3JYrPHQmFt7J5aUjhMlCUrv/SouQOhynZ99MNVa
	CaHkURhC+99ET1n42+mNeaqEEswg4a2n3OnzxTYecI1ZdKXFk+GgijC2yqrcNFRUJzLUeO+UrxF
	LlvOdEKaQqSApfoC3Rk+iwKI6yjzRyqwVGQbA=
X-Google-Smtp-Source: AGHT+IEVauC2sgHSJJ7xcsJoPjXKEhEYVD+OrtNyZ+p7snUDYWI/hwOaqbvjKpkV9eX47O/tVfU/PQ==
X-Received: by 2002:a17:907:7e91:b0:b2a:dc08:592e with SMTP id a640c23a62f3a-b34bef96395mr1615837266b.49.1759154974186;
        Mon, 29 Sep 2025 07:09:34 -0700 (PDT)
Received: from cloudflare.com (79.184.145.122.ipv4.supernova.orange.pl. [79.184.145.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353efa494esm932915966b.25.2025.09.29.07.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:09:33 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 29 Sep 2025 16:09:14 +0200
Subject: [PATCH RFC bpf-next 9/9] selftests/bpf: Expect unclone to preserve
 metadata
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-skb-meta-rx-path-v1-9-de700a7ab1cb@cloudflare.com>
References: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
In-Reply-To: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Since pskb_expand_head() no longer clears metadata on unclone, update tests
for cloned packets to expect metadata to remain intact.

Verify metadata contents directly in the BPF program. This allows for
multiple checks as packet passes through a chain of BPF programs, rather
than a one-time check in user-space.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 20 ++---
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 94 +++++++++++++---------
 2 files changed, 66 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 178292d1251a..6fac79416b70 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -462,25 +462,25 @@ void test_xdp_context_tuntap(void)
 			    skel->progs.ing_cls_dynptr_offset_oob,
 			    skel->progs.ing_cls,
 			    skel->maps.test_result);
-	if (test__start_subtest("clone_data_meta_empty_on_data_write"))
+	if (test__start_subtest("clone_data_meta_kept_on_data_write"))
 		test_tuntap_mirred(skel->progs.ing_xdp,
-				   skel->progs.clone_data_meta_empty_on_data_write,
+				   skel->progs.clone_data_meta_kept_on_data_write,
 				   &skel->bss->test_pass);
-	if (test__start_subtest("clone_data_meta_empty_on_meta_write"))
+	if (test__start_subtest("clone_data_meta_kept_on_meta_write"))
 		test_tuntap_mirred(skel->progs.ing_xdp,
-				   skel->progs.clone_data_meta_empty_on_meta_write,
+				   skel->progs.clone_data_meta_kept_on_meta_write,
 				   &skel->bss->test_pass);
-	if (test__start_subtest("clone_dynptr_empty_on_data_slice_write"))
+	if (test__start_subtest("clone_dynptr_kept_on_data_slice_write"))
 		test_tuntap_mirred(skel->progs.ing_xdp,
-				   skel->progs.clone_dynptr_empty_on_data_slice_write,
+				   skel->progs.clone_dynptr_kept_on_data_slice_write,
 				   &skel->bss->test_pass);
-	if (test__start_subtest("clone_dynptr_empty_on_meta_slice_write"))
+	if (test__start_subtest("clone_dynptr_kept_on_meta_slice_write"))
 		test_tuntap_mirred(skel->progs.ing_xdp,
-				   skel->progs.clone_dynptr_empty_on_meta_slice_write,
+				   skel->progs.clone_dynptr_kept_on_meta_slice_write,
 				   &skel->bss->test_pass);
-	if (test__start_subtest("clone_dynptr_rdonly_before_data_dynptr_write"))
+	if (test__start_subtest("clone_dynptr_rdonly_before_data_dynptr_write_then_rw"))
 		test_tuntap_mirred(skel->progs.ing_xdp,
-				   skel->progs.clone_dynptr_rdonly_before_data_dynptr_write,
+				   skel->progs.clone_dynptr_rdonly_before_data_dynptr_write_then_rw,
 				   &skel->bss->test_pass);
 	if (test__start_subtest("clone_dynptr_rdonly_before_meta_dynptr_write"))
 		test_tuntap_mirred(skel->progs.ing_xdp,
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index d79cb74b571e..3de85b5668c9 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -28,6 +28,13 @@ struct {
 
 bool test_pass;
 
+static const __u8 meta_want[META_SIZE] = {
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
+	0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
+	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
+};
+
 SEC("tc")
 int ing_cls(struct __sk_buff *ctx)
 {
@@ -304,12 +311,13 @@ int ing_xdp(struct xdp_md *ctx)
 }
 
 /*
- * Check that skb->data_meta..skb->data is empty if prog writes to packet
+ * Check that skb->data_meta..skb->data is kept in tact if prog writes to packet
  * _payload_ using packet pointers. Applies only to cloned skbs.
  */
 SEC("tc")
-int clone_data_meta_empty_on_data_write(struct __sk_buff *ctx)
+int clone_data_meta_kept_on_data_write(struct __sk_buff *ctx)
 {
+	__u8 *meta_have = ctx_ptr(ctx, data_meta);
 	struct ethhdr *eth = ctx_ptr(ctx, data);
 
 	if (eth + 1 > ctx_ptr(ctx, data_end))
@@ -318,8 +326,10 @@ int clone_data_meta_empty_on_data_write(struct __sk_buff *ctx)
 	if (eth->h_proto != 0)
 		goto out;
 
-	/* Expect no metadata */
-	if (ctx->data_meta != ctx->data)
+	if (meta_have + META_SIZE > eth)
+		goto out;
+
+	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
 		goto out;
 
 	/* Packet write to trigger unclone in prologue */
@@ -331,14 +341,14 @@ int clone_data_meta_empty_on_data_write(struct __sk_buff *ctx)
 }
 
 /*
- * Check that skb->data_meta..skb->data is empty if prog writes to packet
+ * Check that skb->data_meta..skb->data is kept in tact if prog writes to packet
  * _metadata_ using packet pointers. Applies only to cloned skbs.
  */
 SEC("tc")
-int clone_data_meta_empty_on_meta_write(struct __sk_buff *ctx)
+int clone_data_meta_kept_on_meta_write(struct __sk_buff *ctx)
 {
+	__u8 *meta_have = ctx_ptr(ctx, data_meta);
 	struct ethhdr *eth = ctx_ptr(ctx, data);
-	__u8 *md = ctx_ptr(ctx, data_meta);
 
 	if (eth + 1 > ctx_ptr(ctx, data_end))
 		goto out;
@@ -346,25 +356,29 @@ int clone_data_meta_empty_on_meta_write(struct __sk_buff *ctx)
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
+	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
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
+ * Check that skb_meta dynptr is writable and was kept in tact if prog creates a
+ * r/w slice to packet _payload_. Applies only to cloned skbs.
  */
 SEC("tc")
-int clone_dynptr_empty_on_data_slice_write(struct __sk_buff *ctx)
+int clone_dynptr_kept_on_data_slice_write(struct __sk_buff *ctx)
 {
 	struct bpf_dynptr data, meta;
+	__u8 meta_have[META_SIZE];
 	struct ethhdr *eth;
 
 	bpf_dynptr_from_skb(ctx, 0, &data);
@@ -375,29 +389,26 @@ int clone_dynptr_empty_on_data_slice_write(struct __sk_buff *ctx)
 	if (eth->h_proto != 0)
 		goto out;
 
-	/* Expect no metadata */
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
-	if (bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) > 0)
+	bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0);
+	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
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
+ * Check that skb_meta dynptr is writable and was kept in tact if prog creates
+ * an r/w slice to packet _metadata_. Applies only to cloned skbs.
  */
 SEC("tc")
-int clone_dynptr_empty_on_meta_slice_write(struct __sk_buff *ctx)
+int clone_dynptr_kept_on_meta_slice_write(struct __sk_buff *ctx)
 {
 	struct bpf_dynptr data, meta;
 	const struct ethhdr *eth;
-	__u8 *md;
+	__u8 *meta_have;
 
 	bpf_dynptr_from_skb(ctx, 0, &data);
 	eth = bpf_dynptr_slice(&data, 0, NULL, sizeof(*eth));
@@ -407,16 +418,13 @@ int clone_dynptr_empty_on_meta_slice_write(struct __sk_buff *ctx)
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
+	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
+		goto out;
 
 	test_pass = true;
 out:
@@ -425,12 +433,14 @@ int clone_dynptr_empty_on_meta_slice_write(struct __sk_buff *ctx)
 
 /*
  * Check that skb_meta dynptr is read-only before prog writes to packet payload
- * using dynptr_write helper. Applies only to cloned skbs.
+ * using dynptr_write helper, and becomes read-write afterwards. Applies only to
+ * cloned skbs.
  */
 SEC("tc")
-int clone_dynptr_rdonly_before_data_dynptr_write(struct __sk_buff *ctx)
+int clone_dynptr_rdonly_before_data_dynptr_write_then_rw(struct __sk_buff *ctx)
 {
 	struct bpf_dynptr data, meta;
+	__u8 meta_have[META_SIZE];
 	const struct ethhdr *eth;
 
 	bpf_dynptr_from_skb(ctx, 0, &data);
@@ -443,15 +453,23 @@ int clone_dynptr_rdonly_before_data_dynptr_write(struct __sk_buff *ctx)
 
 	/* Expect read-only metadata before unclone */
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
-	if (!bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) != META_SIZE)
+	if (!bpf_dynptr_is_rdonly(&meta))
+		goto out;
+
+	bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0);
+	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
 		goto out;
 
 	/* Helper write to payload will unclone the packet */
 	bpf_dynptr_write(&data, offsetof(struct ethhdr, h_proto), "x", 1, 0);
 
-	/* Expect no metadata after unclone */
+	/* Expect r/w metadata after unclone */
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
-	if (bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) != 0)
+	if (bpf_dynptr_is_rdonly(&meta))
+		goto out;
+
+	bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0);
+	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
 		goto out;
 
 	test_pass = true;

-- 
2.43.0


