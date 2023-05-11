Return-Path: <bpf+bounces-346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C226FF68A
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 17:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DCB281840
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 15:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840314422;
	Thu, 11 May 2023 15:57:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350FD653
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 15:57:45 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B551BD
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 08:57:43 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53017eb8b2eso5134884a12.0
        for <bpf@vger.kernel.org>; Thu, 11 May 2023 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683820662; x=1686412662;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ysslTo/Hfn7pNtQxK1ESeT51Y+ffNIBUq319/dJaMt8=;
        b=B+LLngFhR6t5kVZS52Dl9o/rkEgmAX6BOh6PfmbRbCric5EvEhXwSBz1PDs1GzLRUh
         1AQ8JKrAq4h7wjXuSoo2zsepftDb+kVS+my1K50vOZaPVSpApg01dP/kx2R6QY0kl4BO
         jkJ6i3pgdMZelPswspNwSOylF6BTftKuQXDJg9AC1p1CO2kGcGHK5xcUh410afTOCxU2
         34DhjJ4N/8XO68MXnkl/7kP7p0594DnLr/alym3fImDa89f2LT/PfbtpzZkw4YfAU7hU
         zwhiBT1/6jchcsIGnEA647PPemJpcdV1Nykc3gGWby7INiwY4mjK0tLO6xtpdkc0hqMr
         LxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683820663; x=1686412663;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ysslTo/Hfn7pNtQxK1ESeT51Y+ffNIBUq319/dJaMt8=;
        b=BUfJuk56jIIyBZ5q8VkAwqJfhi1NVTVdz+BQzPuWRQFpANw7GP8ZSiO80IQQLWoYXE
         EewvU6nNj3LvxEyQdFdz7YL7dc/BP87Ki/LDyk2B+4wiGK8yUec57ltgXMaWwzCSKJia
         X/dhT8YgPzfGKrQHF96DT5xhQ9mX0WKYlfkYMmgzb3G9+lafEKZk6is1oeGLu8mhOMQV
         /nzwb2feIip44mK/doVDPn3KBaNNSLwgn6EYXWFLaLUGF6q0jgDGEMfBbUVH1zbgQsdB
         p2UMvXw8hXvMZqV/9j7sNswcL/dvnzD2xbJEzciR/6Ss/b/ARnfrWPLZzQP+u5zYe0+/
         fOgQ==
X-Gm-Message-State: AC+VfDyyOPkuJskBDuVWaDW2+bsygcBtBsEOuSuuLI51HfByyp+eDwl7
	LAMMkB2P/tDE4arTOsxGi3NYi9Fzb26WmZrmD8vmFGY0weQ/o+XTRZUff9lwfWP/KTqpu+loa4l
	OnQZO1Ws8jvqDiZ9lAKyWRFadqet9c/d7UlPnqoTBnovBHpHkIw==
X-Google-Smtp-Source: ACHHUZ6/1W2DI3jpyOcR0dQA7ClDFHfpeMR2AnvbY/F4d4kv7rAgQsgCsiD8JwA/OdpQumuaPgIhtgo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:a1d:0:b0:530:8674:b4d5 with SMTP id
 29-20020a630a1d000000b005308674b4d5mr372442pgk.12.1683820662619; Thu, 11 May
 2023 08:57:42 -0700 (PDT)
Date: Thu, 11 May 2023 08:57:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230511155740.902548-1-sdf@google.com>
Subject: [PATCH bpf-next] RFC: bpf: query effective progs without cgroup_mutex
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

We're observing some stalls on the heavily loaded machines
in the cgroup_bpf_prog_query path. This is likely due to
being blocked on cgroup_mutex.

IIUC, the cgroup_mutex is there mostly to protect the non-effective
fields (cgrp->bpf.progs) which might be changed by the update path.
For the BPF_F_QUERY_EFFECTIVE case, all we need is to rcu_dereference
a bunch of pointers (and keep them around for consistency), so
let's do it.

Sending out as an RFC because it looks a bit ugly. It would also
be nice to handle non-effective case locklessly as well, but it
might require a larger rework.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf-cgroup-defs.h |  2 +-
 include/linux/bpf-cgroup.h      |  1 +
 kernel/bpf/cgroup.c             | 80 +++++++++++++++++----------------
 3 files changed, 44 insertions(+), 39 deletions(-)

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
index a06e118a9be5..92a1b33dcc06 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -285,12 +285,15 @@ static void cgroup_bpf_release(struct work_struct *work)
 	mutex_lock(&cgroup_mutex);
 
 	for (atype = 0; atype < ARRAY_SIZE(cgrp->bpf.progs); atype++) {
-		struct hlist_head *progs = &cgrp->bpf.progs[atype];
+		struct hlist_head *progs;
 		struct bpf_prog_list *pl;
 		struct hlist_node *pltmp;
 
+		progs = rcu_dereference_protected(&cgrp->bpf.progs[atype],
+						  lockdep_is_held(&cgroup_mutex));
+
 		hlist_for_each_entry_safe(pl, pltmp, progs, node) {
-			hlist_del(&pl->node);
+			hlist_del_rcu(&pl->node);
 			if (pl->prog) {
 				if (pl->prog->expected_attach_type == BPF_LSM_CGROUP)
 					bpf_trampoline_unlink_cgroup_shim(pl->prog);
@@ -301,7 +304,7 @@ static void cgroup_bpf_release(struct work_struct *work)
 					bpf_trampoline_unlink_cgroup_shim(pl->link->link.prog);
 				bpf_cgroup_link_auto_detach(pl->link);
 			}
-			kfree(pl);
+			kfree_rcu(pl, rcu);
 			static_branch_dec(&cgroup_bpf_enabled_key[atype]);
 		}
 		old_array = rcu_dereference_protected(
@@ -352,12 +355,12 @@ static struct bpf_prog *prog_list_prog(struct bpf_prog_list *pl)
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
@@ -553,7 +556,7 @@ static int update_effective_progs(struct cgroup *cgrp,
 
 #define BPF_CGROUP_MAX_PROGS 64
 
-static struct bpf_prog_list *find_attach_entry(struct hlist_head *progs,
+static struct bpf_prog_list *find_attach_entry(struct hlist_head __rcu *progs,
 					       struct bpf_prog *prog,
 					       struct bpf_cgroup_link *link,
 					       struct bpf_prog *replace_prog,
@@ -565,10 +568,10 @@ static struct bpf_prog_list *find_attach_entry(struct hlist_head *progs,
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
@@ -579,7 +582,7 @@ static struct bpf_prog_list *find_attach_entry(struct hlist_head *progs,
 
 	/* direct prog multi-attach w/ replacement case */
 	if (replace_prog) {
-		hlist_for_each_entry(pl, progs, node) {
+		hlist_for_each_entry_rcu(pl, progs, node) {
 			if (pl->prog == replace_prog)
 				/* a match found */
 				return pl;
@@ -615,8 +618,8 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
 	struct bpf_prog *new_prog = prog ? : link->link.prog;
 	enum cgroup_bpf_attach_type atype;
+	struct hlist_head __rcu *progs;
 	struct bpf_prog_list *pl;
-	struct hlist_head *progs;
 	int err;
 
 	if (((flags & BPF_F_ALLOW_OVERRIDE) && (flags & BPF_F_ALLOW_MULTI)) ||
@@ -658,6 +661,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 				      prog ? : link->link.prog, cgrp))
 		return -ENOMEM;
 
+	WRITE_ONCE(cgrp->bpf.flags[atype], saved_flags);
 	if (pl) {
 		old_prog = pl->prog;
 	} else {
@@ -669,12 +673,12 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 			return -ENOMEM;
 		}
 		if (hlist_empty(progs))
-			hlist_add_head(&pl->node, progs);
+			hlist_add_head_rcu(&pl->node, progs);
 		else
-			hlist_for_each(last, progs) {
+			__hlist_for_each_rcu(last, progs) {
 				if (last->next)
 					continue;
-				hlist_add_behind(&pl->node, last);
+				hlist_add_behind_rcu(&pl->node, last);
 				break;
 			}
 	}
@@ -682,7 +686,6 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	pl->prog = prog;
 	pl->link = link;
 	bpf_cgroup_storages_assign(pl->storage, storage);
-	cgrp->bpf.flags[atype] = saved_flags;
 
 	if (type == BPF_LSM_CGROUP) {
 		err = bpf_trampoline_link_cgroup_shim(new_prog, atype);
@@ -796,7 +799,7 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
 	enum cgroup_bpf_attach_type atype;
 	struct bpf_prog *old_prog;
 	struct bpf_prog_list *pl;
-	struct hlist_head *progs;
+	struct hlist_head __rcu *progs;
 	bool found = false;
 
 	atype = bpf_cgroup_atype_find(link->type, new_prog->aux->attach_btf_id);
@@ -808,7 +811,7 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
 	if (link->link.prog->type != new_prog->type)
 		return -EINVAL;
 
-	hlist_for_each_entry(pl, progs, node) {
+	hlist_for_each_entry_rcu(pl, progs, node) {
 		if (pl->link == link) {
 			found = true;
 			break;
@@ -847,7 +850,7 @@ static int cgroup_bpf_replace(struct bpf_link *link, struct bpf_prog *new_prog,
 	return ret;
 }
 
-static struct bpf_prog_list *find_detach_entry(struct hlist_head *progs,
+static struct bpf_prog_list *find_detach_entry(struct hlist_head __rcu *progs,
 					       struct bpf_prog *prog,
 					       struct bpf_cgroup_link *link,
 					       bool allow_multi)
@@ -862,7 +865,7 @@ static struct bpf_prog_list *find_detach_entry(struct hlist_head *progs,
 		/* to maintain backward compatibility NONE and OVERRIDE cgroups
 		 * allow detaching with invalid FD (prog==NULL) in legacy mode
 		 */
-		return hlist_entry(progs->first, typeof(*pl), node);
+		return hlist_entry(rcu_dereference_raw(progs)->first, typeof(*pl), node);
 	}
 
 	if (!prog && !link)
@@ -872,7 +875,7 @@ static struct bpf_prog_list *find_detach_entry(struct hlist_head *progs,
 		return ERR_PTR(-EINVAL);
 
 	/* find the prog or link and detach it */
-	hlist_for_each_entry(pl, progs, node) {
+	hlist_for_each_entry_rcu(pl, progs, node) {
 		if (pl->prog == prog && pl->link == link)
 			return pl;
 	}
@@ -894,9 +897,9 @@ static void purge_effective_progs(struct cgroup *cgrp, struct bpf_prog *prog,
 				  enum cgroup_bpf_attach_type atype)
 {
 	struct cgroup_subsys_state *css;
+	struct hlist_head __rcu *head;
 	struct bpf_prog_array *progs;
 	struct bpf_prog_list *pl;
-	struct hlist_head *head;
 	struct cgroup *cg;
 	int pos;
 
@@ -913,7 +916,7 @@ static void purge_effective_progs(struct cgroup *cgrp, struct bpf_prog *prog,
 				continue;
 
 			head = &cg->bpf.progs[atype];
-			hlist_for_each_entry(pl, head, node) {
+			hlist_for_each_entry_rcu(pl, head, node) {
 				if (!prog_list_prog(pl))
 					continue;
 				if (pl->prog == prog && pl->link == link)
@@ -950,9 +953,9 @@ static int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 			       struct bpf_cgroup_link *link, enum bpf_attach_type type)
 {
 	enum cgroup_bpf_attach_type atype;
+	struct hlist_head __rcu *progs;
 	struct bpf_prog *old_prog;
 	struct bpf_prog_list *pl;
-	struct hlist_head *progs;
 	u32 attach_btf_id = 0;
 	u32 flags;
 
@@ -989,12 +992,12 @@ static int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 	}
 
 	/* now can actually delete it from this cgroup list */
-	hlist_del(&pl->node);
+	hlist_del_rcu(&pl->node);
 
 	kfree(pl);
 	if (hlist_empty(progs))
 		/* last program was detached, reset flags to zero */
-		cgrp->bpf.flags[atype] = 0;
+		WRITE_ONCE(cgrp->bpf.flags[atype], 0);
 	if (old_prog) {
 		if (type == BPF_LSM_CGROUP)
 			bpf_trampoline_unlink_cgroup_shim(old_prog);
@@ -1022,10 +1025,10 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 	__u32 __user *prog_attach_flags = u64_to_user_ptr(attr->query.prog_attach_flags);
 	bool effective_query = attr->query.query_flags & BPF_F_QUERY_EFFECTIVE;
 	__u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
+	struct bpf_prog_array *effective[MAX_CGROUP_BPF_ATTACH_TYPE];
 	enum bpf_attach_type type = attr->query.attach_type;
 	enum cgroup_bpf_attach_type from_atype, to_atype;
 	enum cgroup_bpf_attach_type atype;
-	struct bpf_prog_array *effective;
 	int cnt, ret = 0, i;
 	int total_cnt = 0;
 	u32 flags;
@@ -1046,14 +1049,15 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 		if (from_atype < 0)
 			return -EINVAL;
 		to_atype = from_atype;
-		flags = cgrp->bpf.flags[from_atype];
+		flags = READ_ONCE(cgrp->bpf.flags[from_atype]);
 	}
 
 	for (atype = from_atype; atype <= to_atype; atype++) {
 		if (effective_query) {
-			effective = rcu_dereference_protected(cgrp->bpf.effective[atype],
-							      lockdep_is_held(&cgroup_mutex));
-			total_cnt += bpf_prog_array_length(effective);
+			effective[atype] = rcu_dereference_protected(
+						cgrp->bpf.effective[atype],
+						lockdep_is_held(&cgroup_mutex));
+			total_cnt += bpf_prog_array_length(effective[atype]);
 		} else {
 			total_cnt += prog_list_length(&cgrp->bpf.progs[atype]);
 		}
@@ -1076,12 +1080,10 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 
 	for (atype = from_atype; atype <= to_atype && total_cnt; atype++) {
 		if (effective_query) {
-			effective = rcu_dereference_protected(cgrp->bpf.effective[atype],
-							      lockdep_is_held(&cgroup_mutex));
-			cnt = min_t(int, bpf_prog_array_length(effective), total_cnt);
-			ret = bpf_prog_array_copy_to_user(effective, prog_ids, cnt);
+			cnt = min_t(int, bpf_prog_array_length(effective[atype]), total_cnt);
+			ret = bpf_prog_array_copy_to_user(effective[atype], prog_ids, cnt);
 		} else {
-			struct hlist_head *progs;
+			struct hlist_head __rcu *progs;
 			struct bpf_prog_list *pl;
 			struct bpf_prog *prog;
 			u32 id;
@@ -1089,7 +1091,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 			progs = &cgrp->bpf.progs[atype];
 			cnt = min_t(int, prog_list_length(progs), total_cnt);
 			i = 0;
-			hlist_for_each_entry(pl, progs, node) {
+			hlist_for_each_entry_rcu(pl, progs, node) {
 				prog = prog_list_prog(pl);
 				id = prog->aux->id;
 				if (copy_to_user(prog_ids + i, &id, sizeof(id)))
@@ -1099,7 +1101,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 			}
 
 			if (prog_attach_flags) {
-				flags = cgrp->bpf.flags[atype];
+				flags = READ_ONCE(cgrp->bpf.flags[atype]);
 
 				for (i = 0; i < cnt; i++)
 					if (copy_to_user(prog_attach_flags + i,
@@ -1112,6 +1114,8 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 		prog_ids += cnt;
 		total_cnt -= cnt;
 	}
+	if (total_cnt != 0)
+		return -EAGAIN; /* raced with the detach */
 	return ret;
 }
 
@@ -1120,9 +1124,9 @@ static int cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 {
 	int ret;
 
-	mutex_lock(&cgroup_mutex);
+	rcu_read_lock();
 	ret = __cgroup_bpf_query(cgrp, attr, uattr);
-	mutex_unlock(&cgroup_mutex);
+	rcu_read_unlock();
 	return ret;
 }
 
-- 
2.40.1.521.gf1e218fcd8-goog


