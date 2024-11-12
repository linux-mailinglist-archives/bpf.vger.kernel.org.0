Return-Path: <bpf+bounces-44615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306D29C56A2
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 12:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5361DB2D3AE
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 11:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84562213EFA;
	Tue, 12 Nov 2024 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtAhiPce"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A05C213129
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409771; cv=none; b=EQ2Kl+Sf4jAI038C0p6ekEOl2kObVMPJonmsq8wPY/wtl9GAGlMScKIPGoboxsRD+q+fcbTnjt7SCm9GD8pSF1hoWsuR84YHNx6Z/4B4Bx8yuaEYqdRbE+fCdp0GHLch2nU3B+GxGZ1/4xH+j9aXR5SfTHnieAhQ+FlLFsiwFfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409771; c=relaxed/simple;
	bh=6DrMSe8zGJGPSiGwV4J0C5ZfwYoLp2Kc7MGmyGcVGEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3dq+WgbpAcpHKp5nab4E9QdF0E2wdtAnP95odQQVW79k2oXfdh5VHSv3CXAnuIXun3YhJ6rrzEFE2nOnpxRrQV9hk27x2tqtHAaAW9hGtD8Wqg69U6anOus+dk7M03/s5bDIviyrPEQGbLTW4GcdTiDfB7ZkPuai7hzV84Q3CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtAhiPce; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2114214c63eso46168545ad.3
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 03:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731409768; x=1732014568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhEC4u2dafLUPU8BzHjryYcyOG5IYjpEXHjCRLNA+8U=;
        b=QtAhiPceqRrCzihmPwmBNRzJw5KS52rVESBA9L98YBpiOSHFUoJgG+tTmrBtfh/+vu
         JMZn9+SpcuA6tVx/3LLqF7ZuYP+9mUl8c1T8Ni364fmJb9yF2cMyEMCLDI1LpBIHcCx8
         GS2a4Cj9lpvYe4CpIY5w1j0AV3aoC5qes/L8Vm1JxP9D6ZVqsbdod0jACJROqtH5pSdv
         rBJQdDdb/fiUNwF4Tn/NMdKCtK9iJ1iKc5fyDsY+PBV52qDsCoZSMl7B6n0wNbsOOjGc
         EuMNB1vyO59lLB++7c4YiF1MDUooZWCBe+fjEOjGVAmDFRl7LwMf0KPhMm28eSQqKC1F
         O9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731409768; x=1732014568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhEC4u2dafLUPU8BzHjryYcyOG5IYjpEXHjCRLNA+8U=;
        b=tqsEWZkqCUpYMoyHrZDHLWRiaf/dMT5qY1Dq/4fuTy2BInCNNKdUxKZcQI83ZkKD9n
         NCwQEDW0AU9qXO6zfhXPBeMdOQZvE2nyPyPNz5fXXM/krW6hfVyV6NTphJju8RaD6Cm3
         P/8pXZb9xaD93h9ASP9SLSrb/UH9RFzfl3XA4bCc+TilTs2r3AcbafMs/hVVUTY60+dA
         DUTNQSGij54+4rT4h9ZRJD5PWCLI78FQg/4wYYcZsTJaYlBjlSmdWOf5oJ1y/Eu8adR0
         wGT/V82L8wBr5EMkrbdgc/3cSDFVwI2Z4IfJ+mCI0pAcqUucnnA5A90R2v1ABfE4Qx/c
         WBNw==
X-Gm-Message-State: AOJu0YwdvZH8w++ap7NYaRb6Xt7tjb7+AciqToxyhomWn//iMMBSiFYi
	PMx5z6xb96tKO7kELf8rNPTnRoPGApqQUbYqWuMeW9UdRxWCp55Bati3wA==
X-Google-Smtp-Source: AGHT+IGVpI6XnjTWGQtRt4W2lVFqOE1z7GiXlvwbP3bgbAvAkdCpS5hYi8e3NY+aEfRPhb3/Sy1G/g==
X-Received: by 2002:a17:903:11c9:b0:20c:cccd:17a3 with SMTP id d9443c01a7336-2118359c11amr220845465ad.46.1731409768537;
        Tue, 12 Nov 2024 03:09:28 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e45eabsm91789135ad.114.2024.11.12.03.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 03:09:28 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [bpf-next 3/4] selftests/bpf: allow send_signal test to timeout
Date: Tue, 12 Nov 2024 03:09:05 -0800
Message-ID: <20241112110906.3045278-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112110906.3045278-1-eddyz87@gmail.com>
References: <20241112110906.3045278-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following invocation:

  $ t1=send_signal/send_signal_perf_thread_remote \
    t2=send_signal/send_signal_nmi_thread_remote  \
    ./test_progs -t $t1,$t2

Leads to send_signal_nmi_thread_remote to be stuck
on a line 180:

  /* wait for result */
  err = read(pipe_c2p[0], buf, 1);

In this test case:
- perf event PERF_COUNT_HW_CPU_CYCLES is created for parent process;
- BPF program is attached to perf event, and sends a signal to child
  process when event occurs;
- parent program burns some CPU in busy loop and calls read() to get
  notification from child that it received a signal.

The perf event is declared with .sample_period = 1.
This forces perf to throttle events, and under some unclear conditions
the event does not always occur while parent is in busy loop.
After parent enters read() system call CPU cycles event won't be
generated for parent anymore. Thus, if perf event had not occurred
already the test is stuck.

This commit updates the parent to wait for notification with a timeout,
doing several iterations of busy loop + read_with_timeout().

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/send_signal.c    | 32 +++++++++++--------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index 1aed94ec14ef..4e03d7a4c6f7 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -3,6 +3,7 @@
 #include <sys/time.h>
 #include <sys/resource.h>
 #include "test_send_signal_kern.skel.h"
+#include "io_helpers.h"
 
 static int sigusr1_received;
 
@@ -24,6 +25,7 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 	int pipe_c2p[2], pipe_p2c[2];
 	int err = -1, pmu_fd = -1;
 	volatile int j = 0;
+	int retry_count;
 	char buf[256];
 	pid_t pid;
 	int old_prio;
@@ -163,21 +165,25 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 	/* notify child that bpf program can send_signal now */
 	ASSERT_EQ(write(pipe_p2c[1], buf, 1), 1, "pipe_write");
 
-	/* For the remote test, the BPF program is triggered from this
-	 * process but the other process/thread is signaled.
-	 */
-	if (remote) {
-		if (!attr) {
-			for (int i = 0; i < 10; i++)
-				usleep(1);
-		} else {
-			for (int i = 0; i < 100000000; i++)
-				j /= i + 1;
+	for (retry_count = 0;;) {
+		/* For the remote test, the BPF program is triggered from this
+		 * process but the other process/thread is signaled.
+		 */
+		if (remote) {
+			if (!attr) {
+				for (int i = 0; i < 10; i++)
+					usleep(1);
+			} else {
+				for (int i = 0; i < 100000000; i++)
+					j /= i + 1;
+			}
 		}
+		/* wait for result */
+		err = read_with_timeout(pipe_c2p[0], buf, 1, 100);
+		if (err == -EAGAIN && retry_count++ < 10000)
+			continue;
+		break;
 	}
-
-	/* wait for result */
-	err = read(pipe_c2p[0], buf, 1);
 	if (!ASSERT_GE(err, 0, "reading pipe"))
 		goto disable_pmu;
 	if (!ASSERT_GT(err, 0, "reading pipe error: size 0")) {
-- 
2.47.0


