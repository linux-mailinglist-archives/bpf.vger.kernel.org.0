Return-Path: <bpf+bounces-6335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA957682EE
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 02:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982041C20A70
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 00:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5228D37F;
	Sun, 30 Jul 2023 00:43:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E050376
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 00:43:05 +0000 (UTC)
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8331E5F
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 17:43:03 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 53DF923E3D5EE; Sat, 29 Jul 2023 17:42:51 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	bpf@ietf.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next] docs/bpf: Fix malformed documentation
Date: Sat, 29 Jul 2023 17:42:51 -0700
Message-Id: <20230730004251.381307-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_SOFTFAIL,
	TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Two issues are fixed:
  1. Malformed table due to newly-introduced BPF_MOVSX
  2. Missing reference link for ``Sign-extension load operations``

Fixes: 245d4c40c09b ("docs/bpf: Add documentation for new instructions")
Cc: bpf@ietf.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307291840.Cqhj7uox-lkp@i=
ntel.com/
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/standardization/instruction-set.rst   | 45 ++++++++++---------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
index fb8154cedd84..655494ac7af6 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -154,27 +154,27 @@ otherwise identical operations.
 The 'code' field encodes the operation as below, where 'src' and 'dst' r=
efer
 to the values of the source and destination registers, respectively.
=20
-=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-code      value  offset   description
-=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-BPF_ADD   0x00   0        dst +=3D src
-BPF_SUB   0x10   0        dst -=3D src
-BPF_MUL   0x20   0        dst \*=3D src
-BPF_DIV   0x30   0        dst =3D (src !=3D 0) ? (dst / src) : 0
-BPF_SDIV  0x30   1        dst =3D (src !=3D 0) ? (dst s/ src) : 0
-BPF_OR    0x40   0        dst \|=3D src
-BPF_AND   0x50   0        dst &=3D src
-BPF_LSH   0x60   0        dst <<=3D (src & mask)
-BPF_RSH   0x70   0        dst >>=3D (src & mask)
-BPF_NEG   0x80   0        dst =3D -dst
-BPF_MOD   0x90   0        dst =3D (src !=3D 0) ? (dst % src) : dst
-BPF_SMOD  0x90   1        dst =3D (src !=3D 0) ? (dst s% src) : dst
-BPF_XOR   0xa0   0        dst ^=3D src
-BPF_MOV   0xb0   0        dst =3D src
-BPF_MOVSX 0xb0   8/16/32  dst =3D (s8,s16,s32)src
-BPF_ARSH  0xc0   0        sign extending dst >>=3D (src & mask)
-BPF_END   0xd0   0        byte swap operations (see `Byte swap instructi=
ons`_ below)
-=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+code       value  offset   description
+=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+BPF_ADD    0x00   0        dst +=3D src
+BPF_SUB    0x10   0        dst -=3D src
+BPF_MUL    0x20   0        dst \*=3D src
+BPF_DIV    0x30   0        dst =3D (src !=3D 0) ? (dst / src) : 0
+BPF_SDIV   0x30   1        dst =3D (src !=3D 0) ? (dst s/ src) : 0
+BPF_OR     0x40   0        dst \|=3D src
+BPF_AND    0x50   0        dst &=3D src
+BPF_LSH    0x60   0        dst <<=3D (src & mask)
+BPF_RSH    0x70   0        dst >>=3D (src & mask)
+BPF_NEG    0x80   0        dst =3D -dst
+BPF_MOD    0x90   0        dst =3D (src !=3D 0) ? (dst % src) : dst
+BPF_SMOD   0x90   1        dst =3D (src !=3D 0) ? (dst s% src) : dst
+BPF_XOR    0xa0   0        dst ^=3D src
+BPF_MOV    0xb0   0        dst =3D src
+BPF_MOVSX  0xb0   8/16/32  dst =3D (s8,s16,s32)src
+BPF_ARSH   0xc0   0        sign extending dst >>=3D (src & mask)
+BPF_END    0xd0   0        byte swap operations (see `Byte swap instruct=
ions`_ below)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
=20
 Underflow and overflow are allowed during arithmetic operations, meaning
 the 64-bit or 32-bit value will wrap. If eBPF program execution would
@@ -397,6 +397,9 @@ instructions that transfer data between a register an=
d memory.
 Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW`` and
 'unsigned size' is one of u8, u16, u32 or u64.
=20
+Sign-extension load operations
+------------------------------
+
 The ``BPF_MEMSX`` mode modifier is used to encode sign-extension load
 instructions that transfer data between a register and memory.
=20
--=20
2.34.1


