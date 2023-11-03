Return-Path: <bpf+bounces-14053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DD47DFD78
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 01:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F511B214D9
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 00:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CD0136D;
	Fri,  3 Nov 2023 00:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B62197
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 00:08:57 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBD9182
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 17:08:57 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2JtJkD029523
	for <bpf@vger.kernel.org>; Thu, 2 Nov 2023 17:08:56 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u46jkp53t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 17:08:56 -0700
Received: from twshared15991.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 17:08:53 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id E52B83AD8A7F8; Thu,  2 Nov 2023 17:08:39 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 08/13] selftests/bpf: adjust OP_EQ/OP_NE handling to use subranges for branch taken
Date: Thu, 2 Nov 2023 17:08:17 -0700
Message-ID: <20231103000822.2509815-9-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103000822.2509815-1-andrii@kernel.org>
References: <20231103000822.2509815-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DXmkvI802eQ5Uza5MvYQxqY51FHfTW5x
X-Proofpoint-GUID: DXmkvI802eQ5Uza5MvYQxqY51FHfTW5x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_10,2023-11-02_03,2023-05-22_02

Similar to kernel-side BPF verifier logic enhancements, use 32-bit
subrange knowledge for is_branch_taken() logic in reg_bounds selftests.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/reg_bounds.c     | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
index ac7354cfe139..330618cc12e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -750,16 +750,27 @@ static int reg_state_branch_taken_op(enum num_t t, =
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
+			if (br !=3D -1)
+				return br;
+			br =3D range_branch_taken_op(S32, x->r[S32], y->r[S32], op);
+			if (br !=3D -1)
+				return br;
+		}
+
+		return br_u >=3D 0 ? br_u : br_s;
 	}
 	return range_branch_taken_op(t, x->r[t], y->r[t], op);
 }
--=20
2.34.1


