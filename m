Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2345079B0
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 21:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343673AbiDSTD5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 15:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357529AbiDSTDq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 15:03:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56AE3F886
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 12:01:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a16-20020a056902057000b00641c83f82f5so15503674ybt.22
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 12:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WVEa+j7QHRVsVS1QAWEm9A1nzOdmIjEKEaFwRDSL1CA=;
        b=r5ol9wcqcFB0u2FMVfPa1WRtm/wzx0y1I5pSUmmNy0F7Qg8k8ONd2WpqGYotuKaoEQ
         dmvIfThho0D5w+8zPo5oa1PigmIUNinNo1RdnEEijUHSkdkMR+nZAOJz+pmK5wrsfw9S
         6chwCRRwGbr+9hgOIvOBEYORanctQOkxQCZgSh59XBUvHbst6rE3otJuzyPrLMqskL3u
         NI5dEcjlihVCJzJsUShYnQOvQ5ryx+2kEF5Cf+goLRDXqnicsRslPF5mfecbI4mz0RVP
         e6zHFaeiTp196dQsixWtZnaCCYbv4eo4mzyc/AeRdWWfPyDTgPuk5yL4NzSUjlvhk3sC
         Lxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WVEa+j7QHRVsVS1QAWEm9A1nzOdmIjEKEaFwRDSL1CA=;
        b=VqblBmIvTcRk4DfkhczKAidGPrsY5SWe98pWAN1FsgxqliGwEZAw55X6ttui7MwQz4
         D+Df4m4zSalzuOPkiHTLqtiOU0VhZ7yghjro1+Ab1YPStebwCm9YBAknRzPsPjrFdfUh
         nI8RN2boUf4MWAhFyhoUQDh/dGtLq62RiTNcBTCgzD56Eh1J1DB6aYHSDCwbOLFmmpbD
         G/9yJGrizaGI6P+PNw8rqpBWTuG2/+6bOBWxIeWlKzu6q2YthzGbqKyuHWb6vF0AWx0K
         nbvTqv1iS1vFG4rM7Xwve4dPe2y5PGq+I2xEKW6+JFCP3qzTPkqkrILplXOyY+WBfGMZ
         +FSw==
X-Gm-Message-State: AOAM530uoVm+1618xVykIG74zRRv8d7R4NGlicBM4oOy/lrmL+eAeKBU
        Cmi9v4z+AyP2aLA4euFHdGPGBM0=
X-Google-Smtp-Source: ABdhPJwbI1plWnkXGKjrqzuiXops87Vbi644ErheFzeWR1sJkc8b475DM4+c3ZFA+hI2UiroHMplCCg=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:37f:6746:8e66:a291])
 (user=sdf job=sendgmr) by 2002:a25:d08a:0:b0:641:daac:ff82 with SMTP id
 h132-20020a25d08a000000b00641daacff82mr16155752ybg.643.1650394861940; Tue, 19
 Apr 2022 12:01:01 -0700 (PDT)
Date:   Tue, 19 Apr 2022 12:00:47 -0700
In-Reply-To: <20220419190053.3395240-1-sdf@google.com>
Message-Id: <20220419190053.3395240-3-sdf@google.com>
Mime-Version: 1.0
References: <20220419190053.3395240-1-sdf@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH bpf-next v5 2/8] bpf: convert cgroup_bpf.progs to hlist
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This lets us reclaim some space to be used by new cgroup lsm slots.

Before:
struct cgroup_bpf {
	struct bpf_prog_array *    effective[23];        /*     0   184 */
	/* --- cacheline 2 boundary (128 bytes) was 56 bytes ago --- */
	struct list_head           progs[23];            /*   184   368 */
	/* --- cacheline 8 boundary (512 bytes) was 40 bytes ago --- */
	u32                        flags[23];            /*   552    92 */

	/* XXX 4 bytes hole, try to pack */

	/* --- cacheline 10 boundary (640 bytes) was 8 bytes ago --- */
	struct list_head           storages;             /*   648    16 */
	struct bpf_prog_array *    inactive;             /*   664     8 */
	struct percpu_ref          refcnt;               /*   672    16 */
	struct work_struct         release_work;         /*   688    32 */

	/* size: 720, cachelines: 12, members: 7 */
	/* sum members: 716, holes: 1, sum holes: 4 */
	/* last cacheline: 16 bytes */
};

After:
struct cgroup_bpf {
	struct bpf_prog_array *    effective[23];        /*     0   184 */
	/* --- cacheline 2 boundary (128 bytes) was 56 bytes ago --- */
	struct hlist_head          progs[23];            /*   184   184 */
	/* --- cacheline 5 boundary (320 bytes) was 48 bytes ago --- */
	u8                         flags[23];            /*   368    23 */

	/* XXX 1 byte hole, try to pack */

	/* --- cacheline 6 boundary (384 bytes) was 8 bytes ago --- */
	struct list_head           storages;             /*   392    16 */
	struct bpf_prog_array *    inactive;             /*   408     8 */
	struct percpu_ref          refcnt;               /*   416    16 */
	struct work_struct         release_work;         /*   432    72 */

	/* size: 504, cachelines: 8, members: 7 */
	/* sum members: 503, holes: 1, sum holes: 1 */
	/* last cacheline: 56 bytes */
};

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf-cgroup-defs.h |  4 +-
 include/linux/bpf-cgroup.h      |  2 +-
 kernel/bpf/cgroup.c             | 72 +++++++++++++++++++--------------
 3 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
index 695d1224a71b..5d268e76d8e6 100644
--- a/include/linux/bpf-cgroup-defs.h
+++ b/include/linux/bpf-cgroup-defs.h
@@ -47,8 +47,8 @@ struct cgroup_bpf {
 	 * have either zero or one element
 	 * when BPF_F_ALLOW_MULTI the list can have up to BPF_CGROUP_MAX_PROGS
 	 */
-	struct list_head progs[MAX_CGROUP_BPF_ATTACH_TYPE];
-	u32 flags[MAX_CGROUP_BPF_ATTACH_TYPE];
+	struct hlist_head progs[MAX_CGROUP_BPF_ATTACH_TYPE];
+	u8 flags[MAX_CGROUP_BPF_ATTACH_TYPE];
 
 	/* list of cgroup shared storages */
 	struct list_head storages;
diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 88a51b242adc..69b611f7b2c7 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -95,7 +95,7 @@ struct bpf_cgroup_link {
 };
 
 struct bpf_prog_list {
-	struct list_head node;
+	struct hlist_node node;
 	struct bpf_prog *prog;
 	struct bpf_cgroup_link *link;
 	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE];
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 0cb6211fcb58..aaf9e36f2736 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -184,11 +184,12 @@ static void cgroup_bpf_release(struct work_struct *work)
 	mutex_lock(&cgroup_mutex);
 
 	for (atype = 0; atype < ARRAY_SIZE(cgrp->bpf.progs); atype++) {
-		struct list_head *progs = &cgrp->bpf.progs[atype];
-		struct bpf_prog_list *pl, *pltmp;
+		struct hlist_head *progs = &cgrp->bpf.progs[atype];
+		struct bpf_prog_list *pl;
+		struct hlist_node *pltmp;
 
-		list_for_each_entry_safe(pl, pltmp, progs, node) {
-			list_del(&pl->node);
+		hlist_for_each_entry_safe(pl, pltmp, progs, node) {
+			hlist_del(&pl->node);
 			if (pl->prog)
 				bpf_prog_put(pl->prog);
 			if (pl->link)
@@ -244,12 +245,12 @@ static struct bpf_prog *prog_list_prog(struct bpf_prog_list *pl)
 /* count number of elements in the list.
  * it's slow but the list cannot be long
  */
-static u32 prog_list_length(struct list_head *head)
+static u32 prog_list_length(struct hlist_head *head)
 {
 	struct bpf_prog_list *pl;
 	u32 cnt = 0;
 
-	list_for_each_entry(pl, head, node) {
+	hlist_for_each_entry(pl, head, node) {
 		if (!prog_list_prog(pl))
 			continue;
 		cnt++;
@@ -318,7 +319,7 @@ static int compute_effective_progs(struct cgroup *cgrp,
 		if (cnt > 0 && !(p->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
 			continue;
 
-		list_for_each_entry(pl, &p->bpf.progs[atype], node) {
+		hlist_for_each_entry(pl, &p->bpf.progs[atype], node) {
 			if (!prog_list_prog(pl))
 				continue;
 
@@ -369,7 +370,7 @@ int cgroup_bpf_inherit(struct cgroup *cgrp)
 		cgroup_bpf_get(p);
 
 	for (i = 0; i < NR; i++)
-		INIT_LIST_HEAD(&cgrp->bpf.progs[i]);
+		INIT_HLIST_HEAD(&cgrp->bpf.progs[i]);
 
 	INIT_LIST_HEAD(&cgrp->bpf.storages);
 
@@ -445,7 +446,7 @@ static int update_effective_progs(struct cgroup *cgrp,
 
 #define BPF_CGROUP_MAX_PROGS 64
 
-static struct bpf_prog_list *find_attach_entry(struct list_head *progs,
+static struct bpf_prog_list *find_attach_entry(struct hlist_head *progs,
 					       struct bpf_prog *prog,
 					       struct bpf_cgroup_link *link,
 					       struct bpf_prog *replace_prog,
@@ -455,12 +456,12 @@ static struct bpf_prog_list *find_attach_entry(struct list_head *progs,
 
 	/* single-attach case */
 	if (!allow_multi) {
-		if (list_empty(progs))
+		if (hlist_empty(progs))
 			return NULL;
-		return list_first_entry(progs, typeof(*pl), node);
+		return hlist_entry(progs->first, typeof(*pl), node);
 	}
 
-	list_for_each_entry(pl, progs, node) {
+	hlist_for_each_entry(pl, progs, node) {
 		if (prog && pl->prog == prog && prog != replace_prog)
 			/* disallow attaching the same prog twice */
 			return ERR_PTR(-EINVAL);
@@ -471,7 +472,7 @@ static struct bpf_prog_list *find_attach_entry(struct list_head *progs,
 
 	/* direct prog multi-attach w/ replacement case */
 	if (replace_prog) {
-		list_for_each_entry(pl, progs, node) {
+		hlist_for_each_entry(pl, progs, node) {
 			if (pl->prog == replace_prog)
 				/* a match found */
 				return pl;
@@ -507,7 +508,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
 	enum cgroup_bpf_attach_type atype;
 	struct bpf_prog_list *pl;
-	struct list_head *progs;
+	struct hlist_head *progs;
 	int err;
 
 	if (((flags & BPF_F_ALLOW_OVERRIDE) && (flags & BPF_F_ALLOW_MULTI)) ||
@@ -530,7 +531,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	if (!hierarchy_allows_attach(cgrp, atype))
 		return -EPERM;
 
-	if (!list_empty(progs) && cgrp->bpf.flags[atype] != saved_flags)
+	if (!hlist_empty(progs) && cgrp->bpf.flags[atype] != saved_flags)
 		/* Disallow attaching non-overridable on top
 		 * of existing overridable in this cgroup.
 		 * Disallow attaching multi-prog if overridable or none
@@ -552,12 +553,22 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	if (pl) {
 		old_prog = pl->prog;
 	} else {
+		struct hlist_node *last = NULL;
+
 		pl = kmalloc(sizeof(*pl), GFP_KERNEL);
 		if (!pl) {
 			bpf_cgroup_storages_free(new_storage);
 			return -ENOMEM;
 		}
-		list_add_tail(&pl->node, progs);
+		if (hlist_empty(progs))
+			hlist_add_head(&pl->node, progs);
+		else
+			hlist_for_each(last, progs) {
+				if (last->next)
+					continue;
+				hlist_add_behind(&pl->node, last);
+				break;
+			}
 	}
 
 	pl->prog = prog;
@@ -583,7 +594,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	}
 	bpf_cgroup_storages_free(new_storage);
 	if (!old_prog) {
-		list_del(&pl->node);
+		hlist_del(&pl->node);
 		kfree(pl);
 	}
 	return err;
@@ -614,7 +625,7 @@ static void replace_effective_prog(struct cgroup *cgrp,
 	struct cgroup_subsys_state *css;
 	struct bpf_prog_array *progs;
 	struct bpf_prog_list *pl;
-	struct list_head *head;
+	struct hlist_head *head;
 	struct cgroup *cg;
 	int pos;
 
@@ -630,7 +641,7 @@ static void replace_effective_prog(struct cgroup *cgrp,
 				continue;
 
 			head = &cg->bpf.progs[atype];
-			list_for_each_entry(pl, head, node) {
+			hlist_for_each_entry(pl, head, node) {
 				if (!prog_list_prog(pl))
 					continue;
 				if (pl->link == link)
@@ -664,7 +675,7 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
 	enum cgroup_bpf_attach_type atype;
 	struct bpf_prog *old_prog;
 	struct bpf_prog_list *pl;
-	struct list_head *progs;
+	struct hlist_head *progs;
 	bool found = false;
 
 	atype = to_cgroup_bpf_attach_type(link->type);
@@ -676,7 +687,7 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
 	if (link->link.prog->type != new_prog->type)
 		return -EINVAL;
 
-	list_for_each_entry(pl, progs, node) {
+	hlist_for_each_entry(pl, progs, node) {
 		if (pl->link == link) {
 			found = true;
 			break;
@@ -715,7 +726,7 @@ static int cgroup_bpf_replace(struct bpf_link *link, struct bpf_prog *new_prog,
 	return ret;
 }
 
-static struct bpf_prog_list *find_detach_entry(struct list_head *progs,
+static struct bpf_prog_list *find_detach_entry(struct hlist_head *progs,
 					       struct bpf_prog *prog,
 					       struct bpf_cgroup_link *link,
 					       bool allow_multi)
@@ -723,14 +734,14 @@ static struct bpf_prog_list *find_detach_entry(struct list_head *progs,
 	struct bpf_prog_list *pl;
 
 	if (!allow_multi) {
-		if (list_empty(progs))
+		if (hlist_empty(progs))
 			/* report error when trying to detach and nothing is attached */
 			return ERR_PTR(-ENOENT);
 
 		/* to maintain backward compatibility NONE and OVERRIDE cgroups
 		 * allow detaching with invalid FD (prog==NULL) in legacy mode
 		 */
-		return list_first_entry(progs, typeof(*pl), node);
+		return hlist_entry(progs->first, typeof(*pl), node);
 	}
 
 	if (!prog && !link)
@@ -740,7 +751,7 @@ static struct bpf_prog_list *find_detach_entry(struct list_head *progs,
 		return ERR_PTR(-EINVAL);
 
 	/* find the prog or link and detach it */
-	list_for_each_entry(pl, progs, node) {
+	hlist_for_each_entry(pl, progs, node) {
 		if (pl->prog == prog && pl->link == link)
 			return pl;
 	}
@@ -764,7 +775,7 @@ static int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 	enum cgroup_bpf_attach_type atype;
 	struct bpf_prog *old_prog;
 	struct bpf_prog_list *pl;
-	struct list_head *progs;
+	struct hlist_head *progs;
 	u32 flags;
 	int err;
 
@@ -793,9 +804,10 @@ static int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 		goto cleanup;
 
 	/* now can actually delete it from this cgroup list */
-	list_del(&pl->node);
+	hlist_del(&pl->node);
+
 	kfree(pl);
-	if (list_empty(progs))
+	if (hlist_empty(progs))
 		/* last program was detached, reset flags to zero */
 		cgrp->bpf.flags[atype] = 0;
 	if (old_prog)
@@ -829,7 +841,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 	enum bpf_attach_type type = attr->query.attach_type;
 	enum cgroup_bpf_attach_type atype;
 	struct bpf_prog_array *effective;
-	struct list_head *progs;
+	struct hlist_head *progs;
 	struct bpf_prog *prog;
 	int cnt, ret = 0, i;
 	u32 flags;
@@ -868,7 +880,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 		u32 id;
 
 		i = 0;
-		list_for_each_entry(pl, progs, node) {
+		hlist_for_each_entry(pl, progs, node) {
 			prog = prog_list_prog(pl);
 			id = prog->aux->id;
 			if (copy_to_user(prog_ids + i, &id, sizeof(id)))
-- 
2.36.0.rc0.470.gd361397f0d-goog

