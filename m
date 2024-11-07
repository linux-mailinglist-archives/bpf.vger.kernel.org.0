Return-Path: <bpf+bounces-44194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD179BFCA2
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 03:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74DC5B21F4B
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 02:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E082E62B;
	Thu,  7 Nov 2024 02:42:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E3A38382
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 02:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730947324; cv=none; b=WTC6H3nmNh0tqMq7cHurCzUYusOgdNiK+jKhIliPXvBL4BcY/TqV14CfHFabtjchYX1r2/Ub1hQ1EBv3eBgOUT8y9jnHovrA1bBmSY4Zs/XFw9RLZabwyOCv4kljgKEaYZUc1xaH4NIyJ/r/38HIcHAZGMgcgUVHvCzu7bJ5Ssg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730947324; c=relaxed/simple;
	bh=Q2CzXC9zoSJlg5CRuaGXgN8Y77LMDKHwuYq3nEynthM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0j2zXuxpxlJFyfJmuNIQmdz815Gg1Gd+LrEyGPLo4AZQ9LTHnrinhv2XyFlvqSy+T1sN8nW4vyc7X4/c6SP9PxKJYYc49UNEsHNbPCqkuCJ1LYIyXGzUYAS8NUE+c3Nds41RFTutDpYU7fdzhH69C8cmlAzmOI00pa4XhuKqhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 192C7AD19F15; Wed,  6 Nov 2024 18:41:49 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v10 2/7] bpf: Enable private stack for eligible subprogs
Date: Wed,  6 Nov 2024 18:41:49 -0800
Message-ID: <20241107024149.3356316-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107024138.3355687-1-yonghong.song@linux.dev>
References: <20241107024138.3355687-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If private stack is requested by any subprog, set that subprog
prog->aux->priv_stack_requested to be true so later jit can allocate
private stack for that subprog properly.

Also set env->prog->aux->priv_stack_requested to be true if
subprog[0] requests private stack. This is a use case for a
single main prog (no subprogs) to use private stack.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2284b909b499..09bb9dc939d6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6278,6 +6278,10 @@ static int check_max_stack_depth(struct bpf_verifi=
er_env *env)
 				return ret;
 		}
 	}
+
+	if (si[0].priv_stack_mode =3D=3D PRIV_STACK_ADAPTIVE)
+		env->prog->aux->priv_stack_requested =3D true;
+
 	return 0;
 }
=20
@@ -20211,6 +20215,9 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
=20
 		func[i]->aux->name[0] =3D 'F';
 		func[i]->aux->stack_depth =3D env->subprog_info[i].stack_depth;
+		if (env->subprog_info[i].priv_stack_mode =3D=3D PRIV_STACK_ADAPTIVE)
+			func[i]->aux->priv_stack_requested =3D true;
+
 		func[i]->jit_requested =3D 1;
 		func[i]->blinding_requested =3D prog->blinding_requested;
 		func[i]->aux->kfunc_tab =3D prog->aux->kfunc_tab;
--=20
2.43.5


