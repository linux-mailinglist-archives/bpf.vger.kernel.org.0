Return-Path: <bpf+bounces-64993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5774B1A24E
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 14:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC4A189FE8C
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 12:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9589F26B75B;
	Mon,  4 Aug 2025 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dYatnKDE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D9626A1A3
	for <bpf@vger.kernel.org>; Mon,  4 Aug 2025 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311970; cv=none; b=WAPoRwvFTnrDHTTKqUXsBSoz45iyXgh1u8SIp2sg9f5x0VkG6fMKJ7RrmlCrlD81ahIEDmS6AzMoOPFBk932CPf8SxgaH3mWgkklTdqKCb09vpVV2p8KJf88zhCtcVRkpfjI5Is3nmJ71j6QMsGZIYww7MLT0TPkOGEnPDUYP9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311970; c=relaxed/simple;
	bh=PPrRxylf++fMKZv9Iy/oJV5oi/UlhHvNs2qCW/ynntk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rAOgSvziL9kW+Fp+P9MPBvphPcixgTgCAo1c3Ksq80wvE4EIYvDq4koMJRUWxlHfLwHweUgAMGcA5Hchw6AcpJD4SeI7JkMzb5gpUtO1i8lkEIfWUcjMSUQIj0+CVmhjmQFhowbGFoRfwZFKUieI2DUzNqeNKdxauYL10w2AtCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dYatnKDE; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61580eb7995so9627107a12.0
        for <bpf@vger.kernel.org>; Mon, 04 Aug 2025 05:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754311967; x=1754916767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1yHstTE3tSbVfUP/vtg6i6reJKRnZ5jYKLUV9Bq7ySc=;
        b=dYatnKDE0nCMys9+jTj0MDRAH37HBV3Q8WS4V+molyNnLUX8oGo0u94opKFG+PgG2P
         Y81lSugUVPKX5EhqQilfAW5Y/jUhwhSy3lguzgoUZirQWxcHVUq+2XuH/Dc5PJEYSx/d
         rdMpGvWypYVMavSskxdM0H18PUbrNzxgUCEXTUQZ4C8WqiwdME4GJFp9cC5Co10n4WjO
         NLJr4UcQ8O9YikRuTI9RC/yhHpF+BZ8Tbh4jCRSpP+vKdNrQhvInNrjLpGPgQC3HO+nJ
         MzLwZeHe3zhr6V3gGxRJTx0cTobTA3v5q0qHvmXdQX9ObrBP0ke5iR+OWzLlg3TfGEEI
         32Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311967; x=1754916767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yHstTE3tSbVfUP/vtg6i6reJKRnZ5jYKLUV9Bq7ySc=;
        b=Hwh//07WMsFOtQi13YZ4jUM+vijKpdI50N/6/X5VRDXr8Dd21bshHwrh5EXrQMbvaU
         7gmWQDimyGHrRUXHBHyQnEf4y8hELdViXyumNkHbLh5R6S4CcEdTPec8e+5nTQK842SR
         O1E2pFlRWyUgxXTsfzIl5QMX4OhQJbk2HdWbusUTtpWQw3u6MWStxZ27Ns2b4uxx6Pxx
         UhlFq/x2WqUbdAkUZMkY1uDpp8zbKL9gZ1iL0tRVViFQ6LmEIbh8lroJWz6h11yzoqE9
         vyM5e2gut7g9+5traaLpIoWNZOIvbU5botI3/DmOgmhy9d3WAHiY/LzvKV1C80tfgIQu
         GHFA==
X-Gm-Message-State: AOJu0YxrCCrcRSPD2jQoiiCq1/i13LWW7t/tRhnCyVyUo3p1mm6dJaQh
	cQEmmykzfD4BkVN4ALaM30PSarX5GisLseafZTmyAuM7X+Rh7sq2RybV54oEX2folew=
X-Gm-Gg: ASbGncvKBM5E9JfpzKJE37q1SBRSBDMdvDiHbucGfojW6AA4Jicmi4YTPB4A7zzYsWq
	XEbzOE0NmrHaiyyCydtMw/07Pv8oM9yGwEeaESx2LzTVFx0nXM/Kip9lN6hPGNEx7wnrTHesaXn
	YMWY6zm1Oh/yT8oHZOyTMPaJ84NxNaXRU3gEl+52xjfFn8RvA7wbjvl4tghPsVTGQ7PFUKGDTLy
	SuQm765H1WVbqpUj7xTLNZKQ8SE/dqhIcYa5Gx3O/y7656UygLQz6NkgbXoA72iznQ+jfteg4Nq
	Oe3Bn9FfQNPeR2SerhGsES0XtucKfm9HxQZBZ+uQxDQqGo5MWsX3EsHMb4ii42DyGuQNbWW5uHc
	jgC59AUgZ/93+lSKGn5mwNpPJzeauLDg=
X-Google-Smtp-Source: AGHT+IFyvUH6b7xe4Sr6/CNEn4E6IrEUhTnkBHYMkB3OM2S9jvLq0rombj5HIa+ieYdwUOEe2HZebQ==
X-Received: by 2002:a05:6402:2355:b0:615:3667:f4eb with SMTP id 4fb4d7f45d1cf-615e5dd9a53mr8452211a12.6.1754311967003;
        Mon, 04 Aug 2025 05:52:47 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:75])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffb8d7sm6882374a12.47.2025.08.04.05.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:52:46 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 04 Aug 2025 14:52:26 +0200
Subject: [PATCH bpf-next v6 3/9] selftests/bpf: Cover verifier checks for
 skb_meta dynptr type
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-skb-metadata-thru-dynptr-v6-3-05da400bfa4b@cloudflare.com>
References: <20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com>
In-Reply-To: <20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com>
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

dynptr for skb metadata behaves the same way as the dynptr for skb data
with one exception - writes to skb_meta dynptr don't invalidate existing
skb and skb_meta slices.

Duplicate those the skb dynptr tests which we can, since
bpf_dynptr_from_skb_meta kfunc can be called only from TC BPF, to cover the
skb_meta dynptr verifier checks.

Also add a couple of new tests (skb_data_valid_*) to ensure we don't
invalidate the slices in the mentioned case, which are specific to skb_meta
dynptr.

Reviewed-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |   2 +
 tools/testing/selftests/bpf/progs/dynptr_fail.c    | 258 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/dynptr_success.c |  55 +++++
 3 files changed, 315 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index 9b2d9ceda210..b9f86cb91e81 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -32,6 +32,8 @@ static struct {
 	{"test_ringbuf", SETUP_SYSCALL_SLEEP},
 	{"test_skb_readonly", SETUP_SKB_PROG},
 	{"test_dynptr_skb_data", SETUP_SKB_PROG},
+	{"test_dynptr_skb_meta_data", SETUP_SKB_PROG},
+	{"test_dynptr_skb_meta_flags", SETUP_SKB_PROG},
 	{"test_adjust", SETUP_SYSCALL_SLEEP},
 	{"test_adjust_err", SETUP_SYSCALL_SLEEP},
 	{"test_zero_size_dynptr", SETUP_SYSCALL_SLEEP},
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index bd8f15229f5c..dda6a8dada82 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -269,6 +269,26 @@ int data_slice_out_of_bounds_skb(struct __sk_buff *skb)
 	return SK_PASS;
 }
 
+/* A metadata slice can't be accessed out of bounds */
+SEC("?tc")
+__failure __msg("value is outside of the allowed memory range")
+int data_slice_out_of_bounds_skb_meta(struct __sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+	__u8 *md;
+
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+
+	md = bpf_dynptr_slice_rdwr(&meta, 0, NULL, sizeof(*md));
+	if (!md)
+		return SK_DROP;
+
+	/* this should fail */
+	*(md + 1) = 42;
+
+	return SK_PASS;
+}
+
 SEC("?raw_tp")
 __failure __msg("value is outside of the allowed memory range")
 int data_slice_out_of_bounds_map_value(void *ctx)
@@ -1089,6 +1109,26 @@ int skb_invalid_slice_write(struct __sk_buff *skb)
 	return SK_PASS;
 }
 
+/* bpf_dynptr_slice()s are read-only and cannot be written to */
+SEC("?tc")
+__failure __msg("R{{[0-9]+}} cannot write into rdonly_mem")
+int skb_meta_invalid_slice_write(struct __sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+	__u8 *md;
+
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+
+	md = bpf_dynptr_slice(&meta, 0, NULL, sizeof(*md));
+	if (!md)
+		return SK_DROP;
+
+	/* this should fail */
+	*md = 42;
+
+	return SK_PASS;
+}
+
 /* The read-only data slice is invalidated whenever a helper changes packet data */
 SEC("?tc")
 __failure __msg("invalid mem access 'scalar'")
@@ -1192,6 +1232,188 @@ int skb_invalid_data_slice4(struct __sk_buff *skb)
 	return SK_PASS;
 }
 
+/* Read-only skb data slice is invalidated on write to skb metadata */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int ro_skb_slice_invalid_after_metadata_write(struct __sk_buff *skb)
+{
+	struct bpf_dynptr data, meta;
+	__u8 *d;
+
+	bpf_dynptr_from_skb(skb, 0, &data);
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+
+	d = bpf_dynptr_slice(&data, 0, NULL, sizeof(*d));
+	if (!d)
+		return SK_DROP;
+
+	bpf_dynptr_write(&meta, 0, "x", 1, 0);
+
+	/* this should fail */
+	val = *d;
+
+	return SK_PASS;
+}
+
+/* Read-write skb data slice is invalidated on write to skb metadata */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int rw_skb_slice_invalid_after_metadata_write(struct __sk_buff *skb)
+{
+	struct bpf_dynptr data, meta;
+	__u8 *d;
+
+	bpf_dynptr_from_skb(skb, 0, &data);
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+
+	d = bpf_dynptr_slice_rdwr(&data, 0, NULL, sizeof(*d));
+	if (!d)
+		return SK_DROP;
+
+	bpf_dynptr_write(&meta, 0, "x", 1, 0);
+
+	/* this should fail */
+	*d = 42;
+
+	return SK_PASS;
+}
+
+/* Read-only skb metadata slice is invalidated on write to skb data */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int ro_skb_meta_slice_invalid_after_payload_write(struct __sk_buff *skb)
+{
+	struct bpf_dynptr data, meta;
+	__u8 *md;
+
+	bpf_dynptr_from_skb(skb, 0, &data);
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+
+	md = bpf_dynptr_slice(&meta, 0, NULL, sizeof(*md));
+	if (!md)
+		return SK_DROP;
+
+	bpf_dynptr_write(&data, 0, "x", 1, 0);
+
+	/* this should fail */
+	val = *md;
+
+	return SK_PASS;
+}
+
+/* Read-write skb metadata slice is invalidated on write to skb data slice */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int rw_skb_meta_slice_invalid_after_payload_write(struct __sk_buff *skb)
+{
+	struct bpf_dynptr data, meta;
+	__u8 *md;
+
+	bpf_dynptr_from_skb(skb, 0, &data);
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+
+	md = bpf_dynptr_slice_rdwr(&meta, 0, NULL, sizeof(*md));
+	if (!md)
+		return SK_DROP;
+
+	bpf_dynptr_write(&data, 0, "x", 1, 0);
+
+	/* this should fail */
+	*md = 42;
+
+	return SK_PASS;
+}
+
+/* Read-only skb metadata slice is invalidated whenever a helper changes packet data */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int ro_skb_meta_slice_invalid_after_payload_helper(struct __sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+	__u8 *md;
+
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+
+	md = bpf_dynptr_slice(&meta, 0, NULL, sizeof(*md));
+	if (!md)
+		return SK_DROP;
+
+	if (bpf_skb_pull_data(skb, skb->len))
+		return SK_DROP;
+
+	/* this should fail */
+	val = *md;
+
+	return SK_PASS;
+}
+
+/* Read-write skb metadata slice is invalidated whenever a helper changes packet data */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int rw_skb_meta_slice_invalid_after_payload_helper(struct __sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+	__u8 *md;
+
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+
+	md = bpf_dynptr_slice_rdwr(&meta, 0, NULL, sizeof(*md));
+	if (!md)
+		return SK_DROP;
+
+	if (bpf_skb_pull_data(skb, skb->len))
+		return SK_DROP;
+
+	/* this should fail */
+	*md = 42;
+
+	return SK_PASS;
+}
+
+/* Read-only skb metadata slice is invalidated on write to skb metadata */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int ro_skb_meta_slice_invalid_after_metadata_write(struct __sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+	__u8 *md;
+
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+
+	md = bpf_dynptr_slice(&meta, 0, NULL, sizeof(*md));
+	if (!md)
+		return SK_DROP;
+
+	bpf_dynptr_write(&meta, 0, "x", 1, 0);
+
+	/* this should fail */
+	val = *md;
+
+	return SK_PASS;
+}
+
+/* Read-write skb metadata slice is invalidated on write to skb metadata */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int rw_skb_meta_slice_invalid_after_metadata_write(struct __sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+	__u8 *md;
+
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+
+	md = bpf_dynptr_slice_rdwr(&meta, 0, NULL, sizeof(*md));
+	if (!md)
+		return SK_DROP;
+
+	bpf_dynptr_write(&meta, 0, "x", 1, 0);
+
+	/* this should fail */
+	*md = 42;
+
+	return SK_PASS;
+}
+
 /* The read-only data slice is invalidated whenever a helper changes packet data */
 SEC("?xdp")
 __failure __msg("invalid mem access 'scalar'")
@@ -1255,6 +1477,19 @@ int skb_invalid_ctx(void *ctx)
 	return 0;
 }
 
+/* Only supported prog type can create skb_meta-type dynptrs */
+SEC("?raw_tp")
+__failure __msg("calling kernel function bpf_dynptr_from_skb_meta is not allowed")
+int skb_meta_invalid_ctx(void *ctx)
+{
+	struct bpf_dynptr meta;
+
+	/* this should fail */
+	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+
+	return 0;
+}
+
 SEC("fentry/skb_tx_error")
 __failure __msg("must be referenced or trusted")
 int BPF_PROG(skb_invalid_ctx_fentry, void *skb)
@@ -1665,6 +1900,29 @@ int clone_skb_packet_data(struct __sk_buff *skb)
 	return 0;
 }
 
+/* A skb clone's metadata slice becomes invalid anytime packet data changes */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int clone_skb_packet_meta(struct __sk_buff *skb)
+{
+	struct bpf_dynptr clone, meta;
+	__u8 *md;
+
+	bpf_dynptr_from_skb_meta(skb, 0, &meta);
+	bpf_dynptr_clone(&meta, &clone);
+	md = bpf_dynptr_slice_rdwr(&clone, 0, NULL, sizeof(*md));
+	if (!md)
+		return SK_DROP;
+
+	if (bpf_skb_pull_data(skb, skb->len))
+		return SK_DROP;
+
+	/* this should fail */
+	*md = 42;
+
+	return 0;
+}
+
 /* A xdp clone's data slices should be invalid anytime packet data changes */
 SEC("?xdp")
 __failure __msg("invalid mem access 'scalar'")
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index 8315273cb900..127dea342e5a 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -211,6 +211,61 @@ int test_dynptr_skb_data(struct __sk_buff *skb)
 	return 1;
 }
 
+SEC("?tc")
+int test_dynptr_skb_meta_data(struct __sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+	__u8 *md;
+	int ret;
+
+	err = 1;
+	ret = bpf_dynptr_from_skb_meta(skb, 0, &meta);
+	if (ret)
+		return 1;
+
+	/* This should return NULL. Must use bpf_dynptr_slice API */
+	err = 2;
+	md = bpf_dynptr_data(&meta, 0, sizeof(*md));
+	if (md)
+		return 1;
+
+	err = 0;
+	return 1;
+}
+
+/* Check that skb metadata dynptr ops don't accept any flags. */
+SEC("?tc")
+int test_dynptr_skb_meta_flags(struct __sk_buff *skb)
+{
+	const __u64 INVALID_FLAGS = ~0ULL;
+	struct bpf_dynptr meta;
+	__u8 buf;
+	int ret;
+
+	err = 1;
+	ret = bpf_dynptr_from_skb_meta(skb, INVALID_FLAGS, &meta);
+	if (ret != -EINVAL)
+		return 1;
+
+	err = 2;
+	ret = bpf_dynptr_from_skb_meta(skb, 0, &meta);
+	if (ret)
+		return 1;
+
+	err = 3;
+	ret = bpf_dynptr_read(&buf, 0, &meta, 0, INVALID_FLAGS);
+	if (ret != -EINVAL)
+		return 1;
+
+	err = 4;
+	ret = bpf_dynptr_write(&meta, 0, &buf, 0, INVALID_FLAGS);
+	if (ret != -EINVAL)
+		return 1;
+
+	err = 0;
+	return 1;
+}
+
 SEC("tp/syscalls/sys_enter_nanosleep")
 int test_adjust(void *ctx)
 {

-- 
2.43.0


