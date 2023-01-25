Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0AB67B9FF
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 19:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbjAYS6Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 13:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbjAYS6X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 13:58:23 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD8036695
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 10:58:21 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a18so6222491plm.2
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 10:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kTcSgZsGUsWOjGcwX1i3f2q7TvVOWI0RcMHTJyO1ggY=;
        b=HbUk1vsxrSrMaharncpuYTR7qbKtU9SkWVkTc2S9asHcGPkX/cIXd1laXuwbpJLVq8
         Hp2EdEAMlco9kFcmIud61ZPAH8NXpDFyrEPZvdsemw/gBruOIQjLNJ2IhK3Z/khOlU1I
         d5tYvAFhKcv74lCx4guXEHEw9nb4XP3wV9CNNTEr3xfBW/UBOtnpJ1ybwo5G6lmlqHik
         ZZbpCOFzI321rM4GLKQRskyKIJkFhCJpWnKbjxytPNBNJlzpnTCOGu8QEOPxGBJPETRG
         hcaEysRGdXRAAMi0VJ7kFJ5zdK1SZSoBimiTNYhW5Hr3fDavQHbZ1wuJJ3j8qYkNxt/2
         enHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTcSgZsGUsWOjGcwX1i3f2q7TvVOWI0RcMHTJyO1ggY=;
        b=TW/9JiuqQtZNh9YQYqHO4U88SXiB+DxxPSF2mBu3Z0MpnNJXzMfFJVFvU81GMORvgn
         7jJiOsa1A3s27k8zbwhe5RcXzPaAOShVrO9R1mAvHDyqnWcqN7GbreEhndGB6DrY+iRi
         txa2ecVQd3pc9zahpszQ8D/8pVF67cuq0h+Ej7TfY/3zInVaY+dd6RvR5B+AMhG53uaJ
         hYWwmYmy75CA7dnMJxA1QCi2bWkTAcMzjkJkYkDrSDymnemJtFSP5ANGxdwA+BMJyuZL
         IbxHl59IQYb6lHYrZMoXbpIIryJy8E22pMcTC6DFIVcijACoJeU2Njm5m7y0BdyPf+Rf
         FqHA==
X-Gm-Message-State: AFqh2kqjolQUZIvCf3IFdZqRtNQpppgju+tzoMwk33sHBJKm4DADamux
        QAZJWdtHXg9+MLfE0+fsAj+ZKwd5qLU=
X-Google-Smtp-Source: AMrXdXunqwjhLfvdYpexlP2sv6xNozM6qzr8YXaf7wdlw4WHn0lWM/7mrlZe1VY9ANEFsAJCb+6bFQ==
X-Received: by 2002:a17:902:d2d1:b0:194:c5d6:328 with SMTP id n17-20020a170902d2d100b00194c5d60328mr34817435plc.35.1674673100656;
        Wed, 25 Jan 2023 10:58:20 -0800 (PST)
Received: from mariner-vm.. ([131.107.174.144])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090282c200b00192fc9e8552sm4036234plz.0.2023.01.25.10.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 10:58:20 -0800 (PST)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH] bpf, docs: Use consistent names for the same field
Date:   Wed, 25 Jan 2023 18:58:17 +0000
Message-Id: <20230125185817.6408-1-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
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

From: Dave Thaler <dthaler@microsoft.com>

Use consistent names for the same field, e.g., 'dst' vs 'dst_reg'.
Previously a mix of terms were used for the same thing in various cases.

Changes since last submission: addressed comments from Alexei and Stanislav

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 105 ++++++++++++++++++--------
 1 file changed, 74 insertions(+), 31 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 2d3fe59bd26..3778c807cbb 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -30,20 +30,59 @@ Instruction encoding
 eBPF has two instruction encodings:
 
 * the basic instruction encoding, which uses 64 bits to encode an instruction
-* the wide instruction encoding, which appends a second 64-bit immediate value
-  (imm64) after the basic instruction for a total of 128 bits.
+* the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
+  constant) value after the basic instruction for a total of 128 bits.
 
-The basic instruction encoding looks as follows:
+The basic instruction encoding is as follows, where MSB and LSB mean the most significant
+bits and least significant bits, respectively:
 
 =============  =======  ===============  ====================  ============
 32 bits (MSB)  16 bits  4 bits           4 bits                8 bits (LSB)
 =============  =======  ===============  ====================  ============
-immediate      offset   source register  destination register  opcode
+imm            offset   src              dst                   opcode
 =============  =======  ===============  ====================  ============
 
+imm
+  signed integer immediate value
+
+offset
+  signed integer offset used with pointer arithmetic
+
+src
+  the source register number (0-10), except where otherwise specified
+  (`64-bit immediate instructions`_ reuse this field for other purposes)
+
+dst
+  destination register number (0-10)
+
+opcode
+  operation to perform
+
 Note that most instructions do not use all of the fields.
 Unused fields shall be cleared to zero.
 
+As discussed below in `64-bit immediate instructions`_, a 64-bit immediate
+instruction uses a 64-bit immediate value that is constructed as follows.
+The 64 bits following the basic instruction contain a pseudo instruction
+using the same format but with opcode, dst, src, and offset all set to zero,
+and imm containing the high 32 bits of the immediate value.
+
+=================  ==================
+64 bits (MSB)      64 bits (LSB)
+=================  ==================
+basic instruction  pseudo instruction
+=================  ==================
+
+Thus the 64-bit immediate value is constructed as follows:
+
+  imm64 = (next_imm << 32) | imm
+
+where 'next_imm' refers to the imm value of the pseudo instruction
+following the basic instruction.
+
+In the remainder of this document 'src' and 'dst' refer to the values of the source
+and destination registers, respectively, rather than the register number.
+
 Instruction classes
 -------------------
 
@@ -71,20 +110,24 @@ For arithmetic and jump instructions (``BPF_ALU``, ``BPF_ALU64``, ``BPF_JMP`` an
 ==============  ======  =================
 4 bits (MSB)    1 bit   3 bits (LSB)
 ==============  ======  =================
-operation code  source  instruction class
+code            source  instruction class
 ==============  ======  =================
 
-The 4th bit encodes the source operand:
+code
+  the operation code, whose meaning varies by instruction class
 
-  ======  =====  ========================================
-  source  value  description
-  ======  =====  ========================================
-  BPF_K   0x00   use 32-bit immediate as source operand
-  BPF_X   0x08   use 'src_reg' register as source operand
-  ======  =====  ========================================
+source
+  the source operand location, which unless otherwise specified is one of:
 
-The four MSB bits store the operation code.
+  ======  =====  ==========================================
+  source  value  description
+  ======  =====  ==========================================
+  BPF_K   0x00   use 32-bit 'imm' value as source operand
+  BPF_X   0x08   use 'src' register value as source operand
+  ======  =====  ==========================================
 
+instruction class
+  the instruction class (see `Instruction classes`_)
 
 Arithmetic instructions
 -----------------------
@@ -121,19 +164,19 @@ the destination register is unchanged whereas for ``BPF_ALU`` the upper
 
 ``BPF_ADD | BPF_X | BPF_ALU`` means::
 
-  dst_reg = (u32) dst_reg + (u32) src_reg;
+  dst = (u32) ((u32) dst + (u32) src)
 
 ``BPF_ADD | BPF_X | BPF_ALU64`` means::
 
-  dst_reg = dst_reg + src_reg
+  dst = dst + src
 
 ``BPF_XOR | BPF_K | BPF_ALU`` means::
 
-  dst_reg = (u32) dst_reg ^ (u32) imm32
+  dst = (u32) dst ^ (u32) imm32
 
 ``BPF_XOR | BPF_K | BPF_ALU64`` means::
 
-  dst_reg = dst_reg ^ imm32
+  dst = dst ^ imm32
 
 Also note that the division and modulo operations are unsigned. Thus, for
 ``BPF_ALU``, 'imm' is first interpreted as an unsigned 32-bit value, whereas
@@ -167,11 +210,11 @@ Examples:
 
 ``BPF_ALU | BPF_TO_LE | BPF_END`` with imm = 16 means::
 
-  dst_reg = htole16(dst_reg)
+  dst = htole16(dst)
 
 ``BPF_ALU | BPF_TO_BE | BPF_END`` with imm = 64 means::
 
-  dst_reg = htobe64(dst_reg)
+  dst = htobe64(dst)
 
 Jump instructions
 -----------------
@@ -246,15 +289,15 @@ instructions that transfer data between a register and memory.
 
 ``BPF_MEM | <size> | BPF_STX`` means::
 
-  *(size *) (dst_reg + off) = src_reg
+  *(size *) (dst + offset) = src_reg
 
 ``BPF_MEM | <size> | BPF_ST`` means::
 
-  *(size *) (dst_reg + off) = imm32
+  *(size *) (dst + offset) = imm32
 
 ``BPF_MEM | <size> | BPF_LDX`` means::
 
-  dst_reg = *(size *) (src_reg + off)
+  dst = *(size *) (src + offset)
 
 Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
 
@@ -288,11 +331,11 @@ BPF_XOR   0xa0   atomic xor
 
 ``BPF_ATOMIC | BPF_W  | BPF_STX`` with 'imm' = BPF_ADD means::
 
-  *(u32 *)(dst_reg + off16) += src_reg
+  *(u32 *)(dst + offset) += src
 
 ``BPF_ATOMIC | BPF_DW | BPF_STX`` with 'imm' = BPF ADD means::
 
-  *(u64 *)(dst_reg + off16) += src_reg
+  *(u64 *)(dst + offset) += src
 
 In addition to the simple atomic operations, there also is a modifier and
 two complex atomic operations:
@@ -307,16 +350,16 @@ BPF_CMPXCHG  0xf0 | BPF_FETCH  atomic compare and exchange
 
 The ``BPF_FETCH`` modifier is optional for simple atomic operations, and
 always set for the complex atomic operations.  If the ``BPF_FETCH`` flag
-is set, then the operation also overwrites ``src_reg`` with the value that
+is set, then the operation also overwrites ``src`` with the value that
 was in memory before it was modified.
 
-The ``BPF_XCHG`` operation atomically exchanges ``src_reg`` with the value
-addressed by ``dst_reg + off``.
+The ``BPF_XCHG`` operation atomically exchanges ``src`` with the value
+addressed by ``dst + offset``.
 
 The ``BPF_CMPXCHG`` operation atomically compares the value addressed by
-``dst_reg + off`` with ``R0``. If they match, the value addressed by
-``dst_reg + off`` is replaced with ``src_reg``. In either case, the
-value that was at ``dst_reg + off`` before the operation is zero-extended
+``dst + offset`` with ``R0``. If they match, the value addressed by
+``dst + offset`` is replaced with ``src``. In either case, the
+value that was at ``dst + offset`` before the operation is zero-extended
 and loaded back to ``R0``.
 
 64-bit immediate instructions
@@ -329,7 +372,7 @@ There is currently only one such instruction.
 
 ``BPF_LD | BPF_DW | BPF_IMM`` means::
 
-  dst_reg = imm64
+  dst = imm64
 
 
 Legacy BPF Packet access instructions
-- 
2.33.4

