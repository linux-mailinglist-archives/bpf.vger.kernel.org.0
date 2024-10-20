Return-Path: <bpf+bounces-42534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D529A5602
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 21:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7BA1F223F5
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 19:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B50F19580B;
	Sun, 20 Oct 2024 19:16:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71CA10A1F
	for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 19:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729451807; cv=none; b=IpQh29Zq2uKIKseIrO5LGAXnSMyvVcmHePVs+D9E9QSN78tn5QfpZd7hrfh18XyBNEiA9fOteEDxGNcj8cGfe/0/5LLV3tMddAqw9KeqH+s1r2OIZ5JFx0H974kGBiLWdQTX7e9nsNLU6ePKC/K5aKaj0i/QtGeQaPqH4ZJ8ABI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729451807; c=relaxed/simple;
	bh=FwN/GS/aq27f3iSl15GyQ4terJAIdlhLTiTAe/mCah8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSOs79aWRWJfida8LCoYxKqIgxmX/GXQhkGhyUp7H1k0vXrM18bbZZ6o62+Z3dJrySR41SiGw+tJbSCXiwZXrbZPdyhvUSCdCfnnLWurZrj49KFQ5vQwl3CBnP2TzDwDAfSU74azX78+IzEV6gQTaW/SPmGaG+sBdydSnE1MCh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 7D770A465E99; Sun, 20 Oct 2024 12:14:13 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v6 5/9] bpf, x86: Refactor func emit_prologue
Date: Sun, 20 Oct 2024 12:14:13 -0700
Message-ID: <20241020191413.2106927-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241020191341.2104841-1-yonghong.song@linux.dev>
References: <20241020191341.2104841-1-yonghong.song@linux.dev>
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


