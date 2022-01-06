Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B826486E03
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 00:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245689AbiAFXqx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 18:46:53 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6306 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245659AbiAFXqx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 18:46:53 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 206M476Q001564
        for <bpf@vger.kernel.org>; Thu, 6 Jan 2022 15:46:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+in/XWxMRgbnaKU4v8f41pK2KkWjs35ZQyCrR4xw1Zo=;
 b=K79DWwBPczH197IgPqsCD1t07mtEkBX1dhOhxJ3y4++FJsFAgECMeIYMoQ9uIp08T+mL
 oyH1eoqqgL2ytDrh+mFMuZ7Sx4AyLR2t8U5cKg5MvuHYWcTXpkkG8gScCyjrKUFpSi1n
 sYVjUrG/iGYxSTpyePNVezWFQ3hIYb5Xid0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3de4wg27rc-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 15:46:53 -0800
Received: from twshared3399.25.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 15:46:51 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id 8D09B15CB71A; Thu,  6 Jan 2022 15:46:44 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>
CC:     <christylee@fb.com>, <christyc.y.lee@gmail.com>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: change bpf_prog_attach_xattr() to bpf_prog_attach_opts()
Date:   Thu, 6 Jan 2022 15:46:39 -0800
Message-ID: <20220106234639.1418484-3-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220106234639.1418484-1-christylee@fb.com>
References: <20220106234639.1418484-1-christylee@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: N7Wiqy5DoLh9SqlwbVqw8zYZHdSz9Dlz
X-Proofpoint-ORIG-GUID: N7Wiqy5DoLh9SqlwbVqw8zYZHdSz9Dlz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_10,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201060144
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_prog_attach_opts() is being deprecated and renamed to
bpf_prog_attach_xattr(). Change all selftests/bpf's uage to the new name.

Signed-off-by: Christy Lee <christylee@fb.com>
---
 .../selftests/bpf/prog_tests/cgroup_attach_multi.c   | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c=
 b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
index d3e8f729c623..38b3c47293da 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
@@ -194,14 +194,14 @@ void serial_test_cgroup_attach_multi(void)
=20
 	attach_opts.flags =3D BPF_F_ALLOW_OVERRIDE | BPF_F_REPLACE;
 	attach_opts.replace_prog_fd =3D allow_prog[0];
-	if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
+	if (CHECK(!bpf_prog_attach_opts(allow_prog[6], cg1,
 					 BPF_CGROUP_INET_EGRESS, &attach_opts),
 		  "fail_prog_replace_override", "unexpected success\n"))
 		goto err;
 	CHECK_FAIL(errno !=3D EINVAL);
=20
 	attach_opts.flags =3D BPF_F_REPLACE;
-	if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
+	if (CHECK(!bpf_prog_attach_opts(allow_prog[6], cg1,
 					 BPF_CGROUP_INET_EGRESS, &attach_opts),
 		  "fail_prog_replace_no_multi", "unexpected success\n"))
 		goto err;
@@ -209,7 +209,7 @@ void serial_test_cgroup_attach_multi(void)
=20
 	attach_opts.flags =3D BPF_F_ALLOW_MULTI | BPF_F_REPLACE;
 	attach_opts.replace_prog_fd =3D -1;
-	if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
+	if (CHECK(!bpf_prog_attach_opts(allow_prog[6], cg1,
 					 BPF_CGROUP_INET_EGRESS, &attach_opts),
 		  "fail_prog_replace_bad_fd", "unexpected success\n"))
 		goto err;
@@ -217,7 +217,7 @@ void serial_test_cgroup_attach_multi(void)
=20
 	/* replacing a program that is not attached to cgroup should fail  */
 	attach_opts.replace_prog_fd =3D allow_prog[3];
-	if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
+	if (CHECK(!bpf_prog_attach_opts(allow_prog[6], cg1,
 					 BPF_CGROUP_INET_EGRESS, &attach_opts),
 		  "fail_prog_replace_no_ent", "unexpected success\n"))
 		goto err;
@@ -225,14 +225,14 @@ void serial_test_cgroup_attach_multi(void)
=20
 	/* replace 1st from the top program */
 	attach_opts.replace_prog_fd =3D allow_prog[0];
-	if (CHECK(bpf_prog_attach_xattr(allow_prog[6], cg1,
+	if (CHECK(bpf_prog_attach_opts(allow_prog[6], cg1,
 					BPF_CGROUP_INET_EGRESS, &attach_opts),
 		  "prog_replace", "errno=3D%d\n", errno))
 		goto err;
=20
 	/* replace program with itself */
 	attach_opts.replace_prog_fd =3D allow_prog[6];
-	if (CHECK(bpf_prog_attach_xattr(allow_prog[6], cg1,
+	if (CHECK(bpf_prog_attach_opts(allow_prog[6], cg1,
 					BPF_CGROUP_INET_EGRESS, &attach_opts),
 		  "prog_replace", "errno=3D%d\n", errno))
 		goto err;
--=20
2.30.2

