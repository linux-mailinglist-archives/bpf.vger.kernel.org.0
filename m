Return-Path: <bpf+bounces-49026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D42A132C5
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 06:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AED33A5EDD
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 05:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FEB18CC10;
	Thu, 16 Jan 2025 05:51:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29D3141987
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 05:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737006709; cv=none; b=tUEGKbHaF/BWxk9UoWgaCS2hJtBmn/BpIDY/p5oMbJD0pRVW0OBOBb9OrtZyE7waibGGkgQU+0zVOmBGfYFyEjioyPUopAfIrQzBwLnx29h0tKxHsfreR57QHL2GDl+QkANL/A/SrXCJZpdc1c+3Kxzs9P3+U/6ZDQbDiHvopi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737006709; c=relaxed/simple;
	bh=M0MRPC4InUgpTCkcLNGTZh51OD1kaASqNwm7rdAmrAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsD8hrJp3+p/PSZeTV7UQ029qHEGUhXm5ogSQiqjIr87lndYzwp2D1lgNiMshRgrrIPuv9wLHjyXR1++2Vp+jYA9a+RHOyP64jQOOlfJS9PyWEPNiI2Y6mN3X8ujwtLSW/hzOmTBWWEh6eqp8K9Vl30vpI8sloJEYBZeXAqvnWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 394F3D032467; Wed, 15 Jan 2025 21:51:34 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 2/3] bpf: Remove 'may_goto 0' instruction
Date: Wed, 15 Jan 2025 21:51:34 -0800
Message-ID: <20250116055134.604867-1-yonghong.song@linux.dev>
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

Since 'may_goto 0' insns are actually no-op, let us remove them.
Otherwise, verifier will generate code like
   /* r10 - 8 stores the implicit loop count */
   r11 =3D *(u64 *)(r10 -8)
   if r11 =3D=3D 0x0 goto pc+2
   r11 -=3D 1
   *(u64 *)(r10 -8) =3D r11

which is the pure overhead.

The following code patterns (from the previous commit) are also
handled:
   may_goto 2
   may_goto 1
   may_goto 0

With this commit, the above three 'may_goto' insns are all
eliminated.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edf3cc42a220..72b474bfba2d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20133,6 +20133,40 @@ static int opt_remove_nops(struct bpf_verifier_e=
nv *env)
 	return 0;
 }
=20
+static int opt_remove_useless_may_gotos(struct bpf_verifier_env *env)
+{
+	struct bpf_insn *insn =3D env->prog->insnsi;
+	int i, j, err, last_may_goto, removed_cnt;
+	int insn_cnt =3D env->prog->len;
+
+	for (i =3D 0; i < insn_cnt; i++) {
+		if (!is_may_goto_insn(&insn[i]))
+			continue;
+
+		for (j =3D i + 1; j < insn_cnt; j++) {
+			if (!is_may_goto_insn(&insn[j]))
+				break;
+		}
+
+		last_may_goto =3D --j;
+		removed_cnt =3D 0;
+		while (j >=3D i) {
+			if (insn[j].off =3D=3D 0) {
+				err =3D verifier_remove_insns(env, j, 1);
+				if (err)
+					return err;
+				removed_cnt++;
+			}
+			j--;
+		}
+
+		insn_cnt -=3D removed_cnt;
+		i =3D last_may_goto - removed_cnt;
+	}
+
+	return 0;
+}
+
 static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 					 const union bpf_attr *attr)
 {
@@ -23089,6 +23123,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr, __u3
 			ret =3D opt_remove_dead_code(env);
 		if (ret =3D=3D 0)
 			ret =3D opt_remove_nops(env);
+		if (ret =3D=3D 0)
+			ret =3D opt_remove_useless_may_gotos(env);
 	} else {
 		if (ret =3D=3D 0)
 			sanitize_dead_code(env);
--=20
2.43.5


