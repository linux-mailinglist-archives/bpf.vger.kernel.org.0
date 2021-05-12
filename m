Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3EF37EF46
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 01:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344635AbhELXDj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 19:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346985AbhELVpP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 17:45:15 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20155C08C5DF
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:36 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id k19so19713238pfu.5
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tsnBhaD8QFT2eRYTmBpgPkDqqeV4w1UyPxjf4n0FtSc=;
        b=OJJXt99gl4825B2pzbpQr4JCa+9it6BoSSB20z+PxPfYFvWIzcXC5DgbrLi885vOiD
         wVgUHrbVY8+D4ch77GtaVMIt6D/G0hDB8ALRsgg9zGvktHyxgu+YxZtGocE75VoGS+Yx
         RXgCnNhvQQJnIdvZLn2VlPsNWCdw6qNRRAzb9tmNJRhKwVQsQbZ2Ak1PmDaG3TPBzVLL
         bwCoT/feJczxs9yrRR1qyZxxcXCes8HU0BOXyjGxm4EEfx/ANbNVzHUCRu6fUtHmA3tb
         W/TDzoP4fIgiq99BLXsKek8pRD1mLndURZS5UU29Z3x+y89PqYQ5vpSTFCbd8FtVJAjk
         sFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tsnBhaD8QFT2eRYTmBpgPkDqqeV4w1UyPxjf4n0FtSc=;
        b=Gg+IjUO1R7geBBFYwxHVahgpfr8OryKMYx9jTkqcA23SIXuT9iTrslpnQAkzjXjEAz
         WWBVfLH2/YKFEjI6whQ3uw1E7MWbtZ0Y8QXFuNo3i4i4W9tU/NKCJZPbdRUSEjlDU1N8
         vnoubqaPVqBCfMwbdMyxOwHGa+8A2rWjZgJwpHLiUiIo+jpWTYZZGk//vOtsRLXt40gT
         15GSmtzqBRmQgYAlpb1DGq2P6ApyBkqi5G5kq8ViY7KEBP6kPQrgZoSL69tHgQO5F0mU
         YijLLMDNJ9VwpNBCayv8eMbGS5AUvMiS8DmYiThY3hLEYFETl6rwRT8OShMMgH6UVIKY
         t73Q==
X-Gm-Message-State: AOAM530CxEYVjlICn1OpNkAhCq19o4pyyngj5mJ4PlA8phI8BIcGAqiN
        uohOi61sdTVgQRYcnzfftYQ=
X-Google-Smtp-Source: ABdhPJyheq9TTfUJgqx4+tcOAH+vohfqfieALwNtr6BjuNqurIiJmK5QioPKaEZ9xW0wsRrFZerk8Q==
X-Received: by 2002:a17:90b:4b90:: with SMTP id lr16mr594172pjb.203.1620855215691;
        Wed, 12 May 2021 14:33:35 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id c128sm609222pfa.189.2021.05.12.14.33.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 14:33:35 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 19/21] selftests/bpf: Convert atomics test to light skeleton.
Date:   Wed, 12 May 2021 14:32:54 -0700
Message-Id: <20210512213256.31203-20-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
References: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
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

