Return-Path: <bpf+bounces-39897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29573979008
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 12:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EB201C2215F
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CD81CF5FC;
	Sat, 14 Sep 2024 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YRkBn9Ss"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263ED1CEAC3
	for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 10:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726309979; cv=none; b=d46uZO8ZWMQBBbKQsA0pgK1jwcEm3WrtVBelcqAHvIp5Qv394fJl44WnvBVkREN2yvUJYt4TWxT6+HoG1XPI36sp2GvrfWDoq3IfHFC+neEQOn0uhnwfxkQo4TXcUzOYM3C3+87cdBggmRzA1J73Ftc2t6X82yb5DUs2Fq/qzsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726309979; c=relaxed/simple;
	bh=m6tganteey5Zg+ZqOOxN3LGGrsmpJmws608jYsU4v9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eXXqSMzzxiQ7JYkjBiPM/ugZ3QCW81FjNsq2hqgNO62SJBLR18a/q8qJWFfPRriG8mTSUXvEFrYw6ndIsqkyEGva5BV8pSvq8vkMntuz6AudHDLDXwGqKEfA4z5M2DHMjron8EGiUA1pnMTEz8tVuCZdfgJ+btpEshJ9Ty2yT5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YRkBn9Ss; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7191ee537cbso2178391b3a.2
        for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 03:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726309976; x=1726914776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wKJ6T8lzrG3Rgs6AhFQqgnkeWhWEchyLf0I6JJ+l9w=;
        b=YRkBn9Ssnea4wzVsgFxbSa6SpUnr31dRWq86B8ztJytn/Zben3too/SnZLkaWpjD55
         KPvjtuZ1xSRSVhEliXtzzLgYfMUz0CQRsrDBwxScQ3lqCCzkUDMhLQnAaWf3UwKp8y5a
         IhZaQ2pKutl0fdD0cYKS/UyZ46OiWRafrp26utdmDy5CvsVBoCRm6i2i3n9WHf/jkzCp
         /QkoJ7ZrRRe30lN03gEEC/zXO0pIsPcJWrbAlzbpy57kJEXpKF+dHDWRlLUzlZRULGms
         qMzKnYfDSx0W2RvOpHMVlKrh96pvhHIwKK4Q1ux0OzFT6IOV/N2LXGVSxy9zG1zKZsDG
         U4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726309976; x=1726914776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wKJ6T8lzrG3Rgs6AhFQqgnkeWhWEchyLf0I6JJ+l9w=;
        b=MGa24zWtjGv9gczbItbZlqUYvoMlOXnfB1gR0o/HGJSwUt37ul9RhuR/vAnB3/Dz5W
         6ayvarnMeQ0qBhcXwCA79261ApnbzgVHldUZF0PLKVjZDfWU2aLYAKiRB22d+5dMB28z
         XefHeVqYwaWGq5HR77ITQV4AVnFcwDv6VMUUE7kxwDYKSx1rmVTXkRGvZa1LZAOnsfqB
         sCE1VX/K9SnqQaY5ChynM8f58gAI4zuKW/1A1TX76hzqntGTDNJ69Cv7iwpvxmD9ReQ0
         XuP3lz1thSwIcA+HL5T63jrdhS8Ir4dqKDdtPm3VIoTgnS7TkouFiY96wyiq2HLL7gja
         +V8g==
X-Forwarded-Encrypted: i=1; AJvYcCVdecuR5+zFHZYbAKdFbwmEK8S6+ibWAue8IykJWMMplof7LNXnamm6L+CFvAPZL8yiHAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YybnN2hzBw8kVihQotLY4C5Z+lUTF4yoXtvsa1dojfLx3AjoFTf
	kg3STy8v480Om3U0jWCcxNFoC82pIhGi3Yu8NJg4BxQYYpWFExv6RGG6FM0eVXU=
X-Google-Smtp-Source: AGHT+IF8FZ62F3t14kxbTqWQfHm1EgOf2TO1sWKDgesgw76UlXpQC6XKw5Ig4N3rdi4YJTYevfZbNg==
X-Received: by 2002:a05:6a00:812:b0:70d:1b48:e362 with SMTP id d2e1a72fcca58-719262065e5mr13240001b3a.26.1726309976169;
        Sat, 14 Sep 2024 03:32:56 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab50cbsm788332b3a.53.2024.09.14.03.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 03:32:55 -0700 (PDT)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	alan.maguire@oracle.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Setget_sockopt add a test for tcp over ipv4 via ipv6
Date: Sat, 14 Sep 2024 18:32:26 +0800
Message-Id: <20240914103226.71109-3-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240914103226.71109-1-zhoufeng.zf@bytedance.com>
References: <20240914103226.71109-1-zhoufeng.zf@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Zhou <zhoufeng.zf@bytedance.com>

This patch adds a test for TCP over IPv4 via INET6 API.

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 .../selftests/bpf/prog_tests/setget_sockopt.c | 33 +++++++++++++++++++
 .../selftests/bpf/progs/setget_sockopt.c      | 13 ++++++--
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
index 7d4a9b3d3722..3cad92128e60 100644
--- a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
@@ -15,8 +15,11 @@
 
 #define CG_NAME "/setget-sockopt-test"
 
+#define INT_PORT	8008
+
 static const char addr4_str[] = "127.0.0.1";
 static const char addr6_str[] = "::1";
+static const char addr6_any_str[] = "::";
 static struct setget_sockopt *skel;
 static int cg_fd;
 
@@ -67,6 +70,35 @@ static void test_tcp(int family)
 	ASSERT_EQ(bss->nr_binddev, 2, "nr_bind");
 }
 
+static void test_tcp_over_ipv4_via_ipv6(void)
+{
+	struct setget_sockopt__bss *bss = skel->bss;
+	int sfd, cfd;
+
+	memset(bss, 0, sizeof(*bss));
+	skel->bss->test_tcp_over_ipv4_via_ipv6 = 1;
+
+	sfd = start_server(AF_INET6, SOCK_STREAM,
+			   addr6_any_str, INT_PORT, 0);
+	if (!ASSERT_GE(sfd, 0, "start_server"))
+		return;
+
+	cfd = connect_to_addr_str(AF_INET, SOCK_STREAM, addr4_str, INT_PORT, NULL);
+	if (!ASSERT_GE(cfd, 0, "connect_to_addr_str")) {
+		close(sfd);
+		return;
+	}
+	close(sfd);
+	close(cfd);
+
+	ASSERT_EQ(bss->nr_listen, 1, "nr_listen");
+	ASSERT_EQ(bss->nr_connect, 1, "nr_connect");
+	ASSERT_EQ(bss->nr_active, 1, "nr_active");
+	ASSERT_EQ(bss->nr_passive, 1, "nr_passive");
+	ASSERT_EQ(bss->nr_socket_post_create, 2, "nr_socket_post_create");
+	ASSERT_EQ(bss->nr_binddev, 2, "nr_bind");
+}
+
 static void test_udp(int family)
 {
 	struct setget_sockopt__bss *bss = skel->bss;
@@ -191,6 +223,7 @@ void test_setget_sockopt(void)
 	test_udp(AF_INET);
 	test_ktls(AF_INET6);
 	test_ktls(AF_INET);
+	test_tcp_over_ipv4_via_ipv6();
 
 done:
 	setget_sockopt__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
index 60518aed1ffc..ff834d94dd23 100644
--- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -20,6 +20,7 @@ int nr_connect;
 int nr_binddev;
 int nr_socket_post_create;
 int nr_fin_wait1;
+int test_tcp_over_ipv4_via_ipv6;
 
 struct sockopt_test {
 	int opt;
@@ -262,9 +263,15 @@ static int bpf_test_sockopt(void *ctx, struct sock *sk)
 		if (n != ARRAY_SIZE(sol_ip_tests))
 			return -1;
 	} else {
-		n = bpf_loop(ARRAY_SIZE(sol_ipv6_tests), bpf_test_ipv6_sockopt, &lc, 0);
-		if (n != ARRAY_SIZE(sol_ipv6_tests))
-			return -1;
+		if (test_tcp_over_ipv4_via_ipv6) {
+			n = bpf_loop(ARRAY_SIZE(sol_ip_tests), bpf_test_ip_sockopt, &lc, 0);
+			if (n != ARRAY_SIZE(sol_ip_tests))
+				return -1;
+		} else {
+			n = bpf_loop(ARRAY_SIZE(sol_ipv6_tests), bpf_test_ipv6_sockopt, &lc, 0);
+			if (n != ARRAY_SIZE(sol_ipv6_tests))
+				return -1;
+		}
 	}
 
 	return 0;
-- 
2.30.2


