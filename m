Return-Path: <bpf+bounces-43428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEB79B55A3
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 23:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53867283FCB
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 22:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD9420ADDA;
	Tue, 29 Oct 2024 22:16:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB53A20ADC0
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730240217; cv=none; b=P2s1UYzHUkxVBuJBOBZYXJt+/oI/K77yW6EJBwjP7tCHysCHZJffJxVm1SVoctNk0kN8cs0pOH8IyrxLut772Mk8/n1up8oINYS9XUEdvoYkDTN4hkNxjJyCYnl9yny58cZ0v7mVYpbbh6+aV7ErIggtuxYVSIin5ZS3uUqBQMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730240217; c=relaxed/simple;
	bh=Mnrz94lbsC1aKKV97BPnvKIO3bQErAI08MyvQtYwF8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAVxOKQ0H7Unw3mnART3cgd3Rl7o4EN9rSoMXz9abulHXdOQCddTY8UwKY9QwkcZCjS8tTTgnPlafISc6T8RKyK+XkPhkwMC20fUBjmfs+3N4CfJ9S8BSrb9rXcLbzhrkxd6pLz0Qxx55IpSwJsoS2D2h9tQBAUm3MEGj2LXe6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 91BA8A91CF5B; Tue, 29 Oct 2024 15:16:52 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v7 3/9] bpf: Check potential private stack recursion for progs with async callback
Date: Tue, 29 Oct 2024 15:16:52 -0700
Message-ID: <20241029221652.265284-1-yonghong.song@linux.dev>
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

In previous patch, tracing progs are enabled for private stack since
recursion checking ensures there exists no nested same bpf prog run on
the same cpu.

But it is still possible for nested bpf subprog run on the same cpu
if the same subprog is called in both main prog and async callback,
or in different async callbacks. For example,
  main_prog
   bpf_timer_set_callback(timer, timer_cb);
   call sub1
  sub1
   ...
  time_cb
   call sub1

In the above case, nested subprog run for sub1 is possible with one in
process context and the other in softirq context. If this is the case,
the verifier will disable private stack for this bpf prog.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 46 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d3f4cbab97bc..596afd29f088 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6070,7 +6070,8 @@ static int round_up_stack_depth(struct bpf_verifier=
_env *env, int stack_depth)
  */
 static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, i=
nt idx,
 					 int *subtree_depth, int *depth_frame,
-					 int priv_stack_supported)
+					 int priv_stack_supported,
+					 char *subprog_visited)
 {
 	struct bpf_subprog_info *subprog =3D env->subprog_info;
 	struct bpf_insn *insn =3D env->prog->insnsi;
@@ -6120,8 +6121,12 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx,
 					idx, subprog_depth);
 				return -EACCES;
 			}
-			if (subprog_depth >=3D BPF_PRIV_STACK_MIN_SIZE)
+			if (subprog_depth >=3D BPF_PRIV_STACK_MIN_SIZE) {
 				subprog[idx].use_priv_stack =3D true;
+				subprog_visited[idx] =3D 1;
+			}
+		} else {
+			subprog_visited[idx] =3D 1;
 		}
 	}
 continue_func:
@@ -6222,19 +6227,42 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx,
 static int check_max_stack_depth(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *si =3D env->subprog_info;
+	char *subprogs1 =3D NULL, *subprogs2 =3D NULL;
 	int ret, subtree_depth =3D 0, depth_frame;
+	int orig_priv_stack_supported;
 	int priv_stack_supported;
=20
 	priv_stack_supported =3D bpf_enable_priv_stack(env);
 	if (priv_stack_supported < 0)
 		return priv_stack_supported;
=20
+	orig_priv_stack_supported =3D priv_stack_supported;
+	if (orig_priv_stack_supported !=3D NO_PRIV_STACK) {
+		subprogs1 =3D kvmalloc(env->subprog_cnt * 2, __GFP_ZERO);
+		if (!subprogs1)
+			priv_stack_supported =3D NO_PRIV_STACK;
+		else
+			subprogs2 =3D subprogs1 + env->subprog_cnt;
+	}
+
 	for (int i =3D 0; i < env->subprog_cnt; i++) {
 		if (!i || si[i].is_async_cb) {
 			ret =3D check_max_stack_depth_subprog(env, i, &subtree_depth, &depth_=
frame,
-							    priv_stack_supported);
+							    priv_stack_supported, subprogs2);
 			if (ret < 0)
-				return ret;
+				goto out;
+
+			if (priv_stack_supported !=3D NO_PRIV_STACK) {
+				for (int j =3D 0; j < env->subprog_cnt; j++) {
+					if (subprogs1[j] && subprogs2[j]) {
+						priv_stack_supported =3D NO_PRIV_STACK;
+						break;
+					}
+					subprogs1[j] |=3D subprogs2[j];
+				}
+			}
+			if (priv_stack_supported !=3D NO_PRIV_STACK)
+				memset(subprogs2, 0, env->subprog_cnt);
 		}
 	}
 	if (priv_stack_supported =3D=3D NO_PRIV_STACK) {
@@ -6243,10 +6271,18 @@ static int check_max_stack_depth(struct bpf_verif=
ier_env *env)
 				depth_frame, subtree_depth);
 			return -EACCES;
 		}
+		if (orig_priv_stack_supported =3D=3D PRIV_STACK_ADAPTIVE) {
+			for (int i =3D 0; i < env->subprog_cnt; i++)
+				si[i].use_priv_stack =3D false;
+		}
 	}
 	if (si[0].use_priv_stack)
 		env->prog->aux->use_priv_stack =3D true;
-	return 0;
+	ret =3D 0;
+
+out:
+	kvfree(subprogs1);
+	return ret;
 }
=20
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
--=20
2.43.5


