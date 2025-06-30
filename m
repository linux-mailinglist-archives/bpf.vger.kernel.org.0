Return-Path: <bpf+bounces-61846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC50AEE1B2
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 16:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252843A6CF6
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 14:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D0628FFDB;
	Mon, 30 Jun 2025 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UakC6v3x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C07F28FAAD
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295370; cv=none; b=e0C0TIDCU8x2+nUOkJcU7x2sqiJ1Yi5Zrt+k6WY69VOIkfouzFw0ywGW9sDapU+7CKjq9KfB8d1iP3gMvdjQ3HT6UFUS5KZ4gkipHf0BYTINYkUnN7Lclcx6ROP8ByXq1khR49D4W4iBIcsTzpuz4LGzXlfAa0pA3CaMwM+Fbe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295370; c=relaxed/simple;
	bh=uRNVyE79emPfKVU6XpnZGgITpFG6Ywz7jpzsyJ4I+Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WGs3ynDgXj+XMgaDN+j0o/jTz3P4jjqqd2tiBXbwqkFb4sg3DzviZJ7Dnfl69/dztbDR4jkWjXM3Hh322VZs9wa202pPSD7L5SAe30+syvHcbI3J3Fkf3rED2e4KIcivfL79h9BvLny6vmM8DKmEzBnbyCYtjk79rZYhxgQkL1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UakC6v3x; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60c01f70092so7755527a12.3
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 07:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751295367; x=1751900167; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7HMMcaoWoXp7CBL/t22KpHPWA7fRL898Q9A4YYFk88=;
        b=UakC6v3xppO0KOiEyyUp2HEbiTI+pQwFG1DRDsHFyYdie26qKI4nRsvmzRq9BPgE6M
         jp2KMhxsH6ecge60YiUJ1+ktAmtSdVzZts4+hHGGZjaEGLix8i5g2tMWhAqnp04/qGQA
         RV3bkgd/KuJYMdHQzz3y9GXKFezJI2Cva0smdQrxm1oEzwyKC6BhhdR32ATQ7U6/4LX6
         WFyM5ZeJFXo/aD0c74L+TK+QJ7E+BqHWr3OQf89bJQhA9MB+ed+qDp5a8I+8HMV0Z++j
         UWovr+030AV+sJnUiEG/OQZ7BP3ZdMcmwkSK9dpjlGsJW3T1VM+trVC12tHjVADUo6ee
         jSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295367; x=1751900167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7HMMcaoWoXp7CBL/t22KpHPWA7fRL898Q9A4YYFk88=;
        b=gAP6NnHkiifGp/+gV50k/JnQFkF10qIRzi1XiKictnXL05CjK6+4/8dRvXps0jrhos
         10Kgv3zbGwR/FuHqDadVM+vEL4tBgW0eA5bBDV6dnm4mmq6+dYXhOmFqEb9VxtIcEDD2
         4t5QKEtv3Iku00eG2wxgrUiQR0gNhxUV/AKrANTIuf8qyNMzQdjHRZcQcQgkGwDqMySD
         /isfEarr22Ua2C7yKR2R03chcDv7xJrMCmetpHugILN6odFS25KdhwYoFFwiBF9LMuA9
         Z2DZwq32r7ZzfmGxeyn/u/tP6+3rQhIxwME3O+DsPamAMxFBdaGhQ8b5GrGnw00/TegP
         mrCg==
X-Gm-Message-State: AOJu0YzmqLciG28tUJcy4kICVVfQsQ/uABfFb4CfSLNsWic56rmxanpS
	W3uRsq+SBl72JKckELepmRd5esxu1YTBQCaoyeLedC3NJjxhOX0lm8UXjO1aFpprlUc=
X-Gm-Gg: ASbGncsbtz3kJtM68OLdMpOlNEnPmzmk+fRSS93GzyR0Ooo2n6ZZfQl4od/bNbo74lc
	U37mGublKEVJ2DQKNZ4mUYIxRWc5+P6cReces7/cfkZh55jbhmqD96PNDSFxNEhGINutGUf3e8q
	FEXIQlC8++R5m3QHpy3DOXU/JwklJ2b4LeP3XShw3kTwXnq+GHlENIVgH4MSwBr12d3i5J3UUq/
	9BLdrDWGbznknGIevyhLCoKNQGgXGpVu6/iMIz3ijJuUwkj1BdofjLwBbF1aCv5SmwVcgigQ/2I
	Q7dUOO0PhJ9rf9B62ZjquMH7zjna+IirPn4Vov9kVMKDYCtn7X4MXg==
X-Google-Smtp-Source: AGHT+IFGU+jDL5yigFcn8X6bxLQ9XTZKmPKScGoGu0BuR5t2bi0d7iiTmRQIVofE+ZzUg1yVmnZiSA==
X-Received: by 2002:a17:907:94cc:b0:ace:d710:a8d1 with SMTP id a640c23a62f3a-ae34fdbf054mr1301464866b.24.1751295367364;
        Mon, 30 Jun 2025 07:56:07 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:10a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353639bfcsm695713566b.11.2025.06.30.07.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:56:06 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 30 Jun 2025 16:55:42 +0200
Subject: [PATCH bpf-next 09/13] selftests/bpf: Parametrize
 test_xdp_context_tuntap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-skb-metadata-thru-dynptr-v1-9-f17da13625d8@cloudflare.com>
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

We want to add more test cases to cover different ways to access the
metadata area. Prepare for it. Pull up the skeleton management.

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


