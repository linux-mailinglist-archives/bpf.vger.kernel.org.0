Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC964030F6
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 00:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348763AbhIGWZR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 18:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348194AbhIGWZJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Sep 2021 18:25:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85565C061575
        for <bpf@vger.kernel.org>; Tue,  7 Sep 2021 15:24:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g8so62496edt.7
        for <bpf@vger.kernel.org>; Tue, 07 Sep 2021 15:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JrA4KDr+EqvoE+WZ7hlhOAoAEblbMKXTm8z0RFxsW20=;
        b=11Rj6tT0t9nXv03B00cYJiO6JXe4h7+CH+/EJZeFVesk5UE+4NYf9j/yT69un9nCjx
         xOwLrdqRcyD8TaWBCpigLhDZmx7EJD0f/wiRjdXbqDMEFVE9x2VQyonsZfcuupT7T8HA
         79E94+SG2Q+RIUAAytwhzy9Mn49SKNU6+FpX8jSC7P8TOoBfB7QGCQ4H3mmnqvuBBtiw
         nKecmUjYrz2FW++2tWkFmG/+JLEnzu6dqkggFApjNbu4zcNS6dSU7Mslj/raMGAd3mRg
         w0H7dKpYkp1rAEPg9Mpts1bkXP+soB1WbQxtM4CfVQy3/F84V8wZfFhmNsTVSGbOWIaH
         OxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JrA4KDr+EqvoE+WZ7hlhOAoAEblbMKXTm8z0RFxsW20=;
        b=B12Egq6cTYKYgHyNPbiSwyYB2hqxkwqS4ibw25nlKdvuV38xEkXI54faz1YcmxhMZ6
         ns6f/NUQHw7BQ2XW+xP4QpaLRRN7vVi3oSCNP6jdPwCnkcVLYPItaCQPXE6yYo95Wesx
         hnzdITEKuv98Ucct6+UCLW4CCkhe1T20Ow4/vZnPN1KLXEK3I8dHigYk9i8r+hEXLF55
         5TYIQePN9vuQYz57r+5r0NtjkzyqkYTFsvM0UYayFJU6ty4pmOz0vmbVst/DV1lZzt2O
         SGk4limuRRveOoQJfEzX2TspNWsRZ/MG8J8ymVUwO38oT/esrmyTCZw6BE/lYg33GaKH
         +cYA==
X-Gm-Message-State: AOAM530RoEOQ2pUFaRWq33thsViLcdXS5pcX1UaEVqnOkuSrdVJZTNty
        BpY9YyxiSwGQBxidC4J9ERO6fw==
X-Google-Smtp-Source: ABdhPJyw3WbjP2nep9L5FYtPnmDRuBWTYPiYFgIx4CUBpU1uwQHZ8CYmfWJTHPn2VZgWGyrotpbCqw==
X-Received: by 2002:aa7:d854:: with SMTP id f20mr507406eds.353.1631053441133;
        Tue, 07 Sep 2021 15:24:01 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id gb24sm71772ejc.53.2021.09.07.15.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 15:24:00 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, iii@linux.ibm.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next v2 12/13] bpf/tests: Add more BPF_END byte order conversion tests
Date:   Wed,  8 Sep 2021 00:23:38 +0200
Message-Id: <20210907222339.4130924-13-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210907222339.4130924-1-johan.almbladh@anyfinetworks.com>
References: <20210907222339.4130924-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds tests of the high 32 bits of 64-bit BPF_END conversions.

It also adds a mirrored set of tests where the source bytes are reversed.
The MSB of each byte is now set on the high word instead, possibly
affecting sign-extension during conversion in a different way. Mainly
for JIT testing.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index a515f9b670c9..7475abfd2186 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -6748,6 +6748,67 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, (u32) cpu_to_be64(0x0123456789abcdefLL) } },
 	},
+	{
+		"ALU_END_FROM_BE 64: 0x0123456789abcdef >> 32 -> 0x01234567",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_ENDIAN(BPF_FROM_BE, R0, 64),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, (u32) (cpu_to_be64(0x0123456789abcdefLL) >> 32) } },
+	},
+	/* BPF_ALU | BPF_END | BPF_FROM_BE, reversed */
+	{
+		"ALU_END_FROM_BE 16: 0xfedcba9876543210 -> 0x3210",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
+			BPF_ENDIAN(BPF_FROM_BE, R0, 16),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0,  cpu_to_be16(0x3210) } },
+	},
+	{
+		"ALU_END_FROM_BE 32: 0xfedcba9876543210 -> 0x76543210",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
+			BPF_ENDIAN(BPF_FROM_BE, R0, 32),
+			BPF_ALU64_REG(BPF_MOV, R1, R0),
+			BPF_ALU64_IMM(BPF_RSH, R1, 32),
+			BPF_ALU32_REG(BPF_ADD, R0, R1), /* R1 = 0 */
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, cpu_to_be32(0x76543210) } },
+	},
+	{
+		"ALU_END_FROM_BE 64: 0xfedcba9876543210 -> 0x76543210",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
+			BPF_ENDIAN(BPF_FROM_BE, R0, 64),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, (u32) cpu_to_be64(0xfedcba9876543210ULL) } },
+	},
+	{
+		"ALU_END_FROM_BE 64: 0xfedcba9876543210 >> 32 -> 0xfedcba98",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
+			BPF_ENDIAN(BPF_FROM_BE, R0, 64),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, (u32) (cpu_to_be64(0xfedcba9876543210ULL) >> 32) } },
+	},
 	/* BPF_ALU | BPF_END | BPF_FROM_LE */
 	{
 		"ALU_END_FROM_LE 16: 0x0123456789abcdef -> 0xefcd",
@@ -6785,6 +6846,67 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, (u32) cpu_to_le64(0x0123456789abcdefLL) } },
 	},
+	{
+		"ALU_END_FROM_LE 64: 0x0123456789abcdef >> 32 -> 0xefcdab89",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_ENDIAN(BPF_FROM_LE, R0, 64),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, (u32) (cpu_to_le64(0x0123456789abcdefLL) >> 32) } },
+	},
+	/* BPF_ALU | BPF_END | BPF_FROM_LE, reversed */
+	{
+		"ALU_END_FROM_LE 16: 0xfedcba9876543210 -> 0x1032",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
+			BPF_ENDIAN(BPF_FROM_LE, R0, 16),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0,  cpu_to_le16(0x3210) } },
+	},
+	{
+		"ALU_END_FROM_LE 32: 0xfedcba9876543210 -> 0x10325476",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
+			BPF_ENDIAN(BPF_FROM_LE, R0, 32),
+			BPF_ALU64_REG(BPF_MOV, R1, R0),
+			BPF_ALU64_IMM(BPF_RSH, R1, 32),
+			BPF_ALU32_REG(BPF_ADD, R0, R1), /* R1 = 0 */
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, cpu_to_le32(0x76543210) } },
+	},
+	{
+		"ALU_END_FROM_LE 64: 0xfedcba9876543210 -> 0x10325476",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
+			BPF_ENDIAN(BPF_FROM_LE, R0, 64),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, (u32) cpu_to_le64(0xfedcba9876543210ULL) } },
+	},
+	{
+		"ALU_END_FROM_LE 64: 0xfedcba9876543210 >> 32 -> 0x98badcfe",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
+			BPF_ENDIAN(BPF_FROM_LE, R0, 64),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, (u32) (cpu_to_le64(0xfedcba9876543210ULL) >> 32) } },
+	},
 	/* BPF_ST(X) | BPF_MEM | BPF_B/H/W/DW */
 	{
 		"ST_MEM_B: Store/Load byte: max negative",
-- 
2.25.1

