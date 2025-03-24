Return-Path: <bpf+bounces-54610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE236A6D9C8
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 13:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668BE3B1D2B
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 12:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A709425E469;
	Mon, 24 Mar 2025 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7axskv8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485F1D514A
	for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742817850; cv=none; b=XH7ht7G/TWpWZe2Y0HNDM4sNYHLkmELdoqPiIQSJpeCDdlcyx5D7Ta9vXJntE+DrGLdGidPDd8grJ3WzRgta0tL456gQB11rLdUeSrWn0qLiwGB/QI/AYFalcGLEFIbOCLrnLNCM39gsLCwAKWxjFVxY0E38FBGtPx/R02TJ08A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742817850; c=relaxed/simple;
	bh=In5ohEsw2IWjHRVAkLDP3PeQ1zEQaI+jzpx+sNC8CBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3erYsmG9r8NWBIxZWv3UDBi5a5PbXsD2U61OXX+K12ZLihgbH1XNX8wBXbazx0d5XF3pCSkQ4BlRwQNhQ/Nm/EALLTdNlAj51NO4m2hF/H/J/bHUYxYjc118UiT9OD5yQkCQ8NRx3RFSmVhAgmxCtuip6ZzsnyMsOrrSFgmhC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S7axskv8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742817847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dURCyZBW8dO76YYy7E2XBVs2tvMeb1MOr1YElQtgnG0=;
	b=S7axskv8WM6Fq9euPKltoGe+Hswecae65szk2xELIc0cRYa4ljMuN3GtoZH7QRXHVS5ZkU
	DHo5sXJEE8QUz6NqqYy6ZxXjHHRf2BUqLLAGg/+VD45WVaWf3QmAuhuIDptiNOQSc+Oe4o
	ZfliOIEecSTo3pqnbU2zvmLLsKv2wns=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-2kQIYx6qNl-a40MZCJnk5A-1; Mon,
 24 Mar 2025 08:04:03 -0400
X-MC-Unique: 2kQIYx6qNl-a40MZCJnk5A-1
X-Mimecast-MFC-AGG-ID: 2kQIYx6qNl-a40MZCJnk5A_1742817840
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D4E7180AF68;
	Mon, 24 Mar 2025 12:04:00 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.25])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77814180A803;
	Mon, 24 Mar 2025 12:03:54 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Add benchmark for bounded/unbounded string kfuncs
Date: Mon, 24 Mar 2025 13:03:30 +0100
Message-ID: <ecb1300906ac106648a1bbfdd33895fb12275761.1741874348.git.vmalik@redhat.com>
In-Reply-To: <cover.1741874348.git.vmalik@redhat.com>
References: <cover.1741874348.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add a new benchmark using the existing bench infrastructure which
compares performance of bounded and unbounded string kfuncs added in the
previous commits.

Running on x86_64 and arm64, the most significant difference is in the
strlen/strnlen and strstr/strnstr comparisons on arm64:

    strlen/strnlen
    ==============
    strlen-1             0.453 ± 0.002M/s (drops 0.000 ± 0.000M/s)
    strnlen-1            0.470 ± 0.006M/s (drops 0.000 ± 0.000M/s)
    strlen-8             0.459 ± 0.011M/s (drops 0.000 ± 0.000M/s)
    strnlen-8            0.451 ± 0.006M/s (drops 0.000 ± 0.000M/s)
    strlen-64            0.439 ± 0.007M/s (drops 0.000 ± 0.000M/s)
    strnlen-64           0.455 ± 0.006M/s (drops 0.000 ± 0.000M/s)
    strlen-512           0.359 ± 0.006M/s (drops 0.000 ± 0.000M/s)
    strnlen-512          0.441 ± 0.007M/s (drops 0.000 ± 0.000M/s)
    strlen-2048          0.232 ± 0.003M/s (drops 0.000 ± 0.000M/s)
    strnlen-2048         0.403 ± 0.005M/s (drops 0.000 ± 0.000M/s)
    strlen-4095          0.151 ± 0.001M/s (drops 0.000 ± 0.000M/s)
    strnlen-4095         0.362 ± 0.005M/s (drops 0.000 ± 0.000M/s)

    strstr/strnstr
    ==============
    strstr-8             0.452 ± 0.005M/s (drops 0.000 ± 0.000M/s)
    strnstr-8            0.442 ± 0.006M/s (drops 0.000 ± 0.000M/s)
    strstr-64            0.390 ± 0.004M/s (drops 0.000 ± 0.000M/s)
    strnstr-64           0.400 ± 0.004M/s (drops 0.000 ± 0.000M/s)
    strstr-512           0.228 ± 0.003M/s (drops 0.000 ± 0.000M/s)
    strnstr-512          0.256 ± 0.002M/s (drops 0.000 ± 0.000M/s)
    strstr-2048          0.095 ± 0.001M/s (drops 0.000 ± 0.000M/s)
    strnstr-2048         0.113 ± 0.001M/s (drops 0.000 ± 0.000M/s)
    strstr-4095          0.052 ± 0.001M/s (drops 0.000 ± 0.000M/s)
    strnstr-4095         0.064 ± 0.001M/s (drops 0.000 ± 0.000M/s)

For strings longer than 64B, the unbounded variants are notably faster,
having as much as 140% performance gain over the bounded variants
(strncmp for strings of length 4095). The reason is that arm64 has an
optimized implementation of strnlen in assembly which is also used
inside strnstr.

On x86_64, which doesn't have any optimized string operations, there is
still an observable difference in strlen/strnlen and strstr/strnstr,
albeit much smaller than for arm64:

    strlen/strnlen
    ==============
    strlen-1             7.021 ± 0.036M/s (drops 0.000 ± 0.000M/s)
    strnlen-1            7.000 ± 0.038M/s (drops 0.000 ± 0.000M/s)
    strlen-8             6.837 ± 0.011M/s (drops 0.000 ± 0.000M/s)
    strnlen-8            6.832 ± 0.064M/s (drops 0.000 ± 0.000M/s)
    strlen-64            5.638 ± 0.026M/s (drops 0.000 ± 0.000M/s)
    strnlen-64           6.010 ± 0.034M/s (drops 0.000 ± 0.000M/s)
    strlen-512           3.322 ± 0.011M/s (drops 0.000 ± 0.000M/s)
    strnlen-512          3.449 ± 0.014M/s (drops 0.000 ± 0.000M/s)
    strlen-2048          1.390 ± 0.007M/s (drops 0.000 ± 0.000M/s)
    strnlen-2048         1.429 ± 0.003M/s (drops 0.000 ± 0.000M/s)
    strlen-4095          0.786 ± 0.003M/s (drops 0.000 ± 0.000M/s)
    strnlen-4095         0.803 ± 0.002M/s (drops 0.000 ± 0.000M/s)

    strstr/strnstr
    ==============
    strstr-8             6.031 ± 0.012M/s (drops 0.000 ± 0.000M/s)
    strnstr-8            6.322 ± 0.048M/s (drops 0.000 ± 0.000M/s)
    strstr-64            3.221 ± 0.054M/s (drops 0.000 ± 0.000M/s)
    strnstr-64           3.059 ± 0.025M/s (drops 0.000 ± 0.000M/s)
    strstr-512           0.734 ± 0.006M/s (drops 0.000 ± 0.000M/s)
    strnstr-512          0.849 ± 0.004M/s (drops 0.000 ± 0.000M/s)
    strstr-2048          0.220 ± 0.004M/s (drops 0.000 ± 0.000M/s)
    strnstr-2048         0.246 ± 0.002M/s (drops 0.000 ± 0.000M/s)
    strstr-4095          0.104 ± 0.000M/s (drops 0.000 ± 0.000M/s)
    strnstr-4095         0.122 ± 0.000M/s (drops 0.000 ± 0.000M/s)

The performance gain of the bounded variants on strings over 64B is
3%-6% for strlen/strnlen and 12%-18% for strstr/strnstr. The likely
explanation is that the unbounded variants use __get_kernel_nofault
instead of plain derefence which introduces some small overhead. This
manifests mainly in the above functions as they iterate multiple
strings (i.e. use __get_kernel_nofault more).

For the rest of the functions in the benchmark (strchr/strnchr and
strchrnul/strnchrnul), the performance difference is negligable or
within the bounds of a statistical error, with an exception of
strchr/strnchr on arm64:

    strchr/strnchr
    ==============
    strchr-1             0.475 ± 0.010M/s (drops 0.000 ± 0.000M/s)
    strnchr-1            0.469 ± 0.008M/s (drops 0.000 ± 0.000M/s)
    strchr-8             0.448 ± 0.011M/s (drops 0.000 ± 0.000M/s)
    strnchr-8            0.472 ± 0.006M/s (drops 0.000 ± 0.000M/s)
    strchr-64            0.432 ± 0.010M/s (drops 0.000 ± 0.000M/s)
    strnchr-64           0.445 ± 0.008M/s (drops 0.000 ± 0.000M/s)
    strchr-512           0.308 ± 0.003M/s (drops 0.000 ± 0.000M/s)
    strnchr-512          0.330 ± 0.005M/s (drops 0.000 ± 0.000M/s)
    strchr-2048          0.156 ± 0.002M/s (drops 0.000 ± 0.000M/s)
    strnchr-2048         0.186 ± 0.003M/s (drops 0.000 ± 0.000M/s)
    strchr-4095          0.094 ± 0.001M/s (drops 0.000 ± 0.000M/s)
    strnchr-4095         0.115 ± 0.004M/s (drops 0.000 ± 0.000M/s)

Here, I'm not sure what the reason for the performance benefit is,
possibly a combination of compiler optimizations and
__get_kernel_nofault overhead.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |  21 ++
 .../bpf/benchs/bench_string_kfuncs.c          | 259 ++++++++++++++++++
 .../bpf/benchs/run_bench_string_kfuncs.sh     |  34 +++
 .../selftests/bpf/progs/string_kfuncs_bench.c |  88 ++++++
 5 files changed, 404 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_string_kfuncs.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_string_kfuncs.sh
 create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs_bench.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ca41d47d4ba6..d04f7e78c8ab 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -813,6 +813,7 @@ $(OUTPUT)/bench_local_storage_create.o: $(OUTPUT)/bench_local_storage_create.ske
 $(OUTPUT)/bench_bpf_hashmap_lookup.o: $(OUTPUT)/bpf_hashmap_lookup.skel.h
 $(OUTPUT)/bench_htab_mem.o: $(OUTPUT)/htab_mem_bench.skel.h
 $(OUTPUT)/bench_bpf_crypto.o: $(OUTPUT)/crypto_bench.skel.h
+$(OUTPUT)/bench_string_kfuncs.o: $(OUTPUT)/string_kfuncs_bench.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
@@ -833,6 +834,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_local_storage_create.o \
 		 $(OUTPUT)/bench_htab_mem.o \
 		 $(OUTPUT)/bench_bpf_crypto.o \
+		 $(OUTPUT)/bench_string_kfuncs.o \
 		 #
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 1bd403a5ef7b..5aa7f63436f6 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -283,6 +283,7 @@ extern struct argp bench_local_storage_create_argp;
 extern struct argp bench_htab_mem_argp;
 extern struct argp bench_trigger_batch_argp;
 extern struct argp bench_crypto_argp;
+extern struct argp bench_string_kfuncs_argp;
 
 static const struct argp_child bench_parsers[] = {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
@@ -297,6 +298,7 @@ static const struct argp_child bench_parsers[] = {
 	{ &bench_htab_mem_argp, 0, "hash map memory benchmark", 0 },
 	{ &bench_trigger_batch_argp, 0, "BPF triggering benchmark", 0 },
 	{ &bench_crypto_argp, 0, "bpf crypto benchmark", 0 },
+	{ &bench_string_kfuncs_argp, 0, "string kfuncs benchmark", 0 },
 	{},
 };
 
@@ -550,6 +552,16 @@ extern const struct bench bench_htab_mem;
 extern const struct bench bench_crypto_encrypt;
 extern const struct bench bench_crypto_decrypt;
 
+/* string kfunc benchmarks */
+extern const struct bench bench_string_kfuncs_strlen;
+extern const struct bench bench_string_kfuncs_strnlen;
+extern const struct bench bench_string_kfuncs_strchr;
+extern const struct bench bench_string_kfuncs_strnchr;
+extern const struct bench bench_string_kfuncs_strchrnul;
+extern const struct bench bench_string_kfuncs_strnchrnul;
+extern const struct bench bench_string_kfuncs_strstr;
+extern const struct bench bench_string_kfuncs_strnstr;
+
 static const struct bench *benchs[] = {
 	&bench_count_global,
 	&bench_count_local,
@@ -609,6 +621,15 @@ static const struct bench *benchs[] = {
 	&bench_htab_mem,
 	&bench_crypto_encrypt,
 	&bench_crypto_decrypt,
+	/* string kfuncs */
+	&bench_string_kfuncs_strlen,
+	&bench_string_kfuncs_strnlen,
+	&bench_string_kfuncs_strchr,
+	&bench_string_kfuncs_strnchr,
+	&bench_string_kfuncs_strchrnul,
+	&bench_string_kfuncs_strnchrnul,
+	&bench_string_kfuncs_strstr,
+	&bench_string_kfuncs_strnstr,
 };
 
 static void find_benchmark(void)
diff --git a/tools/testing/selftests/bpf/benchs/bench_string_kfuncs.c b/tools/testing/selftests/bpf/benchs/bench_string_kfuncs.c
new file mode 100644
index 000000000000..a2e11af092ce
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_string_kfuncs.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025. Red Hat, Inc. */
+#include <argp.h>
+#include "bench.h"
+#include "string_kfuncs_bench.skel.h"
+
+static struct string_kfuncs_ctx {
+	struct string_kfuncs_bench *skel;
+} ctx;
+
+static struct string_kfuncs_args {
+	u32 str_len;
+} args = {
+	.str_len = 32,
+};
+
+enum {
+	ARG_STR_LEN = 5000,
+};
+
+static const struct argp_option opts[] = {
+	{ "str-len", ARG_STR_LEN, "STR_LEN", 0, "Set the length of string(s)" },
+	{},
+};
+
+static error_t string_kfuncs_parse_arg(int key, char *arg, struct argp_state *state)
+{
+	switch (key) {
+	case ARG_STR_LEN:
+		args.str_len = strtoul(arg, NULL, 10);
+		if (!args.str_len ||
+		    args.str_len >= sizeof(ctx.skel->bss->str)) {
+			fprintf(stderr, "Invalid str len (limit %zu)\n",
+				sizeof(ctx.skel->bss->str) - 1);
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
+const struct argp bench_string_kfuncs_argp = {
+	.options = opts,
+	.parser = string_kfuncs_parse_arg,
+};
+
+static void string_kfuncs_validate(void)
+{
+	if (env.consumer_cnt != 0) {
+		fprintf(stderr, "string_kfuncs benchmark doesn't support consumer!\n");
+		exit(1);
+	}
+}
+
+static void string_kfuncs_setup(void)
+{
+	int err;
+	char *str;
+	size_t i, sz, quarter;
+
+	sz = sizeof(ctx.skel->bss->str);
+	if (!sz) {
+		fprintf(stderr, "invalid string size (%zu)\n", sz);
+		exit(1);
+	}
+
+	setup_libbpf();
+
+	ctx.skel = string_kfuncs_bench__open();
+	if (!ctx.skel) {
+		fprintf(stderr, "failed to open skeleton\n");
+		exit(1);
+	}
+
+	/* Fill str with random digits 1-9 */
+	srandom(time(NULL));
+	str = ctx.skel->bss->str;
+	for (i = 0; i < args.str_len - 1; i++)
+		str[i] = '1' + random() % 9;
+
+	/* For strchr and variants - set the last character to '0' */
+	str[args.str_len - 1] = '0';
+	str[args.str_len] = '\0';
+
+	/* For strstr and variants - copy the last quarter of str to substr */
+	quarter = args.str_len / 4;
+	memcpy(ctx.skel->bss->substr, str + args.str_len - quarter, quarter + 1);
+
+	ctx.skel->rodata->str_len = args.str_len;
+
+	err = string_kfuncs_bench__load(ctx.skel);
+	if (err) {
+		fprintf(stderr, "failed to load skeleton\n");
+		string_kfuncs_bench__destroy(ctx.skel);
+		exit(1);
+	}
+}
+
+static void string_kfuncs_attach_prog(struct bpf_program *prog)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach(prog);
+	if (!link) {
+		fprintf(stderr, "failed to attach program!\n");
+		exit(1);
+	}
+}
+
+static void string_kfuncs_strlen_setup(void)
+{
+	string_kfuncs_setup();
+	string_kfuncs_attach_prog(ctx.skel->progs.strlen_bench);
+}
+
+static void string_kfuncs_strnlen_setup(void)
+{
+	string_kfuncs_setup();
+	string_kfuncs_attach_prog(ctx.skel->progs.strnlen_bench);
+}
+
+static void string_kfuncs_strchr_setup(void)
+{
+	string_kfuncs_setup();
+	string_kfuncs_attach_prog(ctx.skel->progs.strchr_bench);
+}
+
+static void string_kfuncs_strnchr_setup(void)
+{
+	string_kfuncs_setup();
+	string_kfuncs_attach_prog(ctx.skel->progs.strnchr_bench);
+}
+
+static void string_kfuncs_strchrnul_setup(void)
+{
+	string_kfuncs_setup();
+	string_kfuncs_attach_prog(ctx.skel->progs.strchrnul_bench);
+}
+
+static void string_kfuncs_strnchrnul_setup(void)
+{
+	string_kfuncs_setup();
+	string_kfuncs_attach_prog(ctx.skel->progs.strnchrnul_bench);
+}
+
+static void string_kfuncs_strstr_setup(void)
+{
+	string_kfuncs_setup();
+	string_kfuncs_attach_prog(ctx.skel->progs.strstr_bench);
+}
+
+static void string_kfuncs_strnstr_setup(void)
+{
+	string_kfuncs_setup();
+	string_kfuncs_attach_prog(ctx.skel->progs.strnstr_bench);
+}
+
+static void *string_kfuncs_producer(void *ctx)
+{
+	while (true)
+		(void)syscall(__NR_getpgid);
+	return NULL;
+}
+
+static void string_kfuncs_measure(struct bench_res *res)
+{
+	res->hits = atomic_swap(&ctx.skel->bss->hits, 0);
+}
+
+const struct bench bench_string_kfuncs_strlen = {
+	.name = "string-kfuncs-strlen",
+	.argp = &bench_string_kfuncs_argp,
+	.validate = string_kfuncs_validate,
+	.setup = string_kfuncs_strlen_setup,
+	.producer_thread = string_kfuncs_producer,
+	.measure = string_kfuncs_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
+
+const struct bench bench_string_kfuncs_strnlen = {
+	.name = "string-kfuncs-strnlen",
+	.argp = &bench_string_kfuncs_argp,
+	.validate = string_kfuncs_validate,
+	.setup = string_kfuncs_strnlen_setup,
+	.producer_thread = string_kfuncs_producer,
+	.measure = string_kfuncs_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
+
+const struct bench bench_string_kfuncs_strchr = {
+	.name = "string-kfuncs-strchr",
+	.argp = &bench_string_kfuncs_argp,
+	.validate = string_kfuncs_validate,
+	.setup = string_kfuncs_strchr_setup,
+	.producer_thread = string_kfuncs_producer,
+	.measure = string_kfuncs_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
+
+const struct bench bench_string_kfuncs_strnchr = {
+	.name = "string-kfuncs-strnchr",
+	.argp = &bench_string_kfuncs_argp,
+	.validate = string_kfuncs_validate,
+	.setup = string_kfuncs_strnchr_setup,
+	.producer_thread = string_kfuncs_producer,
+	.measure = string_kfuncs_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
+
+const struct bench bench_string_kfuncs_strchrnul = {
+	.name = "string-kfuncs-strchrnul",
+	.argp = &bench_string_kfuncs_argp,
+	.validate = string_kfuncs_validate,
+	.setup = string_kfuncs_strchrnul_setup,
+	.producer_thread = string_kfuncs_producer,
+	.measure = string_kfuncs_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
+
+const struct bench bench_string_kfuncs_strnchrnul = {
+	.name = "string-kfuncs-strnchrnul",
+	.argp = &bench_string_kfuncs_argp,
+	.validate = string_kfuncs_validate,
+	.setup = string_kfuncs_strnchrnul_setup,
+	.producer_thread = string_kfuncs_producer,
+	.measure = string_kfuncs_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
+
+const struct bench bench_string_kfuncs_strstr = {
+	.name = "string-kfuncs-strstr",
+	.argp = &bench_string_kfuncs_argp,
+	.validate = string_kfuncs_validate,
+	.setup = string_kfuncs_strstr_setup,
+	.producer_thread = string_kfuncs_producer,
+	.measure = string_kfuncs_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
+
+const struct bench bench_string_kfuncs_strnstr = {
+	.name = "string-kfuncs-strnstr",
+	.argp = &bench_string_kfuncs_argp,
+	.validate = string_kfuncs_validate,
+	.setup = string_kfuncs_strnstr_setup,
+	.producer_thread = string_kfuncs_producer,
+	.measure = string_kfuncs_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_string_kfuncs.sh b/tools/testing/selftests/bpf/benchs/run_bench_string_kfuncs.sh
new file mode 100755
index 000000000000..5e635681cd85
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_bench_string_kfuncs.sh
@@ -0,0 +1,34 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ./benchs/run_common.sh
+
+set -eufo pipefail
+
+header "strlen/strnlen"
+for s in 1 8 64 512 2048 4095; do
+	for b in strlen strnlen; do
+		summarize ${b}-${s} "$($RUN_BENCH --str-len=$s string-kfuncs-${b})"
+	done
+done
+
+header "strchr/strnchr"
+for s in 1 8 64 512 2048 4095; do
+	for b in strchr strnchr; do
+		summarize ${b}-${s} "$($RUN_BENCH --str-len=$s string-kfuncs-${b})"
+	done
+done
+
+header "strchrnul/strnchrnul"
+for s in 1 8 64 512 2048 4095; do
+	for b in strchrnul strnchrnul; do
+		summarize ${b}-${s} "$($RUN_BENCH --str-len=$s string-kfuncs-${b})"
+	done
+done
+
+header "strstr/strnstr"
+for s in 8 64 512 2048 4095; do
+	for b in strstr strnstr; do
+		summarize ${b}-${s} "$($RUN_BENCH --str-len=$s string-kfuncs-${b})"
+	done
+done
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_bench.c b/tools/testing/selftests/bpf/progs/string_kfuncs_bench.c
new file mode 100644
index 000000000000..e227c54a5b92
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_bench.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025. Red Hat, Inc. */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define STR_SZ 4096
+
+size_t bpf_strlen(const char *s) __ksym;
+size_t bpf_strnlen(void *s, u32 s__sz) __ksym;
+char *bpf_strchr(const char *s, int c) __ksym;
+char *bpf_strnchr(void *s, u32 s__sz, int c) __ksym;
+char *bpf_strchrnul(const char *s, int c) __ksym;
+char *bpf_strnchrnul(void *s, u32 s__sz, int c) __ksym;
+char *bpf_strstr(const char *s1, const char *s2) __ksym;
+char *bpf_strnstr(void *s1, u32 s1__sz, void *s2, u32 s2__sz) __ksym;
+
+/* Will be updated by benchmark before program loading */
+const volatile unsigned int str_len = 1;
+long hits = 0;
+char str[STR_SZ];
+char substr[STR_SZ];
+
+char _license[] SEC("license") = "GPL";
+
+SEC("tp/syscalls/sys_enter_getpgid")
+int strlen_bench(void *ctx)
+{
+	if (bpf_strlen(str) > 0)
+		__sync_add_and_fetch(&hits, 1);
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_getpgid")
+int strnlen_bench(void *ctx)
+{
+	if (bpf_strnlen(str, str_len + 1) > 0)
+		__sync_add_and_fetch(&hits, 1);
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_getpgid")
+int strchr_bench(void *ctx)
+{
+	if (bpf_strchr(str, '0') != NULL)
+		__sync_add_and_fetch(&hits, 1);
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_getpgid")
+int strnchr_bench(void *ctx)
+{
+	if (bpf_strnchr(str, str_len + 1, '0') != NULL)
+		__sync_add_and_fetch(&hits, 1);
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_getpgid")
+int strchrnul_bench(void *ctx)
+{
+	if (*bpf_strchrnul(str, '0') != '\0')
+		__sync_add_and_fetch(&hits, 1);
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_getpgid")
+int strnchrnul_bench(void *ctx)
+{
+	if (*bpf_strnchrnul(str, str_len + 1, '0') != '\0')
+		__sync_add_and_fetch(&hits, 1);
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_getpgid")
+int strstr_bench(void *ctx)
+{
+	if (bpf_strstr(str, substr) != NULL)
+		__sync_add_and_fetch(&hits, 1);
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_getpgid")
+int strnstr_bench(void *ctx)
+{
+	if (bpf_strnstr(str, str_len + 1, substr, str_len / 4 + 1) != NULL)
+		__sync_add_and_fetch(&hits, 1);
+	return 0;
+}
-- 
2.48.1


