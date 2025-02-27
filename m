Return-Path: <bpf+bounces-52785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE431A487D0
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 19:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38ABD3A3D1C
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 18:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059AD1FFC54;
	Thu, 27 Feb 2025 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHsaqKEI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55151E521C
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 18:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680936; cv=none; b=a7XH4QkHpYSxhNT/hd9r8jNLKfbnDMPir+PfZb1zNgkYIXkqrm0IY+2fBxcbNtPwAQ8ubz9Pvt1mAW9Fq6dW4l92BlKxFobJwBnV9En9hq2zAP0w3uaLqZf/6ab3tNIhIuReo3PZbXLm/i7rNrz6fZVNep9fV3BGQfZSW47m3Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680936; c=relaxed/simple;
	bh=fnObYwSVgtLSSnNj+cndHsYZTAr/G/Og4ubF6v3a0QI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TQQbQ6UbKJ8IlKEL3rvHp+Ac9rh+2jBKm0vVy/V+YiITHf87IYTplv+R0T3w59H6ySOefOJ8j5GG0xi0NQhhIu6mJ/U7GA26ULzZn/Ze5/DDNJqZwMzPy8xGNOfpF8aGkbDZ6bLEcXCzkJB8p0gM7//ybhbqJjpPxp25hJ4D4XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHsaqKEI; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390e6ac844fso978808f8f.3
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 10:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740680933; x=1741285733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ier3rDk/bcmTrP8fXyaUKutb4o6OOTyjLkTKL1X5Dew=;
        b=eHsaqKEIqGY3I04bMAsDFJIdWrPd0ae5AjkwAjAP00aHKtrq/l/wmFl3o/MAdts/NV
         ZrnITVC5Kt81sfsFNnRQR8wDBXyUY8/ArOv4fYUe1PGNtWGM7nhcb5KZeAJbu0tfYtkO
         6WXvJ/R6t9lSMRhMBO1hXrZrnAlWs8B5xqmClHDfaI2ltEwnr4hdAcqYAJAcCHX+9nXK
         +ES2JNS3K2OUml1ASnh6cWzARvZrGzfYGgYxqVuabjfQw8uMjNCAJx7X4j5oddBUDfiN
         KNPEI0Q29fXNHOuN3T3hL3JnV47DfoMT7xer33waiJGgOmRXp36OZpaM5K03CM6D9sj2
         KR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740680933; x=1741285733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ier3rDk/bcmTrP8fXyaUKutb4o6OOTyjLkTKL1X5Dew=;
        b=Gj68IuWwHrXBv3S814FdnuNux7oLMecDAsGYLmkdHzGgQG5pcAqH0NicY7nu9gyjrE
         jpk0dGfjUSARUR1aHfNDwJVW5f86pgtnBrn7W9UvoViP1ZbTHnfPVAmFuPFXlkjXBr6J
         i1SgROvFYhQl7TATD/JBPHPN/K8DH3Udat/L7wsQJByofUnPA+Kf/zvq88bqu/iFzvvx
         mC+O0ve4DaskN2kUW/ZenhkvbaOGUkLspbqnS3pGllHGvXRfxsGLElKzfzZmAM6jVmnl
         tecI1I5yXcMp8nSwI1reBRZA28cV9azZ+m956L2J5hwfU8tf2AhzmUVRQp6hcHKal0KZ
         Zv7w==
X-Gm-Message-State: AOJu0Yy3v0Qq8N/2cFikkWvBTXzEkD9ORHGxjrq3m9j5h4du74rDeAEc
	25oZtRcn/9TILYJptNuP3RjrNNDH9OY9YnvEWSibR29ueyyizAIKCftTcDxgY27dM14P
X-Gm-Gg: ASbGncttXx309wI36rTOGcLYkTzTQko9sgI6DOgG46qC6RVMpTbs6kQMjY8CGQvfGZ9
	KhTUs/8FugChVDazg/FmISd+Jhpr3jtNK1CuCVUSQvkkOSIiR+s/hCtdtcKWkeIr2HoK496/wvv
	HZxfbf3U8bG0MtIr+DOr5sHg4QyXF0LaX7+hhq79yM/yLl8hqIDkTnFPBPwiPZgJ127/fYewrdx
	ih5N6MmyGo+B/BpdLMCkDdzs7JkxaOAsANVwvoNOUaEDOYediw4oFVSDqJTjINIvKbpOq5jXT1J
	r9vSEaFi8XnX01NVstCkmqM3O6IQi/nBp0VaZUh5/sb9JQ3HkTZs
X-Google-Smtp-Source: AGHT+IEtUgT8EZN9yXSOuau1u9A4bfqjIvunLh2SmnpUL5cLIglhbgPa7PjfeJHq7tuKDig1vZKsaQ==
X-Received: by 2002:a05:6000:2108:b0:38f:2289:90f1 with SMTP id ffacd0b85a97d-390ec7d20a4mr192683f8f.29.1740680932955;
        Thu, 27 Feb 2025 10:28:52 -0800 (PST)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-390e47a66c9sm2818233f8f.33.2025.02.27.10.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:28:52 -0800 (PST)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	jolsa@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: add tracing netns cookie tests
Date: Thu, 27 Feb 2025 18:28:30 +0000
Message-Id: <20250227182830.90863-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227182830.90863-1-mahe.tardy@gmail.com>
References: <20250227182830.90863-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add netns cookie test that verifies the helper is now supported and work
in the context of tracing programs.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/netns_cookie.c |  7 +++++++
 .../testing/selftests/bpf/progs/netns_cookie_prog.c | 13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/netns_cookie.c b/tools/testing/selftests/bpf/prog_tests/netns_cookie.c
index e00cd34586dd..53a3272f3e32 100644
--- a/tools/testing/selftests/bpf/prog_tests/netns_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/netns_cookie.c
@@ -52,6 +52,11 @@ void test_netns_cookie(void)
 	if (!ASSERT_OK_PTR(skel->links.get_netns_cookie_cgroup_skb, "prog_attach_cgroup_skb"))
 		goto cleanup_tc;

+	skel->links.get_netns_cookie_tracing = bpf_program__attach(
+			skel->progs.get_netns_cookie_tracing);
+	if (!ASSERT_OK_PTR(skel->links.get_netns_cookie_tracing, "prog_attach_tracing"))
+		goto cleanup_tc;
+
 	server_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
 	if (CHECK(server_fd < 0, "start_server", "errno %d\n", errno))
 		goto cleanup_tc;
@@ -86,6 +91,8 @@ void test_netns_cookie(void)
 	ASSERT_EQ(skel->bss->tcx_netns_cookie, cookie_expected_value, "cookie_value_tcx");
 	ASSERT_EQ(skel->bss->cgroup_skb_init_netns_cookie, cookie_expected_value, "cookie_value_init_cgroup_skb");
 	ASSERT_EQ(skel->bss->cgroup_skb_netns_cookie, cookie_expected_value, "cookie_value_cgroup_skb");
+	ASSERT_EQ(skel->bss->tracing_init_netns_cookie, cookie_expected_value, "cookie_value_init_tracing");
+	ASSERT_EQ(skel->bss->tracing_netns_cookie, cookie_expected_value, "cookie_value_tracing");

 cleanup_tc:
 	err = bpf_prog_detach_opts(tc_fd, loopback, BPF_TCX_INGRESS, &optd);
diff --git a/tools/testing/selftests/bpf/progs/netns_cookie_prog.c b/tools/testing/selftests/bpf/progs/netns_cookie_prog.c
index 94040714af18..5de573571640 100644
--- a/tools/testing/selftests/bpf/progs/netns_cookie_prog.c
+++ b/tools/testing/selftests/bpf/progs/netns_cookie_prog.c
@@ -3,6 +3,7 @@
 #include "vmlinux.h"

 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>

 #define AF_INET6 10

@@ -29,6 +30,7 @@ struct {

 int tcx_init_netns_cookie, tcx_netns_cookie;
 int cgroup_skb_init_netns_cookie, cgroup_skb_netns_cookie;
+int tracing_init_netns_cookie, tracing_netns_cookie;

 SEC("sockops")
 int get_netns_cookie_sockops(struct bpf_sock_ops *ctx)
@@ -100,4 +102,15 @@ int get_netns_cookie_cgroup_skb(struct __sk_buff *skb)
 	return SK_PASS;
 }

+SEC("fexit/inet_stream_connect")
+int BPF_PROG(get_netns_cookie_tracing, struct socket *sock,
+	struct sockaddr *uaddr, int addr_len, int flags)
+{
+	if (uaddr->sa_family != AF_INET6)
+		return 0;
+	tracing_init_netns_cookie = bpf_get_netns_cookie(NULL);
+	tracing_netns_cookie = bpf_get_netns_cookie(sock->sk);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
--
2.34.1


