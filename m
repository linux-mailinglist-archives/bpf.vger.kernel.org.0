Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B20361DFEF
	for <lists+bpf@lfdr.de>; Sun,  6 Nov 2022 02:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiKFBv7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Nov 2022 21:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKFBv7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Nov 2022 21:51:59 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC840FD04
        for <bpf@vger.kernel.org>; Sat,  5 Nov 2022 18:51:57 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id q1so7536760pgl.11
        for <bpf@vger.kernel.org>; Sat, 05 Nov 2022 18:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmh+elQDTehLLKUG46zwdRnmaeeNegv9h+lNAEt+qYM=;
        b=SgFww6RaeHRFjdciQ9JZWTmlfSntpi5SHo9SMDze60TI9tTGYcbDjt7R84TZL5s7ke
         eRC+wIfRzgaIcKeRWWWTRW3IhHor0s/7ZiWy7L1QWLtiTC4vdqI1t2I2WQEjnZrmj8hI
         OhQ61pqafWts+z5y3IjJ75BX7t9eXV1DW0OiR6G3ZXjj2ST34eZpXrMyiutnm0vnsQto
         tHlrJO6S/R1y1q84V8FqyV4a+gJ2jfcGz6mIxJ5ebgx3uKyNO0JlB2+zwOjBOYGDm1EY
         W0rbfA2mb/hASXH2qv/+nEqGmxC7rLrUGO+x5yetpLVmD5Ct6ND+sN6o+TTZluGxIwdY
         gYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmh+elQDTehLLKUG46zwdRnmaeeNegv9h+lNAEt+qYM=;
        b=FBQt/Vzcta77WDM0wdoyeiTRJhKBRJERsDGs5TDG6z+FaaNEy196BXlZ1WpFuRkChG
         iBIbVgWwSXXqrJZ+ByP2KJCkPwK+RAJEOiz5cGSHNbfPf0pZY+MmwR5VmKs6kXQbrFcX
         3agsEDSxjBOcf89Tuk2DKmvpDqZWbIS7+VufWkOA7ELtTPQ4L62Ort3UcgnQpd/HoW0K
         pt3JbJFNsmytnOr/a+cG/3xbzoBU/ws4BCTa0IVRgUZAeRCZQFL1xbgD3rMDB/PyiRHn
         +sLWxfkhLl6N4twVGrvmTvXPeX3lyVe12uCVzO5+3IAY0wdUTK/6bQ9ahAGU5ZEDb0JO
         Qe1Q==
X-Gm-Message-State: ACrzQf2oJPz1enba9j6HEZTvGroAnvjeuA8I+FoKPJ0Zdl1HstxLDYL/
        aFKZ/sOSVWfC8bNwCJRJV7eL1yGLOdFmAQ==
X-Google-Smtp-Source: AMsMyM5SnC7X3ETYBLxVaNIUkvq8F99fwXU7nRiCbgxfLT2buyXOcNENDUd1qdrULBYYFylaCxNfnw==
X-Received: by 2002:a05:6a00:1309:b0:535:d421:1347 with SMTP id j9-20020a056a00130900b00535d4211347mr43398147pfu.5.1667699517200;
        Sat, 05 Nov 2022 18:51:57 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id y28-20020aa79afc000000b005627ddbc7a4sm1838827pfp.191.2022.11.05.18.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 18:51:56 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH RFC bpf-next v1 1/2] bpf: Fix deadlock for bpf_timer's spinlock
Date:   Sun,  6 Nov 2022 07:21:51 +0530
Message-Id: <20221106015152.2556188-2-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221106015152.2556188-1-memxor@gmail.com>
References: <20221106015152.2556188-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7574; i=memxor@gmail.com; h=from:subject; bh=U+R4WUIavV21NNeBZ8J/jRH45Yo6JYx9QHSuoaMgkjk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjZxJYAM3bVGwALTTLI+3kft0XTdp/wty6uIlshAI+ 7H77GfuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2cSWAAKCRBM4MiGSL8Ryl/hD/ wIM/kp+U1JpWYPSd1n85gLNE15E0HmldOrUi/LcDEv/Jq6+/msUwjNPDnu8KSgKOn+GXQKNDAMmWT8 zE8s0FzGjaLV7RpFb6YRgXruuENjjw6pclw+2GaA+32CGUzyzOtr+oCEtpsPQp/+ShaZc1k+1TDyGB mjZshAPBSAg06aKzKKcmHLSNgNxpUiWU3kTFGbP5GP5EdW8DysLZ3krMMNSzPtlXyKUqX1rwpRtnHA WZ83H4y0JRME/i0+SKJPPUVosWYPyN+Vg+XXdtkcpNTq3E8W7RziV6ZSM4W06zbNWRUhH5BPh/uCnd QCNQgdvgm5YpRwSpdOXfwkMYqjSGKZIeT59nzMdQ/xDAFPLVtyHIP7WcK2SxgW7Q4tuMgEiyiLVt7q PyI05YYjw/k93mYS4eKx++TevyELLvo0XBESui7SRi0QPo5Wbsl+S/tNbKQUxPV+YHVHNcGsx0cgsk P16xH3FELkudyRyvF71ECFRD1q43eYiDcA+5ZGFzgUtyo5NoIFTAJ9i38KeulVFc1wcULIfWf7JcwD hJ2sZVEAAOz4vnn1EOFrZXtno41S1Myhh8cDD8AH5oAsuStW3hvu+rEE2It9ZPk3z0LMm6w1kRItlj olgy5CF7syEuaZed/wvKA55GHuVw5JOUYPnQqD6Cy5JT4paU2HL0PwFww/Rg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, unlike other tracing program types, BPF_PROG_TYPE_TRACING is
excluded is_tracing_prog_type checks. This means that they can use maps
containing bpf_spin_lock, bpf_timer, etc. without verification failure.

However, allowing fentry/fexit programs to use maps that have such
bpf_timer in the map value can lead to deadlock.

Suppose that an fentry program is attached to bpf_prog_put, and a TC
program executes and does bpf_map_update_elem on an array map that both
progs share. If the fentry programs calls bpf_map_update_elem for the
same key, it will lead to acquiring of the same lock from within the
critical section protecting the timer.

The call chain is:

bpf_prog_test_run_opts() // TC
  bpf_prog_TC
    bpf_map_update_elem(array_map, key=0)
      bpf_obj_free_fields
        bpf_timer_cancel_and_free
	  __bpf_spin_lock_irqsave
	    drop_prog_refcnt
	      bpf_prog_put
	        bpf_prog_FENTRY // FENTRY
		  bpf_map_update_elem(array_map, key=0)
		    bpf_obj_free_fields
		      bpf_timer_cancel_and_free
		        __bpf_spin_lock_irqsave // DEADLOCK

BPF_TRACE_ITER attach type can be excluded because it always executes in
process context.

Update selftests using bpf_timer in fentry to TC as they will be broken
by this change.

Fixes: 5e0bc3082e2e ("bpf: Forbid bpf_ktime_get_coarse_ns and bpf_timer_* in tracing progs")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                         | 10 ++++++---
 .../testing/selftests/bpf/prog_tests/timer.c  | 21 ++++++++++++-------
 .../selftests/bpf/prog_tests/timer_crash.c    |  9 +++++++-
 tools/testing/selftests/bpf/progs/timer.c     |  8 +++----
 .../testing/selftests/bpf/progs/timer_crash.c |  4 ++--
 5 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d3b75aa0c54d..6e948c695e84 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12784,7 +12784,7 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 	return err;
 }
 
-static bool is_tracing_prog_type(enum bpf_prog_type type)
+static bool is_tracing_prog_type(enum bpf_prog_type type, enum bpf_attach_type eatype)
 {
 	switch (type) {
 	case BPF_PROG_TYPE_KPROBE:
@@ -12792,6 +12792,9 @@ static bool is_tracing_prog_type(enum bpf_prog_type type)
 	case BPF_PROG_TYPE_PERF_EVENT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
+	case BPF_PROG_TYPE_TRACING:
+		if (eatype == BPF_TRACE_ITER)
+			return false;
 		return true;
 	default:
 		return false;
@@ -12803,6 +12806,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 					struct bpf_prog *prog)
 
 {
+	enum bpf_attach_type eatype = env->prog->expected_attach_type;
 	enum bpf_prog_type prog_type = resolve_prog_type(prog);
 
 	if (btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
@@ -12811,7 +12815,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 			return -EINVAL;
 		}
 
-		if (is_tracing_prog_type(prog_type)) {
+		if (is_tracing_prog_type(prog_type, eatype)) {
 			verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
 			return -EINVAL;
 		}
@@ -12823,7 +12827,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 	}
 
 	if (btf_record_has_field(map->record, BPF_TIMER)) {
-		if (is_tracing_prog_type(prog_type)) {
+		if (is_tracing_prog_type(prog_type, eatype)) {
 			verbose(env, "tracing progs cannot use bpf_timer yet\n");
 			return -EINVAL;
 		}
diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index 7eb049214859..c0c39da12250 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -1,25 +1,30 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
 #include <test_progs.h>
+#include <network_helpers.h>
 #include "timer.skel.h"
 
 static int timer(struct timer *timer_skel)
 {
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1,
+	);
 	int err, prog_fd;
-	LIBBPF_OPTS(bpf_test_run_opts, topts);
-
-	err = timer__attach(timer_skel);
-	if (!ASSERT_OK(err, "timer_attach"))
-		return err;
 
 	ASSERT_EQ(timer_skel->data->callback_check, 52, "callback_check1");
 	ASSERT_EQ(timer_skel->data->callback2_check, 52, "callback2_check1");
 
 	prog_fd = bpf_program__fd(timer_skel->progs.test1);
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
-	ASSERT_OK(err, "test_run");
-	ASSERT_EQ(topts.retval, 0, "test_run");
-	timer__detach(timer_skel);
+	ASSERT_OK(err, "test_run test1");
+	ASSERT_EQ(topts.retval, 0, "test_run retval test1");
+
+	prog_fd = bpf_program__fd(timer_skel->progs.test2);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run test2");
+	ASSERT_EQ(topts.retval, 0, "test_run retval test2");
 
 	usleep(50); /* 10 usecs should be enough, but give it extra */
 	/* check that timer_cb1() was executed 10+10 times */
diff --git a/tools/testing/selftests/bpf/prog_tests/timer_crash.c b/tools/testing/selftests/bpf/prog_tests/timer_crash.c
index f74b82305da8..91f2333b92aa 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer_crash.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer_crash.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <network_helpers.h>
 #include "timer_crash.skel.h"
 
 enum {
@@ -9,6 +10,11 @@ enum {
 
 static void test_timer_crash_mode(int mode)
 {
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1,
+	);
 	struct timer_crash *skel;
 
 	skel = timer_crash__open_and_load();
@@ -18,7 +24,8 @@ static void test_timer_crash_mode(int mode)
 	skel->bss->crash_map = mode;
 	if (!ASSERT_OK(timer_crash__attach(skel), "timer_crash__attach"))
 		goto end;
-	usleep(1);
+	ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.timer), &topts), "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run retval");
 end:
 	timer_crash__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/timer.c b/tools/testing/selftests/bpf/progs/timer.c
index acda5c9cea93..492f62917898 100644
--- a/tools/testing/selftests/bpf/progs/timer.c
+++ b/tools/testing/selftests/bpf/progs/timer.c
@@ -119,8 +119,8 @@ static int timer_cb1(void *map, int *key, struct bpf_timer *timer)
 	return 0;
 }
 
-SEC("fentry/bpf_fentry_test1")
-int BPF_PROG2(test1, int, a)
+SEC("tc")
+int test1(void *ctx)
 {
 	struct bpf_timer *arr_timer, *lru_timer;
 	struct elem init = {};
@@ -235,8 +235,8 @@ int bpf_timer_test(void)
 	return 0;
 }
 
-SEC("fentry/bpf_fentry_test2")
-int BPF_PROG2(test2, int, a, int, b)
+SEC("tc")
+int test2(void *ctx)
 {
 	struct hmap_elem init = {}, *val;
 	int key = HTAB, key_malloc = HTAB_MALLOC;
diff --git a/tools/testing/selftests/bpf/progs/timer_crash.c b/tools/testing/selftests/bpf/progs/timer_crash.c
index f8f7944e70da..971eb93f485c 100644
--- a/tools/testing/selftests/bpf/progs/timer_crash.c
+++ b/tools/testing/selftests/bpf/progs/timer_crash.c
@@ -26,8 +26,8 @@ struct {
 int pid = 0;
 int crash_map = 0; /* 0 for amap, 1 for hmap */
 
-SEC("fentry/do_nanosleep")
-int sys_enter(void *ctx)
+SEC("tc")
+int timer(void *ctx)
 {
 	struct map_elem *e, value = {};
 	void *map = crash_map ? (void *)&hmap : (void *)&amap;
-- 
2.38.1

