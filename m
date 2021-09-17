Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA735410100
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 23:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244549AbhIQV7L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 17:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244153AbhIQV7L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 17:59:11 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95DBC061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:57:48 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 17so10881296pgp.4
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+4MUqUUAoYMJSrBhvzAduQ1/byk3PDzCXSpwhZzvGZ8=;
        b=lfnFp2E2MLB6jgwkz/ZN2IB6gHxVfCIs455JnvlJBk3bK8u/RYq5XMwL8t2clKjmrh
         3m1q8DanxeckY/8lDbA3V3ibrTILZuvecGzhjw+SGIjkzOhvlFjfu7nQwqd+/xd9Ucd/
         TTm79hJmKCPJWLXdq5XyKrBc3sklPw/D4dYfIA10jUyiTkFP34YcfyXT/d04w2bWnG5h
         svYgsDID0RkGRXrUH4E6iMPT406G9Y6LeZGgj2G9CpI0/GnR8uLaGdsclCfBHlmOR5XC
         ZWfCrvalzqUVSovT5MDwIKpqHhE+MvSG2njXJ7vFxAT9Fz7upUaw9vNnmp23nvlnh4DB
         LtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+4MUqUUAoYMJSrBhvzAduQ1/byk3PDzCXSpwhZzvGZ8=;
        b=Z3rSuS5ZVF+j+yBFG5zzegvAS1QWven0Lm+/DabFciEfmbPyceyzVyEQNWwZq7iiJV
         xfGeg37SDOlDXU9hem34h1onZygrdnf/DZ5W6zak9ItlCrv0/GFZPv0ToPuUvLjSl73+
         29UZxnofIGtLPzr7eYFtEDoQDQXXc3SXdVoyjvV8xyemDWcKPxJ0OgQH1cKWDh1o8N3F
         /kfy1w9LhDSaYmmfEooRpdvlraklpuNLMWv0uFqx5JPU5r4HujP12TSP++SBvpQLl0El
         ZLkLl+MOuCebvkRBeUAtb9esu20lJzkAB3cgqXElT/u7PXG+D3F7kSktjmGwYf+qTQRs
         TIZQ==
X-Gm-Message-State: AOAM531V3doA1+unsoQrSUWrnPktloXQ8/EAqZLjtKZEQbTILugPe2ev
        DJipTuB74PJl6XnakmD1u/8=
X-Google-Smtp-Source: ABdhPJzdX7Z+Wn+RhxslkAst3OyLbx2QwiHvnuHBIl84OP95LTp274+H//W3kj8h/eGn4AM5z7ywLA==
X-Received: by 2002:a63:d814:: with SMTP id b20mr11936567pgh.268.1631915868185;
        Fri, 17 Sep 2021 14:57:48 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:500::6:db29])
        by smtp.gmail.com with ESMTPSA id d4sm6809230pfv.21.2021.09.17.14.57.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Sep 2021 14:57:47 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        lmb@cloudflare.com, mcroce@microsoft.com, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH RFC bpf-next 08/10] selftests/bpf: Convert kfunc test with CO-RE to lskel.
Date:   Fri, 17 Sep 2021 14:57:19 -0700
Message-Id: <20210917215721.43491-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Convert kfunc_call_test_subprog to light skeleton.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile                | 2 +-
 tools/testing/selftests/bpf/prog_tests/kfunc_call.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 326ea75ce99e..81031c8bdcb8 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -316,7 +316,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 
 LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
 	test_ksyms_module.c test_ringbuf.c atomics.c trace_printk.c \
-	trace_vprintk.c
+	trace_vprintk.c	kfunc_call_test_subprog.c
 SKEL_BLACKLIST += $$(LSKELS)
 
 test_static_linked.skel.h-deps := test_static_linked1.o test_static_linked2.o
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
index 9611f2bc50df..01bd11f04dc6 100644
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
@@ -38,7 +38,7 @@ static void test_subprog(void)
 	if (!ASSERT_OK_PTR(skel, "skel"))
 		return;
 
-	prog_fd = bpf_program__fd(skel->progs.kfunc_call_test1);
+	prog_fd = skel->progs.kfunc_call_test1.prog_fd;
 	err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
 				NULL, NULL, (__u32 *)&retval, NULL);
 	ASSERT_OK(err, "bpf_prog_test_run(test1)");
-- 
2.30.2

