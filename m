Return-Path: <bpf+bounces-71694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A77CBFACAE
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 10:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10693B9EB0
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 08:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66652DF155;
	Wed, 22 Oct 2025 08:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StaWj+dM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F541303A2E
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120396; cv=none; b=GD/qT4aJaVPdW2FeFpTSvCBT+k8OhR5EtJ9FZ3iIjuJaA9RZ0zhMqwuoD2GoxsMMlxhL/QmJbjSbzmw82N+7lmUJYm4QO3O4nLTslXhtDBfCtzA6yjZ20RY6IEoKhF1VjcXwGCGwUDOlIvHZ2d6+HHUa72gXrg9V/AR5BTy2H18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120396; c=relaxed/simple;
	bh=sNkqvWFZREdMBLQ3AIWEE/1KJDAUFoNwSeleCzyx3rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpXG6xSxPPNZcH+bL0bTdOh8Rl89VO2AyFoLymUO5NSsqhmnEgB04MvbqXpVApUIj09Pf8H17mwKdD83LzbJ+HLeGXGXk/aIEsUuTO+kQP0ta/NrWkjuWxOMLzEAE1diHVa2HZsNBvADWiIcSToYmsV7BjpLkLZr0IkH50KoskQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StaWj+dM; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-33d7589774fso4141995a91.0
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 01:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120394; x=1761725194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pj3PqdoyeYD41VexbkIcBOe8O/AiBTjuvETCCqlLiZw=;
        b=StaWj+dMNPuQIXort2DrGNecAmkAqYMLydl6wHVDJ6N1JRelnE0pcwWwNKSsCz5mSr
         2COawpS/QlkpXclRqMvROOY4yRw/WMOIj7UmkCncgM3aOknWYq8dhpsZkTtrJHS6GRDi
         bLak/cg5Kdyzxip6rMgbajU1ffcLv4NEiER/Jk4Y/DC4r9mRLdaZ5f6d0n79gahUl0+X
         hCA6tKT09AdeyhAB6K7fE7jO7N/7MWtXJw3H3Z704dN1fTjm15eeV107RFQ4D/7821Gt
         7LaiQ2y5DKGD5lCle8yX3fw2cvnuzUlMPlyzNENOnfn49r720cPGh4bL7xJcdDeIm0ff
         AMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120394; x=1761725194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pj3PqdoyeYD41VexbkIcBOe8O/AiBTjuvETCCqlLiZw=;
        b=SoT7nnu3/jB793cOqeUIWSbCdGtRWo1uMnF7qIfYeu43OmlOi264kD0/BevKbxnaTh
         7SBmJwqB43DQy+8DzTjOkP/skvQJ3ND20hULSmnG5GawomrVp0+xqMdhA6nk54oAGy9W
         xDD81lNdC/R1bVQp3GAmDXrpkKd83s8oyGNpZyMzIdxBtpVMtVVTOdjLVFzeXmVZm2mU
         8j262WEGurn6SFPKgeLIJW0Dn7vvzMXMPR+Cfp+R4N0N8rYRmbISVAr0dQV3lV8FZYzb
         1I4OJ9abutq2qWu17cHOWRSEvPf9/3LEiRHx1sS0MbDHbookih9hZWtDdV9ATrW2WOnI
         lg1g==
X-Forwarded-Encrypted: i=1; AJvYcCUlzb5FP35UfOVi4BMJfGduZH9Wge9ehcK2gswXEvgO9gR7PYtBTds4u63M2G4cLovcxhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQRcgFYJnqXaiPNNvi6hbfrcj6AIjsxcPHZ5t6vrMH3Rvz6JwA
	YF/6bF/hZX1BtfgEzhHrqgQm6fgzDcfMTFzdAUwStRJfMZaAzkqeL7uT
X-Gm-Gg: ASbGncs+R9lwdurAJKTPsVZkLsS9fF9OiNRW5TgDDrVjsw4riSGoU7UKx+2ejB4+1h0
	8Rj6uuhCrV9qIFvL3rgASP5MOrDirKACRiswJHMr8cdzABVSkvDsAgOQ4BQfXgCB0XJLDv1PZ7Q
	rz8IxxjocKuoMnan7kXbZGvdPaXd9GTgikFnjfZ1nPyx+sgX7HXLyDB4wT7PhJf4ndtJP0vu6+1
	z2PiLAOyzicJTs0+LwqXGL/YvZKhB+5gJgDlTU8actuQ53lUhAGbb4T8zY2ntyzRuRaZUua+hZj
	RPlYS3Ysal21CS/XznjSpS+LohNMkz0Z1j0njz7Vp+/8JJ9TXvuhgW7027xW/FDD5jN5Vo6h208
	gKc60xzRLXoUhxKXaotKeE26mHB+4khYd2yMbhE60wrDoE3C08uP8d5tbcRI4fcDWrdpavH6lGM
	v4HVxsNvXIjoogTbL/nQ==
X-Google-Smtp-Source: AGHT+IEx9dln9OcfazCD+KhBAdzPTNAjHcl9Ith5YJQLotbdTFdeHDdjLcTWNqCThfFIBzRVF0YLPA==
X-Received: by 2002:a17:90a:d44c:b0:336:9dcf:ed14 with SMTP id 98e67ed59e1d1-33bcf8e3b0emr27655601a91.23.1761120393655;
        Wed, 22 Oct 2025 01:06:33 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223c7fb5sm1805330a91.2.2025.10.22.01.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:06:33 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	jolsa@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	leon.hwang@linux.dev,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 10/10] selftests/bpf: add testcase for mixing fsession, fentry and fexit
Date: Wed, 22 Oct 2025 16:06:13 +0800
Message-ID: <20251022080613.555463-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251022080613.555463-1-dongml2@chinatelecom.cn>
References: <20251022080613.555463-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the fsession when it is used together with fentry, fexit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../selftests/bpf/prog_tests/fsession_test.c  | 32 +++++++++++++
 .../selftests/bpf/progs/fsession_mixed.c      | 45 +++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_mixed.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fsession_test.c b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
index 549b6fdd6167..5529e4236b7c 100644
--- a/tools/testing/selftests/bpf/prog_tests/fsession_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 #include "fsession_test.skel.h"
 #include "fsession_cookie.skel.h"
+#include "fsession_mixed.skel.h"
 
 static int check_result(struct fsession_test *skel)
 {
@@ -114,6 +115,35 @@ static void test_fsession_cookie(void)
 	fsession_cookie__destroy(skel);
 }
 
+static void test_fsession_mixed(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct fsession_mixed *skel = NULL;
+	int err, prog_fd;
+
+	skel = fsession_mixed__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fsession_mixed__open_and_load"))
+		goto cleanup;
+
+	err = fsession_mixed__attach(skel);
+	if (!ASSERT_OK(err, "fsession_mixed_attach"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.test1);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		goto cleanup;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		goto cleanup;
+
+	for (int i = 0; i < sizeof(*skel->bss) / sizeof(__u64); i++) {
+		if (!ASSERT_EQ(((__u64 *)skel->bss)[i], 1, "test_result"))
+			goto cleanup;
+	}
+cleanup:
+	fsession_mixed__destroy(skel);
+}
+
 void test_fsession_test(void)
 {
 #if !defined(__x86_64__)
@@ -126,4 +156,6 @@ void test_fsession_test(void)
 		test_fsession_reattach();
 	if (test__start_subtest("fsession_cookie"))
 		test_fsession_cookie();
+	if (test__start_subtest("fsession_mixed"))
+		test_fsession_mixed();
 }
diff --git a/tools/testing/selftests/bpf/progs/fsession_mixed.c b/tools/testing/selftests/bpf/progs/fsession_mixed.c
new file mode 100644
index 000000000000..226e8ca438d4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fsession_mixed.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test1_entry_result = 0;
+__u64 test1_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test5")
+int BPF_PROG(test1, __u64 a, void *b, short c, int d, __u64 e, int ret)
+{
+	__u64 *cookie = bpf_fsession_cookie(ctx);
+
+	if (!bpf_tracing_is_exit(ctx)) {
+		test1_entry_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+			e == 15 && ret == 0;
+		*cookie = 0x123456ULL;
+		return 0;
+	}
+
+	test1_exit_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+		e == 15 && ret == 65 && *cookie == 0x123456ULL;
+	return 0;
+}
+
+__u64 test2_result = 0;
+SEC("fexit/bpf_fentry_test5")
+int BPF_PROG(test2, __u64 a, void *b, short c, int d, __u64 e, int ret)
+{
+	test2_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+		e == 15 && ret == 65;
+	return 0;
+}
+
+__u64 test3_result = 0;
+SEC("fentry/bpf_fentry_test5")
+int BPF_PROG(test3, __u64 a, void *b, short c, int d, __u64 e)
+{
+	test3_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+		e == 15;
+	return 0;
+}
-- 
2.51.1.dirty


