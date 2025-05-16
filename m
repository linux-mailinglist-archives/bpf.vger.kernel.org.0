Return-Path: <bpf+bounces-58408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A4EABA0A2
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 18:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA9A5060DD
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 16:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365D71A256B;
	Fri, 16 May 2025 16:10:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88219323D
	for <bpf@vger.kernel.org>; Fri, 16 May 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747411845; cv=none; b=CMA3aj06aZUEsJN/hJMFIyFXLvVh6wBmp3kIHF5muuRhHJaUfc3kd3Xv63vWuCrciRHGow4z5ACWMU4l97t8qyWnO3lcq3vynJqfFwEKbVekkJI4w3ZyCdEBI9v4CSciAA4XEo5oRn3uba3ILRm+JHxDf+y2+pcsRoLLplOJzkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747411845; c=relaxed/simple;
	bh=5xnJq+Ik5zkgSYOTWadzflXT5o043VyR2nfPWA7C+eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LeAFX/T0Sfs/pYPQrVqdKpjhsvRXrYt0Nwiy8kws222BmsMkaQJfngeY194lFf6bkqA7TUoHEO0p+hIiylNp7PLPXfKYub8Q97FfWqeY0LXKNOHAbwXXF9U/8EX+7/x8i8gcjwtINAidJ/bSPJWWvfhlAsA50tqRK6vLBOyuR3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 1E4107932EC0; Fri, 16 May 2025 09:10:29 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 1/2] bpf: Do not include r10 in precision backtracking bookkeeping
Date: Fri, 16 May 2025 09:10:29 -0700
Message-ID: <20250516161029.962760-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Yi Lai reported an issue ([1]) where the following warning appears
in kernel dmesg:
  [   60.643604] verifier backtracking bug
  [   60.643635] WARNING: CPU: 10 PID: 2315 at kernel/bpf/verifier.c:4302=
 __mark_chain_precision+0x3a6c/0x3e10
  [   60.648428] Modules linked in: bpf_testmod(OE)
  [   60.650471] CPU: 10 UID: 0 PID: 2315 Comm: test_progs Tainted: G    =
       OE       6.15.0-rc4-gef11287f8289-dirty #327 PREEMPT(full)
  [   60.654385] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
  [   60.656682] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
  [   60.660475] RIP: 0010:__mark_chain_precision+0x3a6c/0x3e10
  [   60.662814] Code: 5a 30 84 89 ea e8 c4 d9 01 00 80 3d 3e 7d d8 04 00=
 0f 85 60 fa ff ff c6 05 31 7d d8 04
                       01 48 c7 c7 00 58 30 84 e8 c4 06 a5 ff <0f> 0b e9 =
46 fa ff ff 48 ...
  [   60.668720] RSP: 0018:ffff888116cc7298 EFLAGS: 00010246
  [   60.671075] RAX: 54d70e82dfd31900 RBX: ffff888115b65e20 RCX: 0000000=
000000000
  [   60.673659] RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000=
0ffffffff
  [   60.676241] RBP: 0000000000000400 R08: ffff8881f6f23bd3 R09: 1ffff11=
03ede477a
  [   60.678787] R10: dffffc0000000000 R11: ffffed103ede477b R12: ffff888=
115b60ae8
  [   60.681420] R13: 1ffff11022b6cbc4 R14: 00000000fffffff2 R15: 0000000=
000000001
  [   60.684030] FS:  00007fc2aedd80c0(0000) GS:ffff88826fa8a000(0000) kn=
lGS:0000000000000000
  [   60.686837] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [   60.689027] CR2: 000056325369e000 CR3: 000000011088b002 CR4: 0000000=
000370ef0
  [   60.691623] Call Trace:
  [   60.692821]  <TASK>
  [   60.693960]  ? __pfx_verbose+0x10/0x10
  [   60.695656]  ? __pfx_disasm_kfunc_name+0x10/0x10
  [   60.697495]  check_cond_jmp_op+0x16f7/0x39b0
  [   60.699237]  do_check+0x58fa/0xab10
  ...

Further analysis shows the warning is at line 4302 as below:

  4294                 /* static subprog call instruction, which
  4295                  * means that we are exiting current subprog,
  4296                  * so only r1-r5 could be still requested as
  4297                  * precise, r0 and r6-r10 or any stack slot in
  4298                  * the current frame should be zero by now
  4299                  */
  4300                 if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
  4301                         verbose(env, "BUG regs %x\n", bt_reg_mask(=
bt));
  4302                         WARN_ONCE(1, "verifier backtracking bug");
  4303                         return -EFAULT;
  4304                 }

With the below test (also in the next patch):
  __used __naked static void __bpf_jmp_r10(void)
  {
	asm volatile (
	"r2 =3D 2314885393468386424 ll;"
	"goto +0;"
	"if r2 <=3D r10 goto +3;"
	"if r1 >=3D -1835016 goto +0;"
	"if r2 <=3D 8 goto +0;"
	"if r3 <=3D 0 goto +0;"
	"exit;"
	::: __clobber_all);
  }

  SEC("?raw_tp")
  __naked void bpf_jmp_r10(void)
  {
	asm volatile (
	"r3 =3D 0 ll;"
	"call __bpf_jmp_r10;"
	"r0 =3D 0;"
	"exit;"
	::: __clobber_all);
  }

The following is the verifier failure log:
  0: (18) r3 =3D 0x0                      ; R3_w=3D0
  2: (85) call pc+2
  caller:
   R10=3Dfp0
  callee:
   frame1: R1=3Dctx() R3_w=3D0 R10=3Dfp0
  5: frame1: R1=3Dctx() R3_w=3D0 R10=3Dfp0
  ; asm volatile ("                                 \ @ verifier_precisio=
n.c:184
  5: (18) r2 =3D 0x20202000256c6c78       ; frame1: R2_w=3D0x20202000256c=
6c78
  7: (05) goto pc+0
  8: (bd) if r2 <=3D r10 goto pc+3        ; frame1: R2_w=3D0x20202000256c=
6c78 R10=3Dfp0
  9: (35) if r1 >=3D 0xffe3fff8 goto pc+0         ; frame1: R1=3Dctx()
  10: (b5) if r2 <=3D 0x8 goto pc+0
  mark_precise: frame1: last_idx 10 first_idx 0 subseq_idx -1
  mark_precise: frame1: regs=3Dr2 stack=3D before 9: (35) if r1 >=3D 0xff=
e3fff8 goto pc+0
  mark_precise: frame1: regs=3Dr2 stack=3D before 8: (bd) if r2 <=3D r10 =
goto pc+3
  mark_precise: frame1: regs=3Dr2,r10 stack=3D before 7: (05) goto pc+0
  mark_precise: frame1: regs=3Dr2,r10 stack=3D before 5: (18) r2 =3D 0x20=
202000256c6c78
  mark_precise: frame1: regs=3Dr10 stack=3D before 2: (85) call pc+2
  BUG regs 400

The main failure reason is due to r10 in precision backtracking bookkeepi=
ng.
Actually r10 is always precise and there is no need to add it the precisi=
on
backtracking bookkeeping.

One way to fix the issue is to prevent bt_set_reg() if any src/dst reg is
r10. Andrii suggested to go with push_insn_history() approach to avoid
explicitly checking r10 in backtrack_insn().

This patch added push_insn_history() support for cond_jmp like 'rX <op> r=
Y'
operations. In check_cond_jmp_op(), if any of rX or rY is r10, push_insn_=
history()
will not record that register, and later backtrack_insn() will not do
bt_set_reg() for those registers.

  [1] https://lore.kernel.org/bpf/Z%2F8q3xzpU59CIYQE@ly-workstation/

Reported by: Yi Lai <yi1.lai@linux.intel.com>
Fixes: 407958a0e980 ("bpf: encapsulate precision backtracking bookkeeping=
")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |  7 ++++
 kernel/bpf/verifier.c        | 69 +++++++++++++++++++++++++++++-------
 2 files changed, 64 insertions(+), 12 deletions(-)

Changelogs:
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20250511162758.281071-1-yonghong.so=
ng@linux.dev/
    - In v1, we check r10 register explicitly in backtrack_insn() to deci=
de
      whether we should do bt_set_reg() or not. Andrii suggested to do
      push_insn_history() instead. Whether a particular register (r10 in =
this case)
      should be available for backtracking or not is in check_cond_jmp_op=
(),
      and such information is pushed with push_insn_history(). Later in b=
acktrack_insn(),
      such info is retrieved to decide whether precision marking should b=
e
      done or not. This apporach can avoid explicit checking for r10 in b=
acktrack_insn().

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index cedd66867ecf..9d3fdabeeaf4 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -357,6 +357,8 @@ enum {
 	INSN_F_SPI_SHIFT =3D 3, /* shifted 3 bits to the left */
=20
 	INSN_F_STACK_ACCESS =3D BIT(9), /* we need 10 bits total */
+
+	INSN_F_REG_ACCESS =3D BIT(4), /* we need 5 bits total */
 };
=20
 static_assert(INSN_F_FRAMENO_MASK + 1 >=3D MAX_CALL_FRAMES);
@@ -372,6 +374,11 @@ struct bpf_insn_hist_entry {
 	 * jump is backtracked, vector of six 10-bit records
 	 */
 	u64 linked_regs;
+	/* special flag, e.g., whether reg is used for non-load/store insns
+	 * during precision backtracking.
+	 */
+	u8 sreg_flag;
+	u8 dreg_flag;
 };
=20
 /* Maximum number of register states that can exist at once */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f6d3655b3a7a..013b6651a567 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3743,6 +3743,11 @@ static int check_reg_arg(struct bpf_verifier_env *=
env, u32 regno,
 	return __check_reg_arg(env, state->regs, regno, t);
 }
=20
+static int insn_reg_with_access_flag(int reg)
+{
+	return INSN_F_REG_ACCESS | reg;
+}
+
 static int insn_stack_access_flags(int frameno, int spi)
 {
 	return INSN_F_STACK_ACCESS | (spi << INSN_F_SPI_SHIFT) | frameno;
@@ -3848,7 +3853,7 @@ static void linked_regs_unpack(u64 val, struct link=
ed_regs *s)
=20
 /* for any branch, call, exit record the history of jmps in the given st=
ate */
 static int push_insn_history(struct bpf_verifier_env *env, struct bpf_ve=
rifier_state *cur,
-			     int insn_flags, u64 linked_regs)
+			     int insn_flags, u64 linked_regs, u8 sreg_flag, u8 dreg_flag)
 {
 	struct bpf_insn_hist_entry *p;
 	size_t alloc_size;
@@ -3867,6 +3872,8 @@ static int push_insn_history(struct bpf_verifier_en=
v *env, struct bpf_verifier_s
 			  "verifier insn history bug: insn_idx %d linked_regs !=3D 0: %#llx\n=
",
 			  env->insn_idx, env->cur_hist_ent->linked_regs);
 		env->cur_hist_ent->linked_regs =3D linked_regs;
+		env->cur_hist_ent->sreg_flag =3D sreg_flag;
+		env->cur_hist_ent->dreg_flag =3D dreg_flag;
 		return 0;
 	}
=20
@@ -3884,6 +3891,8 @@ static int push_insn_history(struct bpf_verifier_en=
v *env, struct bpf_verifier_s
 	p->prev_idx =3D env->prev_insn_idx;
 	p->flags =3D insn_flags;
 	p->linked_regs =3D linked_regs;
+	p->sreg_flag =3D sreg_flag;
+	p->dreg_flag =3D dreg_flag;
=20
 	cur->insn_hist_end++;
 	env->cur_hist_ent =3D p;
@@ -4406,6 +4415,8 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
 			 */
 			return 0;
 		} else if (BPF_SRC(insn->code) =3D=3D BPF_X) {
+			bool dreg_precise, sreg_precise;
+
 			if (!bt_is_reg_set(bt, dreg) && !bt_is_reg_set(bt, sreg))
 				return 0;
 			/* dreg <cond> sreg
@@ -4414,8 +4425,16 @@ static int backtrack_insn(struct bpf_verifier_env =
*env, int idx, int subseq_idx,
 			 * before it would be equally necessary to
 			 * propagate it to dreg.
 			 */
-			bt_set_reg(bt, dreg);
-			bt_set_reg(bt, sreg);
+			if (!hist)
+				return 0;
+			dreg_precise =3D hist->dreg_flag =3D=3D insn_reg_with_access_flag(dre=
g);
+			sreg_precise =3D hist->sreg_flag =3D=3D insn_reg_with_access_flag(sre=
g);
+			if (!dreg_precise && !sreg_precise)
+				return 0;
+			if (dreg_precise)
+				bt_set_reg(bt, dreg);
+			if (sreg_precise)
+				bt_set_reg(bt, sreg);
 		} else if (BPF_SRC(insn->code) =3D=3D BPF_K) {
 			 /* dreg <cond> K
 			  * Only dreg still needs precision before
@@ -5115,7 +5134,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
 	}
=20
 	if (insn_flags)
-		return push_insn_history(env, env->cur_state, insn_flags, 0);
+		return push_insn_history(env, env->cur_state, insn_flags, 0, 0, 0);
 	return 0;
 }
=20
@@ -5422,7 +5441,7 @@ static int check_stack_read_fixed_off(struct bpf_ve=
rifier_env *env,
 		insn_flags =3D 0; /* we are not restoring spilled register */
 	}
 	if (insn_flags)
-		return push_insn_history(env, env->cur_state, insn_flags, 0);
+		return push_insn_history(env, env->cur_state, insn_flags, 0, 0, 0);
 	return 0;
 }
=20
@@ -16414,6 +16433,27 @@ static void sync_linked_regs(struct bpf_verifier=
_state *vstate, struct bpf_reg_s
 	}
 }
=20
+static int push_cond_jmp_history(struct bpf_verifier_env *env, struct bp=
f_verifier_state *state,
+				 struct bpf_insn *insn, u64 linked_regs)
+{
+	int err;
+
+	if ((BPF_SRC(insn->code) !=3D BPF_X ||
+	     (insn->src_reg =3D=3D BPF_REG_FP && insn->dst_reg =3D=3D BPF_REG_F=
P)) &&
+	    !linked_regs)
+		return 0;
+
+	err =3D push_insn_history(env, state, 0, linked_regs,
+		BPF_SRC(insn->code) =3D=3D BPF_X && insn->src_reg !=3D BPF_REG_FP
+			? insn_reg_with_access_flag(insn->src_reg)
+			: 0,
+		BPF_SRC(insn->code) =3D=3D BPF_X && insn->dst_reg !=3D BPF_REG_FP
+			? insn_reg_with_access_flag(insn->dst_reg)
+			: 0);
+
+	return err;
+}
+
 static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			     struct bpf_insn *insn, int *insn_idx)
 {
@@ -16517,6 +16557,9 @@ static int check_cond_jmp_op(struct bpf_verifier_=
env *env,
 		    !sanitize_speculative_path(env, insn, *insn_idx + 1,
 					       *insn_idx))
 			return -EFAULT;
+		err =3D push_cond_jmp_history(env, this_branch, insn, 0);
+		if (err)
+			return err;
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch, this_branch->curframe);
 		*insn_idx +=3D insn->off;
@@ -16531,6 +16574,9 @@ static int check_cond_jmp_op(struct bpf_verifier_=
env *env,
 					       *insn_idx + insn->off + 1,
 					       *insn_idx))
 			return -EFAULT;
+		err =3D push_cond_jmp_history(env, this_branch, insn, 0);
+		if (err)
+			return err;
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch, this_branch->curframe);
 		return 0;
@@ -16545,11 +16591,10 @@ static int check_cond_jmp_op(struct bpf_verifie=
r_env *env,
 		collect_linked_regs(this_branch, src_reg->id, &linked_regs);
 	if (dst_reg->type =3D=3D SCALAR_VALUE && dst_reg->id)
 		collect_linked_regs(this_branch, dst_reg->id, &linked_regs);
-	if (linked_regs.cnt > 1) {
-		err =3D push_insn_history(env, this_branch, 0, linked_regs_pack(&linke=
d_regs));
-		if (err)
-			return err;
-	}
+	err =3D push_cond_jmp_history(env, this_branch, insn,
+				    linked_regs.cnt > 1 ? linked_regs_pack(&linked_regs) : 0);
+	if (err)
+		return err;
=20
 	other_branch =3D push_stack(env, *insn_idx + insn->off + 1, *insn_idx,
 				  false);
@@ -19243,7 +19288,7 @@ static int is_state_visited(struct bpf_verifier_e=
nv *env, int insn_idx)
 			 * the current state.
 			 */
 			if (is_jmp_point(env, env->insn_idx))
-				err =3D err ? : push_insn_history(env, cur, 0, 0);
+				err =3D err ? : push_insn_history(env, cur, 0, 0, 0, 0);
 			err =3D err ? : propagate_precision(env, &sl->state);
 			if (err)
 				return err;
@@ -19494,7 +19539,7 @@ static int do_check(struct bpf_verifier_env *env)
 		}
=20
 		if (is_jmp_point(env, env->insn_idx)) {
-			err =3D push_insn_history(env, state, 0, 0);
+			err =3D push_insn_history(env, state, 0, 0, 0, 0);
 			if (err)
 				return err;
 		}
--=20
2.47.1


