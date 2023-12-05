Return-Path: <bpf+bounces-16771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D50805DDD
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 19:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C52281C7D
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 18:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047FD3D3BE;
	Tue,  5 Dec 2023 18:43:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8741F10DD
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 10:43:22 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5IfMcL015699
	for <bpf@vger.kernel.org>; Tue, 5 Dec 2023 10:43:21 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3usxjtn4eg-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 10:43:21 -0800
Received: from twshared15991.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 5 Dec 2023 10:43:18 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id D9EF43CA17064; Tue,  5 Dec 2023 10:43:14 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v4 bpf-next 09/10] selftests/bpf: validate precision logic in partial_stack_load_preserves_zeros
Date: Tue, 5 Dec 2023 10:42:47 -0800
Message-ID: <20231205184248.1502704-10-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205184248.1502704-1-andrii@kernel.org>
References: <20231205184248.1502704-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: FdHx6wp6xQjwpSpWBG4E9HS1acRLPuYE
X-Proofpoint-ORIG-GUID: FdHx6wp6xQjwpSpWBG4E9HS1acRLPuYE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_14,2023-12-05_01,2023-05-22_02

Enhance partial_stack_load_preserves_zeros subtest with detailed
precision propagation log checks. We know expect fp-16 to be spilled,
initially imprecise, zero const register, which is later marked as
precise even when partial stack slot load is performed, even if it's not
a register fill (!).

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/progs/verifier_spill_fill.c    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/to=
ols/testing/selftests/bpf/progs/verifier_spill_fill.c
index 41fd61299eab..df4920da3472 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -495,6 +495,22 @@ char single_byte_buf[1] SEC(".data.single_byte_buf")=
;
 SEC("raw_tp")
 __log_level(2)
 __success
+/* make sure fp-8 is all STACK_ZERO */
+__msg("2: (7a) *(u64 *)(r10 -8) =3D 0          ; R10=3Dfp0 fp-8_w=3D0000=
0000")
+/* but fp-16 is spilled IMPRECISE zero const reg */
+__msg("4: (7b) *(u64 *)(r10 -16) =3D r0        ; R0_w=3D0 R10=3Dfp0 fp-1=
6_w=3D0")
+/* and now check that precision propagation works even for such tricky c=
ase */
+__msg("10: (71) r2 =3D *(u8 *)(r10 -9)         ; R2_w=3DP0 R10=3Dfp0 fp-=
16_w=3D0")
+__msg("11: (0f) r1 +=3D r2")
+__msg("mark_precise: frame0: last_idx 11 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 10: (71) r2 =3D *=
(u8 *)(r10 -9)")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 9: (bf) r1 =3D r=
6")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 8: (73) *(u8 *)(=
r1 +0) =3D r2")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 7: (0f) r1 +=3D =
r2")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 6: (71) r2 =3D *=
(u8 *)(r10 -1)")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 5: (bf) r1 =3D r=
6")
+__msg("mark_precise: frame0: regs=3D stack=3D-16 before 4: (7b) *(u64 *)=
(r10 -16) =3D r0")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 3: (b7) r0 =3D 0"=
)
 __naked void partial_stack_load_preserves_zeros(void)
 {
 	asm volatile (
--=20
2.34.1


