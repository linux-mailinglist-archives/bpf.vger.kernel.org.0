Return-Path: <bpf+bounces-64200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F12F8B0F97C
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 19:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A42A3A9F66
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 17:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F2B243370;
	Wed, 23 Jul 2025 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SdAw+bCJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C650241CB6
	for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292224; cv=none; b=H43OLwhNVJB7zQ90/eT6A705hP2Dj56wnVUKptUuwMummzZ6dZv9jHL0RlrnfGLYT8FCo7i+V8ojC4U1CB/b07fJTOVDtmeGvwYgfKbc+Xy7ks/DPRVzLLMqsCujU/Guly8Drs1On+HbfTXdGbqHwQWloV2zSMFIUXbBEZ+SAH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292224; c=relaxed/simple;
	bh=8UvmGS7h0yO0BSunpUymHkUESAoala8S1ndq9rN7ZTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YwK8rvvQlU7bZWBKQxUO6d1qOMtYtbaEEDYwjvMjIY8+KYZPfsQZ8k51lUCqNZoZbqndSqjW/FgoNFCysWDEXqcqiUaQESwBVAXeAoAnNUYAgVAddIZxsQ9O9fHZs8GAocHHnTw/Ro0CbR12zGT9n6b1JIz+mJFZ2ZRlfmgnJHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SdAw+bCJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso262221166b.0
        for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 10:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753292221; x=1753897021; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+9GnuERSsXNaL5bk3V6N2fM/0EV1p+TClLOoYPWF4Q=;
        b=SdAw+bCJhvQP1hI6FjVuk6WmVwRCFVe3TKZV07UFSvjuv/2jCddnXXHFgB+yg2wOvw
         nNVfonKq2K/lvZvgkRmQ7DAbwYI3FpWQ5sxKKkK84n5oN/ZyXChB97LgXMooZ2SAa5+h
         XktFr6gMYw5c1DpFMkSQ97Is1DrE0c0CbmN6bgyhFQDo9XOKS36SrvPWbW8kGeZn4p2o
         q70eWhJMCuNZAcwpVj52sAmQ/I/Hx38vJH9gFWkLaEKjtPTRYX9fDCmqezwU7lxOY7G6
         Vdr8ZIarLQ4mUE9fGBy7I3OzOeWZgX1lsLnYXuEhI4P9oyLCaZYKTsUfiLNwvpLn4fjI
         UNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753292221; x=1753897021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+9GnuERSsXNaL5bk3V6N2fM/0EV1p+TClLOoYPWF4Q=;
        b=GcpvUZbMFE1sie42tk/4mqjwSgxAMq/RsylYBpygfp9x8P6ygC64+ossXogR1vWMYc
         E+uKpBuMV8l8lB6hkWYwo0CMjGoeru87iQc2ymkUw8bhtjUfdltTgKrym9+FZALGCg6H
         qoAHVGLt4few8dyKmh8EGG0jhI4OkSifHS6WrHy/k31iwy4Zvg8iWBRpIQqkl+G/bagh
         +f5CxogdD9l1XIlyrskxemiAOCgnk+StIFTOmxPRCJGLDH/V3RkjGHFHf3yM0r7kMy+S
         DyMBNQr0SuLEtN0cj+PAXdBAOIIu407xnbTVTtVdkmknDhMgfb+F5+tGIhA4a+/CpvLe
         HZ5Q==
X-Gm-Message-State: AOJu0Yyx4VOmPBWL4QGlkTHP/r7ShOB/0D/Vz1QmRFiOiJr2Pshd4Zbn
	NnnSCN/wEBDoCUoFlIG3i993Ms8H/fILip1JtecJ8kYNGmI9oMBRWCIKQitTdwz0pkg=
X-Gm-Gg: ASbGncsrxvjH0IiwdVG95BR8lUmdUxy64tHKQqi8WRpaEt8NnoPzavWaWnW78MZmP5n
	jSfdUClyhN3YpGp619Cc3Su5buHFU41diOmXafE+0he2hQLL9XFgzgt4eTQhTJC2lenXkHVdecT
	lgSSzo20DMkErlzCimxAfNuvTNBKvctnvYvAmNCJcHL4RBbzBTd/NdeF/O7zjNCgaF+6JtJN0re
	Tm66hyX+pJNu23vsxPU+C2z/bWAuTqNOpujz80Qxda7baXDg38Q9CLtYvmaldzxJ19hHhqsrt5r
	+3w2l+nwAdALqKxKvylRYZoK+rOWJpBseIymWi6SkmFPAQTs+jsCsmJhlG01tHlgrizNypsaLEx
	rCczwypb2cBaCMQ8Q4InAQnRfcVscDwDsEuL6UEQSilIi9xW29WgRzx64rDE/zVZP56LyTR0=
X-Google-Smtp-Source: AGHT+IFc6HXavV66ybyLmOnG8N9+2YMBLbetQAFGzKIBuI04cFc74unXdMixC97uqsGJtG1LavcTQg==
X-Received: by 2002:a17:907:6ea7:b0:ae3:c72f:6383 with SMTP id a640c23a62f3a-af2f48b0ac8mr394506566b.17.1753292220717;
        Wed, 23 Jul 2025 10:37:00 -0700 (PDT)
Received: from cloudflare.com (79.184.149.187.ipv4.supernova.orange.pl. [79.184.149.187])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7c7ebdsm1074784666b.37.2025.07.23.10.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 10:37:00 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 23 Jul 2025 19:36:52 +0200
Subject: [PATCH bpf-next v4 7/8] selftests/bpf: Cover write access to skb
 metadata via dynptr
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-skb-metadata-thru-dynptr-v4-7-a0fed48bcd37@cloudflare.com>
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

Add tests what exercise writes to skb metadata in two ways:
1. indirectly, using bpf_dynptr_write helper,
2. directly, using a read-write dynptr slice.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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


