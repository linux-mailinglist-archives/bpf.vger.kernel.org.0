Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15089410102
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 23:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244638AbhIQV7R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 17:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244153AbhIQV7R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 17:59:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC23FC061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:57:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j1so7844057pjv.3
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ua8PrUJUNaVBGGr8bTLUlc76LG8OFg5OFWYh/tNoyG4=;
        b=o9AiexYpcorFqggWVXvN46SGwD0hncmZp97j9cGQns9f4QwrDiXS6h7R6KTBxlxu1l
         C/2FPUY08ijqumVPHVanLiN3QIYemgY1JyHoGzIjPGj5I49dX2hDYqxp2ECFO2eLbL7d
         hequRprdyR34jyRxIV9sf5eN+xF5vC2MT4WB0iDVnZjSju+x8o0M8tCr60XJFjoiRBl6
         3YI5xKLi6xubfHyskRvon2xVsNxhTidSmZE3iR/qFHxs5gEwtpLHjEXdNwHplhvX7tjF
         iamNPPcwusfmy4sLbDppFDS6GwFA9Erl/nTd5r6YO9fR8tvs3dRWGXfj5L6n4Za3lbNV
         teYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ua8PrUJUNaVBGGr8bTLUlc76LG8OFg5OFWYh/tNoyG4=;
        b=zv5mK1t6ZzyHRtDXuWQyBsN7FFrD0UDSGCMoYTO+PgxK5M1iL4sNfTvEYtQ63JOToG
         J0Vuoy357Awmqehx360RN+LNKnCGLDF0Ht9BE49dItRurReVAg+zGv6FUJ2iJiBjGuJS
         D4bTojKr0x+Mtyl4Jzt3II0y4aFWjWb5HHMG5Vmu0mJheQcXIRgGVjbrt35MzEId5H++
         Enm7jvVl6gpJ7YJNzxZU5wQuj9UY6zJox/VXngdBfsMyhfeYOPQ8k0CKIFNn3uy6yH0e
         KIG5xOFSA9FNtmtZ3s4sIaItoM6yzLexN+pUSq9JFtRQnOId0iZ42J+f+PiUHRQQaKB9
         0dJw==
X-Gm-Message-State: AOAM531xsX2/PxqOAr8irgTRmsidmv0SHVceL5pxMFCCYpJDIAl0betT
        NwxAUlkk8zlyMNyV9tsTses=
X-Google-Smtp-Source: ABdhPJzUEIMpn0eVJKE9Qea3rF8FZxWVYUzvtX9jVllY7TWic4PvxZ8IylBlRZ2MlbwqUzKGu+L4lQ==
X-Received: by 2002:a17:90a:b795:: with SMTP id m21mr14718706pjr.143.1631915874271;
        Fri, 17 Sep 2021 14:57:54 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:500::6:db29])
        by smtp.gmail.com with ESMTPSA id g12sm11454366pja.28.2021.09.17.14.57.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Sep 2021 14:57:53 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        lmb@cloudflare.com, mcroce@microsoft.com, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH RFC bpf-next 10/10] selftests/bpf: Convert map_ptr_kern test to use light skeleton.
Date:   Fri, 17 Sep 2021 14:57:21 -0700
Message-Id: <20210917215721.43491-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

To exercise CO-RE in the kernel further convert map_ptr_kern
test to light skeleton.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile             | 2 +-
 tools/testing/selftests/bpf/prog_tests/map_ptr.c | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 81031c8bdcb8..390e9875a13e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -316,7 +316,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 
 LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
 	test_ksyms_module.c test_ringbuf.c atomics.c trace_printk.c \
-	trace_vprintk.c	kfunc_call_test_subprog.c
+	trace_vprintk.c	kfunc_call_test_subprog.c map_ptr_kern.c
 SKEL_BLACKLIST += $$(LSKELS)
 
 test_static_linked.skel.h-deps := test_static_linked1.o test_static_linked2.o
diff --git a/tools/testing/selftests/bpf/prog_tests/map_ptr.c b/tools/testing/selftests/bpf/prog_tests/map_ptr.c
index 4972f92205c7..62369f8ae124 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_ptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_ptr.c
@@ -4,7 +4,7 @@
 #include <test_progs.h>
 #include <network_helpers.h>
 
-#include "map_ptr_kern.skel.h"
+#include "map_ptr_kern.lskel.h"
 
 void test_map_ptr(void)
 {
@@ -18,9 +18,7 @@ void test_map_ptr(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
-	err = bpf_map__set_max_entries(skel->maps.m_ringbuf, page_size);
-	if (!ASSERT_OK(err, "bpf_map__set_max_entries"))
-		goto cleanup;
+	skel->maps.m_ringbuf.max_entries = page_size;
 
 	err = map_ptr_kern__load(skel);
 	if (!ASSERT_OK(err, "skel_load"))
@@ -28,7 +26,7 @@ void test_map_ptr(void)
 
 	skel->bss->page_size = page_size;
 
-	err = bpf_prog_test_run(bpf_program__fd(skel->progs.cg_skb), 1, &pkt_v4,
+	err = bpf_prog_test_run(skel->progs.cg_skb.prog_fd, 1, &pkt_v4,
 				sizeof(pkt_v4), buf, NULL, &retval, NULL);
 
 	if (CHECK(err, "test_run", "err=%d errno=%d\n", err, errno))
-- 
2.30.2

