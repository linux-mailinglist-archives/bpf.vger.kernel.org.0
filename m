Return-Path: <bpf+bounces-50701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F5EA2B635
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 00:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5114167057
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 23:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7127A2417F9;
	Thu,  6 Feb 2025 23:00:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD052417F7
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882815; cv=none; b=uBgJOjXwPArpdqzAd6oqCt07AdUBMAyfSlixiRJC58AQQH2tQ+WDLZ8joaW4pAeu5WzwQSbTimFELIk8qvxXCOJQ8R9Pns4/1iHjty4zAICl18YENKbHNttm6CdCG6MVQgvnEo9Hw5/ex8CJwr/nDOC4ILXGw2c4t65hu51tn7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882815; c=relaxed/simple;
	bh=PbfKB5lJWpu3nbw+pOXkEwiRz74AoHPXoJKj6bMdndU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdQoHbjpc01VV+csS+3Bgx7u37+ruKvxoFoA2U2Hw7YUKZqowyBooMEDEVZIXJO0nETkq2mH60o8ovaSmibt1TNHuW78uzQyPnEPEvrC4P+U7RRJDtAc4yxjiwJDcS+oo0AYE1pJbPr6x4KUCow1CKzhFeb+DtyXNn+/xtbUi7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id C73D8DD724B6; Thu,  6 Feb 2025 14:59:56 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 1/2] bpf: Allow top down cgroup prog ordering
Date: Thu,  6 Feb 2025 14:59:56 -0800
Message-ID: <20250206225956.3740809-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently for bpf progs in a cgroup hierarchy, the effective prog array
is computed from bottom cgroup to upper cgroups. For example, the followi=
ng
cgroup hierarchy
    root cgroup: p1, p2
        subcgroup: p3, p4
have BPF_F_ALLOW_MULTI for both cgroup levels.
The effective cgroup array ordering looks like
    p3 p4 p1 p2
and at run time, the progs will execute based on that order.

But in some cases, it is desirable to have root prog executes earlier tha=
n
children progs. For example,
  - prog p1 intends to collect original pkt dest addresses.
  - prog p3 will modify original pkt dest addresses to a proxy address fo=
r
    security reason.
The end result is that prog p1 gets proxy address which is not what it
wants. Also, putting p1 to every child cgroup is not desirable either as =
it
will duplicate itself in many child cgroups. And this is exactly a use ca=
se
we are encountering in Meta.

To fix this issue, let us introduce a flag BPF_F_PRIO_TOPDOWN. If the fla=
g
is specified at attachment time, the prog has higher priority and the
ordering with that flag will be from top to bottom. For example, in the
above example,
    root cgroup: p1, p2
        subcgroup: p3, p4
Let us say p1, p2 and p4 are marked with BPF_F_PRIO_TOPDOWN. The final
effective array ordering will be
    p1 p2 p4 p3

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf-cgroup.h     |  1 +
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/cgroup.c            | 37 +++++++++++++++++++++++++++++++---
 kernel/bpf/syscall.c           |  3 ++-
 tools/include/uapi/linux/bpf.h |  1 +
 5 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 7fc69083e745..3d4f221df9ef 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -111,6 +111,7 @@ struct bpf_prog_list {
 	struct bpf_prog *prog;
 	struct bpf_cgroup_link *link;
 	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE];
+	bool is_prio_topdown;
 };
=20
 int cgroup_bpf_inherit(struct cgroup *cgrp);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fff6cdb8d11a..7ae8e8751e78 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1207,6 +1207,7 @@ enum bpf_perf_event_type {
 #define BPF_F_BEFORE		(1U << 3)
 #define BPF_F_AFTER		(1U << 4)
 #define BPF_F_ID		(1U << 5)
+#define BPF_F_PRIO_TOPDOWN	(1U << 6)
 #define BPF_F_LINK		BPF_F_LINK /* 1 << 13 */
=20
 /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 46e5db65dbc8..f31250c6025b 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -382,6 +382,21 @@ static u32 prog_list_length(struct hlist_head *head)
 	return cnt;
 }
=20
+static u32 prog_list_length_with_topdown_cnt(struct hlist_head *head, in=
t *topdown_cnt)
+{
+	struct bpf_prog_list *pl;
+	u32 cnt =3D 0;
+
+	hlist_for_each_entry(pl, head, node) {
+		if (!prog_list_prog(pl))
+			continue;
+		cnt++;
+		if (pl->is_prio_topdown)
+			(*topdown_cnt) +=3D 1;
+	}
+	return cnt;
+}
+
 /* if parent has non-overridable prog attached,
  * disallow attaching new programs to the descendent cgroup.
  * if parent has overridable or multi-prog, allow attaching
@@ -423,12 +438,13 @@ static int compute_effective_progs(struct cgroup *c=
grp,
 	struct bpf_prog_array *progs;
 	struct bpf_prog_list *pl;
 	struct cgroup *p =3D cgrp;
-	int cnt =3D 0;
+	int i, cnt =3D 0, topdown_cnt =3D 0, fstart, bstart, init_bstart;
=20
 	/* count number of effective programs by walking parents */
 	do {
 		if (cnt =3D=3D 0 || (p->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
-			cnt +=3D prog_list_length(&p->bpf.progs[atype]);
+			cnt +=3D prog_list_length_with_topdown_cnt(&p->bpf.progs[atype],
+								 &topdown_cnt);
 		p =3D cgroup_parent(p);
 	} while (p);
=20
@@ -439,20 +455,34 @@ static int compute_effective_progs(struct cgroup *c=
grp,
 	/* populate the array with effective progs */
 	cnt =3D 0;
 	p =3D cgrp;
+	fstart =3D topdown_cnt;
+	bstart =3D topdown_cnt - 1;
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
+			if (!pl->is_prio_topdown) {
+				item =3D &progs->items[fstart];
+				fstart++;
+			} else {
+				item =3D &progs->items[bstart];
+				bstart--;
+			}
 			item->prog =3D prog_list_prog(pl);
 			bpf_cgroup_storages_assign(item->cgroup_storage,
 						   pl->storage);
 			cnt++;
 		}
+
+		/* reverse topdown priority progs ordering at this cgroup level */
+		for (i =3D 0; i < (init_bstart - bstart)/2; i++)
+			swap(progs->items[init_bstart - i], progs->items[bstart + 1 + i]);
+
 	} while ((p =3D cgroup_parent(p)));
=20
 	*array =3D progs;
@@ -698,6 +728,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
=20
 	pl->prog =3D prog;
 	pl->link =3D link;
+	pl->is_prio_topdown =3D !!(flags & BPF_F_PRIO_TOPDOWN);
 	bpf_cgroup_storages_assign(pl->storage, storage);
 	cgrp->bpf.flags[atype] =3D saved_flags;
=20
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c420edbfb7c8..2711f6769263 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4168,7 +4168,8 @@ static int bpf_prog_attach_check_attach_type(const =
struct bpf_prog *prog,
 #define BPF_F_ATTACH_MASK_BASE	\
 	(BPF_F_ALLOW_OVERRIDE |	\
 	 BPF_F_ALLOW_MULTI |	\
-	 BPF_F_REPLACE)
+	 BPF_F_REPLACE |	\
+	 BPF_F_PRIO_TOPDOWN)
=20
 #define BPF_F_ATTACH_MASK_MPROG	\
 	(BPF_F_REPLACE |	\
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 2acf9b336371..de962fbb7c4c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1207,6 +1207,7 @@ enum bpf_perf_event_type {
 #define BPF_F_BEFORE		(1U << 3)
 #define BPF_F_AFTER		(1U << 4)
 #define BPF_F_ID		(1U << 5)
+#define BPF_F_PRIO_TOPDOWN	(1U << 6)
 #define BPF_F_LINK		BPF_F_LINK /* 1 << 13 */
=20
 /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
--=20
2.43.5


