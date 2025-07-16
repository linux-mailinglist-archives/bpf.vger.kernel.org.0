Return-Path: <bpf+bounces-63464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE44B07B06
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 18:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A598B5849C7
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 16:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145752F85CF;
	Wed, 16 Jul 2025 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FnDSaa2D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CAC2F85C6
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682705; cv=none; b=GVza+kGxQI+EVXQcpEsb7e3k5g82y5M+iEdjOUemSyBxX+t0KtlZDorRdP3aa84guEcDj+vMuJIO8IwHjGHFQQWwkTCI79I2VOIk64NJR0REnpKT8xdDfmPCt01rjhSUqsfa0+qSgw+WPO5TDHFA4pvJwC+PFNEZUb+gAGGklpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682705; c=relaxed/simple;
	bh=54L1Kc9gaV36BG5GioDHKbV+2mE/lcWofiUWn7eEGjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VYFjOky33JGqf/YX8cQMJFF7rBy7fNOw5teUOIoRDnI6Ia8osoBg5phIHGBDi+PTg8RoTPVBWH6n3zGzsxoHOcm/g5fbFptmQqBNioGQEgI3m4FgW5StWtTXtMrDXFpkyBp2cyZQ5Y14/LoRhHLaTst/+kAKvrZD99L5RM0BKiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FnDSaa2D; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-553be4d2fbfso79260e87.0
        for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 09:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752682702; x=1753287502; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1cHZQ6qYFTZxJxPR/9ROtfuvMFvGv2NDFIewrCoSxY=;
        b=FnDSaa2D2+y84PfjNNh8I33yVHrhpEOGL/kCUbtlCnGT1ACZimRgc7FA1yvpNimMiw
         uaw8a+dR+6ozvmbzlnDzflsq2hExIK4RgRhLVaAVlIf8uDITKBFMceYOuwl1XppNp1Lu
         PR7QaW/ypL8/2wniSnvFnWzqp6iWGriOuW6L9brbocMjSu/5yuC9ZNJnQrYs1ehY1i3t
         qvxWC+l9KOcbokfCoCUp2FWrUHUgF05PgPd7IK4/3vquWFn9EuYOvN6VG+gmwVhh4CYK
         ogdwGvGlh3PonWBeAaNRgdAlir/1jj3HG+kcXLzuxJqIO+dRJCnFw+XPJhVNm1F4g8Oh
         ayIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682702; x=1753287502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1cHZQ6qYFTZxJxPR/9ROtfuvMFvGv2NDFIewrCoSxY=;
        b=j7GdxEMUVQNIlPjPmYtEp2XtBmyb7cPCTkfClXgkXclcoiD6PDbnCpdBR1K8crsQfX
         PujHxnwxUZPLn+EeU4T1XP6KPlHhy0I/Va3acyhbcehI1gdhK3a/JXaFTLKtp3puSa0r
         tSGgYEUO/gWH2aaOTrqlJA2xXF6WXeXQCRAsZyaKF/EYOMptxmvNItyY2zSTcxNx/IaE
         OEYKeKvKj7+kqsqbCzcpHi+d7jicdi6gZLbrN20zKufKmPEpUlkDygJPw2FoHF2pfuGJ
         WZWcyl2h7GFNwUC6XzWP+aQ+e2h389uDywEOHgevPJxhUCbxVqx3E3GmAa4CSRa1conI
         LUtA==
X-Gm-Message-State: AOJu0Yz3b2E8jCVOfZqcovjNGruEh4+1eEwpXeJi1//desQtQ+s9RDDG
	gMuMvwcKADwj6IV2xR+G8DA4n9ajU1yNZPvhll1RW2m2lfGuDAcDdqZfgxHtWkcRkC4=
X-Gm-Gg: ASbGncsU6Tyaj1D8lo9+uwlsnqAryqax7cU+jQeSuW7vgUhgnYk7zynMhBXoavDh7xP
	YVtbfKVMc6YzAj8g3Dzm9YU9tzt40DliATciYpr9VoUxPOleQKyOTZqsAMttee+iGeRtzXOixF3
	T+lYGMF87JGAXLafqSDJHPQYlfDkWV7SvmvW4U+zbfTKCN00VvY5xQnnTaC3hw91yecj+kx4flf
	W3yvUu2dECOlfXG0zC+OqPjNd7RiBWSQUAtWAvBrtMBVhk1P5uW3ed5dY4AQB1UItiuK/K8gNf8
	TpjoXljFbGKuxBvgYFLsMHW5B9RMH0FkOrwNBHFsV+/mnzeMy7CsRL1WkrYojKiqMCROQy9YGbP
	qGWwXrYoKjW4uUV3XPNenWhigyL7cAk63KR7yQqcWl8YxKWIxhyWniFcW5SpDLXpVPQwS
X-Google-Smtp-Source: AGHT+IFfx8OK7714p6a6//28n1OQGRX4y6QvLrF1f7dkpjoZJ68QwK1K0vsYRf9cMxIRy7yUBtrmxA==
X-Received: by 2002:a05:6512:3e20:b0:553:cfa8:dd25 with SMTP id 2adb3069b0e04-55a23ee8198mr1265587e87.3.1752682701827;
        Wed, 16 Jul 2025 09:18:21 -0700 (PDT)
Received: from cloudflare.com (79.184.150.73.ipv4.supernova.orange.pl. [79.184.150.73])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d32d7sm2691371e87.140.2025.07.16.09.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:18:20 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 16 Jul 2025 18:16:57 +0200
Subject: [PATCH bpf-next v2 13/13] selftests/bpf: Count successful bpf
 program runs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-skb-metadata-thru-dynptr-v2-13-5f580447e1df@cloudflare.com>
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

The skb metadata tests for BPF programs which don't have metadata access
yet have no observable side-effects. Hence, we can't detect breakage.

Count each successful BPF program pass, when taking the expected path, as a
side-effect to test for.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 20 +++++++++++++++-
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 28 ++++++++++++++--------
 2 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 97e1dae9a2e7..a28bf67b6d8d 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -294,13 +294,15 @@ void test_xdp_context_veth(void)
 static void test_tuntap(struct bpf_program *xdp_prog,
 			struct bpf_program *tc_prio_1_prog,
 			struct bpf_program *tc_prio_2_prog,
-			struct bpf_program *nf_prog,
+			struct bpf_program *nf_prog, __u32 *prog_run_cnt,
 			struct bpf_map *result_map)
 {
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
 	struct bpf_link *nf_link = NULL;
 	struct netns_obj *ns = NULL;
 	__u8 packet[PACKET_LEN];
+	__u32 want_run_cnt = 0;
+	__u32 have_run_cnt;
 	int tap_fd = -1;
 	int tap_ifindex;
 	int ret;
@@ -336,6 +338,7 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 		ret = bpf_tc_attach(&tc_hook, &tc_opts);
 		if (!ASSERT_OK(ret, "bpf_tc_attach"))
 			goto close;
+		want_run_cnt++;
 	}
 
 	if (tc_prio_2_prog) {
@@ -345,6 +348,7 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 		ret = bpf_tc_attach(&tc_hook, &tc_opts);
 		if (!ASSERT_OK(ret, "bpf_tc_attach"))
 			goto close;
+		want_run_cnt++;
 	}
 
 	if (nf_prog) {
@@ -354,18 +358,25 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 		nf_link = bpf_program__attach_netfilter(nf_prog, &nf_opts);
 		if (!ASSERT_OK_PTR(nf_link, "attach_netfilter"))
 			goto close;
+		want_run_cnt++;
 	}
 
 	ret = bpf_xdp_attach(tap_ifindex, bpf_program__fd(xdp_prog),
 			     0, NULL);
 	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
 		goto close;
+	want_run_cnt++;
 
 	init_test_packet(packet);
 	ret = write(tap_fd, packet, sizeof(packet));
 	if (!ASSERT_EQ(ret, sizeof(packet), "write packet"))
 		goto close;
 
+	have_run_cnt = __atomic_exchange_n(prog_run_cnt, 0, __ATOMIC_SEQ_CST);
+	if (!ASSERT_EQ(have_run_cnt, want_run_cnt,
+		       "unexpected bpf prog runs"))
+		goto close;
+
 	if (result_map)
 		assert_test_result(result_map);
 
@@ -390,42 +401,49 @@ void test_xdp_context_tuntap(void)
 			    skel->progs.ing_cls,
 			    NULL, /* tc prio 2 */
 			    NULL, /* netfilter */
+			    &skel->bss->prog_run_cnt,
 			    skel->maps.test_result);
 	if (test__start_subtest("dynptr_read"))
 		test_tuntap(skel->progs.ing_xdp,
 			    skel->progs.ing_cls_dynptr_read,
 			    NULL, /* tc prio 2 */
 			    NULL, /* netfilter */
+			    &skel->bss->prog_run_cnt,
 			    skel->maps.test_result);
 	if (test__start_subtest("dynptr_slice"))
 		test_tuntap(skel->progs.ing_xdp,
 			    skel->progs.ing_cls_dynptr_slice,
 			    NULL, /* tc prio 2 */
 			    NULL, /* netfilter */
+			    &skel->bss->prog_run_cnt,
 			    skel->maps.test_result);
 	if (test__start_subtest("dynptr_write"))
 		test_tuntap(skel->progs.ing_xdp_zalloc_meta,
 			    skel->progs.ing_cls_dynptr_write,
 			    skel->progs.ing_cls_dynptr_read,
 			    NULL, /* netfilter */
+			    &skel->bss->prog_run_cnt,
 			    skel->maps.test_result);
 	if (test__start_subtest("dynptr_slice_rdwr"))
 		test_tuntap(skel->progs.ing_xdp_zalloc_meta,
 			    skel->progs.ing_cls_dynptr_slice_rdwr,
 			    skel->progs.ing_cls_dynptr_slice,
 			    NULL, /* netfilter */
+			    &skel->bss->prog_run_cnt,
 			    skel->maps.test_result);
 	if (test__start_subtest("dynptr_offset"))
 		test_tuntap(skel->progs.ing_xdp_zalloc_meta,
 			    skel->progs.ing_cls_dynptr_offset_wr,
 			    skel->progs.ing_cls_dynptr_offset_rd,
 			    NULL, /* netfilter */
+			    &skel->bss->prog_run_cnt,
 			    skel->maps.test_result);
 	if (test__start_subtest("dynptr_nf_hook"))
 		test_tuntap(skel->progs.ing_xdp,
 			    NULL, /* tc prio 1 */
 			    NULL, /* tc prio 2 */
 			    skel->progs.ing_nf,
+			    &skel->bss->prog_run_cnt,
 			    NULL /* ignore result for now */);
 
 	test_xdp_meta__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index a42a6dd4343c..3731baf37e06 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -35,6 +35,14 @@ struct {
 	__uint(value_size, META_SIZE);
 } test_result SEC(".maps");
 
+__u32 prog_run_cnt = 0;
+
+static __always_inline int run_ok(int retval)
+{
+	__sync_fetch_and_add(&prog_run_cnt, 1);
+	return retval;
+}
+
 SEC("tc")
 int ing_cls(struct __sk_buff *ctx)
 {
@@ -49,7 +57,7 @@ int ing_cls(struct __sk_buff *ctx)
 
 	bpf_map_update_elem(&test_result, &key, data_meta, BPF_ANY);
 
-	return TC_ACT_SHOT;
+	return run_ok(TC_ACT_SHOT);
 }
 
 /* Read from metadata using bpf_dynptr_read helper */
@@ -67,7 +75,7 @@ int ing_cls_dynptr_read(struct __sk_buff *ctx)
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
 	bpf_dynptr_read(dst, META_SIZE, &meta, 0, 0);
 
-	return TC_ACT_SHOT;
+	return run_ok(TC_ACT_SHOT);
 }
 
 /* Check that we can't get a dynptr slice to skb metadata yet */
@@ -81,7 +89,7 @@ int ing_nf(struct bpf_nf_ctx *ctx)
 	if (bpf_dynptr_size(&meta) != 0)
 		return NF_DROP;
 
-	return NF_ACCEPT;
+	return run_ok(NF_ACCEPT);
 }
 
 /* Write to metadata using bpf_dynptr_write helper */
@@ -99,7 +107,7 @@ int ing_cls_dynptr_write(struct __sk_buff *ctx)
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
 	bpf_dynptr_write(&meta, 0, src, META_SIZE, 0);
 
-	return TC_ACT_UNSPEC; /* pass */
+	return run_ok(TC_ACT_UNSPEC); /* pass */
 }
 
 /* Read from metadata using read-only dynptr slice */
@@ -121,7 +129,7 @@ int ing_cls_dynptr_slice(struct __sk_buff *ctx)
 
 	__builtin_memcpy(dst, src, META_SIZE);
 
-	return TC_ACT_SHOT;
+	return run_ok(TC_ACT_SHOT);
 }
 
 /* Write to metadata using writeable dynptr slice */
@@ -143,7 +151,7 @@ int ing_cls_dynptr_slice_rdwr(struct __sk_buff *ctx)
 
 	__builtin_memcpy(dst, src, META_SIZE);
 
-	return TC_ACT_UNSPEC; /* pass */
+	return run_ok(TC_ACT_UNSPEC); /* pass */
 }
 
 /*
@@ -181,7 +189,7 @@ int ing_cls_dynptr_offset_rd(struct __sk_buff *ctx)
 		return TC_ACT_SHOT;
 	__builtin_memcpy(dst, src, chunk_len);
 
-	return TC_ACT_SHOT;
+	return run_ok(TC_ACT_SHOT);
 }
 
 /* Write skb metadata in chunks at various offsets in different ways. */
@@ -216,7 +224,7 @@ int ing_cls_dynptr_offset_wr(struct __sk_buff *ctx)
 		return TC_ACT_SHOT;
 	__builtin_memcpy(dst, src, chunk_len);
 
-	return TC_ACT_UNSPEC; /* pass */
+	return run_ok(TC_ACT_UNSPEC); /* pass */
 }
 
 /* Reserve and clear space for metadata but don't populate it */
@@ -247,7 +255,7 @@ int ing_xdp_zalloc_meta(struct xdp_md *ctx)
 
 	__builtin_memset(meta, 0, META_SIZE);
 
-	return XDP_PASS;
+	return run_ok(XDP_PASS);
 }
 
 SEC("xdp")
@@ -278,7 +286,7 @@ int ing_xdp(struct xdp_md *ctx)
 		return XDP_DROP;
 
 	__builtin_memcpy(data_meta, payload, META_SIZE);
-	return XDP_PASS;
+	return run_ok(XDP_PASS);
 }
 
 char _license[] SEC("license") = "GPL";

-- 
2.43.0


