Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C68405978
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 16:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347995AbhIIOqO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 10:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347795AbhIIOqC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 10:46:02 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3223C05BD2E
        for <bpf@vger.kernel.org>; Thu,  9 Sep 2021 07:33:21 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z19so2941555edi.9
        for <bpf@vger.kernel.org>; Thu, 09 Sep 2021 07:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6JgkaMGpZwDS6XNkA78x7OvNTWeQU37pK4HmsG/VJGA=;
        b=MH+ypgBwI4EvstOP6lL/IZvNKA7VeIPGV/fFdGYTqsViKQ+WM/DGQwZ6Dhi90AW3BW
         Ux7FbJ6TEWhB+4RKjQ5F4MkRU2Q20ei+j4LCB2A4rVzHC4WnIcvxY/PqXXruybHRRkyr
         0vwjXGS8+CXSDxNWzUP/9zXR00IINewaep9Azr/DFKWwuhS6W2nht/mFztzScp0sEBsl
         3Nxnaw/sni7F4V8ASS8FTOY7v35TfKR7JZwc4v1HHFkkE0RnSTttKvkzOwPn+bxB9DSF
         5y2S1FSlNIhF4Z7nScBQntYF8UePq6f0clbeit9BGUMzEDv7FTz3rqp1clA95YJomZCW
         p5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6JgkaMGpZwDS6XNkA78x7OvNTWeQU37pK4HmsG/VJGA=;
        b=RdQbpAVTJfm6xP9juWVrZcJpQdyhvbiok3FO/sQ/oi+sJ3PlkHdVyNYEKCzn+v97AT
         tvJSY0oU/OpT6qD8Zxr24CJMkka0FWy+UvJBLIuobpAH71oJMRHksWyjzXPiW3WEJPsh
         flUDpM/ZGBoyxJYFmODHzBdtwk+YzzOsK5iEOdy5i5ZMiS/UItWySyXdPji02ztxKh+C
         GbHI2ufIyy2xvYPvgbH2z2Vvclc3F8DNvXepevz9iiPYQuGrkvgPK9fB5DpVUzVmYkez
         h9rTeSUjzP1eZTCcn32ijOpknAtkYwVFiDczHN69R6oKe3F5DFBVucCMjXcpYeduSkfz
         Jw6A==
X-Gm-Message-State: AOAM533AVZ72JMO+5oEy9zVnlDde2/BXVsI85G+iniVN3h8w0tsms6Nw
        NL5lgEwzx44FnP8uNUnX/0xXiA==
X-Google-Smtp-Source: ABdhPJxAaKE9Nx3UHvl+MyLWXPzFmR6fagl1Ifu4U64UiitWgy6ulM/FG5DNEfAeSdxmNgrI2JJhgw==
X-Received: by 2002:a05:6402:21e6:: with SMTP id ce6mr3424980edb.153.1631198000614;
        Thu, 09 Sep 2021 07:33:20 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id bj10sm1030909ejb.17.2021.09.09.07.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 07:33:20 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, iii@linux.ibm.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next v3 07/13] bpf/tests: Add exhaustive test of LD_IMM64 immediate magnitudes
Date:   Thu,  9 Sep 2021 16:32:57 +0200
Message-Id: <20210909143303.811171-8-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909143303.811171-1-johan.almbladh@anyfinetworks.com>
References: <20210909143303.811171-1-johan.almbladh@anyfinetworks.com>
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

