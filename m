Return-Path: <bpf+bounces-57415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D756AAADCA
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 04:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CECA7AC998
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 02:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6FD35FAED;
	Mon,  5 May 2025 22:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgonBQZZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCAC359E1B;
	Mon,  5 May 2025 22:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484988; cv=none; b=cHdwFBqlef912idnmGjVytxxQIDilNPKUX4wzpe3T3bOTLv0HbgEFpibuGhXFwgmZ0NoYKCo8wa9iFzkjX3auZk5481Ud0iAqT5GXihlyJYGA/kHuMTqm0RTAaV+VZ6Jo0+7p7VhJ9TPSqK0ao9g4L4iyXOdiJcgfu0BCYno54U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484988; c=relaxed/simple;
	bh=dvlCy08zdaOJqomi5ZL/jvRfDyJk8aYgEPcgEyiNyhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hqafBxBIF3HFo8kN64Og3XPbws/FWeNnfws3xQwxEf0wolX4578/YPl7HpTWO2642hOq2YhB38uwDp2IuPKPHmoPPSMYNg4MD/oECzyu3f3gXd8Yklz9xF70FD3+jfrox/hu47xGRK7+hYK4cIUZx6tBDvzHa48jTqzjrUE1VOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgonBQZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F9FC4CEE4;
	Mon,  5 May 2025 22:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484987;
	bh=dvlCy08zdaOJqomi5ZL/jvRfDyJk8aYgEPcgEyiNyhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GgonBQZZMHEzR9r6/2MfWQhzYu4oSM/cDaHXKjYLMGXeIeNe/HBdBLdhfJnr3RiJ5
	 g/bcecd1bz6JphUs2duFF4qspMKhdPmxn1F4efScQbQXm7a1J/oVIn2AiajEfDLclV
	 3FsD8mLaoHBysGKFhtOKWOrOIh9hLWyOF39dHVubyXLwgW1vQN39hDPFI9GH6PdC/8
	 rBCfcAKL9LfLDkhxBWD6wznbQPLE4OOJ7mmPyW65rgGOV0i5tdW2CefUL87e7KRHPD
	 MxY3jZLT38iiGRWPDEpz3KxbBnH+rO4xMG6jwqdbqHg05oFbgkJLyj+/vVR9B//TSo
	 LepQjuUa8wcow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	willemb@google.com,
	kerneljasonxing@gmail.com,
	quic_abchauha@quicinc.com,
	aspsk@isovalent.com,
	linux@jordanrome.com,
	martin.kelly@crowdstrike.com,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 111/486] bpf: Allow pre-ordering for bpf cgroup progs
Date: Mon,  5 May 2025 18:33:07 -0400
Message-Id: <20250505223922.2682012-111-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit 4b82b181a26cff8bf7adc3a85a88d121d92edeaf ]

Currently for bpf progs in a cgroup hierarchy, the effective prog array
is computed from bottom cgroup to upper cgroups (post-ordering). For
example, the following cgroup hierarchy
    root cgroup: p1, p2
        subcgroup: p3, p4
have BPF_F_ALLOW_MULTI for both cgroup levels.
The effective cgroup array ordering looks like
    p3 p4 p1 p2
and at run time, progs will execute based on that order.

But in some cases, it is desirable to have root prog executes earlier than
children progs (pre-ordering). For example,
  - prog p1 intends to collect original pkt dest addresses.
  - prog p3 will modify original pkt dest addresses to a proxy address for
    security reason.
The end result is that prog p1 gets proxy address which is not what it
wants. Putting p1 to every child cgroup is not desirable either as it
will duplicate itself in many child cgroups. And this is exactly a use case
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20250224230116.283071-1-yonghong.song@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf-cgroup.h     |  1 +
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/cgroup.c            | 33 +++++++++++++++++++++++++--------
 kernel/bpf/syscall.c           |  3 ++-
 tools/include/uapi/linux/bpf.h |  1 +
 5 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index ce91d9b2acb9f..7e029c82ae45f 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -111,6 +111,7 @@ struct bpf_prog_list {
 	struct bpf_prog *prog;
 	struct bpf_cgroup_link *link;
 	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE];
+	u32 flags;
 };
 
 int cgroup_bpf_inherit(struct cgroup *cgrp);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4a939c90dc2e4..552fd633f8200 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1206,6 +1206,7 @@ enum bpf_perf_event_type {
 #define BPF_F_BEFORE		(1U << 3)
 #define BPF_F_AFTER		(1U << 4)
 #define BPF_F_ID		(1U << 5)
+#define BPF_F_PREORDER		(1U << 6)
 #define BPF_F_LINK		BPF_F_LINK /* 1 << 13 */
 
 /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 025d7e2214aeb..c0d606c40195d 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -369,7 +369,7 @@ static struct bpf_prog *prog_list_prog(struct bpf_prog_list *pl)
 /* count number of elements in the list.
  * it's slow but the list cannot be long
  */
-static u32 prog_list_length(struct hlist_head *head)
+static u32 prog_list_length(struct hlist_head *head, int *preorder_cnt)
 {
 	struct bpf_prog_list *pl;
 	u32 cnt = 0;
@@ -377,6 +377,8 @@ static u32 prog_list_length(struct hlist_head *head)
 	hlist_for_each_entry(pl, head, node) {
 		if (!prog_list_prog(pl))
 			continue;
+		if (preorder_cnt && (pl->flags & BPF_F_PREORDER))
+			(*preorder_cnt)++;
 		cnt++;
 	}
 	return cnt;
@@ -400,7 +402,7 @@ static bool hierarchy_allows_attach(struct cgroup *cgrp,
 
 		if (flags & BPF_F_ALLOW_MULTI)
 			return true;
-		cnt = prog_list_length(&p->bpf.progs[atype]);
+		cnt = prog_list_length(&p->bpf.progs[atype], NULL);
 		WARN_ON_ONCE(cnt > 1);
 		if (cnt == 1)
 			return !!(flags & BPF_F_ALLOW_OVERRIDE);
@@ -423,12 +425,12 @@ static int compute_effective_progs(struct cgroup *cgrp,
 	struct bpf_prog_array *progs;
 	struct bpf_prog_list *pl;
 	struct cgroup *p = cgrp;
-	int cnt = 0;
+	int i, j, cnt = 0, preorder_cnt = 0, fstart, bstart, init_bstart;
 
 	/* count number of effective programs by walking parents */
 	do {
 		if (cnt == 0 || (p->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
-			cnt += prog_list_length(&p->bpf.progs[atype]);
+			cnt += prog_list_length(&p->bpf.progs[atype], &preorder_cnt);
 		p = cgroup_parent(p);
 	} while (p);
 
@@ -439,20 +441,34 @@ static int compute_effective_progs(struct cgroup *cgrp,
 	/* populate the array with effective progs */
 	cnt = 0;
 	p = cgrp;
+	fstart = preorder_cnt;
+	bstart = preorder_cnt - 1;
 	do {
 		if (cnt > 0 && !(p->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
 			continue;
 
+		init_bstart = bstart;
 		hlist_for_each_entry(pl, &p->bpf.progs[atype], node) {
 			if (!prog_list_prog(pl))
 				continue;
 
-			item = &progs->items[cnt];
+			if (pl->flags & BPF_F_PREORDER) {
+				item = &progs->items[bstart];
+				bstart--;
+			} else {
+				item = &progs->items[fstart];
+				fstart++;
+			}
 			item->prog = prog_list_prog(pl);
 			bpf_cgroup_storages_assign(item->cgroup_storage,
 						   pl->storage);
 			cnt++;
 		}
+
+		/* reverse pre-ordering progs at this cgroup level */
+		for (i = bstart + 1, j = init_bstart; i < j; i++, j--)
+			swap(progs->items[i], progs->items[j]);
+
 	} while ((p = cgroup_parent(p)));
 
 	*array = progs;
@@ -663,7 +679,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 		 */
 		return -EPERM;
 
-	if (prog_list_length(progs) >= BPF_CGROUP_MAX_PROGS)
+	if (prog_list_length(progs, NULL) >= BPF_CGROUP_MAX_PROGS)
 		return -E2BIG;
 
 	pl = find_attach_entry(progs, prog, link, replace_prog,
@@ -698,6 +714,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 
 	pl->prog = prog;
 	pl->link = link;
+	pl->flags = flags;
 	bpf_cgroup_storages_assign(pl->storage, storage);
 	cgrp->bpf.flags[atype] = saved_flags;
 
@@ -1073,7 +1090,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 							      lockdep_is_held(&cgroup_mutex));
 			total_cnt += bpf_prog_array_length(effective);
 		} else {
-			total_cnt += prog_list_length(&cgrp->bpf.progs[atype]);
+			total_cnt += prog_list_length(&cgrp->bpf.progs[atype], NULL);
 		}
 	}
 
@@ -1105,7 +1122,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 			u32 id;
 
 			progs = &cgrp->bpf.progs[atype];
-			cnt = min_t(int, prog_list_length(progs), total_cnt);
+			cnt = min_t(int, prog_list_length(progs, NULL), total_cnt);
 			i = 0;
 			hlist_for_each_entry(pl, progs, node) {
 				prog = prog_list_prog(pl);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index fc048d3c0e69f..ab74a226e3d6d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4042,7 +4042,8 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 #define BPF_F_ATTACH_MASK_BASE	\
 	(BPF_F_ALLOW_OVERRIDE |	\
 	 BPF_F_ALLOW_MULTI |	\
-	 BPF_F_REPLACE)
+	 BPF_F_REPLACE |	\
+	 BPF_F_PREORDER)
 
 #define BPF_F_ATTACH_MASK_MPROG	\
 	(BPF_F_REPLACE |	\
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4a939c90dc2e4..552fd633f8200 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1206,6 +1206,7 @@ enum bpf_perf_event_type {
 #define BPF_F_BEFORE		(1U << 3)
 #define BPF_F_AFTER		(1U << 4)
 #define BPF_F_ID		(1U << 5)
+#define BPF_F_PREORDER		(1U << 6)
 #define BPF_F_LINK		BPF_F_LINK /* 1 << 13 */
 
 /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
-- 
2.39.5


