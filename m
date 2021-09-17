Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F4540F159
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 06:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhIQEg1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 00:36:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29872 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244432AbhIQEf3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Sep 2021 00:35:29 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18H1Ff8v027203
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 21:34:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=opbx6rz26Tfn2QRaL/oty9S8wDDC2vkUctnwpV2yOAs=;
 b=Pt5b7B4iDcxN0C87ta5o3He0Fk1jCF/KmS9a1bJa7nc67qoQJeQi5TR30WO0jt4SDo49
 XTbe+GT+6Vjt5TLa4+IPtU5l+QBDDpEeaMCnuNYHh+izl02Y26UxayPbIZjGswU8M5w1
 IhQIayW/RiNzgntBmMpw3+8thOpuWkzZkec= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b47hfcurh-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 21:34:02 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 16 Sep 2021 21:33:50 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 6B48275291B8; Thu, 16 Sep 2021 21:33:43 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: fix a few compiler warnings
Date:   Thu, 16 Sep 2021 21:33:43 -0700
Message-ID: <20210917043343.3711917-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: E1XLiwwp-phYcwMzETyi_FwNdsvbXHjl
X-Proofpoint-GUID: E1XLiwwp-phYcwMzETyi_FwNdsvbXHjl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-17_02,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=812 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109170028
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With clang building selftests/bpf, I hit a few warnings like below:

  .../bpf_iter.c:592:48: warning: variable 'expected_key_c' set but not u=
sed [-Wunused-but-set-variable]
  __u32 expected_key_a =3D 0, expected_key_b =3D 0, expected_key_c =3D 0;
                                                ^

  .../bpf_iter.c:688:48: warning: variable 'expected_key_c' set but not u=
sed [-Wunused-but-set-variable]
  __u32 expected_key_a =3D 0, expected_key_b =3D 0, expected_key_c =3D 0;
                                                ^

  .../tc_redirect.c:657:6: warning: variable 'target_fd' is used uninitia=
lized whenever 'if' condition is true [-Wsometimes-uninitialized]
  if (!ASSERT_OK_PTR(nstoken, "setns " NS_FWD))
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  .../tc_redirect.c:743:6: note: uninitialized use occurs here
  if (target_fd >=3D 0)
      ^~~~~~~~~

Removing unused variables and initializing the previously-uninitialized v=
ariable
to ensure these warnings are gone.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c    | 6 ++----
 tools/testing/selftests/bpf/prog_tests/tc_redirect.c | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
index 77ac24b191d4..9454331aaf85 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -589,7 +589,7 @@ static void test_overflow(bool test_e2big_overflow, b=
ool ret1)
=20
 static void test_bpf_hash_map(void)
 {
-	__u32 expected_key_a =3D 0, expected_key_b =3D 0, expected_key_c =3D 0;
+	__u32 expected_key_a =3D 0, expected_key_b =3D 0;
 	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
 	struct bpf_iter_bpf_hash_map *skel;
 	int err, i, len, map_fd, iter_fd;
@@ -638,7 +638,6 @@ static void test_bpf_hash_map(void)
 		val =3D i + 4;
 		expected_key_a +=3D key.a;
 		expected_key_b +=3D key.b;
-		expected_key_c +=3D key.c;
 		expected_val +=3D val;
=20
 		err =3D bpf_map_update_elem(map_fd, &key, &val, BPF_ANY);
@@ -685,7 +684,7 @@ static void test_bpf_hash_map(void)
=20
 static void test_bpf_percpu_hash_map(void)
 {
-	__u32 expected_key_a =3D 0, expected_key_b =3D 0, expected_key_c =3D 0;
+	__u32 expected_key_a =3D 0, expected_key_b =3D 0;
 	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
 	struct bpf_iter_bpf_percpu_hash_map *skel;
 	int err, i, j, len, map_fd, iter_fd;
@@ -722,7 +721,6 @@ static void test_bpf_percpu_hash_map(void)
 		key.c =3D i + 3;
 		expected_key_a +=3D key.a;
 		expected_key_b +=3D key.b;
-		expected_key_c +=3D key.c;
=20
 		for (j =3D 0; j < bpf_num_possible_cpus(); j++) {
 			*(__u32 *)(val + j * 8) =3D i + j;
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools=
/testing/selftests/bpf/prog_tests/tc_redirect.c
index e7201ba29ccd..e87bc4466d9a 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -633,7 +633,7 @@ static void test_tc_redirect_peer_l3(struct netns_set=
up_result *setup_result)
 	struct nstoken *nstoken =3D NULL;
 	int err;
 	int tunnel_pid =3D -1;
-	int src_fd, target_fd;
+	int src_fd, target_fd =3D -1;
 	int ifindex;
=20
 	/* Start a L3 TUN/TAP tunnel between the src and dst namespaces.
--=20
2.30.2

