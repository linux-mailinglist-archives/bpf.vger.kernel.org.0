Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993024975F4
	for <lists+bpf@lfdr.de>; Sun, 23 Jan 2022 23:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbiAWWTx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Jan 2022 17:19:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240318AbiAWWTw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 23 Jan 2022 17:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642976392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rpD4RE3uS/46Az++QExWH/f6Mdi5HuK6/iaxYRMQJHA=;
        b=dQ0m/mu9AFMgaxEmWZzleagZ51xTTSbmvn1OzvIadX7dY86a9yLDbFPnbjdh48yyCUshlW
        MyuYKpydsH6BPWOyTSEt4Wdw4V7QhbC0uVZzHb2J4Qn7yIhTLXJCEs6cAgSPcO2YjKj/VH
        hIgYfISk6hMBw6t7S+ghVIlUcNLPMBU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-cnMu4qQDOr20mBDIaN0o9w-1; Sun, 23 Jan 2022 17:19:50 -0500
X-MC-Unique: cnMu4qQDOr20mBDIaN0o9w-1
Received: by mail-ed1-f69.google.com with SMTP id k10-20020a50cb8a000000b00403c8326f2aso11918794edi.6
        for <bpf@vger.kernel.org>; Sun, 23 Jan 2022 14:19:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rpD4RE3uS/46Az++QExWH/f6Mdi5HuK6/iaxYRMQJHA=;
        b=h2ApzHvSd3DH7fw/H72Ka7wXTSqkyrdKFv6AKV1fIt19TJnURoahn8cUEmMJCwdSlV
         dWih75kEDUi9iPhVDsqYoeOeum7GE03m89dUDP6OMmM3wPozqf7pwQILra3xM6MGVdHn
         Xxl2lu5pJygIocAVnJKjji518EgAgUiN3875qgmVnEpHO9QxKRHoGHLHiHzoWTrEGT7E
         p2uFyV8j24V09wFdd5qTglgmDun+BnL2HoI5ZDzaQWRiQ3Zu0ucrLcNqBAt4H6KHWTgY
         OImSFZPiXSiZpz37DLeQJWRqJeRjG4/flZvSfTc75C7Vcxs79bi+GpiioPuWIHWCCEyG
         F93A==
X-Gm-Message-State: AOAM532ZYh32IzFuY7W7XDmQVQVXJ4GblxSl7Tj0b4oJGOIvmpZTnTz8
        ttDwiDtxMonO2SboZbwXk+qTEF5UUpQtkKHuRUB/p5DjemacRJLaMAVzRyx0PGdn+J8nYJfzca1
        K3yHxdmdapHMa
X-Received: by 2002:aa7:dc15:: with SMTP id b21mr12996514edu.237.1642976389400;
        Sun, 23 Jan 2022 14:19:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwI802xOVZpySC1BV+0Pbb0Zp6jskKyQ40L/Z8mYLOOALNihv/wPD6GaoryEw9cZjEl0N/0ng==
X-Received: by 2002:aa7:dc15:: with SMTP id b21mr12996493edu.237.1642976389205;
        Sun, 23 Jan 2022 14:19:49 -0800 (PST)
Received: from krava.redhat.com ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id f19sm867305edu.22.2022.01.23.14.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 14:19:48 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Subject: [PATCH 3/3] perf tests: Remove bpf prologue generation test
Date:   Sun, 23 Jan 2022 23:19:32 +0100
Message-Id: <20220123221932.537060-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220123221932.537060-1-jolsa@kernel.org>
References: <20220123221932.537060-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Removing bpf prologue generation test, because its
support was removed in previous patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/Build  |  9 +-------
 tools/perf/tests/bpf.c  | 51 -----------------------------------------
 tools/perf/tests/llvm.c | 19 ---------------
 tools/perf/tests/llvm.h |  2 --
 4 files changed, 1 insertion(+), 80 deletions(-)

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index af2b37ef7c70..10a5287dbc94 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -36,7 +36,7 @@ perf-y += sample-parsing.o
 perf-y += parse-no-sample-id-all.o
 perf-y += kmod-path.o
 perf-y += thread-map.o
-perf-y += llvm.o llvm-src-base.o llvm-src-kbuild.o llvm-src-prologue.o llvm-src-relocation.o
+perf-y += llvm.o llvm-src-base.o llvm-src-kbuild.o llvm-src-relocation.o
 perf-y += bpf.o
 perf-y += topology.o
 perf-y += mem.o
@@ -81,13 +81,6 @@ $(OUTPUT)tests/llvm-src-kbuild.c: tests/bpf-script-test-kbuild.c tests/Build
 	$(Q)sed -e 's/"/\\"/g' -e 's/\(.*\)/"\1\\n"/g' $< >> $@
 	$(Q)echo ';' >> $@
 
-$(OUTPUT)tests/llvm-src-prologue.c: tests/bpf-script-test-prologue.c tests/Build
-	$(call rule_mkdir)
-	$(Q)echo '#include <tests/llvm.h>' > $@
-	$(Q)echo 'const char test_llvm__bpf_test_prologue_prog[] =' >> $@
-	$(Q)sed -e 's/"/\\"/g' -e 's/\(.*\)/"\1\\n"/g' $< >> $@
-	$(Q)echo ';' >> $@
-
 $(OUTPUT)tests/llvm-src-relocation.c: tests/bpf-script-test-relocation.c tests/Build
 	$(call rule_mkdir)
 	$(Q)echo '#include <tests/llvm.h>' > $@
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 573490530194..c7ade2debbbf 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -37,29 +37,6 @@ static int epoll_pwait_loop(void)
 	return 0;
 }
 
-#ifdef HAVE_BPF_PROLOGUE
-
-static int llseek_loop(void)
-{
-	int fds[2], i;
-
-	fds[0] = open("/dev/null", O_RDONLY);
-	fds[1] = open("/dev/null", O_RDWR);
-
-	if (fds[0] < 0 || fds[1] < 0)
-		return -1;
-
-	for (i = 0; i < NR_ITERS; i++) {
-		lseek(fds[i % 2], i, (i / 2) % 2 ? SEEK_CUR : SEEK_SET);
-		lseek(fds[(i + 1) % 2], i, (i / 2) % 2 ? SEEK_CUR : SEEK_SET);
-	}
-	close(fds[0]);
-	close(fds[1]);
-	return 0;
-}
-
-#endif
-
 static struct {
 	enum test_llvm__testcase prog_id;
 	const char *name;
@@ -86,16 +63,6 @@ static struct {
 		.expect_result	  = (NR_ITERS + 1) / 2,
 		.pin		  = true,
 	},
-#ifdef HAVE_BPF_PROLOGUE
-	{
-		.prog_id	  = LLVM_TESTCASE_BPF_PROLOGUE,
-		.name		  = "[bpf_prologue_test]",
-		.msg_compile_fail = "fix kbuild first",
-		.msg_load_fail	  = "check your vmlinux setting?",
-		.target_func	  = &llseek_loop,
-		.expect_result	  = (NR_ITERS + 1) / 4,
-	},
-#endif
 };
 
 static int do_test(struct bpf_object *obj, int (*func)(void),
@@ -355,31 +322,13 @@ static int test__bpf_pinning(struct test_suite *test __maybe_unused,
 #endif
 }
 
-static int test__bpf_prologue_test(struct test_suite *test __maybe_unused,
-				   int subtest __maybe_unused)
-{
-#if defined(HAVE_LIBBPF_SUPPORT) && defined(HAVE_BPF_PROLOGUE)
-	return test__bpf(2);
-#else
-	pr_debug("Skip BPF test because BPF support is not compiled\n");
-	return TEST_SKIP;
-#endif
-}
-
-
 static struct test_case bpf_tests[] = {
 #ifdef HAVE_LIBBPF_SUPPORT
 	TEST_CASE("Basic BPF filtering", basic_bpf_test),
 	TEST_CASE("BPF pinning", bpf_pinning),
-#ifdef HAVE_BPF_PROLOGUE
-	TEST_CASE("BPF prologue generation", bpf_prologue_test),
-#else
-	TEST_CASE_REASON("BPF prologue generation", bpf_prologue_test, "not compiled in"),
-#endif
 #else
 	TEST_CASE_REASON("Basic BPF filtering", basic_bpf_test, "not compiled in"),
 	TEST_CASE_REASON("BPF pinning", bpf_pinning, "not compiled in"),
-	TEST_CASE_REASON("BPF prologue generation", bpf_prologue_test, "not compiled in"),
 #endif
 	{ .name = NULL, }
 };
diff --git a/tools/perf/tests/llvm.c b/tools/perf/tests/llvm.c
index 8ac0a3a457ef..b57f24185dda 100644
--- a/tools/perf/tests/llvm.c
+++ b/tools/perf/tests/llvm.c
@@ -33,10 +33,6 @@ static struct {
 		.source = test_llvm__bpf_test_kbuild_prog,
 		.desc = "kbuild searching",
 	},
-	[LLVM_TESTCASE_BPF_PROLOGUE] = {
-		.source = test_llvm__bpf_test_prologue_prog,
-		.desc = "Compile source for BPF prologue generation",
-	},
 	[LLVM_TESTCASE_BPF_RELOCATION] = {
 		.source = test_llvm__bpf_test_relocation,
 		.desc = "Compile source for BPF relocation",
@@ -172,17 +168,6 @@ static int test__llvm__bpf_test_kbuild_prog(struct test_suite *test __maybe_unus
 #endif
 }
 
-static int test__llvm__bpf_test_prologue_prog(struct test_suite *test __maybe_unused,
-					      int subtest __maybe_unused)
-{
-#ifdef HAVE_LIBBPF_SUPPORT
-	return test__llvm(LLVM_TESTCASE_BPF_PROLOGUE);
-#else
-	pr_debug("Skip LLVM test because BPF support is not compiled\n");
-	return TEST_SKIP;
-#endif
-}
-
 static int test__llvm__bpf_test_relocation(struct test_suite *test __maybe_unused,
 					   int subtest __maybe_unused)
 {
@@ -199,14 +184,10 @@ static struct test_case llvm_tests[] = {
 #ifdef HAVE_LIBBPF_SUPPORT
 	TEST_CASE("Basic BPF llvm compile", llvm__bpf_base_prog),
 	TEST_CASE("kbuild searching", llvm__bpf_test_kbuild_prog),
-	TEST_CASE("Compile source for BPF prologue generation",
-		  llvm__bpf_test_prologue_prog),
 	TEST_CASE("Compile source for BPF relocation", llvm__bpf_test_relocation),
 #else
 	TEST_CASE_REASON("Basic BPF llvm compile", llvm__bpf_base_prog, "not compiled in"),
 	TEST_CASE_REASON("kbuild searching", llvm__bpf_test_kbuild_prog, "not compiled in"),
-	TEST_CASE_REASON("Compile source for BPF prologue generation",
-			llvm__bpf_test_prologue_prog, "not compiled in"),
 	TEST_CASE_REASON("Compile source for BPF relocation",
 			llvm__bpf_test_relocation, "not compiled in"),
 #endif
diff --git a/tools/perf/tests/llvm.h b/tools/perf/tests/llvm.h
index f68b0d9b8ae2..8e1c4352b1cc 100644
--- a/tools/perf/tests/llvm.h
+++ b/tools/perf/tests/llvm.h
@@ -11,13 +11,11 @@ extern "C" {
 
 extern const char test_llvm__bpf_base_prog[];
 extern const char test_llvm__bpf_test_kbuild_prog[];
-extern const char test_llvm__bpf_test_prologue_prog[];
 extern const char test_llvm__bpf_test_relocation[];
 
 enum test_llvm__testcase {
 	LLVM_TESTCASE_BASE,
 	LLVM_TESTCASE_KBUILD,
-	LLVM_TESTCASE_BPF_PROLOGUE,
 	LLVM_TESTCASE_BPF_RELOCATION,
 	__LLVM_TESTCASE_MAX,
 };
-- 
2.34.1

