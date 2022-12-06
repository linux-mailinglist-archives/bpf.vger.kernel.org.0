Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780D4644F61
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 00:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLFXKf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 18:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLFXKe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 18:10:34 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77504298E
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 15:10:32 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6LhJ5n032730
        for <bpf@vger.kernel.org>; Tue, 6 Dec 2022 15:10:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+Ema17lhkGx/i/301jhTliryFi0neBmgVkp0cqpGJQA=;
 b=fVDfLamWjHoGJ91lMKmqjeX+ORVscFWu+1/hvpQZ0OVtiOHePA+e2ZX2TT5CzYivet3D
 JSX/qXnptI7nf8EFUc/SmlwBdaXwk1VBQO9UEWYCHZXgj9zsic7a+Jp/Ib1QMFlmRKSy
 ryhz+SJb+jYy92V1+W3hQVCUj/Df2VojNm4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m9x70xv4w-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 15:10:32 -0800
Received: from twshared25383.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Dec 2022 15:10:31 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 4CD77120B378A; Tue,  6 Dec 2022 15:10:07 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 10/13] bpf, x86: BPF_PROBE_MEM handling for insn->off < 0
Date:   Tue, 6 Dec 2022 15:09:57 -0800
Message-ID: <20221206231000.3180914-11-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221206231000.3180914-1-davemarchevsky@fb.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TGr0BQd9FlNe5FDX_CGNRXdpIzuEiYTv
X-Proofpoint-GUID: TGr0BQd9FlNe5FDX_CGNRXdpIzuEiYTv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_12,2022-12-06_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Current comment in BPF_PROBE_MEM jit code claims that verifier prevents
insn->off < 0, but this appears to not be true irrespective of changes
in this series. Regardless, changes in this series will result in an
example like:

  struct example_node {
    long key;
    long val;
    struct bpf_rb_node node;
  }

  /* In BPF prog, assume root contains example_node nodes */
  struct bpf_rb_node res =3D bpf_rbtree_first(&root);
  if (!res)
    return 1;

  struct example_node n =3D container_of(res, struct example_node, node);
  long key =3D n->key;

Resulting in a load with off =3D -16, as bpf_rbtree_first's return is
modified by verifier to be PTR_TO_BTF_ID of example_node w/ offset =3D
offsetof(struct example_node, node), instead of PTR_TO_BTF_ID of
bpf_rb_node. So it's necessary to support negative insn->off when
jitting BPF_PROBE_MEM.

In order to ensure that page fault for a BPF_PROBE_MEM load of *src_reg +
insn->off is safely handled, we must confirm that *src_reg + insn->off is
in kernel's memory. Two runtime checks are emitted to confirm that:

  1) (*src_reg + insn->off) > boundary between user and kernel address
  spaces
  2) (*src_reg + insn->off) does not overflow to a small positive
  number. This might happen if some function meant to set src_reg
  returns ERR_PTR(-EINVAL) or similar.

Check 1 currently is sligtly off - it compares a

  u64 limit =3D TASK_SIZE_MAX + PAGE_SIZE + abs(insn->off);

to *src_reg, aborting the load if limit is larger. Rewriting this as an
inequality:

  *src_reg > TASK_SIZE_MAX + PAGE_SIZE + abs(insn->off)
  *src_reg - abs(insn->off) > TASK_SIZE_MAX + PAGE_SIZE

shows that this isn't quite right even if insn->off is positive, as we
really want:

  *src_reg + insn->off > TASK_SIZE_MAX + PAGE_SIZE
  *src_reg > TASK_SIZE_MAX + PAGE_SIZE - insn_off

Since *src_reg + insn->off is the address we'll be loading from, not
*src_reg - insn->off or *src_reg - abs(insn->off). So change the
subtraction to an addition and remove the abs(), as comment indicates
that it was only added to ignore negative insn->off.

For Check 2, currently "does not overflow to a small positive number" is
confirmed by emitting an 'add insn->off, src_reg' instruction and
checking for carry flag. While this works fine for a positive insn->off,
a small negative insn->off like -16 is almost guaranteed to wrap over to
a small positive number when added to any kernel address.

This patch addresses this by not doing Check 2 at BPF prog runtime when
insn->off is negative, rather doing a stronger check at JIT-time. The
logic supporting this is as follows:

1) Assume insn->off is negative, call the largest such negative offset
   MAX_NEGATIVE_OFF. So insn->off >=3D MAX_NEGATIVE_OFF for all possible
   insn->off.

2) *src_reg + insn->off will not wrap over to an unexpected address by
   virtue of negative insn->off, but it might wrap under if
   -insn->off > *src_reg, as that implies *src_reg + insn->off < 0

3) Inequality (TASK_SIZE_MAX + PAGE_SIZE - insn->off) > (TASK_SIZE_MAX + =
PAGE_SIZE)
   must be true since insn->off is negative.

4) If we've completed check 1, we know that
   src_reg >=3D (TASK_SIZE_MAX + PAGE_SIZE - insn->off)

5) Combining statements 3 and 4, we know src_reg > (TASK_SIZE_MAX + PAGE_=
SIZE)

6) By statements 1, 4, and 5, if we can prove
   (TASK_SIZE_MAX + PAGE_SIZE) > -MAX_NEGATIVE_OFF, we'll know that
   (TASK_SIZE_MAX + PAGE_SIZE) > -insn->off for all possible insn->off
   values. We can rewrite this as (TASK_SIZE_MAX + PAGE_SIZE) +
   MAX_NEGATIVE_OFF > 0.

   Since src_reg > TASK_SIZE_MAX + PAGE_SIZE and MAX_NEGATIVE_OFF is
   negative, if the previous inequality is true,
   src_reg + MAX_NEGATIVE_OFF > 0 is also true for all src_reg values.
   Similarly, since insn->off >=3D MAX_NEGATIVE_OFF for all possible
   negative insn->off vals, src_reg + insn->off > 0 and there can be no
   wrapping under.

So proving (TASK_SIZE_MAX + PAGE_SIZE) + MAX_NEGATIVE_OFF > 0 implies
*src_reg + insn->off > 0 for any src_reg that's passed check 1 and any
negative insn->off. Luckily the former inequality does not need to be
checked at runtime, and in fact could be a static_assert if
TASK_SIZE_MAX wasn't determined by a function when CONFIG_X86_5LEVEL
kconfig is used.

Regardless, we can just check (TASK_SIZE_MAX + PAGE_SIZE) +
MAX_NEGATIVE_OFF > 0 once per do_jit call instead of emitting a runtime
check. Given that insn->off is a s16 and is unlikely to grow larger,
this check should always succeed on any x86 processor made in the 21st
century. If it doesn't fail all do_jit calls and complain loudly with
the assumption that the BPF subsystem is misconfigured or has a bug.

A few instructions are saved for negative insn->offs as a result. Using
the struct example_node / off =3D -16 example from before, code looks
like:

BEFORE CHANGE
  72:   movabs $0x800000000010,%r11
  7c:   cmp    %r11,%rdi
  7f:   jb     0x000000000000008d         (check 1 on 7c and here)
  81:   mov    %rdi,%r11
  84:   add    $0xfffffffffffffff0,%r11   (check 2, will set carry for al=
most any r11, so bug for
  8b:   jae    0x0000000000000091          negative insn->off)
  8d:   xor    %edi,%edi                  (as a result long key =3D n->ke=
y; will be 0'd out here)
  8f:   jmp    0x0000000000000095
  91:   mov    -0x10(%rdi),%rdi
  95:

AFTER CHANGE:
  5a:   movabs $0x800000000010,%r11
  64:   cmp    %r11,%rdi
  67:   jae    0x000000000000006d     (check 1 on 64 and here, but now JN=
C instead of JC)
  69:   xor    %edi,%edi              (no check 2, 0 out if %rdi - %r11 <=
 0)
  6b:   jmp    0x0000000000000071
  6d:   mov    -0x10(%rdi),%rdi
  71:

We could do the same for insn->off =3D=3D 0, but for now keep code
generation unchanged for previously working nonnegative insn->offs.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 123 +++++++++++++++++++++++++++---------
 1 file changed, 92 insertions(+), 31 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 36ffe67ad6e5..843f619d0d35 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -11,6 +11,7 @@
 #include <linux/bpf.h>
 #include <linux/memory.h>
 #include <linux/sort.h>
+#include <linux/limits.h>
 #include <asm/extable.h>
 #include <asm/set_memory.h>
 #include <asm/nospec-branch.h>
@@ -94,6 +95,7 @@ static int bpf_size_to_x86_bytes(int bpf_size)
  */
 #define X86_JB  0x72
 #define X86_JAE 0x73
+#define X86_JNC 0x73
 #define X86_JE  0x74
 #define X86_JNE 0x75
 #define X86_JBE 0x76
@@ -950,6 +952,36 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 =
src_reg, bool is64, u8 op)
 	*pprog =3D prog;
 }
=20
+/* Check that condition necessary for PROBE_MEM handling for insn->off <=
 0
+ * holds.
+ *
+ * This could be a static_assert((TASK_SIZE_MAX + PAGE_SIZE) > -S16_MIN)=
,
+ * but TASK_SIZE_MAX can't always be evaluated at compile time, so let's=
 not
+ * assume insn->off size either
+ */
+static int check_probe_mem_task_size_overflow(void)
+{
+	struct bpf_insn insn;
+	s64 max_negative;
+
+	switch (sizeof(insn.off)) {
+	case 2:
+		max_negative =3D S16_MIN;
+		break;
+	default:
+		pr_err("bpf_jit_error: unexpected bpf_insn->off size\n");
+		return -EFAULT;
+	}
+
+	if (!((TASK_SIZE_MAX + PAGE_SIZE) > -max_negative)) {
+		pr_err("bpf jit error: assumption does not hold:\n");
+		pr_err("\t(TASK_SIZE_MAX + PAGE_SIZE) + (max negative insn->off) > 0\n=
");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
=20
 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *=
rw_image,
@@ -967,6 +999,10 @@ static int do_jit(struct bpf_prog *bpf_prog, int *ad=
drs, u8 *image, u8 *rw_image
 	u8 *prog =3D temp;
 	int err;
=20
+	err =3D check_probe_mem_task_size_overflow();
+	if (err)
+		return err;
+
 	detect_reg_usage(insn, insn_cnt, callee_regs_used,
 			 &tail_call_seen);
=20
@@ -1359,20 +1395,30 @@ st:			if (is_imm8(insn->off))
 		case BPF_LDX | BPF_MEM | BPF_DW:
 		case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
 			if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM) {
-				/* Though the verifier prevents negative insn->off in BPF_PROBE_MEM
-				 * add abs(insn->off) to the limit to make sure that negative
-				 * offset won't be an issue.
-				 * insn->off is s16, so it won't affect valid pointers.
-				 */
-				u64 limit =3D TASK_SIZE_MAX + PAGE_SIZE + abs(insn->off);
-				u8 *end_of_jmp1, *end_of_jmp2;
-
 				/* Conservatively check that src_reg + insn->off is a kernel address=
:
-				 * 1. src_reg + insn->off >=3D limit
-				 * 2. src_reg + insn->off doesn't become small positive.
-				 * Cannot do src_reg + insn->off >=3D limit in one branch,
-				 * since it needs two spare registers, but JIT has only one.
+				 * 1. src_reg + insn->off >=3D TASK_SIZE_MAX + PAGE_SIZE
+				 * 2. src_reg + insn->off doesn't overflow and become small positive
+				 *
+				 * For check 1, to save regs, do
+				 * src_reg >=3D (TASK_SIZE_MAX + PAGE_SIZE - insn->off) call rhs
+				 * of inequality 'limit'
+				 *
+				 * For check 2:
+				 * If insn->off is positive, add src_reg + insn->off and check
+				 * overflow directly
+				 * If insn->off is negative, we know that
+				 *   (TASK_SIZE_MAX + PAGE_SIZE - insn->off) > (TASK_SIZE_MAX + PAGE=
_SIZE)
+				 * and from check 1 we know
+				 *   src_reg >=3D (TASK_SIZE_MAX + PAGE_SIZE - insn->off)
+				 * So if (TASK_SIZE_MAX + PAGE_SIZE) + MAX_NEGATIVE_OFF > 0 we can
+				 * be sure that src_reg + insn->off won't overflow in either
+				 * direction and avoid runtime check entirely.
+				 *
+				 * check_probe_mem_task_size_overflow confirms the above assumption
+				 * at the beginning of this function
 				 */
+				u64 limit =3D TASK_SIZE_MAX + PAGE_SIZE - insn->off;
+				u8 *end_of_jmp1, *end_of_jmp2;
=20
 				/* movabsq r11, limit */
 				EMIT2(add_1mod(0x48, AUX_REG), add_1reg(0xB8, AUX_REG));
@@ -1381,32 +1427,47 @@ st:			if (is_imm8(insn->off))
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
+				if (insn->off >=3D 0) {
+					/* cmp src_reg, r11 */
+					/* if unsigned '<' goto end_of_jmp2 */
+					EMIT2(X86_JB, 0);
+					end_of_jmp1 =3D prog;
+
+					/* mov r11, src_reg */
+					emit_mov_reg(&prog, true, AUX_REG, src_reg);
+					/* add r11, insn->off */
+					maybe_emit_1mod(&prog, AUX_REG, true);
+					EMIT2_off32(0x81, add_1reg(0xC0, AUX_REG), insn->off);
+					/* jmp if not carry to start_of_ldx
+					 * Otherwise ERR_PTR(-EINVAL) + 128 will be the user addr
+					 * that has to be rejected.
+					 */
+					EMIT2(X86_JNC, 0);
+					end_of_jmp2 =3D prog;
+				} else {
+					/* cmp src_reg, r11 */
+					/* if unsigned '>=3D' goto start_of_ldx
+					 * w/o needing to do check 2
+					 */
+					EMIT2(X86_JAE, 0);
+					end_of_jmp1 =3D prog;
+				}
=20
 				/* xor dst_reg, dst_reg */
 				emit_mov_imm32(&prog, false, dst_reg, 0);
 				/* jmp byte_after_ldx */
 				EMIT2(0xEB, 0);
=20
-				/* populate jmp_offset for JB above to jump to xor dst_reg */
-				end_of_jmp1[-1] =3D end_of_jmp2 - end_of_jmp1;
-				/* populate jmp_offset for JNC above to jump to start_of_ldx */
 				start_of_ldx =3D prog;
-				end_of_jmp2[-1] =3D start_of_ldx - end_of_jmp2;
+				if (insn->off >=3D 0) {
+					/* populate jmp_offset for JB above to jump to xor dst_reg */
+					end_of_jmp1[-1] =3D end_of_jmp2 - end_of_jmp1;
+					/* populate jmp_offset for JNC above to jump to start_of_ldx */
+					end_of_jmp2[-1] =3D start_of_ldx - end_of_jmp2;
+				} else {
+					/* populate jmp_offset for JAE above to jump to start_of_ldx */
+					end_of_jmp1[-1] =3D start_of_ldx - end_of_jmp1;
+				}
 			}
 			emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
 			if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM) {
--=20
2.30.2

