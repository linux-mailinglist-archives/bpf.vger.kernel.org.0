Return-Path: <bpf+bounces-585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990ED70421E
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 02:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96BCD1C20C8E
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 00:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103AD19D;
	Tue, 16 May 2023 00:14:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B531F195
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 00:14:02 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0216A59
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 17:14:00 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FMkt5K017182
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 17:14:00 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qj8cvfp3f-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 17:13:59 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 17:13:58 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 90E1230BEFA2A; Mon, 15 May 2023 17:13:55 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <cyphar@cyphar.com>, <brauner@kernel.org>, <lennart@poettering.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 1/3] bpf: support O_PATH FDs in BPF_OBJ_PIN and BPF_OBJ_GET commands
Date: Mon, 15 May 2023 17:13:46 -0700
Message-ID: <20230516001348.286414-2-andrii@kernel.org>
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
X-Proofpoint-GUID: 08VS_Z3vKT1y02BV_glVyixGRjjzQ4Rp
X-Proofpoint-ORIG-GUID: 08VS_Z3vKT1y02BV_glVyixGRjjzQ4Rp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_21,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Current UAPI of BPF_OBJ_PIN and BPF_OBJ_GET commands of bpf() syscall
forces users to specify pinning location as a string-based absolute or
relative (to current working directory) path. This has various
implications related to security (e.g., symlink-based attacks), forces
BPF FS to be exposed in the file system, which can cause races with
other applications.

One of the feedbacks we got from folks working with containers heavily
was that inability to use purely FD-based location specification was an
unfortunate limitation and hindrance for BPF_OBJ_PIN and BPF_OBJ_GET
commands. This patch closes this oversight, adding path_fd field to
BPF_OBJ_PIN and BPF_OBJ_GET UAPI, following conventions established by
*at() syscalls for dirfd + pathname combinations.

This now allows interesting possibilities like working with detached BPF
FS mount (e.g., to perform multiple pinnings without running a risk of
someone interfering with them), and generally making pinning/getting
more secure and not prone to any races and/or security attacks.

This is demonstrated by a selftest added in subsequent patch that takes
advantage of new mount APIs (fsopen, fsconfig, fsmount) to demonstrate
creating detached BPF FS mount, pinning, and then getting BPF map out of
it, all while never exposing this private instance of BPF FS to outside
worlds.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h            |  4 ++--
 include/uapi/linux/bpf.h       |  5 +++++
 kernel/bpf/inode.c             | 16 ++++++++--------
 kernel/bpf/syscall.c           |  8 +++++---
 tools/include/uapi/linux/bpf.h |  5 +++++
 5 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 36e4b2d8cca2..f58895830ada 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2077,8 +2077,8 @@ struct file *bpf_link_new_file(struct bpf_link *lin=
k, int *reserved_fd);
 struct bpf_link *bpf_link_get_from_fd(u32 ufd);
 struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
=20
-int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
-int bpf_obj_get_user(const char __user *pathname, int flags);
+int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
+int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags=
);
=20
 #define BPF_ITER_FUNC_PREFIX "bpf_iter_"
 #define DEFINE_BPF_ITER_FUNC(target, args...)			\
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 1bb11a6ee667..db2870a52ce0 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1420,6 +1420,11 @@ union bpf_attr {
 		__aligned_u64	pathname;
 		__u32		bpf_fd;
 		__u32		file_flags;
+		/* same as dirfd in openat() syscall; see openat(2)
+		 * manpage for details of dirfd/path_fd and pathname semantics;
+		 * zero path_fd implies AT_FDCWD behavior
+		 */
+		__u32		path_fd;
 	};
=20
 	struct { /* anonymous struct used by BPF_PROG_ATTACH/DETACH commands */
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 9948b542a470..13bb54f6bd17 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -435,7 +435,7 @@ static int bpf_iter_link_pin_kernel(struct dentry *pa=
rent,
 	return ret;
 }
=20
-static int bpf_obj_do_pin(const char __user *pathname, void *raw,
+static int bpf_obj_do_pin(int path_fd, const char __user *pathname, void=
 *raw,
 			  enum bpf_type type)
 {
 	struct dentry *dentry;
@@ -444,7 +444,7 @@ static int bpf_obj_do_pin(const char __user *pathname=
, void *raw,
 	umode_t mode;
 	int ret;
=20
-	dentry =3D user_path_create(AT_FDCWD, pathname, &path, 0);
+	dentry =3D user_path_create(path_fd, pathname, &path, 0);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
=20
@@ -478,7 +478,7 @@ static int bpf_obj_do_pin(const char __user *pathname=
, void *raw,
 	return ret;
 }
=20
-int bpf_obj_pin_user(u32 ufd, const char __user *pathname)
+int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname)
 {
 	enum bpf_type type;
 	void *raw;
@@ -488,14 +488,14 @@ int bpf_obj_pin_user(u32 ufd, const char __user *pa=
thname)
 	if (IS_ERR(raw))
 		return PTR_ERR(raw);
=20
-	ret =3D bpf_obj_do_pin(pathname, raw, type);
+	ret =3D bpf_obj_do_pin(path_fd, pathname, raw, type);
 	if (ret !=3D 0)
 		bpf_any_put(raw, type);
=20
 	return ret;
 }
=20
-static void *bpf_obj_do_get(const char __user *pathname,
+static void *bpf_obj_do_get(int path_fd, const char __user *pathname,
 			    enum bpf_type *type, int flags)
 {
 	struct inode *inode;
@@ -503,7 +503,7 @@ static void *bpf_obj_do_get(const char __user *pathna=
me,
 	void *raw;
 	int ret;
=20
-	ret =3D user_path_at(AT_FDCWD, pathname, LOOKUP_FOLLOW, &path);
+	ret =3D user_path_at(path_fd, pathname, LOOKUP_FOLLOW, &path);
 	if (ret)
 		return ERR_PTR(ret);
=20
@@ -527,7 +527,7 @@ static void *bpf_obj_do_get(const char __user *pathna=
me,
 	return ERR_PTR(ret);
 }
=20
-int bpf_obj_get_user(const char __user *pathname, int flags)
+int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags=
)
 {
 	enum bpf_type type =3D BPF_TYPE_UNSPEC;
 	int f_flags;
@@ -538,7 +538,7 @@ int bpf_obj_get_user(const char __user *pathname, int=
 flags)
 	if (f_flags < 0)
 		return f_flags;
=20
-	raw =3D bpf_obj_do_get(pathname, &type, f_flags);
+	raw =3D bpf_obj_do_get(path_fd, pathname, &type, f_flags);
 	if (IS_ERR(raw))
 		return PTR_ERR(raw);
=20
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 909c112ef537..65a46f6d4be0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2697,14 +2697,15 @@ static int bpf_prog_load(union bpf_attr *attr, bp=
fptr_t uattr, u32 uattr_size)
 	return err;
 }
=20
-#define BPF_OBJ_LAST_FIELD file_flags
+#define BPF_OBJ_LAST_FIELD path_fd
=20
 static int bpf_obj_pin(const union bpf_attr *attr)
 {
 	if (CHECK_ATTR(BPF_OBJ) || attr->file_flags !=3D 0)
 		return -EINVAL;
=20
-	return bpf_obj_pin_user(attr->bpf_fd, u64_to_user_ptr(attr->pathname));
+	return bpf_obj_pin_user(attr->bpf_fd, attr->path_fd ?: AT_FDCWD,
+				u64_to_user_ptr(attr->pathname));
 }
=20
 static int bpf_obj_get(const union bpf_attr *attr)
@@ -2713,7 +2714,8 @@ static int bpf_obj_get(const union bpf_attr *attr)
 	    attr->file_flags & ~BPF_OBJ_FLAG_MASK)
 		return -EINVAL;
=20
-	return bpf_obj_get_user(u64_to_user_ptr(attr->pathname),
+	return bpf_obj_get_user(attr->path_fd ?: AT_FDCWD,
+				u64_to_user_ptr(attr->pathname),
 				attr->file_flags);
 }
=20
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 1bb11a6ee667..db2870a52ce0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1420,6 +1420,11 @@ union bpf_attr {
 		__aligned_u64	pathname;
 		__u32		bpf_fd;
 		__u32		file_flags;
+		/* same as dirfd in openat() syscall; see openat(2)
+		 * manpage for details of dirfd/path_fd and pathname semantics;
+		 * zero path_fd implies AT_FDCWD behavior
+		 */
+		__u32		path_fd;
 	};
=20
 	struct { /* anonymous struct used by BPF_PROG_ATTACH/DETACH commands */
--=20
2.34.1


