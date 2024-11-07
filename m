Return-Path: <bpf+bounces-44273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E6F9C0C9E
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 18:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9021A1C2293D
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7AD216DE8;
	Thu,  7 Nov 2024 17:09:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA9F2170AE
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730999383; cv=none; b=S1eg0XfCVu/LMol8Gog393KoVHYYnJ9n/UHM22IJNZzGjeoq8auuHr++ykDFfhMu6eJ6E2eH16VFNixv6fDETuaeiOcwuwBRYkDgsaJGcrpM5TC4MtkYnUhoTabu4nbB1X5V5f8X8pBIS/O2VON0EW7YBRMT9cs3Xmw/Ar+TZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730999383; c=relaxed/simple;
	bh=FLIgYvrWMt/q6IpA52o1yGumWGobltlKH0efymDGd5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xdg3zi5zseRDYLnsAeWl/fADzjrhFi8ohtf/9CA4OtIXu6ubm7GOEyqh2H96gp+hoq2lYScvrdFLPt+ua3/2rKkkmBPsAHo8JXfRdXmiOTtb6oY0AYJCda4w3Z5fMJzDfz9sE+t275NcwNXM4T9+e7w1PYBcRkN6HKnKcuo+KbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 98928AD63940; Thu,  7 Nov 2024 09:09:24 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2] docs/bpf: Document some special sdiv/smod operations
Date: Thu,  7 Nov 2024 09:09:24 -0800
Message-ID: <20241107170924.2944681-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Patch [1] fixed possible kernel crash due to specific sdiv/smod operation=
s
in bpf program. The following are related operations and the expected res=
ults
of those operations:
  - LLONG_MIN/-1 =3D LLONG_MIN
  - INT_MIN/-1 =3D INT_MIN
  - LLONG_MIN%-1 =3D 0
  - INT_MIN%-1 =3D 0

Those operations are replaced with codes which won't cause
kernel crash. This patch documents what operations may cause exception an=
d
what replacement operations are.

  [1] https://lore.kernel.org/all/20240913150326.1187788-1-yonghong.song@=
linux.dev/

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/standardization/instruction-set.rst   | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
index ab820d565052..fbe975585236 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -324,34 +324,42 @@ register.
=20
 .. table:: Arithmetic instructions
=20
-  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
   name   code   offset   description
-  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
   ADD    0x0    0        dst +=3D src
   SUB    0x1    0        dst -=3D src
   MUL    0x2    0        dst \*=3D src
   DIV    0x3    0        dst =3D (src !=3D 0) ? (dst / src) : 0
-  SDIV   0x3    1        dst =3D (src !=3D 0) ? (dst s/ src) : 0
+  SDIV   0x3    1        dst =3D (src =3D=3D 0) ? 0 : ((src =3D=3D -1 &&=
 dst =3D=3D LLONG_MIN) ? LLONG_MIN : (dst s/ src))
   OR     0x4    0        dst \|=3D src
   AND    0x5    0        dst &=3D src
   LSH    0x6    0        dst <<=3D (src & mask)
   RSH    0x7    0        dst >>=3D (src & mask)
   NEG    0x8    0        dst =3D -dst
   MOD    0x9    0        dst =3D (src !=3D 0) ? (dst % src) : dst
-  SMOD   0x9    1        dst =3D (src !=3D 0) ? (dst s% src) : dst
+  SMOD   0x9    1        dst =3D (src =3D=3D 0) ? dst : ((src =3D=3D -1 =
&& dst =3D=3D LLONG_MIN) ? 0: (dst s% src))
   XOR    0xa    0        dst ^=3D src
   MOV    0xb    0        dst =3D src
   MOVSX  0xb    8/16/32  dst =3D (s8,s16,s32)src
   ARSH   0xc    0        :term:`sign extending<Sign Extend>` dst >>=3D (=
src & mask)
   END    0xd    0        byte swap operations (see `Byte swap instructio=
ns`_ below)
-  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
=20
 Underflow and overflow are allowed during arithmetic operations, meaning
 the 64-bit or 32-bit value will wrap. If BPF program execution would
 result in division by zero, the destination register is instead set to z=
ero.
+Otherwise, for ``ALU64``, if execution would result in ``LLONG_MIN``
+dividing -1, the desination register is instead set to ``LLONG_MIN``. Fo=
r
+``ALU``, if execution would result in ``INT_MIN`` dividing -1, the
+desination register is instead set to ``INT_MIN``.
+
 If execution would result in modulo by zero, for ``ALU64`` the value of
 the destination register is unchanged whereas for ``ALU`` the upper
-32 bits of the destination register are zeroed.
+32 bits of the destination register are zeroed. Otherwise, for ``ALU64``=
,
+if execution would resuslt in ``LLONG_MIN`` modulo -1, the destination
+register is instead set to 0. For ``ALU``, if execution would result in
+``INT_MIN`` modulo -1, the destination register is instead set to 0.
=20
 ``{ADD, X, ALU}``, where 'code' =3D ``ADD``, 'source' =3D ``X``, and 'cl=
ass' =3D ``ALU``, means::
=20
--=20
2.43.5


