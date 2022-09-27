Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E7A5ECC90
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 21:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiI0TAc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 15:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiI0TA2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 15:00:28 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A041616F6
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:24 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id c7so10194237pgt.11
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Nw/t2m0f2c5hznJWzaS3i9UGa9/OhuZEG5rlsTXfrlU=;
        b=WDHeQJayoPlcLIAT0PwGLYL28nQ0MlFQ5Prv+X60Be5lkQaSB5Oo/iVR5dwKkQ5qV+
         iQR8Ca2xUL/L9dHMxE7slcRCWLMhE60d7GKz8NPXwiTNDN3IhviVwK6Rqjwdg1l4ti5a
         9TQospcDvME7NwiFeQl3IxeGtSjjEkI1Dx3FHvIbj818L0GE3KXixqlxvra6pe/68rh1
         QZBht+yW3dvSBhG/rJ+WbG6q0TRYaBldecbICX4f4z+iFgkDaefefNmD4lAQuJQ571y9
         0yNalVeofJ8zxDRd9K8eVmRhOCs+WI86wFWpEkIt5kauQa1QoBC0/crmixUN1/kuK4jo
         N2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Nw/t2m0f2c5hznJWzaS3i9UGa9/OhuZEG5rlsTXfrlU=;
        b=Z1gAm7amFti5CzSxs/FKBulecOBz58r/VhzURdElH4eKXXbn05S7kX9rPDT85LRUdU
         saaeOVUQtXuha+ugtAeih8utTDnWUWWgYNnI0IZsDRxyHr4lNqiVjQaY6y5G8hgmJasX
         bfPpXHQhY4I5xDggubbTZgltsghtWA6lgvSJ766S9ovIlwboBd182/rPBZF1XVWaNuVU
         h/Ti8pp9btn24D3RHH2bt6hXhAI4n6uO3jiYkBHKuR+f/sD4sdEhTvxxIgWNYm445FZB
         Zn55P21ZiO5eFHXPTe5pWGkNkuLbIGisXLMqV9gc0/lMLNR8zYbg4FrUC6Epa0bkgGZI
         SyRw==
X-Gm-Message-State: ACrzQf0Mi4C2OKHscejmJxj8Ix5mVm4VGIOSDLFLq35njdC2MidWnbQI
        44b6T2PH/mFpspMM80SA/cEkiEudRsA=
X-Google-Smtp-Source: AMsMyM4rB6rKe31qH8AwaR3lYQWw49W9XWM7CtjjSwe3zGLOo3mSBy9uTfh+DH48YJ/vCYbWvZWmbg==
X-Received: by 2002:a63:9d06:0:b0:43a:5cf5:1204 with SMTP id i6-20020a639d06000000b0043a5cf51204mr25449929pgd.557.1664305223538;
        Tue, 27 Sep 2022 12:00:23 -0700 (PDT)
Received: from mariner-vm.. ([131.107.1.181])
        by smtp.gmail.com with ESMTPSA id mi9-20020a17090b4b4900b001f8aee0d826sm8737557pjb.53.2022.09.27.12.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:00:23 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 08/15] ebpf-docs: Use consistent names for the same field
Date:   Tue, 27 Sep 2022 18:59:51 +0000
Message-Id: <20220927185958.14995-8-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
In-Reply-To: <20220927185958.14995-1-dthaler1968@googlemail.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
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

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 107 ++++++++++++++++++--------
 1 file changed, 76 insertions(+), 31 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 3c5a63612..2987234eb 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -34,20 +34,59 @@ Instruction encoding
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
 
+As discussed below in `64-bit immediate instructions`_, some
+instructions use a 64-bit immediate value that is constructed as follows.
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
 
@@ -75,20 +114,24 @@ For arithmetic and jump instructions (``BPF_ALU``, ``BPF_ALU64``, ``BPF_JMP`` an
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
@@ -116,6 +159,8 @@ BPF_ARSH  0xc0   sign extending shift right
 BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
 ========  =====  ==========================================================
 
+where 'src' is the source operand value.
+
 Underflow and overflow are allowed during arithmetic operations,
 meaning the 64-bit or 32-bit value will wrap.  If
 eBPF program execution would result in division by zero,
@@ -125,21 +170,21 @@ the destination register is instead left unchanged.
 
 ``BPF_ADD | BPF_X | BPF_ALU`` means::
 
-  dst_reg = (uint32_t) dst_reg + (uint32_t) src_reg;
+  dst = (uint32_t) (dst + src)
 
 where '(uint32_t)' indicates truncation to 32 bits.
 
 ``BPF_ADD | BPF_X | BPF_ALU64`` means::
 
-  dst_reg = dst_reg + src_reg
+  dst = dst + src
 
 ``BPF_XOR | BPF_K | BPF_ALU`` means::
 
-  src_reg = (uint32_t) src_reg ^ (uint32_t) imm32
+  src = (uint32_t) src ^ (uint32_t) imm
 
 ``BPF_XOR | BPF_K | BPF_ALU64`` means::
 
-  src_reg = src_reg ^ imm32
+  src = src ^ imm
 
 
 Also note that the modulo operation often varies by language
@@ -176,11 +221,11 @@ Examples:
 
 ``BPF_ALU | BPF_TO_LE | BPF_END`` with imm = 16 means::
 
-  dst_reg = htole16(dst_reg)
+  dst = htole16(dst)
 
 ``BPF_ALU | BPF_TO_BE | BPF_END`` with imm = 64 means::
 
-  dst_reg = htobe64(dst_reg)
+  dst = htobe64(dst)
 
 Jump instructions
 -----------------
@@ -255,15 +300,15 @@ instructions that transfer data between a register and memory.
 
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
 
@@ -297,11 +342,11 @@ BPF_XOR   0xa0   atomic xor
 
 ``BPF_ATOMIC | BPF_W  | BPF_STX`` with 'imm' = BPF_ADD means::
 
-  *(uint32_t *)(dst_reg + off16) += src_reg
+  *(uint32_t *)(dst + offset) += src
 
 ``BPF_ATOMIC | BPF_DW | BPF_STX`` with 'imm' = BPF ADD means::
 
-  *(uint32_t *)(dst_reg + off16) += src_reg
+  *(uint64_t *)(dst + offset) += src
 
 In addition to the simple atomic operations, there also is a modifier and
 two complex atomic operations:
@@ -316,16 +361,16 @@ BPF_CMPXCHG  0xf0 | BPF_FETCH  atomic compare and exchange
 
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
@@ -338,7 +383,7 @@ There is currently only one such instruction.
 
 ``BPF_LD | BPF_DW | BPF_IMM`` means::
 
-  dst_reg = imm64
+  dst = imm64
 
 
 Legacy BPF Packet access instructions
-- 
2.33.4

