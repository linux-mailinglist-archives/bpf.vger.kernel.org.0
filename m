Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A09E37EF3E
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 01:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbhELXAX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 19:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347008AbhELVpP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 17:45:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71898C08C5DE
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:34 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id v191so19667969pfc.8
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s4ss6/HcCJ5Ju4ENPKSJQ89spNpeg+tJcOBJeXI9Bx4=;
        b=l8YI2U594D/ztj+b9W+mEtWbnM2EtSoCFuSQDBt66Z8bGh4PjxB1Mwy3WWeHpuVYgC
         ocYQLiXRWFPsG2yXihBjnwfjVomw31Fv9trW5zfJsTSFfy6OWT4NxKCt9/BXbpBahPsM
         Vsn++Q2QNZCew0LxeMsAG5XkuN6v+veugff/PwbCkxPEReFZeZT2Y1sV4rEebJ3vZRL9
         CoCn89tGC4vslrqiJm6XQCe1crmtJ5mDLDxesdCY18TY1X4KtXaSRWn7l+nALnqogbf1
         kr1AvZ4Zevnv8WKFhLdMQ/BiIc634EFrJow45awCs2OS7vUip/b0APTNzFZNlBZndp5R
         nIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s4ss6/HcCJ5Ju4ENPKSJQ89spNpeg+tJcOBJeXI9Bx4=;
        b=ReYA0rolweOQgRJQ5H3dgRUzxDw/ypGZ3q9vW8sba77TryUW5oPS3kQCAN/h53E7ZA
         48RlceVek6THpnAKNkM/O659NiC/BlNCQ8OQjyogM9SGMFHIiu/psN4/OMHQQUVj1I5n
         5eFsvW19cX3ivn+n3xL4qZ5ZqEss4zlRQWlp8NwL3CFIYLBh7OSNopESs0hW1zQ/yJIh
         oXVZlPq2CDyxkFhEK5Nbx5v88NRGBhqWYFGOajMkiJURwV5z/eKLtFhzamoWv+gP6ZxL
         unxXDMlwVXm1WFC9aNYW0nK7v36gZ7Wco4h6zoegzdYFhLJhXIF4cjZeZwx0U0OGelcE
         VoQQ==
X-Gm-Message-State: AOAM530GxIbK4euEpn7gE4A9Fbix+Gswae7y/4IMMuDLudQcuKBDlRbs
        M+w/cSfTbNPlvAyzmg14pS8=
X-Google-Smtp-Source: ABdhPJwQaBWasc1vEk7XUlEpzCf1D+u37b/HUxuy/BhxJwCke4MnQDuMJX2DSpCGRTzi42siLqQmdw==
X-Received: by 2002:a17:90a:b283:: with SMTP id c3mr41011956pjr.31.1620855214015;
        Wed, 12 May 2021 14:33:34 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id c128sm609222pfa.189.2021.05.12.14.33.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 14:33:33 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 18/21] selftests/bpf: Convert few tests to light skeleton.
Date:   Wed, 12 May 2021 14:32:53 -0700
Message-Id: <20210512213256.31203-19-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
References: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Convert few tests that don't use CO-RE to light skeleton.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/.gitignore           |  1 +
 tools/testing/selftests/bpf/Makefile             | 16 +++++++++++++++-
 .../selftests/bpf/prog_tests/fentry_fexit.c      |  6 +++---
 .../selftests/bpf/prog_tests/fentry_test.c       | 10 +++++-----
 .../selftests/bpf/prog_tests/fexit_sleep.c       |  6 +++---
 .../selftests/bpf/prog_tests/fexit_test.c        | 10 +++++-----
 .../selftests/bpf/prog_tests/kfunc_call.c        |  6 +++---
 .../selftests/bpf/prog_tests/ksyms_module.c      |  2 +-
 tools/testing/selftests/bpf/prog_tests/ringbuf.c |  8 +++-----
 tools/testing/selftests/bpf/progs/test_ringbuf.c |  4 ++--
 10 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 4866f6a21901..a030aa4a8a9e 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -30,6 +30,7 @@ test_sysctl
 xdping
 test_cpp
 *.skel.h
+*.lskel.h
 /no_alu32
 /bpf_gcc
 /tools
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 511259c2c6c5..fdc7785ff82d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -312,6 +312,10 @@ SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
 LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h
 
+LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
+	test_ksyms_module.c test_ringbuf.c
+SKEL_BLACKLIST += $$(LSKELS)
+
 test_static_linked.skel.h-deps := test_static_linked1.o test_static_linked2.o
 linked_funcs.skel.h-deps := linked_funcs1.o linked_funcs2.o
 linked_vars.skel.h-deps := linked_vars1.o linked_vars2.o
@@ -339,6 +343,7 @@ TRUNNER_BPF_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o, $$(TRUNNER_BPF_SRCS)
 TRUNNER_BPF_SKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.skel.h,	\
 				 $$(filter-out $(SKEL_BLACKLIST) $(LINKED_BPF_SRCS),\
 					       $$(TRUNNER_BPF_SRCS)))
+TRUNNER_BPF_LSKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.lskel.h, $$(LSKELS))
 TRUNNER_BPF_SKELS_LINKED := $$(addprefix $$(TRUNNER_OUTPUT)/,$(LINKED_SKELS))
 TEST_GEN_FILES += $$(TRUNNER_BPF_OBJS)
 
@@ -380,6 +385,14 @@ $(TRUNNER_BPF_SKELS): %.skel.h: %.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$(Q)diff $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)
 	$(Q)$$(BPFTOOL) gen skeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.o=)) > $$@
 
+$(TRUNNER_BPF_LSKELS): %.lskel.h: %.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
+	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
+	$(Q)$$(BPFTOOL) gen object $$(<:.o=.linked1.o) $$<
+	$(Q)$$(BPFTOOL) gen object $$(<:.o=.linked2.o) $$(<:.o=.linked1.o)
+	$(Q)$$(BPFTOOL) gen object $$(<:.o=.linked3.o) $$(<:.o=.linked2.o)
+	$(Q)diff $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)
+	$(Q)$$(BPFTOOL) gen skeleton -L $$(<:.o=.linked3.o) name $$(notdir $$(<:.o=)) > $$@
+
 $(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_BPF_OBJS) $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$$(call msg,LINK-BPF,$(TRUNNER_BINARY),$$(@:.skel.h=.o))
 	$(Q)$$(BPFTOOL) gen object $$(@:.skel.h=.linked1.o) $$(addprefix $(TRUNNER_OUTPUT)/,$$($$(@F)-deps))
@@ -409,6 +422,7 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
 		      $(TRUNNER_EXTRA_HDRS)				\
 		      $(TRUNNER_BPF_OBJS)				\
 		      $(TRUNNER_BPF_SKELS)				\
+		      $(TRUNNER_BPF_LSKELS)				\
 		      $(TRUNNER_BPF_SKELS_LINKED)			\
 		      $$(BPFOBJ) | $(TRUNNER_OUTPUT)
 	$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
@@ -516,6 +530,6 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o $(OUTPUT)/testing_helpers.o \
 EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
 	feature								\
-	$(addprefix $(OUTPUT)/,*.o *.skel.h no_alu32 bpf_gcc bpf_testmod.ko)
+	$(addprefix $(OUTPUT)/,*.o *.skel.h *.lskel.h no_alu32 bpf_gcc bpf_testmod.ko)
 
 .PHONY: docs docs-clean
diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c b/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
index 109d0345a2be..91154c2ba256 100644
--- a/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
+++ b/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 Facebook */
 #include <test_progs.h>
-#include "fentry_test.skel.h"
-#include "fexit_test.skel.h"
+#include "fentry_test.lskel.h"
+#include "fexit_test.lskel.h"
 
 void test_fentry_fexit(void)
 {
@@ -26,7 +26,7 @@ void test_fentry_fexit(void)
 	if (CHECK(err, "fexit_attach", "fexit attach failed: %d\n", err))
 		goto close_prog;
 
-	prog_fd = bpf_program__fd(fexit_skel->progs.test1);
+	prog_fd = fexit_skel->progs.test1.prog_fd;
 	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
 				NULL, NULL, &retval, &duration);
 	CHECK(err || retval, "ipv6",
diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_test.c b/tools/testing/selftests/bpf/prog_tests/fentry_test.c
index 7cb111b11995..174c89e7456e 100644
--- a/tools/testing/selftests/bpf/prog_tests/fentry_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fentry_test.c
@@ -1,13 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 Facebook */
 #include <test_progs.h>
-#include "fentry_test.skel.h"
+#include "fentry_test.lskel.h"
 
 static int fentry_test(struct fentry_test *fentry_skel)
 {
 	int err, prog_fd, i;
 	__u32 duration = 0, retval;
-	struct bpf_link *link;
+	int link_fd;
 	__u64 *result;
 
 	err = fentry_test__attach(fentry_skel);
@@ -15,11 +15,11 @@ static int fentry_test(struct fentry_test *fentry_skel)
 		return err;
 
 	/* Check that already linked program can't be attached again. */
-	link = bpf_program__attach(fentry_skel->progs.test1);
-	if (!ASSERT_ERR_PTR(link, "fentry_attach_link"))
+	link_fd = fentry_test__test1__attach(fentry_skel);
+	if (!ASSERT_LT(link_fd, 0, "fentry_attach_link"))
 		return -1;
 
-	prog_fd = bpf_program__fd(fentry_skel->progs.test1);
+	prog_fd = fentry_skel->progs.test1.prog_fd;
 	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
 				NULL, NULL, &retval, &duration);
 	ASSERT_OK(err, "test_run");
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_sleep.c b/tools/testing/selftests/bpf/prog_tests/fexit_sleep.c
index ccc7e8a34ab6..4e7f4b42ea29 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_sleep.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_sleep.c
@@ -6,7 +6,7 @@
 #include <time.h>
 #include <sys/mman.h>
 #include <sys/syscall.h>
-#include "fexit_sleep.skel.h"
+#include "fexit_sleep.lskel.h"
 
 static int do_sleep(void *skel)
 {
@@ -58,8 +58,8 @@ void test_fexit_sleep(void)
 	 * waiting for percpu_ref_kill to confirm). The other one
 	 * will be freed quickly.
 	 */
-	close(bpf_program__fd(fexit_skel->progs.nanosleep_fentry));
-	close(bpf_program__fd(fexit_skel->progs.nanosleep_fexit));
+	close(fexit_skel->progs.nanosleep_fentry.prog_fd);
+	close(fexit_skel->progs.nanosleep_fexit.prog_fd);
 	fexit_sleep__detach(fexit_skel);
 
 	/* kill the thread to unwind sys_nanosleep stack through the trampoline */
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_test.c b/tools/testing/selftests/bpf/prog_tests/fexit_test.c
index 6792e41f7f69..af3dba726701 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_test.c
@@ -1,13 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 Facebook */
 #include <test_progs.h>
-#include "fexit_test.skel.h"
+#include "fexit_test.lskel.h"
 
 static int fexit_test(struct fexit_test *fexit_skel)
 {
 	int err, prog_fd, i;
 	__u32 duration = 0, retval;
-	struct bpf_link *link;
+	int link_fd;
 	__u64 *result;
 
 	err = fexit_test__attach(fexit_skel);
@@ -15,11 +15,11 @@ static int fexit_test(struct fexit_test *fexit_skel)
 		return err;
 
 	/* Check that already linked program can't be attached again. */
-	link = bpf_program__attach(fexit_skel->progs.test1);
-	if (!ASSERT_ERR_PTR(link, "fexit_attach_link"))
+	link_fd = fexit_test__test1__attach(fexit_skel);
+	if (!ASSERT_LT(link_fd, 0, "fexit_attach_link"))
 		return -1;
 
-	prog_fd = bpf_program__fd(fexit_skel->progs.test1);
+	prog_fd = fexit_skel->progs.test1.prog_fd;
 	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
 				NULL, NULL, &retval, &duration);
 	ASSERT_OK(err, "test_run");
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
index 7fc0951ee75f..30a7b9b837bf 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -2,7 +2,7 @@
 /* Copyright (c) 2021 Facebook */
 #include <test_progs.h>
 #include <network_helpers.h>
-#include "kfunc_call_test.skel.h"
+#include "kfunc_call_test.lskel.h"
 #include "kfunc_call_test_subprog.skel.h"
 
 static void test_main(void)
@@ -14,13 +14,13 @@ static void test_main(void)
 	if (!ASSERT_OK_PTR(skel, "skel"))
 		return;
 
-	prog_fd = bpf_program__fd(skel->progs.kfunc_call_test1);
+	prog_fd = skel->progs.kfunc_call_test1.prog_fd;
 	err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
 				NULL, NULL, (__u32 *)&retval, NULL);
 	ASSERT_OK(err, "bpf_prog_test_run(test1)");
 	ASSERT_EQ(retval, 12, "test1-retval");
 
-	prog_fd = bpf_program__fd(skel->progs.kfunc_call_test2);
+	prog_fd = skel->progs.kfunc_call_test2.prog_fd;
 	err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
 				NULL, NULL, (__u32 *)&retval, NULL);
 	ASSERT_OK(err, "bpf_prog_test_run(test2)");
diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms_module.c b/tools/testing/selftests/bpf/prog_tests/ksyms_module.c
index 4c232b456479..2cd5cded543f 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksyms_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksyms_module.c
@@ -4,7 +4,7 @@
 #include <test_progs.h>
 #include <bpf/libbpf.h>
 #include <bpf/btf.h>
-#include "test_ksyms_module.skel.h"
+#include "test_ksyms_module.lskel.h"
 
 static int duration;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index de78617f6550..80c11ac0ffb1 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -12,7 +12,7 @@
 #include <sys/sysinfo.h>
 #include <linux/perf_event.h>
 #include <linux/ring_buffer.h>
-#include "test_ringbuf.skel.h"
+#include "test_ringbuf.lskel.h"
 
 #define EDONE 7777
 
@@ -93,9 +93,7 @@ void test_ringbuf(void)
 	if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
 		return;
 
-	err = bpf_map__set_max_entries(skel->maps.ringbuf, page_size);
-	if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
-		goto cleanup;
+	skel->maps.ringbuf.max_entries = page_size;
 
 	err = test_ringbuf__load(skel);
 	if (CHECK(err != 0, "skel_load", "skeleton load failed\n"))
@@ -104,7 +102,7 @@ void test_ringbuf(void)
 	/* only trigger BPF program for current process */
 	skel->bss->pid = getpid();
 
-	ringbuf = ring_buffer__new(bpf_map__fd(skel->maps.ringbuf),
+	ringbuf = ring_buffer__new(skel->maps.ringbuf.map_fd,
 				   process_sample, NULL, NULL);
 	if (CHECK(!ringbuf, "ringbuf_create", "failed to create ringbuf\n"))
 		goto cleanup;
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf.c b/tools/testing/selftests/bpf/progs/test_ringbuf.c
index 6b3f288b7c63..eaa7d9dba0be 100644
--- a/tools/testing/selftests/bpf/progs/test_ringbuf.c
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf.c
@@ -35,7 +35,7 @@ long prod_pos = 0;
 /* inner state */
 long seq = 0;
 
-SEC("tp/syscalls/sys_enter_getpgid")
+SEC("fentry/__x64_sys_getpgid")
 int test_ringbuf(void *ctx)
 {
 	int cur_pid = bpf_get_current_pid_tgid() >> 32;
@@ -48,7 +48,7 @@ int test_ringbuf(void *ctx)
 	sample = bpf_ringbuf_reserve(&ringbuf, sizeof(*sample), 0);
 	if (!sample) {
 		__sync_fetch_and_add(&dropped, 1);
-		return 1;
+		return 0;
 	}
 
 	sample->pid = pid;
-- 
2.30.2

