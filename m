Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9466B5ECC8C
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 21:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiI0TAZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 15:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiI0TAX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 15:00:23 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325C01591C7
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:22 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s26so10214918pgv.7
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=x0B5em+oByRfQ8P2Ax3jaMNoRGrlSl6+p6th4z5ktMk=;
        b=ZwPeY/zBK/Gg+tuhI6c1rLfyy9RlUw5HHrewot8Akje3fjkbLPFaVqClT38bR/EOgU
         KSKnQBAVIF0cpdmKmMQVYYknq8wPI9NNgLpIhmL1yNazHJIFGv/Em75GI2kdGITZm6sN
         2iEIq6XXfg/oRQ/s5fucQlvJxMUtT2nWKqneoSeeMubetAt2fQV4Lmk67tehYY13Mp07
         kEMP2GB0uclOdqc4Yd2U93jyzLmuhFfee+DtBzW8RkvLCbzkYZlFMVcMqmSoWodw0uo5
         F0C6yvHNPBddHl7W9PgtSo+W13eUrRSZrzjKRJLhCzx2anGeisb0KTM1clK74i1jK4ar
         PfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=x0B5em+oByRfQ8P2Ax3jaMNoRGrlSl6+p6th4z5ktMk=;
        b=RhnQGCwsozKrUf/TywNtTNfdLbwNCdkKkjXeBchPiqsXHd0yRubwXlXvrJcde7EsiQ
         8R7oy4EEsADzBsbBtGRUXLSFNIhdyNo+0ces7NWiP5Qi/T3GsUEfIKjnT70yZOg2/J0j
         QmDe/4B5zA526iqI969OI3xE7Wh9PXjYryjJ05o4WeRKlk4LWjPy+6PPRYUad2nPPOrV
         FvM9eGBgQYQRKGwI9XV2H+0h3elRWtjNNVcqU4S+YdvZaH0lgcItgBzVsE9KajBfvHdF
         oOsGHd4bx5IVxUgfER40au1gpC8ZwUvDNaOpXP3djY1B8CJRCGwXVsur636RPmj4E62L
         qgPg==
X-Gm-Message-State: ACrzQf1u6AIRHDv/iTZzc3M1aT/cSh40eaTITG1ed3Q7ahnHMhlLYKS8
        sAqt7hZUsmiNHUfXL8hSPL54oRcjYjY=
X-Google-Smtp-Source: AMsMyM6x144sc8xIDHEO72HVzQXmGO+Xq7vYZeb0uBqcBIzGhZ+WZJaYyYjqi6+KeYHzEFcc66t9JA==
X-Received: by 2002:a63:e105:0:b0:438:b084:78ad with SMTP id z5-20020a63e105000000b00438b08478admr25666503pgh.391.1664305220901;
        Tue, 27 Sep 2022 12:00:20 -0700 (PDT)
Received: from mariner-vm.. ([131.107.1.181])
        by smtp.gmail.com with ESMTPSA id mi9-20020a17090b4b4900b001f8aee0d826sm8737557pjb.53.2022.09.27.12.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:00:20 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 05/15] ebpf-docs: Add TOC and fix formatting
Date:   Tue, 27 Sep 2022 18:59:48 +0000
Message-Id: <20220927185958.14995-5-dthaler1968@googlemail.com>
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
 Documentation/bpf/instruction-set.rst | 268 +++++++++++++-------------
 1 file changed, 136 insertions(+), 132 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 541483118..4997d2088 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -1,7 +1,12 @@
+.. contents::
+.. sectnum::
+
+========================================
+eBPF Instruction Set Specification, v1.0
+========================================
+
+This document specifies version 1.0 of the eBPF instruction set.
 
-====================
-eBPF Instruction Set
-====================
 
 Registers and calling convention
 ================================
@@ -11,10 +16,10 @@ all of which are 64-bits wide.
 
 The eBPF calling convention is defined as:
 
- * R0: return value from function calls, and exit value for eBPF programs
- * R1 - R5: arguments for function calls
- * R6 - R9: callee saved registers that function calls will preserve
- * R10: read-only frame pointer to access stack
+* R0: return value from function calls, and exit value for eBPF programs
+* R1 - R5: arguments for function calls
+* R6 - R9: callee saved registers that function calls will preserve
+* R10: read-only frame pointer to access stack
 
 R0 - R5 are scratch registers and eBPF programs needs to spill/fill them if
 necessary across calls.
@@ -24,17 +29,17 @@ Instruction encoding
 
 eBPF has two instruction encodings:
 
- * the basic instruction encoding, which uses 64 bits to encode an instruction
- * the wide instruction encoding, which appends a second 64-bit immediate value
-   (imm64) after the basic instruction for a total of 128 bits.
+* the basic instruction encoding, which uses 64 bits to encode an instruction
+* the wide instruction encoding, which appends a second 64-bit immediate value
+  (imm64) after the basic instruction for a total of 128 bits.
 
 The basic instruction encoding looks as follows:
 
- =============  =======  ===============  ====================  ============
- 32 bits (MSB)  16 bits  4 bits           4 bits                8 bits (LSB)
- =============  =======  ===============  ====================  ============
- immediate      offset   source register  destination register  opcode
- =============  =======  ===============  ====================  ============
+=============  =======  ===============  ====================  ============
+32 bits (MSB)  16 bits  4 bits           4 bits                8 bits (LSB)
+=============  =======  ===============  ====================  ============
+immediate      offset   source register  destination register  opcode
+=============  =======  ===============  ====================  ============
 
 Note that most instructions do not use all of the fields.
 Unused fields shall be cleared to zero.
@@ -44,30 +49,30 @@ Instruction classes
 
 The three LSB bits of the 'opcode' field store the instruction class:
 
-  =========  =====  ===============================
-  class      value  description
-  =========  =====  ===============================
-  BPF_LD     0x00   non-standard load operations
-  BPF_LDX    0x01   load into register operations
-  BPF_ST     0x02   store from immediate operations
-  BPF_STX    0x03   store from register operations
-  BPF_ALU    0x04   32-bit arithmetic operations
-  BPF_JMP    0x05   64-bit jump operations
-  BPF_JMP32  0x06   32-bit jump operations
-  BPF_ALU64  0x07   64-bit arithmetic operations
-  =========  =====  ===============================
+=========  =====  ===============================  ===================================
+class      value  description                      reference
+=========  =====  ===============================  ===================================
+BPF_LD     0x00   non-standard load operations     `Load and store instructions`_
+BPF_LDX    0x01   load into register operations    `Load and store instructions`_
+BPF_ST     0x02   store from immediate operations  `Load and store instructions`_
+BPF_STX    0x03   store from register operations   `Load and store instructions`_
+BPF_ALU    0x04   32-bit arithmetic operations     `Arithmetic and jump instructions`_
+BPF_JMP    0x05   64-bit jump operations           `Arithmetic and jump instructions`_
+BPF_JMP32  0x06   32-bit jump operations           `Arithmetic and jump instructions`_
+BPF_ALU64  0x07   64-bit arithmetic operations     `Arithmetic and jump instructions`_
+=========  =====  ===============================  ===================================
 
 Arithmetic and jump instructions
 ================================
 
-For arithmetic and jump instructions (BPF_ALU, BPF_ALU64, BPF_JMP and
-BPF_JMP32), the 8-bit 'opcode' field is divided into three parts:
+For arithmetic and jump instructions (``BPF_ALU``, ``BPF_ALU64``, ``BPF_JMP`` and
+``BPF_JMP32``), the 8-bit 'opcode' field is divided into three parts:
 
-  ==============  ======  =================
-  4 bits (MSB)    1 bit   3 bits (LSB)
-  ==============  ======  =================
-  operation code  source  instruction class
-  ==============  ======  =================
+==============  ======  =================
+4 bits (MSB)    1 bit   3 bits (LSB)
+==============  ======  =================
+operation code  source  instruction class
+==============  ======  =================
 
 The 4th bit encodes the source operand:
 
@@ -84,51 +89,51 @@ The four MSB bits store the operation code.
 Arithmetic instructions
 -----------------------
 
-BPF_ALU uses 32-bit wide operands while BPF_ALU64 uses 64-bit wide operands for
+``BPF_ALU`` uses 32-bit wide operands while ``BPF_ALU64`` uses 64-bit wide operands for
 otherwise identical operations.
-The code field encodes the operation as below:
-
-  ========  =====  =================================================
-  code      value  description
-  ========  =====  =================================================
-  BPF_ADD   0x00   dst += src
-  BPF_SUB   0x10   dst -= src
-  BPF_MUL   0x20   dst \*= src
-  BPF_DIV   0x30   dst /= src
-  BPF_OR    0x40   dst \|= src
-  BPF_AND   0x50   dst &= src
-  BPF_LSH   0x60   dst <<= src
-  BPF_RSH   0x70   dst >>= src
-  BPF_NEG   0x80   dst = ~src
-  BPF_MOD   0x90   dst %= src
-  BPF_XOR   0xa0   dst ^= src
-  BPF_MOV   0xb0   dst = src
-  BPF_ARSH  0xc0   sign extending shift right
-  BPF_END   0xd0   byte swap operations (see separate section below)
-  ========  =====  =================================================
-
-BPF_ADD | BPF_X | BPF_ALU means::
+The 'code' field encodes the operation as below:
+
+========  =====  ==========================================================
+code      value  description
+========  =====  ==========================================================
+BPF_ADD   0x00   dst += src
+BPF_SUB   0x10   dst -= src
+BPF_MUL   0x20   dst \*= src
+BPF_DIV   0x30   dst /= src
+BPF_OR    0x40   dst \|= src
+BPF_AND   0x50   dst &= src
+BPF_LSH   0x60   dst <<= src
+BPF_RSH   0x70   dst >>= src
+BPF_NEG   0x80   dst = ~src
+BPF_MOD   0x90   dst %= src
+BPF_XOR   0xa0   dst ^= src
+BPF_MOV   0xb0   dst = src
+BPF_ARSH  0xc0   sign extending shift right
+BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
+========  =====  ==========================================================
+
+``BPF_ADD | BPF_X | BPF_ALU`` means::
 
   dst_reg = (u32) dst_reg + (u32) src_reg;
 
-BPF_ADD | BPF_X | BPF_ALU64 means::
+``BPF_ADD | BPF_X | BPF_ALU64`` means::
 
   dst_reg = dst_reg + src_reg
 
-BPF_XOR | BPF_K | BPF_ALU means::
+``BPF_XOR | BPF_K | BPF_ALU`` means::
 
   src_reg = (u32) src_reg ^ (u32) imm32
 
-BPF_XOR | BPF_K | BPF_ALU64 means::
+``BPF_XOR | BPF_K | BPF_ALU64`` means::
 
   src_reg = src_reg ^ imm32
 
 
 Byte swap instructions
-----------------------
+~~~~~~~~~~~~~~~~~~~~~~
 
 The byte swap instructions use an instruction class of ``BPF_ALU`` and a 4-bit
-code field of ``BPF_END``.
+'code' field of ``BPF_END``.
 
 The byte swap instructions operate on the destination register
 only and do not use a separate source register or immediate value.
@@ -136,14 +141,14 @@ only and do not use a separate source register or immediate value.
 The 1-bit source operand field in the opcode is used to to select what byte
 order the operation convert from or to:
 
-  =========  =====  =================================================
-  source     value  description
-  =========  =====  =================================================
-  BPF_TO_LE  0x00   convert between host byte order and little endian
-  BPF_TO_BE  0x08   convert between host byte order and big endian
-  =========  =====  =================================================
+=========  =====  =================================================
+source     value  description
+=========  =====  =================================================
+BPF_TO_LE  0x00   convert between host byte order and little endian
+BPF_TO_BE  0x08   convert between host byte order and big endian
+=========  =====  =================================================
 
-The imm field encodes the width of the swap operations.  The following widths
+The 'imm' field encodes the width of the swap operations.  The following widths
 are supported: 16, 32 and 64.
 
 Examples:
@@ -159,28 +164,28 @@ Examples:
 Jump instructions
 -----------------
 
-BPF_JMP32 uses 32-bit wide operands while BPF_JMP uses 64-bit wide operands for
+``BPF_JMP32`` uses 32-bit wide operands while ``BPF_JMP`` uses 64-bit wide operands for
 otherwise identical operations.
-The code field encodes the operation as below:
-
-  ========  =====  =========================  ============
-  code      value  description                notes
-  ========  =====  =========================  ============
-  BPF_JA    0x00   PC += off                  BPF_JMP only
-  BPF_JEQ   0x10   PC += off if dst == src
-  BPF_JGT   0x20   PC += off if dst > src     unsigned
-  BPF_JGE   0x30   PC += off if dst >= src    unsigned
-  BPF_JSET  0x40   PC += off if dst & src
-  BPF_JNE   0x50   PC += off if dst != src
-  BPF_JSGT  0x60   PC += off if dst > src     signed
-  BPF_JSGE  0x70   PC += off if dst >= src    signed
-  BPF_CALL  0x80   function call
-  BPF_EXIT  0x90   function / program return  BPF_JMP only
-  BPF_JLT   0xa0   PC += off if dst < src     unsigned
-  BPF_JLE   0xb0   PC += off if dst <= src    unsigned
-  BPF_JSLT  0xc0   PC += off if dst < src     signed
-  BPF_JSLE  0xd0   PC += off if dst <= src    signed
-  ========  =====  =========================  ============
+The 'code' field encodes the operation as below:
+
+========  =====  =========================  ============
+code      value  description                notes
+========  =====  =========================  ============
+BPF_JA    0x00   PC += off                  BPF_JMP only
+BPF_JEQ   0x10   PC += off if dst == src
+BPF_JGT   0x20   PC += off if dst > src     unsigned
+BPF_JGE   0x30   PC += off if dst >= src    unsigned
+BPF_JSET  0x40   PC += off if dst & src
+BPF_JNE   0x50   PC += off if dst != src
+BPF_JSGT  0x60   PC += off if dst > src     signed
+BPF_JSGE  0x70   PC += off if dst >= src    signed
+BPF_CALL  0x80   function call
+BPF_EXIT  0x90   function / program return  BPF_JMP only
+BPF_JLT   0xa0   PC += off if dst < src     unsigned
+BPF_JLE   0xb0   PC += off if dst <= src    unsigned
+BPF_JSLT  0xc0   PC += off if dst < src     signed
+BPF_JSLE  0xd0   PC += off if dst <= src    signed
+========  =====  =========================  ============
 
 The eBPF program needs to store the return value into register R0 before doing a
 BPF_EXIT.
@@ -189,14 +194,26 @@ BPF_EXIT.
 Load and store instructions
 ===========================
 
-For load and store instructions (BPF_LD, BPF_LDX, BPF_ST and BPF_STX), the
+For load and store instructions (``BPF_LD``, ``BPF_LDX``, ``BPF_ST``, and ``BPF_STX``), the
 8-bit 'opcode' field is divided as:
 
-  ============  ======  =================
-  3 bits (MSB)  2 bits  3 bits (LSB)
-  ============  ======  =================
-  mode          size    instruction class
-  ============  ======  =================
+============  ======  =================
+3 bits (MSB)  2 bits  3 bits (LSB)
+============  ======  =================
+mode          size    instruction class
+============  ======  =================
+
+The mode modifier is one of:
+
+  =============  =====  ====================================  =============
+  mode modifier  value  description                           reference
+  =============  =====  ====================================  =============
+  BPF_IMM        0x00   64-bit immediate instructions         `64-bit immediate instructions`_
+  BPF_ABS        0x20   legacy BPF packet access (absolute)   `Legacy BPF Packet access instructions`_
+  BPF_IND        0x40   legacy BPF packet access (indirect)   `Legacy BPF Packet access instructions`_
+  BPF_MEM        0x60   regular load and store operations     `Regular load and store operations`_
+  BPF_ATOMIC     0xc0   atomic operations                     `Atomic operations`_
+  =============  =====  ====================================  =============
 
 The size modifier is one of:
 
@@ -209,19 +226,6 @@ The size modifier is one of:
   BPF_DW         0x18   double word (8 bytes)
   =============  =====  =====================
 
-The mode modifier is one of:
-
-  =============  =====  ====================================
-  mode modifier  value  description
-  =============  =====  ====================================
-  BPF_IMM        0x00   64-bit immediate instructions
-  BPF_ABS        0x20   legacy BPF packet access (absolute)
-  BPF_IND        0x40   legacy BPF packet access (indirect)
-  BPF_MEM        0x60   regular load and store operations
-  BPF_ATOMIC     0xc0   atomic operations
-  =============  =====  ====================================
-
-
 Regular load and store operations
 ---------------------------------
 
@@ -252,42 +256,42 @@ by other eBPF programs or means outside of this specification.
 All atomic operations supported by eBPF are encoded as store operations
 that use the ``BPF_ATOMIC`` mode modifier as follows:
 
-  * ``BPF_ATOMIC | BPF_W | BPF_STX`` for 32-bit operations
-  * ``BPF_ATOMIC | BPF_DW | BPF_STX`` for 64-bit operations
-  * 8-bit and 16-bit wide atomic operations are not supported.
+* ``BPF_ATOMIC | BPF_W | BPF_STX`` for 32-bit operations
+* ``BPF_ATOMIC | BPF_DW | BPF_STX`` for 64-bit operations
+* 8-bit and 16-bit wide atomic operations are not supported.
 
-The imm field is used to encode the actual atomic operation.
+The 'imm' field is used to encode the actual atomic operation.
 Simple atomic operation use a subset of the values defined to encode
-arithmetic operations in the imm field to encode the atomic operation:
+arithmetic operations in the 'imm' field to encode the atomic operation:
 
-  ========  =====  ===========
-  imm       value  description
-  ========  =====  ===========
-  BPF_ADD   0x00   atomic add
-  BPF_OR    0x40   atomic or
-  BPF_AND   0x50   atomic and
-  BPF_XOR   0xa0   atomic xor
-  ========  =====  ===========
+========  =====  ===========
+imm       value  description
+========  =====  ===========
+BPF_ADD   0x00   atomic add
+BPF_OR    0x40   atomic or
+BPF_AND   0x50   atomic and
+BPF_XOR   0xa0   atomic xor
+========  =====  ===========
 
 
-``BPF_ATOMIC | BPF_W  | BPF_STX`` with imm = BPF_ADD means::
+``BPF_ATOMIC | BPF_W  | BPF_STX`` with 'imm' = BPF_ADD means::
 
   *(u32 *)(dst_reg + off16) += src_reg
 
-``BPF_ATOMIC | BPF_DW | BPF_STX`` with imm = BPF ADD means::
+``BPF_ATOMIC | BPF_DW | BPF_STX`` with 'imm' = BPF ADD means::
 
   *(u64 *)(dst_reg + off16) += src_reg
 
 In addition to the simple atomic operations, there also is a modifier and
 two complex atomic operations:
 
-  ===========  ================  ===========================
-  imm          value             description
-  ===========  ================  ===========================
-  BPF_FETCH    0x01              modifier: return old value
-  BPF_XCHG     0xe0 | BPF_FETCH  atomic exchange
-  BPF_CMPXCHG  0xf0 | BPF_FETCH  atomic compare and exchange
-  ===========  ================  ===========================
+===========  ================  ===========================
+imm          value             description
+===========  ================  ===========================
+BPF_FETCH    0x01              modifier: return old value
+BPF_XCHG     0xe0 | BPF_FETCH  atomic exchange
+BPF_CMPXCHG  0xf0 | BPF_FETCH  atomic compare and exchange
+===========  ================  ===========================
 
 The ``BPF_FETCH`` modifier is optional for simple atomic operations, and
 always set for the complex atomic operations.  If the ``BPF_FETCH`` flag
@@ -306,7 +310,7 @@ and loaded back to ``R0``.
 64-bit immediate instructions
 -----------------------------
 
-Instructions with the ``BPF_IMM`` mode modifier use the wide instruction
+Instructions with the ``BPF_IMM`` 'mode' modifier use the wide instruction
 encoding for an extra imm64 value.
 
 There is currently only one such instruction.
-- 
2.33.4

