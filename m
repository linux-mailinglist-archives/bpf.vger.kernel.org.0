Return-Path: <bpf+bounces-63905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69372B0C1C5
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 12:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887E93ADA2B
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 10:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9047293C70;
	Mon, 21 Jul 2025 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OdPjAq3y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6086293B48
	for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095219; cv=none; b=SS9P4fOyMWTeqAF68RCp5ENoSEnA0dJBTL2nI95l1/lOz+PawCovlRl5hKjhUU7NATsvZ+dklqS/79ywD8VEWWJxPp5Zfyu06znoJNy4jTxTYQOevV4By7NpDP1vdy66yiYimAEYLnxE61qEIZug42Rhmjkw0Ph75hXlMHIp8Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095219; c=relaxed/simple;
	bh=2IhA+8Yp6tdoWboGLeolLyAE9sXwbLuuHBB7k0rNT04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dUQSPT9Pcpgao9DOHoESba/64Js1jrOr/GhoYOhRCjpqtq1rxgoVhM/MUPZ67Xmx4UPJrukfbV4lYJD4gpay+VdsMWqowrBK66lJIofnruiHc5nJwdzPARbUJLd2kFHE1xmO2Nid0LJMeuSKKZLD3xp2N5BepoR3qODOdRnNEvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OdPjAq3y; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-612a338aed8so6239190a12.1
        for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 03:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753095216; x=1753700016; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZ6oWCfIdAcGNSgPLjXqQ5VaUSy7YhUQ2wzzt4VKYFw=;
        b=OdPjAq3y+3XaEoaOFp4Lo/7rHUnzkhjHpaUiYfUkAeE+Xj4KGW+n92a8CCsEf1XLoe
         wXSCJd3Xrq8XBqEPDTc/qN4yNxsBBAlg64eHmvWSorUx2QePJw7idwdQ3WjbU3D32FxL
         /HcGdVTNJKc8RrPiq1E/NhPjyQSqGPec5hqaCEG1FlctHaqh437OxKMS2vodbwwlraYd
         0ifuLt/+b8iO3AhWEaaf3dn1Kj44xFjsw0E3u9x3yDXMx3xpCaKEFK09QE70wIoVOj0g
         a4mkhgFFXeygA1CMaQLmKa4LqhDWjiXgfWA0Q2WVIAj/5IQ2a8PESKt9EjAc1PFHpNWi
         ww9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753095216; x=1753700016;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZ6oWCfIdAcGNSgPLjXqQ5VaUSy7YhUQ2wzzt4VKYFw=;
        b=Q/nI4NRj0vgjGA2o1AoVZMWKzh/aYCFyQ52CWx3WOJWKI4Xu5RpDrkekwzADBHK/U4
         iY5t2Q0cDppdhbo/bGNUqiZMmHcRzd9Ysqzrt0a/UHUHS3dJXQ1FbazTYB5PMYKfQYQv
         S+CHF7weQRlD+g9Ne856yEX464MvjDBW2q22AEb22uvZvH8QVgGcfSFSbjrHS0Xhm9cc
         CraDFhJevawfyMx0SQnZFonC+EB/RMjAExujZ5z8xK4Ibm5Wh9RSxRHXAOO/ti8dRddF
         LKN0JepzEmePh3Cipg/59vGDEsy2IZP6HKvVuqlfqLEZLvdv7ZEH0iJO8tzbfFsqO+54
         BsSg==
X-Gm-Message-State: AOJu0YxIQp5TsCooqK4WxU3Nvyj57Mte2FImNPtRmVsHOUmECLjcbOxp
	XvFc9hkEFL+IvliA0E1M8mNHUd9YBESFtIpstaISlYtCMfB/H3KAT/4Ex0cpsXAZ6N8=
X-Gm-Gg: ASbGncscXq9kYlhuEQDuXybtCUoBIm4av4KAsXWUmClorlpdCQf9gwj7HW4iaSAiu6A
	jOl3xQSzpGebKbnhjq9u6YkJGpfN4ZaPiwDOJzP/A1zEzswERjVrl+p2/0PL3nUV0V7gqXhTYKB
	w+EAVpNOeoWywk1o8wzme+/rm94ZaPFBgYHMjVdLOcLyIB1Fbm88SkiArJ0gRt686RZXcn0hP6r
	FSYCDN3kfv/pluiD0VxVspKa6rm7k+xGuN3+n0dGv6hDoomJv1tfHItWI4WNDaVEkPOw1zam9Cy
	erEzvcaLWkh4Xf1zL8rKiCJM5HQR+5JTAixVyjv0my4G2Al5GAmDIJThUNAYw9o0MJ/dj84IeHh
	V8rmc5nYkvVhnuw==
X-Google-Smtp-Source: AGHT+IGcTg/h3g0Pr/USgN4xBIROJzTDLnjOpf6gs5m79/hrxLmeD/wDevUM4Wuov2KMydsOxvCSZQ==
X-Received: by 2002:a17:907:3c82:b0:ade:2e4b:50d1 with SMTP id a640c23a62f3a-ae9ce0a5a13mr2017698966b.29.1753095215773;
        Mon, 21 Jul 2025 03:53:35 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6caf76bfsm659131666b.160.2025.07.21.03.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:53:35 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 21 Jul 2025 12:52:46 +0200
Subject: [PATCH bpf-next v3 08/10] selftests/bpf: Cover read access to skb
 metadata via dynptr
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-skb-metadata-thru-dynptr-v3-8-e92be5534174@cloudflare.com>
References: <20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
In-Reply-To: <20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>, 
 Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Exercise reading from SKB metadata area in two new ways:
1. indirectly, with bpf_dynptr_read(), and
2. directly, with bpf_dynptr_slice().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h           |  3 ++
 .../bpf/prog_tests/xdp_context_test_run.c          | 21 +++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 42 ++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 9386dfe8b884..794d44d19c88 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -19,6 +19,9 @@ extern int bpf_dynptr_from_skb(struct __sk_buff *skb, __u64 flags,
 extern int bpf_dynptr_from_xdp(struct xdp_md *xdp, __u64 flags,
 			       struct bpf_dynptr *ptr__uninit) __ksym __weak;
 
+extern int bpf_dynptr_from_skb_meta(struct __sk_buff *skb, __u64 flags,
+				    struct bpf_dynptr *ptr__uninit) __ksym __weak;
+
 /* Description
  *  Obtain a read-only pointer to the dynptr's data
  * Returns
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 6c66e27e5bc7..7e4526461a4c 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -171,6 +171,18 @@ static void assert_test_result(const struct bpf_map *result_map)
 		     "test_result map contains test payload");
 }
 
+static bool clear_test_result(struct bpf_map *result_map)
+{
+	const __u8 v[sizeof(test_payload)] = {};
+	const __u32 k = 0;
+	int err;
+
+	err = bpf_map__update_elem(result_map, &k, sizeof(k), v, sizeof(v), BPF_ANY);
+	ASSERT_OK(err, "update test_result");
+
+	return err == 0;
+}
+
 void test_xdp_context_veth(void)
 {
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
@@ -268,6 +280,9 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 	int tap_ifindex;
 	int ret;
 
+	if (!clear_test_result(result_map))
+		return;
+
 	ns = netns_new(TAP_NETNS, true);
 	if (!ASSERT_OK_PTR(ns, "create and open ns"))
 		return;
@@ -328,6 +343,12 @@ void test_xdp_context_tuntap(void)
 	if (test__start_subtest("data_meta"))
 		test_tuntap(skel->progs.ing_xdp, skel->progs.ing_cls,
 			    skel->maps.test_result);
+	if (test__start_subtest("dynptr_read"))
+		test_tuntap(skel->progs.ing_xdp, skel->progs.ing_cls_dynptr_read,
+			    skel->maps.test_result);
+	if (test__start_subtest("dynptr_slice"))
+		test_tuntap(skel->progs.ing_xdp, skel->progs.ing_cls_dynptr_slice,
+			    skel->maps.test_result);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index fcf6ca14f2ea..0ba647fb1b1d 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1,8 +1,10 @@
+#include <stdbool.h>
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
 #include <linux/pkt_cls.h>
 
 #include <bpf/bpf_helpers.h>
+#include "bpf_kfuncs.h"
 
 #define META_SIZE 32
 
@@ -40,6 +42,46 @@ int ing_cls(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+/* Read from metadata using bpf_dynptr_read helper */
+SEC("tc")
+int ing_cls_dynptr_read(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+	const __u32 zero = 0;
+	__u8 *dst;
+
+	dst = bpf_map_lookup_elem(&test_result, &zero);
+	if (!dst)
+		return TC_ACT_SHOT;
+
+	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+	bpf_dynptr_read(dst, META_SIZE, &meta, 0, 0);
+
+	return TC_ACT_SHOT;
+}
+
+/* Read from metadata using read-only dynptr slice */
+SEC("tc")
+int ing_cls_dynptr_slice(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+	const __u32 zero = 0;
+	__u8 *dst, *src;
+
+	dst = bpf_map_lookup_elem(&test_result, &zero);
+	if (!dst)
+		return TC_ACT_SHOT;
+
+	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+	src = bpf_dynptr_slice(&meta, 0, NULL, META_SIZE);
+	if (!src)
+		return TC_ACT_SHOT;
+
+	__builtin_memcpy(dst, src, META_SIZE);
+
+	return TC_ACT_SHOT;
+}
+
 SEC("xdp")
 int ing_xdp(struct xdp_md *ctx)
 {

-- 
2.43.0


