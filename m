Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655205F4C2D
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 00:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiJDWsA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 18:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiJDWr5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 18:47:57 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115196D54B
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 15:47:55 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id u21so8715544pfc.13
        for <bpf@vger.kernel.org>; Tue, 04 Oct 2022 15:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pcq7LQDEQMeB4QJFWLJpYIlYLaWbcR5+P3/qDqWc1Go=;
        b=daVUH4+TUkZ84hnr52XrS3s/eS0xj18mfNmbagDASm5c61dbDbAlqc/ZbXZokjAL+B
         wNEDFAdaBN8FmiJ2RYsfkX6uERgxonO5HUzZrb9GcWE3inw1vEa+/HLW+A+YfAq+IA1v
         GkKzAL4sccHPZ193FQp+sciuR1ru+lXRRSvuLnpR+T3orjB0Le+fjpbN8B0I53Joge9/
         JXVboC1zldFJwSw9+C5qSi9iMOKv4x/SmnMlkntpuXJskv31v1YZ87c0q0h7fkI44hZI
         o3AEeiMU7BauAfKGzda3sVi/ilwciv+268IswDcUeeXsQvUZ4WU5fnDv8m1S2MwDnbkk
         Xu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pcq7LQDEQMeB4QJFWLJpYIlYLaWbcR5+P3/qDqWc1Go=;
        b=C4i3c5XFdfT7mbfzD4KbD+kfp2CB/eI/7FWd3KqL7MXY43rgZQUc3fkRV7/dmCZRsC
         pkbfFcTi/Vwl9re0QlJ45a3vmUw3TwHcJc6209s720fh4lwMBm7i26IrD8H7TkJgBI8c
         C21OSFZHfd63Cy3craENTpJm/QO51mJHvsjmwg953tTgRynqxnitRAz1K9IyfVaQz7kw
         RrMUpYYSdKVSjO4Jwiw2wThDnVEyVELSXB7K5QlSBgSL53xvGfTBUgUns38MkB/Exqed
         eMPyfp2qD8d7abLo0Bz94HC2QhLRNfBDmeerJRjvhcQ1M/csHYlyGPy4/EJgfOi44bZ4
         PkNw==
X-Gm-Message-State: ACrzQf1X5XO7WExOUw81xfykX1yAmzxPaYkMDqDMb28WESXR+dkpO/IV
        ki8RudK5gWhEZpTKfLO7k70LPgPgwu4=
X-Google-Smtp-Source: AMsMyM5ZJyvkOkP1D+d126Cdblu8mgpY1+xqbTEeUvENDidozRMkaxXb6/T5hKLsJ3lIJlmKC0wXOQ==
X-Received: by 2002:a63:85c8:0:b0:458:778:c35a with SMTP id u191-20020a6385c8000000b004580778c35amr1091479pgd.362.1664923674309;
        Tue, 04 Oct 2022 15:47:54 -0700 (PDT)
Received: from mariner-vm.. ([131.107.174.139])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b0016c0eb202a5sm9487369plg.225.2022.10.04.15.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 15:47:53 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 6/9] bpf, docs: Improve English readability
Date:   Tue,  4 Oct 2022 22:47:42 +0000
Message-Id: <20221004224745.1430-6-dthaler1968@googlemail.com>
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

Improve English readability

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 110 +++++++++++++++++---------
 Documentation/bpf/linux-notes.rst     |   5 ++
 2 files changed, 77 insertions(+), 38 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 7c1e245df..4d5a506be 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -7,6 +7,9 @@ eBPF Instruction Set Specification, v1.0
 
 This document specifies version 1.0 of the eBPF instruction set.
 
+The eBPF instruction set consists of eleven 64 bit registers, a program counter,
+and an implementation-specific amount (e.g., 512 bytes) of stack space.
+
 Documentation conventions
 =========================
 
@@ -27,12 +30,24 @@ The eBPF calling convention is defined as:
 * R6 - R9: callee saved registers that function calls will preserve
 * R10: read-only frame pointer to access stack
 
-R0 - R5 are scratch registers and eBPF programs needs to spill/fill them if
-necessary across calls.
+Registers R0 - R5 are caller-saved registers, meaning the BPF program needs to either
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
@@ -65,7 +80,7 @@ opcode
   operation to perform
 
 Note that most instructions do not use all of the fields.
-Unused fields shall be cleared to zero.
+Unused fields must be set to zero.
 
 As discussed below in `64-bit immediate instructions`_, a 64-bit immediate
 instruction uses a 64-bit immediate value that is constructed as follows.
@@ -92,7 +107,9 @@ and destination registers, respectively, rather than the register number.
 Instruction classes
 -------------------
 
-The three LSB bits of the 'opcode' field store the instruction class:
+The encoding of the 'opcode' field varies and can be determined from
+the three least significant bits (LSB) of the 'opcode' field which holds
+the "instruction class", as follows:
 
 =========  =====  ===============================  ===================================
 class      value  description                      reference
@@ -138,9 +155,11 @@ instruction class
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
@@ -170,21 +189,23 @@ the destination register is instead set to zero.
 If execution would result in modulo by zero,
 the destination register is instead left unchanged.
 
-``BPF_ADD | BPF_X | BPF_ALU`` means::
+Examples:
+
+``BPF_ADD | BPF_X | BPF_ALU`` (0x0c) means::
 
   dst = (u32) (dst + src)
 
 where '(u32)' indicates truncation to 32 bits.
 
-``BPF_ADD | BPF_X | BPF_ALU64`` means::
+``BPF_ADD | BPF_X | BPF_ALU64`` (0x0f) means::
 
   dst = dst + src
 
-``BPF_XOR | BPF_K | BPF_ALU`` means::
+``BPF_XOR | BPF_K | BPF_ALU`` (0xa4) means::
 
   src = (u32) src ^ (u32) imm
 
-``BPF_XOR | BPF_K | BPF_ALU64`` means::
+``BPF_XOR | BPF_K | BPF_ALU64`` (0xa7) means::
 
   src = src ^ imm
 
@@ -202,8 +223,9 @@ The byte swap instructions use an instruction class of ``BPF_ALU`` and a 4-bit
 The byte swap instructions operate on the destination register
 only and do not use a separate source register or immediate value.
 
-The 1-bit source operand field in the opcode is used to to select what byte
-order the operation convert from or to:
+Byte swap instructions use the 1-bit 'source' field in the 'opcode' field
+as follows.  Instead of indicating the source operator, it is instead
+used to select what byte order the operation converts from or to:
 
 =========  =====  =================================================
 source     value  description
@@ -213,24 +235,33 @@ BPF_TO_BE  0x08   convert between host byte order and big endian
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
@@ -251,9 +282,6 @@ BPF_JSLT  0xc0   PC += off if dst < src     signed
 BPF_JSLE  0xd0   PC += off if dst <= src    signed
 ========  =====  =========================  ============
 
-The eBPF program needs to store the return value into register R0 before doing a
-BPF_EXIT.
-
 Helper functions
 ~~~~~~~~~~~~~~~~
 Helper functions are a concept whereby BPF programs can call into a
@@ -283,7 +311,8 @@ For load and store instructions (``BPF_LD``, ``BPF_LDX``, ``BPF_ST``, and ``BPF_
 mode          size    instruction class
 ============  ======  =================
 
-The mode modifier is one of:
+mode
+  one of:
 
   =============  =====  ====================================  =============
   mode modifier  value  description                           reference
@@ -295,7 +324,8 @@ The mode modifier is one of:
   BPF_ATOMIC     0xc0   atomic operations                     `Atomic operations`_
   =============  =====  ====================================  =============
 
-The size modifier is one of:
+size
+  one of:
 
   =============  =====  =====================
   size modifier  value  description
@@ -306,6 +336,9 @@ The size modifier is one of:
   BPF_DW         0x18   double word (8 bytes)
   =============  =====  =====================
 
+instruction class
+  the instruction class (see `Instruction classes`_)
+
 Regular load and store operations
 ---------------------------------
 
@@ -324,7 +357,7 @@ instructions that transfer data between a register and memory.
 
   dst = *(size *) (src + offset)
 
-Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
+where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
 
 Atomic operations
 -----------------
@@ -336,9 +369,11 @@ by other eBPF programs or means outside of this specification.
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
@@ -353,16 +388,15 @@ BPF_AND   0x50   atomic and
 BPF_XOR   0xa0   atomic xor
 ========  =====  ===========
 
-
-``BPF_ATOMIC | BPF_W  | BPF_STX`` with 'imm' = BPF_ADD means::
+``BPF_ATOMIC | BPF_W  | BPF_STX`` (0xc3) with 'imm' = BPF_ADD means::
 
   *(u32 *)(dst + offset) += src
 
-``BPF_ATOMIC | BPF_DW | BPF_STX`` with 'imm' = BPF ADD means::
+``BPF_ATOMIC | BPF_DW | BPF_STX`` (0xdb) with 'imm' = BPF ADD means::
 
   *(u64 *)(dst + offset) += src
 
-In addition to the simple atomic operations, there also is a modifier and
+In addition to the simple atomic operations above, there also is a modifier and
 two complex atomic operations:
 
 ===========  ================  ===========================
diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
index 956b0c866..5860b73ea 100644
--- a/Documentation/bpf/linux-notes.rst
+++ b/Documentation/bpf/linux-notes.rst
@@ -7,6 +7,11 @@ Linux implementation notes
 
 This document provides more details specific to the Linux kernel implementation of the eBPF instruction set.
 
+Stack space
+======================
+
+Linux currently supports 512 bytes of stack space.
+
 Byte swap instructions
 ======================
 
-- 
2.33.4

