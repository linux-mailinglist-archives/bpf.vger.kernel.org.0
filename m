Return-Path: <bpf+bounces-20498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BC083EFD2
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 20:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23B31C22FF8
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 19:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEF12E626;
	Sat, 27 Jan 2024 19:46:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272D42E84A
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706384810; cv=none; b=ih4jg8DhHf5yYDqEWkeFUbZCYfaz7iB17yEqvbF/vxtCFDqBWWkh+rOW5Y2jIaOvheY0OERAE0QhifuR1gbKeAEmK1ozgnvbKR7V0qkERaPjPb5tNiPw8p41lUkM+D1yTVb6q1pt1+vKLQt2a7yvS2Yg0LzyNhMlJ7RfymOMw4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706384810; c=relaxed/simple;
	bh=Myr63vHqksdUX8vK5MY3FEqunPYeVXDovo7O7hDxvqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lgnXdFvYMpSgVnO/sIOv9RWAO8Bsx6Yas+p3ivj8Ny1huIYq80CGmayUe5B7ueSUa8riLH0kAXBjuAGtCM1UcOA5UWUv2LeEapu1d/MEIB/5bdMMFuBF4o12aNrG8FkN+yQrweWxEM4cReE5BtNK6C0DtFLomAo6uyOhi54BWlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 7E53C2D182784; Sat, 27 Jan 2024 11:46:29 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Dave Thaler <dthaler1968@gmail.com>
Subject: [PATCH bpf-next] [docs/bpf] Improve documentation of 64-bit immediate instructions
Date: Sat, 27 Jan 2024 11:46:29 -0800
Message-Id: <20240127194629.737589-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For 64-bit immediate instruction, 'BPF_IMM | BPF_DW | BPF_LD' and
src_reg=3D[0-6], the current documentation describes the 64-bit
immediate is constructed by
  imm64 =3D (next_imm << 32) | imm

But actually imm64 is only used when src_reg=3D0. For all other
variants (src_reg !=3D 0), 'imm' and 'next_imm' have separate special
encoding requirement and imm64 cannot be easily used to describe
instruction semantics.

This patch clarifies that 64-bit immediate instructions use
two 32-bit immediate values instead of a 64-bit immediate value,
so later describing individual 64-bit immediate instructions
becomes less confusing.

Acked-by: Dave Thaler <dthaler1968@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/standardization/instruction-set.rst         | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
index af43227b6ee4..fceacca46299 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -166,7 +166,7 @@ Note that most instructions do not use all of the fie=
lds.
 Unused fields shall be cleared to zero.
=20
 As discussed below in `64-bit immediate instructions`_, a 64-bit immedia=
te
-instruction uses a 64-bit immediate value that is constructed as follows=
.
+instruction uses two 32-bit immediate values that are constructed as fol=
lows.
 The 64 bits following the basic instruction contain a pseudo instruction
 using the same format but with opcode, dst_reg, src_reg, and offset all =
set to zero,
 and imm containing the high 32 bits of the immediate value.
@@ -181,13 +181,8 @@ This is depicted in the following figure::
                                    '--------------'
                                   pseudo instruction
=20
-Thus the 64-bit immediate value is constructed as follows:
-
-  imm64 =3D (next_imm << 32) | imm
-
-where 'next_imm' refers to the imm value of the pseudo instruction
-following the basic instruction.  The unused bytes in the pseudo
-instruction are reserved and shall be cleared to zero.
+Here, the imm value of the pseudo instruction is called 'next_imm'. The =
unused
+bytes in the pseudo instruction are reserved and shall be cleared to zer=
o.
=20
 Instruction classes
 -------------------
@@ -590,7 +585,7 @@ defined further below:
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
 opcode construction        opcode  src  pseudocode                      =
           imm type     dst type
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
-BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst =3D imm64                   =
             integer      integer
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst =3D (next_imm << 32) | imm  =
             integer      integer
 BPF_IMM | BPF_DW | BPF_LD  0x18    0x1  dst =3D map_by_fd(imm)          =
             map fd       map
 BPF_IMM | BPF_DW | BPF_LD  0x18    0x2  dst =3D map_val(map_by_fd(imm)) =
+ next_imm   map fd       data pointer
 BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst =3D var_addr(imm)           =
             variable id  data pointer
--=20
2.34.1


