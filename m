Return-Path: <bpf+bounces-38038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E51EA95E507
	for <lists+bpf@lfdr.de>; Sun, 25 Aug 2024 22:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50C18B20DC4
	for <lists+bpf@lfdr.de>; Sun, 25 Aug 2024 20:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16401547EB;
	Sun, 25 Aug 2024 20:04:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD425622
	for <bpf@vger.kernel.org>; Sun, 25 Aug 2024 20:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724616267; cv=none; b=sqMiL1cO/+KEUR/urYl9gYtDjsl95c75uZvyo5ugoqH47jy/hroVMmIUfcwBeQSHmbZAC5jmwaphzgm4z3IDnigX5yYgEq76vGjv1VzZul5EPfdlvbeNcTLgISwlOBZdgLzjV16dXXxH6LL4EizhM//ql2c9lr189pQNOtUueZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724616267; c=relaxed/simple;
	bh=jtABDIAVRevSeWM169t+uMMN7PZLet5rGxzweryvz+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k6+Wvh/cHQJRt0+6LsvlCuA5vDcK1JtAMAZOLlP0n2notXY1FtKdvUwsMDtPNtuJopFezUy+/TR0fLjRZ211EPZ1wXTkA2XHqCPusr2I96CITDBaGvdVPoD7UOns7dnoxNlQbPDTYNOAAtGAf7/EVxic355kVIC8udAZNERJ7QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 016BA82FA287; Sun, 25 Aug 2024 13:04:06 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Daniel Hodges <hodgesd@meta.com>
Subject: [PATCH bpf-next] bpf, x64: Fix a jit convergence issue
Date: Sun, 25 Aug 2024 13:04:06 -0700
Message-ID: <20240825200406.1874982-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Daniel Hodges reported a jit error when playing with a sched-ext
program. The error message is:
  unexpected jmp_cond padding: -4 bytes

But further investigation shows the error is actual due to failed
convergence. The following are some analysis:

  ...
  pass4, final_proglen=3D4391:
    ...
    20e:    48 85 ff                test   rdi,rdi
    211:    74 7d                   je     0x290
    213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
    ...
    289:    48 85 ff                test   rdi,rdi
    28c:    74 17                   je     0x2a5
    28e:    e9 7f ff ff ff          jmp    0x212
    293:    bf 03 00 00 00          mov    edi,0x3

Note that insn at 0x211 is 2-byte cond jump insn for offset 0x7d (-125)
and insn at 0x28e is 5-byte jmp insn with offset -129.

  pass5, final_proglen=3D4392:
    ...
    20e:    48 85 ff                test   rdi,rdi
    211:    0f 84 80 00 00 00       je     0x297
    217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
    ...
    28d:    48 85 ff                test   rdi,rdi
    290:    74 1a                   je     0x2ac
    292:    eb 84                   jmp    0x218
    294:    bf 03 00 00 00          mov    edi,0x3

Note that insn at 0x211 is 5-byte cond jump insn now since its offset
becomes 0x80 based on previous round (0x293 - 0x213 =3D 0x80).
At the same time, insn at 0x292 is a 2-byte insn since its offset is
-124.

pass6 will repeat the same code as in pass4. pass7 will repeat the same
code as in pass5, and so on. This will prevent eventual convergence.

Passes 1-14 are with padding =3D 0. At pass15, padding is 1 and related
insn looks like:

    211:    0f 84 80 00 00 00       je     0x297
    217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
    ...
    24d:    48 85 d2                test   rdx,rdx

The similar code in pass14:
    211:    74 7d                   je     0x290
    213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
    ...
    249:    48 85 d2                test   rdx,rdx
    24c:    74 21                   je     0x26f
    24e:    48 01 f7                add    rdi,rsi
    ...

Before generating the following insn,
  250:    74 21                   je     0x273
"padding =3D 1" enables some checking to ensure nops is either 0 or 4
where
  #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
  nops =3D INSN_SZ_DIFF - 2

In this specific case,
  addrs[i] =3D 0x24e // from pass14
  addrs[i-1] =3D 0x24d // from pass15
  prog - temp =3D 3 // from 'test rdx,rdx' in pass15
so
  nops =3D -4
and this triggers the failure.
Making jit prog convergable can fix the above error.

Reported-by: Daniel Hodges <hodgesd@meta.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 47 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 074b41fafbe3..ec541aae5d9b 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -64,6 +64,51 @@ static bool is_imm8(int value)
 	return value <=3D 127 && value >=3D -128;
 }
=20
+/*
+ * Let us limit the positive offset to be <=3D 124.
+ * This is to ensure eventual jit convergence For the following patterns=
:
+ * ...
+ * pass4, final_proglen=3D4391:
+ *   ...
+ *   20e:    48 85 ff                test   rdi,rdi
+ *   211:    74 7d                   je     0x290
+ *   213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
+ *   ...
+ *   289:    48 85 ff                test   rdi,rdi
+ *   28c:    74 17                   je     0x2a5
+ *   28e:    e9 7f ff ff ff          jmp    0x212
+ *   293:    bf 03 00 00 00          mov    edi,0x3
+ * Note that insn at 0x211 is 2-byte cond jump insn for offset 0x7d (-12=
5)
+ * and insn at 0x28e is 5-byte jmp insn with offset -129.
+ *
+ * pass5, final_proglen=3D4392:
+ *   ...
+ *   20e:    48 85 ff                test   rdi,rdi
+ *   211:    0f 84 80 00 00 00       je     0x297
+ *   217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
+ *   ...
+ *   28d:    48 85 ff                test   rdi,rdi
+ *   290:    74 1a                   je     0x2ac
+ *   292:    eb 84                   jmp    0x218
+ *   294:    bf 03 00 00 00          mov    edi,0x3
+ * Note that insn at 0x211 is 5-byte cond jump insn now since its offset
+ * becomes 0x80 based on previous round (0x293 - 0x213 =3D 0x80).
+ * At the same time, insn at 0x292 is a 2-byte insn since its offset is
+ * -124.
+ *
+ * pass6 will repeat the same code as in pass4 and this will prevent
+ * eventual convergence.
+ *
+ * To fix this issue, we need to break je (2->6 bytes) <-> jmp (5->2 byt=
es)
+ * cycle in the above. Let us limit the positive offset for 8bit cond ju=
mp
+ * insn to mamximum 124 (0x7c). This way, the jmp insn will be always 2-=
bytes,
+ * and the jit pass can eventually converge.
+ */
+static bool is_imm8_cond_offset(int value)
+{
+	return value <=3D 124 && value >=3D -128;
+}
+
 static bool is_simm32(s64 value)
 {
 	return value =3D=3D (s64)(s32)value;
@@ -2231,7 +2276,7 @@ st:			if (is_imm8(insn->off))
 				return -EFAULT;
 			}
 			jmp_offset =3D addrs[i + insn->off] - addrs[i];
-			if (is_imm8(jmp_offset)) {
+			if (is_imm8_cond_offset(jmp_offset)) {
 				if (jmp_padding) {
 					/* To keep the jmp_offset valid, the extra bytes are
 					 * padded before the jump insn, so we subtract the
--=20
2.43.5


