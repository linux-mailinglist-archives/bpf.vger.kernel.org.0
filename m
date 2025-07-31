Return-Path: <bpf+bounces-64798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A3EB16F8D
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 12:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11D01888F68
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 10:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7522BEC55;
	Thu, 31 Jul 2025 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ItuEXzAE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EDB2BEC2F
	for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957724; cv=none; b=f0PyexY68nKnWQkfl7xuSDIMGR0g0atrjoKUitrlzfyrykEHL4cbp1n/uKCF5rordOQAzF9MoXugh4ofluT/i1Ap0NJaNcg6DywNFJ4ArD7g5LduGGYDZsn3fyafB1vllu4FNvFtASp9sEj/dfnmwuKczjQQGFUfHoxFD1IN4og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957724; c=relaxed/simple;
	bh=Ies+heGyxXCUihSsdFFrXXScyXFQwEfc1FxVWkuz1Ho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c0bhNXySgqO/jAUbl4BVpdS1BHzd+BwadSCTzm6pV6Ar72qqsTyHTQnstbU/EgvwV+I8gMSIFXaPeefEuE6X376Yg/SFhdxHzIEYh/G+03VrDBO36ifbwOPAgHE3ekUC5S6NPGn44p5jkZqgumVhIqQ3hKJuhLBaaeXCKE52iYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ItuEXzAE; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-615622ed70fso363206a12.3
        for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 03:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753957721; x=1754562521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZOVO8FzrCbiLT2nUKnJ8wTwY2dAM9GRGmZiNXnZe0Q=;
        b=ItuEXzAEpzc7K5+tnjQmYTRz64dKwMl7dJByvuhj7qBKKt6AEPISyh06U2dkmBkD4D
         bgeZdE5Nl8uTg/+f8mSNm6yhTTRShhFTJeOzPrfkynsXO7lYImjOCW2lEZUM3IckdGYM
         vjiAmYSDDIBAf4ObyFn5Er9hW8wShH4P73mJ2Q+Luz8FFP9L+ufETw6jDiTWbt9eCcdx
         tgZSi9sGSqSlXMAmpUUmzo/OkJ59fuoNvYTt907LWkvrRdQ4/hVxUCBAQTpVWQN4Jflq
         FUA/4JfrikJFlIv273QByxSDd3U9te8Qi+Ppzazes5LxIsHSsWj0gbpW4AXiDHrQ5KSV
         0tBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753957721; x=1754562521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZOVO8FzrCbiLT2nUKnJ8wTwY2dAM9GRGmZiNXnZe0Q=;
        b=eb//OxlJVQ2Eg984kO261FHEkrl8AHg5iEsfPr00oIUdNU0agSaQUwCkzGcxstIfIf
         YrP2kCsKYIRpWYSEJFTChebhwjP0BKT+FdSb90/IpvM2D4ERmzfRzquahjoUD3rCznjz
         jbhdNsB5TKYaSFeaskllvg7F/HGChUutrGo0gPn3YpE9Wx3kpa3uyk87skBJDZwLp1m0
         U4nBYlf+jcoE85LFhPJLyH2xbYKZC/oYlSMxnEWJ3rlFy8Qihu+GE+5sqXWuVGhg0w47
         kLiDsdS4HamWENC8UyswX2Wu3zK7VTZQ/XGZZ9lCXl0jJ0HsNGYux9g7j0i0s8SI6NLY
         Rnnw==
X-Gm-Message-State: AOJu0YySH14S8oOGxaJib8zA4q4r5z/U0vC675FxNg7M8vCNXY0Ujotf
	6N8CWLIgMMMFTT+wPwjso4v4YVUfRQXpf7z4oXVGg2RGULLB8ZcRJwRdplYdsviwG3Y=
X-Gm-Gg: ASbGncuXzdj0CIRc6h5KARaOHNAdzDbiSeQSSdKoEPkwsbRB+uHTE/jxng2Ey6QbsEU
	L9LcgBkuuqjwq33g7O48k2hjThHTum2ntoYhl6PySF1Q8AgRAV1yXaNPlfU7JWCB1quftRMJXzK
	ZQcxuIlluRMHadMFJCOgMbDTOIyVed0eeZ4MxP7y2TzqFkFh7CnuK1eJ/GyXACqHSpn/lisxUXC
	y+6ZDPkbJB/XsWiuWwH9WxDAbE//I2f9oga2u4Oz23AC97XXO5RBJaAjS+xzHpc49rcTeKKCmsx
	srOSn1EFtGWrszQB3c7y2QKDNfmbVbwB4tT+O7vfrWSy5gqb4ZSu12Z3JbhemAna0tZbaZSykUX
	+AzBxOLlue8/D0hg=
X-Google-Smtp-Source: AGHT+IEaYjRkiP9zteQUylEuxWP+uWh3+6GtLivdlr5uogNVh0fky2CJ8uG77q91VxjzwwGeoef16Q==
X-Received: by 2002:a17:907:9406:b0:ae3:5e70:330d with SMTP id a640c23a62f3a-af8fd691104mr696096366b.12.1753957721211;
        Thu, 31 Jul 2025 03:28:41 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:eb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c0a4sm87360466b.109.2025.07.31.03.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:28:40 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 31 Jul 2025 12:28:20 +0200
Subject: [PATCH bpf-next v5 6/9] selftests/bpf: Cover read access to skb
 metadata via dynptr
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-skb-metadata-thru-dynptr-v5-6-f02f6b5688dc@cloudflare.com>
References: <20250731-skb-metadata-thru-dynptr-v5-0-f02f6b5688dc@cloudflare.com>
In-Reply-To: <20250731-skb-metadata-thru-dynptr-v5-0-f02f6b5688dc@cloudflare.com>
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

Exercise reading from SKB metadata area in two new ways:
1. indirectly, with bpf_dynptr_read(), and
2. directly, with bpf_dynptr_slice().

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
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


