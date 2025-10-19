Return-Path: <bpf+bounces-71305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F65BEE567
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 14:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FFA189E857
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 12:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B672EA490;
	Sun, 19 Oct 2025 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GRJNY9p+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78BB2E7BBC
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877963; cv=none; b=h8O51o1Q3RYFFqTWhd2iIFvhB2GE1aA7QpNaS6Mj/GYzxYC5SVvnhv6+XQNzNUbT6kyry26Tq76AxcSMhXlgBmn7PaZ+IIiU4Dw6CKVlU1xVSXKD8RD2gYsPPQi2kgGB0WkVFUdZCp63gkSt44YHI6/WuPhDSfCkowh5Xb2bfzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877963; c=relaxed/simple;
	bh=9bMFW5HlTADRbtDaOiOSff+WzK3vNaMYFT6OovA6rWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iOkwMctlKwY/9MrL1F97co22r6abc3uWqciCu8zbuyNKj1vHUpGD/beCKyHSYk3ocPymRbWc7eGaNh5YaeyFuTbHU1+lU5mYCjqDxi7h/iS1AHlE3FnPSP+NxG0pDlWP/0dXtsHCT+d4/WvzCvuFy/B05fWfZn0hlJC9zIgHJOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GRJNY9p+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b64cdbb949cso509175466b.1
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 05:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877960; x=1761482760; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWb06XbiC/Ghu5psY6ZDtCdUlhVGHcGFTCaD3dYiVcA=;
        b=GRJNY9p+A2FU0Wn/+FX1n7GY8V8XBeZjAW7wwB49F0ryDfat0RIMzP6A2aqwEiNrZI
         obWbmVvvzJcDU+jB1ct7vumsnBJWJTBCN2cYI7+Ls+Tl5GSI1fkxzbvmZqQvfW/1ji+x
         7XMq+BdmnFuPcWqTj3dMCvMsSKgp8zKc6P1o5aQwKSQWrbamzCFKcBcXosOUtea+TkMo
         k1Xr4e/sx0sS6HL7yepe/r2iX0i7hO4qZiD9CHo4yauDHIfh784zqJ+AKqDfK4nmzvHI
         SjR/bU+M97un489BqlMBUZYDqUeKas7LSihScJtlE1RJyMfkdb+b6zuhbkWgSk6DU9zc
         GRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877960; x=1761482760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWb06XbiC/Ghu5psY6ZDtCdUlhVGHcGFTCaD3dYiVcA=;
        b=n4yRYY3ChnRVEGametmmyTZDDeswofrbvCVB1S1uOEtcb+eOMU9URhInKHlNkUtcru
         216NsKbKP2XBsFRuDTFvOo9f/4m5MWCmpItq37rnJWRYYohJEoyQJkEx4ywZegHLk8xS
         RL+XsHzJ6q/yeqZ1sibr+6dZ8pcjo6zNRPYwo9cvb8Dq898n+Jk0/GL+tk2TRFNcKP3Z
         UbibPLs+1wHWNDQXynmu6EjDPPojnisRdx/XypeN4uGbmm7qQuBhv55ypT07eb0/eiwp
         AoB5oY+oufSPQ5sKlCs0UYVhfEDFM34s3/OhOm6QSltxgTk5FKH3p6EhBOX3aYp2AY6e
         ejuw==
X-Gm-Message-State: AOJu0Yy35J5QDPeJTVzxttLaO9KlaCtUrCvFxYd6wsLHYsGYqSrYtubF
	Tt3I7x9eHJhkIYXmH9KM0vg2R7MUrJKm8v2QwEV9eMUnKl6u3QiHhWzliAI2tpAFQiA=
X-Gm-Gg: ASbGncu5oMB6qpTKRhoFX9tgrfM+j3SG0bgX6FwWZW118sJkCUx+hFzl16EU9bseEyx
	Nbm84Th2nccNa3FwPICWrsyrn9ER9oDJBvoAuskD55VhczITy7H2aWCPldqnYenAUphfK2tT8j0
	lERkOWPRUuF1sKGlD5o8SKdWGtcBnGC64y4WLHn9d3IY7f0IkDMJVPLVTIdTdoglZBLCL9joeEm
	adPXOgVfBGJ+RrDYlzqh7Lz7/aTsvG2p9AHTVajik6+xza5CHPL0sz38BjYF5+D2FX2tJTTP3T1
	XnkohMBYYspo7x0Hxz8juQwWr9eaUF0kRp7rIavB7Y6/G02O8LxMITck3sI2HpAUEGN0VaauY0X
	dBbj/arAXMJnmxUXySD4cG2FzDZzkmTMznvD2/74/ZLkDFkkVXmI7wSPWqNzojqzNR8IWrUs5jz
	XdudyEu1+6JWRSoC9L8olTiEYn3g2n3Lzb86VclXNnaN+08I1s
X-Google-Smtp-Source: AGHT+IFVIHsKShosytEtskKMey3yttj0MpCEw1KOtRaphKkOvfeE0dU/7yPwkDJB+aVs0gwC4TKr/w==
X-Received: by 2002:a17:907:7f0d:b0:b04:274a:fc87 with SMTP id a640c23a62f3a-b6472c61940mr1174667066b.4.1760877960231;
        Sun, 19 Oct 2025 05:46:00 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebf49fd8sm506236566b.83.2025.10.19.05.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:45:59 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:35 +0200
Subject: [PATCH bpf-next v2 11/15] selftests/bpf: Expect unclone to
 preserve skb metadata
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-11-f9a58f3eb6d6@cloudflare.com>
References: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
In-Reply-To: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
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
 netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Since pskb_expand_head() no longer clears metadata on unclone, update tests
for cloned packets to expect metadata to remain intact.

Also simplify the clone_dynptr_kept_on_{data,meta}_slice_write tests.
Creating an r/w dynptr slice is sufficient to trigger an unclone in the
prologue, so remove the extraneous writes to the data/meta slice.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 20 ++---
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 87 ++++++++++++----------
 2 files changed, 59 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index a3de37942fa4..df6248dbaae8 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -458,25 +458,25 @@ void test_xdp_context_tuntap(void)
 			    skel->progs.ing_cls_dynptr_offset_oob,
 			    skel->progs.ing_cls,
 			    &skel->bss->test_pass);
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
index 33480bcb8ec1..dba76f84c0c5 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -326,12 +326,13 @@ int ing_xdp(struct xdp_md *ctx)
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
@@ -340,8 +341,10 @@ int clone_data_meta_empty_on_data_write(struct __sk_buff *ctx)
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
@@ -353,14 +356,14 @@ int clone_data_meta_empty_on_data_write(struct __sk_buff *ctx)
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
@@ -368,25 +371,29 @@ int clone_data_meta_empty_on_meta_write(struct __sk_buff *ctx)
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
@@ -397,29 +404,26 @@ int clone_dynptr_empty_on_data_slice_write(struct __sk_buff *ctx)
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
@@ -429,16 +433,13 @@ int clone_dynptr_empty_on_meta_slice_write(struct __sk_buff *ctx)
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
@@ -447,12 +448,14 @@ int clone_dynptr_empty_on_meta_slice_write(struct __sk_buff *ctx)
 
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
@@ -465,15 +468,23 @@ int clone_dynptr_rdonly_before_data_dynptr_write(struct __sk_buff *ctx)
 
 	/* Expect read-only metadata before unclone */
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
-	if (!bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) != META_SIZE)
+	if (!bpf_dynptr_is_rdonly(&meta))
+		goto out;
+
+	bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0);
+	if (!check_metadata(meta_have))
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
+	if (!check_metadata(meta_have))
 		goto out;
 
 	test_pass = true;

-- 
2.43.0


