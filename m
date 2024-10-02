Return-Path: <bpf+bounces-40773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7698E98E007
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 18:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7EC61C228EE
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 16:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B971D0DC8;
	Wed,  2 Oct 2024 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRmG1PAr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7703E1CFEA5
	for <bpf@vger.kernel.org>; Wed,  2 Oct 2024 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884893; cv=none; b=L2UD2QOEdT3e8zOOs7FLcAx8OZUqvuhi1GM0B093LQG4GHvHe13HqYRgroJUApXvBfO0xSmFQtpzsVVIQVxkZyR2H+OjOyYGNOJAcfufoKOb8wZoL8ehJqUuDSJwG3195bJ0fW3j3jcWw25xaTbkdvT535fO4hFsVZvE8QyFhyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884893; c=relaxed/simple;
	bh=BtnsRGPA8XOiZYbKnNCisjXiOnbN+quxIWmQj1Mw1w8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ikHzNDiOfuu+V+q8YY/NeDEXRaK8nYrNnDaNLpOTof/bMFz3T1m3qPgoGJ7iMXs0IwycldhSBi7pokBej1Q3ay1VuLSVZTFT+3dDHiUDLQSj63urdN7oqSYqfYk55hxM5ClBa2pWi0Aky1Dy61566xYsweQreD1o+2gwCCAkoWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRmG1PAr; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5389917ef34so8111380e87.2
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2024 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727884889; x=1728489689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgb/2NooKv77QEDz66ed5qIFDIWE50J5diu8JTbvXBk=;
        b=bRmG1PAr2a1dotACImMeHxkzMZI747G+DzfRSZ9hUBK5mEbSEvSv2krtfGD6YBYzHF
         ftXD8ZGJVo1BBW0Fpfz8RGGRNm4/f7j9XljeXzJHv2hICy5B40snWoSJuuzDP2idpzyc
         jcmJAH84I4JW/SI6ULyA3eUKjUs8DpfUL95cvBE5g771NFOxcFmYIgJpzE6K4SaQBJ/J
         FMFBeMOp0RyEzByB8enBMVuZph5wK90ApJVcS3iMvPANJdxhCcz5fbYcdmjn1gHYWW8I
         vZzSHsTcd8RzBfdiYphHRG+iYp48t6DMGvMhcVREP3smCm0gxc+rsUfiruwsHx/9jdP7
         bY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727884889; x=1728489689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgb/2NooKv77QEDz66ed5qIFDIWE50J5diu8JTbvXBk=;
        b=oow/IZ1aksaGNP3Fxl2VGfu39YGyoU8rXjrTAVzW1AmCk/4ouTUR75a5NyTqXTw/np
         oY92vUdGbV9grOD3pFntLqgq3PsZcJxeRwb+QMfWPuWCnsD2+erQvG9IZcl0wSjxTGnO
         1AjaWPV16SD8lEUwbzSKBMI3Pz0HnFJiyFDxCC23sZMh1OVzt5TSXPvwUOJ6OU1FEmIc
         4QyyhkEh+lNO0J7D1hHe9/vNPRh2+QPocf9pAvFY2QwlT8EnzaZv8eiuZIbQ2FHDwAXo
         itm83Wa+Jak7X2gMvzm/dEI90dWZl7MqFDWZSzL40LYdAg2P6JB/Q7+YLcyHP7LgCRM/
         bV0Q==
X-Gm-Message-State: AOJu0Yy5FK7q1YRWynvJ1u9TBldFjmANualIC0ZRdt/hMHlEWphpv+iz
	xQWBwq3D8IEWloilD3Eon5Mma0JKrmSny4LHWSRQJRmSd2L6291y3rBCsGUmG0aCyQ==
X-Google-Smtp-Source: AGHT+IH/3nidgN05YUBIxXJ33tpMQW/fkNj5XmyMQ5iRgH7NaGcAMxZSVFmOPM8l48K4pt9nHl21QQ==
X-Received: by 2002:a05:6512:b18:b0:52c:dfa0:dca0 with SMTP id 2adb3069b0e04-539a0793cd9mr2273204e87.43.1727884889009;
        Wed, 02 Oct 2024 09:01:29 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal (114.73.211.130.bc.googleusercontent.com. [130.211.73.114])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37cd56e65c3sm14193982f8f.60.2024.10.02.09.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:01:28 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: add tcx netns cookie tests
Date: Wed,  2 Oct 2024 16:01:22 +0000
Message-Id: <20241002160122.148980-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002160122.148980-1-mahe.tardy@gmail.com>
References: <20241002160122.148980-1-mahe.tardy@gmail.com>
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
 tools/testing/selftests/bpf/prog_tests/netns_cookie.c | 7 +++++++
 tools/testing/selftests/bpf/progs/netns_cookie_prog.c | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/netns_cookie.c b/tools/testing/selftests/bpf/prog_tests/netns_cookie.c
index 71d8f3ba7d6b..233fd66f59ee 100644
--- a/tools/testing/selftests/bpf/prog_tests/netns_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/netns_cookie.c
@@ -12,6 +12,7 @@ static int duration;

 void test_netns_cookie(void)
 {
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
 	int server_fd = -1, client_fd = -1, cgroup_fd = -1;
 	int err, val, ret, map, verdict;
 	struct netns_cookie_prog *skel;
@@ -38,6 +39,11 @@ void test_netns_cookie(void)
 	if (!ASSERT_OK(err, "prog_attach"))
 		goto done;

+	verdict = bpf_program__fd(skel->progs.get_netns_cookie_tcx);
+	err = bpf_prog_attach_opts(verdict, 1, BPF_TCX_INGRESS, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto done;
+
 	server_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
 	if (CHECK(server_fd < 0, "start_server", "errno %d\n", errno))
 		goto done;
@@ -68,6 +74,7 @@ void test_netns_cookie(void)
 		goto done;

 	ASSERT_EQ(val, cookie_expected_value, "cookie_value");
+	ASSERT_EQ(skel->bss->tcx_netns_cookie, cookie_expected_value, "cookie_value");

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


