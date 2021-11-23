Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696AB45AB51
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 19:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbhKWShm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 13:37:42 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8864 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238991AbhKWShm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 13:37:42 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1ANGTURP022628
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 10:34:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=DWuMcgzsePvnDOqpUfTPzKKcBrmFwGkrHsCnNzQ1+7A=;
 b=RiOChck7+d1zpuhz+x8HilSDYgJplNJAz62swSxvM+tPDALDPQW8kpK2mQ3fa7UkTQIL
 GF+DFkp0HsPOFsFIlPjgC7ogvl/xYFVGPgjPIyOlKf+cwCxx3MIwSNpPkc6ls7/OoF01
 0zQVvwydqY0N5nGFO99Aky1KiwQpjus3Vjw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3ch3v50ya8-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 10:34:33 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 23 Nov 2021 10:34:30 -0800
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id 8E0DC533D327; Tue, 23 Nov 2021 10:34:25 -0800 (PST)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <Kernel-team@fb.com>, Joanne Koong <joannekoong@fb.com>
Subject: [PATCH v2 bpf-next 3/4] selftests/bpf: measure bpf_loop verifier performance
Date:   Tue, 23 Nov 2021 10:34:08 -0800
Message-ID: <20211123183409.3599979-4-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123183409.3599979-1-joannekoong@fb.com>
References: <20211123183409.3599979-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: JifbWpr4EAJVyDSZ3rVbTwxwIJJyu8YT
X-Proofpoint-GUID: JifbWpr4EAJVyDSZ3rVbTwxwIJJyu8YT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_06,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=820 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111230090
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch tests bpf_loop in pyperf and strobemeta, and measures the
verifier performance of replacing the traditional for loop
with bpf_loop.

The results are as follows:

~strobemeta~

Baseline
    verification time 6808200 usec
    stack depth 496
    processed 554252 insns (limit 1000000) max_states_per_insn 16
    total_states 15878 peak_states 13489  mark_read 3110
    #192 verif_scale_strobemeta:OK (unrolled loop)

Using bpf_loop
    verification time 31589 usec
    stack depth 96+400
    processed 1513 insns (limit 1000000) max_states_per_insn 2
    total_states 106 peak_states 106 mark_read 60
    #193 verif_scale_strobemeta_bpf_loop:OK

~pyperf600~

Baseline
    verification time 29702486 usec
    stack depth 368
    processed 626838 insns (limit 1000000) max_states_per_insn 7
    total_states 30368 peak_states 30279 mark_read 748
    #182 verif_scale_pyperf600:OK (unrolled loop)

Using bpf_loop
    verification time 148488 usec
    stack depth 320+40
    processed 10518 insns (limit 1000000) max_states_per_insn 10
    total_states 705 peak_states 517 mark_read 38
    #183 verif_scale_pyperf600_bpf_loop:OK

Using the bpf_loop helper led to approximately a 99% decrease
in the verification time and in the number of instructions.

Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 .../bpf/prog_tests/bpf_verif_scale.c          | 12 +++
 tools/testing/selftests/bpf/progs/pyperf.h    | 71 +++++++++++++++++-
 .../selftests/bpf/progs/pyperf600_bpf_loop.c  |  6 ++
 .../testing/selftests/bpf/progs/strobemeta.h  | 75 ++++++++++++++++++-
 .../selftests/bpf/progs/strobemeta_bpf_loop.c |  9 +++
 5 files changed, 169 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/pyperf600_bpf_loop.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/strobemeta_bpf_loop=
.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/t=
ools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
index 27f5d8ea7964..1fb16f8dad56 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -115,6 +115,12 @@ void test_verif_scale_pyperf600()
 	scale_test("pyperf600.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
=20
+void test_verif_scale_pyperf600_bpf_loop(void)
+{
+	/* use the bpf_loop helper*/
+	scale_test("pyperf600_bpf_loop.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false)=
;
+}
+
 void test_verif_scale_pyperf600_nounroll()
 {
 	/* no unroll at all.
@@ -165,6 +171,12 @@ void test_verif_scale_strobemeta()
 	scale_test("strobemeta.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
=20
+void test_verif_scale_strobemeta_bpf_loop(void)
+{
+	/* use the bpf_loop helper*/
+	scale_test("strobemeta_bpf_loop.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false=
);
+}
+
 void test_verif_scale_strobemeta_nounroll1()
 {
 	/* no unroll, tiny loops */
diff --git a/tools/testing/selftests/bpf/progs/pyperf.h b/tools/testing/s=
elftests/bpf/progs/pyperf.h
index 2fb7adafb6b6..1ed28882daf3 100644
--- a/tools/testing/selftests/bpf/progs/pyperf.h
+++ b/tools/testing/selftests/bpf/progs/pyperf.h
@@ -159,6 +159,59 @@ struct {
 	__uint(value_size, sizeof(long long) * 127);
 } stackmap SEC(".maps");
=20
+#ifdef USE_BPF_LOOP
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
+#endif /* USE_BPF_LOOP */
+
 #ifdef GLOBAL_FUNC
 __noinline
 #elif defined(SUBPROGS)
@@ -228,11 +281,26 @@ int __on_event(struct bpf_raw_tracepoint_args *ctx)
 		int32_t* symbol_counter =3D bpf_map_lookup_elem(&symbolmap, &sym);
 		if (symbol_counter =3D=3D NULL)
 			return 0;
+#ifdef USE_BPF_LOOP
+	struct process_frame_ctx ctx =3D {
+		.cur_cpu =3D cur_cpu,
+		.symbol_counter =3D symbol_counter,
+		.frame_ptr =3D frame_ptr,
+		.frame =3D &frame,
+		.pidData =3D pidData,
+		.sym =3D &sym,
+		.event =3D event,
+	};
+
+	bpf_loop(STACK_MAX_LEN, process_frame_callback, &ctx, 0);
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
@@ -251,6 +319,7 @@ int __on_event(struct bpf_raw_tracepoint_args *ctx)
 				frame_ptr =3D frame.f_back;
 			}
 		}
+#endif /* USE_BPF_LOOP */
 		event->stack_complete =3D frame_ptr =3D=3D NULL;
 	} else {
 		event->stack_complete =3D 1;
diff --git a/tools/testing/selftests/bpf/progs/pyperf600_bpf_loop.c b/too=
ls/testing/selftests/bpf/progs/pyperf600_bpf_loop.c
new file mode 100644
index 000000000000..bde8baed4ca6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/pyperf600_bpf_loop.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2021 Facebook
+
+#define STACK_MAX_LEN 600
+#define USE_BPF_LOOP
+#include "pyperf.h"
diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testi=
ng/selftests/bpf/progs/strobemeta.h
index 60c93aee2f4a..753718595c26 100644
--- a/tools/testing/selftests/bpf/progs/strobemeta.h
+++ b/tools/testing/selftests/bpf/progs/strobemeta.h
@@ -445,6 +445,48 @@ static __always_inline void *read_map_var(struct str=
obemeta_cfg *cfg,
 	return payload;
 }
=20
+#ifdef USE_BPF_LOOP
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
+#endif /* USE_BPF_LOOP */
+
 /*
  * read_strobe_meta returns NULL, if no metadata was read; otherwise ret=
urns
  * pointer to *right after* payload ends
@@ -475,11 +517,36 @@ static void *read_strobe_meta(struct task_struct *t=
ask,
 	 */
 	tls_base =3D (void *)task;
=20
+#ifdef USE_BPF_LOOP
+	struct read_var_ctx ctx =3D {
+		.cfg =3D cfg,
+		.tls_base =3D tls_base,
+		.value =3D &value,
+		.data =3D data,
+		.payload =3D payload,
+	};
+	int err;
+
+	ctx.type =3D READ_INT_VAR;
+	err =3D bpf_loop(STROBE_MAX_INTS, read_var_callback, &ctx, 0);
+	if (err !=3D STROBE_MAX_INTS)
+		return NULL;
+
+	ctx.type =3D READ_STR_VAR;
+	err =3D bpf_loop(STROBE_MAX_STRS, read_var_callback, &ctx, 0);
+	if (err !=3D STROBE_MAX_STRS)
+		return NULL;
+
+	ctx.type =3D READ_MAP_VAR;
+	err =3D bpf_loop(STROBE_MAX_MAPS, read_var_callback, &ctx, 0);
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
@@ -487,7 +554,7 @@ static void *read_strobe_meta(struct task_struct *tas=
k,
 #pragma clang loop unroll(disable)
 #else
 #pragma unroll
-#endif
+#endif /* NO_UNROLL */
 	for (int i =3D 0; i < STROBE_MAX_STRS; ++i) {
 		payload +=3D read_str_var(cfg, i, tls_base, &value, data, payload);
 	}
@@ -495,10 +562,12 @@ static void *read_strobe_meta(struct task_struct *t=
ask,
 #pragma clang loop unroll(disable)
 #else
 #pragma unroll
-#endif
+#endif /* NO_UNROLL */
 	for (int i =3D 0; i < STROBE_MAX_MAPS; ++i) {
 		payload =3D read_map_var(cfg, i, tls_base, &value, data, payload);
 	}
+#endif /* USE_BPF_LOOP */
+
 	/*
 	 * return pointer right after end of payload, so it's possible to
 	 * calculate exact amount of useful data that needs to be sent
diff --git a/tools/testing/selftests/bpf/progs/strobemeta_bpf_loop.c b/to=
ols/testing/selftests/bpf/progs/strobemeta_bpf_loop.c
new file mode 100644
index 000000000000..e6f9f920e68a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/strobemeta_bpf_loop.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+// Copyright (c) 2021 Facebook
+
+#define STROBE_MAX_INTS 2
+#define STROBE_MAX_STRS 25
+#define STROBE_MAX_MAPS 100
+#define STROBE_MAX_MAP_ENTRIES 20
+#define USE_BPF_LOOP
+#include "strobemeta.h"
--=20
2.30.2

