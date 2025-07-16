Return-Path: <bpf+bounces-63459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C33BB07AFC
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 18:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6894256305C
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 16:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70E52F549B;
	Wed, 16 Jul 2025 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CndZalMa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42C92F5493
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682692; cv=none; b=M7Mzwh/w4rzhX4SOMEA+GCCWRpFoFX3wG/2IeQd6tLeffL3QSOfbrgdE79EkZW0AtEWUaRj+MmA5wFSmUq+Kdt+4TBOhcfMVpZ5H7OOmaR47KRvBXodYDDxYv+Gu+t5y/J9Gt4XJ9Y+nsPTeIPDA6y70fQAX+E1XZwd95UwDrVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682692; c=relaxed/simple;
	bh=uRNVyE79emPfKVU6XpnZGgITpFG6Ywz7jpzsyJ4I+Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=enWkFSrd/nqol53cqmlYbct+bBE/22Pi85rgJLE3ZsDP32Mc5k6kZ262+8t0BbZD6+zAwbMuTTZnIL/GS85mjBxmZmezyAbCzG7jUHi5b3boImIQxsViw9oRGL1pS4Y/mOb+c7Yz6WVXECpE/YaG8qFh70IKkyKnI1QiawfJWNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CndZalMa; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55a27e6da1cso37766e87.3
        for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 09:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752682689; x=1753287489; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7HMMcaoWoXp7CBL/t22KpHPWA7fRL898Q9A4YYFk88=;
        b=CndZalMaKjnY5E85lCFwznzOdin4TJszhJmyn47rtyUXHYrJGEF9UhULoX52z0h8hQ
         ZW1d5NhKc0bgasBcevWkk0iEIwiBURQtNTE4vv9S3rpiVVQvJ9J4SNXn9cVhl6Yjp700
         iNo7KKXxK+w6ujJVW54OOtvrbVga4PiJbe6FcxB5ip/ljVYTOykaEchY9LcAxB8GPc9w
         dCKKdh25O5/5jCURjCyxkGlpGKxBCCTpkYKaAL1XsGC71ANvMVkCNtY/k1tVkJvNLkfg
         3HM8wqjXGmEaWu7iJ6hn+m7kSZrnnadmxnz0hL8P13y43oIU9QgKQ911CMr+u8q605jp
         PoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682689; x=1753287489;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7HMMcaoWoXp7CBL/t22KpHPWA7fRL898Q9A4YYFk88=;
        b=LeiEcyOStz9vRDdj/kzSWEnkE8lUOfyCw3k9VIIRQQ7VxQCeBtgyiyrwYZy3fylVSO
         Te+k+FDeMBrv0jbEmLDr1cvfVoWLzDsBccucOJxeHitv42PlgQygksQM0y/m6H7bkGsg
         HNK7SV7m2oR+mvo5ZHstQGUQpQB90sY9SZOjKAJawKgVwIJvATmaD/TLk77uS/y9qR0b
         g6Dhhs4grrUfaAcTsiKMIuR/DmkTG0v50CkEAtMO7X67XMEyYoyieWxApUeM7Q77iZoZ
         he01hO/sSMXr8tgKQW8E3h3MrAnbEgDr6OsQ83Xpf7G9P5kWNxxz1kCU0/qzhk5ntAuZ
         DIgQ==
X-Gm-Message-State: AOJu0YxHa3xZY/39uGS1N8HXZP8r6ECm4yqCnrrG+9pZUkdrsKc3PDSy
	0gJigoGHHq/CkolM7BhonyNbCftOUje/iB+4pAsUjZc9UoAyXYUln825VdzkJTclYqQ=
X-Gm-Gg: ASbGnctJf9FbG44SQeGcZR6tLkVxgyYZkztdh6tnzR2dwZj3pp/eBHUrTi2dD17o3Fm
	V47Y5d+oC/xx+MjfL0wY4n6hEqJThbjjkMQOWwmkV2qVeCbGx5Toe956z33ZRE0GDgTgREnAx80
	55I8PTV0GXujZHRVBT1SAikPJAXO6PMOJGbeR4FNZNJMJsImldik78smcCsOyB4ctL9qYybx9YF
	IoklElGjrm8DSEPii+Ur9J500FdnAtUK64zM593rJnfYWX1ocygh8vDNSUluRZCbeidVRW2hkpe
	5xRSduPj0VQ/1vB221aOWgbBwrATRMqEt81R/aI7Qvg6he0ApstnCQfINZXEChCWV2ev2rTkxDH
	rcBv7cAZCgyNH/HEEIRbeUwE8kx7B8ZDKEfemLI6jGWeJan1k0UC/moRocnVqRfZE1iIE
X-Google-Smtp-Source: AGHT+IEyrBYmH7ddSQgBTkbANSyFKrFY8bNuGAhGpbXeGFY8wp28MlWRMdFVVUkIssqoUdctYOCeXA==
X-Received: by 2002:a05:6512:3a87:b0:553:2c65:f1ca with SMTP id 2adb3069b0e04-55a23ef7ce7mr1170472e87.19.1752682688665;
        Wed, 16 Jul 2025 09:18:08 -0700 (PDT)
Received: from cloudflare.com (79.184.150.73.ipv4.supernova.orange.pl. [79.184.150.73])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b7a6f2sm2694211e87.235.2025.07.16.09.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:18:07 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 16 Jul 2025 18:16:52 +0200
Subject: [PATCH bpf-next v2 08/13] selftests/bpf: Parametrize
 test_xdp_context_tuntap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-skb-metadata-thru-dynptr-v2-8-5f580447e1df@cloudflare.com>
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


