Return-Path: <bpf+bounces-61850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE0AAEE1A9
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 16:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D1297AFFAE
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 14:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDC32918DE;
	Mon, 30 Jun 2025 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YAT4Tdt9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E875A291880
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295379; cv=none; b=bG7iEkVcMOqsgyFJ4+mP0n1cEeGbNepvDhy8InVVyNVkw7x5fwlJA2z80vjqSOpffrEwLAof0HTctlnrke53vnScWRtujBlW1T8BELuP+zgjOM7LKcbm3jSx7T7AxZWRjhyXB995nXAphOBP7rpyA6xlseqMhg5OH6qxuT1rd0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295379; c=relaxed/simple;
	bh=U5Auxh8BDDEl8SK9bxtM3C37TfQSjLgF7Ql3LN/BH20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OaBhi9M+iSIaIUZU9TR4k06FJ72D4SANOPNpEz2I5CsJHoWyvZHqElNF6Jatl8CyESIa5MbSXbPFzsxvOfIgOAnFrOBbZ/CZsjx/kQZK96m9qCcEl+xRRiGLqZMKEqEkXz6ozMGl1pDbD+AgYVRo8a/mYpige4euh7UMRaBVqf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YAT4Tdt9; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0e0271d82so779657466b.3
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 07:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751295375; x=1751900175; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+epAvM8wl1C4tJt+H2ITwz5xvW8WbgvFtLs9EvVf4Uk=;
        b=YAT4Tdt9NYrryM2cR+jh2/CWlIimxSmAp1kYdO9W8wxNxsK4w9dDmK50T/zYygwLK8
         tRNrrVmK+VZueW7y/PuB/4mQvvgtH6uLy0QXEgb+yQPgV6RJEJOnttjB02O6bnsdEC9J
         tKOBHPqT2X2oqqtRiszIBDI27yt+EoRE3IYPnmD+7AMTmCWBscVup6Pf76OiYvok95T+
         AjSUOQ2479Gu/CoYRha9bL8GRinCsYM24tZoWCBgq5zilaZS6wCBeLHJCpTViODBG/Vx
         VM5f87TZ/RCMJXjp5V7xSj9sWhMvFXb4Gsso9YHGVmE8zHJj6x7rKWRYZ0kReDyBD5U0
         M+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295375; x=1751900175;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+epAvM8wl1C4tJt+H2ITwz5xvW8WbgvFtLs9EvVf4Uk=;
        b=IF7eo8Zpw0TjSHpuCMDEFzshXjwPTv98Z46VU5mME24TphPtYC9dVUAC/KI7wD6RR1
         3hH6vq3yo1cOoqpo/RQbmA5uWVhTzFjxZVEpdainkPL2XUJghgYR+tvnrf6iS4vkD4T7
         zxiMqkpozIFS1WhzCSJHikQBRnxEQ0dTZ4RrwYtFVguvnQc+zcbWIcqr3Y46cuFErsrK
         HBaKSyFrTRBdHQiQXGEWn4l1DdFmCGGdZubMIX4QKRtxaj29mmI0f79yBdi9f7NX335h
         gOAfvfUh2o9GymKB/04DMEQ6lodKKGD0OoJ5ana2qdCBsohJzdrOAlBQ6Wnscif9oWCb
         hmtQ==
X-Gm-Message-State: AOJu0Ywm6EbYa11LqZ0qSwlNgNhXMOewCqxyEiShiyCbR3CoEs2HBEtt
	YoiweIH0Dz8FQtLefIwshHd7wVG/UE5JX9muMhA56yfPzNJDeMNKtRSc71cxwU+C+Ok=
X-Gm-Gg: ASbGncuVj3gF8TWL4/5Aw5z2ab62/BPdrY4Gp7Qw8/t3Y/cO6yYFNeB5t/icb8Bwwgj
	1nxfRedysNV8C+G1gGvogvFgjPqPA7D6s2OlwX/eNlXf+qzgWwHVYCmChWxstAN2fJOPMfrsJuk
	ndQT7HSnRCzWjdcWGPFSypLF36g/L8QP0dK/3IR21DYsVt59p9cE1rIMgka6h4dNhn1u4s6Bz1R
	z2iBCHs6Z1zI/J1J8wt0zO4zXErzjPLCMCcJesAxkPkyGL+uWUdf2ryehS0jN4TKAOgPaDY0fTE
	1as0z1+6OYPzeJyyE63yaIP0QChCVqtt6d3tF4oz1hO9r5jMtjp9Kw==
X-Google-Smtp-Source: AGHT+IHUQZ7GrvzhKg9EL19o4Ocm0Do7ugMq27m9hpeFZnUf/F8eHs7qcb7IAPvy/gdEAHOnMQ135g==
X-Received: by 2002:a17:906:d7cd:b0:ae3:502f:cdea with SMTP id a640c23a62f3a-ae3502fee7amr1137149066b.60.1751295375142;
        Mon, 30 Jun 2025 07:56:15 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:10a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3918e4c78sm219670766b.100.2025.06.30.07.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:56:14 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 30 Jun 2025 16:55:46 +0200
Subject: [PATCH bpf-next 13/13] selftests/bpf: Count successful bpf program
 runs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-skb-metadata-thru-dynptr-v1-13-f17da13625d8@cloudflare.com>
References: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
In-Reply-To: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Arthur Fabre <arthur@arthurfabre.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

The skb metadata tests for BPF programs which don't have metadata access
yet have no observable side-effects. Hence, we can't detect breakage.

Count each successful BPF program pass, when taking the expected path, as a
side-effect to test for.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 19 ++++++++++++++++-
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 24 ++++++++++++++--------
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 4cf8e009a054..b9c9f874f1b4 100644
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
 
@@ -390,36 +401,42 @@ void test_xdp_context_tuntap(void)
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
 	if (test__start_subtest("dynptr_nf_hook"))
 		test_tuntap(skel->progs.ing_xdp,
 			    NULL, /* tc prio 1 */
 			    NULL, /* tc prio 2 */
 			    skel->progs.ing_nf,
+			    &skel->bss->prog_run_cnt,
 			    NULL /* ignore result for now */);
 
 	test_xdp_meta__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 41411d164190..ae149e45cf0c 100644
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
 	bpf_dynptr_from_skb(ctx, BPF_DYNPTR_F_SKB_METADATA, &meta);
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
 	bpf_dynptr_from_skb(ctx, BPF_DYNPTR_F_SKB_METADATA, &meta);
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
 
 /* Reserve and clear space for metadata but don't populate it */
@@ -174,7 +182,7 @@ int ing_xdp_zalloc_meta(struct xdp_md *ctx)
 
 	__builtin_memset(meta, 0, META_SIZE);
 
-	return XDP_PASS;
+	return run_ok(XDP_PASS);
 }
 
 SEC("xdp")
@@ -205,7 +213,7 @@ int ing_xdp(struct xdp_md *ctx)
 		return XDP_DROP;
 
 	__builtin_memcpy(data_meta, payload, META_SIZE);
-	return XDP_PASS;
+	return run_ok(XDP_PASS);
 }
 
 char _license[] SEC("license") = "GPL";

-- 
2.43.0


