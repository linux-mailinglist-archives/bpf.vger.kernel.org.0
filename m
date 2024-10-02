Return-Path: <bpf+bounces-40779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9ED98E1F9
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 19:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED1C1C22CDB
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 17:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD45F1D1E8D;
	Wed,  2 Oct 2024 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZsS8Bof"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B835E1D1E7C
	for <bpf@vger.kernel.org>; Wed,  2 Oct 2024 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727891891; cv=none; b=B42V0rgwFFOhWvMlipSOI1lyY2Oy5NMJGKfvN07zgGcrXtJHaLQGcdGQK/ZOg3wW4VjNDe6NQ6ltntIbpDmu7mUmhghFndxCCztADf9u/wwho0XTuNub9m2aXc7phO54dZ5d9wS16wxnAL+hPtd1DQA0lTBO4hhWThYw0XxovWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727891891; c=relaxed/simple;
	bh=ARccJMCiTtTfWzlmhDUm4xi8p0VIp4X3nP38O8rlkjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NKD5a2kFmr13tyjR56CQDBuB6tVJQQViSqRbHkbAHyL+qt8m2ky7jfLL36Mjf2MA1ilySLXiIXjURfX5/cQM4WFE2PIqCbMcKL2W9YIyEQzMmL4r55izxf67xSCdhAk92jEISetNhKuTJVxvs+2h0GbuMhpzWgDuXGVISKmsn1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZsS8Bof; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so204425e9.3
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2024 10:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727891888; x=1728496688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUzWevPH/3NOwhroQAK/SlMUjSktsgPIJ0EELVj5jkc=;
        b=AZsS8BofxuGCZNvUIHNtLLzh1aVddDtmaOvqyTmuySGSYME7d59kili6tbcBYphmXR
         e/6uwtYGp61rQuk2V33gIaEj2jetimAGR5SJSUBhYwbbgmMJ75SLsl0zlrhOjCdlY8zW
         YA6NmtkU/1lf/Teh1iR5FMgxOHXBebdB9y9dGNe5pkxRk+AdgavPCw3UjACOaYN5IiWi
         pVhvMN6VfVwCQVDIhQ5swzvkZZYdCZcTxWXyLYWgTBGo2kwPyVvmqQkxqLwCnDgDa9PG
         EaugurbMsj+2tggOYzvG1o8V8Yu+09jkzR/U5qAQbKJLWXBNywWmo03SZ6Z9ezYBH2ON
         JMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727891888; x=1728496688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUzWevPH/3NOwhroQAK/SlMUjSktsgPIJ0EELVj5jkc=;
        b=UxDSmhI1NLj86esgPvnKgxWAiy9WEm8v0xHFtksTIoDL3wbjZIZ9RkW8QNRUS3PFkg
         I1+crFVuscHsVAWTHDcq7GL/K/TYxAG8BAEDZZ1ROEZB/0gUV/tU5IrgOWwvJz4kgAwm
         5aGDokKRgFudenCaChlDtD+JOE8BHMyKb18vaozwnQ9jfUR1njFw4vACqk6wJy7WOqmH
         nlWj7Y6d8+tbLXMYyyleK/OOOf5oRC9E9QRzkU34tGMf7Cy0yvWqsynbzvngXl6HcIXp
         rNyPcNQAwxLfKA6WA5OEO45+H8wlTy22GzNh8sw9jhFdCeZBa0ld376FqefgXMl09PC9
         3BHg==
X-Gm-Message-State: AOJu0YxF1Sse+UEZ34IAC0RASHbnMwUl6XClf6RYriTil/zg92VsiXXM
	yHM2/9NH4/X34adfVxca25TupX5vWWJoIFFHA3nAnXv7NeMAaUsa3hjvwAhe0WZe7w==
X-Google-Smtp-Source: AGHT+IEokQKAE/+0iw/sHElfQHlg7ytryID1hK73DxfXWXh3X1srWf9pD64j0E4ZeEUZrJ0UuTe9sA==
X-Received: by 2002:a05:600c:4587:b0:42c:bae0:f05f with SMTP id 5b1f17b1804b1-42f777ba357mr35959605e9.13.1727891887808;
        Wed, 02 Oct 2024 10:58:07 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal (114.73.211.130.bc.googleusercontent.com. [130.211.73.114])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f7a00bc5csm25616495e9.45.2024.10.02.10.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 10:58:07 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: add tcx netns cookie tests
Date: Wed,  2 Oct 2024 17:57:26 +0000
Message-Id: <20241002175726.304608-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002175726.304608-1-mahe.tardy@gmail.com>
References: <f05e5f07-467d-441a-8113-0a7c4cb2c842@iogearbox.net>
 <20241002175726.304608-1-mahe.tardy@gmail.com>
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
 .../selftests/bpf/prog_tests/netns_cookie.c   | 28 ++++++++++++++-----
 .../selftests/bpf/progs/netns_cookie_prog.c   |  9 ++++++
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/netns_cookie.c b/tools/testing/selftests/bpf/prog_tests/netns_cookie.c
index 71d8f3ba7d6b..a014082d1e09 100644
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
@@ -38,36 +42,46 @@ void test_netns_cookie(void)
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
+	ASSERT_EQ(skel->bss->tcx_netns_cookie, cookie_expected_value, "cookie_value");
+
+cleanup_tc:
+	err = bpf_prog_detach_opts(tc_fd, loopback, BPF_TCX_INGRESS, &optd);
+	ASSERT_OK(err, "prog_detach");

 done:
 	if (server_fd != -1)
diff --git a/tools/testing/selftests/bpf/progs/netns_cookie_prog.c b/tools/testing/selftests/bpf/progs/netns_cookie_prog.c
index aeff3a4f9287..207f0e6c20b7 100644
--- a/tools/testing/selftests/bpf/progs/netns_cookie_prog.c
+++ b/tools/testing/selftests/bpf/progs/netns_cookie_prog.c
@@ -27,6 +27,8 @@ struct {
 	__type(value, __u64);
 } sock_map SEC(".maps");

+int tcx_netns_cookie;
+
 SEC("sockops")
 int get_netns_cookie_sockops(struct bpf_sock_ops *ctx)
 {
@@ -81,4 +83,11 @@ int get_netns_cookie_sk_msg(struct sk_msg_md *msg)
 	return 1;
 }

+SEC("tcx/ingress")
+int get_netns_cookie_tcx(struct __sk_buff *skb)
+{
+	tcx_netns_cookie = bpf_get_netns_cookie(skb);
+	return TCX_PASS;
+}
+
 char _license[] SEC("license") = "GPL";
--
2.34.1


