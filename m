Return-Path: <bpf+bounces-32229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4A5909955
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 19:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344A728334F
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 17:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A394AECE;
	Sat, 15 Jun 2024 17:46:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9059E173
	for <bpf@vger.kernel.org>; Sat, 15 Jun 2024 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718473598; cv=none; b=YQt24/iAv2jTh1kgEMy/fjvI4TUI1myO3TNQMGAFkE2NK1TsRG1IUDyDOJL44oBcgSzl8HA75Rlz6l18e2ZqBcFpFykKYzD/3l6ELMUIYJCN7G+XASrO3mCTIyrGiiXRTxtJQiAu2Mn0D6s6xsg2J9u9QrPrsGmEpNAL1ro/gso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718473598; c=relaxed/simple;
	bh=gH9tbGq3+YMK3SEmAfXsIxpqKjkEkauCJydo9CyIqTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IB+drH80JaFcTjrZyiEa1vFbknf2Plyjpu7hwVJ+XsiC1A10dQLrY0J2oH9C2ixx6EjwZl27AzsZv1awiMZJr9zkNAmssa+49Nmpw981sE5nSkWhTfqMzgom+iPqbfvgyG0XLLlXQFXlxMgYDCJ0kTvn2sPw/d+5ZMXNzMwue1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id EF7CB58024AE; Sat, 15 Jun 2024 10:46:26 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Zac Ecob <zacecob@protonmail.com>
Subject: [PATCH bpf 1/3] bpf: Add missed var_off setting in set_sext32_default_val()
Date: Sat, 15 Jun 2024 10:46:26 -0700
Message-ID: <20240615174626.3994813-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240615174621.3994321-1-yonghong.song@linux.dev>
References: <20240615174621.3994321-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Zac reported a verification failure and Alexei reproduced the issue
with a simple reproducer ([1]). The verification failure is due to missed
setting for var_off.

The following is the reproducer in [1]:
  0: R1=3Dctx() R10=3Dfp0
  0: (71) r3 =3D *(u8 *)(r10 -387)        ;
     R3_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,=
var_off=3D(0x0; 0xff)) R10=3Dfp0
  1: (bc) w7 =3D (s8)w3                   ;
     R3_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,=
var_off=3D(0x0; 0xff))
     R7_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D127,=
var_off=3D(0x0; 0x7f))
  2: (36) if w7 >=3D 0x2533823b goto pc-3
     mark_precise: frame0: last_idx 2 first_idx 0 subseq_idx -1
     mark_precise: frame0: regs=3Dr7 stack=3D before 1: (bc) w7 =3D (s8)w=
3
     mark_precise: frame0: regs=3Dr3 stack=3D before 0: (71) r3 =3D *(u8 =
*)(r10 -387)
  2: R7_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D127,=
var_off=3D(0x0; 0x7f))
  3: (b4) w0 =3D 0                        ; R0_w=3D0
  4: (95) exit

Note that after insn 1, the var_off for R7 is (0x0; 0x7f). This is not co=
rrect
since upper 24 bits of w7 could be 0 or 1. So correct var_off should be
(0x0; 0xffffffff). Missing var_off setting in set_sext32_default_val() ca=
used later
incorrect analysis in zext_32_to_64(dst_reg) and reg_bounds_sync(dst_reg)=
.

To fix the issue, set var_off correctly in set_sext32_default_val(). The =
correct
reg state after insn 1 becomes:
  1: (bc) w7 =3D (s8)w3                   ;
     R3_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,=
var_off=3D(0x0; 0xff))
     R7_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,smin32=3D-128,smax32=
=3D127,var_off=3D(0x0; 0xffffffff))
and at insn 2, the verifier correctly determines either branch is possibl=
e.

  [1] https://lore.kernel.org/bpf/CAADnVQLPU0Shz7dWV4bn2BgtGdxN3uFHPeobGB=
A72tpg5Xoykw@mail.gmail.com/

Fixes: 8100928c8814 ("bpf: Support new sign-extension mov insns")
Reported-by: Zac Ecob <zacecob@protonmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 010cfee7ffe9..904ef5a03cf5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6236,6 +6236,7 @@ static void set_sext32_default_val(struct bpf_reg_s=
tate *reg, int size)
 	}
 	reg->u32_min_value =3D 0;
 	reg->u32_max_value =3D U32_MAX;
+	reg->var_off =3D tnum_subreg(tnum_unknown);
 }
=20
 static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int size=
)
--=20
2.43.0


