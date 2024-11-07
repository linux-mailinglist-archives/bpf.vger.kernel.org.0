Return-Path: <bpf+bounces-44285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42D99C0D4E
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 18:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17141C2222E
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4B5216E1E;
	Thu,  7 Nov 2024 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwchVoSa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65722216E15
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001887; cv=none; b=QEiy4T5/i5bC+Vtzi7A0LtzJC8Fwy23A8aeKdjkewiOfS2slA1MdbjOVVI+quX3pQxga+Yll8FmY99q4wI1vJmNztbefbP5ZX56xFX4ymsPWTWu1l5H6Hkhe73vg4hLR0+jf6VrACjxYk7Rs2hFglibAxTR0ZY4UMzsfGGz6/mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001887; c=relaxed/simple;
	bh=RSBCHRPgj9xObdvMxW0Dz7UMuVNJbntbfEGTntkAn68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mB6w0VfrPI8KRO2ZSz6qB+di/xdcFLx7/ndkwOcx3SFedQCidN9pxrnfbEKT7ac7QQhHLQMRVd5B69q6RcU/OnnA/2XXLIDjh4z637RYs/PTUDj2AIbH8nBZ6TGjcm71wIvEU8VRfa7yJ6XX7bWByTFqwEhgnaO+LSwMARleXQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwchVoSa; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so1055111b3a.0
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 09:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731001884; x=1731606684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjuU3lhXmez7Dx6myLLEGYrjE75KDVFRvZJdKSDn19I=;
        b=LwchVoSaR9mKZWMvMDjl+zvjpGensEV17mEU1E0h27z+wfwoeoyXMDL6YYtpFzbhJI
         58WE7MEcwJKiy81Y33tkUJUz0CqHLRE0IAxBRLzCQDng/xGXRmDGX3iI8OGazBByYKv9
         CRqOLhalTjnAvlvF5GXZ4aVE3bP4Ioqvbx2r6Fx4w5GsPM9w8OykZG+gRDMr8dFcc58F
         FGORodu4Zryefw/DIJGwNqui7EJsYgiDB7vbYvjA5TZqjLYfZRmPu9T/fSoMKLBZ9fC0
         0saE5dDOGU2hCZeYJB5c59RqUEAA9rIpyttnx6NfhL7OBgjdUnZhBc7UHE0zUqIplXV1
         23zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731001884; x=1731606684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjuU3lhXmez7Dx6myLLEGYrjE75KDVFRvZJdKSDn19I=;
        b=g+cR17XtPvTGnJ4uIBsqb4dkfokFfttU2l6SwCBzDVAwAdku8ABVbpXR0hr/9TwgGB
         fod9c3VjPNrTdoW3IvPnLQmGlRO+1+G4Tqjod4IIIjBzqqz08an2MGBRNaL6xLaQWnuX
         SOhIubNHqB2kNgapi1ZQZGvWTrHT/s4rJ+RMThmvaXo3FfvIFJdLhCjWUstZFjp7lD7X
         vdb2QUcUU2gzv7aMymKs7akFOr+iRYCZNR5eb66z04XCntRGEq4YOxSbWMfziPKPQHre
         lK8et16RIcMVMpa33BBGa/6oW3iKWr0HyAtmGol5f7vi2/5rmnJMgLmSknHwkL8JkVjZ
         YoOw==
X-Gm-Message-State: AOJu0YzHQ0/S0vP/X0nnSHaxdxZkPRZt37/hx/Du2/i6bjb9NzFRJu6d
	K8tM+eC2ZOgg+8BFDycDQm424LBhK5fwzl0MbrGIt7dMLcwgVpwJi54sYSBD
X-Google-Smtp-Source: AGHT+IGTGf5dDNvyUgROJbz2t72EDKsWAnsP02EJ8sJ4YId5bR6x343nN+Yh9Ai0tipOalsZFhY4Fw==
X-Received: by 2002:a05:6a20:841b:b0:1db:ecf6:6e87 with SMTP id adf61e73a8af0-1dc2063ee7cmr500757637.44.1731001884323;
        Thu, 07 Nov 2024 09:51:24 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f52b32sm1730686a91.5.2024.11.07.09.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 09:51:23 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 11/11] selftests/bpf: dynptr_slice benchmark
Date: Thu,  7 Nov 2024 09:50:40 -0800
Message-ID: <20241107175040.1659341-12-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107175040.1659341-1-eddyz87@gmail.com>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Benchmark to measure execution time of a simple bpf_dynptr_slice()
call, when dynptr type is known and buffer__opt parameter is null.
Under such conditions verifier inline the kfunc call and delete a
couple of conditionals in the body of the kfunc.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          |  2 +
 tools/testing/selftests/bpf/bench.c           |  2 +
 .../selftests/bpf/benchs/bench_dynptr_slice.c | 76 +++++++++++++++++++
 .../selftests/bpf/progs/dynptr_slice_bench.c  | 29 +++++++
 4 files changed, 109 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_dynptr_slice.c
 create mode 100644 tools/testing/selftests/bpf/progs/dynptr_slice_bench.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index edef5df08cb2..3a938d5b295f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -845,6 +845,7 @@ $(OUTPUT)/bench_local_storage_create.o: $(OUTPUT)/bench_local_storage_create.ske
 $(OUTPUT)/bench_bpf_hashmap_lookup.o: $(OUTPUT)/bpf_hashmap_lookup.skel.h
 $(OUTPUT)/bench_htab_mem.o: $(OUTPUT)/htab_mem_bench.skel.h
 $(OUTPUT)/bench_bpf_crypto.o: $(OUTPUT)/crypto_bench.skel.h
+$(OUTPUT)/bench_dynptr_slice.o: $(OUTPUT)/dynptr_slice_bench.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
@@ -865,6 +866,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_local_storage_create.o \
 		 $(OUTPUT)/bench_htab_mem.o \
 		 $(OUTPUT)/bench_bpf_crypto.o \
+		 $(OUTPUT)/bench_dynptr_slice.o \
 		 #
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 1bd403a5ef7b..74053665465c 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -549,6 +549,7 @@ extern const struct bench bench_local_storage_create;
 extern const struct bench bench_htab_mem;
 extern const struct bench bench_crypto_encrypt;
 extern const struct bench bench_crypto_decrypt;
+extern const struct bench bench_dynptr_slice;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -609,6 +610,7 @@ static const struct bench *benchs[] = {
 	&bench_htab_mem,
 	&bench_crypto_encrypt,
 	&bench_crypto_decrypt,
+	&bench_dynptr_slice,
 };
 
 static void find_benchmark(void)
diff --git a/tools/testing/selftests/bpf/benchs/bench_dynptr_slice.c b/tools/testing/selftests/bpf/benchs/bench_dynptr_slice.c
new file mode 100644
index 000000000000..957ecc6f1531
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_dynptr_slice.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <argp.h>
+#include "bench.h"
+#include "dynptr_slice_bench.skel.h"
+
+static struct dynptr_slice_ctx {
+	struct dynptr_slice_bench *skel;
+	int pfd;
+} ctx;
+
+static void dynptr_slice_validate(void)
+{
+	if (env.consumer_cnt != 0) {
+		fprintf(stderr, "bpf dynptr_slice benchmark doesn't support consumer!\n");
+		exit(1);
+	}
+}
+
+static void dynptr_slice_setup(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err;
+
+	setup_libbpf();
+	ctx.skel = dynptr_slice_bench__open();
+	if (!ctx.skel) {
+		fprintf(stderr, "failed to open skeleton\n");
+		exit(1);
+	}
+
+	ctx.skel->bss->hits = 0;
+	err = dynptr_slice_bench__load(ctx.skel);
+	if (err) {
+		fprintf(stderr, "failed to load skeleton\n");
+		dynptr_slice_bench__destroy(ctx.skel);
+		exit(1);
+	}
+}
+
+static void dynptr_slice_encrypt_setup(void)
+{
+	dynptr_slice_setup();
+	ctx.pfd = bpf_program__fd(ctx.skel->progs.dynptr_slice);
+}
+
+
+static void dynptr_slice_measure(struct bench_res *res)
+{
+	res->hits = atomic_swap(&ctx.skel->bss->hits, 0);
+}
+
+static void *dynptr_slice_producer(void *unused)
+{
+	static const char data_in[1000];
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.repeat = 64,
+		.data_in = data_in,
+		.data_size_in = sizeof(data_in),
+	);
+
+	while (true)
+		(void)bpf_prog_test_run_opts(ctx.pfd, &opts);
+	return NULL;
+}
+
+const struct bench bench_dynptr_slice = {
+	.name = "dynptr_slice",
+	.validate = dynptr_slice_validate,
+	.setup = dynptr_slice_encrypt_setup,
+	.producer_thread = dynptr_slice_producer,
+	.measure = dynptr_slice_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
diff --git a/tools/testing/selftests/bpf/progs/dynptr_slice_bench.c b/tools/testing/selftests/bpf/progs/dynptr_slice_bench.c
new file mode 100644
index 000000000000..65a493426b5e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dynptr_slice_bench.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_compiler.h"
+#include "bpf_kfuncs.h"
+
+long hits = 0;
+
+SEC("tc")
+int dynptr_slice(struct __sk_buff *skb)
+{
+	struct bpf_dynptr psrc;
+	const int N = 100;
+	int i;
+
+	bpf_dynptr_from_skb(skb, 0, &psrc);
+__pragma_loop_unroll_full
+	for (i = 0; i < N; ++i) {
+		bpf_dynptr_slice(&psrc, i, NULL, 1);
+	}
+	__sync_add_and_fetch(&hits, N);
+
+	return 0;
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.47.0


