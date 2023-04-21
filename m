Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603486EB302
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 22:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjDUUpc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 16:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjDUUpb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 16:45:31 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36B81FCE
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 13:45:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f17e584462so22064935e9.2
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 13:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682109928; x=1684701928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rEWZrvSHxaTJxbITBq44XPm4Epwm/Ypf8OdsXei8kjo=;
        b=a2IS489VG8PN5uLO+nVFV6j9drMHuohD3OT3kDyznJk/ryj/atNsnsJB4MO1opSSbC
         VuxLlyiv3P008+kxxLCL8kxIpHcdFkTvbuq8bO1BLlV+OVpGp+loZsJ6+FHatdTNg5eX
         SaV6WdzpunHGpFQWbIhqennrqEhG22M58vyNDaCr94KQc1uSBJzn2YQAJQ4Z7AxVwVJJ
         HtxylwnBsLMnHTqX36PCJ7bItUCLye/o+Yf4wwIuS8rHakjI/hpPdAKEu5dH5GreAciQ
         HPUKSFdIdKLpGuD74tIhlZzZVJiB907yaMtmhts6EuUygXZAqLc2gFaQIaJf+2BDvq6g
         NS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682109928; x=1684701928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEWZrvSHxaTJxbITBq44XPm4Epwm/Ypf8OdsXei8kjo=;
        b=HUNe0omaxqs541WtpOVnJca4pTGZPoOrlG82ctyAlPXhVcnVZvUdYfg1+ftlu3hL/O
         +jDazrvgGFKT1x7wjMIvNw6od+RMpB0tzea2gCVoJAMU64kku3dyL6ZOgZ3zVz7qmiPS
         3YgXsIsjKi24OhYTpwGP5bZ/RzOz/OYMiFogB32SNSlXT7oQVimHpNrK6tPaeLoinEn2
         yAkHbtr1ucCIe0ww3M4geAXvXxeCbCOQOmxWmgAkD38CI61/iZItkiBl4RR8FRJbgwtM
         24BmDfdSV/VIYWEVIYI4VD9GyhHlUDnV3GEfQ7oFrnWcbaxLlmm4lWaioWHieuVNnhLE
         K6Ug==
X-Gm-Message-State: AAQBX9fngFnzI5X3tI1S02SLQZlTH9NIRaZIr//ZnhDd3aYkVTq+mHSm
        XfBorjxoTNwo5VEXuVr1FgOeX8SGn1xrmA==
X-Google-Smtp-Source: AKy350Y/V9/5egen6xh9f7jViKMrWu0dq6mGhKYsBvE+r3ASs9R6GLIIhZkS1oQ27hl8oFFU0t7VHg==
X-Received: by 2002:a7b:cbd5:0:b0:3ee:96f0:ea31 with SMTP id n21-20020a7bcbd5000000b003ee96f0ea31mr2915890wmi.18.1682109927764;
        Fri, 21 Apr 2023 13:45:27 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id u8-20020a7bc048000000b003f1952a4bdesm1930264wmc.26.2023.04.21.13.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 13:45:27 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: verifier/prevent_map_lookup converted to inline assembly
Date:   Fri, 21 Apr 2023 23:45:14 +0300
Message-Id: <20230421204514.2450907-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test verifier/prevent_map_lookup automatically converted to use inline assembly.

This was a part of a series [1] but could not be applied becuase
another patch from a series had to be witheld.

[1] https://lore.kernel.org/bpf/20230421174234.2391278-1-eddyz87@gmail.com/

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_prevent_map_lookup.c   | 61 +++++++++++++++++++
 .../bpf/verifier/prevent_map_lookup.c         | 29 ---------
 3 files changed, 63 insertions(+), 29 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_prevent_map_lookup.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/prevent_map_lookup.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index c8bab8b1a6a4..2497716ee379 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -42,6 +42,7 @@
 #include "verifier_meta_access.skel.h"
 #include "verifier_netfilter_ctx.skel.h"
 #include "verifier_netfilter_retcode.skel.h"
+#include "verifier_prevent_map_lookup.skel.h"
 #include "verifier_raw_stack.skel.h"
 #include "verifier_raw_tp_writable.skel.h"
 #include "verifier_reg_equal.skel.h"
@@ -140,6 +141,7 @@ void test_verifier_masking(void)              { RUN(verifier_masking); }
 void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
 void test_verifier_netfilter_ctx(void)        { RUN(verifier_netfilter_ctx); }
 void test_verifier_netfilter_retcode(void)    { RUN(verifier_netfilter_retcode); }
+void test_verifier_prevent_map_lookup(void)   { RUN(verifier_prevent_map_lookup); }
 void test_verifier_raw_stack(void)            { RUN(verifier_raw_stack); }
 void test_verifier_raw_tp_writable(void)      { RUN(verifier_raw_tp_writable); }
 void test_verifier_reg_equal(void)            { RUN(verifier_reg_equal); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_prevent_map_lookup.c b/tools/testing/selftests/bpf/progs/verifier_prevent_map_lookup.c
new file mode 100644
index 000000000000..8d27c780996f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_prevent_map_lookup.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/prevent_map_lookup.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} map_stacktrace SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 8);
+	__uint(key_size, sizeof(int));
+	__array(values, void (void));
+} map_prog2_socket SEC(".maps");
+
+SEC("perf_event")
+__description("prevent map lookup in stack trace")
+__failure __msg("cannot pass map_type 7 into func bpf_map_lookup_elem")
+__naked void map_lookup_in_stack_trace(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_stacktrace] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_stacktrace)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("prevent map lookup in prog array")
+__failure __msg("cannot pass map_type 3 into func bpf_map_lookup_elem")
+__failure_unpriv
+__naked void map_lookup_in_prog_array(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_prog2_socket] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_prog2_socket)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/prevent_map_lookup.c b/tools/testing/selftests/bpf/verifier/prevent_map_lookup.c
deleted file mode 100644
index fc4e301260f6..000000000000
--- a/tools/testing/selftests/bpf/verifier/prevent_map_lookup.c
+++ /dev/null
@@ -1,29 +0,0 @@
-{
-	"prevent map lookup in stack trace",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_stacktrace = { 3 },
-	.result = REJECT,
-	.errstr = "cannot pass map_type 7 into func bpf_map_lookup_elem",
-	.prog_type = BPF_PROG_TYPE_PERF_EVENT,
-},
-{
-	"prevent map lookup in prog array",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_prog2 = { 3 },
-	.result = REJECT,
-	.errstr = "cannot pass map_type 3 into func bpf_map_lookup_elem",
-},
-- 
2.40.0

