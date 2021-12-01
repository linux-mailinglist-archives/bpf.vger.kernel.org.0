Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACADF4654D9
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 19:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352116AbhLASQI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 13:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352135AbhLASO4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Dec 2021 13:14:56 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B955C06175D
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 10:11:17 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id y7so18372995plp.0
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 10:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3mTPev7uIJbsmyU5pVzc0DBiXXj+7faN88Sk7wt3i7w=;
        b=pCkNOrEBVPwzxpbOPHL9E9MkzM6TXt/lwNITZhr5p+eBABYthBcSOHVIS70A4N5lmr
         nnZTgmokc/ci/xbpVFjnTapUhsnpEUqHrgyxCiCjcXMh5EVDRmFrlejECRh4fX2jUIib
         TNwFtOfjCO8vWeHDmNzRVNS3thwH9ApaFDgnJ9x190LdWtY9GLtcwL9+tU/qrp5Rq126
         6YBXHHG59faieGv+QjjeCz8IgLhR6O1Gt3XCUdEaELPKCdBPt005nGXlAosVawymsmqf
         hOPxWyuxNXKlko4gW9Eqt39YZDFkBrsFUMnG/zCOLVCHcUrD3rgX2Z7R/ZxZagf69rUK
         uZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3mTPev7uIJbsmyU5pVzc0DBiXXj+7faN88Sk7wt3i7w=;
        b=OM2WURlhb91U2TMAliJp7e2lkC4Gm1wn9tdzOCDhH4WR6hcjApFetoGhlGTyse+sen
         QEUCiDOaJ/c6vxJrmVMG7qbZ2plqVG2xB0XnXxiOcNxf7fEn/ZzApemwGJaf9hOXRW8l
         WBKiNMYlkN7eylcMH6XCXNp+66fkFMF5FRvXHP5B3wxD1ZmORfMQ4+iWxXzqtb9hSy/E
         rttNCsoiDNmlxPY1KybZlkU3H98YjunYphXz1M/9GC8fIKmEI8mBL5ZrxnOTMVhAby0k
         n3Xys8C6Ns7pjOxZib8HpM27wXahydrgspNYSxLjLVddpGVGYjOvvWXzU+LbPqZwpXdc
         VGMQ==
X-Gm-Message-State: AOAM531km5yyloAPrboz6q5+L22J/d1ly5plMmI+OPuaaSkzjcyTds9t
        t8P2aV1H9beV+zc3g5kxtas=
X-Google-Smtp-Source: ABdhPJxPG/ZRPoaXgxuxpCyehs1fZDInJMuwOdf/8fD3HetpEfJyi28ZAz4GQcp0ULAsZKmuXU8M1A==
X-Received: by 2002:a17:90b:128d:: with SMTP id fw13mr9470155pjb.50.1638382276597;
        Wed, 01 Dec 2021 10:11:16 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:620c])
        by smtp.gmail.com with ESMTPSA id p2sm1326pja.55.2021.12.01.10.11.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 10:11:16 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v5 bpf-next 12/17] selftests/bpf: Add lskel version of kfunc test.
Date:   Wed,  1 Dec 2021 10:10:35 -0800
Message-Id: <20211201181040.23337-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
References: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add light skeleton version of kfunc_call_test_subprog test.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  2 +-
 .../selftests/bpf/prog_tests/kfunc_call.c     | 24 +++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index a6c0e92c86a1..6046f86841cd 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -327,7 +327,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
 	test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c
 # Generate both light skeleton and libbpf skeleton for these
-LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c
+LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test_subprog.c
 SKEL_BLACKLIST += $$(LSKELS)
 
 test_static_linked.skel.h-deps := test_static_linked1.o test_static_linked2.o
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
index 5c9c0176991b..7d7445ccc141 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -4,6 +4,7 @@
 #include <network_helpers.h>
 #include "kfunc_call_test.lskel.h"
 #include "kfunc_call_test_subprog.skel.h"
+#include "kfunc_call_test_subprog.lskel.h"
 
 static void test_main(void)
 {
@@ -49,6 +50,26 @@ static void test_subprog(void)
 	kfunc_call_test_subprog__destroy(skel);
 }
 
+static void test_subprog_lskel(void)
+{
+	struct kfunc_call_test_subprog_lskel *skel;
+	int prog_fd, retval, err;
+
+	skel = kfunc_call_test_subprog_lskel__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel"))
+		return;
+
+	prog_fd = skel->progs.kfunc_call_test1.prog_fd;
+	err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
+				NULL, NULL, (__u32 *)&retval, NULL);
+	ASSERT_OK(err, "bpf_prog_test_run(test1)");
+	ASSERT_EQ(retval, 10, "test1-retval");
+	ASSERT_NEQ(skel->data->active_res, -1, "active_res");
+	ASSERT_EQ(skel->data->sk_state_res, BPF_TCP_CLOSE, "sk_state_res");
+
+	kfunc_call_test_subprog_lskel__destroy(skel);
+}
+
 void test_kfunc_call(void)
 {
 	if (test__start_subtest("main"))
@@ -56,4 +77,7 @@ void test_kfunc_call(void)
 
 	if (test__start_subtest("subprog"))
 		test_subprog();
+
+	if (test__start_subtest("subprog_lskel"))
+		test_subprog_lskel();
 }
-- 
2.30.2

