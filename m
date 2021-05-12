Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8022537EF4B
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 01:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346899AbhELXEL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 19:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347129AbhELVpY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 17:45:24 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48CBC08C5E1
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:39 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id e19so1463525pfv.3
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZYq8QSGd4vPZ+7dnoLxzG0qO6UiIeqyrRaawGiLioCI=;
        b=XbOHspSD7mJLVx4TuNUIeL25SHw0jxKgOmB9p7OnM/DTgE5XMrFKrSg/BR+wBqDrqJ
         8fDV06X+TDv3RH60B81ZWzZlz81es1MFQ5sFrKbHIr1X1OagptQvqjPaXU/t0NsW5eOa
         gNMQN1kz79fYKIdZjv0qPOLm1NGHpymcO9iwkCMnqmFjbIjqLRuEwr0S7b0aTwoYR6Yh
         eFAt2D5sEVmNtF20JMaCHD6rzoRWzzBZxIJWccqhfrTVTh1SWAHaP/+yaB3BEXE7jzNP
         gIih2u0s3ggG1yd1kKzqSqB3nAVeW73nigrGuzakZQ+0TgOX5U6/YqQ5K/YT5YpWiiRi
         9rYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZYq8QSGd4vPZ+7dnoLxzG0qO6UiIeqyrRaawGiLioCI=;
        b=dbqdPVMZ/scr8JDIj4LhCQCVQnllmv6dB/4AoqHU3dMACBmEeAYkza9xNSiqG/HqZw
         y794x83wBJtJX6Nj80CifD0YVoXCeVOKNlA6Oa4tWqN60WjcyLus4Ig+RlXyC9Z9Rl84
         do/TQ+/u/1IhTAlL+ghD3qUkGwcnqm1sm5I/zEZmSlpLL9Yu1hD29OqnrM+pGyWivQ5C
         rlKtwFN3iErJh4pLpX5JeONRAvJpd93CsuPSPg4ccTRS6CFFsvtffbuU7eVNadOJZbfZ
         IfKiG6OT/yU9PXq28y2JePHE3gnSLVAaZNeD8MTOl/cdVaMoHTYnm9ete85qQbSxb7sG
         DKCA==
X-Gm-Message-State: AOAM532LXKXfB7dSHXse165sB/8NJne8cqhA7E48j1KC9hx+hN96D8OB
        zK02s9d61ZzZolX8LtPb29E=
X-Google-Smtp-Source: ABdhPJxtEE+pfxrGtrsmYnJAL22/oTzsPNWoijf/M0jrorAPP2k43y7mieNX4pTpk05HThMwyzOYNw==
X-Received: by 2002:a17:90a:b945:: with SMTP id f5mr42369634pjw.233.1620855219423;
        Wed, 12 May 2021 14:33:39 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id c128sm609222pfa.189.2021.05.12.14.33.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 14:33:38 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 21/21] selftests/bpf: Convert test trace_printk to lskel.
Date:   Wed, 12 May 2021 14:32:56 -0700
Message-Id: <20210512213256.31203-22-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
References: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Convert test trace_printk to light skeleton to check
rodata support in lskel.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile                  | 2 +-
 tools/testing/selftests/bpf/prog_tests/trace_printk.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b29862339222..525e4b3fb514 100644
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
index 2c641bdf21ca..d39bc00feb45 100644
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

