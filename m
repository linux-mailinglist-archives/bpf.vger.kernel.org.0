Return-Path: <bpf+bounces-6138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 204EB76611B
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 03:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0C3282550
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 01:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607DE17D2;
	Fri, 28 Jul 2023 01:15:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4DB17D0
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 01:15:33 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ABF30E1
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 18:15:31 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 28116C15256E
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 18:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690506931; bh=cYukfI5WydhD2K/SlxZEnzraGkFsiawrbnNcEnw9xvI=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=AeMsUKEYE1zp8zF6XVkq/FA/iM17X7oQqV0J3c5qKzmvhSe2yMx0jwNJBQFP4nnIE
	 VBj6C3nqg3f3p1ohLbJtvbtxpPBbP7xKvNxnWdCmocTf+Cr/pG2l0z76w1PyIzjBvi
	 OZwaHSni6yLI7vUne50+IRaWViPUoBMTWrBDhdKk=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Jul 27 18:15:30 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id CE2FAC151B02;
	Thu, 27 Jul 2023 18:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690506930; bh=cYukfI5WydhD2K/SlxZEnzraGkFsiawrbnNcEnw9xvI=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=pNtdax/g5q2EWo+U7izI3jWadC6XVGiod0jm4qphqWsmLStZ1KJeoZHKOpP4PS5Ok
	 ZvOH931HN8wzkHNyZPAsUkV3xaERJAQMzeM/vaP6+1jgNXXrsTp2lA7G++RSKuXeAL
	 IJCII0l6HXHlgLE9BjzGJXR3pDV3TU1BaIZ18oBU=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id BB23BC15107B
 for <bpf@ietfa.amsl.com>; Thu, 27 Jul 2023 18:14:00 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -0.261
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mcf1zobLr51q for <bpf@ietfa.amsl.com>;
 Thu, 27 Jul 2023 18:13:56 -0700 (PDT)
Received: from 69-171-232-181.mail-mxout.facebook.com
 (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 13396C151982
 for <bpf@ietf.org>; Thu, 27 Jul 2023 18:13:55 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
 id 7955E23C74BA0; Thu, 27 Jul 2023 18:13:42 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>
Cc: David Faust <david.faust@oracle.com>, Fangrui Song <maskray@google.com>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 bpf@ietf.org
Date: Thu, 27 Jul 2023 18:13:42 -0700
Message-Id: <20230728011342.3724411-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728011143.3710005-1-yonghong.song@linux.dev>
References: <20230728011143.3710005-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/W9OZ1jZVmFsIi2Z5Py9fadYthNE>
Subject: [Bpf] [PATCH bpf-next v5 17/17] docs/bpf: Add documentation for new
 instructions
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add documentation in instruction-set.rst for new instruction encoding
and their corresponding operations. Also removed the question
related to 'no BPF_SDIV' in bpf_design_QA.rst since we have
BPF_SDIV insn now.

Cc: bpf@ietf.org
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 Documentation/bpf/bpf_design_QA.rst           |   5 -
 .../bpf/standardization/instruction-set.rst   | 115 ++++++++++++------
 2 files changed, 79 insertions(+), 41 deletions(-)

diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
index 38372a956d65..eb19c945f4d5 100644
--- a/Documentation/bpf/bpf_design_QA.rst
+++ b/Documentation/bpf/bpf_design_QA.rst
@@ -140,11 +140,6 @@ A: Because if we picked one-to-one relationship to x64 it would have made
 it more complicated to support on arm64 and other archs. Also it
 needs div-by-zero runtime check.
 
-Q: Why there is no BPF_SDIV for signed divide operation?
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-A: Because it would be rarely used. llvm errors in such case and
-prints a suggestion to use unsigned divide instead.
-
 Q: Why BPF has implicit prologue and epilogue?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 A: Because architectures like sparc have register windows and in general
diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 6ef5534b410a..23e880a83a1f 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -154,24 +154,27 @@ otherwise identical operations.
 The 'code' field encodes the operation as below, where 'src' and 'dst' refer
 to the values of the source and destination registers, respectively.
 
-========  =====  ==========================================================
-code      value  description
-========  =====  ==========================================================
-BPF_ADD   0x00   dst += src
-BPF_SUB   0x10   dst -= src
-BPF_MUL   0x20   dst \*= src
-BPF_DIV   0x30   dst = (src != 0) ? (dst / src) : 0
-BPF_OR    0x40   dst \|= src
-BPF_AND   0x50   dst &= src
-BPF_LSH   0x60   dst <<= (src & mask)
-BPF_RSH   0x70   dst >>= (src & mask)
-BPF_NEG   0x80   dst = -dst
-BPF_MOD   0x90   dst = (src != 0) ? (dst % src) : dst
-BPF_XOR   0xa0   dst ^= src
-BPF_MOV   0xb0   dst = src
-BPF_ARSH  0xc0   sign extending dst >>= (src & mask)
-BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
-========  =====  ==========================================================
+========  =====  =======  ==========================================================
+code      value  offset   description
+========  =====  =======  ==========================================================
+BPF_ADD   0x00   0        dst += src
+BPF_SUB   0x10   0        dst -= src
+BPF_MUL   0x20   0        dst \*= src
+BPF_DIV   0x30   0        dst = (src != 0) ? (dst / src) : 0
+BPF_SDIV  0x30   1        dst = (src != 0) ? (dst s/ src) : 0
+BPF_OR    0x40   0        dst \|= src
+BPF_AND   0x50   0        dst &= src
+BPF_LSH   0x60   0        dst <<= (src & mask)
+BPF_RSH   0x70   0        dst >>= (src & mask)
+BPF_NEG   0x80   0        dst = -dst
+BPF_MOD   0x90   0        dst = (src != 0) ? (dst % src) : dst
+BPF_SMOD  0x90   1        dst = (src != 0) ? (dst s% src) : dst
+BPF_XOR   0xa0   0        dst ^= src
+BPF_MOV   0xb0   0        dst = src
+BPF_MOVSX 0xb0   8/16/32  dst = (s8,s16,s32)src
+BPF_ARSH  0xc0   0        sign extending dst >>= (src & mask)
+BPF_END   0xd0   0        byte swap operations (see `Byte swap instructions`_ below)
+========  =====  ============  ==========================================================
 
 Underflow and overflow are allowed during arithmetic operations, meaning
 the 64-bit or 32-bit value will wrap. If eBPF program execution would
@@ -198,11 +201,20 @@ where '(u32)' indicates that the upper 32 bits are zeroed.
 
   dst = dst ^ imm32
 
-Also note that the division and modulo operations are unsigned. Thus, for
-``BPF_ALU``, 'imm' is first interpreted as an unsigned 32-bit value, whereas
-for ``BPF_ALU64``, 'imm' is first sign extended to 64 bits and the result
-interpreted as an unsigned 64-bit value. There are no instructions for
-signed division or modulo.
+Note that most instructions have instruction offset of 0. But three instructions
+(BPF_SDIV, BPF_SMOD, BPF_MOVSX) have non-zero offset.
+
+The devision and modulo operations support both unsigned and signed flavors.
+For unsigned operation (BPF_DIV and BPF_MOD), for ``BPF_ALU``, 'imm' is first
+interpreted as an unsigned 32-bit value, whereas for ``BPF_ALU64``, 'imm' is
+first sign extended to 64 bits and the result interpreted as an unsigned 64-bit
+value.  For signed operation (BPF_SDIV and BPF_SMOD), for ``BPF_ALU``, 'imm' is
+interpreted as a signed value. For ``BPF_ALU64``, the 'imm' is sign extended
+from 32 to 64 and interpreted as a signed 64-bit value.
+
+Instruction BPF_MOVSX does move operation with sign extension.
+``BPF_ALU | MOVSX`` sign extendes 8-bit and 16-bit into 32-bit and upper 32-bit are zeroed.
+``BPF_ALU64 | MOVSX`` sign extends 8-bit, 16-bit and 32-bit into 64-bit.
 
 Shift operations use a mask of 0x3F (63) for 64-bit operations and 0x1F (31)
 for 32-bit operations.
@@ -210,21 +222,23 @@ for 32-bit operations.
 Byte swap instructions
 ~~~~~~~~~~~~~~~~~~~~~~
 
-The byte swap instructions use an instruction class of ``BPF_ALU`` and a 4-bit
-'code' field of ``BPF_END``.
+The byte swap instructions use instruction classes of ``BPF_ALU`` and ``BPF_ALU64``
+and a 4-bit 'code' field of ``BPF_END``.
 
 The byte swap instructions operate on the destination register
 only and do not use a separate source register or immediate value.
 
-The 1-bit source operand field in the opcode is used to select what byte
-order the operation convert from or to:
+For ``BPF_ALU``, the 1-bit source operand field in the opcode is used to select what byte
+order the operation convert from or to. For ``BPF_ALU64``, the 1-bit source operand
+field in the opcode is not used and must be 0.
 
-=========  =====  =================================================
-source     value  description
-=========  =====  =================================================
-BPF_TO_LE  0x00   convert between host byte order and little endian
-BPF_TO_BE  0x08   convert between host byte order and big endian
-=========  =====  =================================================
+=========  =========  =====  =================================================
+class      source     value  description
+=========  =========  =====  =================================================
+BPF_ALU    BPF_TO_LE  0x00   convert between host byte order and little endian
+BPF_ALU    BPF_TO_BE  0x08   convert between host byte order and big endian
+BPF_ALU64  BPF_TO_LE  0x00   do byte swap unconditionally
+=========  =========  =====  =================================================
 
 The 'imm' field encodes the width of the swap operations.  The following widths
 are supported: 16, 32 and 64.
@@ -239,6 +253,12 @@ Examples:
 
   dst = htobe64(dst)
 
+``BPF_ALU64 | BPF_TO_LE | BPF_END`` with imm = 16/32/64 means::
+
+  dst = bswap16 dst
+  dst = bswap32 dst
+  dst = bswap64 dst
+
 Jump instructions
 -----------------
 
@@ -249,7 +269,8 @@ The 'code' field encodes the operation as below:
 ========  =====  ===  ===========================================  =========================================
 code      value  src  description                                  notes
 ========  =====  ===  ===========================================  =========================================
-BPF_JA    0x0    0x0  PC += offset                                 BPF_JMP only
+BPF_JA    0x0    0x0  PC += offset                                 BPF_JMP class
+BPF_JA    0x0    0x0  PC += imm                                    BPF_JMP32 class
 BPF_JEQ   0x1    any  PC += offset if dst == src
 BPF_JGT   0x2    any  PC += offset if dst > src                    unsigned
 BPF_JGE   0x3    any  PC += offset if dst >= src                   unsigned
@@ -278,6 +299,16 @@ Example:
 
 where 's>=' indicates a signed '>=' comparison.
 
+``BPF_JA | BPF_K | BPF_JMP32`` (0x06) means::
+
+  gotol +imm
+
+where 'imm' means the branch offset comes from insn 'imm' field.
+
+Note there are two flavors of BPF_JA instrions. BPF_JMP class permits 16-bit jump offset while
+BPF_JMP32 permits 32-bit jump offset. A >16bit conditional jmp can be converted to a <16bit
+conditional jmp plus a 32-bit unconditional jump.
+
 Helper functions
 ~~~~~~~~~~~~~~~~
 
@@ -320,6 +351,7 @@ The mode modifier is one of:
   BPF_ABS        0x20   legacy BPF packet access (absolute)   `Legacy BPF Packet access instructions`_
   BPF_IND        0x40   legacy BPF packet access (indirect)   `Legacy BPF Packet access instructions`_
   BPF_MEM        0x60   regular load and store operations     `Regular load and store operations`_
+  BPF_MEMSX      0x80   sign-extension load operations        `Sign-extension load operations`_
   BPF_ATOMIC     0xc0   atomic operations                     `Atomic operations`_
   =============  =====  ====================================  =============
 
@@ -350,9 +382,20 @@ instructions that transfer data between a register and memory.
 
 ``BPF_MEM | <size> | BPF_LDX`` means::
 
-  dst = *(size *) (src + offset)
+  dst = *(unsigned size *) (src + offset)
+
+Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW`` and
+'unsigned size' is one of u8, u16, u32 and u64.
+
+The ``BPF_MEMSX`` mode modifier is used to encode sign-extension load
+instructions that transfer data between a register and memory.
+
+``BPF_MEMSX | <size> | BPF_LDX`` means::
+
+  dst = *(signed size *) (src + offset)
 
-Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
+Where size is one of: ``BPF_B``, ``BPF_H`` or ``BPF_W``, and
+'signed size' is one of s8, s16 and s32.
 
 Atomic operations
 -----------------
-- 
2.34.1

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

