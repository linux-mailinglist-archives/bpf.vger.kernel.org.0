Return-Path: <bpf+bounces-40379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F15987D48
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 05:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D08C284D72
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 03:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB3314AD2D;
	Fri, 27 Sep 2024 03:39:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FCA320B
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 03:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727408365; cv=none; b=XY4aCx8fHE8PtqKBoLf63NHmSGSyFRDnw1rYCTdIi2O4ygEFKhxl9zYB5S2eoAM+hvRfc2/m5Gf45Hh2kbzW/LyHoUifBTAORJkEeu2loCfB4yKvv2r6Vp03iqyXgUQ2zSGgfVxGF1Pmo3MsB2hXUmyBjjfgNgdW6hs3X1Kyzc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727408365; c=relaxed/simple;
	bh=qqAklpzyNvmPH/KuCNEI1b8sd7SS5hXegfs9pC+HeqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E+3e8yFObcoM4+KArpgoe1T9IkK8i9mslvRVKZiR1PTc1XLDHC9mnRTkotQWQYY0hLJtUDZN61GG6qikEw72WHaTMLzcJoMHpmA1kORJIklVHmQ6dPdFQDtzSurgeSn2mWtooyh7EXKYr/i8I5RZk8wE/roYUU8LO5XLpz5FZu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 023D49694D29; Thu, 26 Sep 2024 20:39:05 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] docs/bpf: Document some special sdiv/smod operations
Date: Thu, 26 Sep 2024 20:39:04 -0700
Message-ID: <20240927033904.2702474-1-yonghong.song@linux.dev>
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
 .../bpf/standardization/instruction-set.rst   | 25 +++++++++++++++----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
index ab820d565052..d150c1d7ad3b 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -347,11 +347,26 @@ register.
   =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
=20
 Underflow and overflow are allowed during arithmetic operations, meaning
-the 64-bit or 32-bit value will wrap. If BPF program execution would
-result in division by zero, the destination register is instead set to z=
ero.
-If execution would result in modulo by zero, for ``ALU64`` the value of
-the destination register is unchanged whereas for ``ALU`` the upper
-32 bits of the destination register are zeroed.
+the 64-bit or 32-bit value will wrap. There are also a few arithmetic op=
erations
+which may cause exception for certain architectures. Since crashing the =
kernel
+is not an option, those operations are replaced with alternative operati=
ons.
+
+.. table:: Arithmetic operations with possible exceptions
+
+  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+  name   class       original                       replacement
+  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+  DIV    ALU64/ALU   dst /=3D 0                       dst =3D 0
+  SDIV   ALU64/ALU   dst s/=3D 0                      dst =3D 0
+  MOD    ALU64       dst %=3D 0                       dst =3D dst (no re=
placement)
+  MOD    ALU         dst %=3D 0                       dst =3D (u32)dst
+  SMOD   ALU64       dst s%=3D 0                      dst =3D dst (no re=
placement)
+  SMOD   ALU         dst s%=3D 0                      dst =3D (u32)dst
+  SDIV   ALU64       dst s/=3D -1 (dst =3D LLONG_MIN)   dst =3D LLONG_MI=
N
+  SDIV   ALU         dst s/=3D -1 (dst =3D INT_MIN)     dst =3D (u32)INT=
_MIN
+  SMOD   ALU64       dst s%=3D -1 (dst =3D LLONG_MIN)   dst =3D 0
+  SMOD   ALU         dst s%=3D -1 (dst =3D INT_MIN)     dst =3D 0
+  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 ``{ADD, X, ALU}``, where 'code' =3D ``ADD``, 'source' =3D ``X``, and 'cl=
ass' =3D ``ALU``, means::
=20
--=20
2.43.5


