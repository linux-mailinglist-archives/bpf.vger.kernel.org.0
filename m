Return-Path: <bpf+bounces-27008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A8F8A75DF
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 22:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D993DB219FB
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 20:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4F15A4E9;
	Tue, 16 Apr 2024 20:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dZAMg5wq"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD6F39FD7;
	Tue, 16 Apr 2024 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713300064; cv=none; b=fCUPgalFIPqqYKj0GqmmjaL9LoYx66W/0huat6Cl7YmINLBwKPX0lB5eMuFUMaa5gaco+1CqiZ+h+jMG1X/iSBSeaJxu11rHy5GLe7TKiOogLEuOsIrWrd0sR7k3FQajUWrMwSzTAPj0iWxdiJ2FYLuITilR5R5EekGAk32FCZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713300064; c=relaxed/simple;
	bh=Xxxn0J3zc6FsiMlJ3R5hkFS/4ckQKSpVxECSkXOELlw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqLAlPLYDUAUmI9QMS/9JME7YAVCZuahB1HD2WnIZVGpCmzdfmwvn38kZO6SrLtoFgNWNri0dQuRCpD1syBq3fXq+CRZin7+rPETp3SEvpWY2nzde06Xfwi3jG+OA1YsM1bTlXPkmngcvIJ6JbCWSHlf4Dv09YxqRQbW1lGR+qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dZAMg5wq; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GKeb1G011767;
	Tue, 16 Apr 2024 13:40:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=Yse9xYdBGRs5rCBIk776H/T37cvzOb2LbSZMp8HSZAQ=;
 b=dZAMg5wqYB+oMH6R55Dn+vnV/ulZHvUl9V4z7/SL/C0W6RN/fec/qiJg8NYX9zFqqGQa
 uozMcxUZSlkEJ/uVfUEMOVFDLELTdwyjVJefUPR7Qwcmo4QN7o4FKtzTwG2uGP8V4xNy
 O/YXf1CLDUbS6wJ0wpicEnM64XUwGgEYyzgowRiZDR0ZjiQwgJy1uZ6MO94Ut9PALlzx
 ecT0OWi8Dmp7hrdklb118nav8HoPGvMBRVaT9GvyWD8G9lJkrP3QQ8JDAyzX8BSBkzkI
 Opeb3h6lDZ51RcPMd0EmpPmYhCSmygR+Q0+wrTAl1qDTb/BTkVqrlpU9eWRXZV/hZXrt vQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3xhbv96v3m-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 16 Apr 2024 13:40:46 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server id
 15.1.2507.35; Tue, 16 Apr 2024 13:40:27 -0700
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v9 4/4] selftests: bpf: crypto: add benchmark for crypto functions
Date: Tue, 16 Apr 2024 13:40:04 -0700
Message-ID: <20240416204004.3942393-5-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240416204004.3942393-1-vadfed@meta.com>
References: <20240416204004.3942393-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: f-6FzUdeEiQuiiB8TcHr3lz9ySRq-Nj4
X-Proofpoint-ORIG-GUID: f-6FzUdeEiQuiiB8TcHr3lz9ySRq-Nj4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_18,2024-04-16_01,2023-05-22_02

Some simple benchmarks are added to understand the baseline of
performance.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
v9:
- initial submission
---
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |   6 +
 .../selftests/bpf/benchs/bench_bpf_crypto.c   | 190 ++++++++++++++++++
 .../selftests/bpf/progs/crypto_bench.c        | 108 ++++++++++
 4 files changed, 306 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_crypto.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_bench.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index edc73f8f5aef..be8567337480 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -729,6 +729,7 @@ $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o: $(OUTPUT)/local_storage_rcu_tas
 $(OUTPUT)/bench_local_storage_create.o: $(OUTPUT)/bench_local_storage_create.skel.h
 $(OUTPUT)/bench_bpf_hashmap_lookup.o: $(OUTPUT)/bpf_hashmap_lookup.skel.h
 $(OUTPUT)/bench_htab_mem.o: $(OUTPUT)/htab_mem_bench.skel.h
+$(OUTPUT)/bench_bpf_crypto.o: $(OUTPUT)/crypto_bench.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
@@ -748,6 +749,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_bpf_hashmap_lookup.o \
 		 $(OUTPUT)/bench_local_storage_create.o \
 		 $(OUTPUT)/bench_htab_mem.o \
+		 $(OUTPUT)/bench_bpf_crypto.o \
 		 #
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 82de56c8162e..627b74ae041b 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -281,6 +281,7 @@ extern struct argp bench_hashmap_lookup_argp;
 extern struct argp bench_local_storage_create_argp;
 extern struct argp bench_htab_mem_argp;
 extern struct argp bench_trigger_batch_argp;
+extern struct argp bench_crypto_argp;
 
 static const struct argp_child bench_parsers[] = {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
@@ -294,6 +295,7 @@ static const struct argp_child bench_parsers[] = {
 	{ &bench_local_storage_create_argp, 0, "local-storage-create benchmark", 0 },
 	{ &bench_htab_mem_argp, 0, "hash map memory benchmark", 0 },
 	{ &bench_trigger_batch_argp, 0, "BPF triggering benchmark", 0 },
+	{ &bench_crypto_argp, 0, "bpf crypto benchmark", 0 },
 	{},
 };
 
@@ -538,6 +540,8 @@ extern const struct bench bench_local_storage_tasks_trace;
 extern const struct bench bench_bpf_hashmap_lookup;
 extern const struct bench bench_local_storage_create;
 extern const struct bench bench_htab_mem;
+extern const struct bench bench_crypto_encrypt;
+extern const struct bench bench_crypto_decrypt;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -590,6 +594,8 @@ static const struct bench *benchs[] = {
 	&bench_bpf_hashmap_lookup,
 	&bench_local_storage_create,
 	&bench_htab_mem,
+	&bench_crypto_encrypt,
+	&bench_crypto_decrypt,
 };
 
 static void find_benchmark(void)
diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_crypto.c b/tools/testing/selftests/bpf/benchs/bench_bpf_crypto.c
new file mode 100644
index 000000000000..86048f02e6ac
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_bpf_crypto.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <argp.h>
+#include "bench.h"
+#include "crypto_bench.skel.h"
+#include "../progs/crypto_share.h"
+
+#define MAX_CIPHER_LEN 32
+static char *input;
+static struct crypto_ctx {
+	struct crypto_bench *skel;
+	int pfd;
+} ctx;
+
+static struct crypto_args {
+	u32 crypto_len;
+	char *crypto_cipher;
+} args = {
+	.crypto_len = 16,
+	.crypto_cipher = "ecb(aes)",
+};
+
+enum {
+	ARG_CRYPTO_LEN = 5000,
+	ARG_CRYPTO_CIPHER = 5001,
+};
+
+static const struct argp_option opts[] = {
+	{ "crypto-len", ARG_CRYPTO_LEN, "CRYPTO_LEN", 0,
+	  "Set the length of crypto buffer" },
+	{ "crypto-cipher", ARG_CRYPTO_CIPHER, "CRYPTO_CIPHER", 0,
+	  "Set the cipher to use (defaul:ecb(aes))" },
+	{},
+};
+
+static error_t crypto_parse_arg(int key, char *arg, struct argp_state *state)
+{
+	switch (key) {
+	case ARG_CRYPTO_LEN:
+		args.crypto_len = strtoul(arg, NULL, 10);
+		if (!args.crypto_len ||
+		    args.crypto_len > sizeof(ctx.skel->bss->dst)) {
+			fprintf(stderr, "Invalid crypto buffer len (limit %zu)\n",
+				sizeof(ctx.skel->bss->dst));
+			argp_usage(state);
+		}
+		break;
+	case ARG_CRYPTO_CIPHER:
+		args.crypto_cipher = strdup(arg);
+		if (!strlen(args.crypto_cipher) ||
+		    strlen(args.crypto_cipher) > MAX_CIPHER_LEN) {
+			fprintf(stderr, "Invalid crypto cipher len (limit %d)\n",
+				MAX_CIPHER_LEN);
+			argp_usage(state);
+		}
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+
+	return 0;
+}
+
+const struct argp bench_crypto_argp = {
+	.options = opts,
+	.parser = crypto_parse_arg,
+};
+
+static void crypto_validate(void)
+{
+	if (env.consumer_cnt != 0) {
+		fprintf(stderr, "bpf crypto benchmark doesn't support consumer!\n");
+		exit(1);
+	}
+}
+
+static void crypto_setup(void)
+{
+	struct crypto_syscall_args sargs = {
+		.key_len = 16,
+	};
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.ctx_in = &sargs,
+		.ctx_size_in = sizeof(sargs),
+	);
+
+	int err, pfd;
+	size_t i, sz;
+
+	sz = args.crypto_len;
+	if (!sz || sz > sizeof(ctx.skel->bss->dst)) {
+		fprintf(stderr, "invalid encrypt buffer size (source %zu, target %zu)\n",
+			sz, sizeof(ctx.skel->bss->dst));
+		exit(1);
+	}
+
+	setup_libbpf();
+
+	ctx.skel = crypto_bench__open();
+	if (!ctx.skel) {
+		fprintf(stderr, "failed to open skeleton\n");
+		exit(1);
+	}
+
+	snprintf(ctx.skel->bss->cipher, 128, "%s", args.crypto_cipher);
+	memcpy(ctx.skel->bss->key, "12345678testtest", 16);
+
+	srandom(time(NULL));
+	input = malloc(sz);
+	for (i = 0; i < sz - 1; i++)
+		input[i] = '1' + random() % 9;
+	input[sz - 1] = '\0';
+
+	ctx.skel->rodata->len = args.crypto_len;
+
+	err = crypto_bench__load(ctx.skel);
+	if (err) {
+		fprintf(stderr, "failed to load skeleton\n");
+		crypto_bench__destroy(ctx.skel);
+		exit(1);
+	}
+
+	pfd = bpf_program__fd(ctx.skel->progs.crypto_setup);
+	if (pfd < 0) {
+		fprintf(stderr, "failed to get fd for setup prog\n");
+		crypto_bench__destroy(ctx.skel);
+		exit(1);
+	}
+
+	err = bpf_prog_test_run_opts(pfd, &opts);
+	if (err || ctx.skel->bss->status) {
+		fprintf(stderr, "failed to run setup prog: err %d, status %d\n",
+			err, ctx.skel->bss->status);
+		crypto_bench__destroy(ctx.skel);
+		exit(1);
+	}
+}
+
+static void crypto_encrypt_setup(void)
+{
+	crypto_setup();
+	ctx.pfd = bpf_program__fd(ctx.skel->progs.crypto_encrypt);
+}
+
+static void crypto_decrypt_setup(void)
+{
+	crypto_setup();
+	ctx.pfd = bpf_program__fd(ctx.skel->progs.crypto_decrypt);
+}
+
+static void crypto_measure(struct bench_res *res)
+{
+	res->hits = atomic_swap(&ctx.skel->bss->hits, 0);
+}
+
+static void *crypto_producer(void *)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.repeat = 64,
+		.data_in = input,
+		.data_size_in = args.crypto_len,
+	);
+
+	while (true)
+		(void)bpf_prog_test_run_opts(ctx.pfd, &opts);
+	return NULL;
+}
+
+const struct bench bench_crypto_encrypt = {
+	.name = "crypto-encrypt",
+	.argp = &bench_crypto_argp,
+	.validate = crypto_validate,
+	.setup = crypto_encrypt_setup,
+	.producer_thread = crypto_producer,
+	.measure = crypto_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
+
+const struct bench bench_crypto_decrypt = {
+	.name = "crypto-decrypt",
+	.argp = &bench_crypto_argp,
+	.validate = crypto_validate,
+	.setup = crypto_decrypt_setup,
+	.producer_thread = crypto_producer,
+	.measure = crypto_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
diff --git a/tools/testing/selftests/bpf/progs/crypto_bench.c b/tools/testing/selftests/bpf/progs/crypto_bench.c
new file mode 100644
index 000000000000..bd01794a0236
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/crypto_bench.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_kfuncs.h"
+#include "crypto_common.h"
+
+const volatile unsigned int len = 16;
+char dst[256] = {};
+long hits = 0;
+int status;
+char cipher[128] = {};
+u8 key[256] = {};
+
+SEC("syscall")
+int crypto_setup(struct crypto_syscall_args *args)
+{
+	struct bpf_crypto_ctx *cctx;
+	struct bpf_crypto_params params = {
+		.type = "skcipher",
+		.key_len = args->key_len,
+		.authsize = args->authsize,
+	};
+	int err = 0;
+
+	status = 0;
+
+	if (!cipher[0] || !args->key_len || args->key_len > 255) {
+		status = -EINVAL;
+		return 0;
+	}
+
+	__builtin_memcpy(&params.algo, cipher, sizeof(cipher));
+	__builtin_memcpy(&params.key, key, sizeof(key));
+	cctx = bpf_crypto_ctx_create(&params, &err);
+
+	if (!cctx) {
+		status = err;
+		return 0;
+	}
+
+	err = crypto_ctx_insert(cctx);
+	if (err && err != -EEXIST)
+		status = err;
+
+	return 0;
+}
+
+SEC("tc")
+int crypto_encrypt(struct __sk_buff *skb)
+{
+	struct __crypto_ctx_value *v;
+	struct bpf_crypto_ctx *ctx;
+	struct bpf_dynptr psrc, pdst, iv;
+
+	v = crypto_ctx_value_lookup();
+	if (!v) {
+		status = -ENOENT;
+		return 0;
+	}
+
+	ctx = v->ctx;
+	if (!ctx) {
+		status = -ENOENT;
+		return 0;
+	}
+
+	bpf_dynptr_from_skb(skb, 0, &psrc);
+	bpf_dynptr_from_mem(dst, len, 0, &pdst);
+	bpf_dynptr_from_mem(dst, 0, 0, &iv);
+
+	status = bpf_crypto_encrypt(ctx, &psrc, &pdst, &iv);
+	__sync_add_and_fetch(&hits, 1);
+
+	return 0;
+}
+
+SEC("tc")
+int crypto_decrypt(struct __sk_buff *skb)
+{
+	struct bpf_dynptr psrc, pdst, iv;
+	struct __crypto_ctx_value *v;
+	struct bpf_crypto_ctx *ctx;
+
+	v = crypto_ctx_value_lookup();
+	if (!v)
+		return -ENOENT;
+
+	ctx = v->ctx;
+	if (!ctx)
+		return -ENOENT;
+
+	bpf_dynptr_from_skb(skb, 0, &psrc);
+	bpf_dynptr_from_mem(dst, len, 0, &pdst);
+	bpf_dynptr_from_mem(dst, 0, 0, &iv);
+
+	status = bpf_crypto_decrypt(ctx, &psrc, &pdst, &iv);
+	__sync_add_and_fetch(&hits, 1);
+
+	return 0;
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.43.0


