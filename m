Return-Path: <bpf+bounces-58889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FE5AC2D4F
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 06:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72169E8050
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 04:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9671A3169;
	Sat, 24 May 2025 04:13:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C107F5695
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 04:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748060033; cv=none; b=cRj0BINUYEVlkTDKR7xFyU2a+kv8VnaMc3zZf/t/YcZ1tpsv2KRFTiC9PVf+x4nAj0+3rMkZ8oG2NAaCP74hMjG0GUOB8JGE/Uqehnqt/PULb/5M3PTLmHKlw+I/qg4fu2FVAQVDqLvYR7xMUKExgS5nruVwH+IWJoQyk5nBJSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748060033; c=relaxed/simple;
	bh=mA3lnvOgfv4FWnVNtJ0MkWqBBxCkKfHqrRlpGU8TByM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ius7+pKm+v+xqa62gYd49qEVa8xUCetvv09D+iuk0Rovh+bVAZvkfQjWH8kUZ5ykhcwfLm5OP/Gxqov/ieqWSY58+XbLNu80uvTrBb1yBr5ySY3eazIK5CHsqYA3HN84lP5jxDHKquUjJEZ9wGCZjy5OhDMQeJJfVYeFux6uVVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 694B68194260; Fri, 23 May 2025 21:13:35 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 1/2] bpf: Do not include stack ptr register in precision backtracking bookkeeping
Date: Fri, 23 May 2025 21:13:35 -0700
Message-ID: <20250524041335.4046126-1-yonghong.song@linux.dev>
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
Actually r10 is always precise and there is no need to add it for the pre=
cision
backtracking bookkeeping.

One way to fix the issue is to prevent bt_set_reg() if any src/dst reg is
r10. Andrii suggested to go with push_insn_history() approach to avoid
explicitly checking r10 in backtrack_insn().

This patch added push_insn_history() support for cond_jmp like 'rX <op> r=
Y'
operations. In check_cond_jmp_op(), if any of rX or rY is a stack pointer=
,
push_insn_history() will record such information, and later backtrack_ins=
n()
will do bt_set_reg() properly for those register(s).

  [1] https://lore.kernel.org/bpf/Z%2F8q3xzpU59CIYQE@ly-workstation/

Reported by: Yi Lai <yi1.lai@linux.intel.com>
Fixes: 407958a0e980 ("bpf: encapsulate precision backtracking bookkeeping=
")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h | 12 ++++++++----
 kernel/bpf/verifier.c        | 18 ++++++++++++++++--
 2 files changed, 24 insertions(+), 6 deletions(-)

Changelogs:
  v4 -> v5:
    - v4: https://lore.kernel.org/bpf/20250522050239.2834718-1-yonghong.s=
ong@linux.dev/
    - Simplify implementation in backtrack_insn() and check_cond_jmp_op()=
.
  v3 -> v4:
    - v3: https://lore.kernel.org/bpf/20250521170409.2772304-1-yonghong.s=
ong@linux.dev/
    - Fix an issue in push_cond_jmp_history(). Previously, '!src_reg' was=
 used to
      check whether insn is 'dreg <op> imm' or not. But actually '!src_re=
g' is always
      non-NULL. The new fix is using insn directly.
  v2 -> v3:
    - v2: https://lore.kernel.org/bpf/20250516161029.962760-1-yonghong.so=
ng@linux.dev/
    - In v2, I put sreg_flag/dreg_flag into bpf_insn_hist_entry and the i=
nformation
      includes register numbers. This is not necessary as later insn in b=
acktracking
      can retrieve the register number. So the new change is remove sreg_=
flag/dreg_flag
      from bpf_insn_hist_entry and add two bits in bpf_insn_hist_entry.fl=
ags to
      record whether the registers (cond jump like <reg> op < reg>) are s=
tack pointer
      or not. Other changes depend on this data structure change.
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
index 78c97e12ea4e..256274acb1d8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -356,7 +356,11 @@ enum {
 	INSN_F_SPI_MASK =3D 0x3f, /* 6 bits */
 	INSN_F_SPI_SHIFT =3D 3, /* shifted 3 bits to the left */
=20
-	INSN_F_STACK_ACCESS =3D BIT(9), /* we need 10 bits total */
+	INSN_F_STACK_ACCESS =3D BIT(9),
+
+	INSN_F_DST_REG_STACK =3D BIT(10), /* dst_reg is PTR_TO_STACK */
+	INSN_F_SRC_REG_STACK =3D BIT(11), /* src_reg is PTR_TO_STACK */
+	/* total 12 bits are used now. */
 };
=20
 static_assert(INSN_F_FRAMENO_MASK + 1 >=3D MAX_CALL_FRAMES);
@@ -365,9 +369,9 @@ static_assert(INSN_F_SPI_MASK + 1 >=3D MAX_BPF_STACK =
/ 8);
 struct bpf_insn_hist_entry {
 	u32 idx;
 	/* insn idx can't be bigger than 1 million */
-	u32 prev_idx : 22;
-	/* special flags, e.g., whether insn is doing register stack spill/load=
 */
-	u32 flags : 10;
+	u32 prev_idx : 20;
+	/* special INSN_F_xxx flags */
+	u32 flags : 12;
 	/* additional registers that need precision tracking when this
 	 * jump is backtracked, vector of six 10-bit records
 	 */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d5807d2efc92..831c2eff56e1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4410,8 +4410,10 @@ static int backtrack_insn(struct bpf_verifier_env =
*env, int idx, int subseq_idx,
 			 * before it would be equally necessary to
 			 * propagate it to dreg.
 			 */
-			bt_set_reg(bt, dreg);
-			bt_set_reg(bt, sreg);
+			if (!hist || !(hist->flags & INSN_F_SRC_REG_STACK))
+				bt_set_reg(bt, sreg);
+			if (!hist || !(hist->flags & INSN_F_DST_REG_STACK))
+				bt_set_reg(bt, dreg);
 		} else if (BPF_SRC(insn->code) =3D=3D BPF_K) {
 			 /* dreg <cond> K
 			  * Only dreg still needs precision before
@@ -16407,6 +16409,7 @@ static int check_cond_jmp_op(struct bpf_verifier_=
env *env,
 	struct bpf_reg_state *eq_branch_regs;
 	struct linked_regs linked_regs =3D {};
 	u8 opcode =3D BPF_OP(insn->code);
+	int insn_flags =3D 0;
 	bool is_jmp32;
 	int pred =3D -1;
 	int err;
@@ -16465,6 +16468,9 @@ static int check_cond_jmp_op(struct bpf_verifier_=
env *env,
 				insn->src_reg);
 			return -EACCES;
 		}
+
+		if (src_reg->type =3D=3D PTR_TO_STACK)
+			insn_flags |=3D INSN_F_SRC_REG_STACK;
 	} else {
 		if (insn->src_reg !=3D BPF_REG_0) {
 			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
@@ -16476,6 +16482,14 @@ static int check_cond_jmp_op(struct bpf_verifier=
_env *env,
 		__mark_reg_known(src_reg, insn->imm);
 	}
=20
+	if (dst_reg->type =3D=3D PTR_TO_STACK)
+		insn_flags |=3D INSN_F_DST_REG_STACK;
+	if (insn_flags) {
+		err =3D push_insn_history(env, this_branch, insn_flags, 0);
+		if (err)
+			return err;
+	}
+
 	is_jmp32 =3D BPF_CLASS(insn->code) =3D=3D BPF_JMP32;
 	pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
 	if (pred >=3D 0) {
--=20
2.47.1


