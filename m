Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB394654DE
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 19:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352262AbhLASQS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 13:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352257AbhLASPE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Dec 2021 13:15:04 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F95C0613E1
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 10:11:22 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id q17so18322571plr.11
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 10:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pI1/J4pleJ87gmicYPN3ba5h1so2XxOzSdN0LI8wg3c=;
        b=R1rXsXRQSFZ/pV613HQz7VKkA6nDbUM0gYkTteCtLZJaEtFzGCCFuudPIyOPrM5LW8
         wsFuFtr5J6K4Y5VuI9SL5UzYX2GmG8IddjeGSqe2IWqD9OgwQYyOm/iiHMQgdCZV/UmD
         aGTOrbQXpA8nFEB1grmN08JHmsh7Cr9PlRo/TLRYeTGHvBHbUd0XjcxCc7gLtV/dlKW3
         RiA8c74PZHe15DADQ23Q/yaPcYC2+Mo6i+l7lCFs2R9FTq1uFuC46Lb9S4cm0qHFCbX7
         d2eUO1UIHnMROQp6OcrHNX7EsW6Q44bSMutunBpU+C57nJsQowGDetaxq81ZEXpc6cbU
         iHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pI1/J4pleJ87gmicYPN3ba5h1so2XxOzSdN0LI8wg3c=;
        b=Nl+Gq0qbX7Prk/xqUHzwroXVS7pVPBiNXYfY1fowMIArGZAoln/CPNzT+XkelR3Mvf
         aP95GtW2VSeoLy5HAHUIoWHq6Ky+lYL5puub4zLFoIH3Cteeat+X1QUTVb09fu6xJj16
         cTmvvRnDbXZCVQxWCOAgclEkOV3Meuk2dCJXLEEmqHMw55hkPvtHfgJKsuEEmNNKaSHl
         phWEtSilghEGDMgzR9dFfxtwphts4QwpQW7NefzsHzmQHgL25yAJPuPef1VuW70yWtMS
         6FU+wMVQEDDKtdrZmGbbgKS9eDz+meb4GPyWZ30AC7OIP5qLsxNjvf8/SgKFXeZ9oRIR
         3xHA==
X-Gm-Message-State: AOAM530E9mYGVWjNPAED47mFsEfhQmo6mctWIEJu1MuJmSACM9mSz3+e
        DphRZlmfJhcroktXwdAEZnk=
X-Google-Smtp-Source: ABdhPJz0RMaSs/z/KF0zZqSkkvfvzHIHLKMVYxwJ6ljaog3xIQlyGA5uvuKWCa8a8rGArGShjDc1mQ==
X-Received: by 2002:a17:90a:6e41:: with SMTP id s1mr9621619pjm.166.1638382282374;
        Wed, 01 Dec 2021 10:11:22 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:620c])
        by smtp.gmail.com with ESMTPSA id g9sm505991pfv.71.2021.12.01.10.11.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 10:11:21 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v5 bpf-next 14/17] selftests/bpf: Convert map_ptr_kern test to use light skeleton.
Date:   Wed,  1 Dec 2021 10:10:37 -0800
Message-Id: <20211201181040.23337-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
References: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

To exercise CO-RE in the kernel further convert map_ptr_kern
test to light skeleton.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile             |  3 ++-
 tools/testing/selftests/bpf/prog_tests/map_ptr.c | 16 +++++++---------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 6046f86841cd..200ebcc73651 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -325,7 +325,8 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h
 
 LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
-	test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c
+	test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c \
+	map_ptr_kern.c
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test_subprog.c
 SKEL_BLACKLIST += $$(LSKELS)
diff --git a/tools/testing/selftests/bpf/prog_tests/map_ptr.c b/tools/testing/selftests/bpf/prog_tests/map_ptr.c
index 4972f92205c7..273725504f11 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_ptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_ptr.c
@@ -4,31 +4,29 @@
 #include <test_progs.h>
 #include <network_helpers.h>
 
-#include "map_ptr_kern.skel.h"
+#include "map_ptr_kern.lskel.h"
 
 void test_map_ptr(void)
 {
-	struct map_ptr_kern *skel;
+	struct map_ptr_kern_lskel *skel;
 	__u32 duration = 0, retval;
 	char buf[128];
 	int err;
 	int page_size = getpagesize();
 
-	skel = map_ptr_kern__open();
+	skel = map_ptr_kern_lskel__open();
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
-	err = bpf_map__set_max_entries(skel->maps.m_ringbuf, page_size);
-	if (!ASSERT_OK(err, "bpf_map__set_max_entries"))
-		goto cleanup;
+	skel->maps.m_ringbuf.max_entries = page_size;
 
-	err = map_ptr_kern__load(skel);
+	err = map_ptr_kern_lskel__load(skel);
 	if (!ASSERT_OK(err, "skel_load"))
 		goto cleanup;
 
 	skel->bss->page_size = page_size;
 
-	err = bpf_prog_test_run(bpf_program__fd(skel->progs.cg_skb), 1, &pkt_v4,
+	err = bpf_prog_test_run(skel->progs.cg_skb.prog_fd, 1, &pkt_v4,
 				sizeof(pkt_v4), buf, NULL, &retval, NULL);
 
 	if (CHECK(err, "test_run", "err=%d errno=%d\n", err, errno))
@@ -39,5 +37,5 @@ void test_map_ptr(void)
 		goto cleanup;
 
 cleanup:
-	map_ptr_kern__destroy(skel);
+	map_ptr_kern_lskel__destroy(skel);
 }
-- 
2.30.2

