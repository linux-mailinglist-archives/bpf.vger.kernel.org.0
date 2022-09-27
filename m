Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003685ECC97
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 21:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiI0TA7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 15:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiI0TAr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 15:00:47 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBA91BB20F
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:29 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d11so9895710pll.8
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=D9LaGrytoWd6kVpBouFet7qELPwaLytRzvtxPO5gDAM=;
        b=nYcMmuElMVbadBLaeXmyQ12CdEphsQSgAVdWwFw/LSyFN1ARewL9xFMuu3cDGBj8bn
         9pMhOZ1IkSKtrQCw1098VHd3EbSESOxHPtY/Lxu8r4uapzliMV+NyQQUZ2fNyXZZ4ese
         HE7bh/NOS79Kg6RpnS29HwHatZy0NPfwe+UIi+pbAw0bjI6ipCnuf0/x6IArk27fJWkk
         oyyCql97RhgyV/dvZRNw44c9rvkGpXh+MA+5HXoFeSXvN57FiSgD7Vw4P3F7db1axYSB
         G3wl4qMMFwJkLYbhcP0i3dqJ12JklcSZlCaF6NiKsCXFgsNSCAl8h/02AfEdtDP1RWqv
         kqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=D9LaGrytoWd6kVpBouFet7qELPwaLytRzvtxPO5gDAM=;
        b=bRgn5h2m+OemwMAcIBiR1/6C+j+7qHkAxwey6BK1+m5ZVH3vJxEwQp/1VJmF/m4LcN
         QtUZqBYr0d7isjgOoLofqvu1N4n+6+WecEfKAeIqtl83QOvHMVyZejxZ9WqY9p/4JhvX
         8PK2UKFtzVpCfk6TIb7ezsYKOfmqwW0xMOha2itwcE/E6XdIqFTzRhI6dRHhwDuATKV3
         uEmtQPFS9JIytbPE05QGompGF89pGkvexDUZYRKAeZTdtoYcWr6wBOE9frMFUZ/xWPjI
         Ih+aeJgQTRKc8e46lsVtWP4iqenOEGKfH1FDNR4DOxp7sEG79azTYJnpdw10YyUIrCgr
         Ndag==
X-Gm-Message-State: ACrzQf2IsyuzAAiYvPgjaSKQH3wjzNrpAKQ3DvEHeB+fXBtORwXMrlsh
        qJUlfWfTDEN1kwWUuL0NzCNsRIkGxSo=
X-Google-Smtp-Source: AMsMyM5FK8sovL9Yn9kiJN85XR1G/uwE/UhzXU/JZzezs66MooiMC/aprfq5N34z6wVrg+2kX3ZUNQ==
X-Received: by 2002:a17:902:d4cb:b0:178:6e81:35b7 with SMTP id o11-20020a170902d4cb00b001786e8135b7mr28927611plg.108.1664305227788;
        Tue, 27 Sep 2022 12:00:27 -0700 (PDT)
Received: from mariner-vm.. ([131.107.1.181])
        by smtp.gmail.com with ESMTPSA id mi9-20020a17090b4b4900b001f8aee0d826sm8737557pjb.53.2022.09.27.12.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:00:27 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 11/15] ebpf-docs: Improve English readability
Date:   Tue, 27 Sep 2022 18:59:54 +0000
Message-Id: <20220927185958.14995-11-dthaler1968@googlemail.com>
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
 Documentation/bpf/instruction-set.rst | 137 ++++++++++++++++----------
 1 file changed, 87 insertions(+), 50 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index b6f098104..328207ff6 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -7,6 +7,9 @@ eBPF Instruction Set Specification, v1.0
 
 This document specifies version 1.0 of the eBPF instruction set.
 
+The eBPF instruction set consists of eleven 64 bit registers, a program counter,
+and 512 bytes of stack space.
+
 Documentation conventions
 =========================
 
@@ -25,12 +28,24 @@ The eBPF calling convention is defined as:
 * R6 - R9: callee saved registers that function calls will preserve
 * R10: read-only frame pointer to access stack
 
-R0 - R5 are scratch registers and eBPF programs needs to spill/fill them if
-necessary across calls.
+Registers R0 - R5 are scratch registers, meaning the BPF program needs to either
+spill them to the BPF stack or move them to callee saved registers if these
+arguments are to be reused across multiple function calls. Spilling means
+that the value in the register is moved to the BPF stack. The reverse operation
+of moving the variable from the BPF stack to the register is called filling.
+The reason for spilling/filling is due to the limited number of registers.
+
+Upon entering execution of an eBPF program, registers R1 - R5 initially can contain
+the input arguments for the program (similar to the argc/argv pair for a typical C program).
+The actual number of registers used, and their meaning, is defined by the program type;
+for example, a networking program might have an argument that includes network packet data
+and/or metadata.
 
 Instruction encoding
 ====================
 
+An eBPF program is a sequence of instructions.
+
 eBPF has two instruction encodings:
 
 * the basic instruction encoding, which uses 64 bits to encode an instruction
@@ -63,7 +78,7 @@ opcode
   operation to perform
 
 Note that most instructions do not use all of the fields.
-Unused fields shall be cleared to zero.
+Unused fields must be set to zero.
 
 As discussed below in `64-bit immediate instructions`_, some
 instructions use a 64-bit immediate value that is constructed as follows.
@@ -90,7 +105,9 @@ and destination registers, respectively, rather than the register number.
 Instruction classes
 -------------------
 
-The three LSB bits of the 'opcode' field store the instruction class:
+The encoding of the 'opcode' field varies and can be determined from
+the three least significant bits (LSB) of the 'opcode' field which holds
+the "instruction class", as follows:
 
 =========  =====  ===============================  ===================================
 class      value  description                      reference
@@ -136,9 +153,11 @@ instruction class
 Arithmetic instructions
 -----------------------
 
-``BPF_ALU`` uses 32-bit wide operands while ``BPF_ALU64`` uses 64-bit wide operands for
+Instruction class ``BPF_ALU`` uses 32-bit wide operands (zeroing the upper 32 bits
+of the destination register) while ``BPF_ALU64`` uses 64-bit wide operands for
 otherwise identical operations.
-The 'code' field encodes the operation as below:
+
+The 4-bit 'code' field encodes the operation as follows:
 
 ========  =====  ==========================================================
 code      value  description
@@ -168,21 +187,23 @@ the destination register is instead set to zero.
 If execution would result in modulo by zero,
 the destination register is instead left unchanged.
 
-``BPF_ADD | BPF_X | BPF_ALU`` means::
+Examples:
+
+``BPF_ADD | BPF_X | BPF_ALU`` (0x0c) means::
 
   dst = (uint32_t) (dst + src)
 
 where '(uint32_t)' indicates truncation to 32 bits.
 
-``BPF_ADD | BPF_X | BPF_ALU64`` means::
+``BPF_ADD | BPF_X | BPF_ALU64`` (0x0f) means::
 
   dst = dst + src
 
-``BPF_XOR | BPF_K | BPF_ALU`` means::
+``BPF_XOR | BPF_K | BPF_ALU`` (0xa4) means::
 
   src = (uint32_t) src ^ (uint32_t) imm
 
-``BPF_XOR | BPF_K | BPF_ALU64`` means::
+``BPF_XOR | BPF_K | BPF_ALU64`` (0xa7) means::
 
   src = src ^ imm
 
@@ -204,8 +225,9 @@ The byte swap instructions use an instruction class of ``BPF_ALU`` and a 4-bit
 The byte swap instructions operate on the destination register
 only and do not use a separate source register or immediate value.
 
-The 1-bit source operand field in the opcode is used to to select what byte
-order the operation convert from or to:
+Byte swap instructions use non-default semantics of the 1-bit 'source' field in
+the 'opcode' field.  Instead of indicating the source operator, it is instead
+used to select what byte order the operation converts from or to:
 
 =========  =====  =================================================
 source     value  description
@@ -215,24 +237,33 @@ BPF_TO_BE  0x08   convert between host byte order and big endian
 =========  =====  =================================================
 
 The 'imm' field encodes the width of the swap operations.  The following widths
-are supported: 16, 32 and 64.
-
-Examples:
-
-``BPF_ALU | BPF_TO_LE | BPF_END`` with imm = 16 means::
-
-  dst = htole16(dst)
-
-``BPF_ALU | BPF_TO_BE | BPF_END`` with imm = 64 means::
-
-  dst = htobe64(dst)
+are supported: 16, 32 and 64. The following table summarizes the resulting
+possibilities:
+
+=============================  =========  ===  ========  ==================
+opcode construction            opcode     imm  mnemonic  pseudocode
+=============================  =========  ===  ========  ==================
+BPF_END | BPF_TO_LE | BPF_ALU  0xd4       16   le16 dst  dst = htole16(dst)
+BPF_END | BPF_TO_LE | BPF_ALU  0xd4       32   le32 dst  dst = htole32(dst)
+BPF_END | BPF_TO_LE | BPF_ALU  0xd4       64   le64 dst  dst = htole64(dst)
+BPF_END | BPF_TO_BE | BPF_ALU  0xdc       16   be16 dst  dst = htobe16(dst)
+BPF_END | BPF_TO_BE | BPF_ALU  0xdc       32   be32 dst  dst = htobe32(dst)
+BPF_END | BPF_TO_BE | BPF_ALU  0xdc       64   be64 dst  dst = htobe64(dst)
+=============================  =========  ===  ========  ==================
+
+where
+
+* mnenomic indicates a short form that might be displayed by some tools such as disassemblers
+* 'htoleNN()' indicates converting a NN-bit value from host byte order to little-endian byte order
+* 'htobeNN()' indicates converting a NN-bit value from host byte order to big-endian byte order
 
 Jump instructions
 -----------------
 
-``BPF_JMP32`` uses 32-bit wide operands while ``BPF_JMP`` uses 64-bit wide operands for
+Instruction class ``BPF_JMP32`` uses 32-bit wide operands while ``BPF_JMP`` uses 64-bit wide operands for
 otherwise identical operations.
-The 'code' field encodes the operation as below:
+
+The 4-bit 'code' field encodes the operation as below, where PC is the program counter:
 
 ========  =====  =========================  ============
 code      value  description                notes
@@ -253,9 +284,6 @@ BPF_JSLT  0xc0   PC += off if dst < src     signed
 BPF_JSLE  0xd0   PC += off if dst <= src    signed
 ========  =====  =========================  ============
 
-The eBPF program needs to store the return value into register R0 before doing a
-BPF_EXIT.
-
 Helper functions
 ~~~~~~~~~~~~~~~~
 Helper functions are a concept whereby BPF programs can call into a
@@ -285,7 +313,8 @@ For load and store instructions (``BPF_LD``, ``BPF_LDX``, ``BPF_ST``, and ``BPF_
 mode          size    instruction class
 ============  ======  =================
 
-The mode modifier is one of:
+mode
+  one of:
 
   =============  =====  ====================================  =============
   mode modifier  value  description                           reference
@@ -297,7 +326,8 @@ The mode modifier is one of:
   BPF_ATOMIC     0xc0   atomic operations                     `Atomic operations`_
   =============  =====  ====================================  =============
 
-The size modifier is one of:
+size
+  one of:
 
   =============  =====  =====================
   size modifier  value  description
@@ -308,25 +338,31 @@ The size modifier is one of:
   BPF_DW         0x18   double word (8 bytes)
   =============  =====  =====================
 
+instruction class
+  the instruction class (see `Instruction classes`_)
+
 Regular load and store operations
 ---------------------------------
 
 The ``BPF_MEM`` mode modifier is used to encode regular load and store
 instructions that transfer data between a register and memory.
 
-``BPF_MEM | <size> | BPF_STX`` means::
-
-  *(size *) (dst + offset) = src_reg
-
-``BPF_MEM | <size> | BPF_ST`` means::
-
-  *(size *) (dst + offset) = imm32
-
-``BPF_MEM | <size> | BPF_LDX`` means::
-
-  dst = *(size *) (src + offset)
-
-Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
+=============================  =========  ====================================
+opcode construction            opcode     pseudocode
+=============================  =========  ====================================
+BPF_MEM | BPF_B | BPF_LDX      0x71       dst = \*(uint8_t \*) (src + offset)
+BPF_MEM | BPF_H | BPF_LDX      0x69       dst = \*(uint16_t \*) (src + offset)
+BPF_MEM | BPF_W | BPF_LDX      0x61       dst = \*(uint32_t \*) (src + offset)
+BPF_MEM | BPF_DW | BPF_LDX     0x79       dst = \*(uint64_t \*) (src + offset)
+BPF_MEM | BPF_B | BPF_ST       0x72       \*(uint8_t \*) (dst + offset) = imm
+BPF_MEM | BPF_H | BPF_ST       0x6a       \*(uint16_t \*) (dst + offset) = imm
+BPF_MEM | BPF_W | BPF_ST       0x62       \*(uint32_t \*) (dst + offset) = imm
+BPF_MEM | BPF_DW | BPF_ST      0x7a       \*(uint64_t \*) (dst + offset) = imm
+BPF_MEM | BPF_B | BPF_STX      0x73       \*(uint8_t \*) (dst + offset) = src
+BPF_MEM | BPF_H | BPF_STX      0x6b       \*(uint16_t \*) (dst + offset) = src
+BPF_MEM | BPF_W | BPF_STX      0x63       \*(uint32_t \*) (dst + offset) = src
+BPF_MEM | BPF_DW | BPF_STX     0x7b       \*(uint64_t \*) (dst + offset) = src
+=============================  =========  ====================================
 
 Atomic operations
 -----------------
@@ -338,9 +374,11 @@ by other eBPF programs or means outside of this specification.
 All atomic operations supported by eBPF are encoded as store operations
 that use the ``BPF_ATOMIC`` mode modifier as follows:
 
-* ``BPF_ATOMIC | BPF_W | BPF_STX`` for 32-bit operations
-* ``BPF_ATOMIC | BPF_DW | BPF_STX`` for 64-bit operations
-* 8-bit and 16-bit wide atomic operations are not supported.
+* ``BPF_ATOMIC | BPF_W | BPF_STX`` (0xc3) for 32-bit operations
+* ``BPF_ATOMIC | BPF_DW | BPF_STX`` (0xdb) for 64-bit operations
+
+Note that 8-bit (``BPF_B``) and 16-bit (``BPF_H``) wide atomic operations are not supported,
+nor is ``BPF_ATOMIC | <size> | BPF_ST``.
 
 The 'imm' field is used to encode the actual atomic operation.
 Simple atomic operation use a subset of the values defined to encode
@@ -355,16 +393,15 @@ BPF_AND   0x50   atomic and
 BPF_XOR   0xa0   atomic xor
 ========  =====  ===========
 
-
-``BPF_ATOMIC | BPF_W  | BPF_STX`` with 'imm' = BPF_ADD means::
+``BPF_ATOMIC | BPF_W  | BPF_STX`` (0xc3) with 'imm' = BPF_ADD means::
 
   *(uint32_t *)(dst + offset) += src
 
-``BPF_ATOMIC | BPF_DW | BPF_STX`` with 'imm' = BPF ADD means::
+``BPF_ATOMIC | BPF_DW | BPF_STX`` (0xdb) with 'imm' = BPF ADD means::
 
   *(uint64_t *)(dst + offset) += src
 
-In addition to the simple atomic operations, there also is a modifier and
+In addition to the simple atomic operations above, there also is a modifier and
 two complex atomic operations:
 
 ===========  ================  ===========================
-- 
2.33.4

