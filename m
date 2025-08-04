Return-Path: <bpf+bounces-64997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00B3B1A261
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 14:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89B8A7A4177
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 12:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D282126E142;
	Mon,  4 Aug 2025 12:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eNNhoUvJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9792C26D4DE
	for <bpf@vger.kernel.org>; Mon,  4 Aug 2025 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311979; cv=none; b=OybQK6uw4f1Z75TZmx3q1sOKmy9fOU7mkndKmLv2rVSVtzrrz7WZT+qUuLDmzQmdhk084pNsJjnxEvOxXqGJZO46sne3GJedCBFnE3JDaCxn6DMraVFcGenNue13iHYNsORURIlLRgFF4dm2w4eCO99s0leIGVqdiaC76eo3u8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311979; c=relaxed/simple;
	bh=b2AErcy4JiasUYk6Ay8Qa4qaZtrlk5T4baTDWxVHQj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T1Ak4FBsJ7+JiGcjz5lckpDrCv2xT41Cu1z0uPw3qgFe/Si/NFzXUGeGyASdHF3mOV0H+6fn0dXsab0KzCj3SenIU7SZw77dXXglqhims6C94KnBJOdf3+GOlk2njC13ZapLLHzSVQPEpyxBxzVCzKuuK7789LMaUkRqfkcTHpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eNNhoUvJ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61571192ba5so6369778a12.2
        for <bpf@vger.kernel.org>; Mon, 04 Aug 2025 05:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754311974; x=1754916774; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lmcz013S0LSVkr6atlRSjhkmTXgOh1M6jbvUAXVLpHU=;
        b=eNNhoUvJH2E4/yvsWD7klLoA7ZkeIp2lp7rY7SnZk9XzyZtzs4kF5ENB2Zw5gylsjI
         ZkITeDZCbueiHdyviW9Zf3gN0de1IANyOO00mzi+FIDTFZjrn85NTzpO1oh8v+C1Ypi0
         bfwB18XfYJtoFsNDC4w/j64f8O2lIiz2ZMv+1ybxoPLbCYsglwUMLNnDaf5nQZ6Pb4nT
         Y+EpO7UD5RAPjRg0KNmY4synadT8fWCldNIIiO+Ts2TbxDMQkcOQDj1AMGeaQgL0F9pG
         D3h4i6ZfMx1N94TGOzwlm1zLuh8zNASp+AacmTwHIqsGMbFS6iZQOP5wRTrGVHSMs14Z
         2UtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311974; x=1754916774;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lmcz013S0LSVkr6atlRSjhkmTXgOh1M6jbvUAXVLpHU=;
        b=Szd/rLRJm/36/vt12i33+GMF7E4zmPrCVYrpGz2RdHnX6zeIP6OwXi7qPGVymOeO1V
         MgEeTkus3xqyC/8LQL9xYRKDDCUB3nsYiikMk6Bua2qrk/4eugLg9FbMVXhjoMK7y3uq
         35LfU7csNF7CsTx2wExfG3P2aRtmBfcImGsaDceCDK0jJuyKBvVcBY3wMlDOQjKu8Axb
         5jBuZ1MTY/bz2y1mDfIUx28Qm1QbRrFPn0B0JSf4fJsM6dtfVBBNMzycD6iOX6HzUxHf
         TuAPpxyZfytKvKR2dKidchUHp9lDVIsnA/jZ7eQWKQW26LwWB2Y2JlV1dwakf88oJeEX
         q9cw==
X-Gm-Message-State: AOJu0Yzb+O8cuo95EsduW3fnNzq4q7IOkbyl1cqn7IzWGfaK8ji0/Aa/
	qDbNSXqV2CyXlqDlFxr7u1HTsUoD1rJzr5y9cxhzKB6n9wiTMFn10stmOPugzv4Njiw=
X-Gm-Gg: ASbGncuKmGl+l2QQWXl4uGJspqErgxfjfOaw1BMUbN+gOUif927aE+lTXSdJ5zxGzRr
	LLP1IbE7oHQbO35CuQe2Fl/duhj/MasLQ1P/i8cJzBdago4zuyHDv4zzSnTLipYVGtgN7YpbGN9
	vVSr1bBXTqIB1asM1xgSJgCYxd1ZJhpvmci3tCf6FSY4v3LL5JvpEsJNtJU624rQZFV0TNZ87uV
	cBa7UYV0wjsLOboLFmIiDbW7eNjjjXo5nbOKhtegOPWs2ZeyyxrjfDsq3BFpBm0gxNV8J+ImB93
	l0/TKdRRy47LueeTcSGc8dlB5wA8iDPLCZTjy7cndjJdgZxlukYqSHTCR1UTfy0E90ZD/4EQctn
	fv6EJSUtX/GZ/gTI=
X-Google-Smtp-Source: AGHT+IGpWf1xM8VlrIrSEojHZjFfUA0HUVZ25SOt8E4VEka9M8EMRN1rA+ypuPnYwCNy4uD9LBeCrQ==
X-Received: by 2002:a17:907:86a0:b0:af9:3d0a:f391 with SMTP id a640c23a62f3a-af940169e8emr1023175166b.28.1754311974410;
        Mon, 04 Aug 2025 05:52:54 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:75])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7ac0sm6702781a12.35.2025.08.04.05.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:52:53 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 04 Aug 2025 14:52:30 +0200
Subject: [PATCH bpf-next v6 7/9] selftests/bpf: Cover write access to skb
 metadata via dynptr
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-skb-metadata-thru-dynptr-v6-7-05da400bfa4b@cloudflare.com>
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

Add tests what exercise writes to skb metadata in two ways:
1. indirectly, using bpf_dynptr_write helper,
2. directly, using a read-write dynptr slice.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 36 ++++++++++--
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 67 ++++++++++++++++++++++
 2 files changed, 98 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 7e4526461a4c..79c4c58276e6 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -269,7 +269,8 @@ void test_xdp_context_veth(void)
 }
 
 static void test_tuntap(struct bpf_program *xdp_prog,
-			struct bpf_program *tc_prog,
+			struct bpf_program *tc_prio_1_prog,
+			struct bpf_program *tc_prio_2_prog,
 			struct bpf_map *result_map)
 {
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
@@ -302,11 +303,20 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
 		goto close;
 
-	tc_opts.prog_fd = bpf_program__fd(tc_prog);
+	tc_opts.prog_fd = bpf_program__fd(tc_prio_1_prog);
 	ret = bpf_tc_attach(&tc_hook, &tc_opts);
 	if (!ASSERT_OK(ret, "bpf_tc_attach"))
 		goto close;
 
+	if (tc_prio_2_prog) {
+		LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 2,
+			    .prog_fd = bpf_program__fd(tc_prio_2_prog));
+
+		ret = bpf_tc_attach(&tc_hook, &tc_opts);
+		if (!ASSERT_OK(ret, "bpf_tc_attach"))
+			goto close;
+	}
+
 	ret = bpf_xdp_attach(tap_ifindex, bpf_program__fd(xdp_prog),
 			     0, NULL);
 	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
@@ -341,13 +351,29 @@ void test_xdp_context_tuntap(void)
 		return;
 
 	if (test__start_subtest("data_meta"))
-		test_tuntap(skel->progs.ing_xdp, skel->progs.ing_cls,
+		test_tuntap(skel->progs.ing_xdp,
+			    skel->progs.ing_cls,
+			    NULL, /* tc prio 2 */
 			    skel->maps.test_result);
 	if (test__start_subtest("dynptr_read"))
-		test_tuntap(skel->progs.ing_xdp, skel->progs.ing_cls_dynptr_read,
+		test_tuntap(skel->progs.ing_xdp,
+			    skel->progs.ing_cls_dynptr_read,
+			    NULL, /* tc prio 2 */
 			    skel->maps.test_result);
 	if (test__start_subtest("dynptr_slice"))
-		test_tuntap(skel->progs.ing_xdp, skel->progs.ing_cls_dynptr_slice,
+		test_tuntap(skel->progs.ing_xdp,
+			    skel->progs.ing_cls_dynptr_slice,
+			    NULL, /* tc prio 2 */
+			    skel->maps.test_result);
+	if (test__start_subtest("dynptr_write"))
+		test_tuntap(skel->progs.ing_xdp_zalloc_meta,
+			    skel->progs.ing_cls_dynptr_write,
+			    skel->progs.ing_cls_dynptr_read,
+			    skel->maps.test_result);
+	if (test__start_subtest("dynptr_slice_rdwr"))
+		test_tuntap(skel->progs.ing_xdp_zalloc_meta,
+			    skel->progs.ing_cls_dynptr_slice_rdwr,
+			    skel->progs.ing_cls_dynptr_slice,
 			    skel->maps.test_result);
 
 	test_xdp_meta__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 0ba647fb1b1d..e7879860f403 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -60,6 +60,24 @@ int ing_cls_dynptr_read(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+/* Write to metadata using bpf_dynptr_write helper */
+SEC("tc")
+int ing_cls_dynptr_write(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr data, meta;
+	__u8 *src;
+
+	bpf_dynptr_from_skb(ctx, 0, &data);
+	src = bpf_dynptr_slice(&data, sizeof(struct ethhdr), NULL, META_SIZE);
+	if (!src)
+		return TC_ACT_SHOT;
+
+	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+	bpf_dynptr_write(&meta, 0, src, META_SIZE, 0);
+
+	return TC_ACT_UNSPEC; /* pass */
+}
+
 /* Read from metadata using read-only dynptr slice */
 SEC("tc")
 int ing_cls_dynptr_slice(struct __sk_buff *ctx)
@@ -82,6 +100,55 @@ int ing_cls_dynptr_slice(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+/* Write to metadata using writeable dynptr slice */
+SEC("tc")
+int ing_cls_dynptr_slice_rdwr(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr data, meta;
+	__u8 *src, *dst;
+
+	bpf_dynptr_from_skb(ctx, 0, &data);
+	src = bpf_dynptr_slice(&data, sizeof(struct ethhdr), NULL, META_SIZE);
+	if (!src)
+		return TC_ACT_SHOT;
+
+	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+	dst = bpf_dynptr_slice_rdwr(&meta, 0, NULL, META_SIZE);
+	if (!dst)
+		return TC_ACT_SHOT;
+
+	__builtin_memcpy(dst, src, META_SIZE);
+
+	return TC_ACT_UNSPEC; /* pass */
+}
+
+/* Reserve and clear space for metadata but don't populate it */
+SEC("xdp")
+int ing_xdp_zalloc_meta(struct xdp_md *ctx)
+{
+	struct ethhdr *eth = ctx_ptr(ctx, data);
+	__u8 *meta;
+	int ret;
+
+	/* Drop any non-test packets */
+	if (eth + 1 > ctx_ptr(ctx, data_end))
+		return XDP_DROP;
+	if (eth->h_proto != 0)
+		return XDP_DROP;
+
+	ret = bpf_xdp_adjust_meta(ctx, -META_SIZE);
+	if (ret < 0)
+		return XDP_DROP;
+
+	meta = ctx_ptr(ctx, data_meta);
+	if (meta + META_SIZE > ctx_ptr(ctx, data))
+		return XDP_DROP;
+
+	__builtin_memset(meta, 0, META_SIZE);
+
+	return XDP_PASS;
+}
+
 SEC("xdp")
 int ing_xdp(struct xdp_md *ctx)
 {

-- 
2.43.0


