Return-Path: <bpf+bounces-4277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BAB74A1C4
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 18:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31DBC1C20D3D
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 16:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFADAD43;
	Thu,  6 Jul 2023 16:05:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443E2A941
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 16:05:46 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386AA9D
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 09:05:44 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a3a8d21208so878772b6e.0
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 09:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688659543; x=1691251543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j+4Jh341kpNoAmiWVKSiX9jcGS8WZDzyWPsxDA1eBOY=;
        b=fDDi7/d8ELq4HLrERJGZMLH0ghgJeokPnLMUvmG66gropbLpiRwEqckEMSRQdLN9/6
         Wik7FjecHRHzT5jRjDaOBTY2w9r0blmCW1LYFSTlPO0vgcEJVeBK/4X5xAuoscCIKPBR
         OxpjQIT1/7ZES5ke5HbMPR94ytRKQW4BOCiILUk4R70jk31CGrQ4VAEsKzfryeD9tesR
         nkcorjmQDdrMed8pX2hqJEGdD+eiUMUYHwIrD4PviSiaN2YRdyfeilGIZhUzob19MuMw
         pIeRxa9TeFQeAEc4Unverktb1VZgc6PEXkofI+cuk00ZVuKGOKI7K3Jj+P3TaQvKMzQW
         gEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688659543; x=1691251543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+4Jh341kpNoAmiWVKSiX9jcGS8WZDzyWPsxDA1eBOY=;
        b=a+HOgJYSUox/+FemJfJwVPVUDYrw3JMMgpwS883rV05qPlucY4oXKD95MM4ZxnR6AV
         4wYtZnm/y9mpTy3h0SUbBcmFy9W0PjP+jEFv2mIsuuqqW53jEatIRQdGFiT4EU0wT8ns
         09SyndLqkbLi7NeyhRBdqzyQJ1PXuCISgx2kMMEfEhz8Q2v1NQAM6QC0uX1TT/uY+Bme
         JciOD+RisFf/pDKT0kk/t5H4/V9QlfiOaUiRlle3U9Xmc8/hT13iKcU30+xOMEWGmQGk
         HIzdI3nrnc4Gn7Qee3mtW9AneH+1eRfEcKh/rwgK/Jw/9IuExRIvGhO7H0x5QWIkfKkw
         otng==
X-Gm-Message-State: ABy/qLbuv93pXOx6T/ETpayrG4Aeq1cO+RFHhsoZgXu1uAOsl5poubM5
	3S2VyzKXDp/QO0k8l20tmD9L/kZscfo=
X-Google-Smtp-Source: APBJJlEy+5/MmjdshukP9tlMXXMaYVO8EZQA0LRxZ+CCBE/D2uZPY41XCTTaKlxc8H9OeBrieJCuHg==
X-Received: by 2002:a05:6808:d4a:b0:3a2:43e0:6b10 with SMTP id w10-20020a0568080d4a00b003a243e06b10mr2554637oik.40.1688659543103;
        Thu, 06 Jul 2023 09:05:43 -0700 (PDT)
Received: from mariner-vm.. (c-71-197-160-159.hsd1.wa.comcast.net. [71.197.160.159])
        by smtp.gmail.com with ESMTPSA id j15-20020aa7928f000000b0064aea45b040sm1457810pfa.168.2023.07.06.09.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 09:05:42 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH bpf-next v2] bpf, docs: Improve English readability
Date: Thu,  6 Jul 2023 16:05:37 +0000
Message-Id: <20230706160537.1309-1-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Dave Thaler <dthaler@microsoft.com>

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
--
V1 -> V2: addressed comments from Alexei
---
 Documentation/bpf/instruction-set.rst | 59 ++++++++++++++++++++-------
 Documentation/bpf/linux-notes.rst     |  5 +++
 2 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 751e657973f..740989f4c1e 100644
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
@@ -74,7 +89,7 @@ For example::
   07     1       0        00 00  11 22 33 44  r1 += 0x11223344 // big
 
 Note that most instructions do not use all of the fields.
-Unused fields shall be cleared to zero.
+Unused fields must be set to zero.
 
 As discussed below in `64-bit immediate instructions`_, a 64-bit immediate
 instruction uses a 64-bit immediate value that is constructed as follows.
@@ -103,7 +118,9 @@ instruction are reserved and shall be cleared to zero.
 Instruction classes
 -------------------
 
-The three LSB bits of the 'opcode' field store the instruction class:
+The encoding of the 'opcode' field varies and can be determined from
+the three least significant bits (LSB) of the 'opcode' field which holds
+the "instruction class", as follows:
 
 =========  =====  ===============================  ===================================
 class      value  description                      reference
@@ -149,7 +166,8 @@ code            source  instruction class
 Arithmetic instructions
 -----------------------
 
-``BPF_ALU`` uses 32-bit wide operands while ``BPF_ALU64`` uses 64-bit wide operands for
+Instruction class ``BPF_ALU`` uses 32-bit wide operands (zeroing the upper 32 bits
+of the destination register) while ``BPF_ALU64`` uses 64-bit wide operands for
 otherwise identical operations.
 The 'code' field encodes the operation as below, where 'src' and 'dst' refer
 to the values of the source and destination registers, respectively.
@@ -216,8 +234,9 @@ The byte swap instructions use an instruction class of ``BPF_ALU`` and a 4-bit
 The byte swap instructions operate on the destination register
 only and do not use a separate source register or immediate value.
 
-The 1-bit source operand field in the opcode is used to select what byte
-order the operation convert from or to:
+Byte swap instructions use the 1-bit 'source' field in the 'opcode' field
+as follows.  Instead of indicating the source operator, it is instead
+used to select what byte order the operation converts from or to:
 
 =========  =====  =================================================
 source     value  description
@@ -235,16 +254,21 @@ Examples:
 
   dst = htole16(dst)
 
+where 'htole16()' indicates converting a 16-bit value from host byte order to little-endian byte order.
+
 ``BPF_ALU | BPF_TO_BE | BPF_END`` with imm = 64 means::
 
   dst = htobe64(dst)
 
+where 'htobe64()' indicates converting a 64-bit value from host byte order to big-endian byte order.
+
 Jump instructions
 -----------------
 
-``BPF_JMP32`` uses 32-bit wide operands while ``BPF_JMP`` uses 64-bit wide operands for
+Instruction class ``BPF_JMP32`` uses 32-bit wide operands while ``BPF_JMP`` uses 64-bit wide operands for
 otherwise identical operations.
-The 'code' field encodes the operation as below:
+
+The 4-bit 'code' field encodes the operation as below, where PC is the program counter:
 
 ========  =====  ===  ===========================================  =========================================
 code      value  src  description                                  notes
@@ -311,7 +335,8 @@ For load and store instructions (``BPF_LD``, ``BPF_LDX``, ``BPF_ST``, and ``BPF_
 mode          size    instruction class
 ============  ======  =================
 
-The mode modifier is one of:
+mode
+  one of:
 
   =============  =====  ====================================  =============
   mode modifier  value  description                           reference
@@ -323,7 +348,8 @@ The mode modifier is one of:
   BPF_ATOMIC     0xc0   atomic operations                     `Atomic operations`_
   =============  =====  ====================================  =============
 
-The size modifier is one of:
+size
+  one of:
 
   =============  =====  =====================
   size modifier  value  description
@@ -334,6 +360,9 @@ The size modifier is one of:
   BPF_DW         0x18   double word (8 bytes)
   =============  =====  =====================
 
+instruction class
+  the instruction class (see `Instruction classes`_)
+
 Regular load and store operations
 ---------------------------------
 
@@ -352,7 +381,7 @@ instructions that transfer data between a register and memory.
 
   dst = *(size *) (src + offset)
 
-Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
+where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
 
 Atomic operations
 -----------------
@@ -366,7 +395,9 @@ that use the ``BPF_ATOMIC`` mode modifier as follows:
 
 * ``BPF_ATOMIC | BPF_W | BPF_STX`` for 32-bit operations
 * ``BPF_ATOMIC | BPF_DW | BPF_STX`` for 64-bit operations
-* 8-bit and 16-bit wide atomic operations are not supported.
+
+Note that 8-bit (``BPF_B``) and 16-bit (``BPF_H``) wide atomic operations are not currently supported,
+nor is ``BPF_ATOMIC | <size> | BPF_ST``.
 
 The 'imm' field is used to encode the actual atomic operation.
 Simple atomic operation use a subset of the values defined to encode
@@ -390,7 +421,7 @@ BPF_XOR   0xa0   atomic xor
 
   *(u64 *)(dst + offset) += src
 
-In addition to the simple atomic operations, there also is a modifier and
+In addition to the simple atomic operations above, there also is a modifier and
 two complex atomic operations:
 
 ===========  ================  ===========================
diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
index 508d009d3be..724579fd62d 100644
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


