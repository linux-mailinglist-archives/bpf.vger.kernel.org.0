Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4624E65A5B9
	for <lists+bpf@lfdr.de>; Sat, 31 Dec 2022 17:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbiLaQcJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 31 Dec 2022 11:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiLaQcB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 31 Dec 2022 11:32:01 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB03D6250
        for <bpf@vger.kernel.org>; Sat, 31 Dec 2022 08:31:59 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id f34so35821321lfv.10
        for <bpf@vger.kernel.org>; Sat, 31 Dec 2022 08:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjfZDoCIaCb9tlRZT32PD+m4pEEknnQcrJySKukIU3E=;
        b=KPoX8RrK1Lll26ZBUa2/V7ZrEgIVxKCJJpGBlagY3eRnzctL6sIfjLBeTXBUJKaHZG
         4SSgKQFz2XhO+aB8VjLjUVVNMp7bry1/yU8nR/w/8BSQXKoxOcE0+tiy8AobdX91Ktu4
         Bt/o4aFde7Okh+kE8OQGEaYiRfNT1yy2MVqVW8JXUISExbzVbNNMc/R/H4pfXETaofWh
         WNgF2RgV3Ir/jDqJrOXmdda2NirwvPNe98rGl2dycmSAgAxxwJXk65aYfpYJydFA6qsZ
         QGf5q9Vzdcl/tGuTE22WD3hQQKJ6K2J4ypXMs0hqC/U2RyKw2xpWgN8wGtTE9iynk8wR
         2r6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjfZDoCIaCb9tlRZT32PD+m4pEEknnQcrJySKukIU3E=;
        b=DaDQ2a4s1qSOpeL5OFkeQnPXl5qF61XMT4PK++GriBMy1k7nQP1EdyoyFSOG+0tUE1
         jcxqhMgqhxpPV9JVHmMEzE6x3rDrH/AWHczvWFheY/TLbXuH9uLOTPtc+7KaLV/qmEOG
         DZJu9/O0pQb1UX16qFYK6oD0EL+W1ioxwg3q+CpUPYTfZUOZGbwcRFWM9cQe0Fwq2o9w
         +ZASGTum1kSAgAm4Ngiyg6ZIgoJH9SmzDUWq4ouupcORp1AnSDUNaydVQcEJyuWd5UvJ
         H5PG6hYlzt0e2Gghi5QFbdu+MYKLAS515sR2xYRY+7trI78uiGFLh2bFFwxnjC4tnY/i
         jZPg==
X-Gm-Message-State: AFqh2kovJkOPlWs1Ck4REhUMe75kzSmA0AzeE1mPIOOgCn1pf32SP6NT
        gji13vx5sUfBcS9mk2U5t9ZI2Qk0QsE=
X-Google-Smtp-Source: AMrXdXv4disKwMjLs6KZE/HluBiLQDjgmlZZ4opRqKRqCpwdqphr3HzUcAdl78ZGAl9ItvCBb2LeWA==
X-Received: by 2002:ac2:5e31:0:b0:4cb:2377:b2db with SMTP id o17-20020ac25e31000000b004cb2377b2dbmr2067887lfg.14.1672504317899;
        Sat, 31 Dec 2022 08:31:57 -0800 (PST)
Received: from pluto.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c10-20020a19e34a000000b004b4930d53b5sm3876784lfk.134.2022.12.31.08.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 08:31:57 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 4/5] selftests/bpf: test if pointer type is tracked for BPF_ST_MEM
Date:   Sat, 31 Dec 2022 18:31:21 +0200
Message-Id: <20221231163122.1360813-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221231163122.1360813-1-eddyz87@gmail.com>
References: <20221231163122.1360813-1-eddyz87@gmail.com>
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

Check that verifier tracks pointer types for BPF_ST_MEM instructions
and reports error if pointer types do not match for different
execution branches.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/verifier/unpriv.c | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/unpriv.c b/tools/testing/selftests/bpf/verifier/unpriv.c
index 878ca26c3f0a..af0c0f336625 100644
--- a/tools/testing/selftests/bpf/verifier/unpriv.c
+++ b/tools/testing/selftests/bpf/verifier/unpriv.c
@@ -239,6 +239,29 @@
 	.errstr = "same insn cannot be used with different pointers",
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 },
+{
+	/* Same as above, but use BPF_ST_MEM to save 42
+	 * instead of BPF_STX_MEM.
+	 */
+	"unpriv: spill/fill of different pointers st",
+	.insns = {
+	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
+	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_2, 0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
+	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 0),
+	BPF_ST_MEM(BPF_W, BPF_REG_1, offsetof(struct __sk_buff, mark), 42),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.errstr = "same insn cannot be used with different pointers",
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+},
 {
 	"unpriv: spill/fill of different pointers stx - ctx and sock",
 	.insns = {
-- 
2.39.0

