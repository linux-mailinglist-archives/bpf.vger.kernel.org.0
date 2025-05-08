Return-Path: <bpf+bounces-57811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4714BAB0601
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 00:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A489E57CC
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 22:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AE022A811;
	Thu,  8 May 2025 22:35:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD9D24B28
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746743749; cv=none; b=bPuI2LgefsOHW/CYk1I9cm+UYt5+vReQS+iOBxQHB6HSfbSojr2Y70c9U7rSztwlDz+Do3lS3SpWDBrirujBNCsLH+0hAhFQJh/6a1LLnvA0Wb/ppCjj+0tNpMZ6aZRojB0xq369Nm26ioG5sUbONI0fQrQ22FN7oxQ9e2jTjjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746743749; c=relaxed/simple;
	bh=y6ujvSF4Uuh69DK1entmgFhu59bFYp9KQSApNqnedSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYMBSscY3Vj1nHB3SqSd7g8PIiVKYZFPiooiqKx2cMWCX7SwWkmsvxtibP0KY6aHFw+d0FPa7OTutZcS/pLEwQFdOguv8L8z02I9irVqUa77ZGrUi+UWCbdzNCXfM4Y2QWLTTmbU0xWSHZQBlEyiR0G92Q8SLbZBr6zQsUpBXyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5D5067223366; Thu,  8 May 2025 15:35:34 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 2/4] bpf: Implement mprog API on top of existing cgroup progs
Date: Thu,  8 May 2025 15:35:34 -0700
Message-ID: <20250508223534.488607-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508223524.487875-1-yonghong.song@linux.dev>
References: <20250508223524.487875-1-yonghong.song@linux.dev>
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
 kernel/bpf/cgroup.c            | 144 ++++++++++++++++++++++++++++-----
 kernel/bpf/syscall.c           |  44 ++++++----
 tools/include/uapi/linux/bpf.h |   7 ++
 4 files changed, 165 insertions(+), 37 deletions(-)

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
index 84f58f3d028a..7c258c4d9a74 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -624,6 +624,83 @@ static struct bpf_prog_list *find_attach_entry(struc=
t hlist_head *progs,
 	return NULL;
 }
=20
+static struct bpf_prog *get_anchor_prog(struct hlist_head *progs, struct=
 bpf_prog *prog,
+					u32 flags, u32 id_or_fd, struct bpf_prog_list **ppltmp)
+{
+	struct bpf_prog *anchor_prog =3D NULL, *pltmp_prog;
+	bool preorder =3D flags & BPF_F_PREORDER;
+	struct bpf_prog_list *pltmp;
+	bool id =3D flags & BPF_F_ID;
+	int ret =3D -EINVAL;
+
+	if (id || id_or_fd) {
+		/* flags must have BPF_F_BEFORE or BPF_F_AFTER */
+		if (!(flags & (BPF_F_BEFORE | BPF_F_AFTER)))
+			return ERR_PTR(-EINVAL);
+
+		if (id)
+			anchor_prog =3D bpf_prog_by_id(id_or_fd);
+		else
+			anchor_prog =3D bpf_prog_get(id_or_fd);
+		if (IS_ERR(anchor_prog))
+			return anchor_prog;
+		if (anchor_prog->type !=3D prog->type)
+			goto out;
+	}
+
+	if (!anchor_prog) {
+		hlist_for_each_entry(pltmp, progs, node) {
+			if ((flags & BPF_F_BEFORE) && *ppltmp)
+				break;
+			*ppltmp =3D pltmp;
+		}
+	}  else {
+		hlist_for_each_entry(pltmp, progs, node) {
+			pltmp_prog =3D pltmp->link ? pltmp->link->link.prog : pltmp->prog;
+			if (pltmp_prog !=3D anchor_prog)
+				continue;
+			if (!!(pltmp->flags & BPF_F_PREORDER) !=3D preorder)
+				goto out;
+			*ppltmp =3D pltmp;
+			break;
+		}
+		if (!*ppltmp) {
+			ret =3D -ENOENT;
+			goto out;
+		}
+	}
+
+	return anchor_prog;
+
+out:
+	bpf_prog_put(anchor_prog);
+	return ERR_PTR(ret);
+}
+
+static int insert_pl_to_hlist(struct bpf_prog_list *pl, struct hlist_hea=
d *progs,
+			      struct bpf_prog *prog, u32 flags, u32 id_or_fd)
+{
+	struct bpf_prog_list *pltmp =3D NULL;
+	struct bpf_prog *anchor_prog;
+
+	/* flags cannot have both BPF_F_BEFORE and BPF_F_AFTER */
+	if ((flags & BPF_F_BEFORE) && (flags & BPF_F_AFTER))
+		return -EINVAL;
+
+	anchor_prog =3D get_anchor_prog(progs, prog, flags, id_or_fd, &pltmp);
+	if (IS_ERR(anchor_prog))
+		return PTR_ERR(anchor_prog);
+
+	if (hlist_empty(progs))
+		hlist_add_head(&pl->node, progs);
+	else if (flags & BPF_F_BEFORE)
+		hlist_add_before(&pl->node, &pltmp->node);
+	else
+		hlist_add_behind(&pl->node, &pltmp->node);
+
+	return 0;
+}
+
 /**
  * __cgroup_bpf_attach() - Attach the program or the link to a cgroup, a=
nd
  *                         propagate the change to descendants
@@ -633,6 +710,8 @@ static struct bpf_prog_list *find_attach_entry(struct=
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
@@ -640,7 +719,8 @@ static struct bpf_prog_list *find_attach_entry(struct=
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
@@ -656,6 +736,9 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	    ((flags & BPF_F_REPLACE) && !(flags & BPF_F_ALLOW_MULTI)))
 		/* invalid combination */
 		return -EINVAL;
+	if ((flags & BPF_F_REPLACE) && (flags & (BPF_F_BEFORE | BPF_F_AFTER)))
+		/* only either replace or insertion with before/after */
+		return -EINVAL;
 	if (link && (prog || replace_prog))
 		/* only either link or prog/replace_prog can be specified */
 		return -EINVAL;
@@ -663,9 +746,12 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 		/* replace_prog implies BPF_F_REPLACE, and vice versa */
 		return -EINVAL;
=20
+
 	atype =3D bpf_cgroup_atype_find(type, new_prog->aux->attach_btf_id);
 	if (atype < 0)
 		return -EINVAL;
+	if (revision && revision !=3D cgrp->bpf.revisions[atype])
+		return -ESTALE;
=20
 	progs =3D &cgrp->bpf.progs[atype];
=20
@@ -694,22 +780,18 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
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
@@ -728,6 +810,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	if (err)
 		goto cleanup_trampoline;
=20
+	cgrp->bpf.revisions[atype] +=3D 1;
 	if (old_prog) {
 		if (type =3D=3D BPF_LSM_CGROUP)
 			bpf_trampoline_unlink_cgroup_shim(old_prog);
@@ -759,12 +842,13 @@ static int cgroup_bpf_attach(struct cgroup *cgrp,
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
@@ -852,6 +936,7 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
 	if (!found)
 		return -ENOENT;
=20
+	cgrp->bpf.revisions[atype] +=3D 1;
 	old_prog =3D xchg(&link->link.prog, new_prog);
 	replace_effective_prog(cgrp, atype, link);
 	bpf_prog_put(old_prog);
@@ -977,12 +1062,14 @@ static void purge_effective_progs(struct cgroup *c=
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
@@ -1000,6 +1087,9 @@ static int __cgroup_bpf_detach(struct cgroup *cgrp,=
 struct bpf_prog *prog,
 	if (atype < 0)
 		return -EINVAL;
=20
+	if (revision && revision !=3D cgrp->bpf.revisions[atype])
+		return -ESTALE;
+
 	progs =3D &cgrp->bpf.progs[atype];
 	flags =3D cgrp->bpf.flags[atype];
=20
@@ -1025,6 +1115,7 @@ static int __cgroup_bpf_detach(struct cgroup *cgrp,=
 struct bpf_prog *prog,
=20
 	/* now can actually delete it from this cgroup list */
 	hlist_del(&pl->node);
+	cgrp->bpf.revisions[atype] +=3D 1;
=20
 	kfree(pl);
 	if (hlist_empty(progs))
@@ -1040,12 +1131,12 @@ static int __cgroup_bpf_detach(struct cgroup *cgr=
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
@@ -1063,6 +1154,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, =
const union bpf_attr *attr,
 	struct bpf_prog_array *effective;
 	int cnt, ret =3D 0, i;
 	int total_cnt =3D 0;
+	u64 revision =3D 0;
 	u32 flags;
=20
 	if (effective_query && prog_attach_flags)
@@ -1100,6 +1192,10 @@ static int __cgroup_bpf_query(struct cgroup *cgrp,=
 const union bpf_attr *attr,
 		return -EFAULT;
 	if (copy_to_user(&uattr->query.prog_cnt, &total_cnt, sizeof(total_cnt))=
)
 		return -EFAULT;
+	if (!effective_query && from_atype =3D=3D to_atype)
+		revision =3D cgrp->bpf.revisions[from_atype];
+	if (copy_to_user(&uattr->query.revision, &revision, sizeof(revision)))
+		return -EFAULT;
 	if (attr->query.prog_cnt =3D=3D 0 || !prog_ids || !total_cnt)
 		/* return early if user requested only program count + flags */
 		return 0;
@@ -1182,7 +1278,8 @@ int cgroup_bpf_prog_attach(const union bpf_attr *at=
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
@@ -1204,7 +1301,7 @@ int cgroup_bpf_prog_detach(const union bpf_attr *at=
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
@@ -1233,7 +1330,7 @@ static void bpf_cgroup_link_release(struct bpf_link=
 *link)
 	}
=20
 	WARN_ON(__cgroup_bpf_detach(cg_link->cgroup, NULL, cg_link,
-				    cg_link->type));
+				    cg_link->type, 0));
 	if (cg_link->type =3D=3D BPF_LSM_CGROUP)
 		bpf_trampoline_unlink_cgroup_shim(cg_link->link.prog);
=20
@@ -1312,7 +1409,8 @@ int cgroup_bpf_link_attach(const union bpf_attr *at=
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
@@ -1336,7 +1434,9 @@ int cgroup_bpf_link_attach(const union bpf_attr *at=
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
index df33d19c5c3b..58ea3c38eabb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4184,6 +4184,25 @@ static int bpf_prog_attach_check_attach_type(const=
 struct bpf_prog *prog,
 	}
 }
=20
+static bool is_cgroup_prog_type(enum bpf_prog_type ptype, enum bpf_attac=
h_type atype,
+				bool check_atype)
+{
+	switch (ptype) {
+	case BPF_PROG_TYPE_CGROUP_DEVICE:
+	case BPF_PROG_TYPE_CGROUP_SKB:
+	case BPF_PROG_TYPE_CGROUP_SOCK:
+	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
+	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_SOCK_OPS:
+		return true;
+	case BPF_PROG_TYPE_LSM:
+		return check_atype ? atype =3D=3D BPF_LSM_CGROUP : true;
+	default:
+		return false;
+	}
+}
+
 #define BPF_PROG_ATTACH_LAST_FIELD expected_revision
=20
 #define BPF_F_ATTACH_MASK_BASE	\
@@ -4214,6 +4233,9 @@ static int bpf_prog_attach(const union bpf_attr *at=
tr)
 	if (bpf_mprog_supported(ptype)) {
 		if (attr->attach_flags & ~BPF_F_ATTACH_MASK_MPROG)
 			return -EINVAL;
+	} else if (is_cgroup_prog_type(ptype, 0, false)) {
+		if (attr->attach_flags & BPF_F_LINK)
+			return -EINVAL;
 	} else {
 		if (attr->attach_flags & ~BPF_F_ATTACH_MASK_BASE)
 			return -EINVAL;
@@ -4242,20 +4264,6 @@ static int bpf_prog_attach(const union bpf_attr *a=
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
@@ -4264,7 +4272,10 @@ static int bpf_prog_attach(const union bpf_attr *a=
ttr)
 			ret =3D netkit_prog_attach(attr, prog);
 		break;
 	default:
-		ret =3D -EINVAL;
+		if (!is_cgroup_prog_type(ptype, prog->expected_attach_type, true))
+			ret =3D -EINVAL;
+		else
+			ret =3D cgroup_bpf_prog_attach(attr, ptype, prog);
 	}
=20
 	if (ret)
@@ -4294,6 +4305,9 @@ static int bpf_prog_detach(const union bpf_attr *at=
tr)
 			if (IS_ERR(prog))
 				return PTR_ERR(prog);
 		}
+	} else if (is_cgroup_prog_type(ptype, 0, false)) {
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


