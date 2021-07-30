Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAF93DB042
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 02:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbhG3AaL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 20:30:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5390 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234931AbhG3AaI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 29 Jul 2021 20:30:08 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 16U0IOgI031722
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 17:30:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=JzWSxDY/USo2d4AyANQ+8iHAgE9r65q/PqR6W1/eFUI=;
 b=Mzh2B81NsrR+yb0GwzIpijrqFn2lJNzQri0orxHG+zCaun3HFJsjdsUAa5sNWnZGtQ/b
 gJHsM/5keoR6DLD2cpT2SLs/7OaF5FvkjPicQsLCHJ1nlwExe4DwcGMKevu8xqHKWl+N
 ixHT7l7LVwLGfO8Od/dMl2zf07e+K77unms= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3a39tr2py7-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 17:30:02 -0700
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 17:29:59 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id A561416EA8F9; Thu, 29 Jul 2021 17:29:56 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <sunyucong@gmail.com>, Yucong Sun <fallentree@fb.com>
Subject: [PATCH v4 bpf-next] libbpf: Add bpf_object__set_name(obj, name) api.
Date:   Thu, 29 Jul 2021 17:29:53 -0700
Message-ID: <20210730002953.1045142-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730001801.994751-1-fallentree@fb.com>
References: <20210730001801.994751-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: r2Ha6KRFH_dRdX5L4RBCJd-2tVmapHjA
X-Proofpoint-GUID: r2Ha6KRFH_dRdX5L4RBCJd-2tVmapHjA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_20:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=951 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107300000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tracking: libbpf/libbpf#291

Signed-off-by: Yucong Sun <fallentree@fb.com>

---

V3 -> V4: handle obj is NULL case.
V2 -> V3: fix code style errors
---
 tools/lib/bpf/libbpf.c                                 | 10 ++++++++++
 tools/lib/bpf/libbpf.h                                 |  1 +
 tools/lib/bpf/libbpf.map                               |  1 +
 .../selftests/bpf/prog_tests/reference_tracking.c      |  7 +++++++
 4 files changed, 19 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a1ca6fb0c6d8..a628e94a41a4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7545,6 +7545,16 @@ const char *bpf_object__name(const struct bpf_obje=
ct *obj)
 	return obj ? obj->name : libbpf_err_ptr(-EINVAL);
 }
=20
+int bpf_object__set_name(struct bpf_object *obj, const char *name)
+{
+	if (!obj || !name)
+		return libbpf_err(-EINVAL);
+
+	strncpy(obj->name, name, sizeof(obj->name) - 1);
+
+	return 0;
+}
+
 unsigned int bpf_object__kversion(const struct bpf_object *obj)
 {
 	return obj ? obj->kern_version : 0;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 1271d99bb7aa..36a2946e3373 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -161,6 +161,7 @@ LIBBPF_API int bpf_object__load_xattr(struct bpf_obje=
ct_load_attr *attr);
 LIBBPF_API int bpf_object__unload(struct bpf_object *obj);
=20
 LIBBPF_API const char *bpf_object__name(const struct bpf_object *obj);
+LIBBPF_API int bpf_object__set_name(struct bpf_object *obj, const char *=
name);
 LIBBPF_API unsigned int bpf_object__kversion(const struct bpf_object *ob=
j);
 LIBBPF_API int bpf_object__set_kversion(struct bpf_object *obj, __u32 ke=
rn_version);
=20
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index c240d488eb5e..3c15aefeb6e0 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -377,4 +377,5 @@ LIBBPF_0.5.0 {
 		bpf_object__gen_loader;
 		btf_dump__dump_type_data;
 		libbpf_set_strict_mode;
+		bpf_object__set_name;
 } LIBBPF_0.4.0;
diff --git a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c =
b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
index de2688166696..4d3d0a4aec03 100644
--- a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
+++ b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
@@ -5,6 +5,7 @@ void test_reference_tracking(void)
 {
 	const char *file =3D "test_sk_lookup_kern.o";
 	const char *obj_name =3D "ref_track";
+	const char *obj_name2 =3D "ref_track2";
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, open_opts,
 		.object_name =3D obj_name,
 		.relaxed_maps =3D true,
@@ -23,6 +24,12 @@ void test_reference_tracking(void)
 		  bpf_object__name(obj), obj_name))
 		goto cleanup;
=20
+	bpf_object__set_name(obj, obj_name2);
+	if (CHECK(strcmp(bpf_object__name(obj), obj_name2), "obj_name",
+		  "wrong obj name '%s', expected '%s'\n",
+		  bpf_object__name(obj), obj_name2))
+		goto cleanup;
+
 	bpf_object__for_each_program(prog, obj) {
 		const char *title;
=20
--=20
2.30.2

