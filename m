Return-Path: <bpf+bounces-21280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B3E84AE62
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 07:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBFD62870B6
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 06:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922898529A;
	Tue,  6 Feb 2024 06:30:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7CB84FB3
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 06:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707201028; cv=none; b=adG/jLnbSXhYJHrovmvvEZkBR00yVEGHtpfdwgYDMVgba/QHslMgAJmrY1yPtqa678CPST608831vrXRG2TGWt1u1c18T+GI8muh9mhZLcr+WJhVbMvDf6yF1NcZ3FW6xXy0ckK3NlW+/Sh6iRgnF7KexOR56smKbVyw6u7XZk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707201028; c=relaxed/simple;
	bh=VXj++i7nyYto3t3v9LrjlKE0DoXN9X2yupMQklinfQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YuvZumwPjO4QQUuruta2DTo1Nxoh/T43RfiuIAH3thllp+RGZfDDVVrkNkJxb9TFvDvEKKJJeo2sdi8Qw7ccROfqvrPulYWxu2QTYbr7fQV2VWRToUKA4QOcDMqE/KlJNPZs22uq1uL/iu/U8P1qbsh41aIVMT77llyOZfAvOWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id EAD7F2D65FB95; Mon,  5 Feb 2024 22:30:10 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix flaky test verif_scale_strobemeta_subprogs
Date: Mon,  5 Feb 2024 22:30:10 -0800
Message-Id: <20240206063010.1352503-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With latest llvm19, I hit the following selftest failures with

  $ ./test_progs -j
  libbpf: prog 'on_event': BPF program load failed: Permission denied
  libbpf: prog 'on_event': -- BEGIN PROG LOAD LOG --
  combined stack size of 4 calls is 544. Too large
  verification time 1344153 usec
  stack depth 24+440+0+32
  processed 51008 insns (limit 1000000) max_states_per_insn 19 total_stat=
es 1467 peak_states 303 mark_read 146
  -- END PROG LOAD LOG --
  libbpf: prog 'on_event': failed to load: -13
  libbpf: failed to load object 'strobemeta_subprogs.bpf.o'
  scale_test:FAIL:expect_success unexpected error: -13 (errno 13)
  #498     verif_scale_strobemeta_subprogs:FAIL

The verifier complains too big of the combined stack size (544 bytes) whi=
ch
exceeds the maximum stack limit 512. This is a regression from llvm19 ([1=
]).

In the above error log, the original stack depth is 24+440+0+32.
To satisfy interpreter's need, in verifier the stack depth is adjusted to
32+448+32+32=3D544 which exceeds 512, hence the error. The same adjusted
stack size is also used for jit case.

But the jitted codes could use smaller stack size.

  $ egrep -r stack_depth | grep round_up
  arm64/net/bpf_jit_comp.c:       ctx->stack_size =3D round_up(prog->aux-=
>stack_depth, 16);
  loongarch/net/bpf_jit.c:        bpf_stack_adjust =3D round_up(ctx->prog=
->aux->stack_depth, 16);
  powerpc/net/bpf_jit_comp.c:     cgctx.stack_size =3D round_up(fp->aux->=
stack_depth, 16);
  riscv/net/bpf_jit_comp32.c:             round_up(ctx->prog->aux->stack_=
depth, STACK_ALIGN);
  riscv/net/bpf_jit_comp64.c:     bpf_stack_adjust =3D round_up(ctx->prog=
->aux->stack_depth, 16);
  s390/net/bpf_jit_comp.c:        u32 stack_depth =3D round_up(fp->aux->s=
tack_depth, 8);
  sparc/net/bpf_jit_comp_64.c:            stack_needed +=3D round_up(stac=
k_depth, 16);
  x86/net/bpf_jit_comp.c:         EMIT3_off32(0x48, 0x81, 0xEC, round_up(=
stack_depth, 8));
  x86/net/bpf_jit_comp.c: int tcc_off =3D -4 - round_up(stack_depth, 8);
  x86/net/bpf_jit_comp.c:                     round_up(stack_depth, 8));
  x86/net/bpf_jit_comp.c: int tcc_off =3D -4 - round_up(stack_depth, 8);
  x86/net/bpf_jit_comp.c:         EMIT3_off32(0x48, 0x81, 0xC4, round_up(=
stack_depth, 8));

In the above, STACK_ALIGN in riscv/net/bpf_jit_comp32.c is defined as 16.
So stack is aligned in either 8 or 16, x86/s390 having 8-byte stack align=
ment and
the rest having 16-byte alignment.

This patch calculates total stack depth based on 16-byte alignment if jit=
 is requested.
For the above failing case, the new stack size will be 32+448+0+32=3D512 =
and no verification
failure. llvm19 regression will be discussed separately in llvm upstream.

  [1] https://lore.kernel.org/bpf/32bde0f0-1881-46c9-931a-673be566c61d@li=
nux.dev/

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ddaf09db1175..10e33d49ca21 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5812,6 +5812,17 @@ static int check_ptr_alignment(struct bpf_verifier=
_env *env,
 					   strict);
 }
=20
+static int round_up_stack_depth(struct bpf_verifier_env *env, int stack_=
depth)
+{
+	if (env->prog->jit_requested)
+		return round_up(stack_depth, 16);
+
+	/* round up to 32-bytes, since this is granularity
+	 * of interpreter stack size
+	 */
+	return round_up(max_t(u32, stack_depth, 1), 32);
+}
+
 /* starting from main bpf function walk all instructions of the function
  * and recursively walk all callees that given function can call.
  * Ignore jump and exit insns.
@@ -5855,10 +5866,8 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx)
 			depth);
 		return -EACCES;
 	}
-	/* round up to 32-bytes, since this is granularity
-	 * of interpreter stack size
-	 */
-	depth +=3D round_up(max_t(u32, subprog[idx].stack_depth, 1), 32);
+
+	depth +=3D round_up_stack_depth(env, subprog[idx].stack_depth);
 	if (depth > MAX_BPF_STACK) {
 		verbose(env, "combined stack size of %d calls is %d. Too large\n",
 			frame + 1, depth);
@@ -5952,7 +5961,7 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx)
 	 */
 	if (frame =3D=3D 0)
 		return 0;
-	depth -=3D round_up(max_t(u32, subprog[idx].stack_depth, 1), 32);
+	depth -=3D round_up_stack_depth(env, subprog[idx].stack_depth);
 	frame--;
 	i =3D ret_insn[frame];
 	idx =3D ret_prog[frame];
--=20
2.34.1


