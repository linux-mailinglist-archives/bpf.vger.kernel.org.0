Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771F540AA9B
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 11:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhINJUi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 05:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhINJUf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 05:20:35 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C54C0613E6
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 02:19:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ho42so27322963ejc.9
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 02:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6JgkaMGpZwDS6XNkA78x7OvNTWeQU37pK4HmsG/VJGA=;
        b=pEXpFQXqrXoJksDaJUBCQQQPiN5U9GOFHNm+njsIMOe1u54shZ3YdJPkedPuhfnqNJ
         Urzdb/lp2reFqsSaF05JXvscW9QQIUlBhaNZ3PIceJhyfNiiGYCdb1qVx2XiOo5EyulL
         vgqxbEqxCEA1EAfbUNbephM0Iw2WsYmkPeff3+1I5znSBz0oWc89K+WHSM8C2D1PHFwY
         5zNAGGZTeUomMDsIns9tdFqwKWYGCSEDl3PbU3/TFPns+yJr/r0tIqDTXWS9XgKKle7U
         1xOuiiuYjWhLin359RAIhpOL2sOM2IAyoLTZYgMH6CKTxEIv1pNWn218FTTVAiFtmV4L
         XINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6JgkaMGpZwDS6XNkA78x7OvNTWeQU37pK4HmsG/VJGA=;
        b=ATv+5yJx1aVj0WMlr9MLe2kXBzPYqP+lAPFm+JTSaoIgFLd9yppffLuSBkwXHyvFOl
         kuW26MTh1+OcplSwUM5ldzyg/33YW7wk91QqaPi5ryOgIcc7PxNRk9e0Vc7w//fnMD8s
         diHOclUDzRPBOJxaBPTiAaXb55Tn3/xR22Bt83hrC9rpZalXyeIc96UPmIkyqJ4F+HKV
         PPQLu+Ms4j41K5hdpm1U9YmIQEOJyXRpkbfHwrs0S5nUpK9qy9iJxH8WRuXctGAkPYpX
         D0uQWldDRjshgUt8Qrd0hQm3+iP62NwURpMr3blNLiO3466nI8rRX2L8AngpKiaiUryg
         sajg==
X-Gm-Message-State: AOAM530sxggNjWwTdioydJ/i7B90N8IfmOKU5c51GN89GTVE222XIQp5
        RELxms9WljkmOy+Cp60JPlT9hA==
X-Google-Smtp-Source: ABdhPJzr8p1cct9MNuRRWwLy3CPga6+1E+1np2J6tHJkehiEmvUkhO0+kn20JwyDQlqg0928osDcJg==
X-Received: by 2002:a17:906:2a8e:: with SMTP id l14mr17367829eje.321.1631611151591;
        Tue, 14 Sep 2021 02:19:11 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id h10sm4615915ede.28.2021.09.14.02.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 02:19:11 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, iii@linux.ibm.com,
        paul@cilium.io, yangtiezhu@loongson.cn, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf v4 07/14] bpf/tests: Add exhaustive test of LD_IMM64 immediate magnitudes
Date:   Tue, 14 Sep 2021 11:18:35 +0200
Message-Id: <20210914091842.4186267-8-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914091842.4186267-1-johan.almbladh@anyfinetworks.com>
References: <20210914091842.4186267-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds a test for the 64-bit immediate load, a two-instruction
operation, to verify correctness for all possible magnitudes of the
immediate operand. Mainly intended for JIT testing.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index c25e99a461de..6a04447171c7 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -1104,6 +1104,60 @@ static int bpf_fill_alu32_mod_reg(struct bpf_test *self)
 	return __bpf_fill_alu32_reg(self, BPF_MOD);
 }
 
+/*
+ * Test the two-instruction 64-bit immediate load operation for all
+ * power-of-two magnitudes of the immediate operand. For each MSB, a block
+ * of immediate values centered around the power-of-two MSB are tested,
+ * both for positive and negative values. The test is designed to verify
+ * the operation for JITs that emit different code depending on the magnitude
+ * of the immediate value. This is often the case if the native instruction
+ * immediate field width is narrower than 32 bits.
+ */
+static int bpf_fill_ld_imm64(struct bpf_test *self)
+{
+	int block = 64; /* Increase for more tests per MSB position */
+	int len = 3 + 8 * 63 * block * 2;
+	struct bpf_insn *insn;
+	int bit, adj, sign;
+	int i = 0;
+
+	insn = kmalloc_array(len, sizeof(*insn), GFP_KERNEL);
+	if (!insn)
+		return -ENOMEM;
+
+	insn[i++] = BPF_ALU64_IMM(BPF_MOV, R0, 0);
+
+	for (bit = 0; bit <= 62; bit++) {
+		for (adj = -block / 2; adj < block / 2; adj++) {
+			for (sign = -1; sign <= 1; sign += 2) {
+				s64 imm = sign * ((1LL << bit) + adj);
+
+				/* Perform operation */
+				i += __bpf_ld_imm64(&insn[i], R1, imm);
+
+				/* Load reference */
+				insn[i++] = BPF_ALU32_IMM(BPF_MOV, R2, imm);
+				insn[i++] = BPF_ALU32_IMM(BPF_MOV, R3,
+							  (u32)(imm >> 32));
+				insn[i++] = BPF_ALU64_IMM(BPF_LSH, R3, 32);
+				insn[i++] = BPF_ALU64_REG(BPF_OR, R2, R3);
+
+				/* Check result */
+				insn[i++] = BPF_JMP_REG(BPF_JEQ, R1, R2, 1);
+				insn[i++] = BPF_EXIT_INSN();
+			}
+		}
+	}
+
+	insn[i++] = BPF_ALU64_IMM(BPF_MOV, R0, 1);
+	insn[i++] = BPF_EXIT_INSN();
+
+	self->u.ptr.insns = insn;
+	self->u.ptr.len = len;
+	BUG_ON(i != len);
+
+	return 0;
+}
 
 /*
  * Exhaustive tests of JMP operations for all combinations of power-of-two
@@ -10245,6 +10299,15 @@ static struct bpf_test tests[] = {
 		.fill_helper = bpf_fill_alu32_mod_reg,
 		.nr_testruns = NR_PATTERN_RUNS,
 	},
+	/* LD_IMM64 immediate magnitudes */
+	{
+		"LD_IMM64: all immediate value magnitudes",
+		{ },
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 1 } },
+		.fill_helper = bpf_fill_ld_imm64,
+	},
 	/* JMP immediate magnitudes */
 	{
 		"JMP_JSET_K: all immediate value magnitudes",
-- 
2.30.2

