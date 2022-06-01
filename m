Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E36B53AD27
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 21:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiFATGx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jun 2022 15:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiFATGw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jun 2022 15:06:52 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF90B1B
        for <bpf@vger.kernel.org>; Wed,  1 Jun 2022 12:06:49 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id u1-20020a17090a2b8100b001d9325a862fso1525419pjd.6
        for <bpf@vger.kernel.org>; Wed, 01 Jun 2022 12:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fqoikC9tC99i5iKJZbqKTYpgvY7XO+zbxbpfb4IuTeM=;
        b=QPnHRaGvjkkTcHAaDiyHhFjogVAet7B5SEaNwNoRWkurP/N1UKnM+Wj/WCxFRy5Ll5
         ddRA9fmkoK5fL3C6Ohm5zweIC7BprhIsi2Tlzl1hbkEFYwGBamHPeWcd2F6LT3hclaqm
         LtxFaoUbbQY9HqIo3Xn4bnsm5BzNIRsSpzCnVsgdnnweWxH5Hmbd0PAlym5ZcbQTJHRp
         9wIzuw+kU1ePA3fyKoyFbofkYrvi7GGa6vmt9MLJqVsiFoyEAESWVuOH8QFcvvDMWph5
         ihu3uDKYaDHefY+cZSCnUWizjvTjLBXUAwCcGdSab5VCtTihXcDY2PaI3dRCfXP3eZ1e
         cCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fqoikC9tC99i5iKJZbqKTYpgvY7XO+zbxbpfb4IuTeM=;
        b=m1gHjsyvlvLx04oZozyDuXK7SJNdu/IypLIIpQgFvRZbH1TD2XRW70I+1s59qW7f+x
         ancePpTqe5kTLIih47It61nmbcgkw+OgyLcUbbeSJOKMLrqQ3twc2/Lbo6zYy5UHm3j3
         BJHKIDLK3CDHnX32JuHples/LkLLoDcB9jsySOun2NWNqa1S/W23n9DNjs/uYXlDrhyB
         YnZ+3FvP0zhpkemC/PpOb5iEKYMSgzfo9dolbiXpi2tpLOOjGUHWO0alstsdDF7d7eNT
         wR8vSNRxh3LPlW7XXgODzzAy2Tqc1DIZ1O8aMdd/QX7+6hR6EJIwF82xdaKrdHm4CXqj
         //gQ==
X-Gm-Message-State: AOAM531p9WFA8l2YNVph7QIMJ3zTzPVR2d1k4tE4dhIAr51dipBC/csz
        lrt5vV3PAJTuYc4x77MV4AmpYyI=
X-Google-Smtp-Source: ABdhPJw3ixXb/cYOBLDbzJzvX6VG65iQvyIp/+5w2mLoZ6FjtPA4M0t6w5opbPb8+HGxj6tkrl3ZASY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:1307:b0:50d:b02e:11df with SMTP id
 j7-20020a056a00130700b0050db02e11dfmr1043180pfu.4.1654110143708; Wed, 01 Jun
 2022 12:02:23 -0700 (PDT)
Date:   Wed,  1 Jun 2022 12:02:09 -0700
In-Reply-To: <20220601190218.2494963-1-sdf@google.com>
Message-Id: <20220601190218.2494963-3-sdf@google.com>
Mime-Version: 1.0
References: <20220601190218.2494963-1-sdf@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH bpf-next v8 02/11] bpf: convert cgroup_bpf.progs to hlist
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
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf-cgroup-defs.h |  4 +-
 include/linux/bpf-cgroup.h      |  2 +-
 kernel/bpf/cgroup.c             | 76 +++++++++++++++++++--------------
 3 files changed, 47 insertions(+), 35 deletions(-)

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
index 669d96d074ad..6673acfbf2ef 100644
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
index 7a394f7c205c..4adb4f3ecb7f 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -157,11 +157,12 @@ static void cgroup_bpf_release(struct work_struct *work)
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
@@ -217,12 +218,12 @@ static struct bpf_prog *prog_list_prog(struct bpf_prog_list *pl)
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
@@ -291,7 +292,7 @@ static int compute_effective_progs(struct cgroup *cgrp,
 		if (cnt > 0 && !(p->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
 			continue;
 
-		list_for_each_entry(pl, &p->bpf.progs[atype], node) {
+		hlist_for_each_entry(pl, &p->bpf.progs[atype], node) {
 			if (!prog_list_prog(pl))
 				continue;
 
@@ -342,7 +343,7 @@ int cgroup_bpf_inherit(struct cgroup *cgrp)
 		cgroup_bpf_get(p);
 
 	for (i = 0; i < NR; i++)
-		INIT_LIST_HEAD(&cgrp->bpf.progs[i]);
+		INIT_HLIST_HEAD(&cgrp->bpf.progs[i]);
 
 	INIT_LIST_HEAD(&cgrp->bpf.storages);
 
@@ -418,7 +419,7 @@ static int update_effective_progs(struct cgroup *cgrp,
 
 #define BPF_CGROUP_MAX_PROGS 64
 
-static struct bpf_prog_list *find_attach_entry(struct list_head *progs,
+static struct bpf_prog_list *find_attach_entry(struct hlist_head *progs,
 					       struct bpf_prog *prog,
 					       struct bpf_cgroup_link *link,
 					       struct bpf_prog *replace_prog,
@@ -428,12 +429,12 @@ static struct bpf_prog_list *find_attach_entry(struct list_head *progs,
 
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
@@ -444,7 +445,7 @@ static struct bpf_prog_list *find_attach_entry(struct list_head *progs,
 
 	/* direct prog multi-attach w/ replacement case */
 	if (replace_prog) {
-		list_for_each_entry(pl, progs, node) {
+		hlist_for_each_entry(pl, progs, node) {
 			if (pl->prog == replace_prog)
 				/* a match found */
 				return pl;
@@ -480,7 +481,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
 	enum cgroup_bpf_attach_type atype;
 	struct bpf_prog_list *pl;
-	struct list_head *progs;
+	struct hlist_head *progs;
 	int err;
 
 	if (((flags & BPF_F_ALLOW_OVERRIDE) && (flags & BPF_F_ALLOW_MULTI)) ||
@@ -503,7 +504,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	if (!hierarchy_allows_attach(cgrp, atype))
 		return -EPERM;
 
-	if (!list_empty(progs) && cgrp->bpf.flags[atype] != saved_flags)
+	if (!hlist_empty(progs) && cgrp->bpf.flags[atype] != saved_flags)
 		/* Disallow attaching non-overridable on top
 		 * of existing overridable in this cgroup.
 		 * Disallow attaching multi-prog if overridable or none
@@ -525,12 +526,22 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
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
@@ -556,7 +567,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	}
 	bpf_cgroup_storages_free(new_storage);
 	if (!old_prog) {
-		list_del(&pl->node);
+		hlist_del(&pl->node);
 		kfree(pl);
 	}
 	return err;
@@ -587,7 +598,7 @@ static void replace_effective_prog(struct cgroup *cgrp,
 	struct cgroup_subsys_state *css;
 	struct bpf_prog_array *progs;
 	struct bpf_prog_list *pl;
-	struct list_head *head;
+	struct hlist_head *head;
 	struct cgroup *cg;
 	int pos;
 
@@ -603,7 +614,7 @@ static void replace_effective_prog(struct cgroup *cgrp,
 				continue;
 
 			head = &cg->bpf.progs[atype];
-			list_for_each_entry(pl, head, node) {
+			hlist_for_each_entry(pl, head, node) {
 				if (!prog_list_prog(pl))
 					continue;
 				if (pl->link == link)
@@ -637,7 +648,7 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
 	enum cgroup_bpf_attach_type atype;
 	struct bpf_prog *old_prog;
 	struct bpf_prog_list *pl;
-	struct list_head *progs;
+	struct hlist_head *progs;
 	bool found = false;
 
 	atype = to_cgroup_bpf_attach_type(link->type);
@@ -649,7 +660,7 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
 	if (link->link.prog->type != new_prog->type)
 		return -EINVAL;
 
-	list_for_each_entry(pl, progs, node) {
+	hlist_for_each_entry(pl, progs, node) {
 		if (pl->link == link) {
 			found = true;
 			break;
@@ -688,7 +699,7 @@ static int cgroup_bpf_replace(struct bpf_link *link, struct bpf_prog *new_prog,
 	return ret;
 }
 
-static struct bpf_prog_list *find_detach_entry(struct list_head *progs,
+static struct bpf_prog_list *find_detach_entry(struct hlist_head *progs,
 					       struct bpf_prog *prog,
 					       struct bpf_cgroup_link *link,
 					       bool allow_multi)
@@ -696,14 +707,14 @@ static struct bpf_prog_list *find_detach_entry(struct list_head *progs,
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
@@ -713,7 +724,7 @@ static struct bpf_prog_list *find_detach_entry(struct list_head *progs,
 		return ERR_PTR(-EINVAL);
 
 	/* find the prog or link and detach it */
-	list_for_each_entry(pl, progs, node) {
+	hlist_for_each_entry(pl, progs, node) {
 		if (pl->prog == prog && pl->link == link)
 			return pl;
 	}
@@ -737,7 +748,7 @@ static void purge_effective_progs(struct cgroup *cgrp, struct bpf_prog *prog,
 	struct cgroup_subsys_state *css;
 	struct bpf_prog_array *progs;
 	struct bpf_prog_list *pl;
-	struct list_head *head;
+	struct hlist_head *head;
 	struct cgroup *cg;
 	int pos;
 
@@ -754,7 +765,7 @@ static void purge_effective_progs(struct cgroup *cgrp, struct bpf_prog *prog,
 				continue;
 
 			head = &cg->bpf.progs[atype];
-			list_for_each_entry(pl, head, node) {
+			hlist_for_each_entry(pl, head, node) {
 				if (!prog_list_prog(pl))
 					continue;
 				if (pl->prog == prog && pl->link == link)
@@ -791,7 +802,7 @@ static int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 	enum cgroup_bpf_attach_type atype;
 	struct bpf_prog *old_prog;
 	struct bpf_prog_list *pl;
-	struct list_head *progs;
+	struct hlist_head *progs;
 	u32 flags;
 
 	atype = to_cgroup_bpf_attach_type(type);
@@ -822,9 +833,10 @@ static int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 	}
 
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
@@ -852,7 +864,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 	enum bpf_attach_type type = attr->query.attach_type;
 	enum cgroup_bpf_attach_type atype;
 	struct bpf_prog_array *effective;
-	struct list_head *progs;
+	struct hlist_head *progs;
 	struct bpf_prog *prog;
 	int cnt, ret = 0, i;
 	u32 flags;
@@ -891,7 +903,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 		u32 id;
 
 		i = 0;
-		list_for_each_entry(pl, progs, node) {
+		hlist_for_each_entry(pl, progs, node) {
 			prog = prog_list_prog(pl);
 			id = prog->aux->id;
 			if (copy_to_user(prog_ids + i, &id, sizeof(id)))
-- 
2.36.1.255.ge46751e96f-goog

