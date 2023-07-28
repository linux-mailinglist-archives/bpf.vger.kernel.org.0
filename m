Return-Path: <bpf+bounces-6134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF8C766114
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 03:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302EE282548
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 01:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644E217F3;
	Fri, 28 Jul 2023 01:13:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8877C
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 01:13:48 +0000 (UTC)
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA37430F3
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 18:13:45 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 7955E23C74BA0; Thu, 27 Jul 2023 18:13:42 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>
Cc: David Faust <david.faust@oracle.com>,
	Fangrui Song <maskray@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	bpf@ietf.org
Subject: [PATCH bpf-next v5 17/17] docs/bpf: Add documentation for new instructions
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
	SPF_HELO_PASS,SPF_SOFTFAIL,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
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

diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_=
design_QA.rst
index 38372a956d65..eb19c945f4d5 100644
--- a/Documentation/bpf/bpf_design_QA.rst
+++ b/Documentation/bpf/bpf_design_QA.rst
@@ -140,11 +140,6 @@ A: Because if we picked one-to-one relationship to x=
64 it would have made
 it more complicated to support on arm64 and other archs. Also it
 needs div-by-zero runtime check.
=20
-Q: Why there is no BPF_SDIV for signed divide operation?
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-A: Because it would be rarely used. llvm errors in such case and
-prints a suggestion to use unsigned divide instead.
-
 Q: Why BPF has implicit prologue and epilogue?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 A: Because architectures like sparc have register windows and in general
diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
index 6ef5534b410a..23e880a83a1f 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -154,24 +154,27 @@ otherwise identical operations.
 The 'code' field encodes the operation as below, where 'src' and 'dst' r=
efer
 to the values of the source and destination registers, respectively.
=20
-=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-code      value  description
-=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-BPF_ADD   0x00   dst +=3D src
-BPF_SUB   0x10   dst -=3D src
-BPF_MUL   0x20   dst \*=3D src
-BPF_DIV   0x30   dst =3D (src !=3D 0) ? (dst / src) : 0
-BPF_OR    0x40   dst \|=3D src
-BPF_AND   0x50   dst &=3D src
-BPF_LSH   0x60   dst <<=3D (src & mask)
-BPF_RSH   0x70   dst >>=3D (src & mask)
-BPF_NEG   0x80   dst =3D -dst
-BPF_MOD   0x90   dst =3D (src !=3D 0) ? (dst % src) : dst
-BPF_XOR   0xa0   dst ^=3D src
-BPF_MOV   0xb0   dst =3D src
-BPF_ARSH  0xc0   sign extending dst >>=3D (src & mask)
-BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ bel=
ow)
-=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+code      value  offset   description
+=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+BPF_ADD   0x00   0        dst +=3D src
+BPF_SUB   0x10   0        dst -=3D src
+BPF_MUL   0x20   0        dst \*=3D src
+BPF_DIV   0x30   0        dst =3D (src !=3D 0) ? (dst / src) : 0
+BPF_SDIV  0x30   1        dst =3D (src !=3D 0) ? (dst s/ src) : 0
+BPF_OR    0x40   0        dst \|=3D src
+BPF_AND   0x50   0        dst &=3D src
+BPF_LSH   0x60   0        dst <<=3D (src & mask)
+BPF_RSH   0x70   0        dst >>=3D (src & mask)
+BPF_NEG   0x80   0        dst =3D -dst
+BPF_MOD   0x90   0        dst =3D (src !=3D 0) ? (dst % src) : dst
+BPF_SMOD  0x90   1        dst =3D (src !=3D 0) ? (dst s% src) : dst
+BPF_XOR   0xa0   0        dst ^=3D src
+BPF_MOV   0xb0   0        dst =3D src
+BPF_MOVSX 0xb0   8/16/32  dst =3D (s8,s16,s32)src
+BPF_ARSH  0xc0   0        sign extending dst >>=3D (src & mask)
+BPF_END   0xd0   0        byte swap operations (see `Byte swap instructi=
ons`_ below)
+=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Underflow and overflow are allowed during arithmetic operations, meaning
 the 64-bit or 32-bit value will wrap. If eBPF program execution would
@@ -198,11 +201,20 @@ where '(u32)' indicates that the upper 32 bits are =
zeroed.
=20
   dst =3D dst ^ imm32
=20
-Also note that the division and modulo operations are unsigned. Thus, fo=
r
-``BPF_ALU``, 'imm' is first interpreted as an unsigned 32-bit value, whe=
reas
-for ``BPF_ALU64``, 'imm' is first sign extended to 64 bits and the resul=
t
-interpreted as an unsigned 64-bit value. There are no instructions for
-signed division or modulo.
+Note that most instructions have instruction offset of 0. But three inst=
ructions
+(BPF_SDIV, BPF_SMOD, BPF_MOVSX) have non-zero offset.
+
+The devision and modulo operations support both unsigned and signed flav=
ors.
+For unsigned operation (BPF_DIV and BPF_MOD), for ``BPF_ALU``, 'imm' is =
first
+interpreted as an unsigned 32-bit value, whereas for ``BPF_ALU64``, 'imm=
' is
+first sign extended to 64 bits and the result interpreted as an unsigned=
 64-bit
+value.  For signed operation (BPF_SDIV and BPF_SMOD), for ``BPF_ALU``, '=
imm' is
+interpreted as a signed value. For ``BPF_ALU64``, the 'imm' is sign exte=
nded
+from 32 to 64 and interpreted as a signed 64-bit value.
+
+Instruction BPF_MOVSX does move operation with sign extension.
+``BPF_ALU | MOVSX`` sign extendes 8-bit and 16-bit into 32-bit and upper=
 32-bit are zeroed.
+``BPF_ALU64 | MOVSX`` sign extends 8-bit, 16-bit and 32-bit into 64-bit.
=20
 Shift operations use a mask of 0x3F (63) for 64-bit operations and 0x1F =
(31)
 for 32-bit operations.
@@ -210,21 +222,23 @@ for 32-bit operations.
 Byte swap instructions
 ~~~~~~~~~~~~~~~~~~~~~~
=20
-The byte swap instructions use an instruction class of ``BPF_ALU`` and a=
 4-bit
-'code' field of ``BPF_END``.
+The byte swap instructions use instruction classes of ``BPF_ALU`` and ``=
BPF_ALU64``
+and a 4-bit 'code' field of ``BPF_END``.
=20
 The byte swap instructions operate on the destination register
 only and do not use a separate source register or immediate value.
=20
-The 1-bit source operand field in the opcode is used to select what byte
-order the operation convert from or to:
+For ``BPF_ALU``, the 1-bit source operand field in the opcode is used to=
 select what byte
+order the operation convert from or to. For ``BPF_ALU64``, the 1-bit sou=
rce operand
+field in the opcode is not used and must be 0.
=20
-=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-source     value  description
-=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-BPF_TO_LE  0x00   convert between host byte order and little endian
-BPF_TO_BE  0x08   convert between host byte order and big endian
-=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+class      source     value  description
+=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+BPF_ALU    BPF_TO_LE  0x00   convert between host byte order and little =
endian
+BPF_ALU    BPF_TO_BE  0x08   convert between host byte order and big end=
ian
+BPF_ALU64  BPF_TO_LE  0x00   do byte swap unconditionally
+=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 The 'imm' field encodes the width of the swap operations.  The following=
 widths
 are supported: 16, 32 and 64.
@@ -239,6 +253,12 @@ Examples:
=20
   dst =3D htobe64(dst)
=20
+``BPF_ALU64 | BPF_TO_LE | BPF_END`` with imm =3D 16/32/64 means::
+
+  dst =3D bswap16 dst
+  dst =3D bswap32 dst
+  dst =3D bswap64 dst
+
 Jump instructions
 -----------------
=20
@@ -249,7 +269,8 @@ The 'code' field encodes the operation as below:
 =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
 code      value  src  description                                  notes
 =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
-BPF_JA    0x0    0x0  PC +=3D offset                                 BPF=
_JMP only
+BPF_JA    0x0    0x0  PC +=3D offset                                 BPF=
_JMP class
+BPF_JA    0x0    0x0  PC +=3D imm                                    BPF=
_JMP32 class
 BPF_JEQ   0x1    any  PC +=3D offset if dst =3D=3D src
 BPF_JGT   0x2    any  PC +=3D offset if dst > src                    uns=
igned
 BPF_JGE   0x3    any  PC +=3D offset if dst >=3D src                   u=
nsigned
@@ -278,6 +299,16 @@ Example:
=20
 where 's>=3D' indicates a signed '>=3D' comparison.
=20
+``BPF_JA | BPF_K | BPF_JMP32`` (0x06) means::
+
+  gotol +imm
+
+where 'imm' means the branch offset comes from insn 'imm' field.
+
+Note there are two flavors of BPF_JA instrions. BPF_JMP class permits 16=
-bit jump offset while
+BPF_JMP32 permits 32-bit jump offset. A >16bit conditional jmp can be co=
nverted to a <16bit
+conditional jmp plus a 32-bit unconditional jump.
+
 Helper functions
 ~~~~~~~~~~~~~~~~
=20
@@ -320,6 +351,7 @@ The mode modifier is one of:
   BPF_ABS        0x20   legacy BPF packet access (absolute)   `Legacy BP=
F Packet access instructions`_
   BPF_IND        0x40   legacy BPF packet access (indirect)   `Legacy BP=
F Packet access instructions`_
   BPF_MEM        0x60   regular load and store operations     `Regular l=
oad and store operations`_
+  BPF_MEMSX      0x80   sign-extension load operations        `Sign-exte=
nsion load operations`_
   BPF_ATOMIC     0xc0   atomic operations                     `Atomic op=
erations`_
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
@@ -350,9 +382,20 @@ instructions that transfer data between a register a=
nd memory.
=20
 ``BPF_MEM | <size> | BPF_LDX`` means::
=20
-  dst =3D *(size *) (src + offset)
+  dst =3D *(unsigned size *) (src + offset)
+
+Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW`` and
+'unsigned size' is one of u8, u16, u32 and u64.
+
+The ``BPF_MEMSX`` mode modifier is used to encode sign-extension load
+instructions that transfer data between a register and memory.
+
+``BPF_MEMSX | <size> | BPF_LDX`` means::
+
+  dst =3D *(signed size *) (src + offset)
=20
-Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
+Where size is one of: ``BPF_B``, ``BPF_H`` or ``BPF_W``, and
+'signed size' is one of s8, s16 and s32.
=20
 Atomic operations
 -----------------
--=20
2.34.1


