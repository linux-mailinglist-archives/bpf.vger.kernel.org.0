Return-Path: <bpf+bounces-1334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FEB712CAF
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 20:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F812819C7
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 18:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5789E28C22;
	Fri, 26 May 2023 18:42:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3168618B0D
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 18:42:19 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1658E4A
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 11:41:52 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2af1e290921so10472661fa.3
        for <bpf@vger.kernel.org>; Fri, 26 May 2023 11:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685126500; x=1687718500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XivNM9zFbiTSzZT8cp+iPiEmsRKTyl7mrvgg13pkMuM=;
        b=lDUhghWH0+41WZdL5doj/UNG78Y6aMVswBS3lwGL6UZNvJGw/k4Mg5RFDkWKDuLepV
         DX0Dgs5mnBowsF1h4Uj/Urk8Dap+u0jWVoXeUZgItjGwmHqbjtOXvz+OvaqWM6N6y9/p
         qfWMSEvx0jOPV1jHPScTtKyZn0XhjnTRw0uPWodKtsetRL0fzr3E5vf5tC/u0dMOa5l7
         GbPxxGbI1TF1GcRxzx/TpEau6rJPBKnfH0hu+BXGi4WjslPW1vvpbuTSQ6B0DYUr6nHe
         4sATepEdDuNGtbLA0xLagOmDAlnZtz7ak49kof9fXfzH32RazI/v88mzQb2pElj6a4Ts
         5TMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126500; x=1687718500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XivNM9zFbiTSzZT8cp+iPiEmsRKTyl7mrvgg13pkMuM=;
        b=Sp7QmZ9Vo2Xwh1BCPUajumP2V1t9JDspouFFSkLkhVcsfr+Ljc+OvBSix5LYOrhogp
         0K/ecfrKeO//7nFRlqT3SPyeAMb4d4zQEXYd8/9MH4TXUe+eVbbL1fYdnufrpvx7HeJU
         ulGDYh9n0Zrw6DeLaPyZDOqucY4fJhm+zSRRnZAkhCSm1DMpLx9rmvV+6WXett8IJgKG
         xaG0q0SEEYmPqxrVPdpsSY/v3r9oeYSsfnIoql9Pa8Xn8zZqogKxOrXog2BZfWL2trIM
         HBNZ1SpHJmw2b321aI0NRCoSPzIXOxC/RUM1n9htBIgJEk9WdcR24/pwlBEbN0b497F1
         9vtA==
X-Gm-Message-State: AC+VfDxhIWQaH7aHtWu9VDrcWYvqLQAPI16rahE/yLeu2NG1aZs6A/5P
	FnKd9Jv3KnG+EMWnlSyS2nKCuNG0S4ZAuA==
X-Google-Smtp-Source: ACHHUZ5/ax6zRHLUhfJowbo3sQT1OS1uWc3xd7KgyCc+AecfiQWHxR96BRvXpnHWlYWZ2P6B/nJSkA==
X-Received: by 2002:a2e:9c93:0:b0:2af:1db6:8f13 with SMTP id x19-20020a2e9c93000000b002af1db68f13mr905662lji.34.1685126499773;
        Fri, 26 May 2023 11:41:39 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id x7-20020ac25dc7000000b004f155762085sm735767lfq.122.2023.05.26.11.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 11:41:39 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: verify that check_ids() is used for scalars in regsafe()
Date: Fri, 26 May 2023 21:41:26 +0300
Message-Id: <20230526184126.3104040-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526184126.3104040-1-eddyz87@gmail.com>
References: <20230526184126.3104040-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Verify that the following example is rejected by verifier:

r9 = ... some pointer with range X ...
r6 = ... unbound scalar ID=a ...
r7 = ... unbound scalar ID=b ...
if (r6 > r7) goto +1
r6 = r7
if (r6 > X) goto exit
r9 += r7
*(u64 *)r9 = Y

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_scalar_ids.c | 59 +++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_scalar_ids.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 531621adef42..070a13833c3f 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -50,6 +50,7 @@
 #include "verifier_regalloc.skel.h"
 #include "verifier_ringbuf.skel.h"
 #include "verifier_runtime_jit.skel.h"
+#include "verifier_scalar_ids.skel.h"
 #include "verifier_search_pruning.skel.h"
 #include "verifier_sock.skel.h"
 #include "verifier_spill_fill.skel.h"
@@ -150,6 +151,7 @@ void test_verifier_ref_tracking(void)         { RUN(verifier_ref_tracking); }
 void test_verifier_regalloc(void)             { RUN(verifier_regalloc); }
 void test_verifier_ringbuf(void)              { RUN(verifier_ringbuf); }
 void test_verifier_runtime_jit(void)          { RUN(verifier_runtime_jit); }
+void test_verifier_scalar_ids(void)           { RUN(verifier_scalar_ids); }
 void test_verifier_search_pruning(void)       { RUN(verifier_search_pruning); }
 void test_verifier_sock(void)                 { RUN(verifier_sock); }
 void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
new file mode 100644
index 000000000000..c5c7cfbd98d3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/* Verify that check_ids() is used by regsafe() for scalars.
+ *
+ * r9 = ... some pointer with range X ...
+ * r6 = ... unbound scalar ID=a ...
+ * r7 = ... unbound scalar ID=b ...
+ * if (r6 > r7) goto +1
+ * r6 = r7
+ * if (r6 > X) goto exit
+ * r9 += r7
+ * *(u8 *)r9 = Y
+ *
+ * The memory access is safe only if r7 is bounded,
+ * which is true for one branch and not true for another.
+ */
+SEC("socket")
+__description("scalar ids: ID mapping in regsafe()")
+__failure __msg("register with unbounded min value")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void ids_id_mapping_in_regsafe(void)
+{
+	asm volatile (
+	/* Bump allocated stack */
+	"r1 = 0;"
+	"*(u64*)(r10 - 8) = r1;"
+	/* r9 = pointer to stack */
+	"r9 = r10;"
+	"r9 += -8;"
+	/* r7 = ktime_get_ns() */
+	"call %[bpf_ktime_get_ns];"
+	"r7 = r0;"
+	/* r6 = ktime_get_ns() */
+	"call %[bpf_ktime_get_ns];"
+	"r6 = r0;"
+	/* if r6 > r7 is an unpredictable jump */
+	"if r6 > r7 goto l1_%=;"
+	"r6 = r7;"
+"l1_%=:"
+	/* a noop to get to add new parent state */
+	"r0 = r0;"
+	/* if r6 > 4 exit(0) */
+	"if r6 > 4 goto l2_%=;"
+	/* Access memory at r9[r7] */
+	"r9 += r7;"
+	"r0 = *(u8*)(r9 + 0);"
+"l2_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.40.1


