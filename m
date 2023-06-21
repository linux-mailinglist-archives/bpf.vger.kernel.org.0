Return-Path: <bpf+bounces-3079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA52739319
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 01:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1370D1C203BF
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 23:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF3C1DCCE;
	Wed, 21 Jun 2023 23:38:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A041DCB5
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 23:38:24 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E661730
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 16:38:21 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LIqrkO007418
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 16:38:21 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rc05hwt75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 16:38:20 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 16:38:19 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id B17CB333E885B; Wed, 21 Jun 2023 16:38:11 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>
CC: <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>, <cyphar@cyphar.com>,
        <luto@kernel.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v3 bpf-next 01/14] bpf: introduce BPF token object
Date: Wed, 21 Jun 2023 16:37:56 -0700
Message-ID: <20230621233809.1941811-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621233809.1941811-1-andrii@kernel.org>
References: <20230621233809.1941811-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: eJxxpD-OC0iwlLhF7Jdq1CwWBUg7o11x
X-Proofpoint-ORIG-GUID: eJxxpD-OC0iwlLhF7Jdq1CwWBUg7o11x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_12,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add new kind of BPF kernel object, BPF token. BPF token is meant to to
allow delegating privileged BPF functionality, like loading a BPF
program or creating a BPF map, from privileged process to a *trusted*
unprivileged process, all while have a good amount of control over which
privileged operations could be performed using provided BPF token.

This patch adds new BPF_TOKEN_CREATE command to bpf() syscall, which
allows to create a new BPF token object along with a set of allowed
commands that such BPF token allows to unprivileged applications.
Currently only BPF_TOKEN_CREATE command itself can be
delegated, but other patches gradually add ability to delegate
BPF_MAP_CREATE, BPF_BTF_LOAD, and BPF_PROG_LOAD commands.

The above means that new BPF tokens can be created using existing BPF
token, if original privileged creator allowed BPF_TOKEN_CREATE command.
New derived BPF token cannot be more powerful than the original BPF
token.

Importantly, BPF token is automatically pinned at the specified location
inside an instance of BPF FS and cannot be repinned using BPF_OBJ_PIN
command, unlike BPF prog/map/btf/link. This provides more control over
unintended sharing of BPF tokens through pinning it in another BPF FS
instances.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h            |  47 ++++++++++
 include/uapi/linux/bpf.h       |  38 ++++++++
 kernel/bpf/Makefile            |   2 +-
 kernel/bpf/inode.c             |  46 +++++++--
 kernel/bpf/syscall.c           |  17 ++++
 kernel/bpf/token.c             | 167 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  38 ++++++++
 7 files changed, 344 insertions(+), 11 deletions(-)
 create mode 100644 kernel/bpf/token.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f58895830ada..c4f1684aa138 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -51,6 +51,7 @@ struct module;
 struct bpf_func_state;
 struct ftrace_ops;
 struct cgroup;
+struct bpf_token;
=20
 extern struct idr btf_idr;
 extern spinlock_t btf_idr_lock;
@@ -1533,6 +1534,12 @@ struct bpf_link_primer {
 	u32 id;
 };
=20
+struct bpf_token {
+	struct work_struct work;
+	atomic64_t refcnt;
+	u64 allowed_cmds;
+};
+
 struct bpf_struct_ops_value;
 struct btf_member;
=20
@@ -1916,6 +1923,11 @@ bpf_prog_run_array_sleepable(const struct bpf_prog=
_array __rcu *array_rcu,
 	return ret;
 }
=20
+static inline bool bpf_token_capable(const struct bpf_token *token, int =
cap)
+{
+	return token || capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(CAP_=
SYS_ADMIN));
+}
+
 #ifdef CONFIG_BPF_SYSCALL
 DECLARE_PER_CPU(int, bpf_prog_active);
 extern struct mutex bpf_stats_enabled_mutex;
@@ -2077,8 +2089,25 @@ struct file *bpf_link_new_file(struct bpf_link *li=
nk, int *reserved_fd);
 struct bpf_link *bpf_link_get_from_fd(u32 ufd);
 struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
=20
+void bpf_token_inc(struct bpf_token *token);
+void bpf_token_put(struct bpf_token *token);
+int bpf_token_create(union bpf_attr *attr);
+int bpf_token_new_fd(struct bpf_token *token);
+struct bpf_token *bpf_token_get_from_fd(u32 ufd);
+
+bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd=
);
+
+enum bpf_type {
+	BPF_TYPE_UNSPEC	=3D 0,
+	BPF_TYPE_PROG,
+	BPF_TYPE_MAP,
+	BPF_TYPE_LINK,
+	BPF_TYPE_TOKEN,
+};
+
 int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
 int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags=
);
+int bpf_obj_pin_any(int path_fd, const char __user *pathname, void *raw,=
 enum bpf_type type);
=20
 #define BPF_ITER_FUNC_PREFIX "bpf_iter_"
 #define DEFINE_BPF_ITER_FUNC(target, args...)			\
@@ -2436,6 +2465,24 @@ static inline int bpf_obj_get_user(const char __us=
er *pathname, int flags)
 	return -EOPNOTSUPP;
 }
=20
+static inline void bpf_token_inc(struct bpf_token *token)
+{
+}
+
+static inline void bpf_token_put(struct bpf_token *token)
+{
+}
+
+static inline int bpf_token_new_fd(struct bpf_token *token)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline struct bpf_token *bpf_token_get_from_fd(u32 ufd)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline void __dev_flush(void)
 {
 }
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a7b5e91dd768..3c201cfe6d5c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -846,6 +846,24 @@ union bpf_iter_link_info {
  *		Returns zero on success. On error, -1 is returned and *errno*
  *		is set appropriately.
  *
+ * BPF_TOKEN_CREATE
+ *	Description
+ *		Create BPF token with embedded information about what
+ *		BPF-related functionality it allows. This BPF token can be
+ *		passed as an extra parameter to various bpf() syscall commands
+ *		to grant BPF subsystem functionality to unprivileged processes.
+ *		BPF token is automatically pinned at specified location in BPF
+ *		FS. It can be retrieved (to get FD passed to bpf() syscall)
+ *		using BPF_OBJ_GET command. It's not allowed to re-pin BPF
+ *		token using BPF_OBJ_PIN command. Such restrictions ensure BPF
+ *		token stays associated with originally intended BPF FS
+ *		instance and cannot be intentionally or unintentionally pinned
+ *		somewhere else.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -900,6 +918,7 @@ enum bpf_cmd {
 	BPF_ITER_CREATE,
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
+	BPF_TOKEN_CREATE,
 };
=20
 enum bpf_map_type {
@@ -1621,6 +1640,25 @@ union bpf_attr {
 		__u32		flags;		/* extra flags */
 	} prog_bind_map;
=20
+	struct { /* struct used by BPF_TOKEN_CREATE command */
+		/* optional, BPF token FD granting operation */
+		__u32		token_fd;
+		__u32		token_flags;
+		__u32		pin_flags;
+		/* pin_{path_fd,pathname} specify location in BPF FS instance
+		 * to pin BPF token at;
+		 * path_fd + pathname have the same semantics as openat() syscall
+		 */
+		__u32		pin_path_fd;
+		__u64		pin_pathname;
+		/* a bit set of allowed bpf() syscall commands,
+		 * e.g., (1ULL << BPF_TOKEN_CREATE) | (1ULL << BPF_PROG_LOAD)
+		 * will allow creating derived BPF tokens and loading new BPF
+		 * programs
+		 */
+		__u64		allowed_cmds;
+	} token_create;
+
 } __attribute__((aligned(8)));
=20
 /* The description below is an attempt at providing documentation to eBP=
F
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 1d3892168d32..bbc17ea3878f 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) :=3D -fno-=
gcse
 endif
 CFLAGS_core.o +=3D $(call cc-disable-warning, override-init) $(cflags-no=
gcse-yy)
=20
-obj-$(CONFIG_BPF_SYSCALL) +=3D syscall.o verifier.o inode.o helpers.o tn=
um.o log.o
+obj-$(CONFIG_BPF_SYSCALL) +=3D syscall.o verifier.o inode.o helpers.o tn=
um.o log.o token.o
 obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_iter.o map_iter.o task_iter.o prog_it=
er.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) +=3D hashtab.o arraymap.o percpu_freelist.o bp=
f_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) +=3D local_storage.o queue_stack_maps.o ringbu=
f.o
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 4174f76133df..b9b93b81af9a 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -22,13 +22,6 @@
 #include <linux/bpf_trace.h>
 #include "preload/bpf_preload.h"
=20
-enum bpf_type {
-	BPF_TYPE_UNSPEC	=3D 0,
-	BPF_TYPE_PROG,
-	BPF_TYPE_MAP,
-	BPF_TYPE_LINK,
-};
-
 static void *bpf_any_get(void *raw, enum bpf_type type)
 {
 	switch (type) {
@@ -41,6 +34,9 @@ static void *bpf_any_get(void *raw, enum bpf_type type)
 	case BPF_TYPE_LINK:
 		bpf_link_inc(raw);
 		break;
+	case BPF_TYPE_TOKEN:
+		bpf_token_inc(raw);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		break;
@@ -61,6 +57,9 @@ static void bpf_any_put(void *raw, enum bpf_type type)
 	case BPF_TYPE_LINK:
 		bpf_link_put(raw);
 		break;
+	case BPF_TYPE_TOKEN:
+		bpf_token_put(raw);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		break;
@@ -89,6 +88,12 @@ static void *bpf_fd_probe_obj(u32 ufd, enum bpf_type *=
type)
 		return raw;
 	}
=20
+	raw =3D bpf_token_get_from_fd(ufd);
+	if (!IS_ERR(raw)) {
+		*type =3D BPF_TYPE_TOKEN;
+		return raw;
+	}
+
 	return ERR_PTR(-EINVAL);
 }
=20
@@ -97,6 +102,7 @@ static const struct inode_operations bpf_dir_iops;
 static const struct inode_operations bpf_prog_iops =3D { };
 static const struct inode_operations bpf_map_iops  =3D { };
 static const struct inode_operations bpf_link_iops  =3D { };
+static const struct inode_operations bpf_token_iops  =3D { };
=20
 static struct inode *bpf_get_inode(struct super_block *sb,
 				   const struct inode *dir,
@@ -136,6 +142,8 @@ static int bpf_inode_type(const struct inode *inode, =
enum bpf_type *type)
 		*type =3D BPF_TYPE_MAP;
 	else if (inode->i_op =3D=3D &bpf_link_iops)
 		*type =3D BPF_TYPE_LINK;
+	else if (inode->i_op =3D=3D &bpf_token_iops)
+		*type =3D BPF_TYPE_TOKEN;
 	else
 		return -EACCES;
=20
@@ -369,6 +377,11 @@ static int bpf_mklink(struct dentry *dentry, umode_t=
 mode, void *arg)
 			     &bpf_iter_fops : &bpffs_obj_fops);
 }
=20
+static int bpf_mktoken(struct dentry *dentry, umode_t mode, void *arg)
+{
+	return bpf_mkobj_ops(dentry, mode, arg, &bpf_token_iops, &bpffs_obj_fop=
s);
+}
+
 static struct dentry *
 bpf_lookup(struct inode *dir, struct dentry *dentry, unsigned flags)
 {
@@ -435,8 +448,8 @@ static int bpf_iter_link_pin_kernel(struct dentry *pa=
rent,
 	return ret;
 }
=20
-static int bpf_obj_do_pin(int path_fd, const char __user *pathname, void=
 *raw,
-			  enum bpf_type type)
+int bpf_obj_pin_any(int path_fd, const char __user *pathname, void *raw,
+		    enum bpf_type type)
 {
 	struct dentry *dentry;
 	struct inode *dir;
@@ -469,6 +482,9 @@ static int bpf_obj_do_pin(int path_fd, const char __u=
ser *pathname, void *raw,
 	case BPF_TYPE_LINK:
 		ret =3D vfs_mkobj(dentry, mode, bpf_mklink, raw);
 		break;
+	case BPF_TYPE_TOKEN:
+		ret =3D vfs_mkobj(dentry, mode, bpf_mktoken, raw);
+		break;
 	default:
 		ret =3D -EPERM;
 	}
@@ -487,7 +503,15 @@ int bpf_obj_pin_user(u32 ufd, int path_fd, const cha=
r __user *pathname)
 	if (IS_ERR(raw))
 		return PTR_ERR(raw);
=20
-	ret =3D bpf_obj_do_pin(path_fd, pathname, raw, type);
+	/* disallow BPF_OBJ_PIN command for BPF token; BPF token can only be
+	 * auto-pinned during creation with BPF_TOKEN_CREATE
+	 */
+	if (type =3D=3D BPF_TYPE_TOKEN) {
+		bpf_any_put(raw, type);
+		return -EOPNOTSUPP;
+	}
+
+	ret =3D bpf_obj_pin_any(path_fd, pathname, raw, type);
 	if (ret !=3D 0)
 		bpf_any_put(raw, type);
=20
@@ -547,6 +571,8 @@ int bpf_obj_get_user(int path_fd, const char __user *=
pathname, int flags)
 		ret =3D bpf_map_new_fd(raw, f_flags);
 	else if (type =3D=3D BPF_TYPE_LINK)
 		ret =3D (f_flags !=3D O_RDWR) ? -EINVAL : bpf_link_new_fd(raw);
+	else if (type =3D=3D BPF_TYPE_TOKEN)
+		ret =3D (f_flags !=3D O_RDWR) ? -EINVAL : bpf_token_new_fd(raw);
 	else
 		return -ENOENT;
=20
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a75c54b6f8a3..c48e0e829b06 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5081,6 +5081,20 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 	return ret;
 }
=20
+#define BPF_TOKEN_CREATE_LAST_FIELD token_create.allowed_cmds
+
+static int token_create(union bpf_attr *attr)
+{
+	if (CHECK_ATTR(BPF_TOKEN_CREATE))
+		return -EINVAL;
+
+	/* no flags are supported yet */
+	if (attr->token_create.token_flags || attr->token_create.pin_flags)
+		return -EINVAL;
+
+	return bpf_token_create(attr);
+}
+
 static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 {
 	union bpf_attr attr;
@@ -5214,6 +5228,9 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsig=
ned int size)
 	case BPF_PROG_BIND_MAP:
 		err =3D bpf_prog_bind_map(&attr);
 		break;
+	case BPF_TOKEN_CREATE:
+		err =3D token_create(&attr);
+		break;
 	default:
 		err =3D -EINVAL;
 		break;
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
new file mode 100644
index 000000000000..1ece52439701
--- /dev/null
+++ b/kernel/bpf/token.c
@@ -0,0 +1,167 @@
+#include <linux/bpf.h>
+#include <linux/vmalloc.h>
+#include <linux/anon_inodes.h>
+#include <linux/fdtable.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/idr.h>
+#include <linux/namei.h>
+
+DEFINE_IDR(token_idr);
+DEFINE_SPINLOCK(token_idr_lock);
+
+void bpf_token_inc(struct bpf_token *token)
+{
+	atomic64_inc(&token->refcnt);
+}
+
+static void bpf_token_put_deferred(struct work_struct *work)
+{
+	struct bpf_token *token =3D container_of(work, struct bpf_token, work);
+
+	kvfree(token);
+}
+
+void bpf_token_put(struct bpf_token *token)
+{
+	if (!token)
+		return;
+
+	if (!atomic64_dec_and_test(&token->refcnt))
+		return;
+
+	INIT_WORK(&token->work, bpf_token_put_deferred);
+	schedule_work(&token->work);
+}
+
+static int bpf_token_release(struct inode *inode, struct file *filp)
+{
+	struct bpf_token *token =3D filp->private_data;
+
+	bpf_token_put(token);
+	return 0;
+}
+
+static ssize_t bpf_dummy_read(struct file *filp, char __user *buf, size_=
t siz,
+			      loff_t *ppos)
+{
+	/* We need this handler such that alloc_file() enables
+	 * f_mode with FMODE_CAN_READ.
+	 */
+	return -EINVAL;
+}
+
+static ssize_t bpf_dummy_write(struct file *filp, const char __user *buf=
,
+			       size_t siz, loff_t *ppos)
+{
+	/* We need this handler such that alloc_file() enables
+	 * f_mode with FMODE_CAN_WRITE.
+	 */
+	return -EINVAL;
+}
+
+static const struct file_operations bpf_token_fops =3D {
+	.release	=3D bpf_token_release,
+	.read		=3D bpf_dummy_read,
+	.write		=3D bpf_dummy_write,
+};
+
+static struct bpf_token *bpf_token_alloc(void)
+{
+	struct bpf_token *token;
+
+	token =3D kvzalloc(sizeof(*token), GFP_USER);
+	if (!token)
+		return NULL;
+
+	atomic64_set(&token->refcnt, 1);
+
+	return token;
+}
+
+static bool is_bit_subset_of(u32 subset, u32 superset)
+{
+	return (superset & subset) =3D=3D subset;
+}
+
+int bpf_token_create(union bpf_attr *attr)
+{
+	struct bpf_token *new_token, *token =3D NULL;
+	int ret;
+
+	if (attr->token_create.token_fd) {
+		token =3D bpf_token_get_from_fd(attr->token_create.token_fd);
+		if (IS_ERR(token))
+			return PTR_ERR(token);
+		/* if provided BPF token doesn't allow creating new tokens,
+		 * then use system-wide capability checks only
+		 */
+		if (!bpf_token_allow_cmd(token, BPF_TOKEN_CREATE)) {
+			bpf_token_put(token);
+			token =3D NULL;
+		}
+	}
+
+	ret =3D -EPERM;
+	if (!bpf_token_capable(token, CAP_SYS_ADMIN))
+		goto out;
+
+	/* requested cmds should be a subset of associated token's set */
+	if (token && !is_bit_subset_of(attr->token_create.allowed_cmds, token->=
allowed_cmds))
+		goto out;
+
+	new_token =3D bpf_token_alloc();
+	if (!new_token) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	new_token->allowed_cmds =3D attr->token_create.allowed_cmds;
+
+	ret =3D bpf_obj_pin_any(attr->token_create.pin_path_fd,
+			      u64_to_user_ptr(attr->token_create.pin_pathname),
+			      new_token, BPF_TYPE_TOKEN);
+	if (ret < 0)
+		bpf_token_put(new_token);
+out:
+	bpf_token_put(token);
+	return ret;
+}
+
+#define BPF_TOKEN_INODE_NAME "bpf-token"
+
+/* Alloc anon_inode and FD for prepared token.
+ * Returns fd >=3D 0 on success; negative error, otherwise.
+ */
+int bpf_token_new_fd(struct bpf_token *token)
+{
+	return anon_inode_getfd(BPF_TOKEN_INODE_NAME, &bpf_token_fops, token, O=
_CLOEXEC);
+}
+
+struct bpf_token *bpf_token_get_from_fd(u32 ufd)
+{
+	struct fd f =3D fdget(ufd);
+	struct bpf_token *token;
+
+	if (!f.file)
+		return ERR_PTR(-EBADF);
+	if (f.file->f_op !=3D &bpf_token_fops) {
+		fdput(f);
+		return ERR_PTR(-EINVAL);
+	}
+
+	token =3D f.file->private_data;
+	bpf_token_inc(token);
+	fdput(f);
+
+	return token;
+}
+
+bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd=
)
+{
+	if (!token)
+		return false;
+
+	return token->allowed_cmds & (1ULL << cmd);
+}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index a7b5e91dd768..3c201cfe6d5c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -846,6 +846,24 @@ union bpf_iter_link_info {
  *		Returns zero on success. On error, -1 is returned and *errno*
  *		is set appropriately.
  *
+ * BPF_TOKEN_CREATE
+ *	Description
+ *		Create BPF token with embedded information about what
+ *		BPF-related functionality it allows. This BPF token can be
+ *		passed as an extra parameter to various bpf() syscall commands
+ *		to grant BPF subsystem functionality to unprivileged processes.
+ *		BPF token is automatically pinned at specified location in BPF
+ *		FS. It can be retrieved (to get FD passed to bpf() syscall)
+ *		using BPF_OBJ_GET command. It's not allowed to re-pin BPF
+ *		token using BPF_OBJ_PIN command. Such restrictions ensure BPF
+ *		token stays associated with originally intended BPF FS
+ *		instance and cannot be intentionally or unintentionally pinned
+ *		somewhere else.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -900,6 +918,7 @@ enum bpf_cmd {
 	BPF_ITER_CREATE,
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
+	BPF_TOKEN_CREATE,
 };
=20
 enum bpf_map_type {
@@ -1621,6 +1640,25 @@ union bpf_attr {
 		__u32		flags;		/* extra flags */
 	} prog_bind_map;
=20
+	struct { /* struct used by BPF_TOKEN_CREATE command */
+		/* optional, BPF token FD granting operation */
+		__u32		token_fd;
+		__u32		token_flags;
+		__u32		pin_flags;
+		/* pin_{path_fd,pathname} specify location in BPF FS instance
+		 * to pin BPF token at;
+		 * path_fd + pathname have the same semantics as openat() syscall
+		 */
+		__u32		pin_path_fd;
+		__u64		pin_pathname;
+		/* a bit set of allowed bpf() syscall commands,
+		 * e.g., (1ULL << BPF_TOKEN_CREATE) | (1ULL << BPF_PROG_LOAD)
+		 * will allow creating derived BPF tokens and loading new BPF
+		 * programs
+		 */
+		__u64		allowed_cmds;
+	} token_create;
+
 } __attribute__((aligned(8)));
=20
 /* The description below is an attempt at providing documentation to eBP=
F
--=20
2.34.1


