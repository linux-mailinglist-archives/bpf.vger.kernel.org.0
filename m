Return-Path: <bpf+bounces-9802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963B579DB00
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F689281977
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 21:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA98BA22;
	Tue, 12 Sep 2023 21:32:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D83A933
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 21:32:16 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981DE10CA
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 14:32:16 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CKj3at017414
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 14:32:16 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t2ya00e06-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 14:32:16 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 12 Sep 2023 14:32:13 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 97A0037F4072A; Tue, 12 Sep 2023 14:29:25 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <brauner@kernel.org>,
        <lennart@poettering.net>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v4 bpf-next 08/12] libbpf: add bpf_token_create() API
Date: Tue, 12 Sep 2023 14:29:02 -0700
Message-ID: <20230912212906.3975866-9-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912212906.3975866-1-andrii@kernel.org>
References: <20230912212906.3975866-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: zY1ZD_Hn3CpH6PTaP7n5V_9ApY_MBv97
X-Proofpoint-GUID: zY1ZD_Hn3CpH6PTaP7n5V_9ApY_MBv97
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_20,2023-09-05_01,2023-05-22_02

Add low-level wrapper API for BPF_TOKEN_CREATE command in bpf() syscall.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c      | 19 +++++++++++++++++++
 tools/lib/bpf/bpf.h      | 29 +++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 49 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index b0f1913763a3..593ff9ea120d 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1271,3 +1271,22 @@ int bpf_prog_bind_map(int prog_fd, int map_fd,
 	ret =3D sys_bpf(BPF_PROG_BIND_MAP, &attr, attr_sz);
 	return libbpf_err_errno(ret);
 }
+
+int bpf_token_create(int bpffs_path_fd, const char *bpffs_pathname,
+		     struct bpf_token_create_opts *opts)
+{
+	const size_t attr_sz =3D offsetofend(union bpf_attr, token_create);
+	union bpf_attr attr;
+	int fd;
+
+	if (!OPTS_VALID(opts, bpf_token_create_opts))
+		return libbpf_err(-EINVAL);
+
+	memset(&attr, 0, attr_sz);
+	attr.token_create.bpffs_path_fd =3D bpffs_path_fd;
+	attr.token_create.bpffs_pathname =3D ptr_to_u64(bpffs_pathname);
+	attr.token_create.flags =3D OPTS_GET(opts, flags, 0);
+
+	fd =3D sys_bpf_fd(BPF_TOKEN_CREATE, &attr, attr_sz);
+	return libbpf_err_errno(fd);
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 74c2887cfd24..16d5c257066c 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -635,6 +635,35 @@ struct bpf_test_run_opts {
 LIBBPF_API int bpf_prog_test_run_opts(int prog_fd,
 				      struct bpf_test_run_opts *opts);
=20
+struct bpf_token_create_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	__u32 flags;
+	size_t :0;
+};
+#define bpf_token_create_opts__last_field flags
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
+LIBBPF_API int bpf_token_create(int bpffs_path_fd, const char *bpffs_pat=
hname,
+				struct bpf_token_create_opts *opts);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 57712321490f..c45c28a5e14c 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -400,4 +400,5 @@ LIBBPF_1.3.0 {
 		bpf_program__attach_netfilter;
 		bpf_program__attach_tcx;
 		bpf_program__attach_uprobe_multi;
+		bpf_token_create;
 } LIBBPF_1.2.0;
--=20
2.34.1


