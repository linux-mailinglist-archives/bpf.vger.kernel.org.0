Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CBE38013C
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 02:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhENAiN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 20:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhENAiM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 20:38:12 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2248C061574
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:37:01 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id i5so18080105pgm.0
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tsnBhaD8QFT2eRYTmBpgPkDqqeV4w1UyPxjf4n0FtSc=;
        b=I53LdwXZVAkJ6JYiok/iDaSwrVWvy0iwrJ1fDG7zgqGjYt7C4Koekgi8Xp+fz9sXJ3
         Y99ImFWgVosKibSQWi2wTSSU5L+fJz++Sgb4aiAKLwAFWelk3JtGY6JUdClReSIDAj2B
         eGy3+vE4+WaFGuk60I8ccB2Svb+0gx6D8aISo749f4yBguq6yhRPGT/QTRf/tChSJhDC
         +OJC9qnzfonl0F690AHusKEmN/HrtgT7IgAJpf7d/AAcrnpqgtue7gPMczdwGwsbQrHo
         4XPS0dOES0lzLwA/A/y9G7y6l/TOp58VNhnTQrT+TSWF5WDg7raxNd4M31M4r/BO4rS5
         +/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tsnBhaD8QFT2eRYTmBpgPkDqqeV4w1UyPxjf4n0FtSc=;
        b=WXubapL5zleFxtTAIgEtfHxbc9wOAJbDl/z3dj5VuDTHB160XhUBmXxC0GLHnXC51J
         evdWfMA0ZjcmV5X3fLN3R5z9WtPULFGtVpGAtOFmlXzCpqqn2laDi6q+YFOG6z5g99r4
         I+/KDxF+ZNXdwlkf3QviR+9kHd8gAbZbP+Uz4QOr0fjjxzD2x8k7C9dz0WN5apX28Aua
         iILByiF448P621ILWK2jNaeC4oCENOCBGDQYDP21ae/dYm96BijhgdSGFqe8p4g5/ofA
         smC0YmdeDK3OQwgl2rB0pVIeQBlCa02/yRFZgOQjcVeBht5z+6ZqMZCD0GY8r+zP/45j
         4CZw==
X-Gm-Message-State: AOAM5316OyNRjJYxMV/ij9ftQHcKIKm5SsKMTA5IA/zEctXHlZcOUeTo
        0pqoheQjqWsj3xhIU0Wa6QU=
X-Google-Smtp-Source: ABdhPJzehRBMEA46pjFW3Ard8AgKtPjnmWehBr55sdT5qKCNmi+LVaQ/GENKHztvgQVce1BfjzWCww==
X-Received: by 2002:a63:1d61:: with SMTP id d33mr22609806pgm.331.1620952621299;
        Thu, 13 May 2021 17:37:01 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id b9sm302336pfo.107.2021.05.13.17.36.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 May 2021 17:37:00 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 19/21] selftests/bpf: Convert atomics test to light skeleton.
Date:   Thu, 13 May 2021 17:36:21 -0700
Message-Id: <20210514003623.28033-20-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Convert prog_tests/atomics.c to lskel.h

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  2 +-
 .../selftests/bpf/prog_tests/atomics.c        | 72 +++++++++----------
 2 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index fdc7785ff82d..b29862339222 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -313,7 +313,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h
 
 LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
-	test_ksyms_module.c test_ringbuf.c
+	test_ksyms_module.c test_ringbuf.c atomics.c
 SKEL_BLACKLIST += $$(LSKELS)
 
 test_static_linked.skel.h-deps := test_static_linked1.o test_static_linked2.o
diff --git a/tools/testing/selftests/bpf/prog_tests/atomics.c b/tools/testing/selftests/bpf/prog_tests/atomics.c
index 21efe7bbf10d..ba0e1efe5a45 100644
--- a/tools/testing/selftests/bpf/prog_tests/atomics.c
+++ b/tools/testing/selftests/bpf/prog_tests/atomics.c
@@ -2,19 +2,19 @@
 
 #include <test_progs.h>
 
-#include "atomics.skel.h"
+#include "atomics.lskel.h"
 
 static void test_add(struct atomics *skel)
 {
 	int err, prog_fd;
 	__u32 duration = 0, retval;
-	struct bpf_link *link;
+	int link_fd;
 
-	link = bpf_program__attach(skel->progs.add);
-	if (CHECK(IS_ERR(link), "attach(add)", "err: %ld\n", PTR_ERR(link)))
+	link_fd = atomics__add__attach(skel);
+	if (!ASSERT_GT(link_fd, 0, "attach(add)"))
 		return;
 
-	prog_fd = bpf_program__fd(skel->progs.add);
+	prog_fd = skel->progs.add.prog_fd;
 	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
 				NULL, NULL, &retval, &duration);
 	if (CHECK(err || retval, "test_run add",
@@ -33,20 +33,20 @@ static void test_add(struct atomics *skel)
 	ASSERT_EQ(skel->data->add_noreturn_value, 3, "add_noreturn_value");
 
 cleanup:
-	bpf_link__destroy(link);
+	close(link_fd);
 }
 
 static void test_sub(struct atomics *skel)
 {
 	int err, prog_fd;
 	__u32 duration = 0, retval;
-	struct bpf_link *link;
+	int link_fd;
 
-	link = bpf_program__attach(skel->progs.sub);
-	if (CHECK(IS_ERR(link), "attach(sub)", "err: %ld\n", PTR_ERR(link)))
+	link_fd = atomics__sub__attach(skel);
+	if (!ASSERT_GT(link_fd, 0, "attach(sub)"))
 		return;
 
-	prog_fd = bpf_program__fd(skel->progs.sub);
+	prog_fd = skel->progs.sub.prog_fd;
 	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
 				NULL, NULL, &retval, &duration);
 	if (CHECK(err || retval, "test_run sub",
@@ -66,20 +66,20 @@ static void test_sub(struct atomics *skel)
 	ASSERT_EQ(skel->data->sub_noreturn_value, -1, "sub_noreturn_value");
 
 cleanup:
-	bpf_link__destroy(link);
+	close(link_fd);
 }
 
 static void test_and(struct atomics *skel)
 {
 	int err, prog_fd;
 	__u32 duration = 0, retval;
-	struct bpf_link *link;
+	int link_fd;
 
-	link = bpf_program__attach(skel->progs.and);
-	if (CHECK(IS_ERR(link), "attach(and)", "err: %ld\n", PTR_ERR(link)))
+	link_fd = atomics__and__attach(skel);
+	if (!ASSERT_GT(link_fd, 0, "attach(and)"))
 		return;
 
-	prog_fd = bpf_program__fd(skel->progs.and);
+	prog_fd = skel->progs.and.prog_fd;
 	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
 				NULL, NULL, &retval, &duration);
 	if (CHECK(err || retval, "test_run and",
@@ -94,20 +94,20 @@ static void test_and(struct atomics *skel)
 
 	ASSERT_EQ(skel->data->and_noreturn_value, 0x010ull << 32, "and_noreturn_value");
 cleanup:
-	bpf_link__destroy(link);
+	close(link_fd);
 }
 
 static void test_or(struct atomics *skel)
 {
 	int err, prog_fd;
 	__u32 duration = 0, retval;
-	struct bpf_link *link;
+	int link_fd;
 
-	link = bpf_program__attach(skel->progs.or);
-	if (CHECK(IS_ERR(link), "attach(or)", "err: %ld\n", PTR_ERR(link)))
+	link_fd = atomics__or__attach(skel);
+	if (!ASSERT_GT(link_fd, 0, "attach(or)"))
 		return;
 
-	prog_fd = bpf_program__fd(skel->progs.or);
+	prog_fd = skel->progs.or.prog_fd;
 	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
 				NULL, NULL, &retval, &duration);
 	if (CHECK(err || retval, "test_run or",
@@ -123,20 +123,20 @@ static void test_or(struct atomics *skel)
 
 	ASSERT_EQ(skel->data->or_noreturn_value, 0x111ull << 32, "or_noreturn_value");
 cleanup:
-	bpf_link__destroy(link);
+	close(link_fd);
 }
 
 static void test_xor(struct atomics *skel)
 {
 	int err, prog_fd;
 	__u32 duration = 0, retval;
-	struct bpf_link *link;
+	int link_fd;
 
-	link = bpf_program__attach(skel->progs.xor);
-	if (CHECK(IS_ERR(link), "attach(xor)", "err: %ld\n", PTR_ERR(link)))
+	link_fd = atomics__xor__attach(skel);
+	if (!ASSERT_GT(link_fd, 0, "attach(xor)"))
 		return;
 
-	prog_fd = bpf_program__fd(skel->progs.xor);
+	prog_fd = skel->progs.xor.prog_fd;
 	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
 				NULL, NULL, &retval, &duration);
 	if (CHECK(err || retval, "test_run xor",
@@ -151,20 +151,20 @@ static void test_xor(struct atomics *skel)
 
 	ASSERT_EQ(skel->data->xor_noreturn_value, 0x101ull << 32, "xor_nxoreturn_value");
 cleanup:
-	bpf_link__destroy(link);
+	close(link_fd);
 }
 
 static void test_cmpxchg(struct atomics *skel)
 {
 	int err, prog_fd;
 	__u32 duration = 0, retval;
-	struct bpf_link *link;
+	int link_fd;
 
-	link = bpf_program__attach(skel->progs.cmpxchg);
-	if (CHECK(IS_ERR(link), "attach(cmpxchg)", "err: %ld\n", PTR_ERR(link)))
+	link_fd = atomics__cmpxchg__attach(skel);
+	if (!ASSERT_GT(link_fd, 0, "attach(cmpxchg)"))
 		return;
 
-	prog_fd = bpf_program__fd(skel->progs.cmpxchg);
+	prog_fd = skel->progs.cmpxchg.prog_fd;
 	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
 				NULL, NULL, &retval, &duration);
 	if (CHECK(err || retval, "test_run add",
@@ -180,20 +180,20 @@ static void test_cmpxchg(struct atomics *skel)
 	ASSERT_EQ(skel->bss->cmpxchg32_result_succeed, 1, "cmpxchg_result_succeed");
 
 cleanup:
-	bpf_link__destroy(link);
+	close(link_fd);
 }
 
 static void test_xchg(struct atomics *skel)
 {
 	int err, prog_fd;
 	__u32 duration = 0, retval;
-	struct bpf_link *link;
+	int link_fd;
 
-	link = bpf_program__attach(skel->progs.xchg);
-	if (CHECK(IS_ERR(link), "attach(xchg)", "err: %ld\n", PTR_ERR(link)))
+	link_fd = atomics__xchg__attach(skel);
+	if (!ASSERT_GT(link_fd, 0, "attach(xchg)"))
 		return;
 
-	prog_fd = bpf_program__fd(skel->progs.xchg);
+	prog_fd = skel->progs.xchg.prog_fd;
 	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
 				NULL, NULL, &retval, &duration);
 	if (CHECK(err || retval, "test_run add",
@@ -207,7 +207,7 @@ static void test_xchg(struct atomics *skel)
 	ASSERT_EQ(skel->bss->xchg32_result, 1, "xchg32_result");
 
 cleanup:
-	bpf_link__destroy(link);
+	close(link_fd);
 }
 
 void test_atomics(void)
-- 
2.30.2

