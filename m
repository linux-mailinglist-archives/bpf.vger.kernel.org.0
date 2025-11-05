Return-Path: <bpf+bounces-73712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 157E0C37B5C
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41713AB3F7
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F9634EF0C;
	Wed,  5 Nov 2025 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bqsSj9d3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6F934E754
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374010; cv=none; b=MOnnkWdz4zNZmQkeGXze9cZzaa42CbFPnYK214ktL9LnVjW65b/YGVgZvHVkI/OHmCmPhkwNsWPMe6/iOk+7GO1sFi4IL2cgYP0wjIXEMhU/cEIoR2ldx5Wcur8M9wsSgi76WVRdaP1gSoeOeeV4pxZRquYQQb3jsgrwWcNWkqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374010; c=relaxed/simple;
	bh=oU1mObjW9Wpz+u1GfWqs3XLJ/AdgzZqeOQqym3IYvj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AxtrTBpwMV0whOS8a4tSBZYpfFj9y/OiKWfKFojBEyLSEYpQ5oVmkRGMmmWR52s+RfgRPmC8Q0o/TIJuNjlM2kTKLcgKqRO+NLvE5Ora2y7w0AdzHG+JURbwOeauNqfVGVS6sQSdUBVvHSS7g3ivyDEx8/IstBPtmivmOc2ZOqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bqsSj9d3; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so277032a12.3
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 12:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762374007; x=1762978807; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/re0zpWLz18Oa0L5sNL6vn9QSTMIu80JAEtsQnqvWNg=;
        b=bqsSj9d3H4eJvf6X16I3j0d6vfGQlmt315dZjYOjLl5xDkhSaUdmCw9aRzIkuzW9Xj
         ooahqXYoJKt5XSrBquRLYEMftkohfgGhAN6aWOBtuuKteWowGJU3MQ55DaHDjgxqcHY5
         oa0YijuzT92xvmFdzrwVg2yaxhQfbJWHSKNiDZ5ZMzeuuXjQNfTHVgo0Qod0jzYm7yDT
         BsNCzGs3zdwDxe7T6U8UkUxWAu3s857TrBilFyq5h1z6npXViosWX2+EloX/5Yx0bBdo
         AicD/7PxIWtx6dJli526i+ntQ1tvVmn2N1P+yt5Gb33a/IAFcziLJx3cD3H5SdlRRmre
         NlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762374007; x=1762978807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/re0zpWLz18Oa0L5sNL6vn9QSTMIu80JAEtsQnqvWNg=;
        b=KN8Cxvx7Wq3Im/mdxxZSjv1iH37oA3A7vx+UMEJiKOEYIg2GFMMQf9XW7PTfgZups0
         9QoMQo7ev8eTbT/943Xvo0MKI9MOTu8RV3zJ+KHBi1Q9bUoqpBiN4FqDubjg8ME+92T2
         +uB5/YmrKesIYaV9AmWX5wDz+L3ZU5eXc9dDO1Yob9EujxBC5/2Vy+knDUzHQaepOggx
         ZgdqDycHFFAWBgasTixByhbq0y/txpgvjMuUx3NWvrVP1i4iisQiG64CH9twMeGIEPwu
         ygoBjw55VgtxvNSxu7GNgdpas9mOjBEYqgM//9gKAP8xO94P/otWMgcSlhaPQTV5Oeoo
         /KcQ==
X-Gm-Message-State: AOJu0Yy0KgsUft/0+5oswIVvaDYoIYpCycgOj+H8D8xSX/awXc+nsayh
	0noQb/OOCsuFZ0dWX2NkB1fEM72zVifDi2I2k6+NL8c6I/kSnN84bg5/kNZQ737PqgM=
X-Gm-Gg: ASbGnctfkKmjWsiq0oATDPP5M1eVGGIPXhnSTI70CZvOAQD21udf5nFrOKDeDhRxfAo
	hE1yMdMpulnoYyM7yNNK5nX5RER7B3n6oKiief+YeIPdM5ZMvjrlGVCvexNTXyZK7r4PQoQTJyi
	38K6Ti8wHkujaQxr9CdGYchxqhx1zLsKR+zdUrpbHKOYryh4mdP8fHO55wvi6bFTunzRLEShHso
	N2zNtTXnjB6VoTEXCCkf3ZvSPSxeaRr3ly7kSKiOIhADYJawRt7JA24TsqcYexsvDChrLfUpv4i
	lNrKb3qzD3jgPIscZmp3U9EwF0Wm7vvCqM8kLucaKmRAMRxZWb8Bl2oH4HjDRoHANppPBMAsJYf
	RcCeB238ESBNytKnp0OHN1Xb3N+mnqMFCSEa+uqIHWNmVLI4wjB+NZS4SPZ487GqZWLTmJR4uMd
	drQhfv0UdVSRWa9bwfJ9MYiAwZq13Vehqpm4EUN4z63AoPPg==
X-Google-Smtp-Source: AGHT+IHoGhgjwjGQDLj55dOuR7mnyVj4Urj4qYTjGL4CXnMyUYuiiTwBw+8AIPXgwVjN3eeyOxWi2Q==
X-Received: by 2002:a17:907:a0c9:b0:b70:ac7a:2a98 with SMTP id a640c23a62f3a-b72654183d3mr478998566b.26.1762374006858;
        Wed, 05 Nov 2025 12:20:06 -0800 (PST)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289332eb4sm48151266b.1.2025.11.05.12.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:20:06 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 05 Nov 2025 21:19:49 +0100
Subject: [PATCH bpf-next v4 12/16] selftests/bpf: Expect unclone to
 preserve skb metadata
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-skb-meta-rx-path-v4-12-5ceb08a9b37b@cloudflare.com>
References: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
In-Reply-To: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
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
index 3b137c4eed6c..a70de55c6997 100644
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


