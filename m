Return-Path: <bpf+bounces-74066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 688CDC47038
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 14:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143B7188F73A
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 13:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A1B30E849;
	Mon, 10 Nov 2025 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZR29Dl4K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2457122D780
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782551; cv=none; b=AF/UlKpo2PAS1bMzKxoqySLgOF9+GT6aaa1Y+Xvkhp0d1Tjv/Jnky8HBTa6zeE4HqHlDb8zfr7fGEsFh0/1ORTLaM0SdcjvArioyKb8VO3k3iIerlsTPN4IkcLAT7fmz91GjEXApX22z8at7heF1MG+dAtChj+TSOZvyw04nmmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782551; c=relaxed/simple;
	bh=TQ7h6Mz2s/JbJILiZ/3bEy00deZQ+pPh63bYADHti9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e40l1hVQ4AiWQ1lkr6EeG4M1V5AomaH2wutqEnyw1jjYGLC+0LSu4GahJ7cfyUNq/+AF+tHbQegsK9/alEfFRO5mPfz8bDtWjdjoWmmXd+BB2iV/WcLGAIRlS3NLrK44peF34qq/cQbFU9jWUPt0MwLKSOQcfxVrERNX4FH3/gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZR29Dl4K; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2958db8ae4fso25165675ad.2
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 05:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762782547; x=1763387347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p/QXwQnS4eai1OeNWeo93T9s/bj/XOu9GVduo6Pa63U=;
        b=ZR29Dl4KN1Zo58bbUU+Ac+1Q2bFeTsgjFrXYOD5LbL4xxNITq8aq24ahp49uM2fZxs
         /+2Kko/5gsbrtw+oEcjz+feHL5dtKEzTo5c4yjM2ezHFKpO5oDthn8AXoAIvfoRsGQE4
         dnas0Ar1lNsFT00QPcBGPPvDiLWWFTgfbuUfeOUv0VTmSIM5lYazX73gY7XYMtjWtFcC
         9J3qho6jmbnhW/yrtS9yxwvpPK+pijgUWmhtO9nYYVprrGl29hN0jDUjcwhUSKtF/gPY
         yacupPyZOz7vOG6oG6VuOeLtNquK6YOBkDsm8ayJ7Db7Jy4JTDm6Qwvsozp66UmkY85G
         u1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762782547; x=1763387347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/QXwQnS4eai1OeNWeo93T9s/bj/XOu9GVduo6Pa63U=;
        b=pS59i+FGpr6EiSabvtDE/5ttbPvJR3i2HDMptiPHmHvzexYYNoSm3uQBayhRnwZKzs
         Jj3ni0+YhbpLA37pu3C4/2GN7KOfkciezb5Xzp2Cv3wGRU8LXu/l+VDFaK261Enk95aK
         sSvwQLHZ2A9Pq7a0gZbKXYD0gNTCGLFSYIikW1zVLDJ3X9n1qyz1YIEKjpGyhRAXUP9A
         aW8TBSYduVqwmOxTJBkt6lN5Xps7OnBjANj5rJkcXS1evJjdLz4TJF8nwgGbUZSNb2Qz
         pnJDkNIMfr/Ke1LI5Dgd2RJLnxSnMR88ODUQXaQ1rOI8SGGXRD5FzjBGf0LWZ8g2E2zn
         UNhg==
X-Forwarded-Encrypted: i=1; AJvYcCVA8N3F89MFeqsWD5oZFK1p+EM06PpSCnBaPSvK9NAEDk0KBoAvxU2VvLLI+gI41lXenuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFDejpzk9wYszWT88Var1WqTctTyv60n4gXy1FVxiP76qa2SQc
	oQhY+OZG5SRC3bbSAQJBwgqHdmLRIT9HH0BrmqfqFa8ViXN6SJVz4O5n
X-Gm-Gg: ASbGncsRAOIXbSRZEC9AILqOWZYH7VXU5Q5YIoH8GZjx98MGYo3XUXdVMEXfZHyssla
	1vlWJB+jhdu8mP1evYZw5YqLLPF4/WBRXIqfDaYB1zR4N4wvR+Z4WFYYZJpOzHuUuM9gaYSD0fA
	tcUyGgVZmXBNasVE3jkpcuSdQY/x9J+XIqZDNFiDm/UWtGMMZ1PwYarQHsLNYJEoU5a1koowO6H
	QoRbP4W5H0aBH5aVPwMG/ie046MHIP5RFINwW7k3V3309cvVbBeO60gCd5O3USPrmZDe479Rxem
	gEDdTujiYVRLmDmpzOoo5tfDWxCVwkDN5RFsNtuPzQKSjAOrrdxzhhnFFd3/zBP/IE8ZB8S10vl
	Ao7napU7ZntEYHfYbu6ODwON/9R/ke0p/TBdrpV8P1aJ1ckZBfgTyf+6tsuWpntH6o/i2bJpb8m
	1Z6bhYWPNFREI=
X-Google-Smtp-Source: AGHT+IEoH96+sjPLREqC+n2bvCIzOJwtJGtj0Xw/w+23Qs6yfYObqzh3NEEEQcrylABhRl8Rgvzm6g==
X-Received: by 2002:a17:902:fc8f:b0:27e:eabd:4b41 with SMTP id d9443c01a7336-297e5413468mr105009555ad.7.1762782547210;
        Mon, 10 Nov 2025 05:49:07 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccca64sm146648475ad.105.2025.11.10.05.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 05:49:06 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	mingo@kernel.org,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: simplify the kernel_count bench trigger
Date: Mon, 10 Nov 2025 21:48:58 +0800
Message-ID: <20251110134858.1664471-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the "trigger_count" in trigger_bench.c and reuse trigger_driver()
instead for trigger_kernel_count_setup().

With the calling to bpf_get_numa_node_id(), the result for "kernel_count"
will become a little more accurate.

It will also easier if we want to test the performance of livepatch, just
hook the bpf_get_numa_node_id() and run the "kernel_count" bench trigger.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../selftests/bpf/benchs/bench_trigger.c        |  5 +----
 .../testing/selftests/bpf/progs/trigger_bench.c | 17 +++++------------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 1e2aff007c2a..34fd8fa3b803 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -179,11 +179,8 @@ static void trigger_syscall_count_setup(void)
 static void trigger_kernel_count_setup(void)
 {
 	setup_ctx();
-	bpf_program__set_autoload(ctx.skel->progs.trigger_driver, false);
-	bpf_program__set_autoload(ctx.skel->progs.trigger_count, true);
+	ctx.skel->rodata->kernel_count = 1;
 	load_ctx();
-	/* override driver program */
-	ctx.driver_prog_fd = bpf_program__fd(ctx.skel->progs.trigger_count);
 }
 
 static void trigger_kprobe_setup(void)
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index 3d5f30c29ae3..6564d1909c7b 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -39,26 +39,19 @@ int bench_trigger_uprobe_multi(void *ctx)
 	return 0;
 }
 
+const volatile int kernel_count = 0;
 const volatile int batch_iters = 0;
 
-SEC("?raw_tp")
-int trigger_count(void *ctx)
-{
-	int i;
-
-	for (i = 0; i < batch_iters; i++)
-		inc_counter();
-
-	return 0;
-}
-
 SEC("?raw_tp")
 int trigger_driver(void *ctx)
 {
 	int i;
 
-	for (i = 0; i < batch_iters; i++)
+	for (i = 0; i < batch_iters; i++) {
 		(void)bpf_get_numa_node_id(); /* attach point for benchmarking */
+		if (kernel_count)
+			inc_counter();
+	}
 
 	return 0;
 }
-- 
2.51.2


