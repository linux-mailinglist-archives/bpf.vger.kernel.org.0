Return-Path: <bpf+bounces-6275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805A37678AA
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 00:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD9228274E
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 22:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF6B1FB3F;
	Fri, 28 Jul 2023 22:51:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F5E525C
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 22:51:20 +0000 (UTC)
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA90173F
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 15:51:18 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 6F8CB23D53094; Fri, 28 Jul 2023 15:51:05 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	bpf@ietf.org,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2] docs/bpf: Improve documentation for cpu=v4 instructions
Date: Fri, 28 Jul 2023 15:51:05 -0700
Message-Id: <20230728225105.919595-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
	SPF_HELO_PASS,SPF_SOFTFAIL,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Improve documentation for cpu=3Dv4 instructions based on
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

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
index 23e880a83a1f..fb8154cedd84 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -174,7 +174,7 @@ BPF_MOV   0xb0   0        dst =3D src
 BPF_MOVSX 0xb0   8/16/32  dst =3D (s8,s16,s32)src
 BPF_ARSH  0xc0   0        sign extending dst >>=3D (src & mask)
 BPF_END   0xd0   0        byte swap operations (see `Byte swap instructi=
ons`_ below)
-=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
=20
 Underflow and overflow are allowed during arithmetic operations, meaning
 the 64-bit or 32-bit value will wrap. If eBPF program execution would
@@ -201,26 +201,32 @@ where '(u32)' indicates that the upper 32 bits are =
zeroed.
=20
   dst =3D dst ^ imm32
=20
-Note that most instructions have instruction offset of 0. But three inst=
ructions
-(BPF_SDIV, BPF_SMOD, BPF_MOVSX) have non-zero offset.
+Note that most instructions have instruction offset of 0. Only three ins=
tructions
+(``BPF_SDIV``, ``BPF_SMOD``, ``BPF_MOVSX``) have a non-zero offset.
=20
 The devision and modulo operations support both unsigned and signed flav=
ors.
-For unsigned operation (BPF_DIV and BPF_MOD), for ``BPF_ALU``, 'imm' is =
first
-interpreted as an unsigned 32-bit value, whereas for ``BPF_ALU64``, 'imm=
' is
-first sign extended to 64 bits and the result interpreted as an unsigned=
 64-bit
-value.  For signed operation (BPF_SDIV and BPF_SMOD), for ``BPF_ALU``, '=
imm' is
-interpreted as a signed value. For ``BPF_ALU64``, the 'imm' is sign exte=
nded
-from 32 to 64 and interpreted as a signed 64-bit value.
=20
-Instruction BPF_MOVSX does move operation with sign extension.
-``BPF_ALU | MOVSX`` sign extendes 8-bit and 16-bit into 32-bit and upper=
 32-bit are zeroed.
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
=20
 Shift operations use a mask of 0x3F (63) for 64-bit operations and 0x1F =
(31)
 for 32-bit operations.
=20
 Byte swap instructions
-~~~~~~~~~~~~~~~~~~~~~~
+----------------------
=20
 The byte swap instructions use instruction classes of ``BPF_ALU`` and ``=
BPF_ALU64``
 and a 4-bit 'code' field of ``BPF_END``.
@@ -228,16 +234,17 @@ and a 4-bit 'code' field of ``BPF_END``.
 The byte swap instructions operate on the destination register
 only and do not use a separate source register or immediate value.
=20
-For ``BPF_ALU``, the 1-bit source operand field in the opcode is used to=
 select what byte
-order the operation convert from or to. For ``BPF_ALU64``, the 1-bit sou=
rce operand
-field in the opcode is not used and must be 0.
+For ``BPF_ALU``, the 1-bit source operand field in the opcode is used to
+select what byte order the operation converts from or to. For
+``BPF_ALU64``, the 1-bit source operand field in the opcode is reserved
+and must be set to 0.
=20
 =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 class      source     value  description
 =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 BPF_ALU    BPF_TO_LE  0x00   convert between host byte order and little =
endian
 BPF_ALU    BPF_TO_BE  0x08   convert between host byte order and big end=
ian
-BPF_ALU64  BPF_TO_LE  0x00   do byte swap unconditionally
+BPF_ALU64  Reserved   0x00   do byte swap unconditionally
 =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 The 'imm' field encodes the width of the swap operations.  The following=
 widths
@@ -305,9 +312,12 @@ where 's>=3D' indicates a signed '>=3D' comparison.
=20
 where 'imm' means the branch offset comes from insn 'imm' field.
=20
-Note there are two flavors of BPF_JA instrions. BPF_JMP class permits 16=
-bit jump offset while
-BPF_JMP32 permits 32-bit jump offset. A >16bit conditional jmp can be co=
nverted to a <16bit
-conditional jmp plus a 32-bit unconditional jump.
+Note that there are two flavors of ``BPF_JA`` instructions. The
+``BPF_JMP`` class permits a 16-bit jump offset specified by the 'offset'
+field, whereas the ``BPF_JMP32`` class permits a 32-bit jump offset
+specified by the 'imm' field. A > 16-bit conditional jump may be
+converted to a < 16-bit conditional jump plus a 32-bit unconditional
+jump.
=20
 Helper functions
 ~~~~~~~~~~~~~~~~
@@ -385,7 +395,7 @@ instructions that transfer data between a register an=
d memory.
   dst =3D *(unsigned size *) (src + offset)
=20
 Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW`` and
-'unsigned size' is one of u8, u16, u32 and u64.
+'unsigned size' is one of u8, u16, u32 or u64.
=20
 The ``BPF_MEMSX`` mode modifier is used to encode sign-extension load
 instructions that transfer data between a register and memory.
@@ -395,7 +405,7 @@ instructions that transfer data between a register an=
d memory.
   dst =3D *(signed size *) (src + offset)
=20
 Where size is one of: ``BPF_B``, ``BPF_H`` or ``BPF_W``, and
-'signed size' is one of s8, s16 and s32.
+'signed size' is one of s8, s16 or s32.
=20
 Atomic operations
 -----------------
--=20
2.34.1


