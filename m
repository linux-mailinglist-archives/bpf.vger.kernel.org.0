Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3D44551F9
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 02:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242099AbhKRBKA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Nov 2021 20:10:00 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35180 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237831AbhKRBJ7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Nov 2021 20:09:59 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHNVTHu002789
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 17:07:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=AF+Ug2lLkaBLgum97kG2+0QabH9CQmlJebQcILOpims=;
 b=bMjS7v6OFbSaGsnS8H3MJdXNZRMgwhE9SUBVjHF+22PPP00V9MQksCA4tKY8uSc+9GPY
 tmrVyKddAAkKv25ij6q1NEqdJyqTRbNsnEIQBMYTMY3n3Mo6QudOisNQaUaSClJ5UzEx
 Zdb3dnxV4khRpn9gfNX96uz7pt2JeYqnqzM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cdbfvrf7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 17:06:59 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 17 Nov 2021 17:06:58 -0800
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id BA9E34F5FAD8; Wed, 17 Nov 2021 17:06:50 -0800 (PST)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <Kernel-team@fb.com>,
        Joanne Koong <joannekoong@fb.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf: Add tests for bpf_for_each
Date:   Wed, 17 Nov 2021 17:04:03 -0800
Message-ID: <20211118010404.2415864-3-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211118010404.2415864-1-joannekoong@fb.com>
References: <20211118010404.2415864-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: GL2PPd4e9uUaS-QfTOdC5TNd4CFDUO0M
X-Proofpoint-GUID: GL2PPd4e9uUaS-QfTOdC5TNd4CFDUO0M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_09,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=549
 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111180005
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In this patch -
1) Add a new prog "for_each_helper" which tests the basic functionality o=
f
the bpf_for_each helper.

2) Add pyperf600_foreach and strobemeta_foreach to test the performance
of using bpf_for_each instead of a for loop

The results of pyperf600 and strobemeta are as follows:

~strobemeta~

Baseline
    verification time 6808200 usec
    stack depth 496
    processed 592132 insns (limit 1000000) max_states_per_insn 14
    total_states 16018 peak_states 13684 mark_read 3132
    #188 verif_scale_strobemeta:OK (unrolled loop)

Using bpf_for_each
    verification time 31589 usec
    stack depth 96+408
    processed 1630 insns (limit 1000000) max_states_per_insn 4
    total_states 107 peak_states 107 mark_read 60
    #189 verif_scale_strobemeta_foreach:OK

~pyperf600~

Baseline
    verification time 29702486 usec
    stack depth 368
    processed 626838 insns (limit 1000000) max_states_per_insn 7
    total_states 30368 peak_states 30279 mark_read 748
    #182 verif_scale_pyperf600:OK (unrolled loop)

Using bpf_for_each
    verification time 148488 usec
    stack depth 320+40
    processed 10518 insns (limit 1000000) max_states_per_insn 10
    total_states 705 peak_states 517 mark_read 38
    #183 verif_scale_pyperf600_foreach:OK

Using the bpf_for_each helper led to approximately a 100% decrease
in the verification time and in the number of instructions.

Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 .../bpf/prog_tests/bpf_verif_scale.c          | 12 +++
 .../selftests/bpf/prog_tests/for_each.c       | 61 ++++++++++++++++
 .../selftests/bpf/progs/for_each_helper.c     | 69 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/pyperf.h    | 70 +++++++++++++++++-
 .../selftests/bpf/progs/pyperf600_foreach.c   |  5 ++
 .../testing/selftests/bpf/progs/strobemeta.h  | 73 ++++++++++++++++++-
 .../selftests/bpf/progs/strobemeta_foreach.c  |  9 +++
 7 files changed, 295 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_helper.c
 create mode 100644 tools/testing/selftests/bpf/progs/pyperf600_foreach.c
 create mode 100644 tools/testing/selftests/bpf/progs/strobemeta_foreach.=
c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/t=
ools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
index 867349e4ed9e..77396484fde7 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -115,6 +115,12 @@ void test_verif_scale_pyperf600()
 	scale_test("pyperf600.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
=20
+void test_verif_scale_pyperf600_foreach(void)
+{
+	/* use the bpf_for_each helper*/
+	scale_test("pyperf600_foreach.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+}
+
 void test_verif_scale_pyperf600_nounroll()
 {
 	/* no unroll at all.
@@ -165,6 +171,12 @@ void test_verif_scale_strobemeta()
 	scale_test("strobemeta.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
=20
+void test_verif_scale_strobemeta_foreach(void)
+{
+	/* use the bpf_for_each helper*/
+	scale_test("strobemeta_foreach.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false)=
;
+}
+
 void test_verif_scale_strobemeta_nounroll1()
 {
 	/* no unroll, tiny loops */
diff --git a/tools/testing/selftests/bpf/prog_tests/for_each.c b/tools/te=
sting/selftests/bpf/prog_tests/for_each.c
index 68eb12a287d4..529573a82334 100644
--- a/tools/testing/selftests/bpf/prog_tests/for_each.c
+++ b/tools/testing/selftests/bpf/prog_tests/for_each.c
@@ -4,6 +4,7 @@
 #include <network_helpers.h>
 #include "for_each_hash_map_elem.skel.h"
 #include "for_each_array_map_elem.skel.h"
+#include "for_each_helper.skel.h"
=20
 static unsigned int duration;
=20
@@ -121,10 +122,70 @@ static void test_array_map(void)
 	for_each_array_map_elem__destroy(skel);
 }
=20
+static void test_for_each_helper(void)
+{
+	struct for_each_helper *skel;
+	__u32 retval;
+	int err;
+
+	skel =3D for_each_helper__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "for_each_helper__open_and_load"))
+		return;
+
+	skel->bss->nr_iterations =3D 100;
+	err =3D bpf_prog_test_run(bpf_program__fd(skel->progs.test_prog),
+				1, &pkt_v4, sizeof(pkt_v4), NULL, NULL,
+				&retval, &duration);
+	if (CHECK(err || retval, "bpf_for_each helper test_prog",
+		  "err %d errno %d retval %d\n", err, errno, retval))
+		goto out;
+	ASSERT_EQ(skel->bss->nr_iterations_completed, skel->bss->nr_iterations,
+		  "nr_iterations mismatch");
+	ASSERT_EQ(skel->bss->g_output, (100 * 99) / 2, "wrong output");
+
+	/* test callback_fn returning 1 to stop iteration */
+	skel->bss->nr_iterations =3D 400;
+	skel->data->stop_index =3D 50;
+	err =3D bpf_prog_test_run(bpf_program__fd(skel->progs.test_prog),
+				1, &pkt_v4, sizeof(pkt_v4), NULL, NULL,
+				&retval, &duration);
+	if (CHECK(err || retval, "bpf_for_each helper test_prog",
+		  "err %d errno %d retval %d\n", err, errno, retval))
+		goto out;
+	ASSERT_EQ(skel->bss->nr_iterations_completed, skel->data->stop_index + =
1,
+		  "stop_index not followed");
+	ASSERT_EQ(skel->bss->g_output, (50 * 49) / 2, "wrong output");
+
+	/* test passing in a null ctx */
+	skel->bss->nr_iterations =3D 10;
+	err =3D bpf_prog_test_run(bpf_program__fd(skel->progs.prog_null_ctx),
+				1, &pkt_v4, sizeof(pkt_v4), NULL, NULL,
+				&retval, &duration);
+	if (CHECK(err || retval, "bpf_for_each helper prog_null_ctx",
+		  "err %d errno %d retval %d\n", err, errno, retval))
+		goto out;
+	ASSERT_EQ(skel->bss->nr_iterations_completed, skel->bss->nr_iterations,
+		  "nr_iterations mismatch");
+
+	/* test invalid flags */
+	err =3D bpf_prog_test_run(bpf_program__fd(skel->progs.prog_invalid_flag=
s),
+				1, &pkt_v4, sizeof(pkt_v4), NULL, NULL,
+				&retval, &duration);
+	if (CHECK(err || retval, "bpf_for_each helper prog_invalid_flags",
+		  "err %d errno %d retval %d\n", err, errno, retval))
+		goto out;
+	ASSERT_EQ(skel->bss->err, -EINVAL, "invalid_flags");
+
+out:
+	for_each_helper__destroy(skel);
+}
+
 void test_for_each(void)
 {
 	if (test__start_subtest("hash_map"))
 		test_hash_map();
 	if (test__start_subtest("array_map"))
 		test_array_map();
+	if (test__start_subtest("for_each_helper"))
+		test_for_each_helper();
 }
diff --git a/tools/testing/selftests/bpf/progs/for_each_helper.c b/tools/=
testing/selftests/bpf/progs/for_each_helper.c
new file mode 100644
index 000000000000..4404d0cb32a6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/for_each_helper.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+struct callback_ctx {
+	int output;
+};
+
+/* This should be set by the user program */
+u32 nr_iterations;
+u32 stop_index =3D -1;
+
+/* Making these global variables so that the userspace program
+ * can verify the output through the skeleton
+ */
+int nr_iterations_completed;
+int g_output;
+int err;
+
+static int callback_fn(__u32 index, void *data)
+{
+	struct callback_ctx *ctx =3D data;
+
+	if (index >=3D stop_index)
+		return 1;
+
+	ctx->output +=3D index;
+
+	return 0;
+}
+
+static int empty_callback_fn(__u32 index, void *data)
+{
+	return 0;
+}
+
+SEC("tc")
+int test_prog(struct __sk_buff *skb)
+{
+	struct callback_ctx data =3D {};
+
+	nr_iterations_completed =3D bpf_for_each(nr_iterations, callback_fn, &d=
ata, 0);
+
+	g_output =3D data.output;
+
+	return 0;
+}
+
+SEC("tc")
+int prog_null_ctx(struct __sk_buff *skb)
+{
+	nr_iterations_completed =3D bpf_for_each(nr_iterations, empty_callback_=
fn, NULL, 0);
+
+	return 0;
+}
+
+SEC("tc")
+int prog_invalid_flags(struct __sk_buff *skb)
+{
+	struct callback_ctx data =3D {};
+
+	err =3D bpf_for_each(nr_iterations, callback_fn, &data, 1);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/pyperf.h b/tools/testing/s=
elftests/bpf/progs/pyperf.h
index 2fb7adafb6b6..186735e2f385 100644
--- a/tools/testing/selftests/bpf/progs/pyperf.h
+++ b/tools/testing/selftests/bpf/progs/pyperf.h
@@ -159,6 +159,57 @@ struct {
 	__uint(value_size, sizeof(long long) * 127);
 } stackmap SEC(".maps");
=20
+struct process_frame_ctx {
+	int cur_cpu;
+	int32_t *symbol_counter;
+	void *frame_ptr;
+	FrameData *frame;
+	PidData *pidData;
+	Symbol *sym;
+	Event *event;
+	bool done;
+};
+
+#define barrier_var(var) asm volatile("" : "=3Dr"(var) : "0"(var))
+
+static int process_frame_callback(__u32 i, struct process_frame_ctx *ctx=
)
+{
+	int zero =3D 0;
+	void *frame_ptr =3D ctx->frame_ptr;
+	PidData *pidData =3D ctx->pidData;
+	FrameData *frame =3D ctx->frame;
+	int32_t *symbol_counter =3D ctx->symbol_counter;
+	int cur_cpu =3D ctx->cur_cpu;
+	Event *event =3D ctx->event;
+	Symbol *sym =3D ctx->sym;
+
+	if (frame_ptr && get_frame_data(frame_ptr, pidData, frame, sym)) {
+		int32_t new_symbol_id =3D *symbol_counter * 64 + cur_cpu;
+		int32_t *symbol_id =3D bpf_map_lookup_elem(&symbolmap, sym);
+
+		if (!symbol_id) {
+			bpf_map_update_elem(&symbolmap, sym, &zero, 0);
+			symbol_id =3D bpf_map_lookup_elem(&symbolmap, sym);
+			if (!symbol_id) {
+				ctx->done =3D true;
+				return 1;
+			}
+		}
+		if (*symbol_id =3D=3D new_symbol_id)
+			(*symbol_counter)++;
+
+		barrier_var(i);
+		if (i >=3D STACK_MAX_LEN)
+			return 1;
+
+		event->stack[i] =3D *symbol_id;
+
+		event->stack_len =3D i + 1;
+		frame_ptr =3D frame->f_back;
+	}
+	return 0;
+}
+
 #ifdef GLOBAL_FUNC
 __noinline
 #elif defined(SUBPROGS)
@@ -228,11 +279,27 @@ int __on_event(struct bpf_raw_tracepoint_args *ctx)
 		int32_t* symbol_counter =3D bpf_map_lookup_elem(&symbolmap, &sym);
 		if (symbol_counter =3D=3D NULL)
 			return 0;
+#ifdef USE_FOREACH
+	struct process_frame_ctx ctx;
+
+	ctx.cur_cpu =3D cur_cpu;
+	ctx.symbol_counter =3D symbol_counter;
+	ctx.frame_ptr =3D frame_ptr;
+	ctx.frame =3D &frame;
+	ctx.pidData =3D pidData;
+	ctx.sym =3D &sym;
+	ctx.event =3D event;
+	ctx.done =3D false;
+
+	bpf_for_each(STACK_MAX_LEN, process_frame_callback, &ctx, 0);
+	if (ctx.done)
+		return 0;
+#else
 #ifdef NO_UNROLL
 #pragma clang loop unroll(disable)
 #else
 #pragma clang loop unroll(full)
-#endif
+#endif /* NO_UNROLL */
 		/* Unwind python stack */
 		for (int i =3D 0; i < STACK_MAX_LEN; ++i) {
 			if (frame_ptr && get_frame_data(frame_ptr, pidData, &frame, &sym)) {
@@ -251,6 +318,7 @@ int __on_event(struct bpf_raw_tracepoint_args *ctx)
 				frame_ptr =3D frame.f_back;
 			}
 		}
+#endif /* USE_FOREACH */
 		event->stack_complete =3D frame_ptr =3D=3D NULL;
 	} else {
 		event->stack_complete =3D 1;
diff --git a/tools/testing/selftests/bpf/progs/pyperf600_foreach.c b/tool=
s/testing/selftests/bpf/progs/pyperf600_foreach.c
new file mode 100644
index 000000000000..1b43f12a7d54
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/pyperf600_foreach.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2021 Facebook
+#define STACK_MAX_LEN 600
+#define USE_FOREACH
+#include "pyperf.h"
diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testi=
ng/selftests/bpf/progs/strobemeta.h
index 7de534f38c3f..40069e797930 100644
--- a/tools/testing/selftests/bpf/progs/strobemeta.h
+++ b/tools/testing/selftests/bpf/progs/strobemeta.h
@@ -445,6 +445,46 @@ static __always_inline void *read_map_var(struct str=
obemeta_cfg *cfg,
 	return payload;
 }
=20
+enum read_type {
+	READ_INT_VAR,
+	READ_MAP_VAR,
+	READ_STR_VAR,
+};
+
+struct read_var_ctx {
+	struct strobemeta_payload *data;
+	void *tls_base;
+	struct strobemeta_cfg *cfg;
+	void *payload;
+	/* value gets mutated */
+	struct strobe_value_generic *value;
+	enum read_type type;
+};
+
+static int read_var_callback(__u32 index, struct read_var_ctx *ctx)
+{
+	switch (ctx->type) {
+	case READ_INT_VAR:
+		if (index >=3D STROBE_MAX_INTS)
+			return 1;
+		read_int_var(ctx->cfg, index, ctx->tls_base, ctx->value, ctx->data);
+		break;
+	case READ_MAP_VAR:
+		if (index >=3D STROBE_MAX_MAPS)
+			return 1;
+		ctx->payload =3D read_map_var(ctx->cfg, index, ctx->tls_base,
+					    ctx->value, ctx->data, ctx->payload);
+		break;
+	case READ_STR_VAR:
+		if (index >=3D STROBE_MAX_STRS)
+			return 1;
+		ctx->payload +=3D read_str_var(ctx->cfg, index, ctx->tls_base,
+					     ctx->value, ctx->data, ctx->payload);
+		break;
+	}
+	return 0;
+}
+
 /*
  * read_strobe_meta returns NULL, if no metadata was read; otherwise ret=
urns
  * pointer to *right after* payload ends
@@ -475,11 +515,36 @@ static void *read_strobe_meta(struct task_struct *t=
ask,
 	 */
 	tls_base =3D (void *)task;
=20
+#ifdef USE_FOREACH
+	struct read_var_ctx ctx;
+	int err;
+
+	ctx.cfg =3D cfg;
+	ctx.tls_base =3D tls_base;
+	ctx.value =3D &value;
+	ctx.data =3D data;
+	ctx.payload =3D payload;
+	ctx.type =3D READ_INT_VAR;
+
+	err =3D bpf_for_each(STROBE_MAX_INTS, read_var_callback, &ctx, 0);
+	if (err !=3D STROBE_MAX_INTS)
+		return NULL;
+
+	ctx.type =3D READ_STR_VAR;
+	err =3D bpf_for_each(STROBE_MAX_STRS, read_var_callback, &ctx, 0);
+	if (err !=3D STROBE_MAX_STRS)
+		return NULL;
+
+	ctx.type =3D READ_MAP_VAR;
+	err =3D bpf_for_each(STROBE_MAX_MAPS, read_var_callback, &ctx, 0);
+	if (err !=3D STROBE_MAX_MAPS)
+		return NULL;
+#else
 #ifdef NO_UNROLL
 #pragma clang loop unroll(disable)
 #else
 #pragma unroll
-#endif
+#endif /* NO_UNROLL */
 	for (int i =3D 0; i < STROBE_MAX_INTS; ++i) {
 		read_int_var(cfg, i, tls_base, &value, data);
 	}
@@ -487,7 +552,7 @@ static void *read_strobe_meta(struct task_struct *tas=
k,
 #pragma clang loop unroll(disable)
 #else
 #pragma unroll
-#endif
+#endif /* NO_UNROLL */
 	for (int i =3D 0; i < STROBE_MAX_STRS; ++i) {
 		payload +=3D read_str_var(cfg, i, tls_base, &value, data, payload);
 	}
@@ -495,10 +560,12 @@ static void *read_strobe_meta(struct task_struct *t=
ask,
 #pragma clang loop unroll(disable)
 #else
 #pragma unroll
-#endif
+#endif /* NO_UNROLL */
 	for (int i =3D 0; i < STROBE_MAX_MAPS; ++i) {
 		payload =3D read_map_var(cfg, i, tls_base, &value, data, payload);
 	}
+#endif /* USE_FOREACH */
+
 	/*
 	 * return pointer right after end of payload, so it's possible to
 	 * calculate exact amount of useful data that needs to be sent
diff --git a/tools/testing/selftests/bpf/progs/strobemeta_foreach.c b/too=
ls/testing/selftests/bpf/progs/strobemeta_foreach.c
new file mode 100644
index 000000000000..a2d57d2d68ad
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/strobemeta_foreach.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+// Copyright (c) 2021 Facebook
+
+#define STROBE_MAX_INTS 2
+#define STROBE_MAX_STRS 25
+#define STROBE_MAX_MAPS 100
+#define STROBE_MAX_MAP_ENTRIES 20
+#define USE_FOREACH
+#include "strobemeta.h"
--=20
2.30.2

