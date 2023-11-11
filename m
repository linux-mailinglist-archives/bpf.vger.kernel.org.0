Return-Path: <bpf+bounces-14827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4317E8877
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8704A28122B
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540AD5242;
	Sat, 11 Nov 2023 02:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pzf7f58r"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A7263AE
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:49:15 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80BE44B8;
	Fri, 10 Nov 2023 18:49:08 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cc131e52f1so28826955ad.0;
        Fri, 10 Nov 2023 18:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670948; x=1700275748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYAi8NU8qvT6JL+5ks1w/VQtFCCl64ESizJrLPA2acc=;
        b=Pzf7f58rgFVCN789YOzyZtzBHmarHojB0ayRF5kqyX+Lt9KVyn9o7TRD1+CXdQGjtr
         AyBnFTg2Xm4zcpQUUSBmVH+lKnvMF8O07oiBrPqT8amnIG3nSCNhutPLgqobF8qztWnh
         0lWJ0bIsp0FbN8A13qWjmjMOtclL++7TqQgYqtdoi5MkTU1foG7RfFFEUteLokUk1miS
         X8FqQhy2xEMmpVKoWqgF7GbIYrh6QG8u8dkBK06CCg7/sSLlouVFEkMjrbodxM3iwctR
         ZlEV/xLZ8MpkBVzlP4gyWMhIGReAS/BW8e9OLRLcjCFAP34zYZ/HFbgJilaR1n003Uzy
         MwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670948; x=1700275748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OYAi8NU8qvT6JL+5ks1w/VQtFCCl64ESizJrLPA2acc=;
        b=c2J48Imfwn0udiamzL1Znx6Bi30McVtDDer0Fb19XYhQ6CzpORHA6ob2LM3mROxOAW
         qwCQ/mwPwoddRZD+qGuq+tGLOv28K0tilfTUdLFsrs/23N1EmvMO2rkXm2Ukx+2Ib7s1
         jwQjfuEDCM5eYjUqoY6XmNB2j3LD5xU76UHXRg6fWxyg02+VuOQBABzcLMACpfXvKEpU
         DdzKtYpY1Ho5MERxeupHVcpO4qnqLdUNgd5wNqpMjiSKfdG90g3D1Haws8UW4XjWW2zX
         ++su8RWTeg+cgNLPtAsal92P/XZRpCg6p+P1Oq/FnzjwKIRqfwKeC10odsJnLn8v58CF
         XnBQ==
X-Gm-Message-State: AOJu0YzsNeJoyCMRLjMqNiVhOH1+RAqGE5Ji7uEE3JFd9HZUr3Kyr8Vw
	2Iy0avtcHZkk3ll9VwpBFWs=
X-Google-Smtp-Source: AGHT+IHMSrsOCFG7lwNu1/17HnkVspC/S7q8E+eOamI8jiNENyQDAgUSAPxfkwoPmLQnzAn6I93ttg==
X-Received: by 2002:a17:902:ecd2:b0:1bd:e258:a256 with SMTP id a18-20020a170902ecd200b001bde258a256mr1451669plh.32.1699670948227;
        Fri, 10 Nov 2023 18:49:08 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id m18-20020a170902db1200b001c9c6a78a56sm353442plx.97.2023.11.10.18.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:49:07 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	joshdon@google.com,
	brho@google.com,
	pjt@google.com,
	derkling@google.com,
	haoluo@google.com,
	dvernet@meta.com,
	dschatzberg@meta.com,
	dskarlat@cs.cmu.edu,
	riel@surriel.com,
	changwoo@igalia.com,
	himadrics@inria.fr,
	memxor@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 07/36] sched: Expose css_tg() and __setscheduler_prio()
Date: Fri, 10 Nov 2023 16:47:33 -1000
Message-ID: <20231111024835.2164816-8-tj@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111024835.2164816-1-tj@kernel.org>
References: <20231111024835.2164816-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These will be used by a new BPF extensible sched_class.

css_tg() will be used in the init and exit paths to visit all task_groups by
walking cgroups.

__setscheduler_prio() is used to pick the sched_class matching the current
prio of the task. For the new BPF extensible sched_class, the mapping from
the task configuration to sched_class isn't static and depends on a few
factors - e.g. whether the BPF progs implementing the scheduler are loaded
and in a serviceable state. That mapping logic will be added to
__setscheduler_prio().

When the BPF scheduler progs get loaded and unloaded, the mapping changes
and the new sched_class will walk the tasks applying the new mapping using
__setscheduler_prio().

v3: Dropped SCHED_CHANGE_BLOCK() as upstream is adding more generic cleanup
    mechanism.

v2: Expose SCHED_CHANGE_BLOCK() too and update the description.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 kernel/sched/core.c  | 7 +------
 kernel/sched/sched.h | 7 +++++++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 05131ad4b5d5..ce646cdd87dc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7038,7 +7038,7 @@ int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flag
 }
 EXPORT_SYMBOL(default_wake_function);
 
-static void __setscheduler_prio(struct task_struct *p, int prio)
+void __setscheduler_prio(struct task_struct *p, int prio)
 {
 	if (dl_prio(prio))
 		p->sched_class = &dl_sched_class;
@@ -10496,11 +10496,6 @@ void sched_move_task(struct task_struct *tsk)
 	}
 }
 
-static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
-{
-	return css ? container_of(css, struct task_group, css) : NULL;
-}
-
 static struct cgroup_subsys_state *
 cpu_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a6d073a56c2d..97f6e8a28387 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -452,6 +452,11 @@ static inline int walk_tg_tree(tg_visitor down, tg_visitor up, void *data)
 	return walk_tg_tree_from(&root_task_group, down, up, data);
 }
 
+static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
+{
+	return css ? container_of(css, struct task_group, css) : NULL;
+}
+
 extern int tg_nop(struct task_group *tg, void *data);
 
 extern void free_fair_sched_group(struct task_group *tg);
@@ -2437,6 +2442,8 @@ extern void init_sched_dl_class(void);
 extern void init_sched_rt_class(void);
 extern void init_sched_fair_class(void);
 
+extern void __setscheduler_prio(struct task_struct *p, int prio);
+
 extern void resched_curr(struct rq *rq);
 extern void resched_cpu(int cpu);
 
-- 
2.42.0


