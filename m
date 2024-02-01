Return-Path: <bpf+bounces-20903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5710784502D
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7901B1C2320C
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA15E3BB4D;
	Thu,  1 Feb 2024 04:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVCt3Z9s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1153C485
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 04:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761296; cv=none; b=Jui7d/sVwdqxhj+CLKwL4VSJLWKbNnwdV9Qf9sj++VT7YkQaShSbtz0SQa5z4ORK+V2v4Rtt2Aj4vItKHVX47qKqj46u8G6sGd7sKQwlr+kVun9mnt/k5V1XpUJFNS5IrXYF99yDIbULbmqBkw2s2M57c6lCfKiFFtYe55M8iyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761296; c=relaxed/simple;
	bh=IjjNLd6pt8ZtD/1nEkgQngCD7nEFkiMi90W9nzsZLrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=exyFPgtPB1ua0y1m43HuFdEBoKaibRLZfbbpwFA9Y30pWqb5SDvUhZ6UAG15HQVWxP63CKsy2KFZMlfkBQ6vEUFj2PZegs97GvoR4M5dw/sbcxIbG2TZbpU8V6hTh3hvy4ZbRd+MDhPIz2cJoHbBteaj9hcB6bXMK6IJ/a8sfbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVCt3Z9s; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-339289fead2so274944f8f.3
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 20:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706761291; x=1707366091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JOMGc1rzEyjwLiXBTAoSIAQfvOpFkVoDLvtHwP8uT0=;
        b=lVCt3Z9slauxxXvKRsPhJzrDh3QJd6F6phI0ycbkK0Sse16Udy6JFamhNEAI2TAFpu
         Zpk00H5QJDkvQ2WmKgURcLS7e7mY4Z31/IKD5Nts1Cl1sknBVzUpkRmzzlCbgHuYDu+Z
         LPzbiO18xZE9gWtG2BW+gx10U7LqIy5dJVkVxHAgQh7+t5AbIdAA/LqNQM167+cc4elt
         3cgHPYm/6ZJ9HtvWQFn6ZcHe6jCXzLsWzAeJWOGcqPL9dPWyAG/sKaB/nd3THyv+YwIm
         HF16Ec/yZzxTRn2Pfyp5Ba4yoXWaFicL0I8juY0ud6d+DRxu9vuAXFi2wuOm6cQaGKLs
         iI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761291; x=1707366091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JOMGc1rzEyjwLiXBTAoSIAQfvOpFkVoDLvtHwP8uT0=;
        b=tyINyP/bGPNrAHIEHgtY/U84OtplmD2XxtGLGX8ZED1aLKAzUUNKtKay159DuxFe0s
         tAC5x90lA5ewISPUbDFVAJJ/eaoyLs4fbd+wA8u32e5KsbeoYbGYC9v1AeQd92dkD6Dk
         UoVbIsOiag7Vr+sVvV+0jRlLg5PFCtUZ/d/bf0QNAYJbSGvi+HftkAMzZ6hwfoMZ2jDJ
         tHvCKJifL1DaNgz9rIp/vdCiqsjgBpjqHVl4iW2CYxSGG/zTr294TX3jIbnI5qh3mvpM
         DYNkoaLRGuy/EM9MtN1ph9LDqD7zo6AOhBRJE3YukdvDrASneycRQt8scnzkknNfVCKA
         P23A==
X-Gm-Message-State: AOJu0YzcXcHbqp5l3xumWsIvqFgF2LqT7mp5fpjmLkUrAxqOsafAReOs
	PZzhsp70+V7p6k9cadXFjHpPXnX4OoIYU/gzEAyYqh5chWZkO5woh667ZCD3O/0=
X-Google-Smtp-Source: AGHT+IEKD4vyudTXdd/TD8RhrqLda40h5gy4A6G7YCQDSdKnB0iZS/CyfDg5USjcSgV9JrZXXMjyRg==
X-Received: by 2002:a05:6000:1367:b0:337:c4c1:a3af with SMTP id q7-20020a056000136700b00337c4c1a3afmr2647073wrz.35.1706761291354;
        Wed, 31 Jan 2024 20:21:31 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id s14-20020aa7d78e000000b0055f4fbc32ccsm1858259edq.89.2024.01.31.20.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 20:21:30 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	Raj Sahu <rjsu26@vt.edu>,
	Dan Williams <djwillia@vt.edu>,
	Rishabh Iyer <rishabh.iyer@epfl.ch>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [RFC PATCH v1 14/14] selftests/bpf: Add tests for exceptions runtime cleanup
Date: Thu,  1 Feb 2024 04:21:09 +0000
Message-Id: <20240201042109.1150490-15-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201042109.1150490-1-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=23097; i=memxor@gmail.com; h=from:subject; bh=IjjNLd6pt8ZtD/1nEkgQngCD7nEFkiMi90W9nzsZLrI=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBluxwR3tG5ZIPb7mhOQwEN++30fxmR/SoowDPEO MiXGpNpDmyJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZbscEQAKCRBM4MiGSL8R yrm+D/4sMA78GaqmprwEIEGPKOgELAOicP89bcelEQTM9jv13UugOpLudvO/XjtuthTPB8sVlav bCOGg4bZL3rq3NWFzl4u6D/CpWoOA/bDU4bc2indC2TrMZXujnP6Ok4KU/lpuCS11uXeHjmRTmJ HGjL633U5A6FjSCw7Lfz5KJrbZRJhWyW7dS/v1jK3FwOi9pJsI9oz5EyKXUfbribkKOW9CNcLJo CAwWmOE6Jo0zlFkBvdouvIEfo5pjagEMDHC1uwqmCA2AcsopQvFjLD18sRDH5ZJUv0DshNx5A3r IkWVppMV/HVdFsYc4jgPMAwWlKcxervEVDIq3I56U+bKorPHUkRaAvAlMM7Ce2g1/hubyEgg8Lw FfEpzKSk+YPPvuUlSy6Qala1fpOLuF68Idnjnl2vv6JuyEKDHIjd7BnWbcGaqfPF1lvpYACxA2F GOmcOpLNmYKy+zKo0MBbtGD9IONIp8tKjnfmj/GX07tBSPZiyOpWTgQD7GIlUdPqzWeP6EMDD23 XcXSomHtvw7xUX0DudaqPbYi5esZCT0kxlPHaCUe+6C7bLoYpfD/lqsJia5wXYONdNr0+NhdRPb Bf3vf3fkqzbh4Y3qZ3ol3vztfvWknkM38Z1YrPP4WAS/lJZTBJ66aJVGAUOcdin2ZxTbZlTUGkW Fvp0ofnSLz6/UAQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add tests for the runtime cleanup support for exceptions, ensuring that
resources are correctly identified and released when an exception is
thrown. Also, we add negative tests to exercise corner cases the
verifier should reject.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64  |   1 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../bpf/prog_tests/exceptions_cleanup.c       |  65 +++
 .../selftests/bpf/progs/exceptions_cleanup.c  | 468 ++++++++++++++++++
 .../bpf/progs/exceptions_cleanup_fail.c       | 154 ++++++
 .../selftests/bpf/progs/exceptions_fail.c     |  13 -
 6 files changed, 689 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 5c2cc7e8c5d0..6fc79727cd14 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -1,6 +1,7 @@
 bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
 bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
 exceptions					 # JIT does not support calling kfunc bpf_throw: -524
+exceptions_unwind				 # JIT does not support calling kfunc bpf_throw: -524
 fexit_sleep                                      # The test never returns. The remaining tests cannot start.
 kprobe_multi_bench_attach                        # needs CONFIG_FPROBE
 kprobe_multi_test                                # needs CONFIG_FPROBE
diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 1a63996c0304..f09a73dee72c 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -1,5 +1,6 @@
 # TEMPORARY
 # Alphabetical order
 exceptions				 # JIT does not support calling kfunc bpf_throw				       (exceptions)
+exceptions_unwind			 # JIT does not support calling kfunc bpf_throw				       (exceptions)
 get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
 stacktrace_build_id                      # compare_map_keys stackid_hmap vs. stackmap err -2 errno 2                   (?)
diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
new file mode 100644
index 000000000000..78df037b60ea
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
@@ -0,0 +1,65 @@
+#include "bpf/bpf.h"
+#include "exceptions.skel.h"
+#include <test_progs.h>
+#include <network_helpers.h>
+
+#include "exceptions_cleanup.skel.h"
+#include "exceptions_cleanup_fail.skel.h"
+
+static void test_exceptions_cleanup_fail(void)
+{
+	RUN_TESTS(exceptions_cleanup_fail);
+}
+
+void test_exceptions_cleanup(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, ropts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1,
+	);
+	struct exceptions_cleanup *skel;
+	int ret;
+
+	if (test__start_subtest("exceptions_cleanup_fail"))
+		test_exceptions_cleanup_fail();
+
+	skel = exceptions_cleanup__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "exceptions_cleanup__open_and_load"))
+		return;
+
+	ret = exceptions_cleanup__attach(skel);
+	if (!ASSERT_OK(ret, "exceptions_cleanup__attach"))
+		return;
+
+#define RUN_EXC_CLEANUP_TEST(name)                                      \
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.name), \
+				     &ropts);                           \
+	if (!ASSERT_OK(ret, #name ": return value"))                    \
+		return;                                                 \
+	if (!ASSERT_EQ(ropts.retval, 0xeB9F, #name ": opts.retval"))    \
+		return;                                                 \
+	ret = bpf_prog_test_run_opts(                                   \
+		bpf_program__fd(skel->progs.exceptions_cleanup_check),  \
+		&ropts);                                                \
+	if (!ASSERT_OK(ret, #name " CHECK: return value"))              \
+		return;                                                 \
+	if (!ASSERT_EQ(ropts.retval, 0, #name " CHECK: opts.retval"))   \
+		return;													\
+	skel->bss->only_count = 0;
+
+	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_prog_num_iter);
+	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_prog_num_iter_mult);
+	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_prog_dynptr_iter);
+	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_obj);
+	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_percpu_obj);
+	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_ringbuf);
+	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_reg);
+	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_null_or_ptr_do_ptr);
+	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_null_or_ptr_do_null);
+	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_callee_saved);
+	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_frame);
+	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_loop_iterations);
+	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_dead_code_elim);
+	RUN_EXC_CLEANUP_TEST(exceptions_cleanup_frame_dce);
+}
diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
new file mode 100644
index 000000000000..ccf14fe6bd1b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
@@ -0,0 +1,468 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_endian.h>
+#include "bpf_misc.h"
+#include "bpf_kfuncs.h"
+#include "bpf_experimental.h"
+
+struct {
+    __uint(type, BPF_MAP_TYPE_RINGBUF);
+    __uint(max_entries, 8);
+} ringbuf SEC(".maps");
+
+enum {
+    RES_DYNPTR,
+    RES_ITER,
+    RES_REG,
+    RES_SPILL,
+    __RES_MAX,
+};
+
+struct bpf_resource {
+    int type;
+};
+
+struct {
+    __uint(type, BPF_MAP_TYPE_HASH);
+    __uint(max_entries, 1024);
+    __type(key, int);
+    __type(value, struct bpf_resource);
+} hashmap SEC(".maps");
+
+const volatile bool always_false = false;
+bool only_count = false;
+int res_count = 0;
+
+#define MARK_RESOURCE(ptr, type) ({ res_count++; bpf_map_update_elem(&hashmap, &(void *){ptr}, &(struct bpf_resource){type}, 0); });
+#define FIND_RESOURCE(ptr) ((struct bpf_resource *)bpf_map_lookup_elem(&hashmap, &(void *){ptr}) ?: &(struct bpf_resource){__RES_MAX})
+#define FREE_RESOURCE(ptr) bpf_map_delete_elem(&hashmap, &(void *){ptr})
+#define VAL 0xeB9F
+
+SEC("fentry/bpf_cleanup_resource")
+int BPF_PROG(exception_cleanup_mark_free, struct bpf_frame_desc_reg_entry *fd, void *ptr)
+{
+    if (fd->spill_type == STACK_INVALID)
+        bpf_probe_read_kernel(&ptr, sizeof(ptr), ptr);
+    if (only_count) {
+        res_count--;
+        return 0;
+    }
+    switch (fd->spill_type) {
+    case STACK_SPILL:
+        if (FIND_RESOURCE(ptr)->type == RES_SPILL)
+            FREE_RESOURCE(ptr);
+        break;
+    case STACK_INVALID:
+        if (FIND_RESOURCE(ptr)->type == RES_REG)
+            FREE_RESOURCE(ptr);
+        break;
+    case STACK_ITER:
+        if (FIND_RESOURCE(ptr)->type == RES_ITER)
+            FREE_RESOURCE(ptr);
+        break;
+    case STACK_DYNPTR:
+        if (FIND_RESOURCE(ptr)->type == RES_DYNPTR)
+            FREE_RESOURCE(ptr);
+        break;
+    }
+    return 0;
+}
+
+static long map_cb(struct bpf_map *map, void *key, void *value, void *ctx)
+{
+    int *cnt = ctx;
+
+    (*cnt)++;
+    return 0;
+}
+
+SEC("tc")
+int exceptions_cleanup_check(struct __sk_buff *ctx)
+{
+    int cnt = 0;
+
+    if (only_count)
+        return res_count;
+    bpf_for_each_map_elem(&hashmap, map_cb, &cnt, 0);
+    return cnt;
+}
+
+SEC("tc")
+int exceptions_cleanup_prog_num_iter(struct __sk_buff *ctx)
+{
+    int i;
+
+    bpf_for(i, 0, 10) {
+        MARK_RESOURCE(&___it, RES_ITER);
+        bpf_throw(VAL);
+    }
+    return 0;
+}
+
+SEC("tc")
+int exceptions_cleanup_prog_num_iter_mult(struct __sk_buff *ctx)
+{
+    int i, j, k;
+
+    bpf_for(i, 0, 10) {
+        MARK_RESOURCE(&___it, RES_ITER);
+        bpf_for(j, 0, 10) {
+            MARK_RESOURCE(&___it, RES_ITER);
+            bpf_for(k, 0, 10) {
+                MARK_RESOURCE(&___it, RES_ITER);
+                bpf_throw(VAL);
+            }
+        }
+    }
+    return 0;
+}
+
+__noinline
+static int exceptions_cleanup_subprog(struct __sk_buff *ctx)
+{
+    int i;
+
+    bpf_for(i, 0, 10) {
+        MARK_RESOURCE(&___it, RES_ITER);
+        bpf_throw(VAL);
+    }
+    return ctx->len;
+}
+
+SEC("tc")
+int exceptions_cleanup_prog_dynptr_iter(struct __sk_buff *ctx)
+{
+    struct bpf_dynptr rbuf;
+    int ret = 0;
+
+    bpf_ringbuf_reserve_dynptr(&ringbuf, 8, 0, &rbuf);
+    MARK_RESOURCE(&rbuf, RES_DYNPTR);
+    if (ctx->protocol)
+        ret = exceptions_cleanup_subprog(ctx);
+    bpf_ringbuf_discard_dynptr(&rbuf, 0);
+    return ret;
+}
+
+SEC("tc")
+int exceptions_cleanup_obj(struct __sk_buff *ctx)
+{
+    struct { int i; } *p;
+
+    p = bpf_obj_new(typeof(*p));
+    MARK_RESOURCE(&p, RES_SPILL);
+    bpf_throw(VAL);
+    return p->i;
+}
+
+SEC("tc")
+int exceptions_cleanup_percpu_obj(struct __sk_buff *ctx)
+{
+    struct { int i; } *p;
+
+    p = bpf_percpu_obj_new(typeof(*p));
+    MARK_RESOURCE(&p, RES_SPILL);
+    bpf_throw(VAL);
+    return !p;
+}
+
+SEC("tc")
+int exceptions_cleanup_ringbuf(struct __sk_buff *ctx)
+{
+    void *p;
+
+    p = bpf_ringbuf_reserve(&ringbuf, 8, 0);
+    MARK_RESOURCE(&p, RES_SPILL);
+    bpf_throw(VAL);
+    return 0;
+}
+
+SEC("tc")
+int exceptions_cleanup_reg(struct __sk_buff *ctx)
+{
+    void *p;
+
+    p = bpf_ringbuf_reserve(&ringbuf, 8, 0);
+    MARK_RESOURCE(p, RES_REG);
+    bpf_throw(VAL);
+    if (p)
+        bpf_ringbuf_discard(p, 0);
+    return 0;
+}
+
+SEC("tc")
+int exceptions_cleanup_null_or_ptr_do_ptr(struct __sk_buff *ctx)
+{
+    union {
+        void *p;
+        char buf[8];
+    } volatile p;
+    u64 z = 0;
+
+    __builtin_memcpy((void *)&p.p, &z, sizeof(z));
+    MARK_RESOURCE((void *)&p.p, RES_SPILL);
+    if (ctx->len)
+        p.p = bpf_ringbuf_reserve(&ringbuf, 8, 0);
+    bpf_throw(VAL);
+    return 0;
+}
+
+SEC("tc")
+int exceptions_cleanup_null_or_ptr_do_null(struct __sk_buff *ctx)
+{
+    union {
+        void *p;
+        char buf[8];
+    } volatile p;
+
+    p.p = 0;
+    MARK_RESOURCE((void *)p.buf, RES_SPILL);
+    if (!ctx->len)
+        p.p = bpf_ringbuf_reserve(&ringbuf, 8, 0);
+    bpf_throw(VAL);
+    return 0;
+}
+
+__noinline static int mark_resource_subprog(u64 a, u64 b, u64 c, u64 d)
+{
+    MARK_RESOURCE((void *)a, RES_REG);
+    MARK_RESOURCE((void *)b, RES_REG);
+    MARK_RESOURCE((void *)c, RES_REG);
+    MARK_RESOURCE((void *)d, RES_REG);
+    return 0;
+}
+
+SEC("tc")
+int exceptions_cleanup_callee_saved(struct __sk_buff *ctx)
+{
+    asm volatile (
+       "r1 = %[ringbuf] ll;             \
+        r2 = 8;                         \
+        r3 = 0;                         \
+        call %[bpf_ringbuf_reserve];    \
+        r6 = r0;                        \
+        r1 = %[ringbuf] ll;             \
+        r2 = 8;                         \
+        r3 = 0;                         \
+        call %[bpf_ringbuf_reserve];    \
+        r7 = r0;                        \
+        r1 = %[ringbuf] ll;             \
+        r2 = 8;                         \
+        r3 = 0;                         \
+        call %[bpf_ringbuf_reserve];    \
+        r8 = r0;                        \
+        r1 = %[ringbuf] ll;             \
+        r2 = 8;                         \
+        r3 = 0;                         \
+        call %[bpf_ringbuf_reserve];    \
+        r9 = r0;                        \
+        r1 = r6;                        \
+        r2 = r7;                        \
+        r3 = r8;                        \
+        r4 = r9;                        \
+        call mark_resource_subprog;     \
+        r1 = 0xeB9F;                    \
+        call bpf_throw;                 \
+    " : : __imm(bpf_ringbuf_reserve),
+          __imm_addr(ringbuf)
+      : __clobber_all);
+    mark_resource_subprog(0, 0, 0, 0);
+    return 0;
+}
+
+SEC("tc")
+int exceptions_cleanup_callee_saved_noopt(struct __sk_buff *ctx)
+{
+    mark_resource_subprog(1, 2, 3, 4);
+    return 0;
+}
+
+__noinline int global_subprog_throw(struct __sk_buff *ctx)
+{
+    u64 *p = bpf_ringbuf_reserve(&ringbuf, 8, 0);
+    bpf_throw(VAL);
+    return p ? *p : 0 + ctx->len;
+}
+
+__noinline int global_subprog(struct __sk_buff *ctx)
+{
+    u64 *p = bpf_ringbuf_reserve(&ringbuf, 8, 0);
+    if (!p)
+        return ctx->len;
+    global_subprog_throw(ctx);
+    bpf_ringbuf_discard(p, 0);
+    return !!p + ctx->len;
+}
+
+__noinline static int static_subprog(struct __sk_buff *ctx)
+{
+    struct bpf_dynptr rbuf;
+    u64 *p, r = 0;
+
+    bpf_ringbuf_reserve_dynptr(&ringbuf, 8, 0, &rbuf);
+    p = bpf_dynptr_data(&rbuf, 0, 8);
+    if (!p)
+        goto end;
+    *p = global_subprog(ctx);
+    r += *p;
+end:
+    bpf_ringbuf_discard_dynptr(&rbuf, 0);
+    return r + ctx->len;
+}
+
+SEC("tc")
+int exceptions_cleanup_frame(struct __sk_buff *ctx)
+{
+    struct foo { int i; } *p = bpf_obj_new(typeof(*p));
+    int i;
+    only_count = 1;
+    res_count = 4;
+    if (!p)
+        return 1;
+    p->i = static_subprog(ctx);
+    i = p->i;
+    bpf_obj_drop(p);
+    return i + ctx->len;
+}
+
+SEC("tc")
+__success
+int exceptions_cleanup_loop_iterations(struct __sk_buff *ctx)
+{
+    struct { int i; } *f[50] = {};
+    int i;
+
+    only_count = true;
+
+    for (i = 0; i < 50; i++) {
+        f[i] = bpf_obj_new(typeof(*f[0]));
+        if (!f[i])
+            goto end;
+        res_count++;
+        if (i == 49) {
+            bpf_throw(VAL);
+        }
+    }
+end:
+    for (i = 0; i < 50; i++) {
+        if (!f[i])
+            continue;
+        bpf_obj_drop(f[i]);
+    }
+    return 0;
+}
+
+SEC("tc")
+int exceptions_cleanup_dead_code_elim(struct __sk_buff *ctx)
+{
+    void *p;
+
+    p = bpf_ringbuf_reserve(&ringbuf, 8, 0);
+    if (!p)
+        return 0;
+    asm volatile (
+        "r0 = r0;        \
+         r0 = r0;        \
+         r0 = r0;        \
+         r0 = r0;        \
+         r0 = r0;        \
+         r0 = r0;        \
+         r0 = r0;        \
+    " ::: "r0");
+    bpf_throw(VAL);
+    bpf_ringbuf_discard(p, 0);
+    return 0;
+}
+
+__noinline int global_subprog_throw_dce(struct __sk_buff *ctx)
+{
+    u64 *p = bpf_ringbuf_reserve(&ringbuf, 8, 0);
+    bpf_throw(VAL);
+    return p ? *p : 0 + ctx->len;
+}
+
+__noinline int global_subprog_dce(struct __sk_buff *ctx)
+{
+    u64 *p = bpf_ringbuf_reserve(&ringbuf, 8, 0);
+    if (!p)
+        return ctx->len;
+    asm volatile (
+        "r0 = r0;        \
+         r0 = r0;        \
+         r0 = r0;        \
+         r0 = r0;        \
+         r0 = r0;        \
+         r0 = r0;        \
+         r0 = r0;        \
+    " ::: "r0");
+    global_subprog_throw_dce(ctx);
+    bpf_ringbuf_discard(p, 0);
+    return !!p + ctx->len;
+}
+
+__noinline static int static_subprog_dce(struct __sk_buff *ctx)
+{
+    struct bpf_dynptr rbuf;
+    u64 *p, r = 0;
+
+    bpf_ringbuf_reserve_dynptr(&ringbuf, 8, 0, &rbuf);
+    p = bpf_dynptr_data(&rbuf, 0, 8);
+    if (!p)
+        goto end;
+    asm volatile (
+        "r0 = r0;        \
+         r0 = r0;        \
+         r0 = r0;        \
+         r0 = r0;        \
+         r0 = r0;        \
+         r0 = r0;        \
+         r0 = r0;        \
+    " ::: "r0");
+    *p = global_subprog_dce(ctx);
+    r += *p;
+end:
+    bpf_ringbuf_discard_dynptr(&rbuf, 0);
+    return r + ctx->len;
+}
+
+SEC("tc")
+int exceptions_cleanup_frame_dce(struct __sk_buff *ctx)
+{
+    struct foo { int i; } *p = bpf_obj_new(typeof(*p));
+    int i;
+    only_count = 1;
+    res_count = 4;
+    if (!p)
+        return 1;
+    p->i = static_subprog_dce(ctx);
+    i = p->i;
+    bpf_obj_drop(p);
+    return i + ctx->len;
+}
+
+SEC("tc")
+int reject_slot_with_zero_vs_ptr_ok(struct __sk_buff *ctx)
+{
+    asm volatile (
+       "r7 = *(u32 *)(r1 + 0);          \
+        r0 = 0;                         \
+        *(u64 *)(r10 - 8) = r0;         \
+        r1 = %[ringbuf] ll;             \
+        r2 = 8;                         \
+        r3 = 0;                         \
+        if r7 != 0 goto jump4;          \
+        call %[bpf_ringbuf_reserve];    \
+        *(u64 *)(r10 - 8) = r0;         \
+    jump4:                              \
+        r0 = 0;                         \
+        r1 = 0;                         \
+        call bpf_throw;                 \
+    " : : __imm(bpf_ringbuf_reserve),
+          __imm_addr(ringbuf)
+      : "memory");
+    return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
new file mode 100644
index 000000000000..b3c70f92b35f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+struct {
+    __uint(type, BPF_MAP_TYPE_RINGBUF);
+    __uint(max_entries, 8);
+} ringbuf SEC(".maps");
+
+SEC("?tc")
+__failure __msg("Unreleased reference")
+int reject_with_reference(void *ctx)
+{
+	struct { int i; } *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	bpf_throw(0);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("frame_desc: merge: failed to merge old and new frame desc entry")
+int reject_slot_with_distinct_ptr(struct __sk_buff *ctx)
+{
+    void *p;
+
+    if (ctx->len) {
+        p = bpf_ringbuf_reserve(&ringbuf, 8, 0);
+    } else {
+        p = bpf_obj_new(typeof(struct { int i; }));
+    }
+    bpf_throw(0);
+    return !p;
+}
+
+SEC("?tc")
+__failure __msg("frame_desc: merge: failed to merge old and new frame desc entry")
+int reject_slot_with_distinct_ptr_old(struct __sk_buff *ctx)
+{
+    void *p;
+
+    if (ctx->len) {
+        p = bpf_obj_new(typeof(struct { int i; }));
+    } else {
+        p = bpf_ringbuf_reserve(&ringbuf, 8, 0);
+    }
+    bpf_throw(0);
+    return !p;
+}
+
+SEC("?tc")
+__failure __msg("frame_desc: merge: failed to merge old and new frame desc entry")
+int reject_slot_with_misc_vs_ptr(struct __sk_buff *ctx)
+{
+    void *p = (void *)bpf_ktime_get_ns();
+
+    if (ctx->protocol)
+        p = bpf_ringbuf_reserve(&ringbuf, 8, 0);
+    bpf_throw(0);
+    return !p;
+}
+
+SEC("?tc")
+__failure __msg("Unreleased reference")
+int reject_slot_with_misc_vs_ptr_old(struct __sk_buff *ctx)
+{
+    void *p = bpf_ringbuf_reserve(&ringbuf, 8, 0);
+
+    if (ctx->protocol)
+        p = (void *)bpf_ktime_get_ns();
+    bpf_throw(0);
+    return !p;
+}
+
+SEC("?tc")
+__failure __msg("frame_desc: merge: failed to merge old and new frame desc entry")
+int reject_slot_with_invalid_vs_ptr(struct __sk_buff *ctx)
+{
+    asm volatile (
+       "r7 = r1;                        \
+        r1 = %[ringbuf] ll;             \
+        r2 = 8;                         \
+        r3 = 0;                         \
+        r4 = *(u32 *)(r7 + 0);          \
+        r6 = *(u64 *)(r10 - 8);         \
+        if r4 == 0 goto jump;           \
+        call %[bpf_ringbuf_reserve];    \
+        r6 = r0;                        \
+    jump:                               \
+        r0 = 0;                         \
+        r1 = 0;                         \
+        call bpf_throw;                 \
+    " : : __imm(bpf_ringbuf_reserve),
+          __imm_addr(ringbuf)
+      : "memory");
+    return 0;
+}
+
+SEC("?tc")
+__failure __msg("Unreleased reference")
+int reject_slot_with_invalid_vs_ptr_old(struct __sk_buff *ctx)
+{
+    asm volatile (
+       "r7 = r1;                        \
+        r1 = %[ringbuf] ll;             \
+        r2 = 8;                         \
+        r3 = 0;                         \
+        call %[bpf_ringbuf_reserve];    \
+        r6 = r0;                        \
+        r4 = *(u32 *)(r7 + 0);          \
+        if r4 == 0 goto jump2;          \
+        r6 = *(u64 *)(r10 - 8);         \
+    jump2:                              \
+        r0 = 0;                         \
+        r1 = 0;                         \
+        call bpf_throw;                 \
+    " : : __imm(bpf_ringbuf_reserve),
+          __imm_addr(ringbuf)
+      : "memory");
+    return 0;
+}
+
+SEC("?tc")
+__failure __msg("Unreleased reference")
+int reject_slot_with_zero_vs_ptr(struct __sk_buff *ctx)
+{
+    asm volatile (
+       "r7 = *(u32 *)(r1 + 0);          \
+        r1 = %[ringbuf] ll;             \
+        r2 = 8;                         \
+        r3 = 0;                         \
+        call %[bpf_ringbuf_reserve];    \
+        *(u64 *)(r10 - 8) = r0;         \
+        r0 = 0;                         \
+        if r7 != 0 goto jump3;          \
+        *(u64 *)(r10 - 8) = r0;         \
+    jump3:                              \
+        r0 = 0;                         \
+        r1 = 0;                         \
+        call bpf_throw;                 \
+    " : : __imm(bpf_ringbuf_reserve),
+          __imm_addr(ringbuf)
+      : "memory");
+    return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
index dfd164a7a261..1e73200c6276 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -182,19 +182,6 @@ int reject_with_rbtree_add_throw(void *ctx)
 	return 0;
 }
 
-SEC("?tc")
-__failure __msg("Unreleased reference")
-int reject_with_reference(void *ctx)
-{
-	struct foo *f;
-
-	f = bpf_obj_new(typeof(*f));
-	if (!f)
-		return 0;
-	bpf_throw(0);
-	return 0;
-}
-
 __noinline static int subprog_ref(struct __sk_buff *ctx)
 {
 	struct foo *f;
-- 
2.40.1


