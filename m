Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB66444E143
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 06:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhKLFFx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 00:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhKLFFw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 00:05:52 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8842CC061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:03:02 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so5399472pjb.5
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=54ORrARFsahTBDlxa7s7H2kjkxMQaBJwUb7VYBm9zbA=;
        b=mQP9m8+YvFRV0h853iNgRZhTCuc5hSAKmn+YwgTd0nIBzRk0ryKcJUsq9rtftTfHUf
         mt/rW8FW57PHSyXzSQNbGGRZBKjkf+pp7sdWlVkeTDqeo77BbBEnwaVt13OkaPVDVMIQ
         9qvUKPQMRgxP8rBd/qKJwvNpcZxIG2wwV/7WHtMdvFwlEPIdLCGWJ/Lh66g1VklN1tyl
         tEqaH4HKWCngaPPlgaNJpeBaXzM6ztYD4Q8/lysj20Zc300uv0RErxBjlE3D09MpTiKa
         kRSAI8cg55Rqtw+I0SDV3HAa8kc5iO3q5JRG8EjNVNZJC0z+D1SBfyPQK+ECrBoWkO6J
         KLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=54ORrARFsahTBDlxa7s7H2kjkxMQaBJwUb7VYBm9zbA=;
        b=AyHQgyP4K5489QF5JcoYnrIeMO+Xq/dDByw8NaRJCJ2fqQX0M/stRtjNxZBxRDktjD
         0/WJx7+k/3hi6a5qSJBS0my3NQU8U/sVD6kFItxoJpU2aDdDDQxQN0sR5gH2hL9atZ2v
         1I3ltZPaVoV/EtdaFi8Mz2FznUOJJ/to7MZacxggPdBTdTwYyFsx2Q+hzPxLF37Fw37B
         N29EEs28663reAiXhVARmr6YBixdz1mWnejgRJCclrZmDHv9LSpuQlc6mhPcadL3iofl
         QAg6NPRraKVyxBOYbpEBMNZowRs14caZ382qe7W4M0013Sn/2zPdEMncmDnookNRbIAB
         rxVg==
X-Gm-Message-State: AOAM530hD8qZ3Q08P4OtoKcole7ovsIFwcb3DaPpQrz+K3Dpc/zhOz0M
        awrRmDBb3QuCZ3s9G9xS0s66QMoq6w4=
X-Google-Smtp-Source: ABdhPJxeJ/tY9zY4qQh7cW+YWzZkGKRVYG4h52+IH4tXl9mS2rf90x6ZsTRI+seLvCpp18eC5XYP1w==
X-Received: by 2002:a17:90a:a083:: with SMTP id r3mr32339903pjp.55.1636693382049;
        Thu, 11 Nov 2021 21:03:02 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:3dc4])
        by smtp.gmail.com with ESMTPSA id w5sm3496278pgp.79.2021.11.11.21.03.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Nov 2021 21:03:01 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 bpf-next 11/12] selftests/bpf: Convert map_ptr_kern test to use light skeleton.
Date:   Thu, 11 Nov 2021 21:02:29 -0800
Message-Id: <20211112050230.85640-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
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
 tools/testing/selftests/bpf/Makefile             |  2 +-
 tools/testing/selftests/bpf/prog_tests/map_ptr.c | 16 +++++++---------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 811c5e150aa9..539a70b3b770 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -326,7 +326,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 
 LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
 	test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c \
-	kfunc_call_test_subprog.c
+	kfunc_call_test_subprog.c map_ptr_kern.c
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c
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

