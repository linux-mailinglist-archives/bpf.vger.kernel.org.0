Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EEC6A8C45
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 23:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjCBWzf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 17:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCBWze (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 17:55:34 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8682DE64
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 14:55:33 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m7so1289884lfj.8
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 14:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677797731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwuJQrpuQ+ZQh5urgKWxlvgnKse+UVAp5vfvlEdDc2I=;
        b=TijjzdkjknBsHKgpEuY4MqAsS/h3Tpr6EFMIQ/EfY5LN0VRtREPmilMAMG1DhupDlO
         Uq6PuWPdlgSrkoggMrCobWdVlROB8nZSx0uZWudaOXKY41+3srMbvofx+85Clpv/YSbt
         DepZQkDST1Yb2F2I3PDlKcnCxHN2tsvR22cTGJegGi8lBM2VrfbhCB1aksmLWxEFIsC7
         pJ//pIexYlZPrlw5JK6FjZ2n7h+a9/AqjRHVo9aBalQLPQAjLuUp1xIkcw+5axbkp+Sv
         Z/oql+u5A8VHoD0W6anCxxXe7KJ5sshjeuknEfjw2Ta+cHj+QW9K1n5qmJ8xIgZdMSpP
         /AhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677797731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwuJQrpuQ+ZQh5urgKWxlvgnKse+UVAp5vfvlEdDc2I=;
        b=f+ZJ27hoBYZivBonQCYSgN+BjpUkOoi5Da+uELOV9udSXsttk3JIJ1hDQFVNfkzFzj
         nyEbnpMX3D9Bj8scmdxI+QkYwzRiw7Ojr30OeU6OmRxRvhMLwUHg4w5tFk25N0UbXJeG
         tDcvgkZhBFMAW/Kl0/LX17k4TINaOUOXM74LO4+wSImKqhCv6XVEZIVdt6nK59jSBqEU
         m/4tE4nEH7SLrunbfYM4jTOxgr4OJid9+Oqn586Ufwl3gfzxC5vLUH7nKIP3Xw3aEERO
         9VLE3SCTi/J/c5D0rGSVrXCVpGZ5ilkVkvr7KLIXSduAaWa+xVchGlqYXAa5LwmaRLq4
         emGQ==
X-Gm-Message-State: AO0yUKXO26SzWeqhSY409mjlDleBC1LbZsJNcbb4qodDHQ3JVRhF8Y+Z
        /YDZzRPJ4eATJ5G5ViIAub6LadUdShOPOw==
X-Google-Smtp-Source: AK7set/YpT00teLoYr1lKVVYYsWYISintOTciXR1XgVvPfVZjd3XuoLpDILnx5FNPoBflawsKwpK7g==
X-Received: by 2002:a19:7404:0:b0:4dd:a019:b4a1 with SMTP id v4-20020a197404000000b004dda019b4a1mr3063457lfe.54.1677797731163;
        Thu, 02 Mar 2023 14:55:31 -0800 (PST)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id u27-20020a056512041b00b004db266f3978sm113840lfk.174.2023.03.02.14.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 14:55:30 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com, jose.marchesi@oracle.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf: test if pointer type is tracked for BPF_ST_MEM
Date:   Fri,  3 Mar 2023 00:55:06 +0200
Message-Id: <20230302225507.3413720-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302225507.3413720-1-eddyz87@gmail.com>
References: <20230302225507.3413720-1-eddyz87@gmail.com>
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
2.39.1

