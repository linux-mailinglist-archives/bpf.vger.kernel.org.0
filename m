Return-Path: <bpf+bounces-64789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 440EDB16E91
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 11:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491A31AA37FC
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 09:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A2F2BE657;
	Thu, 31 Jul 2025 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig7PDkl0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2915F2BE63A;
	Thu, 31 Jul 2025 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953895; cv=none; b=j/Y3ItID6aBCaCzjrgYw3Z+GeSgPm0g0EzPDAByybyxcKI9k9bH+xH1WjMr162poZwtp2YtPRgo26AMznQy61wzUDNXinycfMRbJZFOl8rP1FVBQFO/nhsEaIEmI0Puf9mxa/UEKmibT/n91++gyHTtACNLaVWq74DGi7deWvJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953895; c=relaxed/simple;
	bh=Y0sVgiMIvCN1tEPgiAVLe8svWdYQEvpuSTM/2lhhTGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fo+EXo0Q1dSUTowz5HYtg+QNwkwxPQxw6fmZ62CjLcuAii4Rpwq6ge2JBW9YrL1m1RHbSNZ541gDvgwdgASSqjGuik8rm2uccgDoGAU1+CkLb7B/o2YQ13RmiyGU3JiPA8J946dGfT8yc7zGge4mZEzWEy7jsaNr5w0rwf5V7hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ig7PDkl0; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-74b54cead6cso136443b3a.1;
        Thu, 31 Jul 2025 02:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753953893; x=1754558693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4PDMe7SP8CZO+JhWjjdFtQ1vR89wVuSvH9ObtDEfac=;
        b=ig7PDkl0M5auHWQoARXS5sH/IQCbiUWi5/T64V94jJnBTJkigBBG0OsRepWZKKvRCi
         NyK34v0r10REl8ySw28Ho9RRx6Y7hjZ2wEJJxQsSqJqPu+8a766yA2H5niO4lZi+ktoC
         jDLhyQReHyqIGv/smugXdqDMO+vWNBBVruFGoaOk+WojHhJWxdWCvUKH8S6fmxzeLfjW
         ySlfFspSbToJKDyABvxL+yE4Xz9yCjriOqgkrIVyCOxwnAKOf2Xzib/mRXD88urP00PA
         Uoavq4hbAWx0Og8p45hpflqwgE61J5kpBFsR5y2nTlKc8XhzJtXB2SrKHGGHoN79moVL
         8Iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753953893; x=1754558693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4PDMe7SP8CZO+JhWjjdFtQ1vR89wVuSvH9ObtDEfac=;
        b=N3l3dl96YcJ+OD/66H2QalJ6uOJI6D3Hy+K+bfZrmsH3FVgEbjKJgC50ivRBCXEFJ1
         LFvpLg3LaOJSGStUXKEoKiKNgLKp4U2BoBJyCHDmyZAkBnvM3Hw5b++dVtTiXkULEued
         5vWi8MPFc2z3HZ6II5dQPTY0qu5M/AHXLuKCmaosRuuPrnrff81UryXIRq6f9+S9sBTv
         EdtTzg6xfS2X3DZYz9ELdV4Ygiz082MBmO9WV1r6j2Zi6kDs/PUwMMTP1PlTEwQzNegv
         yJ72wWCYBQc/lG6mE0vk5SOckrJWY2O9jTRWCCKxK5ndsIzgOGuyUTlImE0UnJ4JSEqT
         vYiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzopYKldJTvZMv/K1fw8HnY2QeaLY9M7eh8DXkgjtSLLHuBWkje6ndQdtMVLJznx+TSfE=@vger.kernel.org, AJvYcCWza5tktBslYk/3RZVWU5ynyIcwwlwYXu8aUVqWtA2mvGfJKTOhOT2H0OQut7/s6mLJfpdYAw8z8C/GB6odDKdZqMof@vger.kernel.org, AJvYcCXXesEK/3WJp/tkSioMM2zVJaBu6ODvBxu1qHlqYjyCF2VagTMYjylgaetOgZumO3Uk85I/aBB/uUWlEe3m@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ibUpOkgSlH20p6D282RYO0AgNsOxB21LjvdJqCkMC6NqwhPy
	oUleHqtk10wDoy0vt/JCvp2WV9e6iJCIWTtlSfNLyjP9uemoHwMIZseC
X-Gm-Gg: ASbGnct1IiNZgh5SY6T/0dapFQDEhyMGkOoKZPu9ePh3z1r7b0JaEqKPtyeg1oUWTJX
	r/DEfgTDpGuZXfMmJJSfDpdH2KFU7kdkMfb0tbdQ7gobyteODsP5+zJheTMZ4vhGeTTOitqd4Go
	EKnRhF07qXi0N00cyUg52PPbqoNpCvegJP3bz6zRbgBKGXRxpDRMh0O1P9hfN5f3tY21l5ymqjd
	7E+m4K2LzTEuAKcfsw4PdCCNevDg6DOZD8lKPHKOAbH9jAAmkXQXFolyvIU+aTG/EDhunwVQuso
	Kg+F7kYDh27QFr7mBC+yt4LY76MYdvpNE1P7/AncnECh8HNUm5HA52SChLy3sbueKkfvMhZqJRb
	aqPBNWgvmYWVyhuoTdZg=
X-Google-Smtp-Source: AGHT+IE3kSfjGpm4vF9P6oGhvDfaGmV6e2g/GrQ5BCL1131NXnerrwWXlBf/hlhOgLJeyGeAWXcjjg==
X-Received: by 2002:a05:6a20:258a:b0:20a:bde0:beb9 with SMTP id adf61e73a8af0-23dc0ea7f3emr9520807637.1.1753953893229;
        Thu, 31 Jul 2025 02:24:53 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd1a7sm1108143b3a.73.2025.07.31.02.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 02:24:52 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org,
	olsajiri@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	hca@linux.ibm.com,
	revest@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: add benchmark testing for kprobe-multi-all
Date: Thu, 31 Jul 2025 17:24:27 +0800
Message-ID: <20250731092433.49367-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731092433.49367-1-dongml2@chinatelecom.cn>
References: <20250731092433.49367-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, the benchmark for kprobe-multi is single, which means there is
only 1 function is hooked during testing. Add the testing
"kprobe-multi-all", which will hook all the kernel functions during
the benchmark. And the "kretprobe-multi-all" is added too.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- add testcase kretprobe-multi-all
- attach a empty kprobe-multi/kretprobe-multi prog to all the kernel
  functions except bpf_get_numa_node_id to make the bench result more
  accurate
---
 tools/testing/selftests/bpf/bench.c           |  4 ++
 .../selftests/bpf/benchs/bench_trigger.c      | 54 +++++++++++++++++++
 .../selftests/bpf/benchs/run_bench_trigger.sh |  4 +-
 .../selftests/bpf/progs/trigger_bench.c       | 12 +++++
 tools/testing/selftests/bpf/trace_helpers.c   |  3 ++
 5 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index ddd73d06a1eb..29dbf937818a 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -510,6 +510,8 @@ extern const struct bench bench_trig_kretprobe;
 extern const struct bench bench_trig_kprobe_multi;
 extern const struct bench bench_trig_kretprobe_multi;
 extern const struct bench bench_trig_fentry;
+extern const struct bench bench_trig_kprobe_multi_all;
+extern const struct bench bench_trig_kretprobe_multi_all;
 extern const struct bench bench_trig_fexit;
 extern const struct bench bench_trig_fmodret;
 extern const struct bench bench_trig_tp;
@@ -578,6 +580,8 @@ static const struct bench *benchs[] = {
 	&bench_trig_kprobe_multi,
 	&bench_trig_kretprobe_multi,
 	&bench_trig_fentry,
+	&bench_trig_kprobe_multi_all,
+	&bench_trig_kretprobe_multi_all,
 	&bench_trig_fexit,
 	&bench_trig_fmodret,
 	&bench_trig_tp,
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 82327657846e..c6634a64a7c0 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -226,6 +226,58 @@ static void trigger_fentry_setup(void)
 	attach_bpf(ctx.skel->progs.bench_trigger_fentry);
 }
 
+static void attach_ksyms_all(struct bpf_program *empty, bool kretprobe)
+{
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	char **syms = NULL;
+	size_t cnt = 0;
+
+	if (bpf_get_ksyms(&syms, &cnt, true)) {
+		printf("failed to get ksyms\n");
+		exit(1);
+	}
+
+	printf("found %zu ksyms\n", cnt);
+	opts.syms = (const char **) syms;
+	opts.cnt = cnt;
+	opts.retprobe = kretprobe;
+	/* attach empty to all the kernel functions except bpf_get_numa_node_id. */
+	if (!bpf_program__attach_kprobe_multi_opts(empty, NULL, &opts)) {
+		printf("failed to attach bpf_program__attach_kprobe_multi_opts to all\n");
+		exit(1);
+	}
+}
+
+static void trigger_kprobe_multi_all_setup(void)
+{
+	struct bpf_program *prog, *empty;
+
+	setup_ctx();
+	empty = ctx.skel->progs.bench_kprobe_multi_empty;
+	prog = ctx.skel->progs.bench_trigger_kprobe_multi;
+	bpf_program__set_autoload(empty, true);
+	bpf_program__set_autoload(prog, true);
+	load_ctx();
+
+	attach_ksyms_all(empty, false);
+	attach_bpf(prog);
+}
+
+static void trigger_kretprobe_multi_all_setup(void)
+{
+	struct bpf_program *prog, *empty;
+
+	setup_ctx();
+	empty = ctx.skel->progs.bench_kretprobe_multi_empty;
+	prog = ctx.skel->progs.bench_trigger_kretprobe_multi;
+	bpf_program__set_autoload(empty, true);
+	bpf_program__set_autoload(prog, true);
+	load_ctx();
+
+	attach_ksyms_all(empty, true);
+	attach_bpf(prog);
+}
+
 static void trigger_fexit_setup(void)
 {
 	setup_ctx();
@@ -512,6 +564,8 @@ BENCH_TRIG_KERNEL(kretprobe, "kretprobe");
 BENCH_TRIG_KERNEL(kprobe_multi, "kprobe-multi");
 BENCH_TRIG_KERNEL(kretprobe_multi, "kretprobe-multi");
 BENCH_TRIG_KERNEL(fentry, "fentry");
+BENCH_TRIG_KERNEL(kprobe_multi_all, "kprobe-multi-all");
+BENCH_TRIG_KERNEL(kretprobe_multi_all, "kretprobe-multi-all");
 BENCH_TRIG_KERNEL(fexit, "fexit");
 BENCH_TRIG_KERNEL(fmodret, "fmodret");
 BENCH_TRIG_KERNEL(tp, "tp");
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh b/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
index a690f5a68b6b..f7573708a0c3 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
@@ -6,8 +6,8 @@ def_tests=( \
 	usermode-count kernel-count syscall-count \
 	fentry fexit fmodret \
 	rawtp tp \
-	kprobe kprobe-multi \
-	kretprobe kretprobe-multi \
+	kprobe kprobe-multi kprobe-multi-all \
+	kretprobe kretprobe-multi kretprobe-multi-all \
 )
 
 tests=("$@")
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index 044a6d78923e..3d5f30c29ae3 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -97,6 +97,12 @@ int bench_trigger_kprobe_multi(void *ctx)
 	return 0;
 }
 
+SEC("?kprobe.multi/bpf_get_numa_node_id")
+int bench_kprobe_multi_empty(void *ctx)
+{
+	return 0;
+}
+
 SEC("?kretprobe.multi/bpf_get_numa_node_id")
 int bench_trigger_kretprobe_multi(void *ctx)
 {
@@ -104,6 +110,12 @@ int bench_trigger_kretprobe_multi(void *ctx)
 	return 0;
 }
 
+SEC("?kretprobe.multi/bpf_get_numa_node_id")
+int bench_kretprobe_multi_empty(void *ctx)
+{
+	return 0;
+}
+
 SEC("?fentry/bpf_get_numa_node_id")
 int bench_trigger_fentry(void *ctx)
 {
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 9da9da51b132..78cf1aab09d8 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -575,6 +575,9 @@ static bool skip_entry(char *name)
 	if (!strcmp(name, "__rcu_read_unlock"))
 		return true;
 
+	if (!strcmp(name, "bpf_get_numa_node_id"))
+		return true;
+
 	return false;
 }
 
-- 
2.50.1


