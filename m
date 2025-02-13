Return-Path: <bpf+bounces-51452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7250CA34ABC
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 17:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 692427A298C
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 16:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAE623A995;
	Thu, 13 Feb 2025 16:48:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B295928A2B0
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465308; cv=none; b=U7yDExvcgnpnHwbbCGDkwRvzRA6UQZQxwM2SDgYRtOM3PN6P7UJpiVJo9T+VNfvGwiGKBsxfDVJErIgQrXe6NmRVfpgXSdt8nFieJ3jPnJ+vx2/XIE2cJCOZ7wdbTv2NANpUd1Bz3F8PjZgb0F7tRSxn+6BdWPH3BuoxFu86LNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465308; c=relaxed/simple;
	bh=TT1u6+NOgkJuEq5HE20+sRp3KZMRvxRSjUOXl8jpe5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z0lqlcbidX+wVRioKsWAKr5ZTg6yMKUtJifugnSzC5mmFmcoXvgA0KLw5b8LeEWdPnBFPn+vUWl+p3abPO/YYfpwOeHr/BXRvgsUY4Lxo0X/HrevarhJ9DhRBcDyY6yagG8ILZY55uSuGx0807SJnxTJOSrQRi4B/YmaNNv83Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 0D1F7889FE1; Thu, 13 Feb 2025 08:48:12 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 1/2] bpf: Allow pre-ordering for bpf cgroup progs
Date: Thu, 13 Feb 2025 08:48:12 -0800
Message-ID: <20250213164812.2668578-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently for bpf progs in a cgroup hierarchy, the effective prog array
is computed from bottom cgroup to upper cgroups (post-ordering). For
example, the following cgroup hierarchy
    root cgroup: p1, p2
        subcgroup: p3, p4
have BPF_F_ALLOW_MULTI for both cgroup levels.
The effective cgroup array ordering looks like
    p3 p4 p1 p2
and at run time, progs will execute based on that order.

But in some cases, it is desirable to have root prog executes earlier tha=
n
children progs (pre-ordering). For example,
  - prog p1 intends to collect original pkt dest addresses.
  - prog p3 will modify original pkt dest addresses to a proxy address fo=
r
    security reason.
The end result is that prog p1 gets proxy address which is not what it
wants. Putting p1 to every child cgroup is not desirable either as it
will duplicate itself in many child cgroups. And this is exactly a use ca=
se
we are encountering in Meta.

To fix this issue, let us introduce a flag BPF_F_PREORDER. If the flag
is specified at attachment time, the prog has higher priority and the
ordering with that flag will be from top to bottom (pre-ordering).
For example, in the above example,
    root cgroup: p1, p2
        subcgroup: p3, p4
Let us say p2 and p4 are marked with BPF_F_PREORDER. The final
effective array ordering will be
    p2 p4 p3 p1

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf-cgroup.h     |  1 +
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/cgroup.c            | 33 +++++++++++++++++++++++++--------
 kernel/bpf/syscall.c           |  3 ++-
 tools/include/uapi/linux/bpf.h |  1 +
 5 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 7fc69083e745..9de7adb68294 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -111,6 +111,7 @@ struct bpf_prog_list {
 	struct bpf_prog *prog;
 	struct bpf_cgroup_link *link;
 	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE];
+	u32 flags;
 };
=20
 int cgroup_bpf_inherit(struct cgroup *cgrp);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fff6cdb8d11a..beac5cdf2d2c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1207,6 +1207,7 @@ enum bpf_perf_event_type {
 #define BPF_F_BEFORE		(1U << 3)
 #define BPF_F_AFTER		(1U << 4)
 #define BPF_F_ID		(1U << 5)
+#define BPF_F_PREORDER		(1U << 6)
 #define BPF_F_LINK		BPF_F_LINK /* 1 << 13 */
=20
 /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 46e5db65dbc8..31d33058174c 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -369,7 +369,7 @@ static struct bpf_prog *prog_list_prog(struct bpf_pro=
g_list *pl)
 /* count number of elements in the list.
  * it's slow but the list cannot be long
  */
-static u32 prog_list_length(struct hlist_head *head)
+static u32 prog_list_length(struct hlist_head *head, int *preorder_cnt)
 {
 	struct bpf_prog_list *pl;
 	u32 cnt =3D 0;
@@ -377,6 +377,8 @@ static u32 prog_list_length(struct hlist_head *head)
 	hlist_for_each_entry(pl, head, node) {
 		if (!prog_list_prog(pl))
 			continue;
+		if (preorder_cnt && (pl->flags & BPF_F_PREORDER))
+			(*preorder_cnt)++;
 		cnt++;
 	}
 	return cnt;
@@ -400,7 +402,7 @@ static bool hierarchy_allows_attach(struct cgroup *cg=
rp,
=20
 		if (flags & BPF_F_ALLOW_MULTI)
 			return true;
-		cnt =3D prog_list_length(&p->bpf.progs[atype]);
+		cnt =3D prog_list_length(&p->bpf.progs[atype], NULL);
 		WARN_ON_ONCE(cnt > 1);
 		if (cnt =3D=3D 1)
 			return !!(flags & BPF_F_ALLOW_OVERRIDE);
@@ -423,12 +425,12 @@ static int compute_effective_progs(struct cgroup *c=
grp,
 	struct bpf_prog_array *progs;
 	struct bpf_prog_list *pl;
 	struct cgroup *p =3D cgrp;
-	int cnt =3D 0;
+	int i, cnt =3D 0, preorder_cnt =3D 0, fstart, bstart, init_bstart;
=20
 	/* count number of effective programs by walking parents */
 	do {
 		if (cnt =3D=3D 0 || (p->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
-			cnt +=3D prog_list_length(&p->bpf.progs[atype]);
+			cnt +=3D prog_list_length(&p->bpf.progs[atype], &preorder_cnt);
 		p =3D cgroup_parent(p);
 	} while (p);
=20
@@ -439,20 +441,34 @@ static int compute_effective_progs(struct cgroup *c=
grp,
 	/* populate the array with effective progs */
 	cnt =3D 0;
 	p =3D cgrp;
+	fstart =3D preorder_cnt;
+	bstart =3D preorder_cnt - 1;
 	do {
 		if (cnt > 0 && !(p->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
 			continue;
=20
+		init_bstart =3D bstart;
 		hlist_for_each_entry(pl, &p->bpf.progs[atype], node) {
 			if (!prog_list_prog(pl))
 				continue;
=20
-			item =3D &progs->items[cnt];
+			if (pl->flags & BPF_F_PREORDER) {
+				item =3D &progs->items[bstart];
+				bstart--;
+			} else {
+				item =3D &progs->items[fstart];
+				fstart++;
+			}
 			item->prog =3D prog_list_prog(pl);
 			bpf_cgroup_storages_assign(item->cgroup_storage,
 						   pl->storage);
 			cnt++;
 		}
+
+		/* reverse pre-ordering progs at this cgroup level */
+		for (i =3D 0; i < (init_bstart - bstart)/2; i++)
+			swap(progs->items[init_bstart - i], progs->items[bstart + 1 + i]);
+
 	} while ((p =3D cgroup_parent(p)));
=20
 	*array =3D progs;
@@ -663,7 +679,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 		 */
 		return -EPERM;
=20
-	if (prog_list_length(progs) >=3D BPF_CGROUP_MAX_PROGS)
+	if (prog_list_length(progs, NULL) >=3D BPF_CGROUP_MAX_PROGS)
 		return -E2BIG;
=20
 	pl =3D find_attach_entry(progs, prog, link, replace_prog,
@@ -698,6 +714,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
=20
 	pl->prog =3D prog;
 	pl->link =3D link;
+	pl->flags =3D flags;
 	bpf_cgroup_storages_assign(pl->storage, storage);
 	cgrp->bpf.flags[atype] =3D saved_flags;
=20
@@ -1073,7 +1090,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, =
const union bpf_attr *attr,
 							      lockdep_is_held(&cgroup_mutex));
 			total_cnt +=3D bpf_prog_array_length(effective);
 		} else {
-			total_cnt +=3D prog_list_length(&cgrp->bpf.progs[atype]);
+			total_cnt +=3D prog_list_length(&cgrp->bpf.progs[atype], NULL);
 		}
 	}
=20
@@ -1105,7 +1122,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, =
const union bpf_attr *attr,
 			u32 id;
=20
 			progs =3D &cgrp->bpf.progs[atype];
-			cnt =3D min_t(int, prog_list_length(progs), total_cnt);
+			cnt =3D min_t(int, prog_list_length(progs, NULL), total_cnt);
 			i =3D 0;
 			hlist_for_each_entry(pl, progs, node) {
 				prog =3D prog_list_prog(pl);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c420edbfb7c8..18de4d301368 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4168,7 +4168,8 @@ static int bpf_prog_attach_check_attach_type(const =
struct bpf_prog *prog,
 #define BPF_F_ATTACH_MASK_BASE	\
 	(BPF_F_ALLOW_OVERRIDE |	\
 	 BPF_F_ALLOW_MULTI |	\
-	 BPF_F_REPLACE)
+	 BPF_F_REPLACE |	\
+	 BPF_F_PREORDER)
=20
 #define BPF_F_ATTACH_MASK_MPROG	\
 	(BPF_F_REPLACE |	\
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index fff6cdb8d11a..beac5cdf2d2c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1207,6 +1207,7 @@ enum bpf_perf_event_type {
 #define BPF_F_BEFORE		(1U << 3)
 #define BPF_F_AFTER		(1U << 4)
 #define BPF_F_ID		(1U << 5)
+#define BPF_F_PREORDER		(1U << 6)
 #define BPF_F_LINK		BPF_F_LINK /* 1 << 13 */
=20
 /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
--=20
2.43.5


