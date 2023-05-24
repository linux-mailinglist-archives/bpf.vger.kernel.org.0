Return-Path: <bpf+bounces-1195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC8A71012C
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 00:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44F41C20CFA
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 22:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68768831;
	Wed, 24 May 2023 22:55:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A24A8495
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 22:55:34 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F1D90
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 15:55:33 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OHG39i008408
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 15:55:33 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qsptc9ujs-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 15:55:32 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 15:55:07 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 57C2E3149A87E; Wed, 24 May 2023 15:55:03 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 2/3] bpf: don't require CAP_SYS_ADMIN for getting NEXT_ID
Date: Wed, 24 May 2023 15:54:20 -0700
Message-ID: <20230524225421.1587859-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524225421.1587859-1-andrii@kernel.org>
References: <20230524225421.1587859-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rU3HYO_oWbO96hZQmOoiYaKd0gkfyK4L
X-Proofpoint-GUID: rU3HYO_oWbO96hZQmOoiYaKd0gkfyK4L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_15,2023-05-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Getting ID of map/prog/btf/link doesn't give any access to underlying
BPF objects, so there is no point in requiring CAP_SYS_ADMIN for these
commands.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c                              |  3 ---
 .../bpf/prog_tests/unpriv_bpf_disabled.c          | 15 ++-------------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c9a201e4c457..1d74c0a8d903 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3720,9 +3720,6 @@ static int bpf_obj_get_next_id(const union bpf_attr=
 *attr,
 	if (CHECK_ATTR(BPF_OBJ_GET_NEXT_ID) || next_id >=3D INT_MAX)
 		return -EINVAL;
=20
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	next_id++;
 	spin_lock_bh(lock);
 	if (!idr_get_next(idr, &next_id))
diff --git a/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c=
 b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
index 8383a99f610f..154a957154e8 100644
--- a/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
+++ b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
@@ -156,7 +156,6 @@ static void test_unpriv_bpf_disabled_negative(struct =
test_unpriv_bpf_disabled *s
 	__u32 attach_flags =3D 0;
 	__u32 prog_ids[3] =3D {};
 	__u32 prog_cnt =3D 3;
-	__u32 next;
 	int i;
=20
 	/* Negative tests for unprivileged BPF disabled.  Verify we cannot
@@ -176,25 +175,15 @@ static void test_unpriv_bpf_disabled_negative(struc=
t test_unpriv_bpf_disabled *s
 			  -EPERM, "map_create_fails");
=20
 	ASSERT_EQ(bpf_prog_get_fd_by_id(prog_id), -EPERM, "prog_get_fd_by_id_fa=
ils");
-	ASSERT_EQ(bpf_prog_get_next_id(prog_id, &next), -EPERM, "prog_get_next_=
id_fails");
-	ASSERT_EQ(bpf_prog_get_next_id(0, &next), -EPERM, "prog_get_next_id_fai=
ls");
=20
 	if (ASSERT_OK(bpf_map_get_info_by_fd(map_fds[0], &map_info, &map_info_l=
en),
-		      "obj_get_info_by_fd")) {
+		      "obj_get_info_by_fd"))
 		ASSERT_EQ(bpf_map_get_fd_by_id(map_info.id), -EPERM, "map_get_fd_by_id=
_fails");
-		ASSERT_EQ(bpf_map_get_next_id(map_info.id, &next), -EPERM,
-			  "map_get_next_id_fails");
-	}
-	ASSERT_EQ(bpf_map_get_next_id(0, &next), -EPERM, "map_get_next_id_fails=
");
=20
 	if (ASSERT_OK(bpf_link_get_info_by_fd(bpf_link__fd(skel->links.sys_nano=
sleep_enter),
 					      &link_info, &link_info_len),
-		      "obj_get_info_by_fd")) {
+		      "obj_get_info_by_fd"))
 		ASSERT_EQ(bpf_link_get_fd_by_id(link_info.id), -EPERM, "link_get_fd_by=
_id_fails");
-		ASSERT_EQ(bpf_link_get_next_id(link_info.id, &next), -EPERM,
-			  "link_get_next_id_fails");
-	}
-	ASSERT_EQ(bpf_link_get_next_id(0, &next), -EPERM, "link_get_next_id_fai=
ls");
=20
 	ASSERT_EQ(bpf_prog_query(prog_fd, BPF_TRACE_FENTRY, 0, &attach_flags, p=
rog_ids,
 				 &prog_cnt), -EPERM, "prog_query_fails");
--=20
2.34.1


