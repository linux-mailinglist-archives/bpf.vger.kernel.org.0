Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D86845B423
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 07:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhKXGFw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 01:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbhKXGFw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 01:05:52 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4277FC061574
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:43 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so3601619pjj.0
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1sTqqJv+t6dZCYugr+KFX3yThcXdzVlHC+f9b6EubaM=;
        b=BKvkbrLSNQdnzNOjXfNXCdyRI2b14MBXtjMQ9feVd5Ug7S5pyZyGOsjRV2R/CAODA5
         +K8cxYO306KryD96mMnuq2DGWawuZXmn8ic+p8sXfnu6UmLLtVFt/MplQ/rrtgN7FSAP
         Pdm95PIJssYs2epf6MIEo9Ku/tzAbJ+Kr4o35+nA5vp+cObw06OJEZeU4NtJrtIt+CzG
         qN4mN3S0jyDhjleFjXzjKnJwb5cxHES7kl0U90DM92Mn8LOf7GID17u46nelq8wXanxv
         HHCuWwOMg4l69tqZjjssM3j1IiIcgvTlq8uhFKJOMUAyMCutJ5jmYEd0mYoAvkEC44JF
         URlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1sTqqJv+t6dZCYugr+KFX3yThcXdzVlHC+f9b6EubaM=;
        b=elmIh0Ou5JTnwJs8egXAGYndcec8xk8o2HZ+3e8p4QaPbpcahgL6HgJ0bzbsyx1ndo
         mat2bSPiDGkMWqxI4dhAhg/jNKGDFhSAKp5h8+BLehuiu6X1Uj0nhJ3GFuSC7IP7hcHa
         ZvjG91I6c5/PGYnUvjUFxdXQUeqiZ8RC3lcMBfam4bMyGfa/z5BGRfGexdu4soRHwh23
         yYcZ9cEO+Za8QuHJc5tnJUOsa1wQ5D2TXsq2FKKu/RotcAzi+36pNTQjy735en/sVIuJ
         Y52gyjBcBqxypJzENn3UOQ2QZACuf2+8pvcAwYzRwCT6y/mldotGd6MNqfJPzvLOdwPp
         5tJg==
X-Gm-Message-State: AOAM532r7Z8j7V2yqutQQDjCZWevAnyDdCCo1sw8MNxD3TV6eejFv66L
        0MnnO8364IJ85r7Gk2481E0=
X-Google-Smtp-Source: ABdhPJyup37l4wxs1DuhRzGuHPqJ2OXCfn7ebF0RDX6zpgWewH5DN7+rh50YlIk6Y7SjqOVfFCcTkg==
X-Received: by 2002:a17:90a:a396:: with SMTP id x22mr5323955pjp.14.1637733762863;
        Tue, 23 Nov 2021 22:02:42 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:8fd1])
        by smtp.gmail.com with ESMTPSA id oc10sm3534354pjb.26.2021.11.23.22.02.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Nov 2021 22:02:42 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 bpf-next 11/16] selftests/bpf: Add lskel version of kfunc test.
Date:   Tue, 23 Nov 2021 22:02:04 -0800
Message-Id: <20211124060209.493-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211124060209.493-1-alexei.starovoitov@gmail.com>
References: <20211124060209.493-1-alexei.starovoitov@gmail.com>
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
index 35684d61aaeb..0c9f1837ece2 100644
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

