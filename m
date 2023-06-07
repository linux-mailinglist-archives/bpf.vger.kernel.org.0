Return-Path: <bpf+bounces-2057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388A7727371
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 01:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8589C1C20F5E
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 23:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3583B418;
	Wed,  7 Jun 2023 23:54:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD511DCA6
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 23:54:15 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2C89E
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 16:54:13 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 357H1Rxi017034
	for <bpf@vger.kernel.org>; Wed, 7 Jun 2023 16:54:12 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3r2aabk0kw-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 16:54:12 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 16:54:06 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id ABA4432857D2D; Wed,  7 Jun 2023 16:53:54 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>
CC: <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>, <cyphar@cyphar.com>,
        <luto@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 01/18] bpf: introduce BPF token object
Date: Wed, 7 Jun 2023 16:53:35 -0700
Message-ID: <20230607235352.1723243-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607235352.1723243-1-andrii@kernel.org>
References: <20230607235352.1723243-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: EJbZjwgS68Jke9on81cbxPIH8KK9etKU
X-Proofpoint-GUID: EJbZjwgS68Jke9on81cbxPIH8KK9etKU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add new kind of BPF kernel object, BPF token. BPF token is meant to to
allow delegating privileged BPF functionality, like loading a BPF
program or creating a BPF map, from privileged process to a *trusted*
unprivileged process, all while have a good amount of control over which
privileged operation could be done using provided BPF token.

This patch adds new BPF_TOKEN_CREATE command to bpf() syscall, which
allows to create a new BPF token object along with a set of allowed
commands. Currently only BPF_TOKEN_CREATE command itself can be
delegated, but other patches gradually add ability to delegate
BPF_MAP_CREATE, BPF_BTF_LOAD, and BPF_PROG_LOAD commands.

The above means that BPF token creation can be allowed by another
existing BPF token, if original privileged creator allowed that. New
derived BPF token cannot be more powerful than the original BPF token.

Lastly, BPF token can be pinned in and retrieved from BPF FS, just like
progs, maps, BTFs, and links. This allows applications (like container
managers) to share BPF token with other applications through file system
just like any other BPF object, and further control access to it using
file system permissions, if desired.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h            |  38 +++++++++++
 include/uapi/linux/bpf.h       |  22 +++++++
 kernel/bpf/Makefile            |   2 +-
 kernel/bpf/inode.c             |  26 ++++++++
 kernel/bpf/syscall.c           |  70 ++++++++++++++++++++
 kernel/bpf/token.c             | 117 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  22 +++++++
 7 files changed, 296 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/token.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f58895830ada..5f3944352c26 100644
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
@@ -2077,6 +2089,14 @@ struct file *bpf_link_new_file(struct bpf_link *li=
nk, int *reserved_fd);
 struct bpf_link *bpf_link_get_from_fd(u32 ufd);
 struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
=20
+void bpf_token_inc(struct bpf_token *token);
+void bpf_token_put(struct bpf_token *token);
+struct bpf_token *bpf_token_alloc(void);
+int bpf_token_new_fd(struct bpf_token *token);
+struct bpf_token *bpf_token_get_from_fd(u32 ufd);
+
+bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd=
);
+
 int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
 int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags=
);
=20
@@ -2436,6 +2456,24 @@ static inline int bpf_obj_get_user(const char __us=
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
index a7b5e91dd768..3e7e8d8cbe90 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -846,6 +846,16 @@ union bpf_iter_link_info {
  *		Returns zero on success. On error, -1 is returned and *errno*
  *		is set appropriately.
  *
+ * BPF_TOKEN_CREATE
+ *	Description
+ *		Create BPF token with embedded information about what
+ *		BPF-related functionality is allowed. This BPF token can be
+ *		passed as an extra parameter to various bpf() syscall command.
+ *
+ *	Return
+ *		A new file descriptor (a nonnegative integer), or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -900,6 +910,7 @@ enum bpf_cmd {
 	BPF_ITER_CREATE,
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
+	BPF_TOKEN_CREATE,
 };
=20
 enum bpf_map_type {
@@ -1621,6 +1632,17 @@ union bpf_attr {
 		__u32		flags;		/* extra flags */
 	} prog_bind_map;
=20
+	struct { /* struct used by BPF_TOKEN_CREATE command */
+		__u32		flags;
+		__u32		token_fd;
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
index 4174f76133df..55d9a945ad18 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -27,6 +27,7 @@ enum bpf_type {
 	BPF_TYPE_PROG,
 	BPF_TYPE_MAP,
 	BPF_TYPE_LINK,
+	BPF_TYPE_TOKEN,
 };
=20
 static void *bpf_any_get(void *raw, enum bpf_type type)
@@ -41,6 +42,9 @@ static void *bpf_any_get(void *raw, enum bpf_type type)
 	case BPF_TYPE_LINK:
 		bpf_link_inc(raw);
 		break;
+	case BPF_TYPE_TOKEN:
+		bpf_token_inc(raw);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		break;
@@ -61,6 +65,9 @@ static void bpf_any_put(void *raw, enum bpf_type type)
 	case BPF_TYPE_LINK:
 		bpf_link_put(raw);
 		break;
+	case BPF_TYPE_TOKEN:
+		bpf_token_put(raw);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		break;
@@ -89,6 +96,12 @@ static void *bpf_fd_probe_obj(u32 ufd, enum bpf_type *=
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
@@ -97,6 +110,7 @@ static const struct inode_operations bpf_dir_iops;
 static const struct inode_operations bpf_prog_iops =3D { };
 static const struct inode_operations bpf_map_iops  =3D { };
 static const struct inode_operations bpf_link_iops  =3D { };
+static const struct inode_operations bpf_token_iops  =3D { };
=20
 static struct inode *bpf_get_inode(struct super_block *sb,
 				   const struct inode *dir,
@@ -136,6 +150,8 @@ static int bpf_inode_type(const struct inode *inode, =
enum bpf_type *type)
 		*type =3D BPF_TYPE_MAP;
 	else if (inode->i_op =3D=3D &bpf_link_iops)
 		*type =3D BPF_TYPE_LINK;
+	else if (inode->i_op =3D=3D &bpf_token_iops)
+		*type =3D BPF_TYPE_TOKEN;
 	else
 		return -EACCES;
=20
@@ -369,6 +385,11 @@ static int bpf_mklink(struct dentry *dentry, umode_t=
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
@@ -469,6 +490,9 @@ static int bpf_obj_do_pin(int path_fd, const char __u=
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
index 92a57efc77de..1d8b513ce318 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5024,6 +5024,73 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 	return ret;
 }
=20
+static bool is_bit_subset_of(u32 subset, u32 superset)
+{
+	return (superset & subset) =3D=3D subset;
+}
+
+#define BPF_TOKEN_CMDS_MASK ((1ULL << BPF_TOKEN_CREATE))
+
+#define BPF_TOKEN_CREATE_LAST_FIELD token_create.allowed_cmds
+
+static int token_create(union bpf_attr *attr)
+{
+	struct bpf_token *new_token, *token =3D NULL;
+	int fd, err;
+
+	if (CHECK_ATTR(BPF_TOKEN_CREATE))
+		return -EINVAL;
+
+	if (attr->token_create.flags)
+		return -EINVAL;
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
+	if (!bpf_token_capable(token, CAP_SYS_ADMIN)) {
+		err =3D -EPERM;
+		goto err_out;
+	}
+
+	/* requested cmds should be a subset of associated token's set */
+	if (token && !is_bit_subset_of(attr->token_create.allowed_cmds, token->=
allowed_cmds)) {
+		err =3D -EPERM;
+		goto err_out;
+	}
+
+	new_token =3D bpf_token_alloc();
+	if (!new_token) {
+		err =3D -ENOMEM;
+		goto err_out;
+	}
+
+	new_token->allowed_cmds =3D attr->token_create.allowed_cmds;
+
+	fd =3D bpf_token_new_fd(new_token);
+	if (fd < 0) {
+		bpf_token_put(new_token);
+		err =3D fd;
+		goto err_out;
+	}
+
+	bpf_token_put(token);
+	return fd;
+
+err_out:
+	bpf_token_put(token);
+	return err;
+}
+
 static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 {
 	union bpf_attr attr;
@@ -5172,6 +5239,9 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsig=
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
index 000000000000..4257281ca1ec
--- /dev/null
+++ b/kernel/bpf/token.c
@@ -0,0 +1,117 @@
+#include <linux/bpf.h>
+#include <linux/vmalloc.h>
+#include <linux/anon_inodes.h>
+#include <linux/fdtable.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/idr.h>
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
+struct bpf_token *bpf_token_alloc(void)
+{
+	struct bpf_token *token;
+
+	token =3D kvzalloc(sizeof(*token), GFP_USER);
+	if (token =3D=3D NULL)
+		return NULL;
+
+	atomic64_set(&token->refcnt, 1);
+
+	return token;
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
index a7b5e91dd768..3e7e8d8cbe90 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -846,6 +846,16 @@ union bpf_iter_link_info {
  *		Returns zero on success. On error, -1 is returned and *errno*
  *		is set appropriately.
  *
+ * BPF_TOKEN_CREATE
+ *	Description
+ *		Create BPF token with embedded information about what
+ *		BPF-related functionality is allowed. This BPF token can be
+ *		passed as an extra parameter to various bpf() syscall command.
+ *
+ *	Return
+ *		A new file descriptor (a nonnegative integer), or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -900,6 +910,7 @@ enum bpf_cmd {
 	BPF_ITER_CREATE,
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
+	BPF_TOKEN_CREATE,
 };
=20
 enum bpf_map_type {
@@ -1621,6 +1632,17 @@ union bpf_attr {
 		__u32		flags;		/* extra flags */
 	} prog_bind_map;
=20
+	struct { /* struct used by BPF_TOKEN_CREATE command */
+		__u32		flags;
+		__u32		token_fd;
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


