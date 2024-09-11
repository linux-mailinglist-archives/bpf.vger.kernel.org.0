Return-Path: <bpf+bounces-39578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86290974957
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 06:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2685E1F26AF3
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 04:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEAA43AB4;
	Wed, 11 Sep 2024 04:40:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B21840862
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 04:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726029634; cv=none; b=iB8ymL67Y3F5Bm42Unu3v8ULjPFJVYgNGN6dgRhV1FrK0KWYTCcwYjdQTO5vL62x4nKhGZcS6IFWXOj3mw+Jzg1ivc1+WglbgxzYmOyHXSPWlCRwe6PlKFY/RlsiyoBb9wbRRVzNJw1K8Dq+nZY0VO1wN5CSBIYIvA+00zwTpSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726029634; c=relaxed/simple;
	bh=wmP1+XKfIQT+c6T+nJ5AZHLmvdy4a+5xaCDTXWhz5/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JEujnTWDN3dw92kWkwvA0Qerj+xJ+y8BXP0EIBENFloIF3FJMOWixBM8u2jTLyEBgk6u6OCxsG7pVLhr036Eyy9xrFAwamiQk/s6jbAReAYqKZjEEFsueGrzvvSBs+UadrIWYvsCCPd4u9n6jh0veFUWOkoC+8DMQq/V7WjNBxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id D70C18D48E4C; Tue, 10 Sep 2024 21:40:17 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Zac Ecob <zacecob@protonmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Fix a sdiv overflow issue
Date: Tue, 10 Sep 2024 21:40:17 -0700
Message-ID: <20240911044017.2261738-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Zac Ecob reported a problem where a bpf program may cause kernel crash du=
e
to the following error:
  Oops: divide error: 0000 [#1] PREEMPT SMP KASAN PTI

The failure is due to the below signed divide:
  LLONG_MIN/-1 where LLONG_MIN equals to -9,223,372,036,854,775,808.
LLONG_MIN/-1 is supposed to give a positive number 9,223,372,036,854,775,=
808,
but it is impossible since for 64-bit system, the maximum positive
number is 9,223,372,036,854,775,807. On x86_64, LLONG_MIN/-1 will
cause a kernel exception. On arm64, the result for LLONG_MIN/-1 is
LLONG_MIN.

So for 64-bit signed divide (sdiv), some additional insns are patched
to check LLONG_MIN/-1 pattern. If such a pattern does exist, the result
will be LLONG_MIN. Otherwise, it follows normal sdiv operation.

  [1] https://lore.kernel.org/bpf/tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZp=
AaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=3D@p=
rotonmail.com/

Reported-by: Zac Ecob <zacecob@protonmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f35b80c16cda..d77f1a05a065 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20506,6 +20506,7 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
 		    insn->code =3D=3D (BPF_ALU | BPF_DIV | BPF_X)) {
 			bool is64 =3D BPF_CLASS(insn->code) =3D=3D BPF_ALU64;
 			bool isdiv =3D BPF_OP(insn->code) =3D=3D BPF_DIV;
+			bool is_sdiv64 =3D is64 && isdiv && insn->off =3D=3D 1;
 			struct bpf_insn *patchlet;
 			struct bpf_insn chk_and_div[] =3D {
 				/* [R,W]x div 0 -> 0 */
@@ -20525,10 +20526,32 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
 				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
 				BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
 			};
+			struct bpf_insn chk_and_sdiv64[] =3D {
+				/* Rx sdiv 0 -> 0 */
+				BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_K, insn->src_reg,
+					     0, 2, 0),
+				BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg),
+				BPF_JMP_IMM(BPF_JA, 0, 0, 8),
+				/* LLONG_MIN sdiv -1 -> LLONG_MIN */
+				BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_K, insn->src_reg,
+					     0, 6, -1),
+				BPF_LD_IMM64(insn->src_reg, LLONG_MIN),
+				BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_X, insn->dst_reg,
+					     insn->src_reg, 2, 0),
+				BPF_MOV64_IMM(insn->src_reg, -1),
+				BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+				BPF_MOV64_IMM(insn->src_reg, -1),
+				*insn,
+			};
=20
-			patchlet =3D isdiv ? chk_and_div : chk_and_mod;
-			cnt =3D isdiv ? ARRAY_SIZE(chk_and_div) :
-				      ARRAY_SIZE(chk_and_mod) - (is64 ? 2 : 0);
+			if (is_sdiv64) {
+				patchlet =3D chk_and_sdiv64;
+				cnt =3D ARRAY_SIZE(chk_and_sdiv64);
+			} else {
+				patchlet =3D isdiv ? chk_and_div : chk_and_mod;
+				cnt =3D isdiv ? ARRAY_SIZE(chk_and_div) :
+					      ARRAY_SIZE(chk_and_mod) - (is64 ? 2 : 0);
+			}
=20
 			new_prog =3D bpf_patch_insn_data(env, i + delta, patchlet, cnt);
 			if (!new_prog)
--=20
2.43.5


