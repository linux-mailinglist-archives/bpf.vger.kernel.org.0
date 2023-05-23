Return-Path: <bpf+bounces-1111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C5870E28F
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 19:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C901C20D96
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 17:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDED52098D;
	Tue, 23 May 2023 17:00:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C45206AA
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 17:00:38 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263C3E5
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 10:00:36 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NFI9dQ014179
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 10:00:35 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qrkvvwrhv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 10:00:35 -0700
Received: from twshared40933.03.prn6.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 10:00:33 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id CE95031365360; Tue, 23 May 2023 10:00:20 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <cyphar@cyphar.com>, <brauner@kernel.org>, <lennart@poettering.net>,
        <linux-fsdevel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v4 bpf-next 3/4] bpf: support O_PATH FDs in BPF_OBJ_PIN and BPF_OBJ_GET commands
Date: Tue, 23 May 2023 10:00:12 -0700
Message-ID: <20230523170013.728457-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523170013.728457-1-andrii@kernel.org>
References: <20230523170013.728457-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: UVCUSd02tl25i1aSr6ni9h-I2h5Ifzzy
X-Proofpoint-ORIG-GUID: UVCUSd02tl25i1aSr6ni9h-I2h5Ifzzy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_10,2023-05-23_02,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h            |  4 ++--
 include/uapi/linux/bpf.h       | 10 ++++++++++
 kernel/bpf/inode.c             | 16 ++++++++--------
 kernel/bpf/syscall.c           | 25 ++++++++++++++++++++-----
 tools/include/uapi/linux/bpf.h | 10 ++++++++++
 tools/lib/bpf/bpf.c            | 17 ++++++++++++++---
 tools/lib/bpf/bpf.h            | 18 ++++++++++++++++--
 tools/lib/bpf/libbpf.map       |  2 ++
 8 files changed, 82 insertions(+), 20 deletions(-)

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
index 1bb11a6ee667..9273c654743c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1272,6 +1272,9 @@ enum {
=20
 /* Create a map that will be registered/unregesitered by the backed bpf_=
link */
 	BPF_F_LINK		=3D (1U << 13),
+
+/* Get path from provided FD in BPF_OBJ_PIN/BPF_OBJ_GET commands */
+	BPF_F_PATH_FD		=3D (1U << 14),
 };
=20
 /* Flags for BPF_PROG_QUERY. */
@@ -1420,6 +1423,13 @@ union bpf_attr {
 		__aligned_u64	pathname;
 		__u32		bpf_fd;
 		__u32		file_flags;
+		/* Same as dirfd in openat() syscall; see openat(2)
+		 * manpage for details of path FD and pathname semantics;
+		 * path_fd should accompanied by BPF_F_PATH_FD flag set in
+		 * file_flags field, otherwise it should be set to zero;
+		 * if BPF_F_PATH_FD flag is not set, AT_FDCWD is assumed.
+		 */
+		__s32		path_fd;
 	};
=20
 	struct { /* anonymous struct used by BPF_PROG_ATTACH/DETACH commands */
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 329f27d5cacf..4174f76133df 100644
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
@@ -477,7 +477,7 @@ static int bpf_obj_do_pin(const char __user *pathname=
, void *raw,
 	return ret;
 }
=20
-int bpf_obj_pin_user(u32 ufd, const char __user *pathname)
+int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname)
 {
 	enum bpf_type type;
 	void *raw;
@@ -487,14 +487,14 @@ int bpf_obj_pin_user(u32 ufd, const char __user *pa=
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
@@ -502,7 +502,7 @@ static void *bpf_obj_do_get(const char __user *pathna=
me,
 	void *raw;
 	int ret;
=20
-	ret =3D user_path_at(AT_FDCWD, pathname, LOOKUP_FOLLOW, &path);
+	ret =3D user_path_at(path_fd, pathname, LOOKUP_FOLLOW, &path);
 	if (ret)
 		return ERR_PTR(ret);
=20
@@ -526,7 +526,7 @@ static void *bpf_obj_do_get(const char __user *pathna=
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
@@ -537,7 +537,7 @@ int bpf_obj_get_user(const char __user *pathname, int=
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
index b2621089904b..c7f6807215e6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2697,23 +2697,38 @@ static int bpf_prog_load(union bpf_attr *attr, bp=
fptr_t uattr, u32 uattr_size)
 	return err;
 }
=20
-#define BPF_OBJ_LAST_FIELD file_flags
+#define BPF_OBJ_LAST_FIELD path_fd
=20
 static int bpf_obj_pin(const union bpf_attr *attr)
 {
-	if (CHECK_ATTR(BPF_OBJ) || attr->file_flags !=3D 0)
+	int path_fd;
+
+	if (CHECK_ATTR(BPF_OBJ) || attr->file_flags & ~BPF_F_PATH_FD)
+		return -EINVAL;
+
+	/* path_fd has to be accompanied by BPF_F_PATH_FD flag */
+	if (!(attr->file_flags & BPF_F_PATH_FD) && attr->path_fd)
 		return -EINVAL;
=20
-	return bpf_obj_pin_user(attr->bpf_fd, u64_to_user_ptr(attr->pathname));
+	path_fd =3D attr->file_flags & BPF_F_PATH_FD ? attr->path_fd : AT_FDCWD=
;
+	return bpf_obj_pin_user(attr->bpf_fd, path_fd,
+				u64_to_user_ptr(attr->pathname));
 }
=20
 static int bpf_obj_get(const union bpf_attr *attr)
 {
+	int path_fd;
+
 	if (CHECK_ATTR(BPF_OBJ) || attr->bpf_fd !=3D 0 ||
-	    attr->file_flags & ~BPF_OBJ_FLAG_MASK)
+	    attr->file_flags & ~(BPF_OBJ_FLAG_MASK | BPF_F_PATH_FD))
+		return -EINVAL;
+
+	/* path_fd has to be accompanied by BPF_F_PATH_FD flag */
+	if (!(attr->file_flags & BPF_F_PATH_FD) && attr->path_fd)
 		return -EINVAL;
=20
-	return bpf_obj_get_user(u64_to_user_ptr(attr->pathname),
+	path_fd =3D attr->file_flags & BPF_F_PATH_FD ? attr->path_fd : AT_FDCWD=
;
+	return bpf_obj_get_user(path_fd, u64_to_user_ptr(attr->pathname),
 				attr->file_flags);
 }
=20
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 1bb11a6ee667..9273c654743c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1272,6 +1272,9 @@ enum {
=20
 /* Create a map that will be registered/unregesitered by the backed bpf_=
link */
 	BPF_F_LINK		=3D (1U << 13),
+
+/* Get path from provided FD in BPF_OBJ_PIN/BPF_OBJ_GET commands */
+	BPF_F_PATH_FD		=3D (1U << 14),
 };
=20
 /* Flags for BPF_PROG_QUERY. */
@@ -1420,6 +1423,13 @@ union bpf_attr {
 		__aligned_u64	pathname;
 		__u32		bpf_fd;
 		__u32		file_flags;
+		/* Same as dirfd in openat() syscall; see openat(2)
+		 * manpage for details of path FD and pathname semantics;
+		 * path_fd should accompanied by BPF_F_PATH_FD flag set in
+		 * file_flags field, otherwise it should be set to zero;
+		 * if BPF_F_PATH_FD flag is not set, AT_FDCWD is assumed.
+		 */
+		__s32		path_fd;
 	};
=20
 	struct { /* anonymous struct used by BPF_PROG_ATTACH/DETACH commands */
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
index 9171ac89a802..7521a2fb7626 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -393,4 +393,6 @@ LIBBPF_1.2.0 {
 } LIBBPF_1.1.0;
=20
 LIBBPF_1.3.0 {
+	global:
+		bpf_obj_pin_opts;
 } LIBBPF_1.2.0;
--=20
2.34.1


