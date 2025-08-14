Return-Path: <bpf+bounces-65627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04694B261C9
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 12:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942C3A203FF
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 10:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169932FAC13;
	Thu, 14 Aug 2025 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="c4m60zpE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9E92FA0EC
	for <bpf@vger.kernel.org>; Thu, 14 Aug 2025 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165600; cv=none; b=dW2dIU/aZaxoR2vfn4lpVY4DBrc8E4fGRBGeY62vwuAKqGSCOsa/gKyACNXSw3YLY5tWQpnE9bUV3SpMxINZanQonLvXYt935hdNTaUX3BhgUg/t1AT1R4/+18IBVsr/J1N6czsilXfRqf4PiRV3/LcUIeEdeh8NXUPDCU3bzV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165600; c=relaxed/simple;
	bh=Ies+heGyxXCUihSsdFFrXXScyXFQwEfc1FxVWkuz1Ho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BU7RDD/MMJyAiMPtXJ5tsA2AOGihignlGS4yDsgLphApY2chtAck94KD62iZQFJWnl7H1k51iCguK38jszTvcfFZh9F/xHP2kJZE5wfzaNc9d+8S9YyjAnV+PWZVmxEXNxBBhZ9ohlShHM+S4ESsMB1GJ14RaQFFPSOTI2QI6to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=c4m60zpE; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7a3b3a9so108640866b.2
        for <bpf@vger.kernel.org>; Thu, 14 Aug 2025 02:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755165597; x=1755770397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZOVO8FzrCbiLT2nUKnJ8wTwY2dAM9GRGmZiNXnZe0Q=;
        b=c4m60zpEc8C+2rGXELFGUQGTqE51+oWAQ+JPZ3FGwXj6GHVh6qZQ+OxIoaKR/BvRSR
         857n7sXL/DDW5qThnauQbcHXL2LS74kPW5kNqELX7cXkRuLiWNa9SFkuP9KdHUPGZZoe
         tjywkGtzpsK+lan4ryqr/ZlFyH07OAmvx0C+yb9nNxo1cJJcrBZZAIBNZfso5KbdpEEN
         3QTm4EyN0RdprJoZ6cT/N1mucYrPNDnIws+48Yim12zwy+cnCuUUKDr//qXuhTlVWd/a
         u5DYN2PNj2JXlQ2WoByf+A8SJTqBXw1jmOpkpgKuSd7EMQztNY2cQyyXkhrDbRIEd3Ii
         7Tiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755165597; x=1755770397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZOVO8FzrCbiLT2nUKnJ8wTwY2dAM9GRGmZiNXnZe0Q=;
        b=ujC73NNEx4Gjb5hr9pt9SrIsyXGF7b28R0iiVv5KrH4gbIZeUs6hW5H7dvZ/aLeWx9
         9zv44dVNS+kEthSFA3wP1KMzKK86XOL6Pa5QX6CklzHXKcYxZfz04F75xr7nO7XiOq4h
         FGwJHWHrOQiycr16cUocLFs/0DmgBzCsqa7/mtt0RO6jmQiaouHxd6P02QBUEm5tgBwk
         bqNA/aXPXkoW1YW6SaSZAOPlo+j0EPh+FqCcavCishVmr41NNI3OwuKoZ4JBx0PWRmQ2
         Q70UMJLkomQyCjPNGtt4kGnHZzwfRBfAjQVVd7Mh4ydqYo9B+Bk6pztWOvMj9kb3I1zc
         6WcQ==
X-Gm-Message-State: AOJu0YzCtbe6TzFj8ZKFdr95EtcmnjL5V1McOPSm3kThu+rJx0ACWC/G
	OkZjpt6NiPGxsNqOK2oFKHWVcPxBqAEdNVHZ2P7gTHHka+C7Odnj/IcXS4/Lg0WDC5c=
X-Gm-Gg: ASbGnctdkDadAgOk98GVe8gIqOg07Q6LQin/BeXLTO6kYWq/hDi72HahoN6535k1lV1
	A4wsVTVfE1g1ETln5xiOCdeRAYiYKsjGeps4nIYHNKHPmrD7eDogJaa1CRTxtSUa6NjtNc6wZpl
	B09bgnWG2d0KVeerVOf0kMY30dpuYsgeLv+Edi8E6SW1DuWW5ztTR1LYPWArZr4b0p7PDwVENLJ
	5HgWp9J4BjudyK3a9w/StvLm8YWQx5O3XzTo2urLEcSHXaZXLWZCOwMu8BYIWei2xRcJE2G7ldD
	UOhNGEPaVD3mEuF+1gJK1mWK2aeq+3Hh29SFVBNG/buviwdO/THS1A49dTIO8DJ7P4lw3C1k4dR
	4gtucUn5TszuXGS4h5SBYQLh6tA==
X-Google-Smtp-Source: AGHT+IHHsjY6DKBTY46L+O72ZWhvXVvcwXuPhK2+hnGgm2V87J2ZdPAOvCX2f8fKKMzA7n3SHQhWkw==
X-Received: by 2002:a17:907:6088:b0:af6:3194:f024 with SMTP id a640c23a62f3a-afcb97c119cmr256689966b.13.1755165597347;
        Thu, 14 Aug 2025 02:59:57 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:f6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0771f9sm2590474366b.16.2025.08.14.02.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:59:56 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 14 Aug 2025 11:59:32 +0200
Subject: [PATCH bpf-next v7 6/9] selftests/bpf: Cover read access to skb
 metadata via dynptr
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-skb-metadata-thru-dynptr-v7-6-8a39e636e0fb@cloudflare.com>
References: <20250814-skb-metadata-thru-dynptr-v7-0-8a39e636e0fb@cloudflare.com>
In-Reply-To: <20250814-skb-metadata-thru-dynptr-v7-0-8a39e636e0fb@cloudflare.com>
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


