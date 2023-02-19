Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BF869C235
	for <lists+bpf@lfdr.de>; Sun, 19 Feb 2023 21:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjBSUEo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Feb 2023 15:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjBSUEn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Feb 2023 15:04:43 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3FE17145
        for <bpf@vger.kernel.org>; Sun, 19 Feb 2023 12:04:42 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id c65so4336272edf.11
        for <bpf@vger.kernel.org>; Sun, 19 Feb 2023 12:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7vxo5V1Om890NM4M2UgjU8KSaAc8BesRA9p+luZzos=;
        b=h+Pops/uZxslfa5NN/GfwMTSSJDp7YCkqq59mGudZ+b51XzzQAxSMfumi+rozIyKyl
         pt9yRgdmTzRJ1ijBe1cwMDTZzHTGw9Zq3V7X1r6pVyGeAumymKvD33WhSNuy+ZJMkCWb
         W1ICgqc0bdUNiZMkPBrXxsbD+eekO1Wk98Upwn9d1pT1YtVxed3ioc8XtbS9ZjHrTiBX
         I9SUQOxg9dLwW6yXy0cVIqi8fVmKiY7+aJtU4E1uAjKCnxZ3nwL9p4PvuRp7fMKYnG3k
         rz8iHLf3E1b4Ysj0FVzd8bc4Ukm9HFvkV3EGlX2VgAySCy4PsUNtD9NnkU7yZK7fVSl6
         pssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7vxo5V1Om890NM4M2UgjU8KSaAc8BesRA9p+luZzos=;
        b=CMTfsHtSv3T9vTTRWz5Z0Zen/mDCLQJ+OMhhzq5Ek6x3nq2aNWngEWsfIaUgJon/V5
         Lua92kYEO2GhMnIMRUZBDKvxxBWW9XmF8zF2Piw+mwdSuhAf7AWTtcFkGLYu3kyWsKTS
         qE5lmqhCNpByI+0wrbmoCCPh1N04WLIn2KEWHvgRTfeK+za/qtMX7WsMN1jAG1J48SlB
         B/2QrJXzAlfSOtBRGR715kW9xedVrqDFfBLm5t1YBiHOnWc/8J5DdQfMxgleVP2voUr2
         7ugsPSaaEvqdCwQuTK9N5zmngtmfFtX0SmIj0sO2OmkPLXYBZadHUgR5C//SHdhfBaPT
         PFmQ==
X-Gm-Message-State: AO0yUKWMo0bVkrqAyo/xXTmLkviIQolOJyfTIbp8oWQeLzmhNwjyNm7n
        XHVYRlzylUVZjkYrkpf7PTh9LNZDucJf8Q==
X-Google-Smtp-Source: AK7set+8mnx5SqviNMchM+GdAjFwEjz0FOdYMuJGnyVUoRAdBVTs250TxyqmNAo7jEQKOGmq/B2IxQ==
X-Received: by 2002:a17:906:f88d:b0:8b2:e81:df2b with SMTP id lg13-20020a170906f88d00b008b20e81df2bmr9785958ejb.44.1676837080411;
        Sun, 19 Feb 2023 12:04:40 -0800 (PST)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090629cf00b008caaae1f1e1sm1124035eje.110.2023.02.19.12.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 12:04:40 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Tests for uninitialized stack reads
Date:   Sun, 19 Feb 2023 22:04:27 +0200
Message-Id: <20230219200427.606541-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230219200427.606541-1-eddyz87@gmail.com>
References: <20230219200427.606541-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Three testcases to make sure that stack reads from uninitialized
locations are accepted by verifier when executed in privileged mode:
- read from a fixed offset;
- read from a variable offset;
- passing a pointer to stack to a helper converts
  STACK_INVALID to STACK_MISC.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/uninit_stack.c   |  9 ++
 .../selftests/bpf/progs/uninit_stack.c        | 87 +++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uninit_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/uninit_stack.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uninit_stack.c b/tools/testing/selftests/bpf/prog_tests/uninit_stack.c
new file mode 100644
index 000000000000..e64c71948491
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/uninit_stack.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "uninit_stack.skel.h"
+
+void test_uninit_stack(void)
+{
+	RUN_TESTS(uninit_stack);
+}
diff --git a/tools/testing/selftests/bpf/progs/uninit_stack.c b/tools/testing/selftests/bpf/progs/uninit_stack.c
new file mode 100644
index 000000000000..8a403470e557
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uninit_stack.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/* Read an uninitialized value from stack at a fixed offset */
+SEC("socket")
+__naked int read_uninit_stack_fixed_off(void *ctx)
+{
+	asm volatile ("					\
+		r0 = 0;					\
+		/* force stack depth to be 128 */	\
+		*(u64*)(r10 - 128) = r1;		\
+		r1 = *(u8 *)(r10 - 8 );			\
+		r0 += r1;				\
+		r1 = *(u8 *)(r10 - 11);			\
+		r1 = *(u8 *)(r10 - 13);			\
+		r1 = *(u8 *)(r10 - 15);			\
+		r1 = *(u16*)(r10 - 16);			\
+		r1 = *(u32*)(r10 - 32);			\
+		r1 = *(u64*)(r10 - 64);			\
+		/* read from a spill of a wrong size, it is a separate	\
+		 * branch in check_stack_read_fixed_off()		\
+		 */					\
+		*(u32*)(r10 - 72) = r1;			\
+		r1 = *(u64*)(r10 - 72);			\
+		r0 = 0;					\
+		exit;					\
+"
+		      ::: __clobber_all);
+}
+
+/* Read an uninitialized value from stack at a variable offset */
+SEC("socket")
+__naked int read_uninit_stack_var_off(void *ctx)
+{
+	asm volatile ("					\
+		call %[bpf_get_prandom_u32];		\
+		/* force stack depth to be 64 */	\
+		*(u64*)(r10 - 64) = r0;			\
+		r0 = -r0;				\
+		/* give r0 a range [-31, -1] */		\
+		if r0 s<= -32 goto exit_%=;		\
+		if r0 s>= 0 goto exit_%=;		\
+		/* access stack using r0 */		\
+		r1 = r10;				\
+		r1 += r0;				\
+		r2 = *(u8*)(r1 + 0);			\
+exit_%=:	r0 = 0;					\
+		exit;					\
+"
+		      :
+		      : __imm(bpf_get_prandom_u32)
+		      : __clobber_all);
+}
+
+static __noinline void dummy(void) {}
+
+/* Pass a pointer to uninitialized stack memory to a helper.
+ * Passed memory block should be marked as STACK_MISC after helper call.
+ */
+SEC("socket")
+__log_level(7) __msg("fp-104=mmmmmmmm")
+__naked int helper_uninit_to_misc(void *ctx)
+{
+	asm volatile ("					\
+		/* force stack depth to be 128 */	\
+		*(u64*)(r10 - 128) = r1;		\
+		r1 = r10;				\
+		r1 += -128;				\
+		r2 = 32;				\
+		call %[bpf_trace_printk];		\
+		/* Call to dummy() forces print_verifier_state(..., true),	\
+		 * thus showing the stack state, matched by __msg().		\
+		 */					\
+		call %[dummy];				\
+		r0 = 0;					\
+		exit;					\
+"
+		      :
+		      : __imm(bpf_trace_printk),
+			__imm(dummy)
+		      : __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.39.1

