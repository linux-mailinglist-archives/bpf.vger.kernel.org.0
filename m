Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C4B64F34C
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 22:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiLPVng (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 16:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPVnf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 16:43:35 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E23F33C26
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 13:43:34 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2BGJx5cb023005
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 13:43:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=A7JiwiOqjLRQau/wCT0ef1cLezkiMDJE6GDX2Kzrszk=;
 b=ZUc/9TFp3GYAVdC8eDvBGIAC0NnpLulxZ8Ri5y0aRHju6Awi0g4vaS8ozOinETfsPwNg
 tYx02fECkIx+Fgt1jhsKi+VLSQ+pg0Pl700/lNt3bxxzNC/S5hTpiGGakM6oie8+bvvO
 z4zYjfYMOjT9NNAWyKSE80hVa3lvGEmYkKE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3mgsfdawdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 13:43:33 -0800
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 16 Dec 2022 13:43:30 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id E04F912A1EDA7; Fri, 16 Dec 2022 13:43:21 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@meta.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH v3 bpf-next 1/2] bpf, x86: Improve PROBE_MEM runtime load check
Date:   Fri, 16 Dec 2022 13:43:18 -0800
Message-ID: <20221216214319.3408356-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: sEFBiZYK1KKsSixqACG-E3unL1Jq1OvU
X-Proofpoint-ORIG-GUID: sEFBiZYK1KKsSixqACG-E3unL1Jq1OvU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_14,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch rewrites the runtime PROBE_MEM check insns emitted by the BPF
JIT in order to ensure load safety. The changes in the patch fix two
issues with the previous logic and more generally improve size of
emitted code. Paragraphs between this one and "FIX 1" below explain the
purpose of the runtime check and examine the current implementation.

When a load is marked PROBE_MEM - e.g. due to PTR_UNTRUSTED access - the
address being loaded from is not necessarily valid. The BPF jit sets up
exception handlers for each such load which catch page faults and 0 out
the destination register.

Arbitrary register-relative loads can escape this exception handling
mechanism. Specifically, a load like dst_reg =3D *(src_reg + off) will no=
t
trigger BPF exception handling if (src_reg + off) is outside of kernel
address space, resulting in an uncaught page fault. A concrete example
of such behavior is a program like:

  struct result {
    char space[40];
    long a;
  };

  /* if err, returns ERR_PTR(-EINVAL) */
  struct result *ptr =3D get_ptr_maybe_err();
  long x =3D ptr->a;

If get_ptr_maybe_err returns ERR_PTR(-EINVAL) and the result isn't
checked for err, 'result' will be (u64)-EINVAL, a number close to
U64_MAX. The ptr->a load will be > U64_MAX and will wrap over to a small
positive u64, which will be in userspace and thus not covered by BPF
exception handling mechanism.

In order to prevent such loads from occurring, the BPF jit emits some
instructions which do runtime checking of (src_reg + off) and skip the
actual load if it's out of range. As an example, here are instructions
emitted for a %rdi =3D *(%rdi + 0x10) PROBE_MEM load:

  72:   movabs $0x800000000010,%r11 --|
  7c:   cmp    %r11,%rdi              |- 72 - 7f: Check 1
  7f:    jb    0x000000000000008d   --|
  81:   mov    %rdi,%r11             -----|
  84:   add    $0x0000000000000010,%r11   |- 81-8b: Check 2
  8b:   jnc    0x0000000000000091    -----|
  8d:   xor    %edi,%edi             ---- 0 out dest
  8f:   jmp    0x0000000000000095
  91:   mov    0x10(%rdi),%rdi       ---- Actual load
  95:

The JIT considers kernel address space to start at MAX_TASK_SIZE +
PAGE_SIZE. Determining whether a load will be outside of kernel address
space should be a simple check:

  (src_reg + off) >=3D MAX_TASK_SIZE + PAGE_SIZE

But because there is only one spare register when the checking logic is
emitted, this logic is split into two checks:

  Check 1: src_reg >=3D (MAX_TASK_SIZE + PAGE_SIZE - off)
  Check 2: src_reg + off doesn't wrap over U64_MAX and result in small po=
s u64

Emitted insns implementing Checks 1 and 2 are annotated in the above
example. Check 1 can be done with a single spare register since the
source reg by definition is the left-hand-side of the inequality.
Since adding 'off' to both sides of Check 1's inequality results in the
original inequality we want, it's equivalent to testing that inequality.
Except in the case where src_reg + off wraps past U64_MAX, which is why
Check 2 needs to actually add src_reg + off if Check 1 passes - again
using the single spare reg.

FIX 1: The Check 1 inequality listed above is not what current code is
doing. Current code is a bit more pessimistic, instead checking:

  src_reg >=3D (MAX_TASK_SIZE + PAGE_SIZE + abs(off))

The 0x800000000010 in above example is from this current check. If Check
1 was corrected to use the correct right-hand-side, the value would be
0x7ffffffffff0. This patch changes the checking logic more broadly (FIX
2 below will elaborate), fixing this issue as a side-effect of the
rewrite. Regardless, it's important to understand why Check 1 should've
been doing MAX_TASK_SIZE + PAGE_SIZE - off before proceeding.

FIX 2: Current code relies on a 'jnc' to determine whether src_reg + off
addition wrapped over. For negative offsets this logic is incorrect.
Consider Check 2 insns emitted when off =3D -0x10:

  81:   mov    %rdi,%r11
  84:   add    0xfffffffffffffff0,%r11
  8b:   jnc    0x0000000000000091

2's complement representation of -0x10 is a large positive u64. Any
value of src_reg that passes Check 1 will result in carry flag being set
after (src_reg + off) addition. So a load with any negative offset will
always fail Check 2 at runtime and never do the actual load. This patch
fixes the negative offset issue by rewriting both checks in order to not
rely on carry flag.

The rewrite takes advantage of the fact that, while we only have one
scratch reg to hold arbitrary values, we know the offset at JIT time.
This we can use src_reg as a temporary scratch reg to hold src_reg +
offset since we can return it to its original value by later subtracting
offset. As a result we can directly check the original inequality we
care about:

  (src_reg + off) >=3D MAX_TASK_SIZE + PAGE_SIZE

For a load like %rdi =3D *(%rsi + -0x10), this results in emitted code:

  43:   movabs $0x800000000000,%r11
  4d:   add    $0xfffffffffffffff0,%rsi --- src_reg +=3D off
  54:   cmp    %r11,%rsi                --- Check original inequality
  57:   jae    0x000000000000005d
  59:   xor    %edi,%edi
  5b:   jmp    0x0000000000000061
  5d:   mov    0x0(%rdi),%rsi           --- Actual Load
  61:   sub    $0xfffffffffffffff0,%rsi --- src_reg -=3D off

Note that the actual load is always done with offset 0, since previous
insns have already done src_reg +=3D off. Regardless of whether the new
check succeeds or fails, insn 61 is always executed, returning src_reg
to its original value.

Because the goal of these checks is to ensure that loaded-from address
will be protected by BPF exception handler, the new check can safely
ignore any wrapover from insn 4d. If such wrapped-over address passes
insn 54 + 57's cmp-and-jmp it will have such protection so the load can
proceed.

IMPROVEMENTS: The above improved logic is 8 insns vs original logic's 9,
and has 1 fewer jmp. The number of checking insns can be further
improved in common scenarios:

If src_reg =3D=3D dst_reg, the actual load insn will clobber src_reg, so
there's no original src_reg state for the sub insn immediately following
the load to restore, so it can be omitted. In fact, it must be omitted
since it would incorrectly subtract from the result of the load if it
wasn't. So for src_reg =3D=3D dst_reg, JIT emits these insns:

  3c:   movabs $0x800000000000,%r11
  46:   add    $0xfffffffffffffff0,%rdi
  4d:   cmp    %r11,%rdi
  50:   jae    0x0000000000000056
  52:   xor    %edi,%edi
  54:   jmp    0x000000000000005a
  56:   mov    0x0(%rdi),%rdi
  5a:

The only difference from larger example being the omitted sub, which
would've been insn 5a in this example.

If offset =3D=3D 0, we can similarly omit the sub as in previous case, si=
nce
there's nothing added to subtract. For the same reason we can omit the
addition as well, resulting in JIT emitting these insns:

  46:   movabs $0x800000000000,%r11
  4d:   cmp    %r11,%rdi
  50:   jae    0x0000000000000056
  52:   xor    %edi,%edi
  54:   jmp    0x000000000000005a
  56:   mov    0x0(%rdi),%rdi
  5a:

Although the above example also has src_reg =3D=3D dst_reg, the same
offset =3D=3D 0 optimization is valid to apply if src_reg !=3D dst_reg.

To summarize the improvements in emitted insn count for the
check-and-load:

BEFORE:                8 check insns, 3 jmps
AFTER (general case):  7 check insns, 2 jmps (12.5% fewer insn, 33% jmp)
AFTER (src =3D=3D dst):    6 check insns, 2 jmps (25% fewer insn)
AFTER (offset =3D=3D 0):   5 check insns, 2 jmps (37.5% fewer insn)

(Above counts don't include the 1 load insn, just checking around it)

Based on BPF bytecode + JITted x86 insn I saw while experimenting with
these improvements, I expect the src_reg =3D=3D dst_reg case to occur mos=
t
often, followed by offset =3D=3D 0, then the general case.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
v1 -> v2: lore.kernel.org/bpf/20221213182726.325137-1-davemarchevsky@fb.c=
om
  * Remove extraneous paragraph from patch summary (Yonghong)
  * Add Yonghong ack

 arch/x86/net/bpf_jit_comp.c | 70 +++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 36ffe67ad6e5..e3e2b57e4e13 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -992,6 +992,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *add=
rs, u8 *image, u8 *rw_image
 		u8 b2 =3D 0, b3 =3D 0;
 		u8 *start_of_ldx;
 		s64 jmp_offset;
+		s16 insn_off;
 		u8 jmp_cond;
 		u8 *func;
 		int nops;
@@ -1358,57 +1359,52 @@ st:			if (is_imm8(insn->off))
 		case BPF_LDX | BPF_PROBE_MEM | BPF_W:
 		case BPF_LDX | BPF_MEM | BPF_DW:
 		case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
+			insn_off =3D insn->off;
+
 			if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM) {
-				/* Though the verifier prevents negative insn->off in BPF_PROBE_MEM
-				 * add abs(insn->off) to the limit to make sure that negative
-				 * offset won't be an issue.
-				 * insn->off is s16, so it won't affect valid pointers.
+				/* Conservatively check that src_reg + insn->off is a kernel address=
:
+				 *   src_reg + insn->off >=3D TASK_SIZE_MAX + PAGE_SIZE
+				 * src_reg is used as scratch for src_reg +=3D insn->off and restore=
d
+				 * after emit_ldx if necessary
 				 */
-				u64 limit =3D TASK_SIZE_MAX + PAGE_SIZE + abs(insn->off);
-				u8 *end_of_jmp1, *end_of_jmp2;
=20
-				/* Conservatively check that src_reg + insn->off is a kernel address=
:
-				 * 1. src_reg + insn->off >=3D limit
-				 * 2. src_reg + insn->off doesn't become small positive.
-				 * Cannot do src_reg + insn->off >=3D limit in one branch,
-				 * since it needs two spare registers, but JIT has only one.
+				u64 limit =3D TASK_SIZE_MAX + PAGE_SIZE;
+				u8 *end_of_jmp;
+
+				/* At end of these emitted checks, insn->off will have been added
+				 * to src_reg, so no need to do relative load with insn->off offset
 				 */
+				insn_off =3D 0;
=20
 				/* movabsq r11, limit */
 				EMIT2(add_1mod(0x48, AUX_REG), add_1reg(0xB8, AUX_REG));
 				EMIT((u32)limit, 4);
 				EMIT(limit >> 32, 4);
+
+				if (insn->off) {
+					/* add src_reg, insn->off */
+					maybe_emit_1mod(&prog, src_reg, true);
+					EMIT2_off32(0x81, add_1reg(0xC0, src_reg), insn->off);
+				}
+
 				/* cmp src_reg, r11 */
 				maybe_emit_mod(&prog, src_reg, AUX_REG, true);
 				EMIT2(0x39, add_2reg(0xC0, src_reg, AUX_REG));
-				/* if unsigned '<' goto end_of_jmp2 */
-				EMIT2(X86_JB, 0);
-				end_of_jmp1 =3D prog;
-
-				/* mov r11, src_reg */
-				emit_mov_reg(&prog, true, AUX_REG, src_reg);
-				/* add r11, insn->off */
-				maybe_emit_1mod(&prog, AUX_REG, true);
-				EMIT2_off32(0x81, add_1reg(0xC0, AUX_REG), insn->off);
-				/* jmp if not carry to start_of_ldx
-				 * Otherwise ERR_PTR(-EINVAL) + 128 will be the user addr
-				 * that has to be rejected.
-				 */
-				EMIT2(0x73 /* JNC */, 0);
-				end_of_jmp2 =3D prog;
+
+				/* if unsigned '>=3D', goto load */
+				EMIT2(X86_JAE, 0);
+				end_of_jmp =3D prog;
=20
 				/* xor dst_reg, dst_reg */
 				emit_mov_imm32(&prog, false, dst_reg, 0);
 				/* jmp byte_after_ldx */
 				EMIT2(0xEB, 0);
=20
-				/* populate jmp_offset for JB above to jump to xor dst_reg */
-				end_of_jmp1[-1] =3D end_of_jmp2 - end_of_jmp1;
-				/* populate jmp_offset for JNC above to jump to start_of_ldx */
+				/* populate jmp_offset for JAE above to jump to start_of_ldx */
 				start_of_ldx =3D prog;
-				end_of_jmp2[-1] =3D start_of_ldx - end_of_jmp2;
+				end_of_jmp[-1] =3D start_of_ldx - end_of_jmp;
 			}
-			emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
+			emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
 			if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM) {
 				struct exception_table_entry *ex;
 				u8 *_insn =3D image + proglen + (start_of_ldx - temp);
@@ -1417,6 +1413,18 @@ st:			if (is_imm8(insn->off))
 				/* populate jmp_offset for JMP above */
 				start_of_ldx[-1] =3D prog - start_of_ldx;
=20
+				if (insn->off && src_reg !=3D dst_reg) {
+					/* sub src_reg, insn->off
+					 * Restore src_reg after "add src_reg, insn->off" in prev
+					 * if statement. But if src_reg =3D=3D dst_reg, emit_ldx
+					 * above already clobbered src_reg, so no need to restore.
+					 * If add src_reg, insn->off was unnecessary, no need to
+					 * restore either.
+					 */
+					maybe_emit_1mod(&prog, src_reg, true);
+					EMIT2_off32(0x81, add_1reg(0xE8, src_reg), insn->off);
+				}
+
 				if (!bpf_prog->aux->extable)
 					break;
=20
--=20
2.30.2

