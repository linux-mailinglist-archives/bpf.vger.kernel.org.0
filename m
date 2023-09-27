Return-Path: <bpf+bounces-11000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 412047B0F55
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 01:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 57A4E1C209D1
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 23:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3493D4CFDC;
	Wed, 27 Sep 2023 23:01:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916064CFBE
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 23:01:53 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195BF18F
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 16:01:52 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 38RLP8Sd010227
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 16:01:51 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 3tck005yqg-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 16:01:51 -0700
Received: from twshared44805.48.prn1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 27 Sep 2023 16:01:45 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 4713138C9A6E7; Wed, 27 Sep 2023 15:58:55 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <brauner@kernel.org>,
        <lennart@poettering.net>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v6 bpf-next 09/13] libbpf: add bpf_token_create() API
Date: Wed, 27 Sep 2023 15:58:05 -0700
Message-ID: <20230927225809.2049655-10-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927225809.2049655-1-andrii@kernel.org>
References: <20230927225809.2049655-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: JfllwGBGiz_2LmPuxXOl-sihswz44zXe
X-Proofpoint-ORIG-GUID: JfllwGBGiz_2LmPuxXOl-sihswz44zXe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_15,2023-09-27_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add low-level wrapper API for BPF_TOKEN_CREATE command in bpf() syscall.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c      | 19 +++++++++++++++++++
 tools/lib/bpf/bpf.h      | 28 ++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 48 insertions(+)

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
index 74c2887cfd24..a5ddb0393fee 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -635,6 +635,34 @@ struct bpf_test_run_opts {
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
+ * @brief **bpf_token_create()** creates a new instance of BPF token der=
ived
+ * from specified BPF FS mount point.
+ *
+ * BPF token created with this API can be passed to bpf() syscall for
+ * commands like BPF_PROG_LOAD, BPF_MAP_CREATE, etc.
+ *
+ * @param bpffs_path_fd O_PATH FD (see man 2 openat() for semantics) spe=
cifying,
+ * in combination with *bpffs_pathname*, BPF FS mount from which to deri=
ve
+ * a BPF token instance.
+ * @param pin_pathname absolute or relative path specifying,in combinati=
on
+ * with *bpffs_pathname*, BPF FS mount from which to derive a BPF token
+ * instance.
+ * @param opts optional BPF token creation options, can be NULL
+ *
+ * @return BPF token FD > 0, on success; negative error code, otherwise =
(errno
+ * is also set to the error code)
+ */
+LIBBPF_API int bpf_token_create(int bpffs_path_fd, const char *bpffs_pat=
hname,
+				struct bpf_token_create_opts *opts);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index cc973b678a39..9d05ebcd3a9e 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -400,6 +400,7 @@ LIBBPF_1.3.0 {
 		bpf_program__attach_netfilter;
 		bpf_program__attach_tcx;
 		bpf_program__attach_uprobe_multi;
+		bpf_token_create;
 		ring__avail_data_size;
 		ring__consume;
 		ring__consumer_pos;
--=20
2.34.1


