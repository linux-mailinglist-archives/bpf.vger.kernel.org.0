Return-Path: <bpf+bounces-64198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DAAB0F975
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 19:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31EF63A1EA4
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 17:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A83624167E;
	Wed, 23 Jul 2025 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="I+FcNRbg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDFC23C505
	for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292221; cv=none; b=jmt4qtnFSC1cnTWYE+wWW0gitBmkZVoZcff+yl1N1o93VuRoVosV6gVNnefQWB5u1Wqvfr/9wm/PngntE9s8ny4PcHmKsGjvsAoIN/QDLN7/rMa4I68uW6254hgYYzB4eJA0TW/mOt2yDEVE3yEEdUkVXbFmb0whqeVBNQBCFgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292221; c=relaxed/simple;
	bh=zlo+v0BX93PMkpPYvABMnpMGpMbQ+pWtgo9unZLKngs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZHSyuuDKUySnVZxfbCJupSL4Y2C8v/y9l6lG3an3KtZNuQ28vHY9u+mJiO6T1H9QRXGl0yEP6RyNUu80/ehhbwVCdM+J21oGazXT8ou1GL6HcRPlsRNhvO3/cjEFme59JDgxNqIjWLIe0o07yhBM4tBpUEx0ouU2iKF9equp28I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=I+FcNRbg; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-608acb0a27fso343799a12.0
        for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 10:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753292218; x=1753897018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhUAeFvwqX53HtmcKI8MSOVYh+BhmknqmuctuiGjaF4=;
        b=I+FcNRbgbUtp+b1g28LjO/dOxb23XinxmwWWJjJ9nYdEP5OaOzENr5fTVXOI11R+1V
         7pOC8y94aYxwzpm0swaSQqvT5EEB9yMYriPKqSAQ+9+HYtbX1X3/PfT925heeQUEthGc
         TsIVolLSiL2vY3tqd+BtXLarVfBHr3WFOdCsCWda542bDceckSnPDFNmWL75ei25hfID
         f2rcpGSc1jG5TrCNbELLpyBu9DhkwIYkwgdlgbpldKYadsKpQmlhUXqxYSxOgFjyxHy6
         e9aGl520g+L1jiALadgmBUGzsNcEUDHqK28S7oB5omM4GNXTaemC+wKeSNKrB6J5LrFo
         9sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753292218; x=1753897018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhUAeFvwqX53HtmcKI8MSOVYh+BhmknqmuctuiGjaF4=;
        b=rnqPt8D6KS+qahMU0BGnfta+yEDkuDCzSJVNGzmq+G+pCD8I20+5wkZaXnSFp6sg1P
         GhMEbouu5VmI8RNhVVCaBTY7yqhZoy0PsmlM3ydJ7XsCCfyPZi6EuPNZKB4MNWrTqYsb
         JBgtDjs3MmxUj7A9xW04pCTRg7foy2VspCOr7jy4hj2BOFU1hKC6g9VRKWG+5yo9gA1Q
         AkxI4AOekVjpPN0+PtcNCA1uM1ntm/Zgt4GGggf0cf2KmZtg1a0s9D5jequGDNoylmCc
         VRFEy6L0NdbiVWnTslmfIXoe1ILJQ4/d+pK+C2EW75mk70XtUl8KoKXbyPmANwr2ppHN
         cbwQ==
X-Gm-Message-State: AOJu0YyAuxI4g4ynsAX5hKhMknJ4ZbD8TEsvINRuJlgjM3n3MdUuOKcZ
	BTwXWeWmh9q6oA9hpDR20XrdLEVTybeNGEF361Dumve2K4+jBetikrL3zhBQoNC/sE8=
X-Gm-Gg: ASbGncv3YpzRyPfYgPOwRszgUdmQuM/qzmS6E1RLszO0ARlyJhl+KfzFjHU2Lp0Ay8i
	hx5NqHcuawzuXOt4OHS+RGdRHzbduL04myQKJg3/PfoGucqWl8rVYMJ5ycob/hpMHV3cRVZ8VnQ
	x0WzeVkYS8a2Rcswai665axhjMVKvnlLDhMNbGphphzt082Mwni6W0yPofxnXggBBesfo8hv4e/
	5/OU4g8HDzgXw9p/iFnueUMwy1KZQJMwK+4GggdgZUpPt1z3xOfgVGiQB/Ft76q5DseWcd2RRxC
	rHB+qWQZphNFib5SKL6Z2wqHufxZW924FS/x4uiGkid7J6hg+8/F7zRJyjtx+16t5qCJnLpP+7n
	HsHM3LQaxTFtQgB95iylM/11eRIG7owACMwdbq1T43RpGXZr8+T05IFRHNN5tYqJyuaMYKYez4c
	m1M0rgKQ==
X-Google-Smtp-Source: AGHT+IEBuIuQZqtuEM621rgjmwu6Mvi9RqEfDX9vvnQuW3S4thSd8jeLnKZWq7cuQTrouVTwd/U50Q==
X-Received: by 2002:a05:6402:40c8:b0:60e:e4b:b8e1 with SMTP id 4fb4d7f45d1cf-6149b5a7b42mr3459311a12.34.1753292217840;
        Wed, 23 Jul 2025 10:36:57 -0700 (PDT)
Received: from cloudflare.com (79.184.149.187.ipv4.supernova.orange.pl. [79.184.149.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f13e13sm8693025a12.10.2025.07.23.10.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 10:36:57 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 23 Jul 2025 19:36:50 +0200
Subject: [PATCH bpf-next v4 5/8] selftests/bpf: Parametrize
 test_xdp_context_tuntap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-skb-metadata-thru-dynptr-v4-5-a0fed48bcd37@cloudflare.com>
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

We want to add more test cases to cover different ways to access the
metadata area. Prepare for it. Pull up the skeleton management.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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


