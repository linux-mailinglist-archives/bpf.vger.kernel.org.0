Return-Path: <bpf+bounces-53324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D63C7A5021B
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F378418939F2
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BD724EF75;
	Wed,  5 Mar 2025 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="viztjMbF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dY5RhGJo"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E9E24EAB6;
	Wed,  5 Mar 2025 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185207; cv=none; b=mVl0DHMEMtUgHtxhVkMbASLXgbrE8U/b0goKWd+HK73bZTId6Up1v9UpyJYziek1ZQ9ZxAHbd9Fm4X0Z8SUe9Tsft2MRbutbEOI9Zl0Av8vaAD+cwLDGPpcpUZkMAQ+xnfMvHTbfKkRgLIw8R/byKHleXfe6hFidwAITeq+B8nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185207; c=relaxed/simple;
	bh=KczKMFMXFRk+1JUF9WxMHIQEBSxpXI06Ae/1D2VS6n0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BjhhdWfzOwd4SFZx9DnPfvQzLVzK5fG/K7yLJG+MXMtxe1f5MEpBVhGlpJT565GQdlgFopdDc7mahb9QZ0RrMnX1bcNMNUFikZ0ssl9TQyH+cRUviXhXSznZ3yU72ebXEqXPoIxYnqA/KIn3y+w/rfV2gqLpa37p8URZer0K4sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=viztjMbF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dY5RhGJo; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D654813810B2;
	Wed,  5 Mar 2025 09:33:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 05 Mar 2025 09:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741185204; x=1741271604; bh=MzgzHgd06C01r695iBlGOIJt3yonQRko
	SowreVZfXbA=; b=viztjMbF57g689QIrsYfhTdI33HYEJ6h0qCc+6NbvncfHFF+
	lQ5U+nSEyQLX3lIayPaFSHeZDxMOhgQzS8jyglapafmQA8CNfyzJV7GRRTgu24+B
	gcT4/nSLNTvNcuXo58niUjL5h6Aa8rVEIz14jdLRxoTHA6kScsXFW7gOqxB5NW5x
	zDMyfwBNf4SoUvCn9PNvAiPx3oQKMrid0WZFqoD4g16Sar0KCwmOgn3uVPdCEgEp
	1wQ8i4RTrywgkwS6yC/wCQuNjTqxesYAWbv/B2nimF3F4USbPZKJwmyTjlj3eLDj
	Z9UouAdfgvnzsn4ieWlhgXEbKuWzlD/9VUXZpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741185204; x=
	1741271604; bh=MzgzHgd06C01r695iBlGOIJt3yonQRkoSowreVZfXbA=; b=d
	Y5RhGJorN1SoSWU3qMtbMTiB55nkdkKZ/va4eOpHLCW7P5IPJCZzwYqO0+WReXZJ
	1748qlZGhZO8UczyUPw0/0S6vksOOJjaotx6Mfd2aLCzJ9thsknlTM/2dvxMM5sv
	oOXe3CEOOB0gqK7p2h9Fo3IHiUnrHzolsdYNRhpVithwZPP6YlkHSWt2acdRiqhx
	1psoPmqqrrrYsFCmGkaaLrvzER5tkzCUykD5kNTh+l3nwz8R8UnBTgJOR90s5S/t
	X7o0u31vavvqCM2Vn4FsbYhqhViQTHKV5jn/Gpz8ptY9R4KFWRqfoCb0EQB/uQqp
	1CYlZQqvusuXKvKRPOiVA==
X-ME-Sender: <xms:tGDIZ48-w2GuOhvdlF87EQMD2e0mXYDfOsv2IQWhCEA5qMXbqaPsOg>
    <xme:tGDIZws5IABDzhXTzz6eshBeBj1ehh9V4yxdtPE2o4F4nK1JFie5GyuyZplEHYyBt
    BxxOZrBwcmUBYvavJI>
X-ME-Received: <xmr:tGDIZ-CDfBjGNRHYjKMsfieiw9is9mY85pAOQCj1XPS2ykyVF-WuEPnrcy9xwrHdOZbjPssjB63XnjhKC5E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhenucggtf
    frrghtthgvrhhnpeffueehtddtkeetgfelteejledvjeekgeduleffjeetfeekveeggffh
    fefhvdegffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhhohhilhgrnhgusehrvgguhh
    grthdrtghomhdprhgtphhtthhopehlsghirghntghonhesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghfrggsrhgvsegtlhhouhgufhhl
    rghrvgdrtghomhdprhgtphhtthhopehjrghkuhgssegtlhhouhgufhhlrghrvgdrtghomh
    dprhgtphhtthhopeihrghnsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsghrrghnug
    gvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomh
X-ME-Proxy: <xmx:tGDIZ4fS4mK7nXmk8rH620coLRXOVqRmcgnoLl-nhGQuml9kw2KEUg>
    <xmx:tGDIZ9OxcEb4wtQ0MDdW_vR67ELloTZW3zNXCIqFCPn2C_tq9MnGaw>
    <xmx:tGDIZynlKad-67jT0Xyzx52o7DUFvyQhIWkmG4DaJci2oUQYfc-oag>
    <xmx:tGDIZ_v5IhOvGHXI5-0EUHiyFsUIQEA4_tl78AjHhPRCwKwHFWs8eA>
    <xmx:tGDIZwqjfQNu2LIU7ArNjO4ah9bTdxmmVSLlBnnMWiw5722DNQYGwGIr>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 09:33:23 -0500 (EST)
From: arthur@arthurfabre.com
Date: Wed, 05 Mar 2025 15:32:01 +0100
Subject: [PATCH RFC bpf-next 04/20] trait: basic XDP benchmark
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-afabre-traits-010-rfc2-v1-4-d0ecfb869797@cloudflare.com>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 Arthur Fabre <afabre@cloudflare.com>
X-Mailer: b4 0.14.2

From: Arthur Fabre <afabre@cloudflare.com>

Basic benchmarks for:

* Getting a trait.
* Setting a trait, with no traits already stored after it.
* Moving traits, when setting or deleting a trait with traits stored
  after it.

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 tools/testing/selftests/bpf/Makefile               |   2 +
 tools/testing/selftests/bpf/bench.c                |   8 ++
 .../selftests/bpf/benchs/bench_xdp_traits.c        | 160 +++++++++++++++++++++
 .../testing/selftests/bpf/progs/bench_xdp_traits.c | 131 +++++++++++++++++
 4 files changed, 301 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e6a02d5b87d123cef7e6b41bfbc96d34083f38e1..6b7a7351664cf611ce72fb76b308b7392e3811ba 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -815,6 +815,7 @@ $(OUTPUT)/bench_local_storage_create.o: $(OUTPUT)/bench_local_storage_create.ske
 $(OUTPUT)/bench_bpf_hashmap_lookup.o: $(OUTPUT)/bpf_hashmap_lookup.skel.h
 $(OUTPUT)/bench_htab_mem.o: $(OUTPUT)/htab_mem_bench.skel.h
 $(OUTPUT)/bench_bpf_crypto.o: $(OUTPUT)/crypto_bench.skel.h
+$(OUTPUT)/bench_xdp_traits.o: $(OUTPUT)/bench_xdp_traits.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
@@ -835,6 +836,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_local_storage_create.o \
 		 $(OUTPUT)/bench_htab_mem.o \
 		 $(OUTPUT)/bench_bpf_crypto.o \
+		 $(OUTPUT)/bench_xdp_traits.o \
 		 #
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 1bd403a5ef7b3401f501d790453c7be9ed289cb5..4678b928fc6ad2f0a870a25d9b10c75a1f6d77ba 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -283,6 +283,7 @@ extern struct argp bench_local_storage_create_argp;
 extern struct argp bench_htab_mem_argp;
 extern struct argp bench_trigger_batch_argp;
 extern struct argp bench_crypto_argp;
+extern struct argp bench_trait_argp;
 
 static const struct argp_child bench_parsers[] = {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
@@ -297,6 +298,7 @@ static const struct argp_child bench_parsers[] = {
 	{ &bench_htab_mem_argp, 0, "hash map memory benchmark", 0 },
 	{ &bench_trigger_batch_argp, 0, "BPF triggering benchmark", 0 },
 	{ &bench_crypto_argp, 0, "bpf crypto benchmark", 0 },
+	{ &bench_trait_argp, 0, "XDP trait benchmark", 0 },
 	{},
 };
 
@@ -549,6 +551,9 @@ extern const struct bench bench_local_storage_create;
 extern const struct bench bench_htab_mem;
 extern const struct bench bench_crypto_encrypt;
 extern const struct bench bench_crypto_decrypt;
+extern const struct bench bench_xdp_trait_get;
+extern const struct bench bench_xdp_trait_set;
+extern const struct bench bench_xdp_trait_move;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -609,6 +614,9 @@ static const struct bench *benchs[] = {
 	&bench_htab_mem,
 	&bench_crypto_encrypt,
 	&bench_crypto_decrypt,
+	&bench_xdp_trait_get,
+	&bench_xdp_trait_set,
+	&bench_xdp_trait_move,
 };
 
 static void find_benchmark(void)
diff --git a/tools/testing/selftests/bpf/benchs/bench_xdp_traits.c b/tools/testing/selftests/bpf/benchs/bench_xdp_traits.c
new file mode 100644
index 0000000000000000000000000000000000000000..0fbcd49edd825f53e6957319d3f05efc218dfb02
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
+		if (args.trait_len != 2 && args.trait_len != 4 && args.trait_len != 8) {
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
index 0000000000000000000000000000000000000000..558c1ab22e09990d3eb0f78f916fd02de3def749
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bench_xdp_traits.c
@@ -0,0 +1,131 @@
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
+	__u16 val2 = 0xdead;
+	__u32 val4 = 0xdeadbeef;
+	__u64 val8 = 0xdeadbeefafafcfcf;
+
+#define BENCH_GET(val, size) do { \
+		ret = bpf_xdp_trait_set(xdp, 32, &val, sizeof(val), 0);		\
+		if (ret != 0)							\
+			return ret;						\
+		for (i = 0; i < ITERATIONS; i++)				\
+			ret = bpf_xdp_trait_get(xdp, 32, &val, sizeof(val));	\
+		if (ret != size)						\
+			return ret;						\
+	} while (0)
+
+	switch (trait_len) {
+	case 2:
+		BENCH_GET(val2, 2);
+		break;
+	case 4:
+		BENCH_GET(val4, 4);
+		break;
+	case 8:
+		BENCH_GET(val8, 8);
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
+	__u16 val2 = 0xdead;
+	__u32 val4 = 0xdeadbeef;
+	__u64 val8 = 0xdeadbeefafafcfcf;
+
+#define BENCH_SET(val) do { \
+		for (i = 0; i < ITERATIONS; i++)				\
+			ret = bpf_xdp_trait_set(xdp, 32, &val, sizeof(val), 0);	\
+	} while (0)
+
+	switch (trait_len) {
+	case 2:
+		BENCH_SET(val2);
+		break;
+	case 4:
+		BENCH_SET(val4);
+		break;
+	case 8:
+		BENCH_SET(val8);
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
+	__u16 val2 = 0xdead;
+	__u32 val4 = 0xdeadbeef;
+	__u64 val8 = 0xdeadbeefafafcfcf;
+
+#define BENCH_MOVE(val) do { \
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
+			ret = bpf_xdp_trait_set(xdp, 32, &val, sizeof(val), 0);		\
+			ret_del = bpf_xdp_trait_del(xdp, 32);				\
+		}									\
+	} while (0)
+
+	switch (trait_len) {
+	case 2:
+		BENCH_MOVE(val2);
+		break;
+	case 4:
+		BENCH_MOVE(val4);
+		break;
+	case 8:
+		BENCH_MOVE(val8);
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


