Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA0F40AAA5
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 11:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhINJUw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 05:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhINJUh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 05:20:37 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0B8C061768
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 02:19:18 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id t19so27326860ejr.8
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 02:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oagsNrHkckWAjyNMa7DFQkqODS/sdAoBZjxZqIVeja0=;
        b=bwJTmCYOV/k6zDx2aOjsuG33ArFYAZ9AM6ncG99YOm8Lr3pCwQHdrWQy5PSNNHyTI0
         bsaSFfIQdZ2nC4utHh5Zf5Le5IQLmm4/Q1xttxj3k31AfYfSDWY8XFXQhk9Y9O92dNnW
         bQg6ORcbeJz2Zuyi3jrVch5vnpfYizHjOSGCpRxX9X7V0u323VL9gX7r9+vtRR+8yG0W
         p8qwNMvQqvMpE/UFmCpCY3zaCdVLFdUl/VvfJ1XJKUrkQxtWI81yE1XzoO/pm+cR0dRi
         t4DsUfsO0+7DmYi0Om8pVUIkb+kIBkImPI068+ydZTvcP9bSDanlTD6cluspPLj6jw6d
         3uHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oagsNrHkckWAjyNMa7DFQkqODS/sdAoBZjxZqIVeja0=;
        b=f1D5QVyG8MH3TT64lD4mjaurUOaLWEtXvDKBtvJTdgJfDr0Ldt7yMo1EUMsEdkJQDA
         HlS1+gbyyOrTrMqGLu9+gIlZqA7bchBNV6LTtfTseDRN7gI+gIW7NugqM3BTFHKx6zJV
         2eY/+GUA9t8bpiFXE6slmjKAgW5VaHb79aWLkGuuAIs/zYSlmgAM162SxSnGD2QQ0ulv
         e6ckIN/FffT/I/5q3GjRsOtewG88bPtfylkWK1StW5EmOWeFcnkNHgf2cLbQMIU5Op7C
         eZ3c0tART0ySzkMvnD1C6SWBLgDJmw1+xOfVOsj9WtAoaskUXE3B/dGLW0Y5YpHxkdYl
         bDug==
X-Gm-Message-State: AOAM531e6ZVc/Vtxf51rfHhMyphdzCMQcfBAmSynfp2XtLpg8/D2GnGH
        R4spJDcFq3ZKoJw0yXovwrrmkQ==
X-Google-Smtp-Source: ABdhPJxhqMSFINNtKxAIBFmWem8PRa0/42X/rxipSpo5uKEmdmHkmD2zxHkGXckHEX6N4l/Zy2OE1g==
X-Received: by 2002:a17:907:2098:: with SMTP id pv24mr4880403ejb.426.1631611157160;
        Tue, 14 Sep 2021 02:19:17 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id h10sm4615915ede.28.2021.09.14.02.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 02:19:16 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, iii@linux.ibm.com,
        paul@cilium.io, yangtiezhu@loongson.cn, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf v4 12/14] bpf/tests: Add more BPF_END byte order conversion tests
Date:   Tue, 14 Sep 2021 11:18:40 +0200
Message-Id: <20210914091842.4186267-13-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914091842.4186267-1-johan.almbladh@anyfinetworks.com>
References: <20210914091842.4186267-1-johan.almbladh@anyfinetworks.com>
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
2.30.2

