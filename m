Return-Path: <bpf+bounces-3693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B3A741FB5
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 07:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0128A1C2048A
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 05:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598225250;
	Thu, 29 Jun 2023 05:18:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAD25223
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 05:18:44 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84E7194
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 22:18:42 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T0jafr021825
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 22:18:42 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rgypq1pn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 22:18:42 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 22:18:41 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 7EA3133AFB43B; Wed, 28 Jun 2023 22:18:36 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>
CC: <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>, <cyphar@cyphar.com>,
        <luto@kernel.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH RESEND v3 bpf-next 02/14] libbpf: add bpf_token_create() API
Date: Wed, 28 Jun 2023 22:18:20 -0700
Message-ID: <20230629051832.897119-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629051832.897119-1-andrii@kernel.org>
References: <20230629051832.897119-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 2YNWSRajEjnwsG9EVOHwXKMJN1o5oMkV
X-Proofpoint-ORIG-GUID: 2YNWSRajEjnwsG9EVOHwXKMJN1o5oMkV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add low-level wrapper API for BPF_TOKEN_CREATE command in bpf() syscall.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c      | 21 +++++++++++++++++++++
 tools/lib/bpf/bpf.h      | 32 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 54 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index ed86b37d8024..a247a1612f29 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1201,3 +1201,24 @@ int bpf_prog_bind_map(int prog_fd, int map_fd,
 	ret =3D sys_bpf(BPF_PROG_BIND_MAP, &attr, attr_sz);
 	return libbpf_err_errno(ret);
 }
+
+int bpf_token_create(int pin_path_fd, const char *pin_pathname, struct b=
pf_token_create_opts *opts)
+{
+	const size_t attr_sz =3D offsetofend(union bpf_attr, token_create);
+	union bpf_attr attr;
+	int ret;
+
+	if (!OPTS_VALID(opts, bpf_token_create_opts))
+		return libbpf_err(-EINVAL);
+
+	memset(&attr, 0, attr_sz);
+	attr.token_create.pin_path_fd =3D pin_path_fd;
+	attr.token_create.pin_pathname =3D ptr_to_u64(pin_pathname);
+	attr.token_create.token_fd =3D OPTS_GET(opts, token_fd, 0);
+	attr.token_create.token_flags =3D OPTS_GET(opts, token_flags, 0);
+	attr.token_create.pin_flags =3D OPTS_GET(opts, pin_flags, 0);
+	attr.token_create.allowed_cmds =3D OPTS_GET(opts, allowed_cmds, 0);
+
+	ret =3D sys_bpf(BPF_TOKEN_CREATE, &attr, attr_sz);
+	return libbpf_err_errno(ret);
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 9aa0ee473754..ab0355d90a2c 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -551,6 +551,38 @@ struct bpf_test_run_opts {
 LIBBPF_API int bpf_prog_test_run_opts(int prog_fd,
 				      struct bpf_test_run_opts *opts);
=20
+struct bpf_token_create_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	__u32 token_fd;
+	__u32 token_flags;
+	__u32 pin_flags;
+	__u64 allowed_cmds;
+	size_t :0;
+};
+#define bpf_token_create_opts__last_field allowed_cmds
+
+/**
+ * @brief **bpf_token_create()** creates a new instance of BPF token, pi=
nning
+ * it at the specified location in BPF FS.
+ *
+ * BPF token created and pinned with this API can be subsequently opened=
 using
+ * bpf_obj_get() API to obtain FD that can be passed to bpf() syscall fo=
r
+ * commands like BPF_PROG_LOAD, BPF_MAP_CREATE, etc.
+ *
+ * @param pin_path_fd O_PATH FD (see man 2 openat() for semantics) speci=
fying,
+ * in combination with *pin_pathname*, target location in BPF FS at whic=
h to
+ * create and pin BPF token.
+ * @param pin_pathname absolute or relative path specifying, in combinat=
ion
+ * with *pin_path_fd*, specifying in combination with *pin_path_fd*, tar=
get
+ * location in BPF FS at which to create and pin BPF token.
+ * @param opts optional BPF token creation options, can be NULL
+ *
+ * @return 0, on success; negative error code, otherwise (errno is also =
set to
+ * the error code)
+ */
+LIBBPF_API int bpf_token_create(int pin_path_fd, const char *pin_pathnam=
e,
+				struct bpf_token_create_opts *opts);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 7521a2fb7626..62cbe4775081 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -395,4 +395,5 @@ LIBBPF_1.2.0 {
 LIBBPF_1.3.0 {
 	global:
 		bpf_obj_pin_opts;
+		bpf_token_create;
 } LIBBPF_1.2.0;
--=20
2.34.1


