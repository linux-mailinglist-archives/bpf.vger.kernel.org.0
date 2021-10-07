Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02620425575
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 16:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242084AbhJGOcY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 10:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbhJGOcY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 10:32:24 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394D4C061746
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 07:30:30 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v18so24056689edc.11
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 07:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8fTtRnswbazIUnyAHS8h/DFC2rlG7Kd7HlnILrsmiPo=;
        b=CkeB/+aFckGK+ggkMunX6zz4pReX6IHgo+AX9eshy5rULWn75FlkdL64GbY4GzyL99
         1txZdtInDGFaTEUxk+eoTH8RP2tSoJCC5ddFqOu1RhOFhWL/9R5LZZ09UndWCVGI4R45
         qJQCwRnXCUxbgPvwzL2mCLTKPL55JfBBmPM2Xfh8DCdbetFn6y1hE5GswgbwRUw+vsKZ
         efb/QlNw+aL/IWbDZ2fy3LJDzmoW3U5NdiWEcXkV2nypYmcXCKAfMvqfHWHnaFU4tuMT
         BYC3aPoOaxUZ11RT+gGtSJ3oaBQ7Qg+fRkWbVkQ8tQvUAtJYMF53quVL7rj3tuyXbl9h
         /ryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8fTtRnswbazIUnyAHS8h/DFC2rlG7Kd7HlnILrsmiPo=;
        b=MrXnZUzH3RpFwtFjwQknSUCArlwGx98PXl5wbZK0kB1VHrXPO8xsFEvSGof/Hj2oEh
         JbLC+H/az20W9pUGhK+WJqRtQpOogLy1j4he9BmWJvlyyYYiMDZjelGJcEyzqzFeX2Nx
         kljbn42gSdQXqdMBoBYasb+bQYytwkm/HeNaHIgwS+QByhwxbS1/iiXYausYwHEpOymg
         GEiV8HGoF5zXhqx3Gvz1Au4Y3sbq6o0D99Aabh73IRjUgcNpyj5UNKk7G0XEmgvT7Ce6
         UMkGKJ3I74TZm0Z15k9Pv8oHxMsbV9lku7OTIq4IdoH/FMtpK+/EAJI5vSjnPHAFPpqE
         ktug==
X-Gm-Message-State: AOAM531WqAL6SZh4fTmOz6pFI/irTMwOsgN5paLg4TllThz4aBxEr5+T
        E65gqPWDIFe2pG5N1t20OvsgjA==
X-Google-Smtp-Source: ABdhPJxGdFpuWq1cKWHvzh+Ut2ycwFwcDKQsCM9wHceOxXnT1292AF+3QOXiBCiJ9BslzRQRL84JKw==
X-Received: by 2002:a50:be8f:: with SMTP id b15mr6745943edk.200.1633617020623;
        Thu, 07 Oct 2021 07:30:20 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id og39sm3617830ejc.93.2021.10.07.07.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 07:30:20 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next] bpf, tests: Add more LD_IMM64 tests
Date:   Thu,  7 Oct 2021 16:30:06 +0200
Message-Id: <20211007143006.634308-1-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds new tests for the two-instruction LD_IMM64. The new tests
verify the operation with immediate values of different byte patterns.
Mainly intended to cover JITs that want to be clever when loading 64-bit
constants.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 120 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 117 insertions(+), 3 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index b9fc330fc83b..e5b10fdefab5 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -2134,7 +2134,7 @@ static int bpf_fill_atomic32_cmpxchg_reg_pairs(struct bpf_test *self)
  * of the immediate value. This is often the case if the native instruction
  * immediate field width is narrower than 32 bits.
  */
-static int bpf_fill_ld_imm64(struct bpf_test *self)
+static int bpf_fill_ld_imm64_magn(struct bpf_test *self)
 {
 	int block = 64; /* Increase for more tests per MSB position */
 	int len = 3 + 8 * 63 * block * 2;
@@ -2180,6 +2180,88 @@ static int bpf_fill_ld_imm64(struct bpf_test *self)
 	return 0;
 }
 
+/*
+ * Test the two-instruction 64-bit immediate load operation for different
+ * combinations of bytes. Each byte in the 64-bit word is constructed as
+ * (base & mask) | (rand() & ~mask), where rand() is a deterministic LCG.
+ * All patterns (base1, mask1) and (base2, mask2) bytes are tested.
+ */
+static int __bpf_fill_ld_imm64_bytes(struct bpf_test *self,
+				     u8 base1, u8 mask1,
+				     u8 base2, u8 mask2)
+{
+	struct bpf_insn *insn;
+	int len = 3 + 8 * BIT(8);
+	int pattern, index;
+	u32 rand = 1;
+	int i = 0;
+
+	insn = kmalloc_array(len, sizeof(*insn), GFP_KERNEL);
+	if (!insn)
+		return -ENOMEM;
+
+	insn[i++] = BPF_ALU64_IMM(BPF_MOV, R0, 0);
+
+	for (pattern = 0; pattern < BIT(8); pattern++) {
+		u64 imm = 0;
+
+		for (index = 0; index < 8; index++) {
+			int byte;
+
+			if (pattern & BIT(index))
+				byte = (base1 & mask1) | (rand & ~mask1);
+			else
+				byte = (base2 & mask2) | (rand & ~mask2);
+			imm = (imm << 8) | byte;
+		}
+
+		/* Update our LCG */
+		rand = rand * 1664525 + 1013904223;
+
+		/* Perform operation */
+		i += __bpf_ld_imm64(&insn[i], R1, imm);
+
+		/* Load reference */
+		insn[i++] = BPF_ALU32_IMM(BPF_MOV, R2, imm);
+		insn[i++] = BPF_ALU32_IMM(BPF_MOV, R3, (u32)(imm >> 32));
+		insn[i++] = BPF_ALU64_IMM(BPF_LSH, R3, 32);
+		insn[i++] = BPF_ALU64_REG(BPF_OR, R2, R3);
+
+		/* Check result */
+		insn[i++] = BPF_JMP_REG(BPF_JEQ, R1, R2, 1);
+		insn[i++] = BPF_EXIT_INSN();
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
+
+static int bpf_fill_ld_imm64_checker(struct bpf_test *self)
+{
+	return __bpf_fill_ld_imm64_bytes(self, 0, 0xff, 0xff, 0xff);
+}
+
+static int bpf_fill_ld_imm64_pos_neg(struct bpf_test *self)
+{
+	return __bpf_fill_ld_imm64_bytes(self, 1, 0x81, 0x80, 0x80);
+}
+
+static int bpf_fill_ld_imm64_pos_zero(struct bpf_test *self)
+{
+	return __bpf_fill_ld_imm64_bytes(self, 1, 0x81, 0, 0xff);
+}
+
+static int bpf_fill_ld_imm64_neg_zero(struct bpf_test *self)
+{
+	return __bpf_fill_ld_imm64_bytes(self, 0x80, 0x80, 0, 0xff);
+}
+
 /*
  * Exhaustive tests of JMP operations for all combinations of power-of-two
  * magnitudes of the operands, both for positive and negative values. The
@@ -12401,14 +12483,46 @@ static struct bpf_test tests[] = {
 		.fill_helper = bpf_fill_alu32_mod_reg,
 		.nr_testruns = NR_PATTERN_RUNS,
 	},
-	/* LD_IMM64 immediate magnitudes */
+	/* LD_IMM64 immediate magnitudes and byte patterns */
 	{
 		"LD_IMM64: all immediate value magnitudes",
 		{ },
 		INTERNAL | FLAG_NO_DATA,
 		{ },
 		{ { 0, 1 } },
-		.fill_helper = bpf_fill_ld_imm64,
+		.fill_helper = bpf_fill_ld_imm64_magn,
+	},
+	{
+		"LD_IMM64: checker byte patterns",
+		{ },
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 1 } },
+		.fill_helper = bpf_fill_ld_imm64_checker,
+	},
+	{
+		"LD_IMM64: random positive and zero byte patterns",
+		{ },
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 1 } },
+		.fill_helper = bpf_fill_ld_imm64_pos_zero,
+	},
+	{
+		"LD_IMM64: random negative and zero byte patterns",
+		{ },
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 1 } },
+		.fill_helper = bpf_fill_ld_imm64_neg_zero,
+	},
+	{
+		"LD_IMM64: random positive and negative byte patterns",
+		{ },
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 1 } },
+		.fill_helper = bpf_fill_ld_imm64_pos_neg,
 	},
 	/* 64-bit ATOMIC register combinations */
 	{
-- 
2.30.2

