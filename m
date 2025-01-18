Return-Path: <bpf+bounces-49265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C18A15E92
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 20:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4913A654C
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 19:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968711B0410;
	Sat, 18 Jan 2025 19:20:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83129194A73
	for <bpf@vger.kernel.org>; Sat, 18 Jan 2025 19:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737228040; cv=none; b=J4c3JZOFm1ylz/uz6/GSRBo9QfKEfoTJXX+maXObcUsKOgvy64IQtnRViaWaxF2sI4JkH+YGH+SDnmJu05k1C3HXgf6JNQV8hc2u/6iUoEMcCJLzcDguTexXxE6hBmnzUyWH4zvX0G0yklEeu1lNv55zgev+VwLZUdPzXsoWjhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737228040; c=relaxed/simple;
	bh=Wbd7+kvry3bX2jAvE1iHf54uZW3I+6rLlGTB1R1fZxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZCKKZbSaSiDb38J4SXnsAatOY9lRglc+1n4e0WAKqOYsBWuGmHXBNWQAKZwtDyP5rwdgacu/tGClHdIDwWB0yc7OPXabJirc07JpoUtJ1hm54i7tPUjIeBSbh46KjSv1TSVFNtA1hHdg6ctHpdzbphKuzMw8cEBED8Osi09H1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 7372FD1B48E0; Sat, 18 Jan 2025 11:20:24 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Emil Tsalapatis <etsal@meta.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 1/3] bpf: Allow 'may_goto 0' instruction in verifier
Date: Sat, 18 Jan 2025 11:20:24 -0800
Message-ID: <20250118192024.2124059-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250118192019.2123689-1-yonghong.song@linux.dev>
References: <20250118192019.2123689-1-yonghong.song@linux.dev>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 245f1f3f1aec..963dfda81c06 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15972,9 +15972,8 @@ static int check_cond_jmp_op(struct bpf_verifier_=
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


