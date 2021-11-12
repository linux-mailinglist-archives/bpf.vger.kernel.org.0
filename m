Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6853744E141
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 06:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhKLFFs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 00:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhKLFFs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 00:05:48 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263E7C061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:02:58 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c126so7582816pfb.0
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=69Q2mmj9G9aHrVxANhMbx5yGbFsd1Ur33mmjoTt2NjY=;
        b=D0swAPm1TnMzzZBp/cNJ8hVgiSBEFQBUv+zBAy8cKdJxYsZhca/YoCSAgsJGKK7860
         OZIsusWu/ILNyFXqDzQv1iPUemNnZq3M8DBjJdVEYyYp5h/WFqXuHJGZ04wTQimLWi/U
         ilu3iywGPbKSdyani7JDW8aRMYXMztVHkXfDaMTjQP+s1fquD6zzF9n5vYWqGlRkYdqa
         9WzF/y/ZmkwtGr65SEGRgIQngjYekooIpTy+b2zIjPMD0Nupq/l5tqtET665P4iR1NmO
         ELFUV8Op8B5RLzo3jShaumMz2lag88PssBzkNLmovTebgAEr2qs8dnWyvVwCKfCobuHX
         4RfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=69Q2mmj9G9aHrVxANhMbx5yGbFsd1Ur33mmjoTt2NjY=;
        b=ZSru44gYA+TAL884Sc/i5fEYvr4OEE+KxbpL9Xbwd6vQW5226o74KaRRx6m/Y26x8R
         4k2cM0a46ACxGUhBxKyUU2moIFpW+aOt+Aq5fYRSjjA+N3Y+dJGi/+t3DyMtk/C/oLo5
         +Dqm8/ShDdpTwxY76CLugWsLlSIuS/sGn0ocF/csMSEaXuSIfqseoFd5fHA4V5gEUYOG
         EEDcyFcyhscHATkPAFUORecw0gFFMMu9BaGkExUNjpMR4ENvIzGf9wARilqduxZunUGv
         +LrSKzKXwQ70HUs2ed7uPUbwR4ec1e0ba7aP0zEjhewuncV9PmLamguIWqbr2Mg6XvwP
         wBaw==
X-Gm-Message-State: AOAM530mLSa3T/N2e+ZIgizgvOamfJjxGj7EwKdcH55zHq8U9Ne5VIcx
        S8kq/jf+TBUZc7+p6VT9t5Cr1l0HW/o=
X-Google-Smtp-Source: ABdhPJwrYSxN7ihMNCAsQjUm96dHCbGiSVe7/q+HuzbyDp3V3E0VHPGKbFbmqeHCJITnklXzcL/Y9w==
X-Received: by 2002:a63:dc0d:: with SMTP id s13mr8435342pgg.254.1636693376640;
        Thu, 11 Nov 2021 21:02:56 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:3dc4])
        by smtp.gmail.com with ESMTPSA id w12sm9522732pjq.2.2021.11.11.21.02.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Nov 2021 21:02:56 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 bpf-next 09/12] selftests/bpf: Convert kfunc test with CO-RE to lskel.
Date:   Thu, 11 Nov 2021 21:02:27 -0800
Message-Id: <20211112050230.85640-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Convert kfunc_call_test_subprog to light skeleton.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile                |  3 ++-
 tools/testing/selftests/bpf/prog_tests/kfunc_call.c | 10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 0470802c907c..811c5e150aa9 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -325,7 +325,8 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h
 
 LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
-	test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c
+	test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c \
+	kfunc_call_test_subprog.c
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c
 SKEL_BLACKLIST += $$(LSKELS)
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
index 5c9c0176991b..4ba6f3867b3c 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -3,7 +3,7 @@
 #include <test_progs.h>
 #include <network_helpers.h>
 #include "kfunc_call_test.lskel.h"
-#include "kfunc_call_test_subprog.skel.h"
+#include "kfunc_call_test_subprog.lskel.h"
 
 static void test_main(void)
 {
@@ -31,14 +31,14 @@ static void test_main(void)
 
 static void test_subprog(void)
 {
-	struct kfunc_call_test_subprog *skel;
+	struct kfunc_call_test_subprog_lskel *skel;
 	int prog_fd, retval, err;
 
-	skel = kfunc_call_test_subprog__open_and_load();
+	skel = kfunc_call_test_subprog_lskel__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel"))
 		return;
 
-	prog_fd = bpf_program__fd(skel->progs.kfunc_call_test1);
+	prog_fd = skel->progs.kfunc_call_test1.prog_fd;
 	err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
 				NULL, NULL, (__u32 *)&retval, NULL);
 	ASSERT_OK(err, "bpf_prog_test_run(test1)");
@@ -46,7 +46,7 @@ static void test_subprog(void)
 	ASSERT_NEQ(skel->data->active_res, -1, "active_res");
 	ASSERT_EQ(skel->data->sk_state_res, BPF_TCP_CLOSE, "sk_state_res");
 
-	kfunc_call_test_subprog__destroy(skel);
+	kfunc_call_test_subprog_lskel__destroy(skel);
 }
 
 void test_kfunc_call(void)
-- 
2.30.2

