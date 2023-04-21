Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C484D6EB0E3
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjDURnb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjDURnQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:16 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A027C10DA
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:03 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f1957e80a2so18119085e9.1
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098982; x=1684690982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kgxF1UKrycTdLytpfs5pIYh7OKcvU+Rjp0qYx3dSYw=;
        b=dtL8di2C4bNzL7SAc5EZfsGZw6IxuNG8msmp5WLi+VXqt88g6YmTprUbo5vaurmHUe
         VZIxXjvF7NDEwpjavsCWj9DJXgdzOwny63jqASIPBcKDu+5d/mVtUsdAMpXVqUw+zaBL
         d4L77MmfKDRJ4MB2Mep4qk71LTLNly1JX4XHSLzMZ7UaPoY7PHPoegabSyu7ut9L8aYQ
         XjpuQEZTKqMpO6GjwJiQI82blkZp1DN3RYw9t3wpjafLmR5gl8EZGqqq6mfdoslPgvCq
         4Hz0Z5yeEFzOfsVhqSsLWUcKIvsV9v+iiT40akT89/ukt8ITzIeyKx+op9Y2ws9QeOfr
         +I4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098982; x=1684690982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kgxF1UKrycTdLytpfs5pIYh7OKcvU+Rjp0qYx3dSYw=;
        b=P1dSINOQCts1q46/hKurtj+rofauHx/da0XlUncLi7KpflVdL8YSb2P9s/ZqBm2QpN
         +q53TxMPqop4RZYG5MhCC4+huOLwAZ/BHne2B2bO/kU2F67g5fGzNVItrrnwLvDHB+OH
         CM0XDDCoG9s9HeEbadu5eMmX7bJZLYzw8ITJdP43Bjx1hycbvpIsLF7cfOH6hSB62yLq
         154Z27M8yjyOygwlv0+ztWcOXT4P1dCEnfo50zam/NRkosi7el38UsO1ax7kZh4PuJgw
         X4O3CGPHdVBNVe9nhDKT47ypuh4tdFjZacp3950fdNalkTjfiq1iWcULKaYcTDuzxTqz
         akvw==
X-Gm-Message-State: AAQBX9cVa2JzAyWG/Z1oE7lvXzc1brdQAhjOcMOw94o0Xq/BrVfIrjvB
        GhujYGc38nWvKy4G06Prnkz6m90A5mqzJw==
X-Google-Smtp-Source: AKy350ZFYkg74SvFzkaTnJSWTSM4OZmjfh7+wquyCTKiYTMMcc40IO4Z53ViD35aZNI1L/UO7pniHA==
X-Received: by 2002:adf:e912:0:b0:2f6:aa71:d5b0 with SMTP id f18-20020adfe912000000b002f6aa71d5b0mr8091627wrm.15.1682098981831;
        Fri, 21 Apr 2023 10:43:01 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:43:01 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 14/24] selftests/bpf: verifier/prevent_map_lookup converted to inline assembly
Date:   Fri, 21 Apr 2023 20:42:24 +0300
Message-Id: <20230421174234.2391278-15-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421174234.2391278-1-eddyz87@gmail.com>
References: <20230421174234.2391278-1-eddyz87@gmail.com>
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

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_prevent_map_lookup.c   | 65 +++++++++++++++++++
 .../bpf/verifier/prevent_map_lookup.c         | 29 ---------
 3 files changed, 67 insertions(+), 29 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_prevent_map_lookup.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/prevent_map_lookup.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index d5ec9054c025..7627893dd849 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -41,6 +41,7 @@
 #include "verifier_masking.skel.h"
 #include "verifier_meta_access.skel.h"
 #include "verifier_precise.skel.h"
+#include "verifier_prevent_map_lookup.skel.h"
 #include "verifier_raw_stack.skel.h"
 #include "verifier_raw_tp_writable.skel.h"
 #include "verifier_reg_equal.skel.h"
@@ -127,6 +128,7 @@ void test_verifier_map_ret_val(void)          { RUN(verifier_map_ret_val); }
 void test_verifier_masking(void)              { RUN(verifier_masking); }
 void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
 void test_verifier_precise(void)              { RUN(verifier_precise); }
+void test_verifier_prevent_map_lookup(void)   { RUN(verifier_prevent_map_lookup); }
 void test_verifier_raw_stack(void)            { RUN(verifier_raw_stack); }
 void test_verifier_raw_tp_writable(void)      { RUN(verifier_raw_tp_writable); }
 void test_verifier_reg_equal(void)            { RUN(verifier_reg_equal); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_prevent_map_lookup.c b/tools/testing/selftests/bpf/progs/verifier_prevent_map_lookup.c
new file mode 100644
index 000000000000..e85f5b0d60d7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_prevent_map_lookup.c
@@ -0,0 +1,65 @@
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
+void dummy_prog_42_socket(void);
+void dummy_prog_24_socket(void);
+void dummy_prog_loop2_socket(void);
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

