Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9359451811
	for <lists+bpf@lfdr.de>; Mon, 15 Nov 2021 23:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhKOWy2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 15 Nov 2021 17:54:28 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29434 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350808AbhKOWi0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Nov 2021 17:38:26 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFGucxh029735
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 14:35:13 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cb34b251v-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 14:35:13 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 15 Nov 2021 14:34:37 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C32B294F715D; Mon, 15 Nov 2021 14:34:35 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: add uprobe triggering overhead benchmarks
Date:   Mon, 15 Nov 2021 14:34:34 -0800
Message-ID: <20211115223434.3232433-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
X-FB-Source: Intern
X-Proofpoint-GUID: 657mcXjSCqK5FSl89li0KvwP40zCLEpC
X-Proofpoint-ORIG-GUID: 657mcXjSCqK5FSl89li0KvwP40zCLEpC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_16,2021-11-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111150115
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add benchmark to measure overhead of uprobes and uretprobes. Also have
a baseline (no uprobe attached) benchmark.

On my dev machine, baseline benchmark can trigger 130M user_target()
invocations. When uprobe is attached, this falls to just 700K. With
uretprobe, we get down to 520K:

  $ sudo ./bench trig-uprobe-base -a
  Summary: hits  131.289 ± 2.872M/s

  $ sudo ./bench trig-uprobe -a
  Summary: hits    0.700 ± 0.008M/s

  $ sudo ./bench trig-uretprobe -a
  Summary: hits    0.518 ± 0.006M/s

This means that uprobe overhead is around 1.4 microseconds for uprobe
and 2 microseconds for uretprobe.

For comparison, just doing a very low-overhead syscall (with no BPF
programs attached anywhere) gives:

  $ sudo ./bench trig-base -a
  Summary: hits    4.830 ± 0.036M/s

So uprobes are about 7x slower than pure context switch.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  4 +-
 tools/testing/selftests/bpf/bench.c           |  6 ++
 .../selftests/bpf/benchs/bench_trigger.c      | 94 +++++++++++++++++++
 .../selftests/bpf/progs/trigger_bench.c       |  7 ++
 4 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 0470802c907c..35684d61aaeb 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -533,7 +533,9 @@ $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.skel.h \
 $(OUTPUT)/bench_bloom_filter_map.o: $(OUTPUT)/bloom_filter_bench.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
-$(OUTPUT)/bench: $(OUTPUT)/bench.o $(OUTPUT)/testing_helpers.o \
+$(OUTPUT)/bench: $(OUTPUT)/bench.o \
+		 $(OUTPUT)/testing_helpers.o \
+		 $(OUTPUT)/trace_helpers.o \
 		 $(OUTPUT)/bench_count.o \
 		 $(OUTPUT)/bench_rename.o \
 		 $(OUTPUT)/bench_trigger.o \
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index cc4722f693e9..10f371376585 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -359,6 +359,9 @@ extern const struct bench bench_trig_kprobe;
 extern const struct bench bench_trig_fentry;
 extern const struct bench bench_trig_fentry_sleep;
 extern const struct bench bench_trig_fmodret;
+extern const struct bench bench_trig_uprobe_base;
+extern const struct bench bench_trig_uprobe;
+extern const struct bench bench_trig_uretprobe;
 extern const struct bench bench_rb_libbpf;
 extern const struct bench bench_rb_custom;
 extern const struct bench bench_pb_libbpf;
@@ -385,6 +388,9 @@ static const struct bench *benchs[] = {
 	&bench_trig_fentry,
 	&bench_trig_fentry_sleep,
 	&bench_trig_fmodret,
+	&bench_trig_uprobe_base,
+	&bench_trig_uprobe,
+	&bench_trig_uretprobe,
 	&bench_rb_libbpf,
 	&bench_rb_custom,
 	&bench_pb_libbpf,
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index f41a491a8cc0..9ecadc549873 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2020 Facebook */
 #include "bench.h"
 #include "trigger_bench.skel.h"
+#include "trace_helpers.h"
 
 /* BPF triggering benchmarks */
 static struct trigger_ctx {
@@ -107,6 +108,69 @@ static void *trigger_consumer(void *input)
 	return NULL;
 }
 
+/* make sure call is not inlined and not avoided by compiler, so __weak and
+ * inline asm volatile in the body of the function
+ */
+__weak void uprobe_target(void)
+{
+	asm volatile ("");
+}
+
+static void *uprobe_base_producer(void *input)
+{
+	while (true) {
+		uprobe_target();
+		atomic_inc(&base_hits.value);
+	}
+	return NULL;
+}
+
+static void *uprobe_producer(void *input)
+{
+	while (true)
+		uprobe_target();
+	return NULL;
+}
+
+static void usetup(bool use_retprobe)
+{
+	size_t uprobe_offset;
+	ssize_t base_addr;
+	struct bpf_link *link;
+
+	setup_libbpf();
+
+	ctx.skel = trigger_bench__open_and_load();
+	if (!ctx.skel) {
+		fprintf(stderr, "failed to open skeleton\n");
+		exit(1);
+	}
+
+	base_addr = get_base_addr();
+	uprobe_offset = get_uprobe_offset(&uprobe_target, base_addr);
+
+	link = bpf_program__attach_uprobe(ctx.skel->progs.bench_trigger_uprobe,
+					  use_retprobe,
+					  -1 /* all PIDs */,
+					  "/proc/self/exe",
+					  uprobe_offset);
+	if (!link) {
+		fprintf(stderr, "failed to attach uprobe!\n");
+		exit(1);
+	}
+	ctx.skel->links.bench_trigger_uprobe = link;
+}
+
+static void uprobe_setup()
+{
+	usetup(false);
+}
+
+static void uretprobe_setup()
+{
+	usetup(true);
+}
+
 const struct bench bench_trig_base = {
 	.name = "trig-base",
 	.validate = trigger_validate,
@@ -182,3 +246,33 @@ const struct bench bench_trig_fmodret = {
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
 };
+
+const struct bench bench_trig_uprobe_base = {
+	.name = "trig-uprobe-base",
+	.setup = NULL, /* no uprobe/uretprobe is attached */
+	.producer_thread = uprobe_base_producer,
+	.consumer_thread = trigger_consumer,
+	.measure = trigger_base_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
+
+const struct bench bench_trig_uprobe = {
+	.name = "trig-uprobe",
+	.setup = uprobe_setup,
+	.producer_thread = uprobe_producer,
+	.consumer_thread = trigger_consumer,
+	.measure = trigger_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
+
+const struct bench bench_trig_uretprobe = {
+	.name = "trig-uretprobe",
+	.setup = uretprobe_setup,
+	.producer_thread = uprobe_producer,
+	.consumer_thread = trigger_consumer,
+	.measure = trigger_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index 9a4d09590b3d..2098f3f27f18 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -52,3 +52,10 @@ int bench_trigger_fmodret(void *ctx)
 	__sync_add_and_fetch(&hits, 1);
 	return -22;
 }
+
+SEC("uprobe/self/uprobe_target")
+int bench_trigger_uprobe(void *ctx)
+{
+	__sync_add_and_fetch(&hits, 1);
+	return 0;
+}
-- 
2.30.2

