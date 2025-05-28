Return-Path: <bpf+bounces-59113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B21DAC607F
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C251BC3E58
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C798221283;
	Wed, 28 May 2025 03:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QokRMHgd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79048221263;
	Wed, 28 May 2025 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404232; cv=none; b=UVs67ecSiaKzRuX96QhFgr0OKLUhveQAu6hTx2Ba9EAG0plkkrhPmT8jNOmkhFI7YwD28u6WLu7Q86fCnouFIKkFqnl3EkwZXfKbr/R0/tvseBLSEnnwSOn+RKxwFn5VnNHLJuxV/1P9Odm+DnNxRuSiXvj5PP+TIgNokm10vDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404232; c=relaxed/simple;
	bh=aPQ3vmm3j5g5SSBlHLCGoS0Iq/r9v/hjD1ssl3W2V6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IXUXm0YQdcwHQgytywHkqd38pnW88ENlz/v3vvctS7Yo7w8kVbb1u5HPn5oQsl29DA3m/OSi3OD86svpB6yKjXZE/oB+IHkGYhIr2ofYEz/UBDNO03krduAPtA9Qg3R/O51mwqJQF/6/736sfHh7jE3EhQMTM4juD/59i6/OiKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QokRMHgd; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b0db0b6a677so2849905a12.2;
        Tue, 27 May 2025 20:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404229; x=1749009029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quFKE0IyjJDzhZdIU0S08uOjSryGsB+MNJLbAiFEAVo=;
        b=QokRMHgdWVCZAxS8N21BWyIfmIH0ncRJT6wTfZFCAShsVKeEp98Ha9Oor1sxD/xVMu
         ZpY4sfddDnPGGahbiLyt0w1ZkDfa3ozAolD4Wm4FsFXdi++4FQYYx49sN4xEMOIBeTd8
         JmZzVlBJaSKjPiFuRKzp2Bv98wQN/hiDXmDJdNJXj0tEN/LsMJ0R7YJ5Q2vB/DUi3SNu
         hB6YYrwHmIO7p6Os3UdOaJSpEpc2pqCyWjk+KIlzD6nvOWtl2jMxoeAOuoY9KWrkyQfC
         0L5w4XlaaJ7y+6as4bOUcwk5qvIIiS4SVD2z3fWWMwJMH7pM2FTh2s0AY1zuHVuNbqtX
         2pPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404229; x=1749009029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quFKE0IyjJDzhZdIU0S08uOjSryGsB+MNJLbAiFEAVo=;
        b=u6YRK502TLxX6UB+2eLozPyAYarYjknZPcxcjQGAiS6YelyjWZcOJUsWvALSgth+WR
         Adm+GhCmySqH6ewL4DdIp92tYtH7PxfBL2V8Y7id1TUkKrOHmXR7GMON+Qa1WqEzxH2V
         PXbU439Nk+HLpANWcUBxa+Q3c/eQgF2mum2V8D3dH5QLQ8fFVc4+Y5D2tOQ+y8etgSr1
         WSjVn6lzoFifQCXNBXySOX0vYYs8NRS/CavcT/dwECceJuJJhWj9Xuw2XehVxPxPaQ76
         8pfNA9Q2XEZPrUHq7yAtml446YVK7eilmAwrL6uY/bCrbLF5zdS9bfD+wa3u1OAAokYY
         qfDg==
X-Forwarded-Encrypted: i=1; AJvYcCVsUz761DJ0nBHc/HU77s1DmATYm5LZENScLCdWXEuC3eM7noYHNt9vqf5mjswfEBzyUU9DktfEdyEHRBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3INbDHbl3K8QkI9ps+BxqWYonoXBof/3qeLGhXK9bGLXaW87Z
	AYlYjFyd8J6vGueP6Qzq8LLF2rylBaNwhCwNMDwKpIc9e9LhWI3UX0Du
X-Gm-Gg: ASbGnct7RMl1ntnPmBFgxl5ZxPJ0VYJr5+SK87x2NJlJMkN4oNi2Fha2rH5Q3bifAiG
	F+10qgAZqrlL3YUkWm+2iJ1K2qSAGzTBIau+TzkVC3K93E42HFKpv+KQIeWIuydcYbdhrgPhn2o
	uoPB1s+RI1C6ehmxwh9erEUhrq8AR41oqVJ4vjx4XmRY6IPOHEgUFHlsj9qNi5ToWCVzp+rm6g2
	RzmpmWrXzoArcEq4NC80Z6wMEY63uzOpKG2wR4VWGYDVjXlZ+T/Kkgp8kGvtBhzBK0bz6GI7qLP
	ouik4qTrBZwaSdXMeN8siqFd7YhmcO/ABnx8RfApc+4tZwC8wIH0dX00XI1YefUnwqHi
X-Google-Smtp-Source: AGHT+IFeCfedJJo38/XErRxppNs0m79/cOF9OhwnV++Lj8oL3ibJmss4a+Zgrfgqrq5+k2mxrLwefA==
X-Received: by 2002:a17:902:f68a:b0:234:d679:72dc with SMTP id d9443c01a7336-234d67975a8mr3481135ad.6.1748404228639;
        Tue, 27 May 2025 20:50:28 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:50:28 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 24/25] selftests/bpf: add testcases for multi-link of tracing
Date: Wed, 28 May 2025 11:47:11 +0800
Message-Id: <20250528034712.138701-25-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528034712.138701-1-dongml2@chinatelecom.cn>
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit, we add some testcases for the following attach types:

BPF_TRACE_FENTRY_MULTI
BPF_TRACE_FEXIT_MULTI
BPF_MODIFY_RETURN_MULTI

We reuse the testings in fentry_test.c, fexit_test.c and modify_return.c
by attach the tracing bpf prog as tracing_multi.

We add some functions to skip for tracing progs to bpf_get_ksyms() in this
commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../selftests/bpf/prog_tests/fentry_fexit.c   |  22 +-
 .../selftests/bpf/prog_tests/fentry_test.c    |  79 +++--
 .../selftests/bpf/prog_tests/fexit_test.c     |  79 +++--
 .../selftests/bpf/prog_tests/modify_return.c  |  60 ++++
 .../bpf/prog_tests/tracing_multi_link.c       | 276 ++++++++++++++++++
 .../selftests/bpf/progs/fentry_multi_empty.c  |  13 +
 .../bpf/progs/tracing_multi_override.c        |  28 ++
 .../selftests/bpf/progs/tracing_multi_test.c  | 181 ++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  24 ++
 tools/testing/selftests/bpf/test_progs.c      | 112 +++++++
 tools/testing/selftests/bpf/test_progs.h      |   3 +
 12 files changed, 831 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_multi_link.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_multi_empty.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_override.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_test.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index cf5ed3bee573..93cacb56591e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -496,7 +496,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
 		test_usdt.skel.h
 
-LSKELS := fentry_test.c fexit_test.c fexit_sleep.c atomics.c 		\
+LSKELS := fexit_sleep.c atomics.c 		\
 	trace_printk.c trace_vprintk.c map_ptr_kern.c 			\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
 	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c
diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c b/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
index 130f5b82d2e6..84cc8b669684 100644
--- a/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
+++ b/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
@@ -1,32 +1,32 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 Facebook */
 #include <test_progs.h>
-#include "fentry_test.lskel.h"
-#include "fexit_test.lskel.h"
+#include "fentry_test.skel.h"
+#include "fexit_test.skel.h"
 
 void test_fentry_fexit(void)
 {
-	struct fentry_test_lskel *fentry_skel = NULL;
-	struct fexit_test_lskel *fexit_skel = NULL;
+	struct fentry_test *fentry_skel = NULL;
+	struct fexit_test *fexit_skel = NULL;
 	__u64 *fentry_res, *fexit_res;
 	int err, prog_fd, i;
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
 
-	fentry_skel = fentry_test_lskel__open_and_load();
+	fentry_skel = fentry_test__open_and_load();
 	if (!ASSERT_OK_PTR(fentry_skel, "fentry_skel_load"))
 		goto close_prog;
-	fexit_skel = fexit_test_lskel__open_and_load();
+	fexit_skel = fexit_test__open_and_load();
 	if (!ASSERT_OK_PTR(fexit_skel, "fexit_skel_load"))
 		goto close_prog;
 
-	err = fentry_test_lskel__attach(fentry_skel);
+	err = fentry_test__attach(fentry_skel);
 	if (!ASSERT_OK(err, "fentry_attach"))
 		goto close_prog;
-	err = fexit_test_lskel__attach(fexit_skel);
+	err = fexit_test__attach(fexit_skel);
 	if (!ASSERT_OK(err, "fexit_attach"))
 		goto close_prog;
 
-	prog_fd = fexit_skel->progs.test1.prog_fd;
+	prog_fd = bpf_program__fd(fexit_skel->progs.test1);
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "ipv6 test_run");
 	ASSERT_OK(topts.retval, "ipv6 test retval");
@@ -40,6 +40,6 @@ void test_fentry_fexit(void)
 	}
 
 close_prog:
-	fentry_test_lskel__destroy(fentry_skel);
-	fexit_test_lskel__destroy(fexit_skel);
+	fentry_test__destroy(fentry_skel);
+	fexit_test__destroy(fexit_skel);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_test.c b/tools/testing/selftests/bpf/prog_tests/fentry_test.c
index aee1bc77a17f..9edd383feabd 100644
--- a/tools/testing/selftests/bpf/prog_tests/fentry_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fentry_test.c
@@ -1,26 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 Facebook */
 #include <test_progs.h>
-#include "fentry_test.lskel.h"
+#include "fentry_test.skel.h"
 #include "fentry_many_args.skel.h"
 
-static int fentry_test_common(struct fentry_test_lskel *fentry_skel)
+static int fentry_test_check(struct fentry_test *fentry_skel)
 {
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
 	int err, prog_fd, i;
-	int link_fd;
 	__u64 *result;
-	LIBBPF_OPTS(bpf_test_run_opts, topts);
-
-	err = fentry_test_lskel__attach(fentry_skel);
-	if (!ASSERT_OK(err, "fentry_attach"))
-		return err;
 
-	/* Check that already linked program can't be attached again. */
-	link_fd = fentry_test_lskel__test1__attach(fentry_skel);
-	if (!ASSERT_LT(link_fd, 0, "fentry_attach_link"))
-		return -1;
-
-	prog_fd = fentry_skel->progs.test1.prog_fd;
+	prog_fd = bpf_program__fd(fentry_skel->progs.test1);
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "test_run");
 	ASSERT_EQ(topts.retval, 0, "test_run");
@@ -31,7 +21,28 @@ static int fentry_test_common(struct fentry_test_lskel *fentry_skel)
 			return -1;
 	}
 
-	fentry_test_lskel__detach(fentry_skel);
+	return 0;
+}
+
+static int fentry_test_common(struct fentry_test *fentry_skel)
+{
+	struct bpf_link *link;
+	int err;
+
+	err = fentry_test__attach(fentry_skel);
+	if (!ASSERT_OK(err, "fentry_attach"))
+		return err;
+
+	/* Check that already linked program can't be attached again. */
+	link = bpf_program__attach(fentry_skel->progs.test1);
+	if (!ASSERT_ERR_PTR(link, "fentry_attach_link"))
+		return -1;
+
+	err = fentry_test_check(fentry_skel);
+	if (!ASSERT_OK(err, "fentry_test_check"))
+		return err;
+
+	fentry_test__detach(fentry_skel);
 
 	/* zero results for re-attach test */
 	memset(fentry_skel->bss, 0, sizeof(*fentry_skel->bss));
@@ -40,10 +51,10 @@ static int fentry_test_common(struct fentry_test_lskel *fentry_skel)
 
 static void fentry_test(void)
 {
-	struct fentry_test_lskel *fentry_skel = NULL;
+	struct fentry_test *fentry_skel = NULL;
 	int err;
 
-	fentry_skel = fentry_test_lskel__open_and_load();
+	fentry_skel = fentry_test__open_and_load();
 	if (!ASSERT_OK_PTR(fentry_skel, "fentry_skel_load"))
 		goto cleanup;
 
@@ -55,7 +66,7 @@ static void fentry_test(void)
 	ASSERT_OK(err, "fentry_second_attach");
 
 cleanup:
-	fentry_test_lskel__destroy(fentry_skel);
+	fentry_test__destroy(fentry_skel);
 }
 
 static void fentry_many_args(void)
@@ -84,10 +95,42 @@ static void fentry_many_args(void)
 	fentry_many_args__destroy(fentry_skel);
 }
 
+static void fentry_multi_test(void)
+{
+	struct fentry_test *fentry_skel = NULL;
+	int err, prog_cnt;
+
+	fentry_skel = fentry_test__open();
+	if (!ASSERT_OK_PTR(fentry_skel, "fentry_skel_open"))
+		goto cleanup;
+
+	prog_cnt = sizeof(fentry_skel->progs) / sizeof(long);
+	err = bpf_to_tracing_multi((void *)&fentry_skel->progs, prog_cnt);
+	if (!ASSERT_OK(err, "fentry_to_multi"))
+		goto cleanup;
+
+	err = fentry_test__load(fentry_skel);
+	if (!ASSERT_OK(err, "fentry_skel_load"))
+		goto cleanup;
+
+	err = bpf_attach_as_tracing_multi((void *)&fentry_skel->progs,
+					  prog_cnt,
+					  (void *)&fentry_skel->links);
+	if (!ASSERT_OK(err, "fentry_attach_multi"))
+		goto cleanup;
+
+	err = fentry_test_check(fentry_skel);
+	ASSERT_OK(err, "fentry_first_attach");
+cleanup:
+	fentry_test__destroy(fentry_skel);
+}
+
 void test_fentry_test(void)
 {
 	if (test__start_subtest("fentry"))
 		fentry_test();
+	if (test__start_subtest("fentry_multi"))
+		fentry_multi_test();
 	if (test__start_subtest("fentry_many_args"))
 		fentry_many_args();
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_test.c b/tools/testing/selftests/bpf/prog_tests/fexit_test.c
index 1c13007e37dd..5652d02b3ad9 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_test.c
@@ -1,26 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 Facebook */
 #include <test_progs.h>
-#include "fexit_test.lskel.h"
+#include "fexit_test.skel.h"
 #include "fexit_many_args.skel.h"
 
-static int fexit_test_common(struct fexit_test_lskel *fexit_skel)
+static int fexit_test_check(struct fexit_test *fexit_skel)
 {
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
 	int err, prog_fd, i;
-	int link_fd;
 	__u64 *result;
-	LIBBPF_OPTS(bpf_test_run_opts, topts);
-
-	err = fexit_test_lskel__attach(fexit_skel);
-	if (!ASSERT_OK(err, "fexit_attach"))
-		return err;
 
-	/* Check that already linked program can't be attached again. */
-	link_fd = fexit_test_lskel__test1__attach(fexit_skel);
-	if (!ASSERT_LT(link_fd, 0, "fexit_attach_link"))
-		return -1;
-
-	prog_fd = fexit_skel->progs.test1.prog_fd;
+	prog_fd = bpf_program__fd(fexit_skel->progs.test1);
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "test_run");
 	ASSERT_EQ(topts.retval, 0, "test_run");
@@ -31,7 +21,28 @@ static int fexit_test_common(struct fexit_test_lskel *fexit_skel)
 			return -1;
 	}
 
-	fexit_test_lskel__detach(fexit_skel);
+	return 0;
+}
+
+static int fexit_test_common(struct fexit_test *fexit_skel)
+{
+	struct bpf_link *link;
+	int err;
+
+	err = fexit_test__attach(fexit_skel);
+	if (!ASSERT_OK(err, "fexit_attach"))
+		return err;
+
+	/* Check that already linked program can't be attached again. */
+	link = bpf_program__attach(fexit_skel->progs.test1);
+	if (!ASSERT_ERR_PTR(link, "fexit_attach_link"))
+		return -1;
+
+	err = fexit_test_check(fexit_skel);
+	if (!ASSERT_OK(err, "fexit_test_check"))
+		return err;
+
+	fexit_test__detach(fexit_skel);
 
 	/* zero results for re-attach test */
 	memset(fexit_skel->bss, 0, sizeof(*fexit_skel->bss));
@@ -40,10 +51,10 @@ static int fexit_test_common(struct fexit_test_lskel *fexit_skel)
 
 static void fexit_test(void)
 {
-	struct fexit_test_lskel *fexit_skel = NULL;
+	struct fexit_test *fexit_skel = NULL;
 	int err;
 
-	fexit_skel = fexit_test_lskel__open_and_load();
+	fexit_skel = fexit_test__open_and_load();
 	if (!ASSERT_OK_PTR(fexit_skel, "fexit_skel_load"))
 		goto cleanup;
 
@@ -55,7 +66,7 @@ static void fexit_test(void)
 	ASSERT_OK(err, "fexit_second_attach");
 
 cleanup:
-	fexit_test_lskel__destroy(fexit_skel);
+	fexit_test__destroy(fexit_skel);
 }
 
 static void fexit_many_args(void)
@@ -84,10 +95,42 @@ static void fexit_many_args(void)
 	fexit_many_args__destroy(fexit_skel);
 }
 
+static void fexit_test_multi(void)
+{
+	struct fexit_test *fexit_skel = NULL;
+	int err, prog_cnt;
+
+	fexit_skel = fexit_test__open();
+	if (!ASSERT_OK_PTR(fexit_skel, "fexit_skel_open"))
+		goto cleanup;
+
+	prog_cnt = sizeof(fexit_skel->progs) / sizeof(long);
+	err = bpf_to_tracing_multi((void *)&fexit_skel->progs, prog_cnt);
+	if (!ASSERT_OK(err, "fexit_to_multi"))
+		goto cleanup;
+
+	err = fexit_test__load(fexit_skel);
+	if (!ASSERT_OK(err, "fexit_skel_load"))
+		goto cleanup;
+
+	err = bpf_attach_as_tracing_multi((void *)&fexit_skel->progs,
+					  prog_cnt,
+					  (void *)&fexit_skel->links);
+	if (!ASSERT_OK(err, "fexit_attach_multi"))
+		goto cleanup;
+
+	err = fexit_test_check(fexit_skel);
+	ASSERT_OK(err, "fexit_first_attach");
+cleanup:
+	fexit_test__destroy(fexit_skel);
+}
+
 void test_fexit_test(void)
 {
 	if (test__start_subtest("fexit"))
 		fexit_test();
+	if (test__start_subtest("fexit_multi"))
+		fexit_test_multi();
 	if (test__start_subtest("fexit_many_args"))
 		fexit_many_args();
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/modify_return.c b/tools/testing/selftests/bpf/prog_tests/modify_return.c
index a70c99c2f8c8..3ca454379e90 100644
--- a/tools/testing/selftests/bpf/prog_tests/modify_return.c
+++ b/tools/testing/selftests/bpf/prog_tests/modify_return.c
@@ -49,6 +49,56 @@ static void run_test(__u32 input_retval, __u16 want_side_effect, __s16 want_ret)
 	modify_return__destroy(skel);
 }
 
+static void run_multi_test(__u32 input_retval, __u16 want_side_effect, __s16 want_ret)
+{
+	struct modify_return *skel = NULL;
+	int err, prog_fd, prog_cnt;
+	__u16 side_effect;
+	__s16 ret;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = modify_return__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	/* stack function args is not supported by tracing multi-link yet,
+	 * so we only enable the bpf progs without stack function args.
+	 */
+	bpf_program__set_expected_attach_type(skel->progs.fentry_test,
+					      BPF_TRACE_FENTRY_MULTI);
+	bpf_program__set_expected_attach_type(skel->progs.fexit_test,
+					      BPF_TRACE_FEXIT_MULTI);
+	bpf_program__set_expected_attach_type(skel->progs.fmod_ret_test,
+					      BPF_MODIFY_RETURN_MULTI);
+
+	err = modify_return__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	prog_cnt = sizeof(skel->progs) / sizeof(long);
+	err = bpf_attach_as_tracing_multi((void *)&skel->progs,
+					  prog_cnt,
+					  (void *)&skel->links);
+	if (!ASSERT_OK(err, "modify_return__attach failed"))
+		goto cleanup;
+
+	skel->bss->input_retval = input_retval;
+	prog_fd = bpf_program__fd(skel->progs.fmod_ret_test);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+
+	side_effect = UPPER(topts.retval);
+	ret = LOWER(topts.retval);
+
+	ASSERT_EQ(ret, want_ret, "test_run ret");
+	ASSERT_EQ(side_effect, want_side_effect, "modify_return side_effect");
+	ASSERT_EQ(skel->bss->fentry_result, 1, "modify_return fentry_result");
+	ASSERT_EQ(skel->bss->fexit_result, 1, "modify_return fexit_result");
+	ASSERT_EQ(skel->bss->fmod_ret_result, 1, "modify_return fmod_ret_result");
+cleanup:
+	modify_return__destroy(skel);
+}
+
 /* TODO: conflict with get_func_ip_test */
 void serial_test_modify_return(void)
 {
@@ -59,3 +109,13 @@ void serial_test_modify_return(void)
 		 0 /* want_side_effect */,
 		 -EINVAL * 2 /* want_ret */);
 }
+
+void serial_test_modify_return_multi(void)
+{
+	run_multi_test(0 /* input_retval */,
+		       2 /* want_side_effect */,
+		       33 /* want_ret */);
+	run_multi_test(-EINVAL /* input_retval */,
+		       1 /* want_side_effect */,
+		       -EINVAL + 29 /* want_ret */);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi_link.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi_link.c
new file mode 100644
index 000000000000..f730e26be911
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi_link.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+
+#include <test_progs.h>
+#include "bpf/libbpf_internal.h"
+
+#include "tracing_multi_test.skel.h"
+#include "tracing_multi_override.skel.h"
+#include "fentry_multi_empty.skel.h"
+
+static void test_run(struct tracing_multi_test *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	skel->bss->pid = getpid();
+	prog_fd = bpf_program__fd(skel->progs.fentry_cookie_test1);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	ASSERT_EQ(skel->bss->fentry_test1_result, 1, "fentry_test1_result");
+	ASSERT_EQ(skel->bss->fentry_test2_result, 1, "fentry_test2_result");
+	ASSERT_EQ(skel->bss->fentry_test3_result, 1, "fentry_test3_result");
+	ASSERT_EQ(skel->bss->fentry_test4_result, 1, "fentry_test4_result");
+	ASSERT_EQ(skel->bss->fentry_test5_result, 1, "fentry_test5_result");
+	ASSERT_EQ(skel->bss->fentry_test6_result, 1, "fentry_test6_result");
+	ASSERT_EQ(skel->bss->fentry_test7_result, 1, "fentry_test7_result");
+	ASSERT_EQ(skel->bss->fentry_test8_result, 1, "fentry_test8_result");
+}
+
+static void test_skel_auto_api(void)
+{
+	struct tracing_multi_test *skel;
+	int err;
+
+	skel = tracing_multi_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_test__open_and_load"))
+		return;
+
+	/* disable all programs that should fail */
+	bpf_program__set_autoattach(skel->progs.fentry_fail_test1, false);
+	bpf_program__set_autoattach(skel->progs.fentry_fail_test2, false);
+	bpf_program__set_autoattach(skel->progs.fentry_fail_test3, false);
+	bpf_program__set_autoattach(skel->progs.fentry_fail_test4, false);
+	bpf_program__set_autoattach(skel->progs.fentry_fail_test5, false);
+	bpf_program__set_autoattach(skel->progs.fentry_fail_test6, false);
+
+	bpf_program__set_autoattach(skel->progs.fexit_fail_test1, false);
+	bpf_program__set_autoattach(skel->progs.fexit_fail_test2, false);
+	bpf_program__set_autoattach(skel->progs.fexit_fail_test3, false);
+
+	err = tracing_multi_test__attach(skel);
+	if (!ASSERT_OK(err, "tracing_multi_test__attach"))
+		goto cleanup;
+
+	test_run(skel);
+
+cleanup:
+	tracing_multi_test__destroy(skel);
+}
+
+static void test_skel_manual_api(void)
+{
+	struct tracing_multi_test *skel;
+	struct bpf_link *link;
+	int err;
+
+	skel = tracing_multi_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_test__open_and_load"))
+		return;
+
+#define ATTACH_PROG(name, success)					\
+do {									\
+	link = bpf_program__attach(skel->progs.name);			\
+	err = libbpf_get_error(link);					\
+	if (!ASSERT_OK(success ? err : !err,				\
+		       "bpf_program__attach: " #name))			\
+		goto cleanup;						\
+	skel->links.name = err ? NULL : link;				\
+} while (0)
+
+	ATTACH_PROG(fentry_success_test1, true);
+	ATTACH_PROG(fentry_success_test2, true);
+	ATTACH_PROG(fentry_success_test3, true);
+	ATTACH_PROG(fentry_success_test4, true);
+
+	ATTACH_PROG(fexit_success_test1, true);
+	ATTACH_PROG(fexit_success_test2, true);
+
+	ATTACH_PROG(fentry_fail_test1, false);
+	ATTACH_PROG(fentry_fail_test2, false);
+	ATTACH_PROG(fentry_fail_test3, false);
+	ATTACH_PROG(fentry_fail_test4, false);
+	ATTACH_PROG(fentry_fail_test5, false);
+	ATTACH_PROG(fentry_fail_test6, false);
+
+	ATTACH_PROG(fexit_fail_test1, false);
+	ATTACH_PROG(fexit_fail_test2, false);
+	ATTACH_PROG(fexit_fail_test3, false);
+
+	ATTACH_PROG(fentry_cookie_test1, true);
+
+	test_run(skel);
+
+cleanup:
+	tracing_multi_test__destroy(skel);
+}
+
+static void test_attach_api(void)
+{
+	LIBBPF_OPTS(bpf_trace_multi_opts, opts);
+	struct tracing_multi_test *skel;
+	struct bpf_link *link;
+	const char *syms[8] = {
+		"bpf_fentry_test1",
+		"bpf_fentry_test2",
+		"bpf_fentry_test3",
+		"bpf_fentry_test4",
+		"bpf_fentry_test5",
+		"bpf_fentry_test6",
+		"bpf_fentry_test7",
+		"bpf_fentry_test8",
+	};
+	__u64 cookies[] = {1, 7, 2, 3, 4, 5, 6, 8};
+
+	skel = tracing_multi_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_test__open_and_load"))
+		return;
+
+	opts.syms = syms;
+	opts.cookies = cookies;
+	opts.cnt = ARRAY_SIZE(syms);
+	link = bpf_program__attach_trace_multi_opts(skel->progs.fentry_cookie_test1,
+						    &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_trace_multi_opts"))
+		goto cleanup;
+	skel->links.fentry_cookie_test1 = link;
+
+	skel->bss->test_cookie = true;
+	test_run(skel);
+cleanup:
+	tracing_multi_test__destroy(skel);
+}
+
+static void test_attach_bench(bool kernel)
+{
+	LIBBPF_OPTS(bpf_trace_multi_opts, opts);
+	struct fentry_multi_empty *skel;
+	long attach_start_ns, attach_end_ns;
+	long detach_start_ns, detach_end_ns;
+	double attach_delta, detach_delta;
+	struct bpf_link *link = NULL;
+	char **syms = NULL;
+	size_t cnt = 0;
+
+	if (!ASSERT_OK(bpf_get_ksyms(&syms, &cnt, kernel), "get_syms"))
+		return;
+
+	skel = fentry_multi_empty__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_multi_empty__open_and_load"))
+		goto cleanup;
+
+	opts.syms = (const char **) syms;
+	opts.cnt = cnt;
+	opts.skip_invalid = true;
+
+	attach_start_ns = get_time_ns();
+	link = bpf_program__attach_trace_multi_opts(skel->progs.fentry_multi_empty,
+						    &opts);
+	attach_end_ns = get_time_ns();
+
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_trace_multi_opts"))
+		return;
+
+	detach_start_ns = get_time_ns();
+	bpf_link__destroy(link);
+	detach_end_ns = get_time_ns();
+
+	attach_delta = (attach_end_ns - attach_start_ns) / 1000000000.0;
+	detach_delta = (detach_end_ns - detach_start_ns) / 1000000000.0;
+
+	printf("%s: found %lu functions\n", __func__, opts.cnt);
+	printf("%s: attached in %7.3lfs\n", __func__, attach_delta);
+	printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
+
+cleanup:
+	fentry_multi_empty__destroy(skel);
+	if (syms)
+		free(syms);
+}
+
+static void test_attach_override(bool fentry_over_multi)
+{
+	struct tracing_multi_override *skel;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct bpf_link *link;
+	int err, prog_fd;
+
+	skel = tracing_multi_override__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_test__open_and_load"))
+		goto cleanup;
+
+	if (fentry_over_multi) {
+		ATTACH_PROG(fentry_multi_override_test1, true);
+		ATTACH_PROG(fentry_override_test1, true);
+	} else {
+		ATTACH_PROG(fentry_override_test1, true);
+		ATTACH_PROG(fentry_multi_override_test1, true);
+	}
+
+	prog_fd = bpf_program__fd(skel->progs.fentry_multi_override_test1);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	ASSERT_EQ(skel->data->fentry_override_test1_result, 3,
+		  "fentry_override_test1_result");
+cleanup:
+	tracing_multi_override__destroy(skel);
+}
+
+static void test_attach_multi(void)
+{
+	struct tracing_multi_override *skel;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct bpf_link *link;
+	int err, prog_fd;
+
+	skel = tracing_multi_override__open();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_test__open"))
+		goto cleanup;
+
+	/* don't load fentry_override_test1, it will create a trampoline */
+	bpf_program__set_autoload(skel->progs.fentry_override_test1, false);
+	err = tracing_multi_override__load(skel);
+	if (!ASSERT_OK(err, "tracing_multi_test__load"))
+		goto cleanup;
+
+	ATTACH_PROG(fentry_multi_override_test1, true);
+	ATTACH_PROG(fentry_multi_override_test2, true);
+
+	prog_fd = bpf_program__fd(skel->progs.fentry_multi_override_test1);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	ASSERT_EQ(skel->data->fentry_override_test1_result, 4,
+		  "fentry_override_test1_result");
+cleanup:
+	tracing_multi_override__destroy(skel);
+}
+
+void serial_test_tracing_multi_attach_bench(void)
+{
+	if (test__start_subtest("kernel"))
+		test_attach_bench(true);
+	if (test__start_subtest("modules"))
+		test_attach_bench(false);
+}
+
+void test_tracing_multi_attach_test(void)
+{
+	if (test__start_subtest("skel_auto_api"))
+		test_skel_auto_api();
+	if (test__start_subtest("skel_manual_api"))
+		test_skel_manual_api();
+	if (test__start_subtest("attach_api"))
+		test_attach_api();
+	if (test__start_subtest("attach_over_multi"))
+		test_attach_override(true);
+	if (test__start_subtest("attach_over_fentry"))
+		test_attach_override(false);
+	if (test__start_subtest("attach_multi"))
+		test_attach_multi();
+}
diff --git a/tools/testing/selftests/bpf/progs/fentry_multi_empty.c b/tools/testing/selftests/bpf/progs/fentry_multi_empty.c
new file mode 100644
index 000000000000..a09ba216dff8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fentry_multi_empty.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("fentry.multi/bpf_fentry_test1")
+int BPF_PROG(fentry_multi_empty)
+{
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_override.c b/tools/testing/selftests/bpf/progs/tracing_multi_override.c
new file mode 100644
index 000000000000..8001be433914
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_override.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+__u64 fentry_override_test1_result = 1;
+
+SEC("fentry.multi/bpf_fentry_test1")
+int BPF_PROG(fentry_multi_override_test1)
+{
+	fentry_override_test1_result++;
+	return 0;
+}
+
+SEC("fentry.multi/bpf_fentry_test1")
+int BPF_PROG(fentry_multi_override_test2)
+{
+	fentry_override_test1_result <<= 1;
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(fentry_override_test1)
+{
+	fentry_override_test1_result++;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_test.c b/tools/testing/selftests/bpf/progs/tracing_multi_test.c
new file mode 100644
index 000000000000..fa27851896b9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_test.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct bpf_testmod_struct_arg_1 {
+	int a;
+};
+struct bpf_testmod_struct_arg_2 {
+	long a;
+	long b;
+};
+
+__u64 test_result = 0;
+
+int pid = 0;
+int test_cookie = 0;
+
+__u64 fentry_test1_result = 0;
+__u64 fentry_test2_result = 0;
+__u64 fentry_test3_result = 0;
+__u64 fentry_test4_result = 0;
+__u64 fentry_test5_result = 0;
+__u64 fentry_test6_result = 0;
+__u64 fentry_test7_result = 0;
+__u64 fentry_test8_result = 0;
+
+extern const void bpf_fentry_test1 __ksym;
+extern const void bpf_fentry_test2 __ksym;
+extern const void bpf_fentry_test3 __ksym;
+extern const void bpf_fentry_test4 __ksym;
+extern const void bpf_fentry_test5 __ksym;
+extern const void bpf_fentry_test6 __ksym;
+extern const void bpf_fentry_test7 __ksym;
+extern const void bpf_fentry_test8 __ksym;
+
+SEC("fentry.multi/bpf_testmod_test_struct_arg_1,bpf_testmod_test_struct_arg_13")
+int BPF_PROG2(fentry_success_test1, struct bpf_testmod_struct_arg_2, a)
+{
+	test_result = a.a + a.b;
+	return 0;
+}
+
+SEC("fentry.multi/bpf_testmod_test_struct_arg_2,bpf_testmod_test_struct_arg_10")
+int BPF_PROG2(fentry_success_test2, int, a, struct bpf_testmod_struct_arg_2, b)
+{
+	test_result = a + b.a + b.b;
+	return 0;
+}
+
+SEC("fentry.multi/bpf_testmod_test_struct_arg_1,bpf_testmod_test_struct_arg_4")
+int BPF_PROG2(fentry_success_test3, struct bpf_testmod_struct_arg_2, a, int, b,
+	      int, c)
+{
+	test_result = c;
+	return 0;
+}
+
+SEC("fentry.multi/bpf_testmod_test_struct_arg_1,bpf_testmod_test_struct_arg_2")
+int BPF_PROG2(fentry_success_test4, struct bpf_testmod_struct_arg_2, a, int, b,
+	      int, c)
+{
+	test_result = c;
+	return 0;
+}
+
+SEC("fentry.multi/bpf_testmod_test_struct_arg_1,bpf_testmod_test_struct_arg_1")
+int BPF_PROG2(fentry_fail_test1, struct bpf_testmod_struct_arg_2, a)
+{
+	test_result = a.a + a.b;
+	return 0;
+}
+
+SEC("fentry.multi/bpf_testmod_test_struct_arg_1,bpf_testmod_test_struct_arg_2")
+int BPF_PROG2(fentry_fail_test2, struct bpf_testmod_struct_arg_2, a)
+{
+	test_result = a.a + a.b;
+	return 0;
+}
+
+SEC("fentry.multi/bpf_testmod_test_struct_arg_1,bpf_testmod_test_struct_arg_4")
+int BPF_PROG2(fentry_fail_test3, struct bpf_testmod_struct_arg_2, a)
+{
+	test_result = a.a + a.b;
+	return 0;
+}
+
+SEC("fentry.multi/bpf_testmod_test_struct_arg_2,bpf_testmod_test_struct_arg_2")
+int BPF_PROG2(fentry_fail_test4, int, a, struct bpf_testmod_struct_arg_2, b)
+{
+	test_result = a + b.a + b.b;
+	return 0;
+}
+
+SEC("fentry.multi/bpf_testmod_test_struct_arg_2,bpf_testmod_test_struct_arg_13")
+int BPF_PROG2(fentry_fail_test5, int, a, struct bpf_testmod_struct_arg_2, b)
+{
+	test_result = a + b.a + b.b;
+	return 0;
+}
+
+SEC("fentry.multi/bpf_testmod_test_struct_arg_1,bpf_testmod_test_struct_arg_12")
+int BPF_PROG2(fentry_fail_test6, struct bpf_testmod_struct_arg_2, a, int, b,
+	      int, c)
+{
+	test_result = c;
+	return 0;
+}
+
+SEC("fexit.multi/bpf_testmod_test_struct_arg_1,bpf_testmod_test_struct_arg_2,bpf_testmod_test_struct_arg_3")
+int BPF_PROG2(fexit_success_test1, struct bpf_testmod_struct_arg_2, a, int, b,
+	      int, c, int, retval)
+{
+	test_result = retval;
+	return 0;
+}
+
+SEC("fexit.multi/bpf_testmod_test_struct_arg_2,bpf_testmod_test_struct_arg_12")
+int BPF_PROG2(fexit_success_test2, int, a, struct bpf_testmod_struct_arg_2, b,
+	      int, c, int, retval)
+{
+	test_result = a + b.a + b.b + retval;
+	return 0;
+}
+
+SEC("fexit.multi/bpf_testmod_test_struct_arg_1,bpf_testmod_test_struct_arg_4")
+int BPF_PROG2(fexit_fail_test1, struct bpf_testmod_struct_arg_2, a, int, b,
+	      int, c, int, retval)
+{
+	test_result = retval;
+	return 0;
+}
+
+SEC("fexit.multi/bpf_testmod_test_struct_arg_2,bpf_testmod_test_struct_arg_10")
+int BPF_PROG2(fexit_fail_test2, int, a, struct bpf_testmod_struct_arg_2, b,
+	      int, c, int, retval)
+{
+	test_result = a + b.a + b.b + retval;
+	return 0;
+}
+
+SEC("fexit.multi/bpf_testmod_test_struct_arg_2,bpf_testmod_test_struct_arg_11")
+int BPF_PROG2(fexit_fail_test3, int, a, struct bpf_testmod_struct_arg_2, b,
+	      int, c, int, retval)
+{
+	test_result = a + b.a + b.b + retval;
+	return 0;
+}
+
+static void tracing_multi_check_cookie(unsigned long long *ctx)
+{
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return;
+
+	__u64 cookie = test_cookie ? bpf_get_attach_cookie(ctx) : 0;
+	__u64 addr = bpf_get_func_ip(ctx);
+
+#define SET(__var, __addr, __cookie) ({			\
+	if (((const void *) addr == __addr) &&		\
+	     (!test_cookie || (cookie == __cookie)))	\
+		__var = 1;				\
+})
+	SET(fentry_test1_result, &bpf_fentry_test1, 1);
+	SET(fentry_test2_result, &bpf_fentry_test2, 7);
+	SET(fentry_test3_result, &bpf_fentry_test3, 2);
+	SET(fentry_test4_result, &bpf_fentry_test4, 3);
+	SET(fentry_test5_result, &bpf_fentry_test5, 4);
+	SET(fentry_test6_result, &bpf_fentry_test6, 5);
+	SET(fentry_test7_result, &bpf_fentry_test7, 6);
+	SET(fentry_test8_result, &bpf_fentry_test8, 8);
+}
+
+SEC("fentry.multi/bpf_fentry_test1,bpf_fentry_test2,bpf_fentry_test3,bpf_fentry_test4,bpf_fentry_test5,bpf_fentry_test6,bpf_fentry_test7,bpf_fentry_test8")
+int BPF_PROG(fentry_cookie_test1)
+{
+	tracing_multi_check_cookie(ctx);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 2e54b95ad898..ebc4d5204136 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -128,6 +128,30 @@ bpf_testmod_test_struct_arg_9(u64 a, void *b, short c, int d, void *e, char f,
 	return bpf_testmod_test_struct_arg_result;
 }
 
+noinline int
+bpf_testmod_test_struct_arg_10(int a, struct bpf_testmod_struct_arg_2 b) {
+	bpf_testmod_test_struct_arg_result = a + b.a + b.b;
+	return bpf_testmod_test_struct_arg_result;
+}
+
+noinline struct bpf_testmod_struct_arg_2 *
+bpf_testmod_test_struct_arg_11(int a, struct bpf_testmod_struct_arg_2 b, int c) {
+	bpf_testmod_test_struct_arg_result = a + b.a + b.b + c;
+	return (void *)bpf_testmod_test_struct_arg_result;
+}
+
+noinline int
+bpf_testmod_test_struct_arg_12(int a, struct bpf_testmod_struct_arg_2 b, int *c) {
+	bpf_testmod_test_struct_arg_result = a + b.a + b.b + *c;
+	return bpf_testmod_test_struct_arg_result;
+}
+
+noinline int
+bpf_testmod_test_struct_arg_13(struct bpf_testmod_struct_arg_2 b) {
+	bpf_testmod_test_struct_arg_result = b.a + b.b;
+	return bpf_testmod_test_struct_arg_result;
+}
+
 noinline int
 bpf_testmod_test_arg_ptr_to_struct(struct bpf_testmod_struct_arg_1 *a) {
 	bpf_testmod_test_struct_arg_result = a->a;
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 26cc50bbed8b..286a30c1c7ae 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -685,6 +685,68 @@ static bool skip_entry(char *name)
 	if (!strncmp(name, "__ftrace_invalid_address__",
 		     sizeof("__ftrace_invalid_address__") - 1))
 		return true;
+
+	/* skip functions in "btf_id_deny" */
+	if (!strcmp(name, "migrate_disable"))
+		return true;
+	if (!strcmp(name, "migrate_enable"))
+		return true;
+	if (!strcmp(name, "rcu_read_unlock_strict"))
+		return true;
+	if (!strcmp(name, "preempt_count_add"))
+		return true;
+	if (!strcmp(name, "preempt_count_sub"))
+		return true;
+	if (!strcmp(name, "__rcu_read_lock"))
+		return true;
+	if (!strcmp(name, "__rcu_read_unlock"))
+		return true;
+
+	/* Following symbols have multi definition in kallsyms, take
+	 * "t_next" for example:
+	 *
+	 *     ffffffff813c10d0 t t_next
+	 *     ffffffff813d31b0 t t_next
+	 *     ffffffff813e06b0 t t_next
+	 *     ffffffff813eb360 t t_next
+	 *     ffffffff81613360 t t_next
+	 *
+	 * but only one of them have corresponding mrecord:
+	 *     ffffffff81613364 t_next
+	 *
+	 * The kernel search the target function address by the symbol
+	 * name "t_next" with kallsyms_lookup_name() during attaching
+	 * and the function "0xffffffff813c10d0" can be matched, which
+	 * doesn't have a corresponding mrecord. And this will make
+	 * the attach failing. Skip the functions like this.
+	 *
+	 * The list maybe not whole, so we still can fail......
+	 */
+	if (!strcmp(name, "kill_pid_usb_asyncio"))
+		return true;
+	if (!strcmp(name, "t_next"))
+		return true;
+	if (!strcmp(name, "t_stop"))
+		return true;
+	if (!strcmp(name, "t_start"))
+		return true;
+	if (!strcmp(name, "p_next"))
+		return true;
+	if (!strcmp(name, "p_stop"))
+		return true;
+	if (!strcmp(name, "p_start"))
+		return true;
+	if (!strcmp(name, "mem32_serial_out"))
+		return true;
+	if (!strcmp(name, "mem32_serial_in"))
+		return true;
+	if (!strcmp(name, "io_serial_in"))
+		return true;
+	if (!strcmp(name, "io_serial_out"))
+		return true;
+	if (!strcmp(name, "event_callback"))
+		return true;
+
 	return false;
 }
 
@@ -860,6 +922,56 @@ int bpf_get_addrs(unsigned long **addrsp, size_t *cntp, bool kernel)
 	return err;
 }
 
+int bpf_to_tracing_multi(struct bpf_program **progs, int prog_cnt)
+{
+	enum bpf_attach_type type;
+	int i, err;
+
+	for (i = 0; i < prog_cnt; i++) {
+		type = bpf_program__get_expected_attach_type(progs[i]);
+		if (type == BPF_TRACE_FENTRY)
+			type = BPF_TRACE_FENTRY_MULTI;
+		else if (type == BPF_TRACE_FEXIT)
+			type = BPF_TRACE_FEXIT_MULTI;
+		else if (type == BPF_MODIFY_RETURN)
+			type = BPF_MODIFY_RETURN_MULTI;
+		else
+			continue;
+		err = bpf_program__set_expected_attach_type(progs[i], type);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+int bpf_attach_as_tracing_multi(struct bpf_program **progs, int prog_cnt,
+				struct bpf_link **link)
+{
+	struct bpf_link *__link;
+	int err, type;
+
+	for (int i = 0; i < prog_cnt; i++) {
+		LIBBPF_OPTS(bpf_trace_multi_opts, opts);
+
+		type = bpf_program__get_expected_attach_type(progs[i]);
+		if (type != BPF_TRACE_FENTRY_MULTI &&
+		    type != BPF_TRACE_FEXIT_MULTI &&
+		    type != BPF_MODIFY_RETURN_MULTI)
+			continue;
+
+		opts.attach_tracing = true;
+		__link = bpf_program__attach_trace_multi_opts(progs[i], &opts);
+		err = libbpf_get_error(link);
+		if (err)
+			return err;
+
+		link[i] = __link;
+	}
+
+	return 0;
+}
+
 int compare_map_keys(int map1_fd, int map2_fd)
 {
 	__u32 key, next_key;
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 477a785c8b5f..d0878bf605af 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -470,6 +470,9 @@ int get_bpf_max_tramp_links_from(struct btf *btf);
 int get_bpf_max_tramp_links(void);
 int bpf_get_ksyms(char ***symsp, size_t *cntp, bool kernel);
 int bpf_get_addrs(unsigned long **addrsp, size_t *cntp, bool kernel);
+int bpf_to_tracing_multi(struct bpf_program **progs, int prog_cnt);
+int bpf_attach_as_tracing_multi(struct bpf_program **progs, int prog_cnt,
+				struct bpf_link **link);
 
 struct netns_obj;
 struct netns_obj *netns_new(const char *name, bool open);
-- 
2.39.5


