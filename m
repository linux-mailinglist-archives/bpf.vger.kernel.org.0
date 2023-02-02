Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35480688472
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 17:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjBBQbM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 11:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjBBQbK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 11:31:10 -0500
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680C21EFEF;
        Thu,  2 Feb 2023 08:31:09 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id t190so1133566vkb.13;
        Thu, 02 Feb 2023 08:31:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41JmIiWypJedOVx8x/Y9I2aABbvFV6cOq2dHkYH7gG4=;
        b=WPk3XJxJDemqpwYzjDSvCRi5/TOQzasL2sL9tJ2zMmYRfyw+aAQmheubX64ciERbTr
         2EKh70atPq1PdBdt5hX810ABdU5xfv78DbeKOxir+9hqUsg5ludxUR3uNBUeVD3w597B
         mL4LqmgdoX1oA3F8ERlHsT3IR58Si1G5nGfE23fKad+RzXLxUwRH1l63W38ENeNr5mMN
         WXte9RXSouMpYKrw/kgfZClwjln1Znl0Vz6T4QI4wqvhd5juaPIYfG7ZPeBk5+SlfR6j
         putNrYsSSlrRaDkp1wtP6JRVI0lRF/pc8/avLrCrDMyYn2v8mdRFIPto5J3iKgaYpD0C
         V2hg==
X-Gm-Message-State: AO0yUKUZSoOD+ZAfWyNaBamTGpI5j99NQWd53xuylMRXCNJ2MzOyKb6j
        XNvSYD0U52uO3Rvi/X6ksM26OeyPFSYWKUaq
X-Google-Smtp-Source: AK7set+46awZ3yPDhQZLUoEze9NTMRgmlNoQXpkKYxcYZT1w30CqXFU4R+NEW88K0azzssDfFV+ScA==
X-Received: by 2002:a1f:a1c7:0:b0:3e1:79a5:74d7 with SMTP id k190-20020a1fa1c7000000b003e179a574d7mr3091626vke.10.1675355468049;
        Thu, 02 Feb 2023 08:31:08 -0800 (PST)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id ea7-20020a05620a488700b007290be5557bsm17239qkb.38.2023.02.02.08.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:31:07 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, toke@redhat.com, brouer@redhat.com,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add a selftest for the KF_DEPRECATED kfunc flag
Date:   Thu,  2 Feb 2023 10:30:56 -0600
Message-Id: <20230202163056.658641-4-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230202163056.658641-1-void@manifault.com>
References: <20230202163056.658641-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that we have KF_DEPRECATED, we should add a selftest for it. This
patch implements that selftest by adding a new test
bpf_kfunc_call_test_deprecated() that includes the KF_DEPRECATED flag,
and adding a kfunc_call_test_deprecated testcase to the kfunc_call_test
suite which verifies that the program is loaded and has the expected
verifier error message.

Signed-off-by: David Vernet <void@manifault.com>
---
 net/bpf/test_run.c                                  |  5 +++++
 tools/testing/selftests/bpf/prog_tests/kfunc_call.c |  2 ++
 tools/testing/selftests/bpf/progs/kfunc_call_test.c | 10 ++++++++++
 3 files changed, 17 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index e6f773d12045..945d6f7c1825 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -746,6 +746,10 @@ __bpf_kfunc static u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused
 	return arg;
 }
 
+__bpf_kfunc void bpf_kfunc_call_test_deprecated(void)
+{
+}
+
 __diag_pop();
 
 BTF_SET8_START(bpf_test_modify_return_ids)
@@ -785,6 +789,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_deprecated, KF_DEPRECATED)
 BTF_SET8_END(test_sk_check_kfunc_ids)
 
 static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
index a543742cd7bd..98398dba5718 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -319,4 +319,6 @@ void test_kfunc_call(void)
 
 	if (test__start_subtest("destructive"))
 		test_destructive();
+
+	RUN_TESTS(kfunc_call_test);
 }
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test.c b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
index 7daa8f5720b9..b605438e42dd 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2021 Facebook */
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 extern long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
 extern int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __u32 b) __ksym;
@@ -18,6 +19,7 @@ extern void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
 extern int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size) __ksym;
 extern int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
 extern u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused) __ksym;
+extern void bpf_kfunc_call_test_deprecated(void) __ksym;
 
 SEC("tc")
 int kfunc_call_test4(struct __sk_buff *skb)
@@ -192,4 +194,12 @@ int kfunc_call_test_static_unused_arg(struct __sk_buff *skb)
 	return actual != expected ? -1 : 0;
 }
 
+SEC("tc")
+__success __log_level(2) __msg("calling deprecated kfunc bpf_kfunc_call_test_deprecated")
+int kfunc_call_test_deprecated(struct __sk_buff *skb)
+{
+	bpf_kfunc_call_test_deprecated();
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.39.0

