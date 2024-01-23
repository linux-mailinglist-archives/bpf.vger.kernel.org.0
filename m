Return-Path: <bpf+bounces-20136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB09839C58
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 23:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F141C269C6
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 22:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F40C53E0F;
	Tue, 23 Jan 2024 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGKg/qkA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6277753E0C;
	Tue, 23 Jan 2024 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049382; cv=none; b=a8nszyH/HRVyFWnwGzMngYUzRZ3ja5PxV68CNSkmklZHXegsbiVReEY6vLBfpgneLux7LpMOrvVg/WwCH4enaC3AW7Ih5RLyXEjl6TV1tS4N6dEwbaUd7E5TwcIpxgwvo+/pyysOc5vaSM3ye0NtFeWvv2C0ZB7F2E0WwAhzRK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049382; c=relaxed/simple;
	bh=Zxjr/wFZHNPfZI7hjGnd8zzvcRjQMMPjId/saWss+eI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GmoMX9xgC65JZ4AtojRDf87HCVlSAAg/YEzsOE/8HSdyudI6EHcDd1XoNeWeor628jufHt+vFbE6u1wDAifu3acKhT7C2vGFDPFbyjfZS+GztcWD7Rqc+f30Wy1Ztlgdk7pRSVBcj8UgJppKYIHXBsAC3q3jk7thty85x9db1hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGKg/qkA; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5ce2aada130so2641392a12.1;
        Tue, 23 Jan 2024 14:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706049379; x=1706654179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eSy+rPOCovSpewSX72LD7wMXTxiQZ2pIn9/KLzvYuE=;
        b=DGKg/qkA8t8zRgUKai4ms1YeCCL34yiYXWhuumpM7O3w+bFro1mDKOAKWNjA/bGS4N
         7vnGtUu7kvQr0RaW63zQLhT/lhLbbaU94m5d/w1RslpELcbnhhzvFZc5ffiFigzjp/XF
         8m62kIuurVLaNZ5CPAn9Kx9oJvJzNwURYh4p9OH9EQYrOxfmznyUj2IMztyv5ZTfexDI
         4kS/wYXskoY7BRtP1c+JcsdI1W4nCzc0+vdcVBiro48s1+dPcoeKVgRjP2AvZ2qLAvdN
         KAn1t3NI+o3M43RXRyCvh0BvzD9wnZRRO/75AeUshk90wHElO+++lhg15XTt0k8Mi1U2
         qV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706049379; x=1706654179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9eSy+rPOCovSpewSX72LD7wMXTxiQZ2pIn9/KLzvYuE=;
        b=IQ4rqjAIAn0WDAT5BxjAwCxdT0OjEOn15IwYG0sHc/ZGH3z53ss+OLEA0jKS0zg2Od
         6q+bFBgw6pYwZyAlo7qcYdrEA5KLK/XKSJgwcLrnGAT35zM7EHvCCygINSFaw6nbe6Zb
         9estRGWwN1ARwgi1O4gARhBX0BO1oVdDf3KkdyNDwnkaKZjdw51hVAEddSXi2uaM2Put
         kXc2XKKpW3XGqZUTE1sLXYh44LNan73vDYpCJJfWWZgzB/u1JpDQF1E3D/qulRIioOSo
         Jpz5kag05lQxJ2LyX9obTx8LSqhO6am4fj0ylmeDgL/GHoE1ExRSRQNpeAtTO5eDjY1+
         CbsA==
X-Gm-Message-State: AOJu0YwkgV6S1LRMr5llefvPhzxINPZ557FkZUJZx8hoE2WFoPN8GcnK
	WIYTjgJS0HFfKM2v745By3BcLb9ruiFMlSIO8Z4fD4ld+8q+QJIgvotTj0ww
X-Google-Smtp-Source: AGHT+IGdImkWoLsGuZ/kQxMZ3kMYwtNqMgfIxwGrxn5Qi95t6kZkQAREB2iGciIzlnQfJinhIM0TDQ==
X-Received: by 2002:a05:6a20:7352:b0:19b:a07a:344d with SMTP id v18-20020a056a20735200b0019ba07a344dmr4390121pzc.7.1706049379577;
        Tue, 23 Jan 2024 14:36:19 -0800 (PST)
Received: from john.. ([98.97.113.214])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902e04900b001d73f1fbdd9sm4875241plx.154.2024.01.23.14.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 14:36:18 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: netdev@vger.kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 2/4] bpf: sockmap, add a sendmsg test so we can check that path
Date: Tue, 23 Jan 2024 14:36:10 -0800
Message-Id: <20240123223612.1015788-3-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240123223612.1015788-1-john.fastabend@gmail.com>
References: <20240123223612.1015788-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sendmsg path with multiple buffers is slightly different from a single
send in how we have to handle and walk the sg when doing pops. Lets
ensure this walk is correct.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 .../bpf/prog_tests/sockmap_helpers.h          |  8 +++
 .../bpf/prog_tests/sockmap_msg_helpers.c      | 53 +++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
index 781cbdf01d7b..4d8d24482032 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
@@ -103,6 +103,14 @@
 		__ret;                                                         \
 	})
 
+#define xsendmsg(fd, msg, flags)                                               \
+	({                                                                     \
+		ssize_t __ret = sendmsg((fd), (msg), (flags));                 \
+		if (__ret == -1)                                               \
+			FAIL_ERRNO("sendmsg");                                 \
+		__ret;                                                         \
+	})
+
 #define xrecv_nonblock(fd, buf, len, flags)                                    \
 	({                                                                     \
 		ssize_t __ret = recv_timeout((fd), (buf), (len), (flags),      \
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c b/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
index 0fe3172a6c43..7eeba3a35242 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
@@ -52,6 +52,50 @@ static void pop_simple_send(struct msg_test_opts *opts, int start, int len)
 	ASSERT_OK(cmp, "pop cmp end bytes failed");
 }
 
+static void pop_complex_send(struct msg_test_opts *opts, int start, int len)
+{
+	struct test_sockmap_msg_helpers *skel = opts->skel;
+	char buf[] = "abcdefghijklmnopqrstuvwxyz";
+	size_t sent, recv, total = 0;
+	struct msghdr msg = {0};
+	struct iovec iov[15];
+	char *recvbuf;
+	int i;
+
+	for (i = 0; i < 15; i++) {
+		iov[i].iov_base = buf;
+		iov[i].iov_len = sizeof(buf);
+		total += sizeof(buf);
+	}
+
+	recvbuf = malloc(total);
+	if (!recvbuf)
+		FAIL("pop complex send malloc failure\n");
+
+	msg.msg_iov = iov;
+	msg.msg_iovlen = 15;
+
+	skel->bss->pop = true;
+
+	if (start == -1)
+		start = sizeof(buf) - len - 1;
+
+	skel->bss->pop_start = start;
+	skel->bss->pop_len = len;
+
+	sent = xsendmsg(opts->client, &msg, 0);
+	if (sent != total)
+		FAIL("xsend failed");
+
+	ASSERT_OK(skel->bss->err, "pop error");
+
+	recv = xrecv_nonblock(opts->server, recvbuf, total, 0);
+	if (recv != sent - skel->bss->pop_len)
+		FAIL("Received incorrect number number of bytes after pop");
+
+	free(recvbuf);
+}
+
 static void test_sockmap_pop(void)
 {
 	struct msg_test_opts opts;
@@ -92,6 +136,15 @@ static void test_sockmap_pop(void)
 	/* Pop from end */
 	pop_simple_send(&opts, POP_END, 5);
 
+	/* Empty pop from start of sendmsg */
+	pop_complex_send(&opts, 0, 0);
+	/* Pop from start of sendmsg */
+	pop_complex_send(&opts, 0, 10);
+	/* Pop from middle of sendmsg */
+	pop_complex_send(&opts, 100, 10);
+	/* Pop from end of sendmsg */
+	pop_complex_send(&opts, 394, 10);
+
 close_sockets:
 	close(client);
 	close(server);
-- 
2.33.0


