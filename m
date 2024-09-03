Return-Path: <bpf+bounces-38850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A266696AC95
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 01:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599C7285ED8
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 23:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73C5126BF1;
	Tue,  3 Sep 2024 23:00:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C71D58B0
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 23:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725404408; cv=none; b=FFmeCE3Q4mu995rqVOsExgnYHBhJednBSO304vddDToGraa5/2rGcEtiscW1H8daN91rVKmhJLwEukCSiheO3cvA6rOwUSwwfejM+i2lAfrnYcKYraTGP/wrDoBkl8u3sTl02VlCE6FUJt1qN5SbC4vnym3yqYvXdcWhDxeAezE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725404408; c=relaxed/simple;
	bh=POE64LdyQ4gIede4hY2KekXHPIu+BMoGqsbo6if7du0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FlJ0U/Y7mi9V7N0YJce1rRvuzSbVM1CCpw7VIxuNFGtfXfbuA2oQDNE5gzJsgr5y9clx+ujNImMvZlbCFssJDYi5OEEvVaMV+nQyQ84ZTHvwVA3azFX/tG5vQ9hVq+PugmdqANn8StyzoHhSaJPxQN7yhD2qXgKyqdsGavMSXN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id BF99B88DE236; Tue,  3 Sep 2024 15:59:49 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Daniel Hodges <hodgesd@meta.com>
Subject: [PATCH bpf-next v2 1/2] bpf, x64: Fix a jit convergence issue
Date: Tue,  3 Sep 2024 15:59:49 -0700
Message-ID: <20240903225949.2066234-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Daniel Hodges reported a jit error when playing with a sched-ext program.
The error message is:
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

Note that insn at 0x211 is 6-byte cond jump insn now since its offset
becomes 0x80 based on previous round (0x293 - 0x213 =3D 0x80). At the sam=
e
time, insn at 0x292 is a 2-byte insn since its offset is -124.

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

To fix the issue, we need to break cycles of je <-> jmp. For example,
in the above case, we have
  211:    74 7d                   je     0x290
the offset is 0x7d. If 2-byte je insn is generated only if
the offset is less than 0x7d (<=3D 0x7c), the cycle can be
break and we can achieve the convergence.

I did some study on other cases like je <-> je, jmp <-> je and
jmp <-> jmp which may cause cycles. Those cases are not from actual
reproducible cases since it is pretty hard to construct a test case
for them. the results show that the offset <=3D 0x7b (0x7b =3D 123) shoul=
d
be enough to cover all cases. This patch added a new helper to generate 8=
-bit
cond/uncond jmp insns only if the offset range is [-128, 123].

Reported-by: Daniel Hodges <hodgesd@meta.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 55 +++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 074b41fafbe3..63c4816ed4e7 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -64,6 +64,57 @@ static bool is_imm8(int value)
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
+ * Note that insn at 0x211 is 6-byte cond jump insn now since its offset
+ * becomes 0x80 based on previous round (0x293 - 0x213 =3D 0x80).
+ * At the same time, insn at 0x292 is a 2-byte insn since its offset is
+ * -124.
+ *
+ * pass6 will repeat the same code as in pass4 and this will prevent
+ * eventual convergence.
+ *
+ * To fix this issue, we need to break je (2->6 bytes) <-> jmp (5->2 byt=
es)
+ * cycle in the above. In the above example that we found je offset <=3D=
 0x7c
+ * should work.
+ *
+ * For other cases, je <-> je needs offset <=3D 0x7b to avoid no converg=
ence
+ * issue. For jmp <-> je and jmp <-> jmp cases, jmp offset <=3D 0x7c sho=
uld
+ * avoid no convergence issue.
+ *
+ * Overall, let us limit the positive offset for 8bit cond/uncond jmp in=
sn
+ * to mamximum 123 (0x7b). This way, the jit pass can eventually converg=
e.
+ */
+static bool is_imm8_jmp_offset(int value)
+{
+	return value <=3D 123 && value >=3D -128;
+}
+
 static bool is_simm32(s64 value)
 {
 	return value =3D=3D (s64)(s32)value;
@@ -2231,7 +2282,7 @@ st:			if (is_imm8(insn->off))
 				return -EFAULT;
 			}
 			jmp_offset =3D addrs[i + insn->off] - addrs[i];
-			if (is_imm8(jmp_offset)) {
+			if (is_imm8_jmp_offset(jmp_offset)) {
 				if (jmp_padding) {
 					/* To keep the jmp_offset valid, the extra bytes are
 					 * padded before the jump insn, so we subtract the
@@ -2313,7 +2364,7 @@ st:			if (is_imm8(insn->off))
 				break;
 			}
 emit_jmp:
-			if (is_imm8(jmp_offset)) {
+			if (is_imm8_jmp_offset(jmp_offset)) {
 				if (jmp_padding) {
 					/* To avoid breaking jmp_offset, the extra bytes
 					 * are padded before the actual jmp insn, so
--=20
2.43.5


