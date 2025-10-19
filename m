Return-Path: <bpf+bounces-71303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2102BEE55A
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 14:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B91A188EC3C
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 12:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5A42E9ED8;
	Sun, 19 Oct 2025 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UdMPpHRE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AC82E8DEB
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877959; cv=none; b=jCEHfpVea2ivPxxXXoIultzIhuil8Ap0+krfjZWOFFA2M+2qOkdHvD4zNn0InsDZpafqgSguCkzu+yZyoWiW06TvAy1VkjFa0PLSNASiln0xv4GlV8x2EcBghkzCGs16pEp+zRJfCDkP4V0dNbvvhHRl/nC9icw5H6rGDXSsHCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877959; c=relaxed/simple;
	bh=4TfFid1Q979uRTwKiHMvMpp33YFmvZtP/kUKMyZ8CWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e+etEUhBXQCiZGcQ3/N7KhnBzkI57xntrk4futT5nrUoKLma17tnTgvQW5eA+mQhjsRJw3ZaDJHDNbkJWEGUo8SjllvDjVvt8zgf50F4r4yRJHRlH7xwhBL0y+sr1CTJfzhDQiKo4LfIsOXSEaosORvGmMwiTam/OY+BoNLz9bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UdMPpHRE; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3ee18913c0so643105466b.3
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 05:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877956; x=1761482756; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edqy55xm7sHdms5uig9C4VS/gSulJmnweBVEeyzGNWw=;
        b=UdMPpHRE1OfzesbSyHzYmVzVn4Y1vh0qMx5DGYWOahiPaRigYPUStHMl22NOtxDS8K
         yLY4We8KIaFPtJPA79KwW93Jws7lhac2LWyrBbG3bQ7d8vNRjobdwG4QGpTO2Wp9ATZ4
         d4b1IQSmfcSBLxjyDwEnGjbR9e8k6TMigz3MsfMTATH0OUSfeKW/HKdN38W237+bD04K
         cN/ptKWNfXDYqZ/tB4WpAYSE7ml9s8nbCGueGy15fLAjpDkoQPsnE4J69R7gXCSYIj8W
         vwyvALkuGcl5dOMSaiGX4JYDvJDI3a2gKXomLqRGqsTfmysonJ/SCKksX7YppQqZOEVA
         p9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877956; x=1761482756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edqy55xm7sHdms5uig9C4VS/gSulJmnweBVEeyzGNWw=;
        b=j+T7two0+rnzsnR5F5QKZBAqVWjHhvk/4p7Eh5UVrKric5SV6/aiUkgI9zBV1zbfuy
         ddmb3JCuZFsjBz2s5HsjgQqcw7QQ5NSD3HIoGvPPYRh0J0MU/5CVCJKl7oM/faGy1UU0
         Kt7uGAp+zJLnajAZaWwfpSCP3Vya+32psg1r5PvvJbGv5cwZGziNlTVCGWlja1/Gt0uN
         Hml1hf2mz91igFRM07gmcUTDct9W8B2BHpxcpJ0tF/lkVWeZmkqpH1d2d/eyty7JQHBi
         h5YXELGEleXYwgp+6FxHnBmz0usomAkQLajbZsJOvyNwLQfp/31ywwhnej1Oydxnkr3M
         BGHw==
X-Gm-Message-State: AOJu0YzFP1Xb6XLx3N3IyUDPxVDkY93kVBtkLl5GGABgC+ghh/z5PEvz
	+uP2fCFJZQOU2gu9Gm1FujULNLI4k5n+LKYQ35iW57bxjFm6q3z9fhkFL4xNisTg/Yw=
X-Gm-Gg: ASbGnctzwU3XZ6XGsM0iemoAeQkNxHkPuwAxhc1AQGe1Ibz/tdJNx+1eHlOFuBk17so
	Owk1BZ9nUbpVEAxXUi/zW32IzVt/GOeCgFhQe7Kqk3SweW0uIpgz4vLcuqKXUjg5eX+YShUS1yu
	LtdxhQ2z3MapCU7kjorMci9aZDpfH+IiSgL+CPmzWuS3/EFwc9ikxptEZsL5W4UaTa1IX4WM23q
	cTO0EyxEcc/D+vslZ5VDvvqwkkVly089LZVJxSi2LnETlgwgo4el+cDBSA4Gqm8WQWvd+ulRlcp
	atLZMEjqpmu7DDHuRJlpngJgMyWn1iaS4IRA/5Zy0e50hZWzN3yIirhktS4MgsgAD7EFfvhacLu
	13kZ7p+5HDM2HlFaib6KyMGj2K14Ljj4fLJuygep1KXN/Lm0p6uWN3eGajcDrlqdQsNA5jY+ekl
	2FIqHocPPZl3V9Us+2epTFppe/EatbG1E1FMd6MzyxI/fSGiKkCyaZ/1HTdPs=
X-Google-Smtp-Source: AGHT+IHVPGlkg420JhQ+8mouCnXDQd+q9hQiid4tAsaJKmGhrqt0eLx73f3dmzhoazYrDblZokwNfA==
X-Received: by 2002:a17:907:3d02:b0:b45:44f4:30e1 with SMTP id a640c23a62f3a-b647443cf27mr1067783766b.34.1760877956299;
        Sun, 19 Oct 2025 05:45:56 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da1b96sm498165066b.1.2025.10.19.05.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:45:55 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:33 +0200
Subject: [PATCH bpf-next v2 09/15] selftests/bpf: Verify skb metadata in
 BPF instead of userspace
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-9-f9a58f3eb6d6@cloudflare.com>
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

Move metadata verification into the BPF TC programs. Previously,
userspace read metadata from a map and verified it once at test end.

Now TC programs compare metadata directly using __builtin_memcmp() and
set a test_pass flag. This enables verification at multiple points during
test execution rather than a single final check.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 52 ++++---------
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 88 +++++++++++-----------
 2 files changed, 57 insertions(+), 83 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 178292d1251a..93a1fbe6a4fd 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -171,33 +171,6 @@ static int write_test_packet(int tap_fd)
 	return 0;
 }
 
-static void assert_test_result(const struct bpf_map *result_map)
-{
-	int err;
-	__u32 map_key = 0;
-	__u8 map_value[TEST_PAYLOAD_LEN];
-
-	err = bpf_map__lookup_elem(result_map, &map_key, sizeof(map_key),
-				   &map_value, TEST_PAYLOAD_LEN, BPF_ANY);
-	if (!ASSERT_OK(err, "lookup test_result"))
-		return;
-
-	ASSERT_MEMEQ(&map_value, &test_payload, TEST_PAYLOAD_LEN,
-		     "test_result map contains test payload");
-}
-
-static bool clear_test_result(struct bpf_map *result_map)
-{
-	const __u8 v[sizeof(test_payload)] = {};
-	const __u32 k = 0;
-	int err;
-
-	err = bpf_map__update_elem(result_map, &k, sizeof(k), v, sizeof(v), BPF_ANY);
-	ASSERT_OK(err, "update test_result");
-
-	return err == 0;
-}
-
 void test_xdp_context_veth(void)
 {
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
@@ -270,11 +243,13 @@ void test_xdp_context_veth(void)
 	if (!ASSERT_GE(tx_ifindex, 0, "if_nametoindex tx"))
 		goto close;
 
+	skel->bss->test_pass = false;
+
 	ret = send_test_packet(tx_ifindex);
 	if (!ASSERT_OK(ret, "send_test_packet"))
 		goto close;
 
-	assert_test_result(skel->maps.test_result);
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
 
 close:
 	close_netns(nstoken);
@@ -286,7 +261,7 @@ void test_xdp_context_veth(void)
 static void test_tuntap(struct bpf_program *xdp_prog,
 			struct bpf_program *tc_prio_1_prog,
 			struct bpf_program *tc_prio_2_prog,
-			struct bpf_map *result_map)
+			bool *test_pass)
 {
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
 	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
@@ -295,8 +270,7 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 	int tap_ifindex;
 	int ret;
 
-	if (!clear_test_result(result_map))
-		return;
+	*test_pass = false;
 
 	ns = netns_new(TAP_NETNS, true);
 	if (!ASSERT_OK_PTR(ns, "create and open ns"))
@@ -340,7 +314,7 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 	if (!ASSERT_OK(ret, "write_test_packet"))
 		goto close;
 
-	assert_test_result(result_map);
+	ASSERT_TRUE(*test_pass, "test_pass");
 
 close:
 	if (tap_fd >= 0)
@@ -431,37 +405,37 @@ void test_xdp_context_tuntap(void)
 		test_tuntap(skel->progs.ing_xdp,
 			    skel->progs.ing_cls,
 			    NULL, /* tc prio 2 */
-			    skel->maps.test_result);
+			    &skel->bss->test_pass);
 	if (test__start_subtest("dynptr_read"))
 		test_tuntap(skel->progs.ing_xdp,
 			    skel->progs.ing_cls_dynptr_read,
 			    NULL, /* tc prio 2 */
-			    skel->maps.test_result);
+			    &skel->bss->test_pass);
 	if (test__start_subtest("dynptr_slice"))
 		test_tuntap(skel->progs.ing_xdp,
 			    skel->progs.ing_cls_dynptr_slice,
 			    NULL, /* tc prio 2 */
-			    skel->maps.test_result);
+			    &skel->bss->test_pass);
 	if (test__start_subtest("dynptr_write"))
 		test_tuntap(skel->progs.ing_xdp_zalloc_meta,
 			    skel->progs.ing_cls_dynptr_write,
 			    skel->progs.ing_cls_dynptr_read,
-			    skel->maps.test_result);
+			    &skel->bss->test_pass);
 	if (test__start_subtest("dynptr_slice_rdwr"))
 		test_tuntap(skel->progs.ing_xdp_zalloc_meta,
 			    skel->progs.ing_cls_dynptr_slice_rdwr,
 			    skel->progs.ing_cls_dynptr_slice,
-			    skel->maps.test_result);
+			    &skel->bss->test_pass);
 	if (test__start_subtest("dynptr_offset"))
 		test_tuntap(skel->progs.ing_xdp_zalloc_meta,
 			    skel->progs.ing_cls_dynptr_offset_wr,
 			    skel->progs.ing_cls_dynptr_offset_rd,
-			    skel->maps.test_result);
+			    &skel->bss->test_pass);
 	if (test__start_subtest("dynptr_offset_oob"))
 		test_tuntap(skel->progs.ing_xdp,
 			    skel->progs.ing_cls_dynptr_offset_oob,
 			    skel->progs.ing_cls,
-			    skel->maps.test_result);
+			    &skel->bss->test_pass);
 	if (test__start_subtest("clone_data_meta_empty_on_data_write"))
 		test_tuntap_mirred(skel->progs.ing_xdp,
 				   skel->progs.clone_data_meta_empty_on_data_write,
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index d79cb74b571e..11288b20f56c 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -11,37 +11,36 @@
 
 #define ctx_ptr(ctx, mem) (void *)(unsigned long)ctx->mem
 
-/* Demonstrates how metadata can be passed from an XDP program to a TC program
- * using bpf_xdp_adjust_meta.
- * For the sake of testing the metadata support in drivers, the XDP program uses
- * a fixed-size payload after the Ethernet header as metadata. The TC program
- * copies the metadata it receives into a map so it can be checked from
- * userspace.
+/* Demonstrate passing metadata from XDP to TC using bpf_xdp_adjust_meta.
+ *
+ * The XDP program extracts a fixed-size payload following the Ethernet header
+ * and stores it as packet metadata to test the driver's metadata support. The
+ * TC program then verifies if the passed metadata is correct.
  */
 
-struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 1);
-	__type(key, __u32);
-	__uint(value_size, META_SIZE);
-} test_result SEC(".maps");
-
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
-	__u8 *data, *data_meta;
-	__u32 key = 0;
-
-	data_meta = ctx_ptr(ctx, data_meta);
-	data      = ctx_ptr(ctx, data);
+	__u8 *meta_have = ctx_ptr(ctx, data_meta);
+	__u8 *data = ctx_ptr(ctx, data);
 
-	if (data_meta + META_SIZE > data)
-		return TC_ACT_SHOT;
+	if (meta_have + META_SIZE > data)
+		goto out;
 
-	bpf_map_update_elem(&test_result, &key, data_meta, BPF_ANY);
+	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
+		goto out;
 
+	test_pass = true;
+out:
 	return TC_ACT_SHOT;
 }
 
@@ -49,17 +48,17 @@ int ing_cls(struct __sk_buff *ctx)
 SEC("tc")
 int ing_cls_dynptr_read(struct __sk_buff *ctx)
 {
+	__u8 meta_have[META_SIZE];
 	struct bpf_dynptr meta;
-	const __u32 zero = 0;
-	__u8 *dst;
-
-	dst = bpf_map_lookup_elem(&test_result, &zero);
-	if (!dst)
-		return TC_ACT_SHOT;
 
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
-	bpf_dynptr_read(dst, META_SIZE, &meta, 0, 0);
+	bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0);
+
+	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
+		goto out;
 
+	test_pass = true;
+out:
 	return TC_ACT_SHOT;
 }
 
@@ -86,20 +85,18 @@ SEC("tc")
 int ing_cls_dynptr_slice(struct __sk_buff *ctx)
 {
 	struct bpf_dynptr meta;
-	const __u32 zero = 0;
-	__u8 *dst, *src;
-
-	dst = bpf_map_lookup_elem(&test_result, &zero);
-	if (!dst)
-		return TC_ACT_SHOT;
+	__u8 *meta_have;
 
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
-	src = bpf_dynptr_slice(&meta, 0, NULL, META_SIZE);
-	if (!src)
-		return TC_ACT_SHOT;
+	meta_have = bpf_dynptr_slice(&meta, 0, NULL, META_SIZE);
+	if (!meta_have)
+		goto out;
 
-	__builtin_memcpy(dst, src, META_SIZE);
+	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
+		goto out;
 
+	test_pass = true;
+out:
 	return TC_ACT_SHOT;
 }
 
@@ -129,14 +126,12 @@ int ing_cls_dynptr_slice_rdwr(struct __sk_buff *ctx)
 SEC("tc")
 int ing_cls_dynptr_offset_rd(struct __sk_buff *ctx)
 {
-	struct bpf_dynptr meta;
 	const __u32 chunk_len = META_SIZE / 4;
-	const __u32 zero = 0;
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
 	__u8 *dst, *src;
 
-	dst = bpf_map_lookup_elem(&test_result, &zero);
-	if (!dst)
-		return TC_ACT_SHOT;
+	dst = meta_have;
 
 	/* 1. Regular read */
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
@@ -155,9 +150,14 @@ int ing_cls_dynptr_offset_rd(struct __sk_buff *ctx)
 	/* 4. Read from a slice starting at an offset */
 	src = bpf_dynptr_slice(&meta, 2 * chunk_len, NULL, chunk_len);
 	if (!src)
-		return TC_ACT_SHOT;
+		goto out;
 	__builtin_memcpy(dst, src, chunk_len);
 
+	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
+		goto out;
+
+	test_pass = true;
+out:
 	return TC_ACT_SHOT;
 }
 

-- 
2.43.0


