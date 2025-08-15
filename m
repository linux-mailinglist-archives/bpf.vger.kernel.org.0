Return-Path: <bpf+bounces-65729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B66C6B27964
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 08:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019831CE49FE
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 06:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D66D2BE7AC;
	Fri, 15 Aug 2025 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlsWtg54"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D892D1913;
	Fri, 15 Aug 2025 06:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755240456; cv=none; b=Q4f+R+VDkDIGQvsX4S7n+cKYq54JiQJhtjTeY6JOnwm7t7CWRepcZl4neAN8gUsatD8oZiUZpIg6fU+t8n4OkTQQhtTIWVSqaKPCdPajJWTiOw7qjB7F7TLeMI6xeCjCNK/DE6Ash+4FWAqAkWcdxQDdUBMKItXpB04zIylpgT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755240456; c=relaxed/simple;
	bh=Y0sVgiMIvCN1tEPgiAVLe8svWdYQEvpuSTM/2lhhTGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATy4GV8hsxTElt1NAbUyyyzEKiCwfBubp2QKCL0Sf6V1aLmouARr/hdpV9SLAVBZ0/uwsuIsCs+1+K1jXhRWBxZ4gUu1/847F+xQGWKRtgLFSlN0Gn8av+QXotqbXjnHizSto4NOBtqdZDc3+Dpb86184HjPKGTGRb2dw66Gnnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlsWtg54; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-76e2eb9ae80so1511571b3a.3;
        Thu, 14 Aug 2025 23:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755240454; x=1755845254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4PDMe7SP8CZO+JhWjjdFtQ1vR89wVuSvH9ObtDEfac=;
        b=JlsWtg54GWru5oqIW9XQlViJn+k3rXg8VxFLIW9p7tqoXpTvKgki8RnIt7fUq/8+v9
         wRBZdLznlvKCamxBqs9UoYKpvga6C4HaN2DWOeK0nEuKbqwqpkNOaMlyDSvCv+BUm43/
         uHdOL35fxg1FHWBksEERtxMpUoXDVVN+1Wk6UzdcgjRWHZAr0SnOTO4XfonxFLB2SLA6
         nAxqS6LJ6K9yUkuX28U78TPWYA1Pe8SP8DefxZ9Cm7zx3KoMBdBSY2bWdR6ly3uOxzg8
         wmChigHI4TJpAvRM+csU+42IuZzSbCB2ntUcsbBiJRYoyiUdH42IXQ6As6Sau0MA/84G
         WquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755240454; x=1755845254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4PDMe7SP8CZO+JhWjjdFtQ1vR89wVuSvH9ObtDEfac=;
        b=N2lLAzy3bEmbJjPVVysQrU4Ftc/mJBRccLoVlu0uqlrPywWtOXNoiZIBnOSj20X+Gp
         ySHtPKXuo3Eg7B1+gKclTQtpjUMO3fW94FmgShDhopNfDf4/H59h1HZ+EPrk0eym3RrC
         htVh9ZXQcxN/gTxDQlUGybukWNE4mtOmsRiUtjxlnnPsS7a20xJMr/V38WgJaLgo8kip
         6y3OI1h7EHmsneaxIurUqLPZFg/dewbneqaPoVZKiB2BluDj8msH8H7A9SrHITDRi1v3
         RiwFp2hoTgl8DQaXtyqzytBjW/P1OMAMuuM8rrRXBjOzEENlY+ufCHtq8JeHL8KeHV0C
         nKmA==
X-Forwarded-Encrypted: i=1; AJvYcCUmbxLRVFkpJis4epm0PAmPwqihrxMF3zFoMMNbrF/iPtEwjg5kZD1sxcebQWNK7h07Lhc=@vger.kernel.org, AJvYcCW+LFjCKq8SXMDN7YD7WR/egjVqzjp7EFCuXu/wNGmILB+6LtOFAb1Hmg8Us98LKvplmCnMOn4qknb3nLU96DCHc3ff@vger.kernel.org, AJvYcCWvxUmL6ur/kDXjTEXcA3izvt4hEAFwJKerUy1chKFG48Vv7CwR1SHF7M7xYtfNzazteIRhbnRlyLTeFn2S@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6uUoOvRudNyt45pg1iSERZ/eJcWjljOOnsXNz48DIEGDcFvvZ
	OQ4SD1sBxGE7ltkj0ViNdkmXgc/ExqUyDGOq+gK5d1Bhr47tcMsFUzFj
X-Gm-Gg: ASbGncvKB84JhoJEeJSALCiHbCGQ3NUMTSikYZdy/wT6t7ig5w0fCWwZk4gOtnVELMv
	6I6ezyRjcQCDwm26c99GfJeqQrhdj5z5sIN4o5qVeOMnQewlUL+SGNOliwM3/48EoLKl5qew474
	ESUkWlsqy5mH0lVN/JaHRFq6WCAnpkvyHB1/sgzRC3R0APanrgwjsesSUHLOKK2qtOmSXR71nWt
	nRcweKLJWDyPIChthYpgUohJcTN9+kgcqAykE3LLznV/r+7ytzF6LpWEr9bD/yHJkKL0mUUq9nL
	QHoBaekYwyvIwycpIdburkSnELlu8ut5duqAJjVNXvvw2UGf22f12wjZjfhL9pVmHiRVvvdj96P
	SbSotG0znY4r1uVw6WROzb5Wkz/MKLA==
X-Google-Smtp-Source: AGHT+IEpPQf+JHKjFjSgWqtn4rPpLWyc9VY7M5Q7JPqhR1Pw9ZB8mkZhnx1HbtDpf1FcmJxxiv/Cjg==
X-Received: by 2002:a17:902:f68e:b0:240:6aad:1c43 with SMTP id d9443c01a7336-2446d905497mr14307425ad.48.1755240454201;
        Thu, 14 Aug 2025 23:47:34 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d539032sm7161665ad.109.2025.08.14.23.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 23:47:33 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 4/4] selftests/bpf: add benchmark testing for kprobe-multi-all
Date: Fri, 15 Aug 2025 14:47:10 +0800
Message-ID: <20250815064712.771089-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815064712.771089-1-dongml2@chinatelecom.cn>
References: <20250815064712.771089-1-dongml2@chinatelecom.cn>
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


