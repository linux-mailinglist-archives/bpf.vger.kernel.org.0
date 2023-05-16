Return-Path: <bpf+bounces-586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4526F704220
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 02:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F018F2810EA
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 00:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4B717D4;
	Tue, 16 May 2023 00:14:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F86F195
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 00:14:06 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DFE5FD1
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 17:14:03 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FMkreo013761
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 17:14:02 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qj830fk04-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 17:14:02 -0700
Received: from twshared40933.03.prn6.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 17:14:00 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 9F3B430BEFA2F; Mon, 15 May 2023 17:13:57 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <cyphar@cyphar.com>, <brauner@kernel.org>, <lennart@poettering.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 2/3] libbpf: add opts-based bpf_obj_pin() API and add support for path_fd
Date: Mon, 15 May 2023 17:13:47 -0700
Message-ID: <20230516001348.286414-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516001348.286414-1-andrii@kernel.org>
References: <20230516001348.286414-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Jn9l1LR3Qa1nVS8U6TNj9d3EC2awLrDK
X-Proofpoint-ORIG-GUID: Jn9l1LR3Qa1nVS8U6TNj9d3EC2awLrDK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_21,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add path_fd support for bpf_obj_pin() and bpf_obj_get() operations
(through their opts-based variants). This allows to take advantage of
new kernel-side support for O_PATH-based pin/get location specification.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c      | 16 +++++++++++++---
 tools/lib/bpf/bpf.h      | 17 +++++++++++++++--
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 128ac723c4ea..35cdc0777d79 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -572,13 +572,17 @@ int bpf_map_update_batch(int fd, const void *keys, =
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
 	attr.bpf_fd =3D fd;
=20
@@ -586,6 +590,11 @@ int bpf_obj_pin(int fd, const char *pathname)
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
@@ -593,7 +602,7 @@ int bpf_obj_get(const char *pathname)
=20
 int bpf_obj_get_opts(const char *pathname, const struct bpf_obj_get_opts=
 *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, file_flags);
+	const size_t attr_sz =3D offsetofend(union bpf_attr, path_fd);
 	union bpf_attr attr;
 	int fd;
=20
@@ -601,6 +610,7 @@ int bpf_obj_get_opts(const char *pathname, const stru=
ct bpf_obj_get_opts *opts)
 		return libbpf_err(-EINVAL);
=20
 	memset(&attr, 0, attr_sz);
+	attr.path_fd =3D OPTS_GET(opts, path_fd, 0);
 	attr.pathname =3D ptr_to_u64((void *)pathname);
 	attr.file_flags =3D OPTS_GET(opts, file_flags, 0);
=20
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index a2c091389b18..22500a526520 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -284,16 +284,29 @@ LIBBPF_API int bpf_map_update_batch(int fd, const v=
oid *keys, const void *values
 				    __u32 *count,
 				    const struct bpf_map_batch_opts *opts);
=20
+struct bpf_obj_pin_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+
+	int path_fd;
+
+	size_t :0;
+};
+#define bpf_obj_pin_opts__last_field path_fd
+
+LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
+LIBBPF_API int bpf_obj_pin_opts(int fd, const char *pathname,
+				const struct bpf_obj_pin_opts *opts);
+
 struct bpf_obj_get_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
=20
 	__u32 file_flags;
+	int path_fd;
=20
 	size_t :0;
 };
-#define bpf_obj_get_opts__last_field file_flags
+#define bpf_obj_get_opts__last_field path_fd
=20
-LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
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


