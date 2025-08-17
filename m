Return-Path: <bpf+bounces-65838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C36B29131
	for <lists+bpf@lfdr.de>; Sun, 17 Aug 2025 04:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA1E1966B7D
	for <lists+bpf@lfdr.de>; Sun, 17 Aug 2025 02:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C78137932;
	Sun, 17 Aug 2025 02:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gdm3RNDQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF27215175;
	Sun, 17 Aug 2025 02:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755398785; cv=none; b=vCpFboF34QgfBYn8r8R9ttO801I+7EVX3QoUD1RzAlehnOGoXogshHgZF7RDTs8np/w2To0DjpUUweyRUq4LD92kgZQMbnceho6tHIzvu+gB5pghvVlhF9PXUyfJU8ojEmB94mrZON4mWioqEo04b2c9vEJ6mACe/gkYfc7A+4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755398785; c=relaxed/simple;
	bh=Y0sVgiMIvCN1tEPgiAVLe8svWdYQEvpuSTM/2lhhTGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnQ614y3z4HxVKjatBWxTMDctBiy7Bi4angp6ydJI9vZUbrphZCtFBVaLUi7DbnGdtNvV+lvAtKM8h/ojdMAxmlw7C7jejwj/dcLyf6O2XgSvOBfUkxJ4gMplbDl3Hkfl3rsyGoOemc2DyU6oPxQv7Kk9Srzdp0WA+P5DhX0EEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gdm3RNDQ; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b471740e488so3113322a12.1;
        Sat, 16 Aug 2025 19:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755398783; x=1756003583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4PDMe7SP8CZO+JhWjjdFtQ1vR89wVuSvH9ObtDEfac=;
        b=Gdm3RNDQIHpNdn7HvbdrITSFlMIWFK6SZLzCeRrsG5EZ3Il60hMIisQRh6zqpJkU6r
         gQDPbaSz4niVS0xOmdq5bcJhyot4w9FwfIv9N2U5Pv5QeJyeZ1X//+VKqYOtp2neKeDo
         GvnhjX39oD2jTGs/nUlsVxnNGlcjnnHmVcxfQnEbhHCQXmCKGQnrRn3AbGx+86VQa8Nq
         1c2gs8d43MVsvvC/sVW37AaCMNUdnX7jd/yER6wqw0uMqKVRXM9Tx9HJvxuDn/A859Qb
         kLqR3E//9GDATT7WcrAKDHnOHgL8Rpd3dXAxKu84xpIxjjX/grR/9LFZcpWaHDmwVQUD
         QM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755398783; x=1756003583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4PDMe7SP8CZO+JhWjjdFtQ1vR89wVuSvH9ObtDEfac=;
        b=N0sSo06i3Ga3u0YgM/eDDN3jNY3q7POAuozX0mPYlAi/guNp1JLMN1YF5zGI1g/AdG
         7OTf2FmDHeAkXanDrwTEK82rSuiXyECF69VStfhvafSvLgtA+n/OA8ZMhySZLNd7d40I
         dPB7nJYlZkJezh9rW78w7ET2jbwMJ8QodgTzjt1PWrQxELM3c6e9N1wHXsxKpmiJyBf0
         cxLw4ICItpVRVJ/tHP7ny2DgNvkvDcE3c9bOhI22up0FDUxKjANymqOm1inOjEMBQoss
         pMOGxb1KHWhOiP6gRIaM8Pb4z2ydkVBcntRYmyYBC24t6b//kpw0SOfFWXnTZ0m1ny+o
         +ujA==
X-Forwarded-Encrypted: i=1; AJvYcCV+T299XQxtOn2IjGB45NndnTXHRCd97zCiwI2BS27ufaQlHwa+Gg3JEqJFGZE60E1GGQg=@vger.kernel.org, AJvYcCVRjRKSFtphomQ0IHd7W7TlGT9OELlwOj2ZiBam3VCON+PIlqle3WPhAayOZ5SgIzqXZuFukEbjn6+zO7Sw@vger.kernel.org, AJvYcCXQdQQ+LtPavN0z1UzbfBoI0inMAFjWFXn+Qd8K4jaCK72rW19NlqV4Sn8LkUsV18qN7AnudRbX0v+4Zcvkyf6Khdh/@vger.kernel.org
X-Gm-Message-State: AOJu0YyjVyhw55kcosowmOMxwOxYQvLxe3wIqfY0ibp854Dw22YY1sI+
	X3kXei9+4tWYFXnJxkCln+Qduntz9rl9c9cKI08HTo8shQabDl5Mb8XC
X-Gm-Gg: ASbGnctUBYn2kBoYJLTa5YkJ2H5lNEG24O9cwGEcrmpLkmjPT5wQn53QlRemk5do+We
	dcGXE4xigEf5UKwYfcK3CtpnZq/AAorH9EW//5/jQrVp8qii4glulm7WhPbCJUiufbfMtaYHD8H
	XB4qsqjnkq0GAqpOsouaxn24EvnaUEREWoOenDE/xlRXCOaHHplBEh86lIwkQfjcjoreVaJh7cc
	TXYdqg+9EJOVPxxAoHNbC3jHC+Xh2564mJvG9FPUhXDn9/bP/o6Wl4JUDYaPM+RlY/FYZMLNdKg
	4BYO1v+itKGWuF46AJEq9H+Dej5eJuZ0oIQb9C5wUov2wFaBiCvC6BXnthTa1KPhEZO5ya7MRic
	JQ+UKME0L72CFiR7kvv/2y+qVmHgpyA==
X-Google-Smtp-Source: AGHT+IEkRPYeSRtqbRyErbZ1r7ZynxxPHvXzI5eAhICn9Y7f2BvFMwBwIlBrZf6wG5Htf8n3RW09DA==
X-Received: by 2002:a17:902:dac9:b0:240:1ed3:fc1f with SMTP id d9443c01a7336-2446d71a0afmr107827595ad.12.1755398783228;
        Sat, 16 Aug 2025 19:46:23 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f382sm45009845ad.79.2025.08.16.19.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 19:46:22 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	hca@linux.ibm.com,
	revest@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v5 4/4] selftests/bpf: add benchmark testing for kprobe-multi-all
Date: Sun, 17 Aug 2025 10:46:05 +0800
Message-ID: <20250817024607.296117-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250817024607.296117-1-dongml2@chinatelecom.cn>
References: <20250817024607.296117-1-dongml2@chinatelecom.cn>
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


