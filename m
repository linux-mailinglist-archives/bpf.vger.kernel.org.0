Return-Path: <bpf+bounces-14899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03277E8DD2
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 02:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DF6280DF5
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 01:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F8517C5;
	Sun, 12 Nov 2023 01:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D307015B6
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 01:06:51 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1089630F9
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:51 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AC0qDJU013669
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:50 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ua86tajm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:50 -0800
Received: from twshared15991.38.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 17:06:49 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 8556B3B5D525B; Sat, 11 Nov 2023 17:06:41 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 08/13] selftests/bpf: adjust OP_EQ/OP_NE handling to use subranges for branch taken
Date: Sat, 11 Nov 2023 17:06:04 -0800
Message-ID: <20231112010609.848406-9-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231112010609.848406-1-andrii@kernel.org>
References: <20231112010609.848406-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: XbXwKNkXBFlt4NMljEZbiLb-rJkuQ8fH
X-Proofpoint-ORIG-GUID: XbXwKNkXBFlt4NMljEZbiLb-rJkuQ8fH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-11_21,2023-11-09_01,2023-05-22_02

Similar to kernel-side BPF verifier logic enhancements, use 32-bit
subrange knowledge for is_branch_taken() logic in reg_bounds selftests.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/reg_bounds.c     | 30 ++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
index 7a524b381ed3..10f3b6898274 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -748,16 +748,38 @@ static int reg_state_branch_taken_op(enum num_t t, =
struct reg_state *x, struct r
 		/* OP_EQ and OP_NE are sign-agnostic */
 		enum num_t tu =3D t_unsigned(t);
 		enum num_t ts =3D t_signed(t);
-		int br_u, br_s;
+		int br_u, br_s, br;
=20
 		br_u =3D range_branch_taken_op(tu, x->r[tu], y->r[tu], op);
 		br_s =3D range_branch_taken_op(ts, x->r[ts], y->r[ts], op);
=20
 		if (br_u >=3D 0 && br_s >=3D 0 && br_u !=3D br_s)
 			ASSERT_FALSE(true, "branch taken inconsistency!\n");
-		if (br_u >=3D 0)
-			return br_u;
-		return br_s;
+
+		/* if 64-bit ranges are indecisive, use 32-bit subranges to
+		 * eliminate always/never taken branches, if possible
+		 */
+		if (br_u =3D=3D -1 && (t =3D=3D U64 || t =3D=3D S64)) {
+			br =3D range_branch_taken_op(U32, x->r[U32], y->r[U32], op);
+			/* we can only reject for OP_EQ, never take branch
+			 * based on lower 32 bits
+			 */
+			if (op =3D=3D OP_EQ && br =3D=3D 0)
+				return 0;
+			/* for OP_NEQ we can be conclusive only if lower 32 bits
+			 * differ and thus inequality branch is always taken
+			 */
+			if (op =3D=3D OP_NE && br =3D=3D 1)
+				return 1;
+
+			br =3D range_branch_taken_op(S32, x->r[S32], y->r[S32], op);
+			if (op =3D=3D OP_EQ && br =3D=3D 0)
+				return 0;
+			if (op =3D=3D OP_NE && br =3D=3D 1)
+				return 1;
+		}
+
+		return br_u >=3D 0 ? br_u : br_s;
 	}
 	return range_branch_taken_op(t, x->r[t], y->r[t], op);
 }
--=20
2.34.1


