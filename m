Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBF4457AD3
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 04:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbhKTDg0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 22:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhKTDg0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 22:36:26 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31EDC061574
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 19:33:23 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso10341814pjo.3
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 19:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/t6UEiBdrHVcO80I/mXmHpDCBJjInFyaAv3FiStHrS8=;
        b=ONtIPJB17G7ia0+0JgvZWofVJvevKZZzCVrap0f8dpfXaItvAO4Ji6R2zbN7y3w8/n
         FufMzlwSZdQCu5F23AWOSVbsKKxdgPDKnWUZktslP7QS2tZwinRkD3F29aVMMfGXoCCB
         ziJ3IragcdEqzm5V1Ldl93OXedRzxhV1HDDgLbwNPd8Q/r7Vk9cdh3fkhJRy5rcVApiW
         /zvNsnkplip/en5hQLfki3le6bYMC+iqDJ+pWtlpmI2eGe5pxuFaMvQOqkeFW17gbnu/
         AXa8dcflbcKBNr6PFDI2uGP0WbD6FMUKygB0jlHI9Tn90iFJqq9ZuEF9XFJf/TUpFtMr
         kmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/t6UEiBdrHVcO80I/mXmHpDCBJjInFyaAv3FiStHrS8=;
        b=vJwhhmGnhHojhm77tWD1p+LnE6QXgcSUVwEE0zNSav5VVj/SVw2b+t1xG6I4LMK88S
         FdeVyTK6MhW5GJzSyec2Z/2sJuIQi5AreMeym60FFmaC3ef9Qrx5YKjHOfg1fICeo2MC
         so966j23OoKI8tgpqyByKZtQcs/r6T72/efaXpCT/rMP8DWXgi3lq927DgyuBJfeniYv
         9kBiXOL0Nj7PC0oQqMGfgdzLlZ283GveDY9z07z5I5vl6jad20QWMFo0CdRqcFGTGh58
         hyxJC/2VZ83LxTWxlmwPWc40mXWqWRukvuZEvTLMVrVkkhWa7BHq2ZBECDcA6vw+pTWL
         rx7A==
X-Gm-Message-State: AOAM5312FVyAd4Upea0JpkYwqP8trNyZexJOHYq7qsRUumytgpIeMwjc
        dJmZ+JhkOjOhYGONmF23Wow=
X-Google-Smtp-Source: ABdhPJwexf7+vKGFnYcge6LMYqNjkmuJKmMwkQUpu7CYvTopa73ndzYCRitQa22mWPxSubmMQFQHZw==
X-Received: by 2002:a17:90a:8b01:: with SMTP id y1mr6104072pjn.225.1637379203230;
        Fri, 19 Nov 2021 19:33:23 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:a858])
        by smtp.gmail.com with ESMTPSA id k8sm997781pfu.75.2021.11.19.19.33.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Nov 2021 19:33:22 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 bpf-next 09/13] selftests/bpf: Add lskel version of kfunc test.
Date:   Fri, 19 Nov 2021 19:32:51 -0800
Message-Id: <20211120033255.91214-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add light skeleton version of kfunc_call_test_subprog test.

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

