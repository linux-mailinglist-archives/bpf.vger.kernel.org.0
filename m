Return-Path: <bpf+bounces-56396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6892A96C7C
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 15:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC15517C598
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 13:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C17284B35;
	Tue, 22 Apr 2025 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="Fp67FSUd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lPDESPu4"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97432284B25;
	Tue, 22 Apr 2025 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328245; cv=none; b=g4cdm0Ryad157g9DkDGJ+IGpCb+vkJcbUraoNZegjRn6DejqZrqFc9ZkN37+Ne4Zdo/3TDCF+TFBmr3mSSvB/fZqcwmHerqNpty5E2F+IdePQ4LxwJJJZzHDnKyxUn5LZ7Bm2E6yYbekEFg4hdMZP5JBb6w4HGhPq0M8i/m9+jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328245; c=relaxed/simple;
	bh=BKPcVnof0qL6bo/OXoEuejvCH89D+JHmOcqST1NAdto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WlejJbIbA5zax6n2yv+y8QGXqcetnsLm6yBvl5FJMSb37sNoyvUCJENGNzI08n5fY4foXJPppEEssyMxKAZm9YGS8EgpzehSLXy39IZ6Jx0m/mzYqkRApjS7aaDSsYf9UBVnFDmsIMvL6YteKHVdkGpf8zyEHQaVgRvtt6AEwlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=Fp67FSUd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lPDESPu4; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 52933114017F;
	Tue, 22 Apr 2025 09:24:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 22 Apr 2025 09:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1745328242; x=1745414642; bh=qbCIWcrzbl0DhYPHkZA7wrVFBMRcRSBA
	BBDl3xOB8RA=; b=Fp67FSUdy7UIJ4n/EgtfKjo7aXvfzsfQSOEr+L9quluByEUR
	ehSowCYy8Hzjv7mjv5rmKc5pKcTmMAnsxKWjfFfiBkb3KulOwRRKEgdR4E+9KfbF
	zqoAfVvJEGdoJWPwU+bSb0sWHn7GhtgFaXuhU1awfF/mZH8NsT4h5fT6fw+IE+GT
	Gq1aVx4bLSawEYQh2l+M9g7AwHAt71kjqL0CtW8xoaInuIbsmZH5CEdOx3mZoPh4
	91pQyo58Cwff4fvYR+3EPsyKbWKm7yQJWVyRR0njVZyKSiWIQSU1Q/05iiAXTscu
	E2pU+xcYMm4HQZxcOyWwUKSH1iwSiTCpR+mpKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745328242; x=
	1745414642; bh=qbCIWcrzbl0DhYPHkZA7wrVFBMRcRSBABBDl3xOB8RA=; b=l
	PDESPu4VAQQv7I+nvLE1AuGxKu70CXwavFeHn8qWzBGFy2figYuJSpqaW60gkLfI
	XPf7nMvM6sLcg0s1dE51pNd4PENW5p1JSjePxt2b+8tpIpYN/zdHHuGLmWXEpYus
	qDOkgbnluXL4jZ4PMQmhlVAuSmB7dVH+zr1S2B1Cul2TmPnpjjKxhesltakAYVnJ
	/xWn8WZusyebts3mEeTPgDW6oBThepV4O78ThsEihmVf4uXp8gxLlJkF0bNMAQJ5
	2jBTNJKMgrh4Mn4BeVjdm0mVEcSP3eLFNBT+zs/0D86Me8cckC3PimIDEHJ0Je/z
	OGT4msj/gnbPn9H+hY9Eg==
X-ME-Sender: <xms:cZgHaCG1CqV9zvZ8n4iqz_F7k899O62vvRA8CwKncVtN0dvGtS4wKg>
    <xme:cZgHaDXhrMRslchLXyucLOVbMDAPOWh6XF789jC2h3_G5e3LC9rvTqclK69vbQKYs
    P7aW7JCMVOarvLlXOM>
X-ME-Received: <xmr:cZgHaMLZLZqbkQTY-9jbe8zANMIEDWpHG2ClUQQxSvycBe3-p9okx2N0_C2XfDbEdG1rSuN-DTpkZkuf6As>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehrthhhuhhrucfhrggs
    rhgvuceorghrthhhuhhrsegrrhhthhhurhhfrggsrhgvrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejkeehffejvdefhedtleetgfeivdetgfefffetkeelieefvdefhfeuveevhffh
    ueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohepuddvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohephigrnhestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrfihksehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepthhhohhilhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhope
    hjsghrrghnuggvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopegs
    phhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:cZgHaMFv5Rbtq0GzLajBpyd_7W9UcAv_oaVCsbnVdb6K4zK5dceuww>
    <xmx:cpgHaIW_R4JsaSkiaTD4-YeMMyAt2t5U1GosNsllywR5xHzcgsFPWg>
    <xmx:cpgHaPOlIFRjgC8_4wudJgz_-CUkUOIrh_2ABbt-yDIc5fQhHzHhZQ>
    <xmx:cpgHaP2LoE8eLBjUvAjWOCBoiq7lXbjsNtd8R78epDDJWrxcG5Xdtg>
    <xmx:cpgHaPp2GOqaGLuGb6Tk7bGT0OHtspB-LNai6GeqyLmZcr7LueEKx75o>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 09:24:00 -0400 (EDT)
From: Arthur Fabre <arthur@arthurfabre.com>
Date: Tue, 22 Apr 2025 15:23:34 +0200
Subject: [PATCH RFC bpf-next v2 05/17] trait: XDP benchmark
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-afabre-traits-010-rfc2-v2-5-92bcc6b146c9@arthurfabre.com>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
In-Reply-To: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 ast@kernel.org, kuba@kernel.org, edumazet@google.com, 
 Arthur Fabre <arthur@arthurfabre.com>
X-Mailer: b4 0.14.2

Benchmarks for:

* Getting a trait.
* Setting a trait, with no traits already stored after it.
* Moving traits, when setting or deleting a trait with traits stored
  after it.

Signed-off-by: Arthur Fabre <arthur@arthurfabre.com>
---
 tools/testing/selftests/bpf/Makefile               |   2 +
 tools/testing/selftests/bpf/bench.c                |   8 ++
 .../selftests/bpf/benchs/bench_xdp_traits.c        | 160 +++++++++++++++++++++
 .../testing/selftests/bpf/progs/bench_xdp_traits.c | 128 +++++++++++++++++
 4 files changed, 298 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 03663222a0a5503bc4a265301621c3f9b239537a..4f0636c488ca9cbae9a7b2a269a7bc2722d2bba5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -812,6 +812,7 @@ $(OUTPUT)/bench_bpf_hashmap_lookup.o: $(OUTPUT)/bpf_hashmap_lookup.skel.h
 $(OUTPUT)/bench_htab_mem.o: $(OUTPUT)/htab_mem_bench.skel.h
 $(OUTPUT)/bench_bpf_crypto.o: $(OUTPUT)/crypto_bench.skel.h
 $(OUTPUT)/bench_sockmap.o: $(OUTPUT)/bench_sockmap_prog.skel.h
+$(OUTPUT)/bench_xdp_traits.o: $(OUTPUT)/bench_xdp_traits.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
@@ -833,6 +834,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_htab_mem.o \
 		 $(OUTPUT)/bench_bpf_crypto.o \
 		 $(OUTPUT)/bench_sockmap.o \
+		 $(OUTPUT)/bench_xdp_traits.o \
 		 #
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index c80df9b7509432ab836cd624bbf943d0bff008bc..d25c6309c4abfebd868809fccfdf8ecdbe5edabf 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -284,6 +284,7 @@ extern struct argp bench_htab_mem_argp;
 extern struct argp bench_trigger_batch_argp;
 extern struct argp bench_crypto_argp;
 extern struct argp bench_sockmap_argp;
+extern struct argp bench_trait_argp;
 
 static const struct argp_child bench_parsers[] = {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
@@ -299,6 +300,7 @@ static const struct argp_child bench_parsers[] = {
 	{ &bench_trigger_batch_argp, 0, "BPF triggering benchmark", 0 },
 	{ &bench_crypto_argp, 0, "bpf crypto benchmark", 0 },
 	{ &bench_sockmap_argp, 0, "bpf sockmap benchmark", 0 },
+	{ &bench_trait_argp, 0, "XDP trait benchmark", 0 },
 	{},
 };
 
@@ -552,6 +554,9 @@ extern const struct bench bench_htab_mem;
 extern const struct bench bench_crypto_encrypt;
 extern const struct bench bench_crypto_decrypt;
 extern const struct bench bench_sockmap;
+extern const struct bench bench_xdp_trait_get;
+extern const struct bench bench_xdp_trait_set;
+extern const struct bench bench_xdp_trait_move;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -613,6 +618,9 @@ static const struct bench *benchs[] = {
 	&bench_crypto_encrypt,
 	&bench_crypto_decrypt,
 	&bench_sockmap,
+	&bench_xdp_trait_get,
+	&bench_xdp_trait_set,
+	&bench_xdp_trait_move,
 };
 
 static void find_benchmark(void)
diff --git a/tools/testing/selftests/bpf/benchs/bench_xdp_traits.c b/tools/testing/selftests/bpf/benchs/bench_xdp_traits.c
new file mode 100644
index 0000000000000000000000000000000000000000..3964002c27d454ab17fde305d0d2bbd94007cbaf
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_xdp_traits.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <argp.h>
+#include "bench.h"
+#include "bench_xdp_traits.skel.h"
+
+static struct trait_ctx {
+	struct bench_xdp_traits *skel;
+	int pfd;
+} ctx;
+
+static struct trait_args {
+	u32 trait_len;
+} args = {
+	.trait_len = 2,
+};
+
+enum {
+	ARG_TRAIT_LEN = 6000,
+};
+
+static const struct argp_option opts[] = {
+	{ "trait-len", ARG_TRAIT_LEN, "TRAIT_LEN", 0,
+	  "Set the length of the trait set/get" },
+	{},
+};
+
+static error_t trait_parse_arg(int key, char *arg, struct argp_state *state)
+{
+	switch (key) {
+	case ARG_TRAIT_LEN:
+		args.trait_len = strtoul(arg, NULL, 10);
+		if (args.trait_len != 0 && args.trait_len != 4 && args.trait_len != 8) {
+			fprintf(stderr, "Invalid trait length\n");
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
+const struct argp bench_trait_argp = {
+	.options = opts,
+	.parser = trait_parse_arg,
+};
+
+static void trait_validate(void)
+{
+	if (env.consumer_cnt != 0) {
+		fprintf(stderr, "bpf trait benchmark doesn't support consumer!\n");
+		exit(1);
+	}
+}
+
+static void trait_setup(void)
+{
+	int err;
+
+	setup_libbpf();
+
+	ctx.skel = bench_xdp_traits__open();
+	if (!ctx.skel) {
+		fprintf(stderr, "failed to open skeleton\n");
+		exit(1);
+	}
+
+	ctx.skel->bss->trait_len = args.trait_len;
+
+	err = bench_xdp_traits__load(ctx.skel);
+	if (err) {
+		fprintf(stderr, "failed to load skeleton\n");
+		bench_xdp_traits__destroy(ctx.skel);
+		exit(1);
+	}
+}
+
+static void trait_get_setup(void)
+{
+	trait_setup();
+	ctx.pfd = bpf_program__fd(ctx.skel->progs.trait_get);
+}
+
+static void trait_set_setup(void)
+{
+	trait_setup();
+	ctx.pfd = bpf_program__fd(ctx.skel->progs.trait_set);
+}
+
+static void trait_move_setup(void)
+{
+	trait_setup();
+	ctx.pfd = bpf_program__fd(ctx.skel->progs.trait_move);
+}
+
+static void trait_measure(struct bench_res *res)
+{
+	res->hits = atomic_swap(&ctx.skel->bss->hits, 0);
+}
+
+static void *trait_producer(void *unused)
+{
+	static char in[14];
+	int err;
+
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in = in,
+		.data_size_in = sizeof(in),
+		.repeat = 256, // max
+	);
+
+	while (true) {
+		err = bpf_prog_test_run_opts(ctx.pfd, &opts);
+		if (err != 0) {
+			fprintf(stderr, "failed to prog_run: %d\n", err);
+			return NULL;
+		}
+		if (opts.retval != 0) {
+			fprintf(stderr, "prog didn't return 0: %d\n", opts.retval);
+			return NULL;
+		}
+	}
+
+	return NULL;
+}
+
+const struct bench bench_xdp_trait_get = {
+	.name = "xdp-trait-get",
+	.argp = &bench_trait_argp,
+	.validate = trait_validate,
+	.setup = trait_get_setup,
+	.producer_thread = trait_producer,
+	.measure = trait_measure,
+	.report_progress = ops_report_progress,
+	.report_final = ops_report_final,
+};
+
+const struct bench bench_xdp_trait_set = {
+	.name = "xdp-trait-set",
+	.argp = &bench_trait_argp,
+	.validate = trait_validate,
+	.setup = trait_set_setup,
+	.producer_thread = trait_producer,
+	.measure = trait_measure,
+	.report_progress = ops_report_progress,
+	.report_final = ops_report_final,
+};
+
+const struct bench bench_xdp_trait_move = {
+	.name = "xdp-trait-move",
+	.argp = &bench_trait_argp,
+	.validate = trait_validate,
+	.setup = trait_move_setup,
+	.producer_thread = trait_producer,
+	.measure = trait_measure,
+	.report_progress = ops_report_progress,
+	.report_final = ops_report_final,
+};
diff --git a/tools/testing/selftests/bpf/progs/bench_xdp_traits.c b/tools/testing/selftests/bpf/progs/bench_xdp_traits.c
new file mode 100644
index 0000000000000000000000000000000000000000..70949f8e78ead1e1e8a0172ed9388183344c1e11
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bench_xdp_traits.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <errno.h>
+
+extern int bpf_xdp_trait_set(const struct xdp_md *xdp, __u64 key,
+			     const void *val, __u64 val__sz,
+			     __u64 flags) __ksym;
+extern int bpf_xdp_trait_get(const struct xdp_md *xdp, __u64 key, void *val,
+			     __u64 val__sz) __ksym;
+extern int bpf_xdp_trait_del(const struct xdp_md *xdp, __u64 key) __ksym;
+
+__u32 trait_len;
+long hits = 0;
+
+#define ITERATIONS (10000)
+
+SEC("xdp")
+int trait_get(struct xdp_md *xdp)
+{
+	int ret, i;
+	__u32 val4 = 0xdeadbeef;
+	__u64 val8 = 0xdeadbeefafafcfcf;
+
+#define BENCH_GET(val, size) do { \
+		ret = bpf_xdp_trait_set(xdp, 32, val, size, 0);			\
+		if (ret != 0)							\
+			return ret;						\
+		for (i = 0; i < ITERATIONS; i++)				\
+			ret = bpf_xdp_trait_get(xdp, 32, val, size);		\
+		if (ret != size)						\
+			return ret;						\
+	} while (0)
+
+	switch (trait_len) {
+	case 0:
+		BENCH_GET(NULL, 0);
+		break;
+	case 4:
+		BENCH_GET(&val4, sizeof(val4));
+		break;
+	case 8:
+		BENCH_GET(&val8, sizeof(val8));
+		break;
+	}
+
+	__sync_add_and_fetch(&hits, ITERATIONS);
+	return 0;
+}
+
+SEC("xdp")
+int trait_set(struct xdp_md *xdp)
+{
+	int ret, i;
+	__u32 val4 = 0xdeadbeef;
+	__u64 val8 = 0xdeadbeefafafcfcf;
+
+#define BENCH_SET(val, size) do { \
+		for (i = 0; i < ITERATIONS; i++)			\
+			ret = bpf_xdp_trait_set(xdp, 32, val, size, 0);	\
+	} while (0)
+
+	switch (trait_len) {
+	case 0:
+		BENCH_SET(NULL, 0);
+		break;
+	case 4:
+		BENCH_SET(&val4, sizeof(val4));
+		break;
+	case 8:
+		BENCH_SET(&val8, sizeof(val8));
+		break;
+	}
+
+	if (ret != 0)
+		return ret;
+
+	__sync_add_and_fetch(&hits, ITERATIONS);
+	return 0;
+}
+
+SEC("xdp")
+int trait_move(struct xdp_md *xdp)
+{
+	int ret, ret_del, i;
+	__u32 val4 = 0xdeadbeef;
+	__u64 val8 = 0xdeadbeefafafcfcf;
+
+#define BENCH_MOVE(val, size) do { \
+		for (i = 0; i < 8; i++)	{						\
+			ret = bpf_xdp_trait_set(xdp, 40+i, &val8, sizeof(val8), 0);	\
+			if (ret != 0)							\
+				return ret;						\
+		}									\
+		/* We do two operations per iteration, so do half as many to make it
+		 * vaguely comparable with other benchmarks
+		 */									\
+		for (i = 0; i < ITERATIONS/2; i++) {					\
+			/* Need to delete after, otherwise we'll just overwrite an
+			 * existing trait and there will be nothing to move.
+			 */								\
+			ret = bpf_xdp_trait_set(xdp, 32, val, size, 0);			\
+			ret_del = bpf_xdp_trait_del(xdp, 32);				\
+		}									\
+	} while (0)
+
+	switch (trait_len) {
+	case 0:
+		BENCH_MOVE(NULL, 0);
+		break;
+	case 4:
+		BENCH_MOVE(&val4, sizeof(val4));
+		break;
+	case 8:
+		BENCH_MOVE(&val8, sizeof(val8));
+		break;
+	}
+
+	if (ret != 0)
+		return ret;
+	if (ret_del != 0)
+		return ret_del;
+
+	__sync_add_and_fetch(&hits, ITERATIONS);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.43.0


