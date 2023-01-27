Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C4667F15F
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 23:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjA0Wrd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 17:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjA0Wrc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 17:47:32 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2E35CE67
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 14:47:04 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9so6402424pll.9
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 14:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zzipOJr47iPyvNOfdx8GYLYk05XSaCbDGO47K+hsrnU=;
        b=QXtCnZH39cpD4DmomSJnMPgeLKDwxuF2DdSoGEGeig98uk2PEjyZ2q28DjFfliOZ5s
         OmB9dj9AVBJ9SMWGd15nWmjkqwGPuVwfQk8wbMK8ly54m3C5sQ6JsSpXX29uPuar3pZ+
         7QV5k9okYsUQCa5Bt6VHqlzpeooAn7dGfBQzM/K4CMX2o5SS+kqKkRU3qaJrkApROrBP
         nzUquLDllNYsBVUSJ0i86T9/wG3iLqFxzA+8Yms1Yg383fiOyyNwgUN5g+gvO6xnWqQI
         uUBIsi0vESqpO+Ne7QzqWdnPu76Df4N5wSlYAMUFktLcp0tcOOIH+1I/b+9Dr5WouxZB
         M0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzipOJr47iPyvNOfdx8GYLYk05XSaCbDGO47K+hsrnU=;
        b=DJX9oQVmCaxhtY1pWl47GIOa8w4qGK/QdjIEm7ga9GqSzPWve7MpCYWXFewqRc+1tC
         TiVA23fZKWgPeI5/hMGXSuNHWDc7OS/1y4Ai3l/FVQHzQNmTyfb/swqq6u17i0rvhzTh
         qi0WzevZ4vg7K/lqi5b9+3NtCvpFcGP9JtoLo4VH3bhE499OFqglRao7djAkHmkDGOBT
         jaqABO6/1yMFAtUBWQ4caXo5JFYlspnzgkpSOtbcV2VDUvFuYSjRFsWcRVTUO1OYrFx7
         pNeMPicpod2xZQZXaV2NhdS847EbguuxmblPY85kDZt7Y7u7i69M3MlQiN4MXuJXZwt1
         Zzxw==
X-Gm-Message-State: AO0yUKWZCG9VLstfMLwr8Tt+Ycn+r3jchgrSHKDpSQbIKmSGsb1JKJeH
        mzWCCML94DYlMGWj4Nb5JsJKY38iGBs=
X-Google-Smtp-Source: AK7set+UfQxT1ByYG5gxTrPAx10B3c33e//+TWdxq7KGBm8uEG9MN/JJlOQsmvMOixyWSM4AujaeQg==
X-Received: by 2002:a17:903:1107:b0:196:191b:6b22 with SMTP id n7-20020a170903110700b00196191b6b22mr18692731plh.59.1674859624044;
        Fri, 27 Jan 2023 14:47:04 -0800 (PST)
Received: from mariner-vm.. ([131.107.8.90])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902c28200b00188fadb71ecsm3373012pld.16.2023.01.27.14.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 14:47:03 -0800 (PST)
From:   Dave Thaler <dthaler1968@googlemail.com>
To:     bpf@vger.kernel.org
Cc:     bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH bpf-next v4] bpf, docs: Use consistent names for the same field
Date:   Fri, 27 Jan 2023 22:45:55 +0000
Message-Id: <20230127224555.916-1-dthaler1968@googlemail.com>
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

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
V3 -> V4: per David Vernet, minimize column widths

V2 -> V3: per David Vernet, added bolding and updated terms for reg numbers

V1 -> V2: addressed comments from Alexei and Stanislav
---
 Documentation/bpf/instruction-set.rst | 113 ++++++++++++++++++--------
 1 file changed, 77 insertions(+), 36 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 2d3fe59bd26..c1c17ee60ec 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -30,20 +30,56 @@ Instruction encoding
 eBPF has two instruction encodings:
 
 * the basic instruction encoding, which uses 64 bits to encode an instruction
-* the wide instruction encoding, which appends a second 64-bit immediate value
-  (imm64) after the basic instruction for a total of 128 bits.
+* the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
+  constant) value after the basic instruction for a total of 128 bits.
 
-The basic instruction encoding looks as follows:
+The basic instruction encoding is as follows, where MSB and LSB mean the most significant
+bits and least significant bits, respectively:
 
-=============  =======  ===============  ====================  ============
-32 bits (MSB)  16 bits  4 bits           4 bits                8 bits (LSB)
-=============  =======  ===============  ====================  ============
-immediate      offset   source register  destination register  opcode
-=============  =======  ===============  ====================  ============
+=============  =======  =======  =======  ============
+32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
+=============  =======  =======  =======  ============
+imm            offset   src_reg  dst_reg  opcode
+=============  =======  =======  =======  ============
+
+**imm**
+  signed integer immediate value
+
+**offset**
+  signed integer offset used with pointer arithmetic
+
+**src_reg**
+  the source register number (0-10), except where otherwise specified
+  (`64-bit immediate instructions`_ reuse this field for other purposes)
+
+**dst_reg**
+  destination register number (0-10)
+
+**opcode**
+  operation to perform
 
 Note that most instructions do not use all of the fields.
 Unused fields shall be cleared to zero.
 
+As discussed below in `64-bit immediate instructions`_, a 64-bit immediate
+instruction uses a 64-bit immediate value that is constructed as follows.
+The 64 bits following the basic instruction contain a pseudo instruction
+using the same format but with opcode, dst_reg, src_reg, and offset all set to zero,
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
 Instruction classes
 -------------------
 
@@ -71,27 +107,32 @@ For arithmetic and jump instructions (``BPF_ALU``, ``BPF_ALU64``, ``BPF_JMP`` an
 ==============  ======  =================
 4 bits (MSB)    1 bit   3 bits (LSB)
 ==============  ======  =================
-operation code  source  instruction class
+code            source  instruction class
 ==============  ======  =================
 
-The 4th bit encodes the source operand:
+**code**
+  the operation code, whose meaning varies by instruction class
 
-  ======  =====  ========================================
-  source  value  description
-  ======  =====  ========================================
-  BPF_K   0x00   use 32-bit immediate as source operand
-  BPF_X   0x08   use 'src_reg' register as source operand
-  ======  =====  ========================================
+**source**
+  the source operand location, which unless otherwise specified is one of:
 
-The four MSB bits store the operation code.
+  ======  =====  ==============================================
+  source  value  description
+  ======  =====  ==============================================
+  BPF_K   0x00   use 32-bit 'imm' value as source operand
+  BPF_X   0x08   use 'src_reg' register value as source operand
+  ======  =====  ==============================================
 
+**instruction class**
+  the instruction class (see `Instruction classes`_)
 
 Arithmetic instructions
 -----------------------
 
 ``BPF_ALU`` uses 32-bit wide operands while ``BPF_ALU64`` uses 64-bit wide operands for
 otherwise identical operations.
-The 'code' field encodes the operation as below:
+The 'code' field encodes the operation as below, where 'src' and 'dst' refer
+to the values of the source and destination registers, respectively.
 
 ========  =====  ==========================================================
 code      value  description
@@ -121,19 +162,19 @@ the destination register is unchanged whereas for ``BPF_ALU`` the upper
 
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
@@ -167,11 +208,11 @@ Examples:
 
 ``BPF_ALU | BPF_TO_LE | BPF_END`` with imm = 16 means::
 
-  dst_reg = htole16(dst_reg)
+  dst = htole16(dst)
 
 ``BPF_ALU | BPF_TO_BE | BPF_END`` with imm = 64 means::
 
-  dst_reg = htobe64(dst_reg)
+  dst = htobe64(dst)
 
 Jump instructions
 -----------------
@@ -246,15 +287,15 @@ instructions that transfer data between a register and memory.
 
 ``BPF_MEM | <size> | BPF_STX`` means::
 
-  *(size *) (dst_reg + off) = src_reg
+  *(size *) (dst + offset) = src
 
 ``BPF_MEM | <size> | BPF_ST`` means::
 
-  *(size *) (dst_reg + off) = imm32
+  *(size *) (dst + offset) = imm32
 
 ``BPF_MEM | <size> | BPF_LDX`` means::
 
-  dst_reg = *(size *) (src_reg + off)
+  dst = *(size *) (src + offset)
 
 Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
 
@@ -288,11 +329,11 @@ BPF_XOR   0xa0   atomic xor
 
 ``BPF_ATOMIC | BPF_W  | BPF_STX`` with 'imm' = BPF_ADD means::
 
-  *(u32 *)(dst_reg + off16) += src_reg
+  *(u32 *)(dst + offset) += src
 
 ``BPF_ATOMIC | BPF_DW | BPF_STX`` with 'imm' = BPF ADD means::
 
-  *(u64 *)(dst_reg + off16) += src_reg
+  *(u64 *)(dst + offset) += src
 
 In addition to the simple atomic operations, there also is a modifier and
 two complex atomic operations:
@@ -307,16 +348,16 @@ BPF_CMPXCHG  0xf0 | BPF_FETCH  atomic compare and exchange
 
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
@@ -329,7 +370,7 @@ There is currently only one such instruction.
 
 ``BPF_LD | BPF_DW | BPF_IMM`` means::
 
-  dst_reg = imm64
+  dst = imm64
 
 
 Legacy BPF Packet access instructions
-- 
2.33.4

