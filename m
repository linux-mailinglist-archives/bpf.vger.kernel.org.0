Return-Path: <bpf+bounces-1450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA28F716AEA
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 19:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E9D2811FC
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 17:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D252A23C6E;
	Tue, 30 May 2023 17:28:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E28200C0
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 17:28:25 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5C4189
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 10:27:57 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4effb818c37so5245649e87.3
        for <bpf@vger.kernel.org>; Tue, 30 May 2023 10:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685467674; x=1688059674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9PKakjUPj0VMT0tQBxCfsvh70MN07+QftYbg6wUJhA=;
        b=ox7KTiJ0X3rT1V464RG4caYopLvKUZILotFcnNXw0GNPOvBaPGJHGh+aYUypLY6zUh
         uoF1oo8jFb0tyqFJU4cX5CG34agD0b6bGbvKVqdWKHNecml0ORNcUqYzdo1pNRzVvRIF
         shHAvoSr+xRxD8gvZw9TEr9EAhn1edrjYPTrFESq1ClvpB78fzNtjZWyyDsLtBj9mAlf
         jr+x+RmwRo5CcOb2MqUrloJIDjqCVfCNQ4d24eDf0f9HGXf3NNrm6lCReRUsAN8ystmx
         Y8LTANVKH6HeBoI1FYJcewfT5je585sPc0X5AbELD8S67Th4ovOI5yadDtkWAVLpPTVs
         SHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685467674; x=1688059674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9PKakjUPj0VMT0tQBxCfsvh70MN07+QftYbg6wUJhA=;
        b=YGSn/pIn1UVu8eFelrwDi/YtmbxFXP2TxhnCNkRZyp0urAHqVasSKs4If7rqmVyrKw
         v+/hT7nefwthmswOscYkZJZ/+vL0OJQWGgSbSYQTXaRoc+g8vB9w8LD0cIl0GPI0exTH
         xSSEk5dPKY/G0LrljFhWix2Gi6bXuHi0QI/54ggvD3mgnarXYy8qHOzrojgYR2TedLaY
         y1CJqEvL/25LO4JriA2DAjR07TP3u/MEdKapP3EYSKeuZejl/ThBas7Kv4thynoBKrv5
         3XPl81CdmPX6npbzxYjDLSoTl3JMwb4Q4xXsKxfeqYF1FQHHPQaXDRDdzsbZ9pYyRdN4
         rDzA==
X-Gm-Message-State: AC+VfDx/cu5AUsAJzlE+2PHXv1Tyzrj8uUVBfnNu8OnjckMUfk34f0Og
	xU8SXEZldblHS/0Ms6MxRmwSwHPxvxjsJg==
X-Google-Smtp-Source: ACHHUZ7/ip6XrF/ocypbSgY6mtte6j0kVcE3WozitleA+IknaKk6f0awiKmL0Wz1FYBSYXdLKwO65Q==
X-Received: by 2002:ac2:4435:0:b0:4f4:b0d0:63fb with SMTP id w21-20020ac24435000000b004f4b0d063fbmr1075820lfl.35.1685467674627;
        Tue, 30 May 2023 10:27:54 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a1-20020a056512020100b004f262997496sm405985lfo.76.2023.05.30.10.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 10:27:54 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: verify that check_ids() is used for scalars in regsafe()
Date: Tue, 30 May 2023 20:27:37 +0300
Message-Id: <20230530172739.447290-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530172739.447290-1-eddyz87@gmail.com>
References: <20230530172739.447290-1-eddyz87@gmail.com>
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
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_scalar_ids.c | 108 ++++++++++++++++++
 2 files changed, 110 insertions(+)
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
index 000000000000..0ea9a1f6e1ae
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -0,0 +1,108 @@
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
+/* Similar to a previous one, but shows that bpf_reg_state::precise
+ * could not be used to filter out registers subject to check_ids() in
+ * verifier.c:regsafe(). At 'l0' register 'r6' does not have 'precise'
+ * flag set but it is important to have this register in the idmap.
+ */
+SEC("socket")
+__failure __msg("register with unbounded min value")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void ids_id_mapping_in_regsafe_2(void)
+{
+	asm volatile (
+	/* Bump allocated stack */
+	"r1 = 0;"
+	"*(u64*)(r10 - 8) = r1;"
+	/* r9 = pointer to stack */
+	"r9 = r10;"
+	"r9 += -8;"
+	/* r8 = ktime_get_ns() */
+	"call %[bpf_ktime_get_ns];"
+	"r8 = r0;"
+	/* r7 = ktime_get_ns() */
+	"call %[bpf_ktime_get_ns];"
+	"r7 = r0;"
+	/* r6 = ktime_get_ns() */
+	"call %[bpf_ktime_get_ns];"
+	"r6 = r0;"
+	/* scratch .id from r0 */
+	"r0 = 0;"
+	/* if r6 > r7 is an unpredictable jump */
+	"if r6 > r7 goto l1_%=;"
+	/* tie r6 and r7 .id */
+	"r6 = r7;"
+"l0_%=:"
+	/* if r7 > 4 exit(0) */
+	"if r7 > 4 goto l2_%=;"
+	/* Access memory at r9[r7] */
+	"r9 += r6;"
+	"r0 = *(u8*)(r9 + 0);"
+"l2_%=:"
+	"r0 = 0;"
+	"exit;"
+"l1_%=:"
+	/* tie r6 and r8 .id */
+	"r6 = r8;"
+	"goto l0_%=;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.40.1


