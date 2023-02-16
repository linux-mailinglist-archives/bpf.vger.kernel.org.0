Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8FB699C63
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 19:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBPSg2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 13:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjBPSg1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 13:36:27 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C5F4B50C
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 10:36:23 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id dz21so6283870edb.13
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 10:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2eUn6kH9Ue6WSO1X4oIjaKzA1FvsQW4uMTZXal8grs=;
        b=FRe1iRa2TIdtMdRDoz91Q84nezlZtittlaesBPQ5zbBECmudvaec+YfTXhCTDW9pZL
         49mH/MmPjZVrRDfO9pUYFZ0W7j1BWlPGeAqhbJbtwXp4RCUz8G4m3UlWS698Cz0R5kE/
         8LKpluq01rQ1Ds37z0+4J1VdRW24RmT2DSMCvzpvEd6TCjLlRcGYmdJZKsSjj4BxgXzL
         hbE0fH7dOT12qDIkFBrxKNEBKj0WF6H3e7i0pG/nHmA4+/caGsngZnBMhcklrm1akVpL
         +AkRvifKYVCJNE6xcP9MCIH2RAaY2cqRD6cIElt302K30psKffz9/8aEJq8rReccqtS5
         hD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2eUn6kH9Ue6WSO1X4oIjaKzA1FvsQW4uMTZXal8grs=;
        b=Fduq0YVlbPy+c0cVsiI1enDxy9BJyWkRRdG/2hV9ogdcIVHJdJMJzQtltWxpbvZIOK
         VVktj3k2XNA5wY3hi2J8fXpuLTrJ62WZ9MPhDRKBJRtYCHLxTJWJpfBILBCXQlwPXp1h
         MlHocmlrSbZkdsY1n4cvjvnTGjFLjlQrMJmfAp9AVq3XfWiI6QCX5nP7rq2dMDJCfdB8
         HjnGKGOv/PCljSD9zIbM50aurGJ4Douk1UZ+gpKIIuuJQvn/sBFG4Y0r/DN0Kfu0I6Oy
         aP9KUXaVELhQoG69aCfScXDB4W1cK1fzF2pWysENbnQVJW1lBP2mbdD11/brS4VExl2z
         OKMw==
X-Gm-Message-State: AO0yUKWg3nscr+t25gqc07gnGKEPtgWeWg+DVzB8OxsWps/BLfVcpCg1
        lz6CMDji+g886GTBs8DZM90Oxq8g7IY=
X-Google-Smtp-Source: AK7set+PXhdPxnERvHmKWUit0Q90yVvBMmLKLj+1Nkyf2B/swHniJcWP8DYbAX3O/PHUTUEaFYiocw==
X-Received: by 2002:a05:6402:5484:b0:4aa:b228:eb72 with SMTP id fg4-20020a056402548400b004aab228eb72mr2827853edb.17.1676572581951;
        Thu, 16 Feb 2023 10:36:21 -0800 (PST)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v28-20020a50d09c000000b004accc54a9edsm1237854edd.93.2023.02.16.10.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:36:21 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next  2/2] selftests/bpf: Tests for uninitialized stack reads
Date:   Thu, 16 Feb 2023 20:36:06 +0200
Message-Id: <20230216183606.2483834-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216183606.2483834-1-eddyz87@gmail.com>
References: <20230216183606.2483834-1-eddyz87@gmail.com>
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

Two testcases to make sure that stack reads from uninitialized
locations are accepted by verifier when executed in privileged mode:
- read from a fixed offset;
- read from a variable offset.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/uninit_stack.c   |  9 +++
 .../selftests/bpf/progs/uninit_stack.c        | 55 +++++++++++++++++++
 2 files changed, 64 insertions(+)
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
index 000000000000..20ff6a22c906
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uninit_stack.c
@@ -0,0 +1,55 @@
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
+	asm volatile ("				\
+		// force stack depth to be 128	\
+		*(u64*)(r10 - 128) = r1;	\
+		r1 = *(u8 *)(r10 - 8 );		\
+		r1 = *(u8 *)(r10 - 11);		\
+		r1 = *(u8 *)(r10 - 13);		\
+		r1 = *(u8 *)(r10 - 15);		\
+		r1 = *(u16*)(r10 - 16);		\
+		r1 = *(u32*)(r10 - 32);		\
+		r1 = *(u64*)(r10 - 64);		\
+		// read from a spill of a wrong size, it is a separate	\
+		// branch in check_stack_read_fixed_off()		\
+		*(u32*)(r10 - 72) = r1;		\
+		r1 = *(u64*)(r10 - 72);		\
+		r0 = 0;				\
+		exit;				\
+"
+		      ::: __clobber_all);
+}
+
+/* Read an uninitialized value from stack at a variable offset */
+SEC("socket")
+__naked int read_uninit_stack_var_off(void *ctx)
+{
+	asm volatile ("				\
+		call %[bpf_get_prandom_u32];	\
+		// force stack depth to be 64	\
+		*(u64*)(r10 - 64) = r0;		\
+		r0 = -r0;			\
+		// give r0 a range [-31, -1]	\
+		if r0 s<= -32 goto exit_%=;	\
+		if r0 s>= 0 goto exit_%=;	\
+		// access stack using r0	\
+		r1 = r10;			\
+		r1 += r0;			\
+		r2 = *(u8*)(r1 + 0);		\
+exit_%=:	r0 = 0;				\
+		exit;				\
+"
+		      :
+		      : __imm(bpf_get_prandom_u32)
+		      : __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.39.1

