Return-Path: <bpf+bounces-64996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD843B1A256
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 14:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C7018848AE
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 12:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A0B25D202;
	Mon,  4 Aug 2025 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="W6PbhlC9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760C326C39F
	for <bpf@vger.kernel.org>; Mon,  4 Aug 2025 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311977; cv=none; b=ndvbjde3LJpXUtBPvBDVeZ/EVikij4gaKOp/FVEcHhLRgvm/gTDi62Ceml1x0jzSqn2dud4kxRZXIZHuyzOneimGI7wIx5D75Hc7hM2nRUKUcoGvUjjXtPRJqFH4S0aDLWJdQSAVDIGebE03O+9Nsidscv3zyGHJOIxcmpQ18z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311977; c=relaxed/simple;
	bh=Ies+heGyxXCUihSsdFFrXXScyXFQwEfc1FxVWkuz1Ho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s0mL0xLjRivWT0xFIboB+COUpO7cVUHdyVcTyAudpt0fO1CH6BDIxMCoforlbbzWMCaJ+d6EmHPRZ/3Gz2Y/LSkHfgEMOdcdLdmYkeawUo6gkdHdmdDaeMZ/JBUfaI+WbZOSUNUB40r/gO2+5Hd35fOmZ8/jo3Q4dkFKA9GJkbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=W6PbhlC9; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-af8f5e38a9fso749959166b.0
        for <bpf@vger.kernel.org>; Mon, 04 Aug 2025 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754311973; x=1754916773; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZOVO8FzrCbiLT2nUKnJ8wTwY2dAM9GRGmZiNXnZe0Q=;
        b=W6PbhlC94Hu8qzqGN+YXtGNL5cvulRkPIeHJtTgjeapxkztGDWgedviQBJ85y7BGNT
         jVWiy6Fz1eHi4zJAOKxt2D6V2NMcxSRZ1G164xahSO+p+QhyWaB4un8HwxxfHW03lK2u
         9sF7NEMrKZwWGx7s0pHum7JEaSXUMBTCEam/hPZFoGdrSgnLjuEoL3cri584cPeKN5ka
         QXDpcgmDcGmY8L7Iy6o/xG6MVMSYXY8ebD7JxnIr0R9DNkHQTGaX7D2WVX9+B/0ckHhx
         yQ1lnnVUJkCegGrA+fz/F6UqC3YGVoLdbe2EUIum+j2nZHa4BBVrTx2DWsk/BwGpefKR
         d1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311973; x=1754916773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZOVO8FzrCbiLT2nUKnJ8wTwY2dAM9GRGmZiNXnZe0Q=;
        b=Jo/YZ1eFDZVtd9qoaBtD+lZBW08gLr4vyb40tSzukOvMQ1F3slJSdu6u60V1O5T7EY
         NMH88MH2XTxzGn7q0wyGwVN1mz4HkTzRe4t8YlnymowRCngkghG1KEbi0H/PN+a7E24C
         On4/8IGjUhhXU+xTnFOKUj5Trd7gfnzMpPUY5HGRsZ4/jz7RNEDFwqIA01lTN0Q9Ve58
         VKZ9mZVibO+iEJ6z06Us6tiD51byPNIXzxn4+OaGyGaEvn2GMOB2QXmtoQoUJZsfln16
         OBU0rnq+biE8EmTfUR5SpluuXBNFa4pLUovtNBNysm8SwAj9dEtdnqgiOtF7Jz/yVmKM
         pTHA==
X-Gm-Message-State: AOJu0Yx/vCg6iUIur0C1yxyK3vKHXMEaEdJFmk9fzRBSYKBq7ZDb5c9S
	CyL7wqVSGzsZiaoe/wFd6yjHUjMPpVlURApH9Exq4kqChsmdtK8AlBDf5FI4uwh509o=
X-Gm-Gg: ASbGncuI5b+vREahy9TFf+rPV9UYHzuAsgkH+TA1Su3IJU7np4SajPDr8yRRALDj3i+
	5EbxpR1PSvWsMxHH+2Dcx+uyN7JVpbSwc/OGgmhsHtDeKOHoWtIOMvcOTMdzLFKiruM4A+6jWLs
	m3/kmlWOSVHGbwSRSJd/srC0j0Lv3ly97+1tT7xmRA5Fm//HHxk9bCZI88XZp6KCONCsB6K3/F5
	EbGa+2A1zpZHL6oWU6yrUNeEysOXkjIlpgEd61x0lvLJrN3UZlSy1OWbx9IYr5InIbxstcBnzQ6
	1PIgbx6nn1snvECxPmWVg5yY5w/QXmuEdf+I0tU29j4ikJVJeiObmoqS+w5xo7tSfPwMG2412wo
	NVdz148HKTGeXSsAUFoq7Tr/3hQ==
X-Google-Smtp-Source: AGHT+IG1e1hqaSndQpRpXt1BOsZiEm0vbGoAAkhfN39c0IW+DR42cTHp8RghhcBBx/H8NeTcXLUEQA==
X-Received: by 2002:a17:907:3d9f:b0:af9:3589:68cb with SMTP id a640c23a62f3a-af9401c7bc5mr1039971566b.48.1754311972544;
        Mon, 04 Aug 2025 05:52:52 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c0a4sm724236566b.109.2025.08.04.05.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:52:51 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 04 Aug 2025 14:52:29 +0200
Subject: [PATCH bpf-next v6 6/9] selftests/bpf: Cover read access to skb
 metadata via dynptr
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-skb-metadata-thru-dynptr-v6-6-05da400bfa4b@cloudflare.com>
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


