Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF58F376F45
	for <lists+bpf@lfdr.de>; Sat,  8 May 2021 05:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhEHDuV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 May 2021 23:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhEHDuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 May 2021 23:50:19 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60069C061761
        for <bpf@vger.kernel.org>; Fri,  7 May 2021 20:49:18 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id z18so2645617plg.8
        for <bpf@vger.kernel.org>; Fri, 07 May 2021 20:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GqMwLc8bZDgAdQd/jqEc6DeFkm+cdgyoPkr6k8iE7nM=;
        b=VbrKA3+0i4+Oho5UKudks7y7KAY02+CFOZBkFB/qFiigY0eMCPH8nDKWeVy4Q4ativ
         EqzvTHLX3Uz+jxIrt7mOKGTLnBNB+tAH/JRelu8MVW8TliN/E2zGeEOYKtU4ghFqLklo
         +XaOJUW7k9yka2NHbrsgwXZk/s2QCtP+hmAS1rlwJmz4aapUmqUS8rukBEZ9dEQDhPU8
         CmbETiSo2wE8C3HWCz1XF9R5s8/OyxBUIQBPzMzb6UQUujZcPP2TwbZ9f5ywSOzHX52x
         5CQtVrdE5n5mIq8WMe97unD5X1sOIL4yoU4b2Dhst33qgkskrODAI88VyxNE956rnZA/
         W7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GqMwLc8bZDgAdQd/jqEc6DeFkm+cdgyoPkr6k8iE7nM=;
        b=jkUdMhyw6ddg/etpkPKkaXz2AN//361+FnWRukxPTBIAQha64WcWJYw3qkyWF+EaKK
         zv0UL1Bf2R/+Bs5yv4E/gaPDMoCt5EiR7Vvax8RLIyV6sY6csBFN8oULZt390i6XpaNt
         cZt/oRZf5JVHOi0V2lMCjM6YMfFO7EGb9t13yJej7/ahEwMZdm+nUPkR5NyMHFAVOEoZ
         vBaKY6JKEMMKk23d1vRngcdH1hz/Vvnw46zwax+ku7J9+ccbsUjmOxq4Oi5sYFC2p8Up
         2XgBoXCI4IoJ3Z0iHmcV6PS2JrzIBAmy8WARo1LfiInFyjGWgWp9nCi+xyaTmthmmM8J
         otIA==
X-Gm-Message-State: AOAM5331aPpTVJuuD9w0YZHf5fyn4iC98yLnGZV/PCCaJNWK1z5HvUzC
        w6nhkVmvDG75enIizSVuVtA=
X-Google-Smtp-Source: ABdhPJxvKzeUGFf3kcL0oZeaMg5XIhtvCmshGosZcxUOeYnK9tSsmTlrcA17gBSYHU9K/ktws4GsCQ==
X-Received: by 2002:a17:90a:590d:: with SMTP id k13mr15081797pji.68.1620445757946;
        Fri, 07 May 2021 20:49:17 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.1])
        by smtp.gmail.com with ESMTPSA id u12sm5784606pfh.122.2021.05.07.20.49.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 20:49:17 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 20/22] selftests/bpf: Convert atomics test to light skeleton.
Date:   Fri,  7 May 2021 20:48:35 -0700
Message-Id: <20210508034837.64585-21-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Convert prog_tests/atomics.c to lskel.h

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  2 +-
 .../selftests/bpf/prog_tests/atomics.c        | 73 ++++++++++---------
 2 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f794f16c79b8..4f50e4367e42 100644
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
index 21efe7bbf10d..b5b139ee5614 100644
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
@@ -32,21 +32,22 @@ static void test_add(struct atomics *skel)
 
 	ASSERT_EQ(skel->data->add_noreturn_value, 3, "add_noreturn_value");
 
+
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
@@ -66,20 +67,20 @@ static void test_sub(struct atomics *skel)
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
@@ -94,20 +95,20 @@ static void test_and(struct atomics *skel)
 
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
@@ -123,20 +124,20 @@ static void test_or(struct atomics *skel)
 
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
@@ -151,20 +152,20 @@ static void test_xor(struct atomics *skel)
 
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
@@ -180,20 +181,20 @@ static void test_cmpxchg(struct atomics *skel)
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
@@ -207,7 +208,7 @@ static void test_xchg(struct atomics *skel)
 	ASSERT_EQ(skel->bss->xchg32_result, 1, "xchg32_result");
 
 cleanup:
-	bpf_link__destroy(link);
+	close(link_fd);
 }
 
 void test_atomics(void)
-- 
2.30.2

