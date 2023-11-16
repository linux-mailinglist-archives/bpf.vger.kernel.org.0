Return-Path: <bpf+bounces-15142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A7F7ED936
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 03:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27C29B20AC3
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 02:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DD779C4;
	Thu, 16 Nov 2023 02:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1VOZC9f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51198E
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:40 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9e623356d5dso44075966b.3
        for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700101119; x=1700705919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtsYm7+4lcgBGbdtQ7YUUXaD/llKL/SonujoxPfo2z8=;
        b=K1VOZC9fAqRtMYXoQqfKV8CsGee+5wBqSW9FnlNvo8oNZnEf/yVSbEMeo/RvRYI1rT
         C8aRHrFK+nVOinFHxdSV7Ut4SPoZrGHBluCQX42e2fyVOqFeqtCY+ojU+/RHaNF6IFZr
         U3Oxyu0AJatMdhsb3wZ/3uS8OFTbfxUgQDDpQxY/7OFwrTEIf+yOp5bZddwSWnNfvEBA
         p0GG3IDujVQ2juf4b/2EhtHGZp2Rdl+wv5oOyaaMuylAVKVnOKjHDLqsKzahhQmMN3qC
         XzPZMUzhypzKBpq+S/f/wIegl5C7ODJHKS6r1gh6asB783vQvqeZJhaSnK1llYWkiWv/
         pilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700101119; x=1700705919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtsYm7+4lcgBGbdtQ7YUUXaD/llKL/SonujoxPfo2z8=;
        b=BaRmVXgnDlsuTa8DhCI+VY8Ux9TDXYmERlCj+FlF2dv3gMGYMXisltZidxdtDo/kyq
         GJ+JXS67W/7eAYv1JP4knCjMGnx8pJuOGgU+wElTl72kglZbHTWcjdJtyUyuhA/BRyPs
         E6Ip4ObK12ECO+QzPdDuXNldnrq4NcqKBYkBRIi9GrvJSxGnvScOQfIwy0qYI+gnDqrZ
         U+5sIJwmGXHNdtPswbgRQjvEtrZfU5UGd84euY+NKwLCHbFquvjf8HW03bvHgNXJpf//
         /JNbzue91qgpnfgreCfQC3SsqfMkMic0xMQ23Sp0Gy/5Q4gS7dxIcPSdGeHoeBg0uwPM
         Hdow==
X-Gm-Message-State: AOJu0YzanaNXxQZBKaFek2YumoV3KsbFwFsSlRXbNiCpUNqw6CBiMLAs
	CgRDeCOzY53YQSEkm9HqESpS+eP+jl0HwA==
X-Google-Smtp-Source: AGHT+IGY3fLV2hPyvoOkXVAC2wB9U7k13f8EwWYUczAxyjei16zfPUZRSiGqQYy8S1S+GR8FsrKJRQ==
X-Received: by 2002:a17:906:811:b0:9a6:426f:7dfd with SMTP id e17-20020a170906081100b009a6426f7dfdmr8830635ejd.66.1700101118930;
        Wed, 15 Nov 2023 18:18:38 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ay1-20020a170906d28100b009dd606ce80fsm7774064ejb.31.2023.11.15.18.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 18:18:38 -0800 (PST)
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
Subject: [PATCH bpf 07/12] selftests/bpf: tests for iterating callbacks
Date: Thu, 16 Nov 2023 04:17:58 +0200
Message-ID: <20231116021803.9982-8-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116021803.9982-1-eddyz87@gmail.com>
References: <20231116021803.9982-1-eddyz87@gmail.com>
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
2.42.0


