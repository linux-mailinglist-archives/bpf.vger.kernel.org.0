Return-Path: <bpf+bounces-42340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D3A9A30C3
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 00:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7777E1C219F6
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 22:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0171D7E54;
	Thu, 17 Oct 2024 22:32:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2925D1D95A9
	for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 22:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729204342; cv=none; b=fxAunOly08Y6+N6BzyO5llLfq2lEhm0iHvfUhB1KhFkE+zcH4Fdns1eyF7QwCwzopkwnw5D+HcejJuJGXk/tkO5D2yIMmVn4sjUu3P88AXmSkZpRgICJQbXOo6b3isdf9cgVLAU1Ejz+kYjRu6Vo1Ez7bLEHG0a83x0k6LixO/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729204342; c=relaxed/simple;
	bh=FwN/GS/aq27f3iSl15GyQ4terJAIdlhLTiTAe/mCah8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDt9h7RKUMkucX6W2tqFVSH+kAcRfNW6W92P0+UfV2f3JbN9cbT2KOMN38QlttZFpW86CIVpCPr/kFOqkRLF/Vev3HuKwr9+DBEZvxicIKVnfXDR0K0AL/9B6n48b43plCBTVlww+BvylPPJZnCciNHf4RFIms8dJ6INmNAdkvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 582FEA2F0820; Thu, 17 Oct 2024 15:32:04 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v5 5/9] bpf, x86: Refactor func emit_prologue
Date: Thu, 17 Oct 2024 15:32:04 -0700
Message-ID: <20241017223204.3177432-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241017223138.3175885-1-yonghong.song@linux.dev>
References: <20241017223138.3175885-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Refactor function emit_prologue() such that it has bpf_prog as one of
arguments. This can reduce the number of total arguments since later
on there will be more arguments being added to this function.

Also add a variable 'stack_depth' to hold the value for
  bpf_prog->aux->stack_depth
to simplify the code.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 06b080b61aa5..6d24389e58a1 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -489,10 +489,12 @@ static void emit_prologue_tail_call(u8 **pprog, boo=
l is_subprog)
  * bpf_tail_call helper will skip the first X86_TAIL_CALL_OFFSET bytes
  * while jumping to another program
  */
-static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cb=
pf,
-			  bool tail_call_reachable, bool is_subprog,
-			  bool is_exception_cb)
+static void emit_prologue(u8 **pprog, u32 stack_depth, struct bpf_prog *=
bpf_prog,
+			  bool tail_call_reachable)
 {
+	bool ebpf_from_cbpf =3D bpf_prog_was_classic(bpf_prog);
+	bool is_exception_cb =3D bpf_prog->aux->exception_cb;
+	bool is_subprog =3D bpf_is_subprog(bpf_prog);
 	u8 *prog =3D *pprog;
=20
 	emit_cfi(&prog, is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash);
@@ -1424,17 +1426,18 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
 	u64 arena_vm_start, user_vm_start;
 	int i, excnt =3D 0;
 	int ilen, proglen =3D 0;
+	u32 stack_depth;
 	u8 *prog =3D temp;
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
-		      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
-		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
+	emit_prologue(&prog, stack_depth, bpf_prog, tail_call_reachable);
 	/* Exception callback will clobber callee regs for its own use, and
 	 * restore the original callee regs from main prog's stack frame.
 	 */
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


