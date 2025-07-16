Return-Path: <bpf+bounces-63460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7435B07AFE
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 18:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB57172622
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2534D2F5483;
	Wed, 16 Jul 2025 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="anpD6Qoa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19FB2F7CF3
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682697; cv=none; b=Utxdj31VJl45kTj85fbFiOxwCxvTAASvTI+JAA5vOKzfGPeK2eYFDLVBOptUCG4LdMOFqHE0LqR8UOZtBrU9XLGs8KCtkFvNSMFW8JaLpihtXIPwJrsKiErTj0uQjE9qZOFQ72vKQ7cv8ssupsqODwDcIc+ouJ37ZbbbB4xKAhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682697; c=relaxed/simple;
	bh=2IhA+8Yp6tdoWboGLeolLyAE9sXwbLuuHBB7k0rNT04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VhQCt27hJAgihIKYEJj2BB8rNHqHH7lroB+5zoZnOorvU8wCXSFThsNODp3uYYRu+34EK8F+hGie5+o2JJhqGx8DU1gCQLK+MJHOXProHgGGIQhrXP1NChqVWpwDyddJdyPJF/j8faN3YmSwQmtkkv42PDYT7lKiQ/+kSXyLsNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=anpD6Qoa; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5561c20e2d5so92058e87.0
        for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 09:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752682691; x=1753287491; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZ6oWCfIdAcGNSgPLjXqQ5VaUSy7YhUQ2wzzt4VKYFw=;
        b=anpD6QoandDrXvEfvttGruYnfO3/pc3jyYrQ5Zy2zwJ0OX2MRz80kRTPKKF9aeo4BU
         GQSD1Smc5KbTOqoKng72d13wp+wRiJSwX/L4ldGdzQAZmKH+N4icVD0QPACLVYGl5DU6
         RZQ9jV+Pgrkp29lX3hObvngIE1LUP8UVKLamdH7h7sIba0EbuKdB23nWZ7JcCGb0OMx8
         EV8de4qM+/5ukKhoecs8bcnSxpd5b0LwqvH8g0JtEMXB07fITN7gPgwIHXv0mYMLf/5J
         L0DRqkh0rlwCZ5a9EH1ZXtQQ9Af+3Y4655zzXzZv+RqcU18HDpAd2FOlCm1hp/sHXJAg
         tOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682691; x=1753287491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZ6oWCfIdAcGNSgPLjXqQ5VaUSy7YhUQ2wzzt4VKYFw=;
        b=wpRYWyan9TiBR9dyxWXDz+svhtL6+DTkSCoGay4jsPiTj8NjFQhcX5xeMFtgp1RSbF
         /0q5WkXWxSQNbkCD+pvi011cGp+mlxdyGcSOs5htr+PWNCtSZvLLqhu46AKXYZRSkP/d
         iQOK66uUu13EOQXTsSoPduG2geSBDVE3W8jmNV+Bdza3kV6+h+LmkpDMx4PwjGt1AIl+
         Szh5kNs0QU1MSvubBQGIhdx2h7oKCdYh9jT5mMG5HtKnA2mawkMxn1apzYKI/xtF2ebN
         /Alw4u870wBxk0WQJ9qgmI5jOvd8fYB31nsO7WUYR9oF6/TeOSUcSwN7x8ycNuJzTiGW
         OYRw==
X-Gm-Message-State: AOJu0YwSnectg0WYn+VZPS8KZK3RzDWTC/eyYnL6vydHMZKki/oUkV60
	QDG9oHCfb+QN2jTUiG0LtOAzwvaKDFYFz4/GKOcD02fo5uTuGPDO9g23YZdFS4k+EME=
X-Gm-Gg: ASbGnctt8nwxmRxSencUCxu+wfyAyWwzsOQUCbQbj3W9uuFP1GiqiwUL7Go0t9cbsM8
	RQx3J3KO3DQFMP4pOpRguyOMcrl8bVM+kdyuTATgdCEL3eGNV4P8lceKCxDypJbtvZCn6+NVDd2
	g8ripo2u9GVxrqTIbyzPLvrHtA8vz4gAD+Ee0kvMoTK5h+Qe4areAPHjZdaF3MshuyRhzNZv/Kq
	3/GYgcHLQQMXCY4JcpfzinN/vf2KGcf34TvrDaNjRtdZ7C+eIAh0Rrc4Si5bYleORMvcq0Dse50
	4RRi2P3Ne3z08JndYvY9X6kUEnuI5mVGUIsGpzcrV9O0jQYEAV/X7aFZ5uFNHxjYjG1lgD1v+pe
	4v7oBZYWpEesTB69GJEGAJ31pPQvw907YKErXu3EM7Il7SfJh00w5NfS04Kl2l4DUjCx2
X-Google-Smtp-Source: AGHT+IFzF0t4RlEGKoSTVpooITkw1LaDX3aBWvBCpjqIXZYGa1RRFmb6ogIE/4O5aPIORHqsSZolUA==
X-Received: by 2002:a05:6512:3b06:b0:553:2cfe:9f1f with SMTP id 2adb3069b0e04-55a232ffc2amr1548287e87.6.1752682691010;
        Wed, 16 Jul 2025 09:18:11 -0700 (PDT)
Received: from cloudflare.com (79.184.150.73.ipv4.supernova.orange.pl. [79.184.150.73])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fab8c054dsm20879181fa.64.2025.07.16.09.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:18:09 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 16 Jul 2025 18:16:53 +0200
Subject: [PATCH bpf-next v2 09/13] selftests/bpf: Cover read access to skb
 metadata via dynptr
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-skb-metadata-thru-dynptr-v2-9-5f580447e1df@cloudflare.com>
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


