Return-Path: <bpf+bounces-44647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D51569C5D80
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 17:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9061F226CE
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 16:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E73620695E;
	Tue, 12 Nov 2024 16:39:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0074520651E
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429561; cv=none; b=OetD7aAE+Z73KSPWTHPH5nHjZoN+2AbgHwo6zZHJmjfot5cJOwdrFrCO5zc9dLzMYW4XYo6ZhMBYZCEp4rKta3gjiT+vESnvt8vvELmUQXtLNiQcBkyqDmVqWSpt6CGofIz4O66mNQCglvhVtn0YcdTfLpu7tiVk7ZhX6UKk3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429561; c=relaxed/simple;
	bh=ApM6jTYMNEP7rwBAJhWlCxSLrXFH0f2OcZ0rpXzUxbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSEyXMFuh+bSGZ52BSQcY34VUGZAMYOJ0JE46K9jYdbje/TPcZfml2wl6yVqlVWwb3/9EfNtCPiJXJuHepwfxA6S5+9GkRS9ZnWHJFqoopZ9V1RzRGLLA3TPhjF8dncquk42yMMYFwjX6AcvbShUJTwapTEQe5LR1QRTGMWXEgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 583E2AFAF890; Tue, 12 Nov 2024 08:39:12 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v12 2/7] bpf: Enable private stack for eligible subprogs
Date: Tue, 12 Nov 2024 08:39:12 -0800
Message-ID: <20241112163912.2224007-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241112163902.2223011-1-yonghong.song@linux.dev>
References: <20241112163902.2223011-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If private stack is used by any subprog, set that subprog
prog->aux->jits_use_priv_stack to be true so later jit can allocate
private stack for that subprog properly.

Also set env->prog->aux->jits_use_priv_stack to be true if
any subprog uses private stack. This is a use case for a
single main prog (no subprogs) to use private stack, and
also a use case for later struct-ops progs where
env->prog->aux->jits_use_priv_stack will enable recursion
check if any subprog uses private stack.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/verifier.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1b84613b10ac..15f20d508174 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1523,6 +1523,7 @@ struct bpf_prog_aux {
 	bool exception_cb;
 	bool exception_boundary;
 	bool is_extended; /* true if extended by freplace program */
+	bool jits_use_priv_stack;
 	u64 prog_array_member_cnt; /* counts how many times as member of prog_a=
rray */
 	struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_=
cnt */
 	struct bpf_arena *arena;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fb23793ac53d..176d19ad9d07 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6334,6 +6334,14 @@ static int check_max_stack_depth(struct bpf_verifi=
er_env *env)
 				return ret;
 		}
 	}
+
+	for (int i =3D 0; i < env->subprog_cnt; i++) {
+		if (si[i].priv_stack_mode =3D=3D PRIV_STACK_ADAPTIVE) {
+			env->prog->aux->jits_use_priv_stack =3D true;
+			break;
+		}
+	}
+
 	return 0;
 }
=20
@@ -20274,6 +20282,9 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
=20
 		func[i]->aux->name[0] =3D 'F';
 		func[i]->aux->stack_depth =3D env->subprog_info[i].stack_depth;
+		if (env->subprog_info[i].priv_stack_mode =3D=3D PRIV_STACK_ADAPTIVE)
+			func[i]->aux->jits_use_priv_stack =3D true;
+
 		func[i]->jit_requested =3D 1;
 		func[i]->blinding_requested =3D prog->blinding_requested;
 		func[i]->aux->kfunc_tab =3D prog->aux->kfunc_tab;
--=20
2.43.5


