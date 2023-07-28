Return-Path: <bpf+bounces-6276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F577678AB
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 00:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD361C20A6E
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 22:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AC61FB45;
	Fri, 28 Jul 2023 22:51:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBAF525C
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 22:51:25 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052C219B6
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 15:51:23 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id D00FDC1516F3
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 15:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690584683; bh=0JtXhzL54NtGoz1hN0IL0Q8QPhUr8R8wuX+5Fh72abA=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=SXVxk84mvXOogYTznAQcmBw6II16blJEUqOEDF1o54cZ5zPHqtRT5QOrX0MzO7Ma/
	 ZhoqTeW6qB5ZwWSM62h/FBEZla7Fa1/dM2uQ1eDORWEPaA6YVf+3UjND4U21B75AVw
	 0NKoAbalVeZ+DeQQGUvbaaq7yEozRunpi/lwGiZg=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Jul 28 15:51:23 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id B286FC14CF0D;
	Fri, 28 Jul 2023 15:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690584683; bh=0JtXhzL54NtGoz1hN0IL0Q8QPhUr8R8wuX+5Fh72abA=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=SXVxk84mvXOogYTznAQcmBw6II16blJEUqOEDF1o54cZ5zPHqtRT5QOrX0MzO7Ma/
	 ZhoqTeW6qB5ZwWSM62h/FBEZla7Fa1/dM2uQ1eDORWEPaA6YVf+3UjND4U21B75AVw
	 0NKoAbalVeZ+DeQQGUvbaaq7yEozRunpi/lwGiZg=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id E681CC14CF0D
 for <bpf@ietfa.amsl.com>; Fri, 28 Jul 2023 15:51:22 -0700 (PDT)
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
 with ESMTP id MersXPTsBG5I for <bpf@ietfa.amsl.com>;
 Fri, 28 Jul 2023 15:51:18 -0700 (PDT)
Received: from 66-220-155-178.mail-mxout.facebook.com
 (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 435C4C14CEFF
 for <bpf@ietf.org>; Fri, 28 Jul 2023 15:51:17 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
 id 6F8CB23D53094; Fri, 28 Jul 2023 15:51:05 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf@ietf.org,
 David Vernet <void@manifault.com>
Date: Fri, 28 Jul 2023 15:51:05 -0700
Message-Id: <20230728225105.919595-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/W3s-BT0OYzLxThRNKCsSfAEiVJE>
Subject: [Bpf] [PATCH bpf-next v2] docs/bpf: Improve documentation for
 cpu=v4 instructions
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

Improve documentation for cpu=v4 instructions based on
David's suggestions.

Cc: bpf@ietf.org
Suggested-by: David Vernet <void@manifault.com>
Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/standardization/instruction-set.rst   | 54 +++++++++++--------
 1 file changed, 32 insertions(+), 22 deletions(-)

Changelogs:
  v1 -> v2:
    - Fix a minor grammar.
    - Add David's Ack.

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 23e880a83a1f..fb8154cedd84 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -174,7 +174,7 @@ BPF_MOV   0xb0   0        dst = src
 BPF_MOVSX 0xb0   8/16/32  dst = (s8,s16,s32)src
 BPF_ARSH  0xc0   0        sign extending dst >>= (src & mask)
 BPF_END   0xd0   0        byte swap operations (see `Byte swap instructions`_ below)
-========  =====  ============  ==========================================================
+========  =====  =======  ==========================================================
 
 Underflow and overflow are allowed during arithmetic operations, meaning
 the 64-bit or 32-bit value will wrap. If eBPF program execution would
@@ -201,26 +201,32 @@ where '(u32)' indicates that the upper 32 bits are zeroed.
 
   dst = dst ^ imm32
 
-Note that most instructions have instruction offset of 0. But three instructions
-(BPF_SDIV, BPF_SMOD, BPF_MOVSX) have non-zero offset.
+Note that most instructions have instruction offset of 0. Only three instructions
+(``BPF_SDIV``, ``BPF_SMOD``, ``BPF_MOVSX``) have a non-zero offset.
 
 The devision and modulo operations support both unsigned and signed flavors.
-For unsigned operation (BPF_DIV and BPF_MOD), for ``BPF_ALU``, 'imm' is first
-interpreted as an unsigned 32-bit value, whereas for ``BPF_ALU64``, 'imm' is
-first sign extended to 64 bits and the result interpreted as an unsigned 64-bit
-value.  For signed operation (BPF_SDIV and BPF_SMOD), for ``BPF_ALU``, 'imm' is
-interpreted as a signed value. For ``BPF_ALU64``, the 'imm' is sign extended
-from 32 to 64 and interpreted as a signed 64-bit value.
 
-Instruction BPF_MOVSX does move operation with sign extension.
-``BPF_ALU | MOVSX`` sign extendes 8-bit and 16-bit into 32-bit and upper 32-bit are zeroed.
-``BPF_ALU64 | MOVSX`` sign extends 8-bit, 16-bit and 32-bit into 64-bit.
+For unsigned operations (``BPF_DIV`` and ``BPF_MOD``), for ``BPF_ALU``,
+'imm' is interpreted as a 32-bit unsigned value. For ``BPF_ALU64``,
+'imm' is first sign extended from 32 to 64 bits, and then interpreted as
+a 64-bit unsigned value.
+
+For signed operations (``BPF_SDIV`` and ``BPF_SMOD``), for ``BPF_ALU``,
+'imm' is interpreted as a 32-bit signed value. For ``BPF_ALU64``, 'imm'
+is first sign extended from 32 to 64 bits, and then interpreted as a
+64-bit signed value.
+
+The ``BPF_MOVSX`` instruction does a move operation with sign extension.
+``BPF_ALU | BPF_MOVSX`` sign extends 8-bit and 16-bit operands into 32
+bit operands, and zeroes the remaining upper 32 bits.
+``BPF_ALU64 | BPF_MOVSX`` sign extends 8-bit, 16-bit, and 32-bit
+operands into 64 bit operands.
 
 Shift operations use a mask of 0x3F (63) for 64-bit operations and 0x1F (31)
 for 32-bit operations.
 
 Byte swap instructions
-~~~~~~~~~~~~~~~~~~~~~~
+----------------------
 
 The byte swap instructions use instruction classes of ``BPF_ALU`` and ``BPF_ALU64``
 and a 4-bit 'code' field of ``BPF_END``.
@@ -228,16 +234,17 @@ and a 4-bit 'code' field of ``BPF_END``.
 The byte swap instructions operate on the destination register
 only and do not use a separate source register or immediate value.
 
-For ``BPF_ALU``, the 1-bit source operand field in the opcode is used to select what byte
-order the operation convert from or to. For ``BPF_ALU64``, the 1-bit source operand
-field in the opcode is not used and must be 0.
+For ``BPF_ALU``, the 1-bit source operand field in the opcode is used to
+select what byte order the operation converts from or to. For
+``BPF_ALU64``, the 1-bit source operand field in the opcode is reserved
+and must be set to 0.
 
 =========  =========  =====  =================================================
 class      source     value  description
 =========  =========  =====  =================================================
 BPF_ALU    BPF_TO_LE  0x00   convert between host byte order and little endian
 BPF_ALU    BPF_TO_BE  0x08   convert between host byte order and big endian
-BPF_ALU64  BPF_TO_LE  0x00   do byte swap unconditionally
+BPF_ALU64  Reserved   0x00   do byte swap unconditionally
 =========  =========  =====  =================================================
 
 The 'imm' field encodes the width of the swap operations.  The following widths
@@ -305,9 +312,12 @@ where 's>=' indicates a signed '>=' comparison.
 
 where 'imm' means the branch offset comes from insn 'imm' field.
 
-Note there are two flavors of BPF_JA instrions. BPF_JMP class permits 16-bit jump offset while
-BPF_JMP32 permits 32-bit jump offset. A >16bit conditional jmp can be converted to a <16bit
-conditional jmp plus a 32-bit unconditional jump.
+Note that there are two flavors of ``BPF_JA`` instructions. The
+``BPF_JMP`` class permits a 16-bit jump offset specified by the 'offset'
+field, whereas the ``BPF_JMP32`` class permits a 32-bit jump offset
+specified by the 'imm' field. A > 16-bit conditional jump may be
+converted to a < 16-bit conditional jump plus a 32-bit unconditional
+jump.
 
 Helper functions
 ~~~~~~~~~~~~~~~~
@@ -385,7 +395,7 @@ instructions that transfer data between a register and memory.
   dst = *(unsigned size *) (src + offset)
 
 Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW`` and
-'unsigned size' is one of u8, u16, u32 and u64.
+'unsigned size' is one of u8, u16, u32 or u64.
 
 The ``BPF_MEMSX`` mode modifier is used to encode sign-extension load
 instructions that transfer data between a register and memory.
@@ -395,7 +405,7 @@ instructions that transfer data between a register and memory.
   dst = *(signed size *) (src + offset)
 
 Where size is one of: ``BPF_B``, ``BPF_H`` or ``BPF_W``, and
-'signed size' is one of s8, s16 and s32.
+'signed size' is one of s8, s16 or s32.
 
 Atomic operations
 -----------------
-- 
2.34.1

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

