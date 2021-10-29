Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FE4440597
	for <lists+bpf@lfdr.de>; Sat, 30 Oct 2021 00:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhJ2WwT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 18:52:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22972 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231566AbhJ2WwS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 Oct 2021 18:52:18 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19TMhf7a020520
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 15:49:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=KYJbf3GdMMx/HzRefRDY75/KiJi5QhPl/OuuTetH1zw=;
 b=pczlytz4oYpQW10nWRtnJIMURPxYtbLi2gwspuShOnNWKik2BkKMdqzTmqZex4HRAnGY
 Kuye74YaYrApFdFG8QkyPHWQBabc/F25eYYpVc7e2lq4RfdKhiMMt/jEHJ98Y6EMxwK7
 NtGSsqElUomV2FIH3Omz1E1i5eJcbhwR8kA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c09aw0rc8-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 15:49:48 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 15:49:46 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id A575D4373050; Fri, 29 Oct 2021 15:49:36 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <Kernel-team@fb.com>, <yhs@fb.com>,
        Joanne Koong <joannekoong@fb.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add bloom map success test for userspace calls
Date:   Fri, 29 Oct 2021 15:49:09 -0700
Message-ID: <20211029224909.1721024-4-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029224909.1721024-1-joannekoong@fb.com>
References: <20211029224909.1721024-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: D1XaNqtsqxs0bVISvzj2qDL_UCtq-J7p
X-Proofpoint-ORIG-GUID: D1XaNqtsqxs0bVISvzj2qDL_UCtq-J7p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_06,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=829 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch has two changes:
1) Adds a new function "test_success_cases" to test
successfully creating + adding + looking up a value
in a bloom filter map from the userspace side.

2) Use bpf_create_map instead of bpf_create_map_xattr in
the "test_fail_cases" and test_inner_map to make the
code look cleaner.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 .../bpf/prog_tests/bloom_filter_map.c         | 59 +++++++++++--------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c b/=
tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
index 9aa3fbed918b..be73e3de6668 100644
--- a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
@@ -7,44 +7,31 @@
=20
 static void test_fail_cases(void)
 {
-	struct bpf_create_map_attr xattr =3D {
-		.name =3D "bloom_filter_map",
-		.map_type =3D BPF_MAP_TYPE_BLOOM_FILTER,
-		.max_entries =3D 100,
-		.value_size =3D 11,
-	};
 	__u32 value;
 	int fd, err;
=20
 	/* Invalid key size */
-	xattr.key_size =3D 4;
-	fd =3D bpf_create_map_xattr(&xattr);
+	fd =3D bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 4, sizeof(value), 100,=
 0);
 	if (!ASSERT_LT(fd, 0, "bpf_create_map bloom filter invalid key size"))
 		close(fd);
-	xattr.key_size =3D 0;
=20
 	/* Invalid value size */
-	xattr.value_size =3D 0;
-	fd =3D bpf_create_map_xattr(&xattr);
+	fd =3D bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 0, 0, 100, 0);
 	if (!ASSERT_LT(fd, 0, "bpf_create_map bloom filter invalid value size 0=
"))
 		close(fd);
-	xattr.value_size =3D 11;
=20
 	/* Invalid max entries size */
-	xattr.max_entries =3D 0;
-	fd =3D bpf_create_map_xattr(&xattr);
+	fd =3D bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 0, sizeof(value), 0, 0=
);
 	if (!ASSERT_LT(fd, 0, "bpf_create_map bloom filter invalid max entries =
size"))
 		close(fd);
-	xattr.max_entries =3D 100;
=20
 	/* Bloom filter maps do not support BPF_F_NO_PREALLOC */
-	xattr.map_flags =3D BPF_F_NO_PREALLOC;
-	fd =3D bpf_create_map_xattr(&xattr);
+	fd =3D bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 0, sizeof(value), 100,
+			    BPF_F_NO_PREALLOC);
 	if (!ASSERT_LT(fd, 0, "bpf_create_map bloom filter invalid flags"))
 		close(fd);
-	xattr.map_flags =3D 0;
=20
-	fd =3D bpf_create_map_xattr(&xattr);
+	fd =3D bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 0, sizeof(value), 100,=
 0);
 	if (!ASSERT_GE(fd, 0, "bpf_create_map bloom filter"))
 		return;
=20
@@ -67,6 +54,30 @@ static void test_fail_cases(void)
 	close(fd);
 }
=20
+static void test_success_cases(void)
+{
+	char value[11];
+	int fd, err;
+
+	/* Create a map */
+	fd =3D bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 0, sizeof(value), 100,
+			    BPF_F_ZERO_SEED | BPF_F_NUMA_NODE);
+	if (!ASSERT_GE(fd, 0, "bpf_create_map bloom filter success case"))
+		return;
+
+	/* Add a value to the bloom filter */
+	err =3D bpf_map_update_elem(fd, NULL, &value, 0);
+	if (!ASSERT_OK(err, "bpf_map_update_elem bloom filter success case"))
+		goto done;
+
+	 /* Lookup a value in the bloom filter */
+	err =3D bpf_map_lookup_elem(fd, NULL, &value);
+	ASSERT_OK(err, "bpf_map_update_elem bloom filter success case");
+
+done:
+	close(fd);
+}
+
 static void check_bloom(struct bloom_filter_map *skel)
 {
 	struct bpf_link *link;
@@ -86,16 +97,11 @@ static void test_inner_map(struct bloom_filter_map *s=
kel, const __u32 *rand_vals
 			   __u32 nr_rand_vals)
 {
 	int outer_map_fd, inner_map_fd, err, i, key =3D 0;
-	struct bpf_create_map_attr xattr =3D {
-		.name =3D "bloom_filter_inner_map",
-		.map_type =3D BPF_MAP_TYPE_BLOOM_FILTER,
-		.value_size =3D sizeof(__u32),
-		.max_entries =3D nr_rand_vals,
-	};
 	struct bpf_link *link;
=20
 	/* Create a bloom filter map that will be used as the inner map */
-	inner_map_fd =3D bpf_create_map_xattr(&xattr);
+	inner_map_fd =3D bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 0, sizeof(*r=
and_vals),
+				      nr_rand_vals, 0);
 	if (!ASSERT_GE(inner_map_fd, 0, "bpf_create_map bloom filter inner map"=
))
 		return;
=20
@@ -190,6 +196,7 @@ void test_bloom_filter_map(void)
 	int err;
=20
 	test_fail_cases();
+	test_success_cases();
=20
 	err =3D setup_progs(&skel, &rand_vals, &nr_rand_vals);
 	if (err)
--=20
2.30.2

