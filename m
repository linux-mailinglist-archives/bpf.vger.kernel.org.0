Return-Path: <bpf+bounces-63904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B85ECB0C1C8
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 12:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5945554065D
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 10:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD00F293B7F;
	Mon, 21 Jul 2025 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YnMCfI78"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C352C292B5B
	for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095217; cv=none; b=rwqDkv/hVZ6qPUFskkjQoZ+dk/FsepKfjgikGViN32Am+ZphdDxKzgnbwftbqJHuOkbKIP4wOLZXAFugeQaIMZkV2i/8rPaGl6zBAThgwa8t5UNEK+/hlyb4iQTuKX1MI/sM90GwWIJhq2Odg6weIdj3RI2p0soP4Nr4Hvm4Q9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095217; c=relaxed/simple;
	bh=uRNVyE79emPfKVU6XpnZGgITpFG6Ywz7jpzsyJ4I+Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lyO7CsiiQBLpAY1HBu7K444PVIHp+RKLO9EEfzyOZyxtNueXygHwzl2CKuy89qi9g2tuFNg4zH5yRvqMug+hoOtnAnEDH8YoWxV5pVr1Gc6LRvBrxKSytWgT3aM1x84EcJsZQ1hmnNTOVISxVuAdgEsDt9YmKxc5F/YQYPB9A7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YnMCfI78; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so6649467a12.2
        for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753095214; x=1753700014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7HMMcaoWoXp7CBL/t22KpHPWA7fRL898Q9A4YYFk88=;
        b=YnMCfI78b7synolT+xKM1MkObRrukeIwAXp6CSeLRuvlqVTF1Qp3S0XTDb1rMyHj2s
         Nb0D4WCQYe/EEpBuLNMRosNw1izUBgtWahXWZhUHj4BihzWUkFCDsTrmXvkecoxDETJp
         ueBEscImnR/woVB1sEuTYZsbonMz04N5Uy85+MVC3IRrL4dR8xXusdxN5qeJICEblRKA
         6hQiNUhp1Wygt0EoqswdzTBNa8cftIbwtCY2wRUigq6pLvDpOeImouOz5w3/C4tkfhZS
         hAn344+1AattJkFJz2c6a7NidUIrdtCo4E2J6ITCP+TDVY3ZkCbKbvjFZMjVrkkukc/V
         70Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753095214; x=1753700014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7HMMcaoWoXp7CBL/t22KpHPWA7fRL898Q9A4YYFk88=;
        b=KKEm0OeUDgkzWXpmKhI8mkG+zF2JMSBxtO+n78oC3Q+JL9ssuTxzRX2Im7W9Etawrw
         IRlHNLzEp9PR4MVCT3kNCou0BpwniPe1VS4X812I7q++wRk6OGv6QA1tmyEpDuavWMrx
         9CMEqL581XBqW3rAubKz3Lo2ilkxVxwwZAgQY/X8+nQsU2am+X5AlrPrUPvip/iF2gJH
         AyvxN7n6861siuyOYN58g7rUVbo+Rxfa7BZXItD8eGeVfzf19jsKPhBE0xUCrHxDLsXi
         V6Ck8iazmMU0igzlko/WW1wnnsUM7JkC7LX9RaYA+zCuZEq+Kp2lnJ5d/MgXnnIJ+KH/
         vj8g==
X-Gm-Message-State: AOJu0YxS5wESyB/W03u/I0OJjdq4dD8ceIKrW8iwy3WCAnumKGEyWLbc
	LY58KvQGvrQS6AoO40dmKBozW2CDrO4FfGwtIzfDMTmLiLe4jhfqS3N9NeHUyLqxhuA=
X-Gm-Gg: ASbGnctyyl9qB0ompWZbQghdDfGXoDA0o3pYBV7rFAGHLvXuvRYXgvCz4rK4eFNHSMC
	nKL1uw/wfVeXJs8SoaiVAldxoQSlR6LaxIiUS4ITX8PNUgzyXCrwDCq6E4xPj/oFBgFmj0cxZPx
	eZHCrD9guq2kJkwwh3v2tUNXbC1n2KxKm8W2qyEL0EdGaV/FdJoVHZNHcrrgCLSZ/gDVE7sBSRK
	gS9XHgPPmt0IR1Olbq7C40CdTTu3pvNsLaSMdkdtLMjKUJmZotEGq1aKOKFNOgs2NipFEx7hH6u
	mF5+ZKJCWJ7p6RFyRESBcp8PidiKA9vjDg7hheOvKiVR+OOHtXvvnPIIlWA3jMhKfsMVHd31bai
	WBkRDV0oUP0W12Q==
X-Google-Smtp-Source: AGHT+IG3TBn3/a64XNavmgsR5xqtrjPmkBz1S/rcOZt65MqDgsRBjjfB7VC0+m02zu94z10crci02w==
X-Received: by 2002:a05:6402:1d55:b0:612:b057:90ab with SMTP id 4fb4d7f45d1cf-612b05793femr12408609a12.17.1753095213988;
        Mon, 21 Jul 2025 03:53:33 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:217])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612e7125fb4sm4012845a12.9.2025.07.21.03.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:53:33 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 21 Jul 2025 12:52:45 +0200
Subject: [PATCH bpf-next v3 07/10] selftests/bpf: Parametrize
 test_xdp_context_tuntap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-skb-metadata-thru-dynptr-v3-7-e92be5534174@cloudflare.com>
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


