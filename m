Return-Path: <bpf+bounces-43931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0649BBE11
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 20:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C22C282F97
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 19:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621181CBEAB;
	Mon,  4 Nov 2024 19:35:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9FCAD2D
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 19:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730748914; cv=none; b=SuEdoXPhXY5isvZjPV4gZy6/yGCSyhaWmp6pGPee9epJ87PDDG5ZV0qlAzTqExOe03yGOhPz1w7J3rHCcMnvs5fCvi05duRp/ANW3FasxemTPvkotLK1c29v4m7xFGjR1I+nCKnmG0uVK/fuLeRP+0BGZKGzzjVQENTNdS9P1GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730748914; c=relaxed/simple;
	bh=+jwfgpLrWLiEISSeJi+XNEMzaCiQtmQop2xz153gq34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGZyqhMmSiznlR24Nw4PS7ungy9fdqlE1kS5QPtECG4ylYG+A0INPyjrfVluwfBRxGk0G1loQjXAPEBTHcE+9tOuaLiQVVbPqqurpzFI3VqI+G+NEI/CuYSoVyHakp/tVnNqUcCwwQ70an+IHczeL58nwy2qvOiEVOjgK3nqL2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 7DBF6ABEC70B; Mon,  4 Nov 2024 11:35:00 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v9 01/10] bpf: Check stack depth limit after visiting all subprogs
Date: Mon,  4 Nov 2024 11:35:00 -0800
Message-ID: <20241104193500.3242095-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241104193455.3241859-1-yonghong.song@linux.dev>
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Check stack depth limit after all subprogs are visited. Note that if
private stack is enabled, the only stack size restriction is for a single
subprog with size less than or equal to MAX_BPF_STACK.

In subsequent patches, in function check_max_stack_depth(), there could
be a flip from enabling private stack to disabling private stack due to
potential nested bpf subprog run. Moving stack depth limit checking after
visiting all subprogs ensures the checking not missed in such flipping
cases.

The useless 'continue' statement in the loop in func
check_max_stack_depth() is also removed.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ba800c7611e3..ed8f70e51141 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6032,7 +6032,8 @@ static int round_up_stack_depth(struct bpf_verifier=
_env *env, int stack_depth)
  * Since recursion is prevented by check_cfg() this algorithm
  * only needs a local stack of MAX_CALL_FRAMES to remember callsites
  */
-static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, i=
nt idx)
+static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, i=
nt idx,
+					 int *subtree_depth, int *depth_frame)
 {
 	struct bpf_subprog_info *subprog =3D env->subprog_info;
 	struct bpf_insn *insn =3D env->prog->insnsi;
@@ -6070,10 +6071,9 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx)
 		return -EACCES;
 	}
 	depth +=3D round_up_stack_depth(env, subprog[idx].stack_depth);
-	if (depth > MAX_BPF_STACK) {
-		verbose(env, "combined stack size of %d calls is %d. Too large\n",
-			frame + 1, depth);
-		return -EACCES;
+	if (depth > MAX_BPF_STACK && !*subtree_depth) {
+		*subtree_depth =3D depth;
+		*depth_frame =3D frame + 1;
 	}
 continue_func:
 	subprog_end =3D subprog[idx + 1].start;
@@ -6173,15 +6173,19 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx)
 static int check_max_stack_depth(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *si =3D env->subprog_info;
-	int ret;
+	int ret, subtree_depth =3D 0, depth_frame;
=20
 	for (int i =3D 0; i < env->subprog_cnt; i++) {
 		if (!i || si[i].is_async_cb) {
-			ret =3D check_max_stack_depth_subprog(env, i);
+			ret =3D check_max_stack_depth_subprog(env, i, &subtree_depth, &depth_=
frame);
 			if (ret < 0)
 				return ret;
 		}
-		continue;
+	}
+	if (subtree_depth > MAX_BPF_STACK) {
+		verbose(env, "combined stack size of %d calls is %d. Too large\n",
+			depth_frame, subtree_depth);
+		return -EACCES;
 	}
 	return 0;
 }
--=20
2.43.5


