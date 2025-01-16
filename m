Return-Path: <bpf+bounces-49025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E0EA132C4
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 06:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A5618875F4
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 05:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0780F18D620;
	Thu, 16 Jan 2025 05:51:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0579B149C7B
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 05:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737006702; cv=none; b=IlH8TGaebVJlZmpgslQI3ZyuRCmitFHxOXqgiHDt/ERiF3I/4i/VT8g8CClpUtc2z00BRKFgxLGTaH4qe+V2PoWjiJLsz3wgRY1xDkAG3tk6aX3+ktWIjrMoRZuh3aRXsfTkr8Gc+mziJ+Ik3yHh4o4yjiVbxq8cgk3wrU3VIrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737006702; c=relaxed/simple;
	bh=fB+dTtDTMiWL56JUQCUrU+gGWBJW//uqaARQD0IzHWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dn3m5Rkzg3VVaIgQ8SPNVAA/VOUmdvfMKTrTE7oktF3L5pQVJDLpy9YOOfnCn/vLZfj898Tn9xn/ZUKaxzaHLo2IdiHId9oNpnXTryayfRWtXsXFR19abn+9krX//pSa/sL9+IRm5aQ+u19ZBLINyWStDsJ8hS032ZOG1X1+8b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 1E3C2D032440; Wed, 15 Jan 2025 21:51:29 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Emil Tsalapatis <etsal@meta.com>
Subject: [PATCH bpf-next 1/3] bpf: Allow 'may_goto 0' instruction
Date: Wed, 15 Jan 2025 21:51:29 -0800
Message-ID: <20250116055129.604354-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250116055123.603790-1-yonghong.song@linux.dev>
References: <20250116055123.603790-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit 011832b97b31 ("bpf: Introduce may_goto instruction") added support
for may_goto insn. The 'may_goto 0' insn is disallowed since the insn is
equivalent to a nop as both branch will go to the next insn.

But it is possible that compiler transformation may generate 'may_goto 0'
insn. Emil Tsalapatis from Meta reported such a case which caused
verification failure. For example, for the following code,
   int i, tmp[3];
   for (i =3D 0; i < 3 && can_loop; i++)
     tmp[i] =3D 0;
   ...

clang 20 may generate code like
   may_goto 2;
   may_goto 1;
   may_goto 0;
   r1 =3D 0; /* tmp[0] =3D 0; */
   r2 =3D 0; /* tmp[1] =3D 0; */
   r3 =3D 0; /* tmp[2] =3D 0; */

Let us permit 'may_goto 0' insn to avoid verification failure for codes
like the above.

Reported-by: Emil Tsalapatis <etsal@meta.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b8ca227c78af..edf3cc42a220 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15899,9 +15899,8 @@ static int check_cond_jmp_op(struct bpf_verifier_=
env *env,
=20
 		if (insn->code !=3D (BPF_JMP | BPF_JCOND) ||
 		    insn->src_reg !=3D BPF_MAY_GOTO ||
-		    insn->dst_reg || insn->imm || insn->off =3D=3D 0) {
-			verbose(env, "invalid may_goto off %d imm %d\n",
-				insn->off, insn->imm);
+		    insn->dst_reg || insn->imm) {
+			verbose(env, "invalid may_goto imm %d\n", insn->imm);
 			return -EINVAL;
 		}
 		prev_st =3D find_prev_entry(env, cur_st->parent, idx);
--=20
2.43.5


