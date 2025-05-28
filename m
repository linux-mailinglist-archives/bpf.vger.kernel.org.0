Return-Path: <bpf+bounces-59114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 396FEAC6080
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9A41893970
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E63221557;
	Wed, 28 May 2025 03:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPQCK9uV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC234221277;
	Wed, 28 May 2025 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404233; cv=none; b=Z90eO4r8gQqIt9CzVPun90A8PPtfT/2d/Kf1/5JDNG7zGgTriCR93kezybo2gueRmQZX77BeM7QYMYtKeYL2tlJJxSUsnX9Y+CjHY6zHmxdSl32tn1j79D7rUPn0aYwzkv7+rpevPifKDr+tCyTo78B3VMwUe3VQ4TlTzAsZD1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404233; c=relaxed/simple;
	bh=rciDrG8G6L4Dh6dkq2H8+0cYFsdIDFcdIk/SXzFy2Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hKQ1aLovyIqpPXRNtRR6T0KXUWGa3UYyP2E3JhUNsJDGIazCO3vnTqDKWt/O5vAQsoDkK0nP6CE1PWO1Lb2IQPErZjwZzcylGoXEWb4JOnTTEehBTZa2FbwN7enVUYJpI6vVWAtZZQ19ml07FisP1qoBKLomQQRT1SLf0+nyb7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPQCK9uV; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-23446bb8785so37436685ad.0;
        Tue, 27 May 2025 20:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404231; x=1749009031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hu9/X1JOi8Os36x5RU4FpTPbcc8XO6FTrIp+jwMDpec=;
        b=mPQCK9uVQrI/1QxlD5BoZkw4kJB8zOGFt+dWbUJUmo2FwhuQDYYx8jwlDa/0Hzw735
         ihks9MVokUBv6TEDIgvEaWVZsg2hovST3kFymNEHnBziPplKwCmy+9Ucc9HzbGprD3/b
         IgzHEDWHMsgzpRmsrj+1CKzCxrnfLHGP0+6xkI+KJZCq3AsG2KUjCbcoHDxWquwZT+yY
         6IIe/NAuNKwawgsPlk0YHMm2MnLe9ywLEC3WLPbkWDkBMmgesiasw8Q3v3jeTT6SIprj
         +NdqQYm0PRkTiTf8NZjLXn6fMxY59ME9NhroTZtq9T1GMBCsiNOLh8O3SaR3Q69/u2Qu
         xR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404231; x=1749009031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hu9/X1JOi8Os36x5RU4FpTPbcc8XO6FTrIp+jwMDpec=;
        b=dXFifQfGWYQFC1PIZc/FsAkB0+y08WC3YwjgRHNJpsAQyV7xk4CYUZxV9lP3qC1RGc
         J7XDnTR7Hko2Dq0JqMGMpFxNmvSr6upJMYDSn3RVovm7hmm0c2c6WGro3iCKHme+b9LT
         R5hjUvrnhpP5WilnmQOkJeKmf4Oq0EbaZy0StK/aBZX4cwvfExXFw3IeBP2++3eNskNA
         28uXmHiDtHol/mgB9pg+1dFaLqCF805D0iwJ5Yj3E0BPyOPev3vq6fSZ04PUhSglCORI
         IPQzuJo+iRx38b757m++gsQqRe9kiPFRpBoPhKHYrOFDKHz3188sNv+pxlfRb9GCH0ya
         juyA==
X-Forwarded-Encrypted: i=1; AJvYcCUKIym+JVckzYCFeSuJ9s8zdiSrzlDPCVX3czHo+tCwREten7DGulVxcHJ1lDwwZDwnWluOpTtWcT3nPWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx24sShMuGxS2GDTRrv3HlaxKzK0iBd6nOyqy3fPnaaSl8YDkBF
	zOFXTCkPkOs3CLqAi04MGYFkXx832ikRGCHVXofoySpR+Aa7nTfnFxLw
X-Gm-Gg: ASbGnctPEiGRS0BFEhhqUFUq+Td92xpkmmpFr5aL6mMLVT9rs1xXeyChPYA4XKq8Uil
	5JwUGF+UpfuLiBRkTUjCd//FiHYqzdrEgwe8RE9u00ZGY3Jsko3hZ6fGfc5VXSwwW1SYKY6PwqU
	/HfAPURwi6URTnRcvGcoqA4VqQDpnACSUB4VkGXGZ9guMutgK1XI86s7UpFAJi7Nqx8GpfEfvLa
	HWdw3FO0LduAYWIkgmDC/Rvwytvrr+p9qDBD82n7a8Rl3Qyac9x/8AqAvxmKUnQC/0CQVSKZcju
	FljQUOqm346S8dmFxZ7JU8AWRzPDstAvCkGJICE4F93IzbF84mtMDKbfhLzMlRNbZFWn
X-Google-Smtp-Source: AGHT+IHb6XuBb0eSurxKAfp2Gz9/QNo3XaqUB3jxZEb20L9m4arA2I30pbXGEjnNIAQjFRKJrZLISQ==
X-Received: by 2002:a17:902:e5cb:b0:234:c549:da10 with SMTP id d9443c01a7336-234c549dbedmr29711375ad.47.1748404230906;
        Tue, 27 May 2025 20:50:30 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:50:30 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 25/25] selftests/bpf: add performance bench test for trace prog
Date: Wed, 28 May 2025 11:47:12 +0800
Message-Id: <20250528034712.138701-26-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528034712.138701-1-dongml2@chinatelecom.cn>
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add testcase for the performance of the trace bpf progs. In this testcase,
bpf_fentry_test1() will be called 10000000 times in bpf_testmod_bench_run,
and the time consumed will be returned. Following cases is considered:

- nop: nothing is attached to bpf_fentry_test1()
- fentry: a empty FENTRY bpf program is attached to bpf_fentry_test1()
- fentry_multi_single: a empty FENTRY_MULTI bpf program is attached to
  bpf_fentry_test1()
- fentry_multi_all: a empty FENTRY_MULTI bpf program is attached to all
  the kernel functions
- kprobe_multi_single: a empty KPROBE_MULTI bpf program is attached to
  bpf_fentry_test1()
- kprobe_multi_all: a empty KPROBE_MULTI bpf program is attached to all
  the kernel functions

And we can get the result by running:

  ./test_progs -t tracing_multi_bench -v | grep time

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../selftests/bpf/prog_tests/trace_bench.c    | 149 ++++++++++++++++++
 .../selftests/bpf/progs/fentry_empty.c        |  13 ++
 .../testing/selftests/bpf/progs/trace_bench.c |  21 +++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  16 ++
 4 files changed, 199 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/trace_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_empty.c
 create mode 100644 tools/testing/selftests/bpf/progs/trace_bench.c

diff --git a/tools/testing/selftests/bpf/prog_tests/trace_bench.c b/tools/testing/selftests/bpf/prog_tests/trace_bench.c
new file mode 100644
index 000000000000..673c9acf358c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/trace_bench.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+
+#include <test_progs.h>
+#include "bpf/libbpf_internal.h"
+
+#include "fentry_multi_empty.skel.h"
+#include "fentry_empty.skel.h"
+#include "kprobe_multi_empty.skel.h"
+#include "trace_bench.skel.h"
+
+static void test_bench_run(const char *name)
+{
+	struct trace_bench *skel;
+	__u64 bench_result;
+	int err;
+
+	skel = trace_bench__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "trace_bench__open_and_load"))
+		return;
+
+	err = trace_bench__attach(skel);
+	if (!ASSERT_OK(err, "trace_bench__attach"))
+		goto cleanup;
+
+	ASSERT_OK(trigger_module_test_read(1), "trigger_read");
+
+	bench_result = skel->bss->bench_result / 1000;
+	printf("bench time for %s: %lld.%03lldms\n", name, bench_result / 1000,
+	       bench_result % 1000);
+cleanup:
+	trace_bench__destroy(skel);
+}
+
+static void test_fentry_multi(bool load_all, char *name)
+{
+	LIBBPF_OPTS(bpf_trace_multi_opts, opts);
+	struct fentry_multi_empty *skel;
+	char **syms = NULL;
+	struct bpf_link *link;
+	size_t cnt = 0;
+	int err;
+
+	skel = fentry_multi_empty__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_multi_empty__open_and_load"))
+		goto cleanup;
+
+	if (!load_all) {
+		err = fentry_multi_empty__attach(skel);
+		if (!ASSERT_OK(err, "fentry_multi_empty__attach"))
+			goto cleanup;
+		goto do_test;
+	}
+
+	if (!ASSERT_OK(bpf_get_ksyms(&syms, &cnt, true), "get_syms"))
+		return;
+	opts.syms = (const char **) syms;
+	opts.cnt = cnt;
+	opts.skip_invalid = true;
+	link = bpf_program__attach_trace_multi_opts(skel->progs.fentry_multi_empty,
+						    &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_trace_multi_opts"))
+		goto cleanup;
+	skel->links.fentry_multi_empty = link;
+	printf("attach %d functions before testings\n", (int)opts.cnt);
+
+do_test:
+	test_bench_run(name);
+cleanup:
+	fentry_multi_empty__destroy(skel);
+	if (syms)
+		free(syms);
+}
+
+static void test_fentry_single(void)
+{
+	struct fentry_empty *skel;
+	int err;
+
+	skel = fentry_empty__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_empty__open_and_load"))
+		return;
+
+	err = fentry_empty__attach(skel);
+	if (!ASSERT_OK(err, "fentry_empty__attach"))
+		goto cleanup;
+
+	test_bench_run("fentry_single");
+cleanup:
+	fentry_empty__destroy(skel);
+}
+
+static void test_kprobe_multi(bool load_all, char *name)
+{
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	char *test_func = "bpf_fentry_test1";
+	struct kprobe_multi_empty *skel;
+	struct bpf_link *link;
+	char **syms = NULL;
+	size_t cnt = 0;
+
+	if (!ASSERT_OK(bpf_get_ksyms(&syms, &cnt, true), "get_syms"))
+		return;
+
+	skel = kprobe_multi_empty__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "kprobe_multi_empty__open_and_load"))
+		goto cleanup;
+
+	if (load_all) {
+		opts.syms = (const char **) syms;
+		opts.cnt = cnt;
+	} else {
+		opts.syms = (const char **) &test_func;
+		opts.cnt = 1;
+	}
+	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_empty,
+						     NULL, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_kprobe_multi_opts"))
+		goto cleanup;
+	skel->links.test_kprobe_empty = link;
+
+	if (load_all)
+		printf("attach %d functions before testings\n", (int)opts.cnt);
+	test_bench_run(name);
+
+cleanup:
+	kprobe_multi_empty__destroy(skel);
+	if (syms)
+		free(syms);
+}
+
+void test_trace_bench(void)
+{
+	if (test__start_subtest("nop"))
+		test_bench_run("nop");
+
+	if (test__start_subtest("fentry_single"))
+		test_fentry_single();
+
+	if (test__start_subtest("fentry_multi_single"))
+		test_fentry_multi(false, "fentry_multi_single");
+	if (test__start_subtest("fentry_multi_all"))
+		test_fentry_multi(true, "fentry_multi_all");
+
+	if (test__start_subtest("kprobe_multi_single"))
+		test_kprobe_multi(false, "kprobe_multi_single");
+	if (test__start_subtest("kprobe_multi_all"))
+		test_kprobe_multi(true, "kprobe_multi_all");
+}
diff --git a/tools/testing/selftests/bpf/progs/fentry_empty.c b/tools/testing/selftests/bpf/progs/fentry_empty.c
new file mode 100644
index 000000000000..f2bfaf04d56a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fentry_empty.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(fentry_empty)
+{
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/trace_bench.c b/tools/testing/selftests/bpf/progs/trace_bench.c
new file mode 100644
index 000000000000..98373871414a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/trace_bench.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 bench_result;
+
+SEC("fexit.multi/bpf_testmod_bench_run")
+int BPF_PROG(fexit_bench_done)
+{
+	__u64 ret = 0;
+
+	bpf_get_func_ret(ctx, &ret);
+	bench_result = ret;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index ebc4d5204136..d21775eba211 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -405,6 +405,20 @@ noinline int bpf_testmod_fentry_test11(u64 a, void *b, short c, int d,
 	return a + (long)b + c + d + (long)e + f + g + h + i + j + k;
 }
 
+extern int bpf_fentry_test1(int a);
+noinline u64 bpf_testmod_bench_run(void)
+{
+	u64 start = ktime_get_boottime_ns();
+	u64 time;
+
+	for (int i = 0; i < 10000000; i++)
+		bpf_fentry_test1(i);
+
+	time = ktime_get_boottime_ns() - start;
+
+	return time;
+}
+
 int bpf_testmod_fentry_ok;
 
 noinline ssize_t
@@ -443,6 +457,8 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 
 	(void)trace_bpf_testmod_test_raw_tp_null(NULL);
 
+	(void)bpf_testmod_bench_run();
+
 	bpf_testmod_test_struct_ops3();
 
 	struct_arg3 = kmalloc((sizeof(struct bpf_testmod_struct_arg_3) +
-- 
2.39.5


