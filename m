Return-Path: <bpf+bounces-15290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CA57EFCFC
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 02:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9643F1F25E88
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 01:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5282420E0;
	Sat, 18 Nov 2023 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBWLUPq4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A754D6D
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 17:34:16 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9e623356e59so355473666b.0
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 17:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700271255; x=1700876055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuvfwn61IVW3VhDnsOv11dwxQoD7AdJ5jVg0qt21yzs=;
        b=DBWLUPq48wzhzjvU3CgbCAi8eWoi/LOsndlV+D0KdL4V+60OPfqsrFqJWWpRtIEUQC
         bJE0V5i+481kgHuTRTUQHK/imowqQYnXrxBlb4K/KmeWGQPos1zYgq/a2I98l1OGkjTH
         9k7EpiykwFqANT2CmWCo3NBms939d5XzMtfvgGd4S42Tg5EfPxwr5VM7T8qUwDmhAYsK
         H5Ip8db5blc2MrBKKPo5Visy7lI3GYU/8j7iX4+vNHB3xQwwsNVDamDTqD5zxcl+r9je
         DyVGRSe+P0UiQIxT6gJQzsZET7o8IMvvhDq+CLEYKrMBulGp6u9JoIjjdGYxObGJQnkd
         uZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700271255; x=1700876055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuvfwn61IVW3VhDnsOv11dwxQoD7AdJ5jVg0qt21yzs=;
        b=xIYtk0naqC8cmuVqFLHDC1U+O2FfJWa6YFwSjaW0h+wUB0/1CJYLGluQSAiB5BiNca
         IJkVkXQppIr10RDG6sGxy41R9/8ZepFzu3iMx3/2WKfe89oqOsxEGL96dt7/dbFq04Yl
         HEGe0Abuh5l/1yvpockdNOYl7F1MBPEMc/9R+MXrr1uvmJ6dhlMerfuvHyAEXgkeVmDB
         0YOGxST7T8GFmpR+FEUjfm4WHjbE8++D9Zdv7jh9O+ldazJRIUuHVimmW69xM8mCw01e
         aeU2PDcUHtptZg90FKdtbU145cBjIO76hhtZnB+/ZILgUM7WnndYq89UK6pPXVuJRDEF
         yCgQ==
X-Gm-Message-State: AOJu0YynlW7PAGNEm3dVsEyeig1MmHzS8CO6/RE9QiDjNDU0dc5MMiWd
	c4HgJFfYmY/NExCPohipkGR01cSe0JM=
X-Google-Smtp-Source: AGHT+IE9DsI+bqpK6kpVAVgyjC1MwFO2T+StyB0Z9dGKQfTJGbBT5nZR8w141eDyMwU7cNiuSjaU0g==
X-Received: by 2002:a17:907:8b88:b0:9c7:58cd:b57 with SMTP id tb8-20020a1709078b8800b009c758cd0b57mr923435ejc.37.1700271254854;
        Fri, 17 Nov 2023 17:34:14 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v27-20020a170906489b00b009d2eb40ff9dsm1359284ejq.33.2023.11.17.17.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 17:34:14 -0800 (PST)
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
Subject: [PATCH bpf v2 07/11] selftests/bpf: tests for iterating callbacks
Date: Sat, 18 Nov 2023 03:33:51 +0200
Message-ID: <20231118013355.7943-8-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118013355.7943-1-eddyz87@gmail.com>
References: <20231118013355.7943-1-eddyz87@gmail.com>
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


