Return-Path: <bpf+bounces-15488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CAC7F239C
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 03:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088DD28268B
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 02:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BBD14294;
	Tue, 21 Nov 2023 02:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfqoE3h9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3ABDCA
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 18:07:35 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9fd0059a967so353101066b.1
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 18:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700532453; x=1701137253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuvfwn61IVW3VhDnsOv11dwxQoD7AdJ5jVg0qt21yzs=;
        b=IfqoE3h9MBavROWfAhh2WjGu5Ik8FhIRZohrhedAciSzyjqXe9QLNC51b4brESFxaD
         chdpEqu7yTcDC203/ZbQkZE+4xJ2niUGTriyhSgzp+szM/9ZzvfRMcy3jrWF2VF5Td9Y
         FzhYLJQ0FA/uhZAmd789rQMuQCzdP9jXzGXb5+fM58MXkvXSnwKxZ0tQzhy59CbPZD6U
         SPYmbM201vnx1Y2XlCGgKS1W0THcf3O5VeZCWcxBaK9Uv2QldIhWSP6dR8InMMHmfh/v
         WLQFahNEvjvMpa7EA/VhcNs6u3CCQAhKyPCkkP3gJhuwr8J5k+zHtse2wj98bM5j2rDI
         w20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700532453; x=1701137253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuvfwn61IVW3VhDnsOv11dwxQoD7AdJ5jVg0qt21yzs=;
        b=nCRT1kE0x/6KH80aFtqY2kG9o0d+HanMqS7/FE7CQBerUnN42f/9y0EvnYtdgYSpS6
         J4wsUdZ7Xh+1xnnSykIOLPPnNHZvB93NsSDnXnV4cdDRSVUtMpCCWZfoIb/fH2KDCTD5
         tCKwtDGWO8JhnrZNQZ4jVUwln2+5C5UXgZfipK9e3z0VnuT9HysdfpEq601YgpGq0Oz4
         kjtSLZVTHgWgMUbzs5Px2QTdNRXeMJ822lN7rBkDcny8QZemTdbeV9icD7+eyjP3R24O
         8mjN3dXU1gj3Y2k5tSQWOLde1oso8USQHvl4wGZ1/fQMbzEEivqv5EHDgWXjRXNdW6r/
         L1kg==
X-Gm-Message-State: AOJu0YwEkuI7sV//5tTbBbXv5o4y56/GRlsyyPBExToKrVyDTvy/faoc
	XtweNWDt2WVPu2mms3pk4jMXDoY1rAUGLA==
X-Google-Smtp-Source: AGHT+IH7jcuc1YckSSP6ncasj9KekY5U0KvIadzyZp9L1P7CNx46uy9r3wVHwrgYuEemdVAsOPwdQA==
X-Received: by 2002:a17:907:d27:b0:9ee:462c:7924 with SMTP id gn39-20020a1709070d2700b009ee462c7924mr1555241ejc.9.1700532453074;
        Mon, 20 Nov 2023 18:07:33 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ha7-20020a170906a88700b009fc990d9edbsm2426668ejb.192.2023.11.20.18.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:07:32 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	awerner32@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf v4 07/11] selftests/bpf: tests for iterating callbacks
Date: Tue, 21 Nov 2023 04:06:57 +0200
Message-ID: <20231121020701.26440-8-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121020701.26440-1-eddyz87@gmail.com>
References: <20231121020701.26440-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A set of test cases to check behavior of callback handling logic,
check if verifier catches the following situations:
- program not safe on second callback iteration;
- program not safe on zero callback iterations;
- infinite loop inside a callback.

Verify that callback logic works for bpf_loop, bpf_for_each_map_elem,
bpf_user_ringbuf_drain, bpf_find_vma.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_iterating_callbacks.c  | 147 ++++++++++++++++++
 2 files changed, 149 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index e5c61aa6604a..5cfa7a6316b6 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -31,6 +31,7 @@
 #include "verifier_helper_restricted.skel.h"
 #include "verifier_helper_value_access.skel.h"
 #include "verifier_int_ptr.skel.h"
+#include "verifier_iterating_callbacks.skel.h"
 #include "verifier_jeq_infer_not_null.skel.h"
 #include "verifier_ld_ind.skel.h"
 #include "verifier_ldsx.skel.h"
@@ -139,6 +140,7 @@ void test_verifier_helper_packet_access(void) { RUN(verifier_helper_packet_acces
 void test_verifier_helper_restricted(void)    { RUN(verifier_helper_restricted); }
 void test_verifier_helper_value_access(void)  { RUN(verifier_helper_value_access); }
 void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
+void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_callbacks); }
 void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null); }
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
 void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
new file mode 100644
index 000000000000..fa9429f77a81
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 8);
+	__type(key, __u32);
+	__type(value, __u64);
+} map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_USER_RINGBUF);
+	__uint(max_entries, 8);
+} ringbuf SEC(".maps");
+
+struct vm_area_struct;
+struct bpf_map;
+
+struct buf_context {
+	char *buf;
+};
+
+struct num_context {
+	__u64 i;
+};
+
+__u8 choice_arr[2] = { 0, 1 };
+
+static int unsafe_on_2nd_iter_cb(__u32 idx, struct buf_context *ctx)
+{
+	if (idx == 0) {
+		ctx->buf = (char *)(0xDEAD);
+		return 0;
+	}
+
+	if (bpf_probe_read_user(ctx->buf, 8, (void *)(0xBADC0FFEE)))
+		return 1;
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("R1 type=scalar expected=fp")
+int unsafe_on_2nd_iter(void *unused)
+{
+	char buf[4];
+	struct buf_context loop_ctx = { .buf = buf };
+
+	bpf_loop(100, unsafe_on_2nd_iter_cb, &loop_ctx, 0);
+	return 0;
+}
+
+static int unsafe_on_zero_iter_cb(__u32 idx, struct num_context *ctx)
+{
+	ctx->i = 0;
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("invalid access to map value, value_size=2 off=32 size=1")
+int unsafe_on_zero_iter(void *unused)
+{
+	struct num_context loop_ctx = { .i = 32 };
+
+	bpf_loop(100, unsafe_on_zero_iter_cb, &loop_ctx, 0);
+	return choice_arr[loop_ctx.i];
+}
+
+static int loop_detection_cb(__u32 idx, struct num_context *ctx)
+{
+	for (;;) {}
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("infinite loop detected")
+int loop_detection(void *unused)
+{
+	struct num_context loop_ctx = { .i = 0 };
+
+	bpf_loop(100, loop_detection_cb, &loop_ctx, 0);
+	return 0;
+}
+
+static __always_inline __u64 oob_state_machine(struct num_context *ctx)
+{
+	switch (ctx->i) {
+	case 0:
+		ctx->i = 1;
+		break;
+	case 1:
+		ctx->i = 32;
+		break;
+	}
+	return 0;
+}
+
+static __u64 for_each_map_elem_cb(struct bpf_map *map, __u32 *key, __u64 *val, void *data)
+{
+	return oob_state_machine(data);
+}
+
+SEC("?raw_tp")
+__failure __msg("invalid access to map value, value_size=2 off=32 size=1")
+int unsafe_for_each_map_elem(void *unused)
+{
+	struct num_context loop_ctx = { .i = 0 };
+
+	bpf_for_each_map_elem(&map, for_each_map_elem_cb, &loop_ctx, 0);
+	return choice_arr[loop_ctx.i];
+}
+
+static __u64 ringbuf_drain_cb(struct bpf_dynptr *dynptr, void *data)
+{
+	return oob_state_machine(data);
+}
+
+SEC("?raw_tp")
+__failure __msg("invalid access to map value, value_size=2 off=32 size=1")
+int unsafe_ringbuf_drain(void *unused)
+{
+	struct num_context loop_ctx = { .i = 0 };
+
+	bpf_user_ringbuf_drain(&ringbuf, ringbuf_drain_cb, &loop_ctx, 0);
+	return choice_arr[loop_ctx.i];
+}
+
+static __u64 find_vma_cb(struct task_struct *task, struct vm_area_struct *vma, void *data)
+{
+	return oob_state_machine(data);
+}
+
+SEC("?raw_tp")
+__failure __msg("invalid access to map value, value_size=2 off=32 size=1")
+int unsafe_find_vma(void *unused)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct num_context loop_ctx = { .i = 0 };
+
+	bpf_find_vma(task, 0, find_vma_cb, &loop_ctx, 0);
+	return choice_arr[loop_ctx.i];
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.42.1


