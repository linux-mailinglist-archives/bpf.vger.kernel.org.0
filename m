Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E014817D3
	for <lists+bpf@lfdr.de>; Thu, 30 Dec 2021 01:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhL3ABZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Dec 2021 19:01:25 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19150 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230083AbhL3ABY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 Dec 2021 19:01:24 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BTHDmPX003127
        for <bpf@vger.kernel.org>; Wed, 29 Dec 2021 16:01:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=l77diYftmip0V0dJE+tWo3KM/CLyroziklzSy3pkL1U=;
 b=Ss+NZAjFx2BKJVlP9fUoyEoHtr8pKfaQnUzra3RQfqOQaN1nwQghI0iDEdGcggFO7zjo
 WrI4RMQw8RiUDauNKzRIcAnu8yjF1C+MxBeKEhHbeQa4kF0L7iFMgvsXWYIC1IINSGx7
 SAOAHNNBzV3vuu1M/fdAJY3TSr+KNflSjB0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d8evtdsmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 29 Dec 2021 16:01:21 -0800
Received: from twshared10426.24.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 29 Dec 2021 16:01:20 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id 68044101F48B; Wed, 29 Dec 2021 16:01:17 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>
CC:     <christyc.y.lee@gmail.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, <ast@kernel.org>,
        Christy Lee <christylee@fb.com>
Subject: [PATCH bpf-next] libbpf: rename bpf_prog_attach_xattr to bpf_prog_attach_opts
Date:   Wed, 29 Dec 2021 16:01:10 -0800
Message-ID: <20211230000110.1068538-1-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: S6mSdsQSsVQtdbF9xIcGnWyooaBIl3qx
X-Proofpoint-ORIG-GUID: S6mSdsQSsVQtdbF9xIcGnWyooaBIl3qx
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-29_07,2021-12-29_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112290127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

All xattr APIs are being dropped, let's converge to the convention used in
high-level APIs and rename bpf_prog_attach_xattr to bpf_prog_attach_opts.

[0] Closes: https://github.com/libbpf/libbpf/issues/285

Signed-off-by: Christy Lee <christylee@fb.com>
---
 tools/lib/bpf/bpf.c                                  | 11 +++++++++--
 tools/lib/bpf/bpf.h                                  |  4 ++++
 tools/lib/bpf/libbpf.map                             |  1 +
 .../selftests/bpf/prog_tests/cgroup_attach_multi.c   | 12 ++++++------
 4 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 9b64eed2b003..19741cfcaf11 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -754,10 +754,10 @@ int bpf_prog_attach(int prog_fd, int target_fd, enum =
bpf_attach_type type,
 		.flags =3D flags,
 	);
=20
-	return bpf_prog_attach_xattr(prog_fd, target_fd, type, &opts);
+	return bpf_prog_attach_opts(prog_fd, target_fd, type, &opts);
 }
=20
-int bpf_prog_attach_xattr(int prog_fd, int target_fd,
+int bpf_prog_attach_opts(int prog_fd, int target_fd,
 			  enum bpf_attach_type type,
 			  const struct bpf_prog_attach_opts *opts)
 {
@@ -778,6 +778,13 @@ int bpf_prog_attach_xattr(int prog_fd, int target_fd,
 	return libbpf_err_errno(ret);
 }
=20
+int bpf_prog_attach_xattr(int prog_fd, int target_fd,
+			  enum bpf_attach_type type,
+			  const struct bpf_prog_attach_opts *opts)
+{
+	return bpf_prog_attach_opts(prog_fd, target_fd, type, opts);
+}
+
 int bpf_prog_detach(int target_fd, enum bpf_attach_type type)
 {
 	union bpf_attr attr;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 00619f64a040..5dc9fefe73f3 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -280,6 +280,10 @@ struct bpf_prog_attach_opts {
=20
 LIBBPF_API int bpf_prog_attach(int prog_fd, int attachable_fd,
 			       enum bpf_attach_type type, unsigned int flags);
+LIBBPF_API int bpf_prog_attach_opts(int prog_fd, int attachable_fd,
+				     enum bpf_attach_type type,
+				     const struct bpf_prog_attach_opts *opts);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_prog_attach_opts() instead")
 LIBBPF_API int bpf_prog_attach_xattr(int prog_fd, int attachable_fd,
 				     enum bpf_attach_type type,
 				     const struct bpf_prog_attach_opts *opts);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 529783967793..be2bb69d1a12 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -246,6 +246,7 @@ LIBBPF_0.0.8 {
 		bpf_link__update_program;
 		bpf_link_create;
 		bpf_link_update;
+		bpf_prog_attach_opts;
 		bpf_map__set_initial_value;
 		bpf_program__attach_cgroup;
 		bpf_program__attach_lsm;
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c b=
/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
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

