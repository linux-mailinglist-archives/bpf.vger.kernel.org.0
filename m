Return-Path: <bpf+bounces-14712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8324E7E7877
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 04:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C790280E28
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 03:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E32D12B70;
	Fri, 10 Nov 2023 03:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173EE11720
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 03:49:19 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F02469D
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 19:49:18 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MYvS9018927
	for <bpf@vger.kernel.org>; Thu, 9 Nov 2023 19:49:18 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u8xr3pwcn-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 19:49:18 -0800
Received: from twshared11278.41.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 19:49:15 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 0C75B3B41DC6A; Thu,  9 Nov 2023 19:49:03 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v10 bpf-next 12/17] libbpf: add bpf_token_create() API
Date: Thu, 9 Nov 2023 19:48:33 -0800
Message-ID: <20231110034838.1295764-13-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110034838.1295764-1-andrii@kernel.org>
References: <20231110034838.1295764-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ROSLXdTRKhU__Da4Si5Oz8nMRL9Kvw5j
X-Proofpoint-ORIG-GUID: ROSLXdTRKhU__Da4Si5Oz8nMRL9Kvw5j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_17,2023-11-09_01,2023-05-22_02

Add low-level wrapper API for BPF_TOKEN_CREATE command in bpf() syscall.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c      | 17 +++++++++++++++++
 tools/lib/bpf/bpf.h      | 24 ++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 42 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 9dc9625651dc..d4019928a864 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1287,3 +1287,20 @@ int bpf_prog_bind_map(int prog_fd, int map_fd,
 	ret =3D sys_bpf(BPF_PROG_BIND_MAP, &attr, attr_sz);
 	return libbpf_err_errno(ret);
 }
+
+int bpf_token_create(int bpffs_fd, struct bpf_token_create_opts *opts)
+{
+	const size_t attr_sz =3D offsetofend(union bpf_attr, token_create);
+	union bpf_attr attr;
+	int fd;
+
+	if (!OPTS_VALID(opts, bpf_token_create_opts))
+		return libbpf_err(-EINVAL);
+
+	memset(&attr, 0, attr_sz);
+	attr.token_create.bpffs_fd =3D bpffs_fd;
+	attr.token_create.flags =3D OPTS_GET(opts, flags, 0);
+
+	fd =3D sys_bpf_fd(BPF_TOKEN_CREATE, &attr, attr_sz);
+	return libbpf_err_errno(fd);
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index d0f53772bdc0..e49254c9f68f 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -640,6 +640,30 @@ struct bpf_test_run_opts {
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
+ * @param bpffs_fd FD for BPF FS instance from which to derive a BPF tok=
en
+ * instance.
+ * @param opts optional BPF token creation options, can be NULL
+ *
+ * @return BPF token FD > 0, on success; negative error code, otherwise =
(errno
+ * is also set to the error code)
+ */
+LIBBPF_API int bpf_token_create(int bpffs_fd,
+				struct bpf_token_create_opts *opts);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index b52dc28dc8af..8224738d2492 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -401,6 +401,7 @@ LIBBPF_1.3.0 {
 		bpf_program__attach_netkit;
 		bpf_program__attach_tcx;
 		bpf_program__attach_uprobe_multi;
+		bpf_token_create;
 		ring__avail_data_size;
 		ring__consume;
 		ring__consumer_pos;
--=20
2.34.1


