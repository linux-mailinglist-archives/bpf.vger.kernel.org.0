Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B3B45B425
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 07:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhKXGF6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 01:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbhKXGF5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 01:05:57 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB121C061574
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:48 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso1670128pjb.0
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EM57a3c4C0+gbX6SEdRULPw3rSjjYeNwfaqSyMKFhvw=;
        b=K2thLXGKEQoIUVHzBM7RnzoqJRRtf587YjN2+tXKfVTF2GmmBXVvq+nLSnpXskRbLS
         Fp/QpxIqeEGbi6/o6TBawMWo8nTMuL7UR1bNOyoNNAMzJqeZB6usVQfZ1p5xKKSspCTb
         o3yC/WSUOGRPKyiwmpxaY7hSRitVnMSfeCVFMP8u4mq/Y61p8nzVXgOoiP0yyx2KWBxl
         f2SsUnZxokrG1nwSbfH5sQKNr/b2uW7j84j3/sS87ySAp/ZbThQz0gz3H1/8ZGD7KVID
         cVeppuSCfU/1/N1CkFybC35T5eaDZLHd4t2cQ6Y+DgFLgGhl2MqVHetlvw2uIExSFr8A
         ikOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EM57a3c4C0+gbX6SEdRULPw3rSjjYeNwfaqSyMKFhvw=;
        b=3JwNDV8NYvXrsF9HA6cZoAH0AsVJbWMft6CPHsU94QVQqzTc4Q5a8WQpaGJR3/fJYM
         w/kue5XdKk6E0NTX/2ndlCR2ja0pSMf8LGQigr9i+C7/0qeClnhPF2sZs5eT+iigxZMs
         iTVnutPn7ZHiFBShPXs0FX5MRT9PICeh4Ouozkdq81FLYRPXL9+Z2YiS+9LCWbepqHcO
         Y6SO2Pw3tEfLqT4aOdHC2w2FLT0Fh7obM/yeIdPbE4F8RuHrrdgxlyxapZ6eaHez3bHn
         nMJIeMZGqTwa2KR6HnI9WxvlH4KPnnk+q7jjr9TRtYVS0k6mU/EOF+KfreEPNYfnfaWr
         kwBg==
X-Gm-Message-State: AOAM532tF9Jb0HO7DGpzUf4TUQuS3HwtYlGkq2iSMvi/VeqW4/r3zuTA
        VeJMGZoRDr+vZkJIVZWNh5ErboMAzmk=
X-Google-Smtp-Source: ABdhPJxI45sED00+gVajeIfbsUyXwZR+LunuEwh+S5+XlGsiIxr+alYzMbe1Ix6lGS4rU9VIazjEtA==
X-Received: by 2002:a17:90a:d49:: with SMTP id 9mr12112157pju.115.1637733768294;
        Tue, 23 Nov 2021 22:02:48 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:8fd1])
        by smtp.gmail.com with ESMTPSA id l6sm5774554pfc.51.2021.11.23.22.02.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Nov 2021 22:02:47 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 bpf-next 13/16] selftests/bpf: Convert map_ptr_kern test to use light skeleton.
Date:   Tue, 23 Nov 2021 22:02:06 -0800
Message-Id: <20211124060209.493-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211124060209.493-1-alexei.starovoitov@gmail.com>
References: <20211124060209.493-1-alexei.starovoitov@gmail.com>
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

