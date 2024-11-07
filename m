Return-Path: <bpf+bounces-44192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D849BFCA0
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 03:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07439282F9C
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 02:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F35F7E782;
	Thu,  7 Nov 2024 02:41:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB6E40855
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 02:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730947319; cv=none; b=hGWL854mYQiBwjjhFOoKFmRfMPxJCN1k0jssqla6b51v8Z9Hk90j+7yW0imnLg1RPQ57JcTO2OoKtuxEDDy8waCun6xJ5ED0b1SUXkhBTOvycjncl7ViDuRL76oMEDytI4OqxM975b/i6XX8Jjl+Q5xytQO3RL3H1+dwHT/BvK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730947319; c=relaxed/simple;
	bh=e6yOAYh3HtklpCU97frRuIwqk4na/DWxw+kUN1kRw9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2gWsSyzNcfO1RebJkONzGrjxgv6X8V0w+e1V6XuhyyaaJ1Ly4fkis6szSWI7H1YQw1Gi5vPiKIvOQD4uuTB08deKQSSZoR5TJQs5nLs4pGFj57BuIcSodsyM+CQAg38oM27AKiV+1r5sQJpJrCGiIBi2UgHckOovZA+VI+M3ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 33C92AD19F2E; Wed,  6 Nov 2024 18:41:54 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v10 3/7] bpf, x86: Avoid repeated usage of bpf_prog->aux->stack_depth
Date: Wed,  6 Nov 2024 18:41:54 -0800
Message-ID: <20241107024154.3356541-1-yonghong.song@linux.dev>
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

Refactor the code to avoid repeated usage of bpf_prog->aux->stack_depth
in do_jit() func. If the private stack is used, the stack_depth will be
0 for that prog. Refactoring make it easy to adjust stack_depth.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 06b080b61aa5..3ff638c37999 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1425,14 +1425,17 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
 	int i, excnt =3D 0;
 	int ilen, proglen =3D 0;
 	u8 *prog =3D temp;
+	u32 stack_depth;
 	int err;
=20
+	stack_depth =3D bpf_prog->aux->stack_depth;
+
 	arena_vm_start =3D bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
 	user_vm_start =3D bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
=20
 	detect_reg_usage(insn, insn_cnt, callee_regs_used);
=20
-	emit_prologue(&prog, bpf_prog->aux->stack_depth,
+	emit_prologue(&prog, stack_depth,
 		      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
 		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
 	/* Exception callback will clobber callee regs for its own use, and
@@ -2128,7 +2131,7 @@ st:			if (is_imm8(insn->off))
=20
 			func =3D (u8 *) __bpf_call_base + imm32;
 			if (tail_call_reachable) {
-				LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
+				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
 				ip +=3D 7;
 			}
 			if (!imm32)
@@ -2145,13 +2148,13 @@ st:			if (is_imm8(insn->off))
 							  &bpf_prog->aux->poke_tab[imm32 - 1],
 							  &prog, image + addrs[i - 1],
 							  callee_regs_used,
-							  bpf_prog->aux->stack_depth,
+							  stack_depth,
 							  ctx);
 			else
 				emit_bpf_tail_call_indirect(bpf_prog,
 							    &prog,
 							    callee_regs_used,
-							    bpf_prog->aux->stack_depth,
+							    stack_depth,
 							    image + addrs[i - 1],
 							    ctx);
 			break;
--=20
2.43.5


