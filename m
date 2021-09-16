Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77ABF40D17D
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 03:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbhIPCAQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 15 Sep 2021 22:00:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:15564 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233565AbhIPCAQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Sep 2021 22:00:16 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FM3u2c015198
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 18:58:56 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b3my2b1yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 18:58:56 -0700
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 15 Sep 2021 18:58:56 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 3F2B7422A28C; Wed, 15 Sep 2021 18:58:49 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 5/7] selftests/bpf: switch fexit_bpf2bpf selftest to set_attach_target() API
Date:   Wed, 15 Sep 2021 18:58:34 -0700
Message-ID: <20210916015836.1248906-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916015836.1248906-1-andrii@kernel.org>
References: <20210916015836.1248906-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: gO_5zPWXjVRSmmSUZiEkEUt2Kpte76-s
X-Proofpoint-ORIG-GUID: gO_5zPWXjVRSmmSUZiEkEUt2Kpte76-s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-15_07,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1034 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160011
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switch fexit_bpf2bpf selftest to bpf_program__set_attach_target()
instead of using bpf_object_open_opts.attach_prog_fd, which is going to
be deprecated. These changes also demonstrate the new mode of
set_attach_target() in which it allows NULL when the target is BPF
program (attach_prog_fd != 0).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 43 +++++++++++--------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index 73b4c76e6b86..c7c1816899bf 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -60,7 +60,7 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
 	struct bpf_object *obj = NULL, *tgt_obj;
 	__u32 retval, tgt_prog_id, info_len;
 	struct bpf_prog_info prog_info = {};
-	struct bpf_program **prog = NULL;
+	struct bpf_program **prog = NULL, *p;
 	struct bpf_link **link = NULL;
 	int err, tgt_fd, i;
 	struct btf *btf;
@@ -69,9 +69,6 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
 			    &tgt_obj, &tgt_fd);
 	if (!ASSERT_OK(err, "tgt_prog_load"))
 		return;
-	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts,
-			    .attach_prog_fd = tgt_fd,
-			   );
 
 	info_len = sizeof(prog_info);
 	err = bpf_obj_get_info_by_fd(tgt_fd, &prog_info, &info_len);
@@ -89,10 +86,15 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
 	if (!ASSERT_OK_PTR(prog, "prog_ptr"))
 		goto close_prog;
 
-	obj = bpf_object__open_file(obj_file, &opts);
+	obj = bpf_object__open_file(obj_file, NULL);
 	if (!ASSERT_OK_PTR(obj, "obj_open"))
 		goto close_prog;
 
+	bpf_object__for_each_program(p, obj) {
+		err = bpf_program__set_attach_target(p, tgt_fd, NULL);
+		ASSERT_OK(err, "set_attach_target");
+	}
+
 	err = bpf_object__load(obj);
 	if (!ASSERT_OK(err, "obj_load"))
 		goto close_prog;
@@ -270,7 +272,7 @@ static void test_fmod_ret_freplace(void)
 	struct bpf_link *freplace_link = NULL;
 	struct bpf_program *prog;
 	__u32 duration = 0;
-	int err, pkt_fd;
+	int err, pkt_fd, attach_prog_fd;
 
 	err = bpf_prog_load(tgt_name, BPF_PROG_TYPE_UNSPEC,
 			    &pkt_obj, &pkt_fd);
@@ -278,26 +280,32 @@ static void test_fmod_ret_freplace(void)
 	if (CHECK(err, "tgt_prog_load", "file %s err %d errno %d\n",
 		  tgt_name, err, errno))
 		return;
-	opts.attach_prog_fd = pkt_fd;
 
-	freplace_obj = bpf_object__open_file(freplace_name, &opts);
+	freplace_obj = bpf_object__open_file(freplace_name, NULL);
 	if (!ASSERT_OK_PTR(freplace_obj, "freplace_obj_open"))
 		goto out;
 
+	prog = bpf_program__next(NULL, freplace_obj);
+	err = bpf_program__set_attach_target(prog, pkt_fd, NULL);
+	ASSERT_OK(err, "freplace__set_attach_target");
+
 	err = bpf_object__load(freplace_obj);
 	if (CHECK(err, "freplace_obj_load", "err %d\n", err))
 		goto out;
 
-	prog = bpf_program__next(NULL, freplace_obj);
 	freplace_link = bpf_program__attach_trace(prog);
 	if (!ASSERT_OK_PTR(freplace_link, "freplace_attach_trace"))
 		goto out;
 
-	opts.attach_prog_fd = bpf_program__fd(prog);
-	fmod_obj = bpf_object__open_file(fmod_ret_name, &opts);
+	fmod_obj = bpf_object__open_file(fmod_ret_name, NULL);
 	if (!ASSERT_OK_PTR(fmod_obj, "fmod_obj_open"))
 		goto out;
 
+	attach_prog_fd = bpf_program__fd(prog);
+	prog = bpf_program__next(NULL, fmod_obj);
+	err = bpf_program__set_attach_target(prog, attach_prog_fd, NULL);
+	ASSERT_OK(err, "fmod_ret_set_attach_target");
+
 	err = bpf_object__load(fmod_obj);
 	if (CHECK(!err, "fmod_obj_load", "loading fmod_ret should fail\n"))
 		goto out;
@@ -322,14 +330,14 @@ static void test_func_sockmap_update(void)
 }
 
 static void test_obj_load_failure_common(const char *obj_file,
-					  const char *target_obj_file)
-
+					 const char *target_obj_file)
 {
 	/*
 	 * standalone test that asserts failure to load freplace prog
 	 * because of invalid return code.
 	 */
 	struct bpf_object *obj = NULL, *pkt_obj;
+	struct bpf_program *prog;
 	int err, pkt_fd;
 	__u32 duration = 0;
 
@@ -339,14 +347,15 @@ static void test_obj_load_failure_common(const char *obj_file,
 	if (CHECK(err, "tgt_prog_load", "file %s err %d errno %d\n",
 		  target_obj_file, err, errno))
 		return;
-	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts,
-			    .attach_prog_fd = pkt_fd,
-			   );
 
-	obj = bpf_object__open_file(obj_file, &opts);
+	obj = bpf_object__open_file(obj_file, NULL);
 	if (!ASSERT_OK_PTR(obj, "obj_open"))
 		goto close_prog;
 
+	prog = bpf_program__next(NULL, obj);
+	err = bpf_program__set_attach_target(prog, pkt_fd, NULL);
+	ASSERT_OK(err, "set_attach_target");
+
 	/* It should fail to load the program */
 	err = bpf_object__load(obj);
 	if (CHECK(!err, "bpf_obj_load should fail", "err %d\n", err))
-- 
2.30.2

