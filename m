Return-Path: <bpf+bounces-57988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ADCAB2988
	for <lists+bpf@lfdr.de>; Sun, 11 May 2025 18:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FAB189754B
	for <lists+bpf@lfdr.de>; Sun, 11 May 2025 16:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C5425C821;
	Sun, 11 May 2025 16:28:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27D5288CC
	for <bpf@vger.kernel.org>; Sun, 11 May 2025 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746980898; cv=none; b=AcozVoCjHaKAbA8XJK89WvdlQfTGvgfRPPJY7DbDmnQc3WzaE5fF2W/eeShWiYXB3LAfNzZ/zkmXReL5BtlPBMbq3uUH5yekBolKivzW16aoUM4MP5BE4F7MJSSQyru3l8G4FdcbHM1oS2V4aSQ54h2qWVX90VxEHzeKJkQ8SUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746980898; c=relaxed/simple;
	bh=MLwluYfczZA2goP7Kf+fXN0EzYAU6cmYekyG4rp36PY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i72aSYGWLTwK6B/X3eJPfF0LLYZmSeg5aa7DeZI5TRdn3IAenbM7V/1xFbporjAggMBudqUl16GSnEPILG3/gZSY4WVwG2lNz9UYKaGt/SujWlseEjwivShHm4P74qgGQHXiMPnGZslNt5ZzwMV4ewAwY/bj6GWNGSLuz5gTZLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id CD0D974BC042; Sun, 11 May 2025 09:27:58 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 1/2] bpf: Do not include r10 in precision backtracking bookkeeping
Date: Sun, 11 May 2025 09:27:58 -0700
Message-ID: <20250511162758.281071-1-yonghong.song@linux.dev>
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

  4294                         /* static subprog call instruction, which
  4295                          * means that we are exiting current subpr=
og,
  4296                          * so only r1-r5 could be still requested =
as
  4297                          * precise, r0 and r6-r10 or any stack slo=
t in
  4298                          * the current frame should be zero by now
  4299                          */
  4300                         if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
  4301                                 verbose(env, "BUG regs %x\n", bt_r=
eg_mask(bt));
  4302                                 WARN_ONCE(1, "verifier backtrackin=
g bug");
  4303                                 return -EFAULT;
  4304                         }

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

This patch fixed the problem by not adding r10 to prevision backtracking =
bookkeeping.

  [1] https://lore.kernel.org/bpf/Z%2F8q3xzpU59CIYQE@ly-workstation/

Reported by: Yi Lai <yi1.lai@linux.intel.com>
Fixes: 407958a0e980 ("bpf: encapsulate precision backtracking bookkeeping=
")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 28f5a7899bd6..1cb4d80d15c1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4413,8 +4413,10 @@ static int backtrack_insn(struct bpf_verifier_env =
*env, int idx, int subseq_idx,
 			 * before it would be equally necessary to
 			 * propagate it to dreg.
 			 */
-			bt_set_reg(bt, dreg);
-			bt_set_reg(bt, sreg);
+			if (dreg !=3D BPF_REG_FP)
+				bt_set_reg(bt, dreg);
+			if (sreg !=3D BPF_REG_FP)
+				bt_set_reg(bt, sreg);
 		} else if (BPF_SRC(insn->code) =3D=3D BPF_K) {
 			 /* dreg <cond> K
 			  * Only dreg still needs precision before
--=20
2.47.1


