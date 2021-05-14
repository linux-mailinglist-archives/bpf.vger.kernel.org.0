Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6139A38013E
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 02:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhENAiP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 20:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhENAiP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 20:38:15 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291B4C061574
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:37:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id y32so22814507pga.11
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZYq8QSGd4vPZ+7dnoLxzG0qO6UiIeqyrRaawGiLioCI=;
        b=n+FhY+kEeIleMvqXq54AeI2lN3JyOtdzzRb/wFDx3abMfRGBq++OeQlUvSDDSL1FYQ
         JNuEf4k9aW5kkdyr6/meUVy4fGAvhXP4bv5GhN/zsT5j9ZBs3u5PE7DuR1K+DCFz7EmD
         olc8hXnRWPZqAV/i7O8W7GbBY8fUWVfTZhUeP101TwqXjB7VleWg5HLOg0oSAffmpvV1
         wnWwh5dTvqQfkwk8WmeUdNrKV1RK+FQOV0PUSwUp0/azFqp5dglVhUV8GxGtxOnn3jFa
         eiA6JFsz8bTrcgKe9BHylVfY2He4zDi6Fe3jRFkeskkDqbtfFhsul+za9R1NjQtvHxZ5
         +9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZYq8QSGd4vPZ+7dnoLxzG0qO6UiIeqyrRaawGiLioCI=;
        b=XSkGJdccpJjUcfPBco9QrTblUXDwlhLkxuM2vKv8OguCvzgIjFuTifd0G2CjEP75Fu
         XWqvBDn8+3ndMfo9OaayhNTrcBCFSZDfYdHxYjeYlEKVra4wyY57ETQ3rrA+24K5ExqQ
         /Jx3mj6FWXqjpqULW8HM7XwC7kPWe4JIOF9mhvtyaejel2+dZu6brWMdBB25ANhSVJIm
         T08Bnwf184Ap9MM8Z4Ikf1dkF4oMxAyPg9soZVhsQi9pTtQouV8HjrMjRtlAjyle0aT2
         Y+Y0K0HAdMtzgLPvh3LgxWqHkcHeirv5Yv2Noi+IOmYnAOKtjGlfRM64474WIu1obpuQ
         EtMg==
X-Gm-Message-State: AOAM532U5n9bbbgdqHrBbj97zLCl6wa3aFpNsMeyz0Dqwg5XbrUTQrW4
        H55M0lVPo98PK0z4JjcbV38=
X-Google-Smtp-Source: ABdhPJwiQYLX5MDPxURJRvBkpat8FbDkJA97QRBg6w0jAFYlRc2UcrwZrLhqNDQx+Y2nN6HJOO6dfg==
X-Received: by 2002:a63:5b20:: with SMTP id p32mr42843974pgb.173.1620952624671;
        Thu, 13 May 2021 17:37:04 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id b9sm302336pfo.107.2021.05.13.17.37.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 May 2021 17:37:04 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 21/21] selftests/bpf: Convert test trace_printk to lskel.
Date:   Thu, 13 May 2021 17:36:23 -0700
Message-Id: <20210514003623.28033-22-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
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

