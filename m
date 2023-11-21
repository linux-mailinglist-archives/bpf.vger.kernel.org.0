Return-Path: <bpf+bounces-15463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D1C7F2211
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 01:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9028BB21966
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 00:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8EF80B;
	Tue, 21 Nov 2023 00:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1129ABA
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 16:23:16 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKN8H6p018312
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 16:23:15 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uggutgdcu-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 16:23:15 -0800
Received: from twshared19681.14.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 16:22:35 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 4F2B13BD9427D; Mon, 20 Nov 2023 16:22:27 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 02/10] selftests/bpf: add stack access precision test
Date: Mon, 20 Nov 2023 16:22:13 -0800
Message-ID: <20231121002221.3687787-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121002221.3687787-1-andrii@kernel.org>
References: <20231121002221.3687787-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CkILf4F8jgRStO5Li8NQcrEmrvAZiuSF
X-Proofpoint-GUID: CkILf4F8jgRStO5Li8NQcrEmrvAZiuSF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02

Add a new selftests that validates precision tracking for stack access
instruction, using both r10-based and non-r10-based accesses. For
non-r10 ones we also make sure to have non-zero var_off to validate that
final stack offset is tracked properly in instruction history
information inside verifier.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/progs/verifier_subprog_precision.c    | 64 +++++++++++++++++--
 1 file changed, 59 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision=
.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index 9b3844215a36..a796d282077a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -535,14 +535,68 @@ __naked int subprog_spill_into_parent_stack_slot_pr=
ecise(void)
 	);
 }
=20
-__naked __noinline __used
-static __u64 subprog_with_checkpoint(void)
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("17: (0f) r1 +=3D r0")
+__msg("mark_precise: frame0: last_idx 17 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 16: (bf) r1 =3D r=
7")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 15: (27) r0 *=3D =
4")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 14: (79) r0 =3D *=
(u64 *)(r10 -16)")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 13: (7b) *(u64 *=
)(r7 -8) =3D r0")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 12: (79) r0 =3D *=
(u64 *)(r8 +16)")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 11: (7b) *(u64 *=
)(r8 +16) =3D r0")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 10: (79) r0 =3D *=
(u64 *)(r7 -8)")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 9: (7b) *(u64 *)=
(r10 -16) =3D r0")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 8: (07) r8 +=3D -=
32")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 7: (bf) r8 =3D r1=
0")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 6: (07) r7 +=3D -=
8")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 5: (bf) r7 =3D r1=
0")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 21: (95) exit")
+__msg("mark_precise: frame1: regs=3Dr0 stack=3D before 20: (bf) r0 =3D r=
1")
+__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 4: (85) call pc+1=
5")
+__msg("mark_precise: frame0: regs=3Dr1 stack=3D before 3: (bf) r1 =3D r6=
")
+__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 2: (b7) r6 =3D 1"=
)
+__naked int stack_slot_aliases_precision(void)
 {
 	asm volatile (
-		"r0 =3D 0;"
-		/* guaranteed checkpoint if BPF_F_TEST_STATE_FREQ is used */
-		"goto +0;"
+		"r6 =3D 1;"
+		/* pass r6 through r1 into subprog to get it back as r0;
+		 * this whole chain will have to be marked as precise later
+		 */
+		"r1 =3D r6;"
+		"call identity_subprog;"
+		/* let's setup two registers that are aliased to r10 */
+		"r7 =3D r10;"
+		"r7 +=3D -8;"			/* r7 =3D r10 - 8 */
+		"r8 =3D r10;"
+		"r8 +=3D -32;"			/* r8 =3D r10 - 32 */
+		/* now spill subprog's return value (a r6 -> r1 -> r0 chain)
+		 * a few times through different stack pointer regs, making
+		 * sure to use r10, r7, and r8 both in LDX and STX insns, and
+		 * *importantly* also using a combination of const var_off and
+		 * insn->off to validate that we record final stack slot
+		 * correctly, instead of relying on just insn->off derivation,
+		 * which is only valid for r10-based stack offset
+		 */
+		"*(u64 *)(r10 - 16) =3D r0;"
+		"r0 =3D *(u64 *)(r7 - 8);"	/* r7 - 8 =3D=3D r10 - 16 */
+		"*(u64 *)(r8 + 16) =3D r0;"	/* r8 + 16 =3D r10 - 16 */
+		"r0 =3D *(u64 *)(r8 + 16);"
+		"*(u64 *)(r7 - 8) =3D r0;"
+		"r0 =3D *(u64 *)(r10 - 16);"
+		/* get ready to use r0 as an index into array to force precision */
+		"r0 *=3D 4;"
+		"r1 =3D %[vals];"
+		/* here r0->r1->r6 chain is forced to be precise and has to be
+		 * propagated back to the beginning, including through the
+		 * subprog call and all the stack spills and loads
+		 */
+		"r1 +=3D r0;"
+		"r0 =3D *(u32 *)(r1 + 0);"
 		"exit;"
+		:
+		: __imm_ptr(vals)
+		: __clobber_common, "r6"
 	);
 }
=20
--=20
2.34.1


