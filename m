Return-Path: <bpf+bounces-65626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E712B261D3
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 12:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE161BC4A3D
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 10:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AA12FA0F9;
	Thu, 14 Aug 2025 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EV7O6pET"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0CC2F99B9
	for <bpf@vger.kernel.org>; Thu, 14 Aug 2025 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165598; cv=none; b=RHKCrwSv+OMWVUkAztzv0h7V62ukQpxBCPq69Ah3Z1fMvhNNyh4QfzgVjNyjA/ak9glzTnLUruPcu3ifBI+cCG+J0oP+UE92JtL8S1c0JAB+q3BYFw5YlH0b70l8qAwNOE3G8D6lJw0DQc1wSlPlSg69n8nksJJv8Zk3YM9gZHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165598; c=relaxed/simple;
	bh=rOgEaue3k1efCvteS9x+AYID405oKjOeQI0S/MAOO/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pM3oFH/oLEEWj6SrDqf1Of+YokhJjh3QhjyqHMm2rlg4fiVkxTckUI97yz8S9x32HGq7n0W6QI3ROTjT7gHU/SF0PtKLnf9NPfDcX5MiLrt/bXDInVzRh6sDMLuyh3J32ufaEGQTbbcCxMhyci/Hb4eDVAqPY68ItAoCdA0qVtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EV7O6pET; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7a7bad8so101251166b.3
        for <bpf@vger.kernel.org>; Thu, 14 Aug 2025 02:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755165596; x=1755770396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r0fIqnzU78JFEGt4tPHYQLQeFtpWNKhdVMlxMCo22pY=;
        b=EV7O6pET9va1qj/gg2AZATwD/u2IB9w6wGHGJVNpqsHg3/a3fEgzfhwhbdufWjegs+
         zdTKPD5fqW6mAvImb0FJH1TbbuGa/zXCJb/xz+MxmF+DH4WdOBEuFiD3jfbYf3QrUuhu
         RBOvemu4sLR5HOh/Hx3iWiCykUmv9/BCzXQN5yg7VuCk84HGpBDAwo5ki4FTFcjIJIEn
         VLDD3YNUvqha5IK9KyVgIxwjWCvgUGXoRMHzIRvXBylfIVLV1EdFwCoQmufCzn0+LqYr
         mUG3y9tkynSuejfSqOpXO77lb5xsooly0wGMLiZP+X0OLCClj8WpWO++MU9Rz72ej1c7
         qLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755165596; x=1755770396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0fIqnzU78JFEGt4tPHYQLQeFtpWNKhdVMlxMCo22pY=;
        b=h/kU+hPRM0VRrLFyJdwnkZbKc+T2qXGjCJlE1ILd1N4qkjQjIB+jwHONzY/F+7Te+P
         5gh0P5beLXmWb2wt+TVQC+FqRjw4Uer18RleaNd5+aeEv8GtqlP3T9vwMalDWStybLpy
         RPZPCH6z1l50uaSjRjZ7OtvlB3U7Srm+Oi1E7G+dUzo49qXuuF42FzavjtpRFydAPpyW
         sw2GTEZhHdKKTyul5csKR/14pSiRH4NJ5QyxkmeHEY2ad6wpuyXB/pWoBJJ8dTEvSi5G
         MKYkZ3OF5BG/sLQRFsx3SQfg6bjrS5b4IJXsbXPydLv78T2G1Q/B5HIs7CJM4knF/j+f
         PSIg==
X-Gm-Message-State: AOJu0YzM89xBfxbrruwvV2IV0pRpAsmN6GOUIjzoaSN0xrn6MaNYC2vC
	/F4oib3u16WMIcFrobQNCkEU7Hw9AFtDgBw5tRko4MiVSalZmqlOKBrXEdVI2cbUnQ0=
X-Gm-Gg: ASbGnct+qxmW96EZvkp6DQ0Mrqb3mH0XjFR2BRqWAfE5ZI6yMyaIcIZLq0fbQ2Y0SsA
	CkRW2rhdhI4W9TjnjykwJLEfN3JUKgw2vLqQmjFkKYXQT7iFQpkQOOWbNQ+KMlqBiE010XmZXZB
	ChXWpDKdlzXavwZfrmIX2Cbk/Y320LxSGJqZI0r00eO3E3o/cABpi2vw+w65IsD4yp79ABJLZ4m
	3oUTgDweANnctTYJyC/W4e4mZNv2wSrrgyG9BC/lSZkYcF0Fmbiam8hVXaWJ+eswDSRq6kiAJ1k
	joIxgnBVSggGzuRr86sfCdEZzVH6nvzvHZUMu7usROfRRS7nuzjx0Q8t0EqTK0A9QURGSQL2s+U
	JbwjoxaN+qR/GLhT+MTMn
X-Google-Smtp-Source: AGHT+IG8XNjJJ8axUv1kHemYqxYmKs6jEIi80bYTWtmES0etyEbXzIxgH5Vavr+Q88+uoIMG0YYGnA==
X-Received: by 2002:a17:907:7202:b0:ae4:107f:dba2 with SMTP id a640c23a62f3a-afcb981f243mr246458066b.13.1755165595497;
        Thu, 14 Aug 2025 02:59:55 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:f6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3792sm2548731466b.50.2025.08.14.02.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:59:54 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 14 Aug 2025 11:59:31 +0200
Subject: [PATCH bpf-next v7 5/9] selftests/bpf: Parametrize
 test_xdp_context_tuntap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-skb-metadata-thru-dynptr-v7-5-8a39e636e0fb@cloudflare.com>
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

We want to add more test cases to cover different ways to access the
metadata area. Prepare for it. Pull up the skeleton management.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 31 +++++++++++++++-------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 0134651d94ab..6c66e27e5bc7 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -256,12 +256,13 @@ void test_xdp_context_veth(void)
 	netns_free(tx_ns);
 }
 
-void test_xdp_context_tuntap(void)
+static void test_tuntap(struct bpf_program *xdp_prog,
+			struct bpf_program *tc_prog,
+			struct bpf_map *result_map)
 {
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
 	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
 	struct netns_obj *ns = NULL;
-	struct test_xdp_meta *skel = NULL;
 	__u8 packet[sizeof(struct ethhdr) + TEST_PAYLOAD_LEN];
 	int tap_fd = -1;
 	int tap_ifindex;
@@ -277,10 +278,6 @@ void test_xdp_context_tuntap(void)
 
 	SYS(close, "ip link set dev " TAP_NAME " up");
 
-	skel = test_xdp_meta__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
-		goto close;
-
 	tap_ifindex = if_nametoindex(TAP_NAME);
 	if (!ASSERT_GE(tap_ifindex, 0, "if_nametoindex"))
 		goto close;
@@ -290,12 +287,12 @@ void test_xdp_context_tuntap(void)
 	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
 		goto close;
 
-	tc_opts.prog_fd = bpf_program__fd(skel->progs.ing_cls);
+	tc_opts.prog_fd = bpf_program__fd(tc_prog);
 	ret = bpf_tc_attach(&tc_hook, &tc_opts);
 	if (!ASSERT_OK(ret, "bpf_tc_attach"))
 		goto close;
 
-	ret = bpf_xdp_attach(tap_ifindex, bpf_program__fd(skel->progs.ing_xdp),
+	ret = bpf_xdp_attach(tap_ifindex, bpf_program__fd(xdp_prog),
 			     0, NULL);
 	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
 		goto close;
@@ -312,11 +309,25 @@ void test_xdp_context_tuntap(void)
 	if (!ASSERT_EQ(ret, sizeof(packet), "write packet"))
 		goto close;
 
-	assert_test_result(skel->maps.test_result);
+	assert_test_result(result_map);
 
 close:
 	if (tap_fd >= 0)
 		close(tap_fd);
-	test_xdp_meta__destroy(skel);
 	netns_free(ns);
 }
+
+void test_xdp_context_tuntap(void)
+{
+	struct test_xdp_meta *skel = NULL;
+
+	skel = test_xdp_meta__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
+		return;
+
+	if (test__start_subtest("data_meta"))
+		test_tuntap(skel->progs.ing_xdp, skel->progs.ing_cls,
+			    skel->maps.test_result);
+
+	test_xdp_meta__destroy(skel);
+}

-- 
2.43.0


