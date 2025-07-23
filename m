Return-Path: <bpf+bounces-64196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82555B0F95B
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 19:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BD9B7B4920
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 17:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E9523A997;
	Wed, 23 Jul 2025 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="H3kc/zZb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A7C23AB94
	for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292218; cv=none; b=fLNt4Cb2vDpdMpk5bseIzephsBRclcKi/jAHN/81DlkCByI7q9XMpuZyrNazHp+UcL2DpkbXxd+SSmox4vRnhEZzuB5jGsQgAbTrXbAwjZVBGs4oJVkm43KT0B1+hJy1oyKc8udT8z8aZa4pcE/rOEF+6yN+BuxhLdj+rgUnaCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292218; c=relaxed/simple;
	bh=w0dfzydpBGC2gtWUtICRP+6lG6+loY6ENR3ea2/UiCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Okl0KcROH4pT0mn48vZ+Z74HrU0gITzvuwunTaleTkYeARfmEUk31CMgyWh/Kcofluk7Cvik5BcBa5O+N/YveOtd9y+LgPO6NabxUcuKxUXTpIxSwASCRHTmue91g8XGAmFVqZT7EZQ2CLUephsLELCJlS7olHDxXsztr+gagRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=H3kc/zZb; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61360453fa3so292705a12.0
        for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 10:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753292215; x=1753897015; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=adpqALW5OiJ/6KTKUpTR9nbyCqab9Z1fb73ApNAsl1M=;
        b=H3kc/zZbjdRv16+lWuWCTPZwqgFgRV9h93IJtzn6/M5JLkMBys2awcSOKS2ea/3E2e
         s99se90ZxF5GIl33IjCt85IwowyQjsKmQl30IWyJm7NkvVrLCEY3tyoZXbJT0byE2ub9
         U1DUaz9oX5Fx9hJdLyYuGlShCr+T3a9c0s8lIX6XeSzWHqhIyU4eL4pZ1kTUwY1NRJDN
         qkwQ3Imgq05fYNjuRcyd3uDxGngWopWn8orGOiz+B1daQVABQoRz6oNd7reaMTScdTHf
         NKbTHLMTun5ramDRAlrErJJVgFgMxTvRn0DQDNnDu+95waMLzcKWSt2hmzKeuhE6xfki
         Etfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753292215; x=1753897015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adpqALW5OiJ/6KTKUpTR9nbyCqab9Z1fb73ApNAsl1M=;
        b=qUDJkg1bAvMpHyo7DXQvRafTMImrpBekSCxKUnHk7ZSnF9F86eVS80ViRVPhTBNAX7
         cmXOsaOp+BTi8njuh50BjBPnO2g9LMOZAeTz/vRyaDuKT+rhQW2nYW3tXVqJUn0OJJRZ
         OZ/iDXjufg0lTPWo63naXEDNOVJ6twUSri81gPOxfn8PwhFMgS9kuF8aCeIoBIDPNlQN
         meEHnVZbyCKhpBURpOmIEYijBq2EcUhs1DzEg9mKOdd0kNmZJ/FpuZNUy2VoMYQAyFaf
         9bQUsKW0CyQ1vFPJdyFbr/Vw/C8k01bRfur1O/HWtvVUQnpCbyV50tAgm4genaTB9N1+
         4FoQ==
X-Gm-Message-State: AOJu0YzcbbbqpEnGaKmqN+1UTuBLejJmQikYdeiNdnOprfcWj9bmDkGJ
	+E4BzkmCYYsNq4foE76mbRHOONhw6OYsCHinygkZz3Dl6p6lMOXCG66ILK1AjoJqr6E=
X-Gm-Gg: ASbGncuxadr2Wx17b9e9r+BvdTi29GG1OLpXlff+fY0n3BmZ8f1rPBGEl89zz4ZeWvO
	hH46eWyiIQrWria4UuoF2otXpQPMOYTIzWQv9cpR0KmvtdBs/HbXJJtpzJNEGDx2hb89bHXP7HL
	yCeoXIQQv8wnYPWpeOx5nR22zyVO5uJIqEc2DfITT26CPA5IuEt63HrIHrP7LQtEZWBPTEUVtCq
	uwUl/Cb2JEpifje4WPFoEs3loe2z3VjMsNm+YI8zjweRIXJgEJ7W/Y4F964PgeEoHhupwV3Df1o
	UlDJIo6gJlrOfV5NyC1eCAwc/+0j2u+giWw4t0lCe27cNAm7GiJymceBrqzXFa9QKFeFWbaeCEw
	hNTr5yu1srHdKu01wEU/36mF4iRsAt2bpOwUbYb1GChDSDYacogv/lqLluwllYbrBbrZGzj8=
X-Google-Smtp-Source: AGHT+IHif332kh9PpOkUuzfuAAwnW5oMFJqU/JVtkUvfGgzmyB2TQ/Sf3Xhr14/ruuw/k6pljEHHwQ==
X-Received: by 2002:a05:6402:312a:b0:604:e85d:8bb4 with SMTP id 4fb4d7f45d1cf-6149b58ce9cmr2379625a12.21.1753292214896;
        Wed, 23 Jul 2025 10:36:54 -0700 (PDT)
Received: from cloudflare.com (79.184.149.187.ipv4.supernova.orange.pl. [79.184.149.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f3392csm8835193a12.19.2025.07.23.10.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 10:36:54 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 23 Jul 2025 19:36:48 +0200
Subject: [PATCH bpf-next v4 3/8] selftests/bpf: Cover verifier checks for
 skb_meta dynptr type
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-skb-metadata-thru-dynptr-v4-3-a0fed48bcd37@cloudflare.com>
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

dynptr for skb metadata behaves the same way as the dynptr for skb data
with one exception - writes to skb_meta dynptr don't invalidate existing
skb and skb_meta slices.

Duplicate those the skb dynptr tests which we can, since
bpf_dynptr_from_skb_meta kfunc can be called only from TC BPF, to cover the
skb_meta dynptr verifier checks.

Also add a couple of new tests (skb_data_valid_*) to ensure we don't
invalidate the slices in the mentioned case, which are specific to skb_meta
dynptr.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |   1 +
 tools/testing/selftests/bpf/progs/dynptr_fail.c    | 258 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/dynptr_success.c |  22 ++
 3 files changed, 281 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index f2b65398afce..23455b8fd926 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -32,6 +32,7 @@ static struct {
 	{"test_ringbuf", SETUP_SYSCALL_SLEEP},
 	{"test_skb_readonly", SETUP_SKB_PROG},
 	{"test_dynptr_skb_data", SETUP_SKB_PROG},
+	{"test_dynptr_skb_meta_data", SETUP_SKB_PROG},
 	{"test_adjust", SETUP_SYSCALL_SLEEP},
 	{"test_adjust_err", SETUP_SYSCALL_SLEEP},
 	{"test_zero_size_dynptr", SETUP_SYSCALL_SLEEP},
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index bd8f15229f5c..136e382e913b 100644
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
@@ -1115,6 +1155,29 @@ int skb_invalid_data_slice1(struct __sk_buff *skb)
 	return SK_PASS;
 }
 
+/* Read-only skb metadata slice is invalidated whenever a helper changes packet data */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int skb_meta_invalid_data_slice1(struct __sk_buff *skb)
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
 /* The read-write data slice is invalidated whenever a helper changes packet data */
 SEC("?tc")
 __failure __msg("invalid mem access 'scalar'")
@@ -1141,6 +1204,29 @@ int skb_invalid_data_slice2(struct __sk_buff *skb)
 	return SK_PASS;
 }
 
+/* Read-write skb metadata slice is invalidated whenever a helper changes packet data */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int skb_meta_invalid_data_slice2(struct __sk_buff *skb)
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
 /* The read-only data slice is invalidated whenever bpf_dynptr_write() is called */
 SEC("?tc")
 __failure __msg("invalid mem access 'scalar'")
@@ -1167,6 +1253,74 @@ int skb_invalid_data_slice3(struct __sk_buff *skb)
 	return SK_PASS;
 }
 
+/* Read-only skb metadata slice is invalidated on write to skb data */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int skb_meta_invalid_data_slice3(struct __sk_buff *skb)
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
+/* Read-only skb data slice is _not_ invalidated on write to skb metadata */
+SEC("?tc")
+__success
+int skb_valid_data_slice3(struct __sk_buff *skb)
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
+	/* this should succeed */
+	val = *d;
+
+	return SK_PASS;
+}
+
+/* Read-only skb metadata slice is _not_ invalidated on write to skb metadata */
+SEC("?tc")
+__success
+int skb_meta_valid_data_slice3(struct __sk_buff *skb)
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
+	/* this should succeed */
+	val = *md;
+
+	return SK_PASS;
+}
+
 /* The read-write data slice is invalidated whenever bpf_dynptr_write() is called */
 SEC("?tc")
 __failure __msg("invalid mem access 'scalar'")
@@ -1192,6 +1346,74 @@ int skb_invalid_data_slice4(struct __sk_buff *skb)
 	return SK_PASS;
 }
 
+/* Read-write skb metadata slice is invalidated on write to skb data slice */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int skb_meta_invalid_data_slice4(struct __sk_buff *skb)
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
+/* Read-write skb data slice is _not_ invalidated on write to skb metadata */
+SEC("?tc")
+__success
+int skb_valid_data_slice4(struct __sk_buff *skb)
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
+	/* this should succeed */
+	*d = 42;
+
+	return SK_PASS;
+}
+
+/* Read-write skb metadata slice is _not_ invalidated on write to skb metadata */
+SEC("?tc")
+__success
+int skb_meta_valid_data_slice4(struct __sk_buff *skb)
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
+	/* this should succeed */
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
index 7d7081d05d47..2d8ba076e37c 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -209,6 +209,28 @@ int test_dynptr_skb_data(struct __sk_buff *skb)
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
 SEC("tp/syscalls/sys_enter_nanosleep")
 int test_adjust(void *ctx)
 {

-- 
2.43.0


