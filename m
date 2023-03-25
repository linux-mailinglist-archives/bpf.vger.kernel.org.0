Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB426C8A85
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjCYC5J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjCYC5H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:57:07 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A551B553
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:51 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so1969983wms.2
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679713011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7yoItjqYOx8kekG1sl4Nms91Z9RZE4//u0J5EYlnJA=;
        b=Ixm37EX+oj8iUfdpPA/ImTyfSHoZnxN2v6Dg0YzleY9ovhh470fiu3j0B2LZa3HqF2
         w9gaXYf4s2Vj7b8bG+9NHwMkLzj056SorobJImdMeK5xEJ2hrfZ5vQTXTTjZjeEkAkHV
         SUEwYO9T6O87vu+NP0lbYK9MSseQLDQXOjK4SnqifeO9M5f7LxqyMWhIHZmrNx0L5FMZ
         Rh8fLuTySxDmpjoJWI3XY0EEtFh/mmgMIlUcvCf/aJ+Qsfp+yKB5SIJ8EmH/n3wkvYhF
         RErWR5tJVVCqPQiOVZAGrlRpw2nJk+k+2oaGZ6IpUqKu8kE1xVIrGxZRHx49QbwSsp2X
         WHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679713011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7yoItjqYOx8kekG1sl4Nms91Z9RZE4//u0J5EYlnJA=;
        b=jPX6mnePcdUNBxeJv9e/NnD1Dk+iOoTiRboIUbjLaKCf6GcrWego7JpMbRs2TUNH27
         kGEsEWXw2ELpkHY+VuyyuBix2eh7IR/q2ra+hL3KKhiSE31fEvCn6OwSfaWGbXLfQAwP
         NfzKgbJBWLs8Hq2PeniQ9bSqnYYzhU0++w54RUOZ3LOfk8EZzucLr79WBIGInNu8BFne
         ErpuSNKEFzO9SEzRLLf319OHYrptaqNplTxssoHVKmGrL9ZxuhvWKGqhMVVLKm2QPkhx
         uvP9ULopar8rDT4nAdp14+PrhSFDSXBA00bjnF95TdEv831maVOqsBZn5QEYrJq7hNbp
         s16w==
X-Gm-Message-State: AO0yUKWGNCHeXOdEdGyETRiArMZLT7pFV5pDfoxCp0lU9xQNVOsVJbd/
        xknCoW6hxM0B7DKil3VLFWxP3mce4VY=
X-Google-Smtp-Source: AK7set/RtxDgz8yrpYOA9BA3xgaygBhEmRRolERtGG7ZdKYe+34d67ZGwushDR6IhpF3PKSGj1yOgQ==
X-Received: by 2002:a1c:770c:0:b0:3ed:454d:36ab with SMTP id t12-20020a1c770c000000b003ed454d36abmr3878074wmi.16.1679713010905;
        Fri, 24 Mar 2023 19:56:50 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:50 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 42/43] selftests/bpf: verifier/xdp.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:23 +0200
Message-Id: <20230325025524.144043-43-eddyz87@gmail.com>
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

Test verifier/xdp.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../selftests/bpf/progs/verifier_xdp.c        | 24 +++++++++++++++++++
 tools/testing/selftests/bpf/verifier/xdp.c    | 14 -----------
 3 files changed, 26 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_xdp.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/xdp.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index cd56fe520145..a774d5b193f1 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -39,6 +39,7 @@
 #include "verifier_value_or_null.skel.h"
 #include "verifier_var_off.skel.h"
 #include "verifier_xadd.skel.h"
+#include "verifier_xdp.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -100,3 +101,4 @@ void test_verifier_value(void)                { RUN(verifier_value); }
 void test_verifier_value_or_null(void)        { RUN(verifier_value_or_null); }
 void test_verifier_var_off(void)              { RUN(verifier_var_off); }
 void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
+void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_xdp.c b/tools/testing/selftests/bpf/progs/verifier_xdp.c
new file mode 100644
index 000000000000..50768ed179b3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_xdp.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/xdp.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("xdp")
+__description("XDP, using ifindex from netdev")
+__success __retval(1)
+__naked void xdp_using_ifindex_from_netdev(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	r2 = *(u32*)(r1 + %[xdp_md_ingress_ifindex]);	\
+	if r2 < 1 goto l0_%=;				\
+	r0 = 1;						\
+l0_%=:	exit;						\
+"	:
+	: __imm_const(xdp_md_ingress_ifindex, offsetof(struct xdp_md, ingress_ifindex))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/xdp.c b/tools/testing/selftests/bpf/verifier/xdp.c
deleted file mode 100644
index 5ac390508139..000000000000
--- a/tools/testing/selftests/bpf/verifier/xdp.c
+++ /dev/null
@@ -1,14 +0,0 @@
-{
-	"XDP, using ifindex from netdev",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct xdp_md, ingress_ifindex)),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_2, 1, 1),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_XDP,
-	.retval = 1,
-},
-- 
2.40.0

