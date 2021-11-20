Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C2A457AD6
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 04:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbhKTDgl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 22:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbhKTDgc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 22:36:32 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213C3C06173E
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 19:33:29 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so10327484pjb.5
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 19:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EM57a3c4C0+gbX6SEdRULPw3rSjjYeNwfaqSyMKFhvw=;
        b=aQZ9UB1p3AluxMfWopIdxEfUDkKYXBeqFabOUAkVQYLerVQu6F2dxjxZfPVdW6sXQf
         ApifHikaBhV3GvtHK0QTQ8TQweevzcOff7PWrvxFa0gP/RbvuGgcuZHNlzYfgNtXqWtb
         8OSDpdyOQcdkJ2XgUC1nTBWFOZfs6PlAbGaN8m/skvkglavHB/ivvYRjR0ZrrwXilYKD
         EBoAn5ox/wG1uAWngj3Uza13YNVXmWUuNfncqHpMDOeYTp/1iHboZoR0IvCKartk9FmN
         BLtTya0hF81v86LJij0GLfSuFZst4f3tMWMAj4n6Oxnx9PKsIGTu+WxCKZrjfcEWCzLo
         HkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EM57a3c4C0+gbX6SEdRULPw3rSjjYeNwfaqSyMKFhvw=;
        b=50FYe536gMi0g3hwTBBfs9qtCg1N3/hHoJYq92tjsSOWhHyYTaQUplppl8EEwy98PZ
         oluqIxhOnkUX15pgFhAMXm3sO08x1YtnJvm9IJOn4mUC+duYLJPmjtEfQDZdQxskGbOs
         v9ui3XXer9JE4vjGW8IdWYVOuOvnkLfFjtFbSCtmIGT+jK5AKwfPO8SewTfc/SbpCHjA
         3ZwR2/slq5u+aOXa7J4Qog0fC6X29OkF1/ewxTV1y1hxRNUO4DRk5eUIkC3RsEGPrmXi
         /13l1UEzX1Wv0abBCekA33BJVHT99MPfcLCdzv3Xrw7v5cGzxW4cdFpNiS6+i9YF/5jB
         oquA==
X-Gm-Message-State: AOAM532oIYnFjJhlDesnRKoucz1BbKKNapk0H0To3nuXvOHlf/pGbGsE
        7JKEBjfSsYaJ4EQNjdFYzbMKplbKa7U=
X-Google-Smtp-Source: ABdhPJzV/3DZdYAJAI5+8L8AbByCSsau43JRxY+7kyrIc8DRhDk0FitJLabgZPMW68d0IMS2B/BP0Q==
X-Received: by 2002:a17:902:7d96:b0:142:6a63:c1cd with SMTP id a22-20020a1709027d9600b001426a63c1cdmr81822994plm.88.1637379208682;
        Fri, 19 Nov 2021 19:33:28 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:a858])
        by smtp.gmail.com with ESMTPSA id lx15sm800579pjb.44.2021.11.19.19.33.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Nov 2021 19:33:28 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 bpf-next 11/13] selftests/bpf: Convert map_ptr_kern test to use light skeleton.
Date:   Fri, 19 Nov 2021 19:32:53 -0800
Message-Id: <20211120033255.91214-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
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
index 0c9f1837ece2..4fd040f5944b 100644
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

