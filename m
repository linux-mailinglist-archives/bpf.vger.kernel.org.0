Return-Path: <bpf+bounces-47505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6DE9F9DC0
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 02:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E2F16639D
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 01:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8EE38DE9;
	Sat, 21 Dec 2024 01:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2cb+nCJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB4B282EE
	for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 01:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734744392; cv=none; b=lM5ij6tG8IA9okMQcCNi2hWJ0b6lj9vNRkYLyvs40VdaVhDDlC11wKmxMOR1VkO1GOJ4hcHbEWBaYDXRAePgbhLtqFPcTLEFAHRFAD3Im9sGebYGj3dLX4iaLUCAHEQbNzgIrnZXmFUYmQZYmaZpn0fp0xg1gAvYIwGdcwj/EL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734744392; c=relaxed/simple;
	bh=J0uIY6A8JDdMj0JP8IBJHPjr9rJz9TpI6m3buHqW2A4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kUYOLoRzWOt8Zu7cTO/hN9nLFEICHzpMcHw3/eip9trGo53/q/XmqIRh9tJwh1mrGLMOk4fCXis5Ktxw1znR78LQpvTahMFpV/wQjldmlBYWYDzG4FKjNx/4CEsNlYWZODLipjFgmQWr41anP5RlAilo0geevFskXsAqh4pCtcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l2cb+nCJ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-729046e1283so1675638b3a.1
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 17:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734744389; x=1735349189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VR7rs6YOw8kz1O0c5Uzbutq8ohP0Q1FipY0UTTgo7LE=;
        b=l2cb+nCJSik41QOImqI8GxGYRNfi/n/g2fus62qMU7mZVrR0BBzfhm9qk4ZyBGGqz7
         3BGG66HDRcaq8X3YfSufQwZDBiGVGiOPYA7RAFqShsBePjk+3pSBe8hvt0dobWL6bde9
         KzSrN733tpuqxH0lS2xCPEa7uHmdlq481mjoeWT8GYmE/5fLcnpmXim8RSlD+AqwN+YJ
         CvhY0f6vc7Fmgk1DbFODRV16tJvvObGi+qVbtVNbO8kCh4vDz+abCg68xnBleXMuS7ub
         9DJ6n8WTeenBukJsa4gzpxdvgJvsIUgf3Js1rsw7oySRbEadkd1ieynIHyzbcoPu0Fzo
         gHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734744389; x=1735349189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VR7rs6YOw8kz1O0c5Uzbutq8ohP0Q1FipY0UTTgo7LE=;
        b=mwkpVpGxTu3ID/7fQkuBTpM944iPK99QTtRtbZqFYO4ZCUJFpBRsmCG5q/pP87+zhE
         uXkP8ZPRJLuHEhLy4JEoNOf4bFmz8xG+2wgFobajKHVEr8B4CVR2zg8X/oIK4C7C32OU
         AfpmMuafqkQhZNPFClmEi/KYhGhYlKvXLuqE7nRxy5k57rew91GLRcJpcYiUyVohDeFg
         qJn4D3QV3wH8qNabI0YIVbj94r9hD71fx55LVBTwwfjx58O+F9ul/YEuoN1OfbzXy9n9
         tlvemsjHaa4yt1UrL+zAgGPqiPSJh1H6jolqLaqnH6aESQ6iDaXBXZZOMArxS9TOuyaC
         rNVA==
X-Gm-Message-State: AOJu0YzvQgWr3AXTa5ZuQStoydpEjtQi9mlv7Op62cfSgJ82k9M4bGa8
	6zezuRRyUnEGL9sU6PGKjW/vIqXpziUwQTvXEmgVGnDasRCbTP1KQ6u9mhA/z39+8hor/yXAogo
	WwSAjqszwBKgD+ITovfcbqamejRvrIiKMT2xUmm+zsi46v/zRRWS8w5Y2aAgJLnlBycjTfRAMqO
	qWwdl5cXQbw5uuDAy1C5/m6sfjtHR64HodMnPpUws=
X-Google-Smtp-Source: AGHT+IHGZp1lynJxLzXDf8EUHjWFT+6nZOfXQ5lWLeGO4NjDXJwuXl7Ffxd61IwVMu1NkWUgA5vbthCTJTEeJA==
X-Received: from pgab186.prod.google.com ([2002:a63:34c3:0:b0:7fd:4e21:2f5a])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:d045:b0:1e4:8fda:78ea with SMTP id adf61e73a8af0-1e5e08661eemr9682713637.46.1734744389307;
 Fri, 20 Dec 2024 17:26:29 -0800 (PST)
Date: Sat, 21 Dec 2024 01:26:13 +0000
In-Reply-To: <cover.1734742802.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1734742802.git.yepeilin@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <114f23ac20d73eeb624a9677e39a87b766f4bcc2.1734742802.git.yepeilin@google.com>
Subject: [PATCH RFC bpf-next v1 4/4] selftests/bpf: Add selftests for
 load-acquire and store-release instructions
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: Peilin Ye <yepeilin@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, 
	Neel Natu <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>, 
	David Vernet <dvernet@meta.com>, Dave Marchevsky <davemarchevsky@meta.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add the following ./test_progs tests:

  * atomics/load_acquire
  * atomics/store_release
  * arena_atomics/load_acquire
  * arena_atomics/store_release

They depend on the pre-defined __BPF_FEATURE_LOAD_ACQ_STORE_REL feature
macro, which implies -mcpu>=v4.

  $ ALLOWLIST=atomics/load_acquire,atomics/store_release,
  $ ALLOWLIST+=arena_atomics/load_acquire,arena_atomics/store_release

  $ ./test_progs-cpuv4 -a $ALLOWLIST

  #3/9     arena_atomics/load_acquire:OK
  #3/10    arena_atomics/store_release:OK
...
  #10/8    atomics/load_acquire:OK
  #10/9    atomics/store_release:OK

  $ ./test_progs -v -a $ALLOWLIST

  test_load_acquire:SKIP:Clang does not support BPF load-acquire or addr_space_cast
  #3/9     arena_atomics/load_acquire:SKIP
  test_store_release:SKIP:Clang does not support BPF store-release or addr_space_cast
  #3/10    arena_atomics/store_release:SKIP
...
  test_load_acquire:SKIP:Clang does not support BPF load-acquire
  #10/8    atomics/load_acquire:SKIP
  test_store_release:SKIP:Clang does not support BPF store-release
  #10/9    atomics/store_release:SKIP

Additionally, add several ./test_verifier tests:

  #65/u atomic BPF_LOAD_ACQ access through non-pointer  OK
  #65/p atomic BPF_LOAD_ACQ access through non-pointer  OK
  #66/u atomic BPF_STORE_REL access through non-pointer  OK
  #66/p atomic BPF_STORE_REL access through non-pointer  OK

  #67/u BPF_ATOMIC load-acquire, 8-bit OK
  #67/p BPF_ATOMIC load-acquire, 8-bit OK
  #68/u BPF_ATOMIC load-acquire, 16-bit OK
  #68/p BPF_ATOMIC load-acquire, 16-bit OK
  #69/u BPF_ATOMIC load-acquire, 32-bit OK
  #69/p BPF_ATOMIC load-acquire, 32-bit OK
  #70/u BPF_ATOMIC load-acquire, 64-bit OK
  #70/p BPF_ATOMIC load-acquire, 64-bit OK
  #71/u Cannot load-acquire from uninitialized src_reg OK
  #71/p Cannot load-acquire from uninitialized src_reg OK

  #76/u BPF_ATOMIC store-release, 8-bit OK
  #76/p BPF_ATOMIC store-release, 8-bit OK
  #77/u BPF_ATOMIC store-release, 16-bit OK
  #77/p BPF_ATOMIC store-release, 16-bit OK
  #78/u BPF_ATOMIC store-release, 32-bit OK
  #78/p BPF_ATOMIC store-release, 32-bit OK
  #79/u BPF_ATOMIC store-release, 64-bit OK
  #79/p BPF_ATOMIC store-release, 64-bit OK
  #80/u Cannot store-release from uninitialized src_reg OK
  #80/p Cannot store-release from uninitialized src_reg OK

Reviewed-by: Josh Don <joshdon@google.com>
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 include/linux/filter.h                        |  2 +
 .../selftests/bpf/prog_tests/arena_atomics.c  | 61 +++++++++++++++-
 .../selftests/bpf/prog_tests/atomics.c        | 57 ++++++++++++++-
 .../selftests/bpf/progs/arena_atomics.c       | 62 +++++++++++++++-
 tools/testing/selftests/bpf/progs/atomics.c   | 62 +++++++++++++++-
 .../selftests/bpf/verifier/atomic_invalid.c   | 26 +++----
 .../selftests/bpf/verifier/atomic_load.c      | 71 +++++++++++++++++++
 .../selftests/bpf/verifier/atomic_store.c     | 70 ++++++++++++++++++
 8 files changed, 393 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_load.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_store.c

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 0477254bc2d3..c264d723dc9e 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -364,6 +364,8 @@ static inline bool insn_is_cast_user(const struct bpf_insn *insn)
  *   BPF_XOR | BPF_FETCH      src_reg = atomic_fetch_xor(dst_reg + off16, src_reg);
  *   BPF_XCHG                 src_reg = atomic_xchg(dst_reg + off16, src_reg)
  *   BPF_CMPXCHG              r0 = atomic_cmpxchg(dst_reg + off16, r0, src_reg)
+ *   BPF_LOAD_ACQ             dst_reg = smp_load_acquire(src_reg + off16)
+ *   BPF_STORE_REL            smp_store_release(dst_reg + off16, src_reg)
  */
 
 #define BPF_ATOMIC_OP(SIZE, OP, DST, SRC, OFF)			\
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
diff --git a/tools/testing/selftests/bpf/verifier/atomic_invalid.c b/tools/testing/selftests/bpf/verifier/atomic_invalid.c
index 8c52ad682067..3f90d8f8a9c0 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_invalid.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_invalid.c
@@ -1,4 +1,4 @@
-#define __INVALID_ATOMIC_ACCESS_TEST(op)				\
+#define __INVALID_ATOMIC_ACCESS_TEST(op, reg)				\
 	{								\
 		"atomic " #op " access through non-pointer ",		\
 		.insns = {						\
@@ -9,15 +9,17 @@
 			BPF_EXIT_INSN(),				\
 		},							\
 		.result = REJECT,					\
-		.errstr = "R1 invalid mem access 'scalar'"		\
+		.errstr = #reg " invalid mem access 'scalar'"		\
 	}
-__INVALID_ATOMIC_ACCESS_TEST(BPF_ADD),
-__INVALID_ATOMIC_ACCESS_TEST(BPF_ADD | BPF_FETCH),
-__INVALID_ATOMIC_ACCESS_TEST(BPF_AND),
-__INVALID_ATOMIC_ACCESS_TEST(BPF_AND | BPF_FETCH),
-__INVALID_ATOMIC_ACCESS_TEST(BPF_OR),
-__INVALID_ATOMIC_ACCESS_TEST(BPF_OR | BPF_FETCH),
-__INVALID_ATOMIC_ACCESS_TEST(BPF_XOR),
-__INVALID_ATOMIC_ACCESS_TEST(BPF_XOR | BPF_FETCH),
-__INVALID_ATOMIC_ACCESS_TEST(BPF_XCHG),
-__INVALID_ATOMIC_ACCESS_TEST(BPF_CMPXCHG),
+__INVALID_ATOMIC_ACCESS_TEST(BPF_ADD, R1),
+__INVALID_ATOMIC_ACCESS_TEST(BPF_ADD | BPF_FETCH, R1),
+__INVALID_ATOMIC_ACCESS_TEST(BPF_AND, R1),
+__INVALID_ATOMIC_ACCESS_TEST(BPF_AND | BPF_FETCH, R1),
+__INVALID_ATOMIC_ACCESS_TEST(BPF_OR, R1),
+__INVALID_ATOMIC_ACCESS_TEST(BPF_OR | BPF_FETCH, R1),
+__INVALID_ATOMIC_ACCESS_TEST(BPF_XOR, R1),
+__INVALID_ATOMIC_ACCESS_TEST(BPF_XOR | BPF_FETCH, R1),
+__INVALID_ATOMIC_ACCESS_TEST(BPF_XCHG, R1),
+__INVALID_ATOMIC_ACCESS_TEST(BPF_CMPXCHG, R1),
+__INVALID_ATOMIC_ACCESS_TEST(BPF_LOAD_ACQ, R0),
+__INVALID_ATOMIC_ACCESS_TEST(BPF_STORE_REL, R1),
\ No newline at end of file
diff --git a/tools/testing/selftests/bpf/verifier/atomic_load.c b/tools/testing/selftests/bpf/verifier/atomic_load.c
new file mode 100644
index 000000000000..5186f71b6009
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/atomic_load.c
@@ -0,0 +1,71 @@
+{
+	"BPF_ATOMIC load-acquire, 8-bit",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		/* Write 1 to stack. */
+		BPF_ST_MEM(BPF_B, BPF_REG_10, -1, 0x12),
+		/* Load-acquire it from stack to R1. */
+		BPF_ATOMIC_OP(BPF_B, BPF_LOAD_ACQ, BPF_REG_1, BPF_REG_10, -1),
+		/* Check loaded value is 0x12. */
+		BPF_JMP32_IMM(BPF_JEQ, BPF_REG_1, 0x12, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"BPF_ATOMIC load-acquire, 16-bit",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		/* Write 0x1234 to stack. */
+		BPF_ST_MEM(BPF_H, BPF_REG_10, -2, 0x1234),
+		/* Load-acquire it from stack to R1. */
+		BPF_ATOMIC_OP(BPF_H, BPF_LOAD_ACQ, BPF_REG_1, BPF_REG_10, -2),
+		/* Check loaded value is 0x1234. */
+		BPF_JMP32_IMM(BPF_JEQ, BPF_REG_1, 0x1234, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"BPF_ATOMIC load-acquire, 32-bit",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		/* Write 0x12345678 to stack. */
+		BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0x12345678),
+		/* Load-acquire it from stack to R1. */
+		BPF_ATOMIC_OP(BPF_W, BPF_LOAD_ACQ, BPF_REG_1, BPF_REG_10, -4),
+		/* Check loaded value is 0x12345678. */
+		BPF_JMP32_IMM(BPF_JEQ, BPF_REG_1, 0x12345678, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"BPF_ATOMIC load-acquire, 64-bit",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		/* Save 0x1234567890abcdef to R1, then write it to stack. */
+		BPF_LD_IMM64(BPF_REG_1, 0x1234567890abcdef),
+		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+		/* Load-acquire it from stack to R2. */
+		BPF_ATOMIC_OP(BPF_DW, BPF_LOAD_ACQ, BPF_REG_2, BPF_REG_10, -8),
+		/* Check loaded value is 0x1234567890abcdef. */
+		BPF_JMP_REG(BPF_JEQ, BPF_REG_2, BPF_REG_1, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"Cannot load-acquire from uninitialized src_reg",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_ATOMIC_OP(BPF_DW, BPF_LOAD_ACQ, BPF_REG_1, BPF_REG_2, -8),
+		BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.errstr = "R2 !read_ok",
+},
diff --git a/tools/testing/selftests/bpf/verifier/atomic_store.c b/tools/testing/selftests/bpf/verifier/atomic_store.c
new file mode 100644
index 000000000000..23f2d5c46ea5
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/atomic_store.c
@@ -0,0 +1,70 @@
+{
+	"BPF_ATOMIC store-release, 8-bit",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		/* Store-release 0x12 to stack. */
+		BPF_MOV64_IMM(BPF_REG_1, 0x12),
+		BPF_ATOMIC_OP(BPF_B, BPF_STORE_REL, BPF_REG_10, BPF_REG_1, -1),
+		/* Check loaded value is 0x12. */
+		BPF_LDX_MEM(BPF_B, BPF_REG_2, BPF_REG_10, -1),
+		BPF_JMP32_REG(BPF_JEQ, BPF_REG_2, BPF_REG_1, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"BPF_ATOMIC store-release, 16-bit",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		/* Store-release 0x1234 to stack. */
+		BPF_MOV64_IMM(BPF_REG_1, 0x1234),
+		BPF_ATOMIC_OP(BPF_H, BPF_STORE_REL, BPF_REG_10, BPF_REG_1, -2),
+		/* Check loaded value is 0x1234. */
+		BPF_LDX_MEM(BPF_H, BPF_REG_2, BPF_REG_10, -2),
+		BPF_JMP32_REG(BPF_JEQ, BPF_REG_2, BPF_REG_1, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"BPF_ATOMIC store-release, 32-bit",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		/* Store-release 0x12345678 to stack. */
+		BPF_MOV64_IMM(BPF_REG_1, 0x12345678),
+		BPF_ATOMIC_OP(BPF_W, BPF_STORE_REL, BPF_REG_10, BPF_REG_1, -4),
+		/* Check loaded value is 0x12345678. */
+		BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_10, -4),
+		BPF_JMP32_REG(BPF_JEQ, BPF_REG_2, BPF_REG_1, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"BPF_ATOMIC store-release, 64-bit",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		/* Store-release 0x1234567890abcdef to stack. */
+		BPF_LD_IMM64(BPF_REG_1, 0x1234567890abcdef),
+		BPF_ATOMIC_OP(BPF_DW, BPF_STORE_REL, BPF_REG_10, BPF_REG_1, -8),
+		/* Check loaded value is 0x1234567890abcdef. */
+		BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_10, -8),
+		BPF_JMP_REG(BPF_JEQ, BPF_REG_2, BPF_REG_1, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"Cannot store-release with uninitialized src_reg",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_ATOMIC_OP(BPF_DW, BPF_STORE_REL, BPF_REG_10, BPF_REG_2, -8),
+		BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.errstr = "R2 !read_ok",
+},
-- 
2.47.1.613.gc27f4b7a9f-goog


