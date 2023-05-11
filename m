Return-Path: <bpf+bounces-364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC016FF84E
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 19:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F052818AF
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 17:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5C68F7D;
	Thu, 11 May 2023 17:21:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75498F50
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 17:21:06 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DB8269E
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 10:21:04 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-64380c45e84so9244765b3a.0
        for <bpf@vger.kernel.org>; Thu, 11 May 2023 10:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683825664; x=1686417664;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DLqlLlnWSNdvO3kIs7DeE2e9cmnYTCcpsBhEJpe9IGk=;
        b=5ZG4dmJBQNuB90Yy6ERkzETITzs2c/1oN17oEBNVPYECy67Wwayv15vYX6v6Ltb8c1
         rMKXusum2Wnhgd8whyQUywH2STstYKKdDoI5iJx+tMc34JFeESIGXUqFqMB5lFfaqmMN
         iN69DOegdHzeA2z7cJS72PJg62AgNssAVCTrbkS0+WhYpJQ05Oz2ZcQwJaHayKEDNrLK
         QpvdDJE6P0RsFjalsZ3govEjrUYBDyElngnyJTdfG6WBH//QGgNGd+r32cok8U36D3Su
         mUtpCv8slyxTwaXdQZKpSqBBmi7GSy6fAEyRqpZ/b5+tVHMfJIDVPM97ZVGhRrw/FOb6
         iWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683825664; x=1686417664;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLqlLlnWSNdvO3kIs7DeE2e9cmnYTCcpsBhEJpe9IGk=;
        b=lEuftoBIa0LrInIO7QkAah47bzymry6XkHwmf5dLylBOwzGQnX06pXB1VxiygigAAD
         PwkxgDRUaWzpep5e2mNQ5TiSRPmr/AWU01dHMq+11g1QJx7ecvprximLWNU0maUPkAJx
         jk1cFIHdZeTl9L1K/1AM9ipC4wYfteU3Sl448WsE+Z4j7W/iDRll4ahRy6hmZwZSeCf7
         ArQ3isFXSFs407Uw4upgfHutfu9tZUe/3HPYVMg1hT6vXL3gygd54MLGACCGUcw7owRR
         cH5j+OsLM5TA2OYSFpl1EnWLst+wJV8NRXJe7XzSS2qTZZ4y+TzTFQCdNZHe6K07knAr
         lnpg==
X-Gm-Message-State: AC+VfDy+xyfdr10GIwapYG/5bgoL2MsjkWqoPks1AMOz4aD8gJTgyFeH
	q9B3XMllE2TqUTRsxVdhIqUbmjTcKvbImXtlhXE0jdJmoxCEXYV+cqOQyxqTixsHRNJR1Ww55Xv
	Q8uoZtsbwfEo1VL8g6rtMwx4B6Kq0T0p+B15FeoZv8w49fqrpjg==
X-Google-Smtp-Source: ACHHUZ6APIZAxu4AYWcusO85v1fYjEDOIfv3OmRykkxkzPi7nvnLO61RmSpDVAJChvBZ23NO4ZNJJKE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:d68:b0:643:6fa8:e7f4 with SMTP id
 n40-20020a056a000d6800b006436fa8e7f4mr6070343pfv.0.1683825664007; Thu, 11 May
 2023 10:21:04 -0700 (PDT)
Date: Thu, 11 May 2023 10:20:54 -0700
In-Reply-To: <20230511172054.1892665-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230511172054.1892665-1-sdf@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230511172054.1892665-5-sdf@google.com>
Subject: [PATCH bpf-next 4/4] bpf: query effective progs without cgroup_mutex
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When querying bpf prog list, we don't really need to hold
cgroup_mutex. There is only one caller of cgroup_bpf_query
(cgroup_bpf_prog_query) and it does cgroup_get/put, so we're
safe WRT cgroup going way. However, we if we stop grabbing
cgroup_mutex, we risk racing with the prog attach/detach path
to the same cgroup, so here is how to work it around.

We have two case:
1. querying effective array
2. querying non-effective list

(1) is easy because it's already a RCU-managed array, so all we
need is to make a copy of that array (under rcu read lock)
into a temporary buffer and copy that temporary buffer back
to userspace.

(2) is more involved because we keep the list of progs and it's
not managed by RCU. However, it seems relatively simple to
convert that hlist to the RCU-managed one: convert the readers
to use hlist_xxx_rcu and replace kfree with kfree_rcu. One
other notable place is cgroup_bpf_release where we replace
hlist_for_each_entry_safe with hlist_for_each_entry_rcu. This
should be safe because hlist_del_rcu does not remove/poison
forward pointer of the list entry, so it's safe to remove
the elements while iterating (without specially flavored
for_each_safe wrapper).

For (2), we also need to take care of flags. I added a bunch
of READ_ONCE/WRITE_ONCE to annotate lockless access. And I
also moved flag update path to happen before adding prog
to the list to make sure readers observe correct flags.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf-cgroup-defs.h |   2 +-
 include/linux/bpf-cgroup.h      |   1 +
 kernel/bpf/cgroup.c             | 152 ++++++++++++++++++--------------
 3 files changed, 90 insertions(+), 65 deletions(-)

diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
index 7b121bd780eb..df0b8faa1a17 100644
--- a/include/linux/bpf-cgroup-defs.h
+++ b/include/linux/bpf-cgroup-defs.h
@@ -56,7 +56,7 @@ struct cgroup_bpf {
 	 * have either zero or one element
 	 * when BPF_F_ALLOW_MULTI the list can have up to BPF_CGROUP_MAX_PROGS
 	 */
-	struct hlist_head progs[MAX_CGROUP_BPF_ATTACH_TYPE];
+	struct hlist_head __rcu progs[MAX_CGROUP_BPF_ATTACH_TYPE];
 	u8 flags[MAX_CGROUP_BPF_ATTACH_TYPE];
 
 	/* list of cgroup shared storages */
diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 57e9e109257e..555e9cbb3a05 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -106,6 +106,7 @@ struct bpf_prog_list {
 	struct bpf_prog *prog;
 	struct bpf_cgroup_link *link;
 	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE];
+	struct rcu_head rcu;
 };
 
 int cgroup_bpf_inherit(struct cgroup *cgrp);
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 32092c78602f..981897ba8965 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -285,12 +285,14 @@ static void cgroup_bpf_release(struct work_struct *work)
 	mutex_lock(&cgroup_mutex);
 
 	for (atype = 0; atype < ARRAY_SIZE(cgrp->bpf.progs); atype++) {
-		struct hlist_head *progs = &cgrp->bpf.progs[atype];
+		struct hlist_head *progs;
 		struct bpf_prog_list *pl;
-		struct hlist_node *pltmp;
 
-		hlist_for_each_entry_safe(pl, pltmp, progs, node) {
-			hlist_del(&pl->node);
+		progs = rcu_dereference_protected(&cgrp->bpf.progs[atype],
+						  lockdep_is_held(&cgroup_mutex));
+
+		hlist_for_each_entry_rcu(pl, progs, node) {
+			hlist_del_rcu(&pl->node);
 			if (pl->prog) {
 				if (pl->prog->expected_attach_type == BPF_LSM_CGROUP)
 					bpf_trampoline_unlink_cgroup_shim(pl->prog);
@@ -301,7 +303,7 @@ static void cgroup_bpf_release(struct work_struct *work)
 					bpf_trampoline_unlink_cgroup_shim(pl->link->link.prog);
 				bpf_cgroup_link_auto_detach(pl->link);
 			}
-			kfree(pl);
+			kfree_rcu(pl, rcu);
 			static_branch_dec(&cgroup_bpf_enabled_key[atype]);
 		}
 		old_array = rcu_dereference_protected(
@@ -342,22 +344,27 @@ static void cgroup_bpf_release_fn(struct percpu_ref *ref)
  */
 static struct bpf_prog *prog_list_prog(struct bpf_prog_list *pl)
 {
-	if (pl->prog)
-		return pl->prog;
-	if (pl->link)
-		return pl->link->link.prog;
+	struct bpf_cgroup_link *link;
+	struct bpf_prog *prog;
+
+	prog = READ_ONCE(pl->prog);
+	if (prog)
+		return prog;
+	link = READ_ONCE(pl->link);
+	if (link)
+		return link->link.prog;
 	return NULL;
 }
 
 /* count number of elements in the list.
  * it's slow but the list cannot be long
  */
-static u32 prog_list_length(struct hlist_head *head)
+static u32 prog_list_length(struct hlist_head __rcu *head)
 {
 	struct bpf_prog_list *pl;
 	u32 cnt = 0;
 
-	hlist_for_each_entry(pl, head, node) {
+	hlist_for_each_entry_rcu(pl, head, node) {
 		if (!prog_list_prog(pl))
 			continue;
 		cnt++;
@@ -553,7 +560,7 @@ static int update_effective_progs(struct cgroup *cgrp,
 
 #define BPF_CGROUP_MAX_PROGS 64
 
-static struct bpf_prog_list *find_attach_entry(struct hlist_head *progs,
+static struct bpf_prog_list *find_attach_entry(struct hlist_head __rcu *progs,
 					       struct bpf_prog *prog,
 					       struct bpf_cgroup_link *link,
 					       struct bpf_prog *replace_prog,
@@ -565,10 +572,10 @@ static struct bpf_prog_list *find_attach_entry(struct hlist_head *progs,
 	if (!allow_multi) {
 		if (hlist_empty(progs))
 			return NULL;
-		return hlist_entry(progs->first, typeof(*pl), node);
+		return hlist_entry(rcu_dereference_raw(progs)->first, typeof(*pl), node);
 	}
 
-	hlist_for_each_entry(pl, progs, node) {
+	hlist_for_each_entry_rcu(pl, progs, node) {
 		if (prog && pl->prog == prog && prog != replace_prog)
 			/* disallow attaching the same prog twice */
 			return ERR_PTR(-EINVAL);
@@ -579,7 +586,7 @@ static struct bpf_prog_list *find_attach_entry(struct hlist_head *progs,
 
 	/* direct prog multi-attach w/ replacement case */
 	if (replace_prog) {
-		hlist_for_each_entry(pl, progs, node) {
+		hlist_for_each_entry_rcu(pl, progs, node) {
 			if (pl->prog == replace_prog)
 				/* a match found */
 				return pl;
@@ -615,8 +622,8 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
 	struct bpf_prog *new_prog = prog ? : link->link.prog;
 	enum cgroup_bpf_attach_type atype;
+	struct hlist_head __rcu *progs;
 	struct bpf_prog_list *pl;
-	struct hlist_head *progs;
 	int err;
 
 	if (((flags & BPF_F_ALLOW_OVERRIDE) && (flags & BPF_F_ALLOW_MULTI)) ||
@@ -658,6 +665,9 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 				      prog ? : link->link.prog, cgrp))
 		return -ENOMEM;
 
+	/* for concurrent readers: update flags before adding prog to the list */
+	WRITE_ONCE(cgrp->bpf.flags[atype], saved_flags);
+
 	if (pl) {
 		old_prog = pl->prog;
 	} else {
@@ -669,12 +679,12 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 			return -ENOMEM;
 		}
 		if (hlist_empty(progs))
-			hlist_add_head(&pl->node, progs);
+			hlist_add_head_rcu(&pl->node, progs);
 		else
-			hlist_for_each(last, progs) {
+			hlist_for_each_rcu(last, progs, lockdep_is_held(&cgroup_mutex)) {
 				if (last->next)
 					continue;
-				hlist_add_behind(&pl->node, last);
+				hlist_add_behind_rcu(&pl->node, last);
 				break;
 			}
 	}
@@ -682,7 +692,6 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	pl->prog = prog;
 	pl->link = link;
 	bpf_cgroup_storages_assign(pl->storage, storage);
-	cgrp->bpf.flags[atype] = saved_flags;
 
 	if (type == BPF_LSM_CGROUP) {
 		err = bpf_trampoline_link_cgroup_shim(new_prog, atype);
@@ -794,9 +803,9 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
 				struct bpf_prog *new_prog)
 {
 	enum cgroup_bpf_attach_type atype;
+	struct hlist_head __rcu *progs;
 	struct bpf_prog *old_prog;
 	struct bpf_prog_list *pl;
-	struct hlist_head *progs;
 	bool found = false;
 
 	atype = bpf_cgroup_atype_find(link->type, new_prog->aux->attach_btf_id);
@@ -808,7 +817,7 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
 	if (link->link.prog->type != new_prog->type)
 		return -EINVAL;
 
-	hlist_for_each_entry(pl, progs, node) {
+	hlist_for_each_entry_rcu(pl, progs, node) {
 		if (pl->link == link) {
 			found = true;
 			break;
@@ -847,7 +856,7 @@ static int cgroup_bpf_replace(struct bpf_link *link, struct bpf_prog *new_prog,
 	return ret;
 }
 
-static struct bpf_prog_list *find_detach_entry(struct hlist_head *progs,
+static struct bpf_prog_list *find_detach_entry(struct hlist_head __rcu *progs,
 					       struct bpf_prog *prog,
 					       struct bpf_cgroup_link *link,
 					       bool allow_multi)
@@ -862,7 +871,7 @@ static struct bpf_prog_list *find_detach_entry(struct hlist_head *progs,
 		/* to maintain backward compatibility NONE and OVERRIDE cgroups
 		 * allow detaching with invalid FD (prog==NULL) in legacy mode
 		 */
-		return hlist_entry(progs->first, typeof(*pl), node);
+		return hlist_entry(rcu_dereference_raw(progs)->first, typeof(*pl), node);
 	}
 
 	if (!prog && !link)
@@ -872,7 +881,7 @@ static struct bpf_prog_list *find_detach_entry(struct hlist_head *progs,
 		return ERR_PTR(-EINVAL);
 
 	/* find the prog or link and detach it */
-	hlist_for_each_entry(pl, progs, node) {
+	hlist_for_each_entry_rcu(pl, progs, node) {
 		if (pl->prog == prog && pl->link == link)
 			return pl;
 	}
@@ -894,9 +903,9 @@ static void purge_effective_progs(struct cgroup *cgrp, struct bpf_prog *prog,
 				  enum cgroup_bpf_attach_type atype)
 {
 	struct cgroup_subsys_state *css;
+	struct hlist_head __rcu *head;
 	struct bpf_prog_array *progs;
 	struct bpf_prog_list *pl;
-	struct hlist_head *head;
 	struct cgroup *cg;
 	int pos;
 
@@ -913,7 +922,7 @@ static void purge_effective_progs(struct cgroup *cgrp, struct bpf_prog *prog,
 				continue;
 
 			head = &cg->bpf.progs[atype];
-			hlist_for_each_entry(pl, head, node) {
+			hlist_for_each_entry_rcu(pl, head, node) {
 				if (!prog_list_prog(pl))
 					continue;
 				if (pl->prog == prog && pl->link == link)
@@ -950,9 +959,9 @@ static int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 			       struct bpf_cgroup_link *link, enum bpf_attach_type type)
 {
 	enum cgroup_bpf_attach_type atype;
+	struct hlist_head __rcu *progs;
 	struct bpf_prog *old_prog;
 	struct bpf_prog_list *pl;
-	struct hlist_head *progs;
 	u32 attach_btf_id = 0;
 	u32 flags;
 
@@ -978,23 +987,23 @@ static int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 
 	/* mark it deleted, so it's ignored while recomputing effective */
 	old_prog = pl->prog;
-	pl->prog = NULL;
-	pl->link = NULL;
+	WRITE_ONCE(pl->prog, NULL);
+	WRITE_ONCE(pl->link, NULL);
 
 	if (update_effective_progs(cgrp, atype)) {
 		/* if update effective array failed replace the prog with a dummy prog*/
-		pl->prog = old_prog;
-		pl->link = link;
+		WRITE_ONCE(pl->prog, old_prog);
+		WRITE_ONCE(pl->link, link);
 		purge_effective_progs(cgrp, old_prog, link, atype);
 	}
 
 	/* now can actually delete it from this cgroup list */
-	hlist_del(&pl->node);
+	hlist_del_rcu(&pl->node);
 
-	kfree(pl);
+	kfree_rcu(pl, rcu);
 	if (hlist_empty(progs))
 		/* last program was detached, reset flags to zero */
-		cgrp->bpf.flags[atype] = 0;
+		WRITE_ONCE(cgrp->bpf.flags[atype], 0);
 	if (old_prog) {
 		if (type == BPF_LSM_CGROUP)
 			bpf_trampoline_unlink_cgroup_shim(old_prog);
@@ -1015,9 +1024,8 @@ static int cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 	return ret;
 }
 
-/* Must be called with cgroup_mutex held to avoid races. */
-static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
-			      union bpf_attr __user *uattr)
+static int cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
+			    union bpf_attr __user *uattr)
 {
 	__u32 __user *prog_attach_flags = u64_to_user_ptr(attr->query.prog_attach_flags);
 	bool effective_query = attr->query.query_flags & BPF_F_QUERY_EFFECTIVE;
@@ -1025,12 +1033,11 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 	enum bpf_attach_type type = attr->query.attach_type;
 	enum cgroup_bpf_attach_type from_atype, to_atype;
 	enum cgroup_bpf_attach_type atype;
-	struct bpf_prog_array *effective;
 	int cnt, ret = 0, i;
 	int total_cnt = 0;
+	u32 *prog_ids, *p;
 	int remaining;
 	u32 flags;
-	u32 *p;
 
 	if (effective_query && prog_attach_flags)
 		return -EINVAL;
@@ -1048,17 +1055,20 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 		if (from_atype < 0)
 			return -EINVAL;
 		to_atype = from_atype;
-		flags = cgrp->bpf.flags[from_atype];
+		flags = READ_ONCE(cgrp->bpf.flags[from_atype]);
 	}
 
 	for (atype = from_atype; atype <= to_atype; atype++) {
+		rcu_read_lock();
 		if (effective_query) {
-			effective = rcu_dereference_protected(cgrp->bpf.effective[atype],
-							      lockdep_is_held(&cgroup_mutex));
+			struct bpf_prog_array *effective;
+
+			effective = rcu_dereference(cgrp->bpf.effective[atype]);
 			total_cnt += bpf_prog_array_length(effective);
 		} else {
 			total_cnt += prog_list_length(&cgrp->bpf.progs[atype]);
 		}
+		rcu_read_unlock();
 	}
 
 	/* always output uattr->query.attach_flags as 0 during effective query */
@@ -1076,39 +1086,53 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 		ret = -ENOSPC;
 	}
 
-	p = user_prog_ids;
+	prog_ids = kcalloc(total_cnt, sizeof(u32), GFP_USER | __GFP_NOWARN);
+	if (!prog_ids)
+		return -ENOMEM;
+
+	p = prog_ids;
 	remaining = total_cnt;
 	for (atype = from_atype; atype <= to_atype && remaining; atype++) {
 		if (effective_query) {
-			effective = rcu_dereference_protected(cgrp->bpf.effective[atype],
-							      lockdep_is_held(&cgroup_mutex));
+			struct bpf_prog_array *effective;
+
+			rcu_read_lock();
+			effective = rcu_dereference(cgrp->bpf.effective[atype]);
 			cnt = min_t(int, bpf_prog_array_length(effective), remaining);
-			ret = bpf_prog_array_copy_to_user(effective, p, cnt);
+			ret = bpf_prog_array_copy_core(effective, p, cnt);
+			rcu_read_unlock();
 		} else {
-			struct hlist_head *progs;
+			struct hlist_head __rcu *progs;
 			struct bpf_prog_list *pl;
 			struct bpf_prog *prog;
 			u32 id;
 
+			rcu_read_lock();
 			progs = &cgrp->bpf.progs[atype];
 			cnt = min_t(int, prog_list_length(progs), remaining);
 			i = 0;
-			hlist_for_each_entry(pl, progs, node) {
-				prog = prog_list_prog(pl);
+			hlist_for_each_entry_rcu(pl, progs, node) {
+				prog = bpf_prog_inc_not_zero(prog_list_prog(pl));
+				if (IS_ERR(prog))
+					continue;
+
 				id = prog->aux->id;
-				if (copy_to_user(p + i, &id, sizeof(id)))
-					return -EFAULT;
+				p[i] = id;
+				bpf_prog_put(prog);
 				if (++i == cnt)
 					break;
 			}
+			rcu_read_unlock();
 
 			if (prog_attach_flags) {
-				flags = cgrp->bpf.flags[atype];
+				flags = READ_ONCE(cgrp->bpf.flags[atype]);
 
 				for (i = 0; i < cnt; i++)
 					if (copy_to_user(prog_attach_flags + i,
-							 &flags, sizeof(flags)))
-						return -EFAULT;
+							 &flags, sizeof(flags))) {
+						ret = -EFAULT;
+						goto free_user_ids;
+					}
 				prog_attach_flags += cnt;
 			}
 		}
@@ -1116,17 +1140,17 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 		p += cnt;
 		remaining -= cnt;
 	}
-	return ret;
-}
+	if (remaining != 0) {
+		ret = -EAGAIN; /* raced with the detach */
+		goto free_user_ids;
+	}
 
-static int cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
-			    union bpf_attr __user *uattr)
-{
-	int ret;
+	if (copy_to_user(user_prog_ids, prog_ids, sizeof(u32) * total_cnt))
+		ret = -EFAULT;
+
+free_user_ids:
+	kfree(prog_ids);
 
-	mutex_lock(&cgroup_mutex);
-	ret = __cgroup_bpf_query(cgrp, attr, uattr);
-	mutex_unlock(&cgroup_mutex);
 	return ret;
 }
 
-- 
2.40.1.521.gf1e218fcd8-goog


