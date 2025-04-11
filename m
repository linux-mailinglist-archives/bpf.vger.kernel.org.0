Return-Path: <bpf+bounces-55703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2C4A85120
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 03:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF6617B3A7C
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 01:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2123A26F461;
	Fri, 11 Apr 2025 01:15:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00136946C
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744334148; cv=none; b=O1jqHP0wVg5p4TkSj72JqNRYDZcNJB/MD9P1f3bW8GSW8dZ3nPKvyr6VcisA8Ox7Bu+/y6gWqUcbl8HePxYGNbBpjT2VLFKjzaH8mRixJmjJ8UDwzE9PLBBj7TnyuJVpVf2HcERG8BYLW7HSKQ5E8ZwcXPb0B+JYkYaPgh8a+BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744334148; c=relaxed/simple;
	bh=Aq6asFm4xCFKxPb1Eex+0ndjt6+CSo0KdYo2WKIUiK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErwpF+tiV/f59SlBVQwTv44VhCTzNjMSfsR/MKh2wEiid6RmSqokLRCo1ph+1UpXtt787+FajJjtytqUHE6MXPpQKRyHxTO0L0vyyK7/QrGhKqpJDLpVwhc4C5W2lXQGeXAMRbOs+rDQXn/dDv0a8i407XuAU5jL8aEGSumPwck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 039B05149071; Thu, 10 Apr 2025 18:15:34 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [RFC PATCH bpf-next 2/4] bpf: Implement mprog API on top of existing cgroup progs
Date: Thu, 10 Apr 2025 18:15:33 -0700
Message-ID: <20250411011533.1839631-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411011523.1838771-1-yonghong.song@linux.dev>
References: <20250411011523.1838771-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Current cgroup prog ordering is appending at attachment time. This is not
ideal. In some cases, users want specific ordering at a particular cgroup
level. To address this, the existing mprog API seems an ideal solution wi=
th
supporting BPF_F_BEFORE and BPF_F_AFTER flags.

But there are a few obstacles to directly use kernel mprog interface.
Currently cgroup bpf progs already support prog attach/detach/replace
and link-based attach/detach/replace. For example, in struct
bpf_prog_array_item, the cgroup_storage field needs to be together
with bpf prog. But the mprog API struct bpf_mprog_fp only has bpf_prog
as the member, which makes it difficult to use kernel mprog interface.

In another case, the current cgroup prog detach tries to use the
same flag as in attach. This is different from mprog kernel interface
which uses flags passed from user space.

So to avoid modifying existing behavior, I made the following changes to
support mprog API for cgroup progs:
 - The support is for prog list at cgroup level. Cross-level prog list
   (a.k.a. effective prog list) is not supported.
 - Previously, BPF_F_PREORDER is supported only for prog attach, now
   BPF_F_PREORDER is also supported by link-based attach.
 - For attach, BPF_F_BEFORE/BPF_F_AFTER/BPF_F_ID is supported similar to
   kernel mprog but with different implementation.
 - For detach and replace, use the existing implementation.
 - For attach, detach and replace, the revision for a particular prog
   list, associated with a particular attach type, will be updated
   by increasing count by 1.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/uapi/linux/bpf.h       |   7 ++
 kernel/bpf/cgroup.c            | 151 ++++++++++++++++++++++++++++-----
 kernel/bpf/syscall.c           |  58 ++++++++-----
 tools/include/uapi/linux/bpf.h |   7 ++
 4 files changed, 181 insertions(+), 42 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 71d5ac83cf5d..a5c7992e8f7c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1794,6 +1794,13 @@ union bpf_attr {
 				};
 				__u64		expected_revision;
 			} netkit;
+			struct {
+				union {
+					__u32	relative_fd;
+					__u32	relative_id;
+				};
+				__u64		expected_revision;
+			} cgroup;
 		};
 	} link_create;
=20
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 84f58f3d028a..ffd455051131 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -624,6 +624,90 @@ static struct bpf_prog_list *find_attach_entry(struc=
t hlist_head *progs,
 	return NULL;
 }
=20
+static struct bpf_prog *get_cmp_prog(struct hlist_head *progs, struct bp=
f_prog *prog,
+				     u32 flags, u32 id_or_fd, struct bpf_prog_list **ppltmp)
+{
+	struct bpf_prog *cmp_prog =3D NULL, *pltmp_prog;
+	bool preorder =3D !!(flags & BPF_F_PREORDER);
+	struct bpf_prog_list *pltmp;
+	bool id =3D flags & BPF_F_ID;
+	bool found;
+
+	if (id || id_or_fd) {
+		/* flags must have BPF_F_BEFORE or BPF_F_AFTER */
+		if (!(flags & (BPF_F_BEFORE | BPF_F_AFTER)))
+			return ERR_PTR(-EINVAL);
+
+		if (id)
+			cmp_prog =3D bpf_prog_by_id(id_or_fd);
+		else
+			cmp_prog =3D bpf_prog_get(id_or_fd);
+		if (IS_ERR(cmp_prog))
+			return cmp_prog;
+		if (cmp_prog->type !=3D prog->type)
+			return ERR_PTR(-EINVAL);
+
+		found =3D false;
+		hlist_for_each_entry(pltmp, progs, node) {
+			pltmp_prog =3D pltmp->link ? pltmp->link->link.prog : pltmp->prog;
+			if (pltmp_prog =3D=3D cmp_prog) {
+				if (!!(pltmp->flags & BPF_F_PREORDER) !=3D preorder)
+					return ERR_PTR(-EINVAL);
+				found =3D true;
+				*ppltmp =3D pltmp;
+				break;
+			}
+		}
+		if (!found)
+			return ERR_PTR(-ENOENT);
+	}
+
+	return cmp_prog;
+}
+
+static int insert_pl_to_hlist(struct bpf_prog_list *pl, struct hlist_hea=
d *progs,
+			      struct bpf_prog *prog, u32 flags, u32 id_or_fd)
+{
+	struct hlist_node *last, *last_node =3D NULL;
+	struct bpf_prog_list *pltmp =3D NULL;
+	struct bpf_prog *cmp_prog;
+
+	/* flags cannot have both BPF_F_BEFORE and BPF_F_AFTER */
+	if ((flags & BPF_F_BEFORE) && (flags & BPF_F_AFTER))
+		return -EINVAL;
+
+	cmp_prog =3D get_cmp_prog(progs, prog, flags, id_or_fd, &pltmp);
+	if (IS_ERR(cmp_prog))
+		return PTR_ERR(cmp_prog);
+
+	if (hlist_empty(progs)) {
+		hlist_add_head(&pl->node, progs);
+	} else {
+		hlist_for_each(last, progs) {
+			if (last->next)
+				continue;
+			last_node =3D last;
+			break;
+		}
+
+		if (!cmp_prog) {
+			if (flags & BPF_F_BEFORE)
+				hlist_add_head(&pl->node, progs);
+			else
+				hlist_add_behind(&pl->node, last_node);
+		} else {
+			if (flags & BPF_F_BEFORE)
+				hlist_add_before(&pl->node, &pltmp->node);
+			else if (flags & BPF_F_AFTER)
+				hlist_add_behind(&pl->node, &pltmp->node);
+			else
+				hlist_add_behind(&pl->node, last_node);
+		}
+	}
+
+	return 0;
+}
+
 /**
  * __cgroup_bpf_attach() - Attach the program or the link to a cgroup, a=
nd
  *                         propagate the change to descendants
@@ -633,6 +717,8 @@ static struct bpf_prog_list *find_attach_entry(struct=
 hlist_head *progs,
  * @replace_prog: Previously attached program to replace if BPF_F_REPLAC=
E is set
  * @type: Type of attach operation
  * @flags: Option flags
+ * @id_or_fd: Relative prog id or fd
+ * @revision: bpf_prog_list revision
  *
  * Exactly one of @prog or @link can be non-null.
  * Must be called with cgroup_mutex held.
@@ -640,7 +726,8 @@ static struct bpf_prog_list *find_attach_entry(struct=
 hlist_head *progs,
 static int __cgroup_bpf_attach(struct cgroup *cgrp,
 			       struct bpf_prog *prog, struct bpf_prog *replace_prog,
 			       struct bpf_cgroup_link *link,
-			       enum bpf_attach_type type, u32 flags)
+			       enum bpf_attach_type type, u32 flags, u32 id_or_fd,
+			       u64 revision)
 {
 	u32 saved_flags =3D (flags & (BPF_F_ALLOW_OVERRIDE | BPF_F_ALLOW_MULTI)=
);
 	struct bpf_prog *old_prog =3D NULL;
@@ -656,6 +743,9 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	    ((flags & BPF_F_REPLACE) && !(flags & BPF_F_ALLOW_MULTI)))
 		/* invalid combination */
 		return -EINVAL;
+	if ((flags & BPF_F_REPLACE) && (flags & (BPF_F_BEFORE | BPF_F_AFTER)))
+		/* only either replace or insertion with before/after */
+		return -EINVAL;
 	if (link && (prog || replace_prog))
 		/* only either link or prog/replace_prog can be specified */
 		return -EINVAL;
@@ -663,9 +753,12 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 		/* replace_prog implies BPF_F_REPLACE, and vice versa */
 		return -EINVAL;
=20
+
 	atype =3D bpf_cgroup_atype_find(type, new_prog->aux->attach_btf_id);
 	if (atype < 0)
 		return -EINVAL;
+	if (revision && revision !=3D atomic64_read(&cgrp->bpf.revisions[atype]=
))
+		return -ESTALE;
=20
 	progs =3D &cgrp->bpf.progs[atype];
=20
@@ -694,22 +787,18 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	if (pl) {
 		old_prog =3D pl->prog;
 	} else {
-		struct hlist_node *last =3D NULL;
-
 		pl =3D kmalloc(sizeof(*pl), GFP_KERNEL);
 		if (!pl) {
 			bpf_cgroup_storages_free(new_storage);
 			return -ENOMEM;
 		}
-		if (hlist_empty(progs))
-			hlist_add_head(&pl->node, progs);
-		else
-			hlist_for_each(last, progs) {
-				if (last->next)
-					continue;
-				hlist_add_behind(&pl->node, last);
-				break;
-			}
+
+		err =3D insert_pl_to_hlist(pl, progs, prog ? : link->link.prog, flags,=
 id_or_fd);
+		if (err) {
+			kfree(pl);
+			bpf_cgroup_storages_free(new_storage);
+			return err;
+		}
 	}
=20
 	pl->prog =3D prog;
@@ -728,6 +817,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	if (err)
 		goto cleanup_trampoline;
=20
+	atomic64_inc(&cgrp->bpf.revisions[atype]);
 	if (old_prog) {
 		if (type =3D=3D BPF_LSM_CGROUP)
 			bpf_trampoline_unlink_cgroup_shim(old_prog);
@@ -759,12 +849,13 @@ static int cgroup_bpf_attach(struct cgroup *cgrp,
 			     struct bpf_prog *prog, struct bpf_prog *replace_prog,
 			     struct bpf_cgroup_link *link,
 			     enum bpf_attach_type type,
-			     u32 flags)
+			     u32 flags, u32 id_or_fd, u64 revision)
 {
 	int ret;
=20
 	cgroup_lock();
-	ret =3D __cgroup_bpf_attach(cgrp, prog, replace_prog, link, type, flags=
);
+	ret =3D __cgroup_bpf_attach(cgrp, prog, replace_prog, link, type, flags=
,
+				  id_or_fd, revision);
 	cgroup_unlock();
 	return ret;
 }
@@ -852,6 +943,7 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
 	if (!found)
 		return -ENOENT;
=20
+	atomic64_inc(&cgrp->bpf.revisions[atype]);
 	old_prog =3D xchg(&link->link.prog, new_prog);
 	replace_effective_prog(cgrp, atype, link);
 	bpf_prog_put(old_prog);
@@ -977,12 +1069,14 @@ static void purge_effective_progs(struct cgroup *c=
grp, struct bpf_prog *prog,
  * @prog: A program to detach or NULL
  * @link: A link to detach or NULL
  * @type: Type of detach operation
+ * @revision: bpf_prog_list revision
  *
  * At most one of @prog or @link can be non-NULL.
  * Must be called with cgroup_mutex held.
  */
 static int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *pro=
g,
-			       struct bpf_cgroup_link *link, enum bpf_attach_type type)
+			       struct bpf_cgroup_link *link, enum bpf_attach_type type,
+			       u64 revision)
 {
 	enum cgroup_bpf_attach_type atype;
 	struct bpf_prog *old_prog;
@@ -1000,6 +1094,9 @@ static int __cgroup_bpf_detach(struct cgroup *cgrp,=
 struct bpf_prog *prog,
 	if (atype < 0)
 		return -EINVAL;
=20
+	if (revision && revision !=3D atomic64_read(&cgrp->bpf.revisions[atype]=
))
+		return -ESTALE;
+
 	progs =3D &cgrp->bpf.progs[atype];
 	flags =3D cgrp->bpf.flags[atype];
=20
@@ -1025,6 +1122,7 @@ static int __cgroup_bpf_detach(struct cgroup *cgrp,=
 struct bpf_prog *prog,
=20
 	/* now can actually delete it from this cgroup list */
 	hlist_del(&pl->node);
+	atomic64_inc(&cgrp->bpf.revisions[atype]);
=20
 	kfree(pl);
 	if (hlist_empty(progs))
@@ -1040,12 +1138,12 @@ static int __cgroup_bpf_detach(struct cgroup *cgr=
p, struct bpf_prog *prog,
 }
=20
 static int cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
-			     enum bpf_attach_type type)
+			     enum bpf_attach_type type, u64 revision)
 {
 	int ret;
=20
 	cgroup_lock();
-	ret =3D __cgroup_bpf_detach(cgrp, prog, NULL, type);
+	ret =3D __cgroup_bpf_detach(cgrp, prog, NULL, type, revision);
 	cgroup_unlock();
 	return ret;
 }
@@ -1063,6 +1161,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, =
const union bpf_attr *attr,
 	struct bpf_prog_array *effective;
 	int cnt, ret =3D 0, i;
 	int total_cnt =3D 0;
+	u64 revision =3D 0;
 	u32 flags;
=20
 	if (effective_query && prog_attach_flags)
@@ -1100,6 +1199,10 @@ static int __cgroup_bpf_query(struct cgroup *cgrp,=
 const union bpf_attr *attr,
 		return -EFAULT;
 	if (copy_to_user(&uattr->query.prog_cnt, &total_cnt, sizeof(total_cnt))=
)
 		return -EFAULT;
+	if (!effective_query && from_atype =3D=3D to_atype)
+		revision =3D atomic64_read(&cgrp->bpf.revisions[from_atype]);
+	if (copy_to_user(&uattr->query.revision, &revision, sizeof(revision)))
+		return -EFAULT;
 	if (attr->query.prog_cnt =3D=3D 0 || !prog_ids || !total_cnt)
 		/* return early if user requested only program count + flags */
 		return 0;
@@ -1182,7 +1285,8 @@ int cgroup_bpf_prog_attach(const union bpf_attr *at=
tr,
 	}
=20
 	ret =3D cgroup_bpf_attach(cgrp, prog, replace_prog, NULL,
-				attr->attach_type, attr->attach_flags);
+				attr->attach_type, attr->attach_flags,
+				attr->relative_fd, attr->expected_revision);
=20
 	if (replace_prog)
 		bpf_prog_put(replace_prog);
@@ -1204,7 +1308,7 @@ int cgroup_bpf_prog_detach(const union bpf_attr *at=
tr, enum bpf_prog_type ptype)
 	if (IS_ERR(prog))
 		prog =3D NULL;
=20
-	ret =3D cgroup_bpf_detach(cgrp, prog, attr->attach_type);
+	ret =3D cgroup_bpf_detach(cgrp, prog, attr->attach_type, attr->expected=
_revision);
 	if (prog)
 		bpf_prog_put(prog);
=20
@@ -1233,7 +1337,7 @@ static void bpf_cgroup_link_release(struct bpf_link=
 *link)
 	}
=20
 	WARN_ON(__cgroup_bpf_detach(cg_link->cgroup, NULL, cg_link,
-				    cg_link->type));
+				    cg_link->type, 0));
 	if (cg_link->type =3D=3D BPF_LSM_CGROUP)
 		bpf_trampoline_unlink_cgroup_shim(cg_link->link.prog);
=20
@@ -1312,7 +1416,8 @@ int cgroup_bpf_link_attach(const union bpf_attr *at=
tr, struct bpf_prog *prog)
 	struct cgroup *cgrp;
 	int err;
=20
-	if (attr->link_create.flags)
+	if (attr->link_create.flags &&
+	    (attr->link_create.flags & (~(BPF_F_ID | BPF_F_BEFORE | BPF_F_AFTER=
 | BPF_F_PREORDER))))
 		return -EINVAL;
=20
 	cgrp =3D cgroup_get_from_fd(attr->link_create.target_fd);
@@ -1336,7 +1441,9 @@ int cgroup_bpf_link_attach(const union bpf_attr *at=
tr, struct bpf_prog *prog)
 	}
=20
 	err =3D cgroup_bpf_attach(cgrp, NULL, NULL, link,
-				link->type, BPF_F_ALLOW_MULTI);
+				link->type, BPF_F_ALLOW_MULTI | attr->link_create.flags,
+				attr->link_create.cgroup.relative_fd,
+				attr->link_create.cgroup.expected_revision);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
 		goto out_put_cgroup;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9794446bc8c6..48cf855f949f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4183,6 +4183,23 @@ static int bpf_prog_attach_check_attach_type(const=
 struct bpf_prog *prog,
 	}
 }
=20
+static bool bpf_cgroup_prog_attached(enum bpf_prog_type ptype)
+{
+	switch (ptype) {
+	case BPF_PROG_TYPE_CGROUP_DEVICE:
+	case BPF_PROG_TYPE_CGROUP_SKB:
+	case BPF_PROG_TYPE_CGROUP_SOCK:
+	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
+	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_SOCK_OPS:
+	case BPF_PROG_TYPE_LSM:
+		return true;
+	default:
+		return false;
+	}
+}
+
 #define BPF_PROG_ATTACH_LAST_FIELD expected_revision
=20
 #define BPF_F_ATTACH_MASK_BASE	\
@@ -4214,11 +4231,15 @@ static int bpf_prog_attach(const union bpf_attr *=
attr)
 		if (attr->attach_flags & ~BPF_F_ATTACH_MASK_MPROG)
 			return -EINVAL;
 	} else {
-		if (attr->attach_flags & ~BPF_F_ATTACH_MASK_BASE)
-			return -EINVAL;
-		if (attr->relative_fd ||
-		    attr->expected_revision)
-			return -EINVAL;
+		if (bpf_cgroup_prog_attached(ptype)) {
+			if (attr->attach_flags & BPF_F_LINK)
+				return -EINVAL;
+		} else {
+			if (attr->attach_flags & ~BPF_F_ATTACH_MASK_BASE)
+				return -EINVAL;
+			if (attr->relative_fd || attr->expected_revision)
+				return -EINVAL;
+		}
 	}
=20
 	prog =3D bpf_prog_get_type(attr->attach_bpf_fd, ptype);
@@ -4241,20 +4262,6 @@ static int bpf_prog_attach(const union bpf_attr *a=
ttr)
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 		ret =3D netns_bpf_prog_attach(attr, prog);
 		break;
-	case BPF_PROG_TYPE_CGROUP_DEVICE:
-	case BPF_PROG_TYPE_CGROUP_SKB:
-	case BPF_PROG_TYPE_CGROUP_SOCK:
-	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
-	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
-	case BPF_PROG_TYPE_CGROUP_SYSCTL:
-	case BPF_PROG_TYPE_SOCK_OPS:
-	case BPF_PROG_TYPE_LSM:
-		if (ptype =3D=3D BPF_PROG_TYPE_LSM &&
-		    prog->expected_attach_type !=3D BPF_LSM_CGROUP)
-			ret =3D -EINVAL;
-		else
-			ret =3D cgroup_bpf_prog_attach(attr, ptype, prog);
-		break;
 	case BPF_PROG_TYPE_SCHED_CLS:
 		if (attr->attach_type =3D=3D BPF_TCX_INGRESS ||
 		    attr->attach_type =3D=3D BPF_TCX_EGRESS)
@@ -4263,7 +4270,15 @@ static int bpf_prog_attach(const union bpf_attr *a=
ttr)
 			ret =3D netkit_prog_attach(attr, prog);
 		break;
 	default:
-		ret =3D -EINVAL;
+		if (!bpf_cgroup_prog_attached(ptype)) {
+			ret =3D -EINVAL;
+		} else {
+			if (ptype =3D=3D BPF_PROG_TYPE_LSM &&
+			    prog->expected_attach_type !=3D BPF_LSM_CGROUP)
+				ret =3D -EINVAL;
+			else
+				ret =3D cgroup_bpf_prog_attach(attr, ptype, prog);
+		}
 	}
=20
 	if (ret)
@@ -4293,6 +4308,9 @@ static int bpf_prog_detach(const union bpf_attr *at=
tr)
 			if (IS_ERR(prog))
 				return PTR_ERR(prog);
 		}
+	} else if (bpf_cgroup_prog_attached(ptype)) {
+		if (attr->attach_flags || attr->relative_fd)
+			return -EINVAL;
 	} else if (attr->attach_flags ||
 		   attr->relative_fd ||
 		   attr->expected_revision) {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 71d5ac83cf5d..a5c7992e8f7c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1794,6 +1794,13 @@ union bpf_attr {
 				};
 				__u64		expected_revision;
 			} netkit;
+			struct {
+				union {
+					__u32	relative_fd;
+					__u32	relative_id;
+				};
+				__u64		expected_revision;
+			} cgroup;
 		};
 	} link_create;
=20
--=20
2.47.1


