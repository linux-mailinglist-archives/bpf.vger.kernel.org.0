Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA0C5F4C2A
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 00:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiJDWrz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 18:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiJDWrx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 18:47:53 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370516D543
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 15:47:52 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id c7so13849579pgt.11
        for <bpf@vger.kernel.org>; Tue, 04 Oct 2022 15:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=jcX2mJ3fFojEo2hfaxGiaRqzWuPlP1L0U3++56+JvDo=;
        b=D//wAtQBjlQMiDgnfHg/NO3Od/RZ0+P8XSy4F61jts5Libcp3uKN21QTA2858vil1x
         dGX8y9fKLPsIycuRWR1f5Hj62qYVJCAn5F7CG9zzoFMaWIXB/MVpugyMzP8oscOmrk/B
         t2zHqFbuU2h0rx41Oi4S1ip8tmZab03KCR1RZy02vGRK8zTf3/zRuwOfNIplIPZvkAXN
         41WI6rJJLniqkZHyErr6cZ4OyEXJ7z+rP//uCvLAhaXiuJ83lvvB4YmsatByYmDcQDjb
         k31PM3BTb7wzhlknhVXkStbkWQKD1A8Kukdg2+4pHnX5jFFt51aG14UXtk5T6KsImh8C
         lzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jcX2mJ3fFojEo2hfaxGiaRqzWuPlP1L0U3++56+JvDo=;
        b=g3nUJU3mANUDn4r2hRt/ZNEKKLD5poJnzYLSAw7CssLxT2s5QzAw7cWpgc5C6wy5Wy
         O9TiSx1bcm58MDMHdH9DkOYRUHqb4FRZXOFFTIcD6Hbid783nVzj/IhxVdN64KElm/uN
         qubcE6WuBhLR+pn6pFFvKRTilAEE3TnM9J/CDrUSHT9SUhmWzJt106w+Gih+ugnRyhoY
         fEXUtoD+Bo6Q2FX1oYBuJ0Lpjn1H1uP4bNSjkY0I2C2/eR/omFf4peDgJefY2ZJyikqU
         J6AEkt5fdc/JM/8gLc0GfN1C1H7jb0SVqv+ytvAhC/RIbwT/zICDqp8NZl2x3SlQx7ra
         eQzQ==
X-Gm-Message-State: ACrzQf0jz5UZEfvjQjQLyqkhTTUae/XDI+K8FQpD628w9f59riaRcZF1
        2uJB6112y7GJ24lb8f1BVCiHk6Olw0c=
X-Google-Smtp-Source: AMsMyM5slwPyWrR25T7+GVKnEaZUdOnoIjRPY/4FITs5w2Q9VZy1jpzdrNUlIyEzSPKC8NgFl45BBg==
X-Received: by 2002:a05:6a00:8d0:b0:53b:2cbd:fab6 with SMTP id s16-20020a056a0008d000b0053b2cbdfab6mr29733774pfu.3.1664923671138;
        Tue, 04 Oct 2022 15:47:51 -0700 (PDT)
Received: from mariner-vm.. ([131.107.174.139])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b0016c0eb202a5sm9487369plg.225.2022.10.04.15.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 15:47:50 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 3/9] bpf, docs: Use consistent names for the same field
Date:   Tue,  4 Oct 2022 22:47:39 +0000
Message-Id: <20221004224745.1430-3-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
In-Reply-To: <20221004224745.1430-1-dthaler1968@googlemail.com>
References: <20221004224745.1430-1-dthaler1968@googlemail.com>
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

Use consistent names for the same field

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 107 ++++++++++++++++++--------
 1 file changed, 76 insertions(+), 31 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 3a64d4b49..29b599c70 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -35,20 +35,59 @@ Instruction encoding
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
+  imm64 = imm + (next_imm << 32)
+
+where 'next_imm' refers to the imm value of the pseudo instruction
+following the basic instruction.
+
+In the remainder of this document 'src' and 'dst' refer to the values of the source
+and destination registers, respectively, rather than the register number.
+
 Instruction classes
 -------------------
 
@@ -76,20 +115,24 @@ For arithmetic and jump instructions (``BPF_ALU``, ``BPF_ALU64``, ``BPF_JMP`` an
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
@@ -117,6 +160,8 @@ BPF_ARSH  0xc0   sign extending shift right
 BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
 ========  =====  ==========================================================
 
+where 'src' is the source operand value.
+
 Underflow and overflow are allowed during arithmetic operations,
 meaning the 64-bit or 32-bit value will wrap.  If
 eBPF program execution would result in division by zero,
@@ -126,21 +171,21 @@ the destination register is instead left unchanged.
 
 ``BPF_ADD | BPF_X | BPF_ALU`` means::
 
-  dst_reg = (u32) dst_reg + (u32) src_reg;
+  dst = (u32) (dst + src)
 
 where '(u32)' indicates truncation to 32 bits.
 
 ``BPF_ADD | BPF_X | BPF_ALU64`` means::
 
-  dst_reg = dst_reg + src_reg
+  dst = dst + src
 
 ``BPF_XOR | BPF_K | BPF_ALU`` means::
 
-  src_reg = (u32) src_reg ^ (u32) imm32
+  src = (u32) src ^ (u32) imm
 
 ``BPF_XOR | BPF_K | BPF_ALU64`` means::
 
-  src_reg = src_reg ^ imm32
+  src = src ^ imm
 
 Also note that the division and modulo operations are unsigned,
 where 'imm' is first sign extended to 64 bits and then converted
@@ -173,11 +218,11 @@ Examples:
 
 ``BPF_ALU | BPF_TO_LE | BPF_END`` with imm = 16 means::
 
-  dst_reg = htole16(dst_reg)
+  dst = htole16(dst)
 
 ``BPF_ALU | BPF_TO_BE | BPF_END`` with imm = 64 means::
 
-  dst_reg = htobe64(dst_reg)
+  dst = htobe64(dst)
 
 Jump instructions
 -----------------
@@ -252,15 +297,15 @@ instructions that transfer data between a register and memory.
 
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
 
@@ -294,11 +339,11 @@ BPF_XOR   0xa0   atomic xor
 
 ``BPF_ATOMIC | BPF_W  | BPF_STX`` with 'imm' = BPF_ADD means::
 
-  *(u32 *)(dst_reg + off16) += src_reg
+  *(u32 *)(dst + offset) += src
 
 ``BPF_ATOMIC | BPF_DW | BPF_STX`` with 'imm' = BPF ADD means::
 
-  *(u64 *)(dst_reg + off16) += src_reg
+  *(u64 *)(dst + offset) += src
 
 In addition to the simple atomic operations, there also is a modifier and
 two complex atomic operations:
@@ -313,16 +358,16 @@ BPF_CMPXCHG  0xf0 | BPF_FETCH  atomic compare and exchange
 
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
@@ -335,7 +380,7 @@ There is currently only one such instruction.
 
 ``BPF_LD | BPF_DW | BPF_IMM`` means::
 
-  dst_reg = imm64
+  dst = imm64
 
 
 Legacy BPF Packet access instructions
-- 
2.33.4

