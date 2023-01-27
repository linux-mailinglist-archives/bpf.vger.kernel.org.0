Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A2C67DC3B
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 03:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjA0CYW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 21:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjA0CYV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 21:24:21 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AC34109C
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 18:24:20 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id m7-20020a17090a71c700b0022c0c070f2eso6543100pjs.4
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 18:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZNNYbD9ItO1QJpNxyoPUadHZnFepcnMSjgdnM1dfUE=;
        b=YdXtyrK3qP/Bq8EgZ4spvKIHijh18VRrZPAnxlF+XJl8q16wOrGA6mV8593W4XV2GO
         Lq2miYacfSvV5p17EIhDbX4HESUuJPkH8iKT2KBNYCq763pAjw51H3DAX8IVpfnscCXQ
         Xl43M3FNWP59QH/MpBieRA1c1m0Ld2EouUVxFPnWzi7BaI+Rmc5/BbUI0/C0GC7amDfF
         sgVpIxU3qIgzFVZXQ22TTgpauTm6uBipacOr2EFJGYDZA9K8hCDPUpevB23MN5eIpFeJ
         if0njtwleoQa1xI+awYIyL2OxWVuwXIHRpZha7Oqw4GY1aXyYK+pVbafg/u5DyufC1D0
         7ZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZNNYbD9ItO1QJpNxyoPUadHZnFepcnMSjgdnM1dfUE=;
        b=1WMxMJ2+eUF083tUukbNbae7l0/6scCg3/gpa7UgWLzIm/DwzhdzvzIWGHZp3fAx6I
         DeYygn0ReBZexhRf166m0NlFy92Un9Oug7vFRKl3mpvJRLSsF4YF4/AAUVk1e3wPOih+
         +kbmrcRyYDqu1NYEh5Ij80OVx9eO8VL3TbdK8MbBJc6yVhm94VJqWR8a0gsaYmBy29fU
         GFajdUhHtJqabw29OW+9DECfZf0AtfFiM+h4nno+7FQtoQYKXxtR9hXEcTyYFbvth3m8
         g5Nkesbu8eBXj1UhdbFgslkzTVhhkieDo102mnPvoaswoYavLgp84DnaOHF9069pt3Cc
         27vg==
X-Gm-Message-State: AO0yUKUsen+fS1rG6N9xsjl32vf8Dpaoyz1H8QIK1EhSZPHutd6FRxz1
        Ox4uy87CgLeAIni4ogiRkS0h6CWm/rs=
X-Google-Smtp-Source: AK7set8Lv8Pt6o4FsyYQZc5qm9pnadiOkdtS3yy52wdeI9y6YJ5AyyjGn19X3hb5JirLTeAqpmpROg==
X-Received: by 2002:a17:903:2312:b0:196:2546:7cdd with SMTP id d18-20020a170903231200b0019625467cddmr10401824plh.38.1674786259281;
        Thu, 26 Jan 2023 18:24:19 -0800 (PST)
Received: from mariner-vm.. ([131.107.8.75])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902e74200b0017f5ad327casm1638010plf.103.2023.01.26.18.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 18:24:18 -0800 (PST)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH] bpf, docs: Use consistent names for the same field
Date:   Fri, 27 Jan 2023 02:24:16 +0000
Message-Id: <20230127022416.1468-1-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
In-Reply-To: <Y9GOiIbWz5mL0nSv@maniforge>
References: <Y9GOiIbWz5mL0nSv@maniforge>
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
V2 -> V3: per David Vernet, added bolding and updated terms for reg numbers

V1 -> V2: addressed comments from Alexei and Stanislav
---
 Documentation/bpf/instruction-set.rst | 105 ++++++++++++++++++--------
 1 file changed, 73 insertions(+), 32 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 2d3fe59bd26..2da47fe4ef8 100644
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
 
 =============  =======  ===============  ====================  ============
 32 bits (MSB)  16 bits  4 bits           4 bits                8 bits (LSB)
 =============  =======  ===============  ====================  ============
-immediate      offset   source register  destination register  opcode
+imm            offset   src_reg          dst_reg               opcode
 =============  =======  ===============  ====================  ============
 
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
+
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

