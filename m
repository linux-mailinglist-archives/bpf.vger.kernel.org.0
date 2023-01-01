Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2423565A94D
	for <lists+bpf@lfdr.de>; Sun,  1 Jan 2023 09:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjAAIe0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 Jan 2023 03:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjAAIe0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 1 Jan 2023 03:34:26 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B016246
        for <bpf@vger.kernel.org>; Sun,  1 Jan 2023 00:34:25 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id fy4so27009412pjb.0
        for <bpf@vger.kernel.org>; Sun, 01 Jan 2023 00:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTGrPnxdHr6DphV3iGM3VdIYy8slnPP3hxiIGDfb5OI=;
        b=hDAwqMuLNjsSSzmkbi54gWpa7GZ+UTmDJ0HuBAFMFlr4OukwbnZN9rTNldKuyBk1DR
         MJv77qS38pDOBi50cgPSGHU8xUsJeLMES2r4oRPeIEfSf793Y2V6OAgZwQ6cJ4R7yPcr
         Hs/ssMLKFjzQbEnpcH5L8RQVEkqYFcyKpdqseRtmpAY0ja7Q2ZyAdS2BToOY8egQ7nsb
         IRjc9zdxpGnflmxiWBlweQkdCCUGMki2qsGy/1ECLcXnHqaxsZO9SMY9SW3L419YCB6d
         NvGtwGJtZzqykJcOXw4lSZ+Q6FGYhGjPOwcAK5I3tExLSVkz41UNIxx/0mCTk0L1IXEx
         t11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTGrPnxdHr6DphV3iGM3VdIYy8slnPP3hxiIGDfb5OI=;
        b=ikIsPwziFSoS4P/VQSOJBZtlb7EYjrfWbvv+mohX0lOXvFlGTJtMULFhPxbY/AN8Bh
         GZ+r5c+zSg3c4JLqfUoCnr9gk5/aTXA5gqP5HDyAzsej0TcsUfxgc/fVRdtzeAt8rnX1
         FXDC4Vjlq0JH2W7J3EYnQJFyiD7e2pERNstFrWZp9hcX86YVfJvImLHw1F5gJLhK1xAZ
         sWn9pXDR63UMdzvRnkY5xz6rmC1E7MlQsU4hG9CHNdOn1KmtQxoXnsvtHSrZUP3TnkgL
         F4VUhFs6mY0qYIzKpeMi1yAQtPTcVp5PXuFGsWXZYaKJ/Tir2SaS+FPBaLWZGHb1IO1v
         cU0Q==
X-Gm-Message-State: AFqh2kol8phsgaJLAxkE93SzLLIDJiCrMkrHsP3XkIPaWTQZh0igLgb2
        hND0RNkV9Kf6Y0tdp5+yuBbnHhaewrDoXTbw
X-Google-Smtp-Source: AMrXdXsLkk+R9mV7J7MPajHaZ7IkEIYMMykuUcgeJzsaHc0BDQICnStSzA4RXkXgvQrdi1L56cBYtQ==
X-Received: by 2002:a17:902:ab1a:b0:192:9924:ce7e with SMTP id ik26-20020a170902ab1a00b001929924ce7emr13609924plb.55.1672562064496;
        Sun, 01 Jan 2023 00:34:24 -0800 (PST)
Received: from localhost ([2405:201:6014:d8bc:6259:1a87:ebdd:30a7])
        by smtp.gmail.com with ESMTPSA id jn18-20020a170903051200b00189393ab02csm9419249plb.99.2023.01.01.00.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 00:34:24 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 5/8] selftests/bpf: Add dynptr pruning tests
Date:   Sun,  1 Jan 2023 14:03:59 +0530
Message-Id: <20230101083403.332783-6-memxor@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230101083403.332783-1-memxor@gmail.com>
References: <20230101083403.332783-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4765; i=memxor@gmail.com; h=from:subject; bh=EjP8Xq5SudoQovN+R6iIEKmoCGjUc8QjuO48957Psgs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjsUV0p9H75i8Qsw18by6rww8G0sbDD+WM3+IVaOjC 3C/FaHuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY7FFdAAKCRBM4MiGSL8RyphcD/ 49c+HAdgLekQWgvnP+u6oL4kJYKW3gHaxGbP+SXtzHJwan+BeCAMyP9Wxu1pN5wb8I5g3JVuFHveyy jRJj3BzWQFcPRH0w1iBZZzn6qwM9wjQdjTkBw0DX2TOmk4Nj9eankQpACa9X5GBDC3dkLk1vnsXyO2 +eYy9vEx7MMnnxpKeu0maU00xWdhiOcHH59qDyCVs4iY1FMMkbC8UzgIs68uayc4whqqNkE/5ziXBt pNLwPjhHkVzOqy2D2NtHqx8lr4U+8VRAzVU6cFL8Q0RbU/UJjIK4ye9/zkHCVvVjBFWONGN8RHICIf R9iivBfPz65bgXuDwpxT5LAT5KHdWi0ac0i+WXERYSyJVThkJ2oW6aUEhPqy6N2YTTQxSJ1/WCzwgH pJ504yEGrHUI79erTKSBJqTtWiBFbPIiQHMR6ay8U8l4GzjqfpRATie0gFjv04Wa9HWu6Fo3GlahFr OFWzCL4ZfguXq8SzpSxbHeUwQveRDDYKA388nEcV6419ppsX0MULcPFcvNRF2nf4ldIxhjbTqLQJKA pS5Cj/3tFLtggoTc1wM67C+LMwfT+BleFQTZuTbvt+Nc2YT7UXIcYI/SNEvZ5blln3MUJNY10s4+Yx cLZXtvWf64LtnecebaR1m0lpBbwCJZbv030rSntuciKVwvK0tLFYXXc2SWiw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add verifier tests that verify the new pruning behavior for STACK_DYNPTR
slots, and ensure that state equivalence takes into account changes to
the old and current verifier state correctly.

Without the prior fixes, both of these bugs trigger with unprivileged
BPF mode.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/verifier/dynptr.c | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/dynptr.c

diff --git a/tools/testing/selftests/bpf/verifier/dynptr.c b/tools/testing/selftests/bpf/verifier/dynptr.c
new file mode 100644
index 000000000000..798f4f7e0c57
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/dynptr.c
@@ -0,0 +1,90 @@
+{
+       "dynptr: rewrite dynptr slot",
+        .insns = {
+        BPF_MOV64_IMM(BPF_REG_0, 0),
+        BPF_LD_MAP_FD(BPF_REG_6, 0),
+        BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+        BPF_MOV64_IMM(BPF_REG_2, 8),
+        BPF_MOV64_IMM(BPF_REG_3, 0),
+        BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
+        BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -16),
+        BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve_dynptr),
+        BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+        BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+        BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0xeB9F),
+        BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+        BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -16),
+        BPF_MOV64_IMM(BPF_REG_2, 0),
+        BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_discard_dynptr),
+        BPF_MOV64_IMM(BPF_REG_0, 0),
+        BPF_EXIT_INSN(),
+        },
+	.fixup_map_ringbuf = { 1 },
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "unknown func bpf_ringbuf_reserve_dynptr#198",
+	.result = REJECT,
+	.errstr = "arg 1 is an unacquired reference",
+},
+{
+       "dynptr: type confusion",
+       .insns = {
+       BPF_MOV64_IMM(BPF_REG_0, 0),
+       BPF_LD_MAP_FD(BPF_REG_6, 0),
+       BPF_LD_MAP_FD(BPF_REG_7, 0),
+       BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+       BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+       BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
+       BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
+       BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -24),
+       BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0xeB9FeB9F),
+       BPF_ST_MEM(BPF_DW, BPF_REG_10, -24, 0xeB9FeB9F),
+       BPF_MOV64_IMM(BPF_REG_4, 0),
+       BPF_MOV64_REG(BPF_REG_8, BPF_REG_2),
+       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_update_elem),
+       BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+       BPF_MOV64_REG(BPF_REG_2, BPF_REG_8),
+       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+       BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+       BPF_EXIT_INSN(),
+       BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
+       BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+       BPF_MOV64_IMM(BPF_REG_2, 8),
+       BPF_MOV64_IMM(BPF_REG_3, 0),
+       BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
+       BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -16),
+       BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
+       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve_dynptr),
+       BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
+       /* pad with insns to trigger add_new_state heuristic for straight line path */
+       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
+       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
+       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
+       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
+       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
+       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
+       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
+       BPF_JMP_IMM(BPF_JA, 0, 0, 9),
+       BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+       BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0),
+       BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
+       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
+       BPF_MOV64_IMM(BPF_REG_2, 0),
+       BPF_MOV64_IMM(BPF_REG_3, 0),
+       BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
+       BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -16),
+       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_dynptr_from_mem),
+       BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -16),
+       BPF_MOV64_IMM(BPF_REG_2, 0),
+       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_discard_dynptr),
+       BPF_MOV64_IMM(BPF_REG_0, 0),
+       BPF_EXIT_INSN(),
+       },
+       .fixup_map_hash_16b = { 1 },
+       .fixup_map_ringbuf = { 3 },
+       .result_unpriv = REJECT,
+       .errstr_unpriv = "unknown func bpf_ringbuf_reserve_dynptr#198",
+       .result = REJECT,
+       .errstr = "arg 1 is an unacquired reference",
+},
-- 
2.39.0

