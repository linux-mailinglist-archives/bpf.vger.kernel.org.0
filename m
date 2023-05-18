Return-Path: <bpf+bounces-921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3211C708AD6
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 23:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FAE5281871
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 21:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B9C27709;
	Thu, 18 May 2023 21:55:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9D024E89
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 21:55:07 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF3CE45
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 14:55:04 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IFpqGl013798
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 14:55:04 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qnnmckbm0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 14:55:04 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 14:55:02 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id E419D30EEE4CE; Thu, 18 May 2023 14:54:49 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <cyphar@cyphar.com>, <brauner@kernel.org>, <lennart@poettering.net>,
        <linux-fsdevel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 bpf-next 2/3] libbpf: add opts-based bpf_obj_pin() API and add support for path_fd
Date: Thu, 18 May 2023 14:54:43 -0700
Message-ID: <20230518215444.1418789-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518215444.1418789-1-andrii@kernel.org>
References: <20230518215444.1418789-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0XyJAjpDu-fGcC4L1SSaUbCMfPRz0XjQ
X-Proofpoint-GUID: 0XyJAjpDu-fGcC4L1SSaUbCMfPRz0XjQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_15,2023-05-17_02,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add path_fd support for bpf_obj_pin() and bpf_obj_get() operations
(through their opts-based variants). This allows to take advantage of
new kernel-side support for O_PATH-based pin/get location specification.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c      | 17 ++++++++++++++---
 tools/lib/bpf/bpf.h      | 18 ++++++++++++++++--
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 128ac723c4ea..ed86b37d8024 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -572,20 +572,30 @@ int bpf_map_update_batch(int fd, const void *keys, =
const void *values, __u32 *co
 				    (void *)keys, (void *)values, count, opts);
 }
=20
-int bpf_obj_pin(int fd, const char *pathname)
+int bpf_obj_pin_opts(int fd, const char *pathname, const struct bpf_obj_=
pin_opts *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, file_flags);
+	const size_t attr_sz =3D offsetofend(union bpf_attr, path_fd);
 	union bpf_attr attr;
 	int ret;
=20
+	if (!OPTS_VALID(opts, bpf_obj_pin_opts))
+		return libbpf_err(-EINVAL);
+
 	memset(&attr, 0, attr_sz);
+	attr.path_fd =3D OPTS_GET(opts, path_fd, 0);
 	attr.pathname =3D ptr_to_u64((void *)pathname);
+	attr.file_flags =3D OPTS_GET(opts, file_flags, 0);
 	attr.bpf_fd =3D fd;
=20
 	ret =3D sys_bpf(BPF_OBJ_PIN, &attr, attr_sz);
 	return libbpf_err_errno(ret);
 }
=20
+int bpf_obj_pin(int fd, const char *pathname)
+{
+	return bpf_obj_pin_opts(fd, pathname, NULL);
+}
+
 int bpf_obj_get(const char *pathname)
 {
 	return bpf_obj_get_opts(pathname, NULL);
@@ -593,7 +603,7 @@ int bpf_obj_get(const char *pathname)
=20
 int bpf_obj_get_opts(const char *pathname, const struct bpf_obj_get_opts=
 *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, file_flags);
+	const size_t attr_sz =3D offsetofend(union bpf_attr, path_fd);
 	union bpf_attr attr;
 	int fd;
=20
@@ -601,6 +611,7 @@ int bpf_obj_get_opts(const char *pathname, const stru=
ct bpf_obj_get_opts *opts)
 		return libbpf_err(-EINVAL);
=20
 	memset(&attr, 0, attr_sz);
+	attr.path_fd =3D OPTS_GET(opts, path_fd, 0);
 	attr.pathname =3D ptr_to_u64((void *)pathname);
 	attr.file_flags =3D OPTS_GET(opts, file_flags, 0);
=20
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index a2c091389b18..9aa0ee473754 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -284,16 +284,30 @@ LIBBPF_API int bpf_map_update_batch(int fd, const v=
oid *keys, const void *values
 				    __u32 *count,
 				    const struct bpf_map_batch_opts *opts);
=20
-struct bpf_obj_get_opts {
+struct bpf_obj_pin_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
=20
 	__u32 file_flags;
+	int path_fd;
=20
 	size_t :0;
 };
-#define bpf_obj_get_opts__last_field file_flags
+#define bpf_obj_pin_opts__last_field path_fd
=20
 LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
+LIBBPF_API int bpf_obj_pin_opts(int fd, const char *pathname,
+				const struct bpf_obj_pin_opts *opts);
+
+struct bpf_obj_get_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+
+	__u32 file_flags;
+	int path_fd;
+
+	size_t :0;
+};
+#define bpf_obj_get_opts__last_field path_fd
+
 LIBBPF_API int bpf_obj_get(const char *pathname);
 LIBBPF_API int bpf_obj_get_opts(const char *pathname,
 				const struct bpf_obj_get_opts *opts);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index a5aa3a383d69..7a4fe80da360 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -389,5 +389,6 @@ LIBBPF_1.2.0 {
 		bpf_link__update_map;
 		bpf_link_get_info_by_fd;
 		bpf_map_get_info_by_fd;
+		bpf_obj_pin_opts;
 		bpf_prog_get_info_by_fd;
 } LIBBPF_1.1.0;
--=20
2.34.1


