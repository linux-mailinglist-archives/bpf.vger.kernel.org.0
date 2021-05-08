Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AA3376F47
	for <lists+bpf@lfdr.de>; Sat,  8 May 2021 05:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhEHDuX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 May 2021 23:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhEHDuX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 May 2021 23:50:23 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA82C061761
        for <bpf@vger.kernel.org>; Fri,  7 May 2021 20:49:21 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id i13so9386074pfu.2
        for <bpf@vger.kernel.org>; Fri, 07 May 2021 20:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zxPHvkEvgEDaR2TrDa228MMqgxEhIF+gTHbwPvP7qCg=;
        b=jHwryWcSA0W3jtm+0L5/gcpohrICrq8/pUoOW2BaxzGM6z0dKy1I/SFBXO8wChDIf0
         11drwy3xABo5XHnYsZb069WHdyix3t2Izxec+TP28V+cvfXDWDh3LgWAbVbV/4jt4g8n
         jZ9xFNk0jNPIvearN1NOsFE6ioiwM57GRJ74mdmV86mZ3J4teAw6W+raKDsmTNIeCVOx
         eKjUhXgFbMi3E1PxwPaVW6Ss91NSIjhpjSHyEbTLnR4CCUOEJdIjWD4s2PcBYgdlsjTv
         3/PbAVJFgKr+Wo9/F5s1gd/OHLrE99wP7ErHOoImKR30NPSLpCAlUBCcCs6AP5/156QC
         bCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zxPHvkEvgEDaR2TrDa228MMqgxEhIF+gTHbwPvP7qCg=;
        b=P6J3XK3RhBjDL2v//bufbEYnZtzjNOdWY2qKMErAlt1XNbM3I1m+cpkMjnA7RgxScG
         Muslm+y1/03Mghmwv6A/Jza+vXyxQIFBgLtjrTriImPuRJkvQk2TrreVqX/z33GNuOTZ
         btquKD5mgUg6+oKJ803z8jjApOcr35rvNNrE1kI7zAiCOnYSiScdicZS3A8DhXq8Me6P
         yY69wli1FiB4dlBddNAYvw0Gmfkr1KX4gOhNae8zIRkHDWN/tL/wslq9+mUce6+UsBCh
         /mGFbwM9FsO5mK71Due7KmveoKBZMUCj/hI7aHVG/D1Yvtu7p1JS330gi4/8BwVfnoUP
         sU2g==
X-Gm-Message-State: AOAM532B945dqdXMkWJCtF0ymJ1AvS3TdM5iw6rexGS/oh2E82Edosey
        bhfD5AW+WQNCbwaXkvEpKR8=
X-Google-Smtp-Source: ABdhPJyvGCV7uByRTtUlUatlmTU/MLMQ76PQgSYIUWGtXx1QT4jk27PbmICCrHCsbOUbKQA8dG/j+w==
X-Received: by 2002:a63:e918:: with SMTP id i24mr13593485pgh.118.1620445761422;
        Fri, 07 May 2021 20:49:21 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.1])
        by smtp.gmail.com with ESMTPSA id u12sm5784606pfh.122.2021.05.07.20.49.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 20:49:20 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 22/22] selftests/bpf: Convert test trace_printk to lskel.
Date:   Fri,  7 May 2021 20:48:37 -0700
Message-Id: <20210508034837.64585-23-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Convert test trace_printk to light skeleton to check
rodata support in lskel.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile                  | 2 +-
 tools/testing/selftests/bpf/prog_tests/trace_printk.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 4f50e4367e42..8d252238b005 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -313,7 +313,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h
 
 LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
-	test_ksyms_module.c test_ringbuf.c atomics.c
+	test_ksyms_module.c test_ringbuf.c atomics.c trace_printk.c
 SKEL_BLACKLIST += $$(LSKELS)
 
 test_static_linked.skel.h-deps := test_static_linked1.o test_static_linked2.o
diff --git a/tools/testing/selftests/bpf/prog_tests/trace_printk.c b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
index 60c2347a3181..e67268e929bd 100644
--- a/tools/testing/selftests/bpf/prog_tests/trace_printk.c
+++ b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
@@ -3,7 +3,7 @@
 
 #include <test_progs.h>
 
-#include "trace_printk.skel.h"
+#include "trace_printk.lskel.h"
 
 #define TRACEBUF	"/sys/kernel/debug/tracing/trace_pipe"
 #define SEARCHMSG	"testing,testing"
-- 
2.30.2

