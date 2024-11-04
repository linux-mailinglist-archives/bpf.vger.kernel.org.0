Return-Path: <bpf+bounces-43934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064119BBE1C
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 20:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3931A1C21C92
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 19:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6A81CCB2E;
	Mon,  4 Nov 2024 19:38:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E4B1CBE82
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730749090; cv=none; b=dzu+JvqeFQZZwwTKdMoGRLSFdMjIq2b8S7nBOqNDRfEUilj/xJQYc4I1zVKmDzaeZfYZ/fkZTkUgddrGi/Hv1SyPnjZMwXBJiqTixOzUfieA7KPeEO27jM+88r8wQUA7fH3iUgPsIJIhCpw0lyqdEZK8d+kex4/OZMfgWb2vRBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730749090; c=relaxed/simple;
	bh=BDhOLK54EQYRoaH1jAO7MkHRnauswTRLZgazS2+wkLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqGib2sSo1iCLM8EiUwmew3PmHXlYsvUqz23mFXxrrdWRc4xpO29PMGYR26yBH1flpSdw+q6aTRP2Ti/6gDFnvBLUJbkzWljULcj1VXE9gD573bJOIg1bL3WR4AF61KdoY2ZPU7wL9PPTM4k3lRX109RNuclukPBJC1U/H3DB9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 37AB2ABEC766; Mon,  4 Nov 2024 11:35:15 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v9 04/10] bpf: Check potential private stack recursion for progs with async callback
Date: Mon,  4 Nov 2024 11:35:15 -0800
Message-ID: <20241104193515.3243315-1-yonghong.song@linux.dev>
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
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/verifier.c        | 42 +++++++++++++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 0622c11a7e19..e921589abc72 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -669,6 +669,8 @@ struct bpf_subprog_info {
 	/* true if bpf_fastcall stack region is used by functions that can't be=
 inlined */
 	bool keep_fastcall_stack: 1;
 	bool use_priv_stack: 1;
+	bool visited_with_priv_stack_accum: 1;
+	bool visited_with_priv_stack: 1;
=20
 	u8 arg_cnt;
 	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 406195c433ea..e01b3f0fd314 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6118,8 +6118,12 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx,
 					idx, subprog_depth);
 				return -EACCES;
 			}
-			if (subprog_depth >=3D BPF_PRIV_STACK_MIN_SIZE)
+			if (subprog_depth >=3D BPF_PRIV_STACK_MIN_SIZE) {
 				subprog[idx].use_priv_stack =3D true;
+				subprog[idx].visited_with_priv_stack =3D true;
+			}
+		} else {
+			subprog[idx].visited_with_priv_stack =3D true;
 		}
 	}
 continue_func:
@@ -6220,10 +6224,12 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx,
 static int check_max_stack_depth(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *si =3D env->subprog_info;
+	enum priv_stack_mode orig_priv_stack_supported;
 	enum priv_stack_mode priv_stack_supported;
 	int ret, subtree_depth =3D 0, depth_frame;
=20
 	priv_stack_supported =3D bpf_enable_priv_stack(env->prog);
+	orig_priv_stack_supported =3D priv_stack_supported;
=20
 	if (priv_stack_supported !=3D NO_PRIV_STACK) {
 		for (int i =3D 0; i < env->subprog_cnt; i++) {
@@ -6240,13 +6246,39 @@ static int check_max_stack_depth(struct bpf_verif=
ier_env *env)
 							    priv_stack_supported);
 			if (ret < 0)
 				return ret;
+
+			if (priv_stack_supported !=3D NO_PRIV_STACK) {
+				for (int j =3D 0; j < env->subprog_cnt; j++) {
+					if (si[j].visited_with_priv_stack_accum &&
+					    si[j].visited_with_priv_stack) {
+						/* si[j] is visited by both main/async subprog
+						 * and another async subprog.
+						 */
+						priv_stack_supported =3D NO_PRIV_STACK;
+						break;
+					}
+					if (!si[j].visited_with_priv_stack_accum)
+						si[j].visited_with_priv_stack_accum =3D
+							si[j].visited_with_priv_stack;
+				}
+			}
+			if (priv_stack_supported !=3D NO_PRIV_STACK) {
+				for (int j =3D 0; j < env->subprog_cnt; j++)
+					si[j].visited_with_priv_stack =3D false;
+			}
 		}
 	}
=20
-	if (priv_stack_supported =3D=3D NO_PRIV_STACK && subtree_depth > MAX_BP=
F_STACK) {
-		verbose(env, "combined stack size of %d calls is %d. Too large\n",
-			depth_frame, subtree_depth);
-		return -EACCES;
+	if (priv_stack_supported =3D=3D NO_PRIV_STACK) {
+		if (subtree_depth > MAX_BPF_STACK) {
+			verbose(env, "combined stack size of %d calls is %d. Too large\n",
+				depth_frame, subtree_depth);
+			return -EACCES;
+		}
+		if (orig_priv_stack_supported =3D=3D PRIV_STACK_ADAPTIVE) {
+			for (int i =3D 0; i < env->subprog_cnt; i++)
+				si[i].use_priv_stack =3D false;
+		}
 	}
 	if (si[0].use_priv_stack)
 		env->prog->aux->use_priv_stack =3D true;
--=20
2.43.5


