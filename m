Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09AC6C8A7B
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjCYC4v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjCYC4u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:50 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3661B2C7
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:39 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l15-20020a05600c4f0f00b003ed58a9a15eso1993936wmq.5
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhAh8OtflC0enwwygcDwGuqajziN6nZbzkCP+fsuF9g=;
        b=LRwp5J0Vh6eB6E4OdQd8t2bGESie4Xe4lCR93sre8mn9DWkmKZnK3ziBqK6/tCL1oR
         kt65iyrRS/U8ApCH0Q6kbGIfYgXtthG5aVtsCN30w8jvZJqs9ertTtJ8DQEQjkvenfVm
         wHuAUBYDrrMCXPK0sWlI85Ub64aQxffCM7OQyRUmMSZwYxYOAmQtwW3wH9XKCM638A9/
         cFiU8+5rnn/xEtLx1OGIzP17mZncuTn7SPhP02a8ff3B87w9GHWfirwGL5Frg8gZyOBi
         jFerDc7ATRJv7gYre5UtPdVff3YpuAk4yBRmWbTYRdFzRN0K8p00Go6593eyLal5el+L
         1Yaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhAh8OtflC0enwwygcDwGuqajziN6nZbzkCP+fsuF9g=;
        b=fdV4y5NxCNsE6vvvngMP7kI9wJG0/qjSA+icIFUK4ktQzCO0AjW8C/lh9a/K+N9Mjg
         IXvdts1ntkKh/zjgJZpiolGTgpnRDzCQA3nnbXAe8lVGQnqgcv9BRAJgOCS3LSaR3mqI
         zGro7uJQ99dbu/khU7vSnYpOTko2fA2K4IdCwW7p3ZwYMwFrjjrfRD+j4wTuzxXh9PcZ
         TGIBGBd33oeOG4gWvjZ3apkVUoVVm4ljNR40Fcpvi3MrP/C+LodNeNROcSBOHmJGYzcY
         mJ0IDnfJ9tY3mKE3f2xH/PGibYjHvYzilLQH0xS1hThb6tMVART2uAZSmx1PWnTyjCat
         Kq1w==
X-Gm-Message-State: AO0yUKVuP/bCM9MejnVcQl8k0PXDgNUcvoaaBKlytONEiq09d564Fo0x
        oRAJV6PUMz7xHGt6eJf05Hw5iC3U+GE=
X-Google-Smtp-Source: AK7set/Sl3r9q6x/IQdjoSTALuGTOLQlUUsSpjMdYbNLV7FxLw0fmi19MyvrUwS3PBO/puFH9/0YYQ==
X-Received: by 2002:a1c:f207:0:b0:3ee:d7f:6667 with SMTP id s7-20020a1cf207000000b003ee0d7f6667mr4412062wmc.31.1679712997294;
        Fri, 24 Mar 2023 19:56:37 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:36 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 32/43] selftests/bpf: verifier/raw_tp_writable.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:13 +0200
Message-Id: <20230325025524.144043-33-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230325025524.144043-1-eddyz87@gmail.com>
References: <20230325025524.144043-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test verifier/raw_tp_writable.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_raw_tp_writable.c      | 50 +++++++++++++++++++
 .../selftests/bpf/verifier/raw_tp_writable.c  | 35 -------------
 3 files changed, 52 insertions(+), 35 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_raw_tp_writable.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/raw_tp_writable.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 4a73cac3f9ba..f7488904f26e 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -29,6 +29,7 @@
 #include "verifier_masking.skel.h"
 #include "verifier_meta_access.skel.h"
 #include "verifier_raw_stack.skel.h"
+#include "verifier_raw_tp_writable.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -80,3 +81,4 @@ void test_verifier_map_ret_val(void)          { RUN(verifier_map_ret_val); }
 void test_verifier_masking(void)              { RUN(verifier_masking); }
 void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
 void test_verifier_raw_stack(void)            { RUN(verifier_raw_stack); }
+void test_verifier_raw_tp_writable(void)      { RUN(verifier_raw_tp_writable); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_raw_tp_writable.c b/tools/testing/selftests/bpf/progs/verifier_raw_tp_writable.c
new file mode 100644
index 000000000000..14a0172e2141
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_raw_tp_writable.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/raw_tp_writable.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, long long);
+} map_hash_8b SEC(".maps");
+
+SEC("raw_tracepoint.w")
+__description("raw_tracepoint_writable: reject variable offset")
+__failure
+__msg("R6 invalid variable buffer offset: off=0, var_off=(0x0; 0xffffffff)")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void tracepoint_writable_reject_variable_offset(void)
+{
+	asm volatile ("					\
+	/* r6 is our tp buffer */			\
+	r6 = *(u64*)(r1 + 0);				\
+	r1 = %[map_hash_8b] ll;				\
+	/* move the key (== 0) to r10-8 */		\
+	w0 = 0;						\
+	r2 = r10;					\
+	r2 += -8;					\
+	*(u64*)(r2 + 0) = r0;				\
+	/* lookup in the map */				\
+	call %[bpf_map_lookup_elem];			\
+	/* exit clean if null */			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	/* shift the buffer pointer to a variable location */\
+	r0 = *(u32*)(r0 + 0);				\
+	r6 += r0;					\
+	/* clobber whatever's there */			\
+	r7 = 4242;					\
+	*(u64*)(r6 + 0) = r7;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/raw_tp_writable.c b/tools/testing/selftests/bpf/verifier/raw_tp_writable.c
deleted file mode 100644
index 2978fb5a769d..000000000000
--- a/tools/testing/selftests/bpf/verifier/raw_tp_writable.c
+++ /dev/null
@@ -1,35 +0,0 @@
-{
-	"raw_tracepoint_writable: reject variable offset",
-	.insns = {
-		/* r6 is our tp buffer */
-		BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
-
-		BPF_LD_MAP_FD(BPF_REG_1, 0),
-		/* move the key (== 0) to r10-8 */
-		BPF_MOV32_IMM(BPF_REG_0, 0),
-		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-		BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 0),
-		/* lookup in the map */
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-			     BPF_FUNC_map_lookup_elem),
-
-		/* exit clean if null */
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-		BPF_EXIT_INSN(),
-
-		/* shift the buffer pointer to a variable location */
-		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0),
-		BPF_ALU64_REG(BPF_ADD, BPF_REG_6, BPF_REG_0),
-		/* clobber whatever's there */
-		BPF_MOV64_IMM(BPF_REG_7, 4242),
-		BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_7, 0),
-
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 1, },
-	.prog_type = BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
-	.errstr = "R6 invalid variable buffer offset: off=0, var_off=(0x0; 0xffffffff)",
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-- 
2.40.0

