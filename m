Return-Path: <bpf+bounces-41100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FE2992896
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 12:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BEC1F239E7
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 10:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C5D18BC24;
	Mon,  7 Oct 2024 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpdqfHgk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6A318B476
	for <bpf@vger.kernel.org>; Mon,  7 Oct 2024 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728295218; cv=none; b=jaD1F3nLWTAGtko0XmZju6bMCkLgGXJW0mmmGYION0bwXzbBroq9ahHyNscyDSDfjwcZqf5jGtrL8fM2yYKfCg6hVsoNuxCP7xNJDoRiPhOxniEi0ylykhndLpVUGimbRCReklWNglrQfklOG6L8bE9C+C/bLscdPl9y5j90niM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728295218; c=relaxed/simple;
	bh=FygPPuoSezLwu+yCFbVDYwFpbX1IFaDFIrbU7VNJdxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R6wmn7kdZD2PkRTjHzVPw+DDG3q2YaOrOmEg/cAerqRXZt5zEjDPH/5X1OMhjCSrOIKVN7BMpmKRzvWmPtVXCMMxgR7AP2Bov0JSvXVxm/k2/Kn4+Vch6lvBQl09z5xvEdMKAVgjqvZrczli6BkbZsd4cMEDdq7F9XnuZEDfEU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpdqfHgk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42e5e758093so35983585e9.1
        for <bpf@vger.kernel.org>; Mon, 07 Oct 2024 03:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728295215; x=1728900015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O207R4WqoktJZt+A3zTrnk0InCe8Hn4tCEWXqpWCt1s=;
        b=lpdqfHgkM45YbQTM/WR8PrP7/6RpIzWOXbCv/uFJCwU8Lax8QKp5rYC3fRCad7T0SE
         LWK+Fb5ygIXoXZsFS6vGM0COT+3dp37CoTARpYHztVEejsOVq3kA9XkAbSg86o8qDocw
         8MK+9S8XbQ9iL6gyXxftjAi0Ou2PGWrxqnMpdgpy82fX6S5McgXfGTSylOxTg38Zt9o0
         SZYZJ5MRXlA0hCcZzTbgfnPCxriuPFPMrijldl3t8S515YLuBuj5och48eMoZH1Z+H9Z
         7XyoFRXd3zVPrSHUxeho7ggK36Gvx/A4WcgWgfc7Ay3LzLhBU3Ka81GaRuB385NqIEsd
         LjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728295215; x=1728900015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O207R4WqoktJZt+A3zTrnk0InCe8Hn4tCEWXqpWCt1s=;
        b=R98YXd5X93vseph84xa+hfLUnYceMs9MQSCBk56dL89DWR16HWPWTCtPE0ey4zNez5
         +5wT74YWqluT39znCf7l/venyU/h/DEr9vLuyBlCc7k+GLs1E/ynoTMv7Kvb0XD+Q0XF
         Kot2J6zJD8WdYKMBnL0FJuD6J9eNAxXOkdIw+JokdugfnRadLOmsWbKLqXBYoHullO5H
         xmBxWz6WEDqCFvGoAyI3nConI1x090u/hyA8Mzy8AxpUrxHwyXllvO2L3+UWGmUvYjr5
         67vaA+VnhuwCnb3UHnSwmgiE29Y5SbAoJph+N9Z5piF8jSKUk0lb3hUV2wj9nUBxiySt
         43eQ==
X-Gm-Message-State: AOJu0Yy72M2ykGl4ayZQskhgoGxMLugcQCwvn+lLXOfxjI+3rDBgyYik
	+JU+qhL29itopj66faYJTDUpZT260iyIWLsikBsi/RTMrxK78RqrNvXwgiDvFjM=
X-Google-Smtp-Source: AGHT+IFrY056TsjSZ2YB5wW8WUsgqF8uUb1uc4LF+DMhwKZNgK52Etr63I/uyvyR41ee1f3Wa6gd0w==
X-Received: by 2002:a05:600c:4449:b0:42c:bf70:a303 with SMTP id 5b1f17b1804b1-42f85af4635mr78128565e9.29.1728295214802;
        Mon, 07 Oct 2024 03:00:14 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal (169.218.205.35.bc.googleusercontent.com. [35.205.218.169])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37d1695e84fsm5341188f8f.75.2024.10.07.03.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 03:00:14 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: add tcx netns cookie tests
Date: Mon,  7 Oct 2024 09:59:58 +0000
Message-Id: <20241007095958.97442-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007095958.97442-1-mahe.tardy@gmail.com>
References: <a67821e7-e0e2-442e-a7c4-30889a482806@iogearbox.net>
 <20241007095958.97442-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add netns cookie test that verifies the helper is now supported and work
in the context of tc programs.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../selftests/bpf/prog_tests/netns_cookie.c   | 29 ++++++++++++++-----
 .../selftests/bpf/progs/netns_cookie_prog.c   | 10 +++++++
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/netns_cookie.c b/tools/testing/selftests/bpf/prog_tests/netns_cookie.c
index 71d8f3ba7d6b..ac3c3c097c0e 100644
--- a/tools/testing/selftests/bpf/prog_tests/netns_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/netns_cookie.c
@@ -8,12 +8,16 @@
 #define SO_NETNS_COOKIE 71
 #endif

+#define loopback 1
+
 static int duration;

 void test_netns_cookie(void)
 {
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
 	int server_fd = -1, client_fd = -1, cgroup_fd = -1;
-	int err, val, ret, map, verdict;
+	int err, val, ret, map, verdict, tc_fd;
 	struct netns_cookie_prog *skel;
 	uint64_t cookie_expected_value;
 	socklen_t vallen = sizeof(cookie_expected_value);
@@ -38,36 +42,47 @@ void test_netns_cookie(void)
 	if (!ASSERT_OK(err, "prog_attach"))
 		goto done;

+	tc_fd = bpf_program__fd(skel->progs.get_netns_cookie_tcx);
+	err = bpf_prog_attach_opts(tc_fd, loopback, BPF_TCX_INGRESS, &opta);
+	if (!ASSERT_OK(err, "prog_attach"))
+		goto done;
+
 	server_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
 	if (CHECK(server_fd < 0, "start_server", "errno %d\n", errno))
-		goto done;
+		goto cleanup_tc;

 	client_fd = connect_to_fd(server_fd, 0);
 	if (CHECK(client_fd < 0, "connect_to_fd", "errno %d\n", errno))
-		goto done;
+		goto cleanup_tc;

 	ret = send(client_fd, send_msg, sizeof(send_msg), 0);
 	if (CHECK(ret != sizeof(send_msg), "send(msg)", "ret:%d\n", ret))
-		goto done;
+		goto cleanup_tc;

 	err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.sockops_netns_cookies),
 				  &client_fd, &val);
 	if (!ASSERT_OK(err, "map_lookup(sockops_netns_cookies)"))
-		goto done;
+		goto cleanup_tc;

 	err = getsockopt(client_fd, SOL_SOCKET, SO_NETNS_COOKIE,
 			 &cookie_expected_value, &vallen);
 	if (!ASSERT_OK(err, "getsockopt"))
-		goto done;
+		goto cleanup_tc;

 	ASSERT_EQ(val, cookie_expected_value, "cookie_value");

 	err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.sk_msg_netns_cookies),
 				  &client_fd, &val);
 	if (!ASSERT_OK(err, "map_lookup(sk_msg_netns_cookies)"))
-		goto done;
+		goto cleanup_tc;

 	ASSERT_EQ(val, cookie_expected_value, "cookie_value");
+	ASSERT_EQ(skel->bss->tcx_init_netns_cookie, cookie_expected_value, "cookie_value");
+	ASSERT_EQ(skel->bss->tcx_netns_cookie, cookie_expected_value, "cookie_value");
+
+cleanup_tc:
+	err = bpf_prog_detach_opts(tc_fd, loopback, BPF_TCX_INGRESS, &optd);
+	ASSERT_OK(err, "prog_detach");

 done:
 	if (server_fd != -1)
diff --git a/tools/testing/selftests/bpf/progs/netns_cookie_prog.c b/tools/testing/selftests/bpf/progs/netns_cookie_prog.c
index aeff3a4f9287..c6edf8dbefeb 100644
--- a/tools/testing/selftests/bpf/progs/netns_cookie_prog.c
+++ b/tools/testing/selftests/bpf/progs/netns_cookie_prog.c
@@ -27,6 +27,8 @@ struct {
 	__type(value, __u64);
 } sock_map SEC(".maps");

+int tcx_init_netns_cookie, tcx_netns_cookie;
+
 SEC("sockops")
 int get_netns_cookie_sockops(struct bpf_sock_ops *ctx)
 {
@@ -81,4 +83,12 @@ int get_netns_cookie_sk_msg(struct sk_msg_md *msg)
 	return 1;
 }

+SEC("tcx/ingress")
+int get_netns_cookie_tcx(struct __sk_buff *skb)
+{
+	tcx_init_netns_cookie = bpf_get_netns_cookie(NULL);
+	tcx_netns_cookie = bpf_get_netns_cookie(skb);
+	return TCX_PASS;
+}
+
 char _license[] SEC("license") = "GPL";
--
2.34.1


