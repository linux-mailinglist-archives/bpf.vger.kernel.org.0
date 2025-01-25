Return-Path: <bpf+bounces-49751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F00A1C071
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 03:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC0A3AE138
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 02:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2209D204689;
	Sat, 25 Jan 2025 02:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N6pAa0WP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAE21FBCB5
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 02:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737771578; cv=none; b=boJGbBVr7y9ni0NY5c6p8epA8TL/9vNQFaBpKpW8TTUs2X4zG9SSdFWjOxEFsw8ggR+qy2qZuX7QGl3YX+rwxYQCVh3mgj3dFER/HjVC91a01k6A6fpsIY3yAnU8DXnEPKgIyqQ19V7+H+uzmbz7ngq9SF+S9ykYe4KIgUJpNJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737771578; c=relaxed/simple;
	bh=LimUoi+FuxUWEB5grkneFv7gxwV1h7mQgMdnYeNS3nM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o/WgLDQDUAxzKb+0PULdbetl4pZ9+shDige1KWZGFFH579LT7encV+ugYzyTNTGF5Mau0aTpkXf9EZe/Ox/H0LBeFSrNBVld6WVgx3JDNX28UJUMHO63Zhq+Tdh+W8c01M0PFOCN67FytUIvyP2B2Teda0BtKqOE2lgEF7tw6MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N6pAa0WP; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee8ced572eso5566038a91.0
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 18:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737771576; x=1738376376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TUVtAh3jk+1Z9FYL8oOTJSugJD98SnZKa+Q8sEqs79Q=;
        b=N6pAa0WP7TxijnwGyTA+z/qqQG8zHNtpt4WpJalWEHed2tur/NRniBvWvP0eNJxY/T
         +EHuM/3A6BMfwtj1PYr79ppXbepeDchdoNLYbtWM839jlWIBUKBW2vg7Z//zl3z3BHGV
         +lw586Ifc56yV2/z18BawCXq9Ph+sruzmsvTo4E/zK8Fdr/9QM30ln5qZ0Mg2lJ6BLqi
         dBzlUX8rmq+FTE1gTsUkDCdiY/OCDgOHXDB3RrQMTnq3bogMeFXKbqsRopgJB9lR6C1s
         ivGULYLrQQi1Bk5M010k07McZFFfKLdz906C280ysSgY9SrowF0svy8m0Cy3QgjrOHuR
         wq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737771576; x=1738376376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TUVtAh3jk+1Z9FYL8oOTJSugJD98SnZKa+Q8sEqs79Q=;
        b=aT2qaW+kLBCH3VvZbRaBnWEgzn0gC3VCW3r/GWQ5f7ra9qCLz5bf5oVKVC2x9yEKqF
         1dxm33Mzb3emJXQk7OdM+QQfZncyT+1BTGdJnY0VjboAkX+RaKCiFrrNsqPT9Wjlcbwu
         1QTpIY6kweWjexZEs0+jzTNgu8PchIQsX/X0V03N4Xm2XOzgL/jFXwj8PnpIV+h5f9cw
         /ISHDxPeAWfT7z3xH6SrMcLmS2oMreSKfZ32izMuIzLmzchG0OuPX/p00jVsOj6k6s5F
         4emQGmSCqxGvmgL/Xum/3/rx7cYzwU21LfeEtS1s0Dx/f71mjwVqieNhJ+FJ18PO3d3Y
         LY3w==
X-Gm-Message-State: AOJu0Ywhxj+LwkmR5GRwbNHxMR7greWkUoreMBK1Otyx7bDK9GXmsZKV
	V5TGm9pVDrZXhApd8J7hdv90KjctW2MPXmJvo4BvWv66VTXhFAUPru+UlhwnIDr7zVXKwI+VhD2
	N3K9U5mmEOiEQEBdCh8VVsHfslzHcMZ4Xh3MbB083jIKJqbyMYDEmpq2s9Be8hVi0euPdkh9vBE
	TfJYOFfbl/supGLrr6FLCK6zRFeo4racp9WdMttN4=
X-Google-Smtp-Source: AGHT+IF5/7KDUnK2hWYlKFk6TCuy51i/bgTYYOR6pwVpRa8Y8ICyfmquFNa7v3yriLE2ixCD8VdqiMqRbmEGkg==
X-Received: from pfbcg8.prod.google.com ([2002:a05:6a00:2908:b0:725:d8bc:33e1])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:6812:b0:72d:b36a:4497 with SMTP id d2e1a72fcca58-72db36a45eemr40542229b3a.3.1737771575436;
 Fri, 24 Jan 2025 18:19:35 -0800 (PST)
Date: Sat, 25 Jan 2025 02:19:30 +0000
In-Reply-To: <cover.1737763916.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1737763916.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <3f2de7c6e5d2def7bdfb091347c1dacea0915974.1737763916.git.yepeilin@google.com>
Subject: [PATCH bpf-next v1 7/8] selftests/bpf: Add selftests for load-acquire
 and store-release instructions
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, David Vernet <void@manifault.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add several ./test_progs tests:

  - atomics/load_acquire
  - atomics/store_release
  - arena_atomics/load_acquire
  - arena_atomics/store_release
  - verifier_load_acquire/*
  - verifier_store_release/*
  - verifier_precision/bpf_load_acquire
  - verifier_precision/bpf_store_release

The last two tests are added to check if backtrack_insn() handles the
new instructions correctly.

Additionally, the last test also makes sure that the verifier
"remembers" the value (in src_reg) we store-release into e.g. a stack
slot.  For example, if we take a look at the test program:

    #0:  "r1 = 8;"
    #1:  "store_release((u64 *)(r10 - 8), r1);"
    #2:  "r1 = *(u64 *)(r10 - 8);"
    #3:  "r2 = r10;"
    #4:  "r2 += r1;"	/* mark_precise */
    #5:  "r0 = 0;"
    #6:  "exit;"

At #1, if the verifier doesn't remember that we wrote 8 to the stack,
then later at #4 we would be adding an unbounded scalar value to the
stack pointer, which would cause the program to be rejected:

  VERIFIER LOG:
  =============
...
  math between fp pointer and register with unbounded min value is not allowed

All new tests depend on the pre-defined __BPF_FEATURE_LOAD_ACQ_STORE_REL
feature macro, which implies -mcpu>=v4.

Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 .../selftests/bpf/prog_tests/arena_atomics.c  |  61 ++++++-
 .../selftests/bpf/prog_tests/atomics.c        |  57 ++++++-
 .../selftests/bpf/prog_tests/verifier.c       |   4 +
 .../selftests/bpf/progs/arena_atomics.c       |  62 ++++++-
 tools/testing/selftests/bpf/progs/atomics.c   |  62 ++++++-
 .../bpf/progs/verifier_load_acquire.c         |  92 +++++++++++
 .../selftests/bpf/progs/verifier_precision.c  |  39 +++++
 .../bpf/progs/verifier_store_release.c        | 153 ++++++++++++++++++
 8 files changed, 524 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_load_acquire.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_store_release.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
index 26e7c06c6cb4..81d3575d7652 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
@@ -162,6 +162,60 @@ static void test_uaf(struct arena_atomics *skel)
 	ASSERT_EQ(skel->arena->uaf_recovery_fails, 0, "uaf_recovery_fails");
 }
 
+static void test_load_acquire(struct arena_atomics *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	if (skel->data->skip_lacq_srel_tests) {
+		printf("%s:SKIP:Clang does not support BPF load-acquire or addr_space_cast\n",
+		       __func__);
+		test__skip();
+		return;
+	}
+
+	/* No need to attach it, just run it directly */
+	prog_fd = bpf_program__fd(skel->progs.load_acquire);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return;
+
+	ASSERT_EQ(skel->arena->load_acquire8_result, 0x12, "load_acquire8_result");
+	ASSERT_EQ(skel->arena->load_acquire16_result, 0x1234, "load_acquire16_result");
+	ASSERT_EQ(skel->arena->load_acquire32_result, 0x12345678, "load_acquire32_result");
+	ASSERT_EQ(skel->arena->load_acquire64_result, 0x1234567890abcdef,
+		  "load_acquire64_result");
+}
+
+static void test_store_release(struct arena_atomics *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	if (skel->data->skip_lacq_srel_tests) {
+		printf("%s:SKIP:Clang does not support BPF store-release or addr_space_cast\n",
+		       __func__);
+		test__skip();
+		return;
+	}
+
+	/* No need to attach it, just run it directly */
+	prog_fd = bpf_program__fd(skel->progs.store_release);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return;
+
+	ASSERT_EQ(skel->arena->store_release8_result, 0x12, "store_release8_result");
+	ASSERT_EQ(skel->arena->store_release16_result, 0x1234, "store_release16_result");
+	ASSERT_EQ(skel->arena->store_release32_result, 0x12345678, "store_release32_result");
+	ASSERT_EQ(skel->arena->store_release64_result, 0x1234567890abcdef,
+		  "store_release64_result");
+}
+
 void test_arena_atomics(void)
 {
 	struct arena_atomics *skel;
@@ -171,7 +225,7 @@ void test_arena_atomics(void)
 	if (!ASSERT_OK_PTR(skel, "arena atomics skeleton open"))
 		return;
 
-	if (skel->data->skip_tests) {
+	if (skel->data->skip_all_tests) {
 		printf("%s:SKIP:no ENABLE_ATOMICS_TESTS or no addr_space_cast support in clang",
 		       __func__);
 		test__skip();
@@ -199,6 +253,11 @@ void test_arena_atomics(void)
 	if (test__start_subtest("uaf"))
 		test_uaf(skel);
 
+	if (test__start_subtest("load_acquire"))
+		test_load_acquire(skel);
+	if (test__start_subtest("store_release"))
+		test_store_release(skel);
+
 cleanup:
 	arena_atomics__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/atomics.c b/tools/testing/selftests/bpf/prog_tests/atomics.c
index 13e101f370a1..5d7cff3eed2b 100644
--- a/tools/testing/selftests/bpf/prog_tests/atomics.c
+++ b/tools/testing/selftests/bpf/prog_tests/atomics.c
@@ -162,6 +162,56 @@ static void test_xchg(struct atomics_lskel *skel)
 	ASSERT_EQ(skel->bss->xchg32_result, 1, "xchg32_result");
 }
 
+static void test_load_acquire(struct atomics_lskel *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	if (skel->data->skip_lacq_srel_tests) {
+		printf("%s:SKIP:Clang does not support BPF load-acquire\n", __func__);
+		test__skip();
+		return;
+	}
+
+	/* No need to attach it, just run it directly */
+	prog_fd = skel->progs.load_acquire.prog_fd;
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return;
+
+	ASSERT_EQ(skel->bss->load_acquire8_result, 0x12, "load_acquire8_result");
+	ASSERT_EQ(skel->bss->load_acquire16_result, 0x1234, "load_acquire16_result");
+	ASSERT_EQ(skel->bss->load_acquire32_result, 0x12345678, "load_acquire32_result");
+	ASSERT_EQ(skel->bss->load_acquire64_result, 0x1234567890abcdef, "load_acquire64_result");
+}
+
+static void test_store_release(struct atomics_lskel *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	if (skel->data->skip_lacq_srel_tests) {
+		printf("%s:SKIP:Clang does not support BPF store-release\n", __func__);
+		test__skip();
+		return;
+	}
+
+	/* No need to attach it, just run it directly */
+	prog_fd = skel->progs.store_release.prog_fd;
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return;
+
+	ASSERT_EQ(skel->bss->store_release8_result, 0x12, "store_release8_result");
+	ASSERT_EQ(skel->bss->store_release16_result, 0x1234, "store_release16_result");
+	ASSERT_EQ(skel->bss->store_release32_result, 0x12345678, "store_release32_result");
+	ASSERT_EQ(skel->bss->store_release64_result, 0x1234567890abcdef, "store_release64_result");
+}
+
 void test_atomics(void)
 {
 	struct atomics_lskel *skel;
@@ -170,7 +220,7 @@ void test_atomics(void)
 	if (!ASSERT_OK_PTR(skel, "atomics skeleton load"))
 		return;
 
-	if (skel->data->skip_tests) {
+	if (skel->data->skip_all_tests) {
 		printf("%s:SKIP:no ENABLE_ATOMICS_TESTS (missing Clang BPF atomics support)",
 		       __func__);
 		test__skip();
@@ -193,6 +243,11 @@ void test_atomics(void)
 	if (test__start_subtest("xchg"))
 		test_xchg(skel);
 
+	if (test__start_subtest("load_acquire"))
+		test_load_acquire(skel);
+	if (test__start_subtest("store_release"))
+		test_store_release(skel);
+
 cleanup:
 	atomics_lskel__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 8a0e1ff8a2dc..8bdad4167cf5 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -45,6 +45,7 @@
 #include "verifier_ldsx.skel.h"
 #include "verifier_leak_ptr.skel.h"
 #include "verifier_linked_scalars.skel.h"
+#include "verifier_load_acquire.skel.h"
 #include "verifier_loops1.skel.h"
 #include "verifier_lwt.skel.h"
 #include "verifier_map_in_map.skel.h"
@@ -80,6 +81,7 @@
 #include "verifier_spill_fill.skel.h"
 #include "verifier_spin_lock.skel.h"
 #include "verifier_stack_ptr.skel.h"
+#include "verifier_store_release.skel.h"
 #include "verifier_subprog_precision.skel.h"
 #include "verifier_subreg.skel.h"
 #include "verifier_tailcall_jit.skel.h"
@@ -173,6 +175,7 @@ void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
 void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_callbacks); }
 void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null); }
 void test_verifier_jit_convergence(void)      { RUN(verifier_jit_convergence); }
+void test_verifier_load_acquire(void)	      { RUN(verifier_load_acquire); }
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
 void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }
 void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); }
@@ -211,6 +214,7 @@ void test_verifier_sockmap_mutate(void)       { RUN(verifier_sockmap_mutate); }
 void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill); }
 void test_verifier_spin_lock(void)            { RUN(verifier_spin_lock); }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
+void test_verifier_store_release(void)	      { RUN(verifier_store_release); }
 void test_verifier_subprog_precision(void)    { RUN(verifier_subprog_precision); }
 void test_verifier_subreg(void)               { RUN(verifier_subreg); }
 void test_verifier_tailcall_jit(void)         { RUN(verifier_tailcall_jit); }
diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c b/tools/testing/selftests/bpf/progs/arena_atomics.c
index 40dd57fca5cc..fe8b67d9c87b 100644
--- a/tools/testing/selftests/bpf/progs/arena_atomics.c
+++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
@@ -19,9 +19,15 @@ struct {
 } arena SEC(".maps");
 
 #if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CAST)
-bool skip_tests __attribute((__section__(".data"))) = false;
+bool skip_all_tests __attribute((__section__(".data"))) = false;
 #else
-bool skip_tests = true;
+bool skip_all_tests = true;
+#endif
+
+#if defined(__BPF_FEATURE_LOAD_ACQ_STORE_REL) && defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+bool skip_lacq_srel_tests __attribute((__section__(".data"))) = false;
+#else
+bool skip_lacq_srel_tests = true;
 #endif
 
 __u32 pid = 0;
@@ -274,4 +280,56 @@ int uaf(const void *ctx)
 	return 0;
 }
 
+__u8 __arena_global load_acquire8_value = 0x12;
+__u16 __arena_global load_acquire16_value = 0x1234;
+__u32 __arena_global load_acquire32_value = 0x12345678;
+__u64 __arena_global load_acquire64_value = 0x1234567890abcdef;
+
+__u8 __arena_global load_acquire8_result = 0;
+__u16 __arena_global load_acquire16_result = 0;
+__u32 __arena_global load_acquire32_result = 0;
+__u64 __arena_global load_acquire64_result = 0;
+
+SEC("raw_tp/sys_enter")
+int load_acquire(const void *ctx)
+{
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+#ifdef __BPF_FEATURE_LOAD_ACQ_STORE_REL
+	load_acquire8_result = __atomic_load_n(&load_acquire8_value, __ATOMIC_ACQUIRE);
+	load_acquire16_result = __atomic_load_n(&load_acquire16_value, __ATOMIC_ACQUIRE);
+	load_acquire32_result = __atomic_load_n(&load_acquire32_value, __ATOMIC_ACQUIRE);
+	load_acquire64_result = __atomic_load_n(&load_acquire64_value, __ATOMIC_ACQUIRE);
+#endif
+
+	return 0;
+}
+
+__u8 __arena_global store_release8_result = 0;
+__u16 __arena_global store_release16_result = 0;
+__u32 __arena_global store_release32_result = 0;
+__u64 __arena_global store_release64_result = 0;
+
+SEC("raw_tp/sys_enter")
+int store_release(const void *ctx)
+{
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+#ifdef __BPF_FEATURE_LOAD_ACQ_STORE_REL
+	__u8 val8 = 0x12;
+	__u16 val16 = 0x1234;
+	__u32 val32 = 0x12345678;
+	__u64 val64 = 0x1234567890abcdef;
+
+	__atomic_store_n(&store_release8_result, val8, __ATOMIC_RELEASE);
+	__atomic_store_n(&store_release16_result, val16, __ATOMIC_RELEASE);
+	__atomic_store_n(&store_release32_result, val32, __ATOMIC_RELEASE);
+	__atomic_store_n(&store_release64_result, val64, __ATOMIC_RELEASE);
+#endif
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/atomics.c b/tools/testing/selftests/bpf/progs/atomics.c
index f89c7f0cc53b..4c23d7d0d37d 100644
--- a/tools/testing/selftests/bpf/progs/atomics.c
+++ b/tools/testing/selftests/bpf/progs/atomics.c
@@ -5,9 +5,15 @@
 #include <stdbool.h>
 
 #ifdef ENABLE_ATOMICS_TESTS
-bool skip_tests __attribute((__section__(".data"))) = false;
+bool skip_all_tests __attribute((__section__(".data"))) = false;
 #else
-bool skip_tests = true;
+bool skip_all_tests = true;
+#endif
+
+#ifdef __BPF_FEATURE_LOAD_ACQ_STORE_REL
+bool skip_lacq_srel_tests __attribute((__section__(".data"))) = false;
+#else
+bool skip_lacq_srel_tests = true;
 #endif
 
 __u32 pid = 0;
@@ -168,3 +174,55 @@ int xchg(const void *ctx)
 
 	return 0;
 }
+
+__u8 load_acquire8_value = 0x12;
+__u16 load_acquire16_value = 0x1234;
+__u32 load_acquire32_value = 0x12345678;
+__u64 load_acquire64_value = 0x1234567890abcdef;
+
+__u8 load_acquire8_result = 0;
+__u16 load_acquire16_result = 0;
+__u32 load_acquire32_result = 0;
+__u64 load_acquire64_result = 0;
+
+SEC("raw_tp/sys_enter")
+int load_acquire(const void *ctx)
+{
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+#ifdef __BPF_FEATURE_LOAD_ACQ_STORE_REL
+	load_acquire8_result = __atomic_load_n(&load_acquire8_value, __ATOMIC_ACQUIRE);
+	load_acquire16_result = __atomic_load_n(&load_acquire16_value, __ATOMIC_ACQUIRE);
+	load_acquire32_result = __atomic_load_n(&load_acquire32_value, __ATOMIC_ACQUIRE);
+	load_acquire64_result = __atomic_load_n(&load_acquire64_value, __ATOMIC_ACQUIRE);
+#endif
+
+	return 0;
+}
+
+__u8 store_release8_result = 0;
+__u16 store_release16_result = 0;
+__u32 store_release32_result = 0;
+__u64 store_release64_result = 0;
+
+SEC("raw_tp/sys_enter")
+int store_release(const void *ctx)
+{
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+#ifdef __BPF_FEATURE_LOAD_ACQ_STORE_REL
+	__u8 val8 = 0x12;
+	__u16 val16 = 0x1234;
+	__u32 val32 = 0x12345678;
+	__u64 val64 = 0x1234567890abcdef;
+
+	__atomic_store_n(&store_release8_result, val8, __ATOMIC_RELEASE);
+	__atomic_store_n(&store_release16_result, val16, __ATOMIC_RELEASE);
+	__atomic_store_n(&store_release32_result, val32, __ATOMIC_RELEASE);
+	__atomic_store_n(&store_release64_result, val64, __ATOMIC_RELEASE);
+#endif
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
new file mode 100644
index 000000000000..506df4b8231b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#if defined(__TARGET_ARCH_arm64) && defined(__BPF_FEATURE_LOAD_ACQ_STORE_REL)
+
+SEC("socket")
+__description("load-acquire, 8-bit")
+__success __success_unpriv __retval(0x12)
+__naked void load_acquire_8(void)
+{
+	asm volatile (
+	"*(u8 *)(r10 - 1) = 0x12;"
+	"w0 = load_acquire((u8 *)(r10 - 1));"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__description("load-acquire, 16-bit")
+__success __success_unpriv __retval(0x1234)
+__naked void load_acquire_16(void)
+{
+	asm volatile (
+	"*(u16 *)(r10 - 2) = 0x1234;"
+	"w0 = load_acquire((u16 *)(r10 - 2));"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__description("load-acquire, 32-bit")
+__success __success_unpriv __retval(0x12345678)
+__naked void load_acquire_32(void)
+{
+	asm volatile (
+	"*(u32 *)(r10 - 4) = 0x12345678;"
+	"w0 = load_acquire((u32 *)(r10 - 4));"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__description("load-acquire, 64-bit")
+__success __success_unpriv __retval(0x1234567890abcdef)
+__naked void load_acquire_64(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) = 0x1234567890abcdef;"
+	"r0 = load_acquire((u64 *)(r10 - 8));"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__description("load-acquire with uninitialized src_reg")
+__failure __failure_unpriv __msg("R2 !read_ok")
+__naked void load_acquire_with_uninitialized_src_reg(void)
+{
+	asm volatile (
+	"r0 = load_acquire((u64 *)(r2 + 0));"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__description("load-acquire with non-pointer src_reg")
+__failure __failure_unpriv __msg("R1 invalid mem access 'scalar'")
+__naked void load_acquire_with_non_pointer_src_reg(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"r0 = load_acquire((u64 *)(r1 + 0));"
+	"exit;"
+	::: __clobber_all);
+}
+
+#else
+
+SEC("socket")
+__description("load-acquire is not supported by compiler or jit, use a dummy test")
+__success
+int dummy_test(void)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
index 6b564d4c0986..7d5b9e95e3cf 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -90,6 +90,45 @@ __naked int bpf_end_bswap(void)
 		::: __clobber_all);
 }
 
+#if defined(__TARGET_ARCH_arm64) && defined(__BPF_FEATURE_LOAD_ACQ_STORE_REL)
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("mark_precise: frame0: regs=r1 stack= before 2: (bf) r2 = r10")
+__msg("mark_precise: frame0: regs=r1 stack= before 1: (db) r1 = load_acquire((u64 *)(r10 -8))")
+__msg("mark_precise: frame0: regs= stack=-8 before 0: (7a) *(u64 *)(r10 -8) = 8")
+__naked int bpf_load_acquire(void)
+{
+	asm volatile (
+		"*(u64 *)(r10 - 8) = 8;"
+		"r1 = load_acquire((u64 *)(r10 - 8));"
+		"r2 = r10;"
+		"r2 += r1;"	/* mark_precise */
+		"r0 = 0;"
+		"exit;"
+		::: __clobber_all);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("mark_precise: frame0: regs=r1 stack= before 3: (bf) r2 = r10")
+__msg("mark_precise: frame0: regs=r1 stack= before 2: (79) r1 = *(u64 *)(r10 -8)")
+__msg("mark_precise: frame0: regs= stack=-8 before 1: (db) store_release((u64 *)(r10 -8), r1)")
+__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__naked int bpf_store_release(void)
+{
+	asm volatile (
+		"r1 = 8;"
+		"store_release((u64 *)(r10 - 8), r1);"
+		"r1 = *(u64 *)(r10 - 8);"
+		"r2 = r10;"
+		"r2 += r1;"	/* mark_precise */
+		"r0 = 0;"
+		"exit;"
+		::: __clobber_all);
+}
+
+#endif /* load-acquire, store-release */
 #endif /* v4 instruction */
 
 SEC("?raw_tp")
diff --git a/tools/testing/selftests/bpf/progs/verifier_store_release.c b/tools/testing/selftests/bpf/progs/verifier_store_release.c
new file mode 100644
index 000000000000..d8c3b73388cb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_store_release.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#if defined(__TARGET_ARCH_arm64) && defined(__BPF_FEATURE_LOAD_ACQ_STORE_REL)
+
+SEC("socket")
+__description("store-release, 8-bit")
+__success __success_unpriv __retval(0x12)
+__naked void store_release_8(void)
+{
+	asm volatile (
+	"w1 = 0x12;"
+	"store_release((u8 *)(r10 - 1), w1);"
+	"w0 = *(u8 *)(r10 - 1);"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__description("store-release, 16-bit")
+__success __success_unpriv __retval(0x1234)
+__naked void store_release_16(void)
+{
+	asm volatile (
+	"w1 = 0x1234;"
+	"store_release((u16 *)(r10 - 2), w1);"
+	"w0 = *(u16 *)(r10 - 2);"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__description("store-release, 32-bit")
+__success __success_unpriv __retval(0x12345678)
+__naked void store_release_32(void)
+{
+	asm volatile (
+	"w1 = 0x12345678;"
+	"store_release((u32 *)(r10 - 4), w1);"
+	"w0 = *(u32 *)(r10 - 4);"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__description("store-release, 64-bit")
+__success __success_unpriv __retval(0x1234567890abcdef)
+__naked void store_release_64(void)
+{
+	asm volatile (
+	"r1 = 0x1234567890abcdef;"
+	"store_release((u64 *)(r10 - 8), r1);"
+	"r0 = *(u64 *)(r10 - 8);"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__description("store-release with uninitialized src_reg")
+__failure __failure_unpriv __msg("R2 !read_ok")
+__naked void store_release_with_uninitialized_src_reg(void)
+{
+	asm volatile (
+	"store_release((u64 *)(r10 - 8), r2);"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__description("store-release with uninitialized dst_reg")
+__failure __failure_unpriv __msg("R2 !read_ok")
+__naked void store_release_with_uninitialized_dst_reg(void)
+{
+	asm volatile (
+	"r1 = 0x1234567890abcdef;"
+	"store_release((u64 *)(r2 - 8), r1);"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__description("store-release with non-pointer dst_reg")
+__failure __failure_unpriv __msg("R1 invalid mem access 'scalar'")
+__naked void store_release_with_non_pointer_dst_reg(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"store_release((u64 *)(r1 + 0), r1);"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__description("store-release, leak pointer to stack")
+__success __retval(0)
+__failure_unpriv __msg_unpriv("R1 leaks addr into mem")
+__naked void store_release_leak_pointer_to_stack(void)
+{
+	asm volatile (
+	"store_release((u64 *)(r10 - 8), r1);"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, long long);
+} map_hash_8b SEC(".maps");
+
+SEC("socket")
+__description("store-release, leak pointer to map")
+__success __retval(0)
+__failure_unpriv __msg_unpriv("R6 leaks addr into mem")
+__naked void store_release_leak_pointer_to_map(void)
+{
+	asm volatile (
+	"r6 = r1;"
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"r1 = %[map_hash_8b] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto l0_%=;"
+	"store_release((u64 *)(r0 + 0), r6);"
+"l0_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+#else
+
+SEC("socket")
+__description("store-release is not supported by compiler or jit, use a dummy test")
+__success
+int dummy_test(void)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") = "GPL";
-- 
2.48.1.262.g85cc9f2d1e-goog


