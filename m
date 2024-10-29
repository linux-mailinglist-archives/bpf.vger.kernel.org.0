Return-Path: <bpf+bounces-43426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7104D9B55A1
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 23:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8FD7B21A84
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 22:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E178D20ADC1;
	Tue, 29 Oct 2024 22:16:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503AE207A0B
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730240214; cv=none; b=Aj1jUK2aI9XSP79yPB2vFLXeglayESfMnWjj77CRtZKCjF/+waDNYp/48KJE4/lSd1kN5UgPyeDuTwfakbW1p5XXzQnTykbLK2YQ16hgeEKzl53JswBKjHfOWgVGtIjVFaKZw9xF4caKsay4hO3EF0+eY3nuaFsXhIgW1/OdkDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730240214; c=relaxed/simple;
	bh=Gw5e3HerW2V96yedmprrICn4PtHFGZKdTZhW89n3nm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWwN1dzUcNq1znQ3Yg9iiL/bmwYX07X2ZbsS3GLqpkP0FDtoChRY/fYjhx6c7kCXCrcS697p4qlAD6IU0x794suCyiLdXhku9G7nOb8eUD78aRdbfDKQ6e3yhqZEVBKCHjEt8A16pLH6jSm4Sat9iBfiv/LVjNBeKwiZ/CigHew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 5C426A91CF27; Tue, 29 Oct 2024 15:16:42 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v7 1/9] bpf: Check stack depth limit after visiting all subprogs
Date: Tue, 29 Oct 2024 15:16:42 -0700
Message-ID: <20241029221642.264723-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241029221637.264348-1-yonghong.song@linux.dev>
References: <20241029221637.264348-1-yonghong.song@linux.dev>
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
index 797cf3ed32e0..89b0a980d0f9 100644
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


