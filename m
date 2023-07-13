Return-Path: <bpf+bounces-4939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBC475189F
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 08:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF541C20F83
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 06:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99465685;
	Thu, 13 Jul 2023 06:09:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900B66107
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 06:09:06 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5434A1FF7
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:08:56 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CN0YCI019750
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:08:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=QtYMT+9aKx5m38oCAcI0xc54jX2u5j9iur3N56WuAJc=;
 b=gDVeN8udLUtyxgwobznq+6DGjuDGcwp2qULvXTNVTD7K2yMTeM/78HjXSiKS4F0the9+
 2mCuiJvqaPF+Yz5T0uXuRpSjGRIXRE9RMKvxDuUGiHh822P7UHqmATuM9tpblWaqXPgT
 Bvmr7ksQeeiFgYceeknc0V+bcWpFYKLe6wI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rt5fc25b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:08:55 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Jul 2023 23:08:54 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id B7A4C22EFA4FC; Wed, 12 Jul 2023 23:08:47 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 15/15] docs/bpf: Add documentation for new instructions
Date: Wed, 12 Jul 2023 23:08:47 -0700
Message-ID: <20230713060847.397969-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713060718.388258-1-yhs@fb.com>
References: <20230713060718.388258-1-yhs@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: iCAYe8DpUvbM1hi3KvTRuXynF9ECpweC
X-Proofpoint-GUID: iCAYe8DpUvbM1hi3KvTRuXynF9ECpweC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_03,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add documentation in instruction-set.rst for new instruction encoding
and their corresponding operations. Also removed the question
related to 'no BPF_SDIV' in bpf_design_QA.rst since we have
BPF_SDIV insn now.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 Documentation/bpf/bpf_design_QA.rst           |   5 -
 .../bpf/standardization/instruction-set.rst   | 100 ++++++++++++------
 2 files changed, 66 insertions(+), 39 deletions(-)

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
index 751e657973f0..367f426d09a1 100644
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
-BPF_NEG   0x80   dst =3D -src
-BPF_MOD   0x90   dst =3D (src !=3D 0) ? (dst % src) : dst
-BPF_XOR   0xa0   dst ^=3D src
-BPF_MOV   0xb0   dst =3D src
-BPF_ARSH  0xc0   sign extending dst >>=3D (src & mask)
-BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ bel=
ow)
-=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+code      value  offset value  description
+=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+BPF_ADD   0x00   0             dst +=3D src
+BPF_SUB   0x10   0             dst -=3D src
+BPF_MUL   0x20   0             dst \*=3D src
+BPF_DIV   0x30   0             dst =3D (src !=3D 0) ? (dst / src) : 0
+BPF_SDIV  0x30   1             dst =3D (src !=3D 0) ? (dst s/ src) : 0
+BPF_OR    0x40   0             dst \|=3D src
+BPF_AND   0x50   0             dst &=3D src
+BPF_LSH   0x60   0             dst <<=3D (src & mask)
+BPF_RSH   0x70   0             dst >>=3D (src & mask)
+BPF_NEG   0x80   0             dst =3D -src
+BPF_MOD   0x90   0             dst =3D (src !=3D 0) ? (dst % src) : dst
+BPF_SMOD  0x90   1             dst =3D (src !=3D 0) ? (dst s% src) : dst
+BPF_XOR   0xa0   0             dst ^=3D src
+BPF_MOV   0xb0   0             dst =3D src
+BPF_MOVSX 0xb0   8/16/32       dst =3D (s8,16,s32)src
+BPF_ARSH  0xc0   0             sign extending dst >>=3D (src & mask)
+BPF_END   0xd0   0             byte swap operations (see `Byte swap inst=
ructions`_ below)
+=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Underflow and overflow are allowed during arithmetic operations, meaning
 the 64-bit or 32-bit value will wrap. If eBPF program execution would
@@ -198,11 +201,19 @@ where '(u32)' indicates that the upper 32 bits are =
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
+value.  For signed operation (BPF_SDIV and BPF_SMOD), for both ``BPF_ALU=
`` and
+``BPF_ALU64``, 'imm' is interpreted as a signed value.
+
+Instruction BPF_MOVSX does move operation with sign extension. For ``BPF=
_ALU``
+mode, 8-bit and 16-bit sign extensions to 32-bit are supported. For ``BP=
F_ALU64``,
+8-bit, 16-bit and 32-bit sign extenstions to 64-bit are supported.
=20
 Shift operations use a mask of 0x3F (63) for 64-bit operations and 0x1F =
(31)
 for 32-bit operations.
@@ -210,21 +221,23 @@ for 32-bit operations.
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
+field in the opcode is not used.
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
@@ -239,6 +252,10 @@ Examples:
=20
   dst =3D htobe64(dst)
=20
+``BPF_ALU64 | BPF_TO_LE | BPF_END`` with imm =3D 16 means::
+
+  dst =3D bswap16(dst)
+
 Jump instructions
 -----------------
=20
@@ -249,7 +266,8 @@ The 'code' field encodes the operation as below:
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
@@ -278,6 +296,10 @@ Example:
=20
 where 's>=3D' indicates a signed '>=3D' comparison.
=20
+Note there are two flavors of BPF_JA instrions. BPF_JMP class permits 16=
-bit jump offset while
+BPF_JMP32 permits 32-bit jump offset. A >16bit conditional jmp can be co=
nverted to a <16bit
+conditional jmp plus a 32-bit unconditional jump.
+
 Helper functions
 ~~~~~~~~~~~~~~~~
=20
@@ -320,6 +342,7 @@ The mode modifier is one of:
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
@@ -354,6 +377,15 @@ instructions that transfer data between a register a=
nd memory.
=20
 Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
=20
+The ``BPF_MEMSX`` mode modifier is used to encode sign-extension load
+instructions that transfer data between a register and memory.
+
+``BPF_MEMSX | <size> | BPF_LDX`` means::
+
+  dst =3D *(sign-extension size *) (src + offset)
+
+Where size is one of: ``BPF_B``, ``BPF_H`` or ``BPF_W``.
+
 Atomic operations
 -----------------
=20
--=20
2.34.1


