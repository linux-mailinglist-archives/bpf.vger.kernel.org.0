Return-Path: <bpf+bounces-32437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D1F90DE1F
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7284D1C23743
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDB517FAD8;
	Tue, 18 Jun 2024 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZ44VTK6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8CF17966D;
	Tue, 18 Jun 2024 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745672; cv=none; b=ncJb3TNY5aJBwZisyXjuEMN+aSdI6iuhDsuYoT8BvsmoIHCc4DVz0EPbd3Jc4IRdl06mfoy7jDzw7e3MdH7FMT3Ti70/NWVqB6I+OMjNNnSdxV5dBdp2lAqbagotP7d83+vvd7TzDNcy9Q0fUkHdjR1253XcPgvtabNzDwI4hqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745672; c=relaxed/simple;
	bh=umPpc25NZdYIylJd96E+GvddD1Nb9ByAybgHmv5ZXh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYxu5bqY+ZZcjfcD/COojLmaHdvfmMCnBdyW71SkRTnhndTL5qgTFzkH99MhPBtXoyk57/B7Mss0sHmQ2WqRCnFDyM7MLdHXDGGLe5pzw9YR3LkMJnxOK8mm1PrOIwU2Pm97BcrlDLPLUtv92EFeSO9k6fU9pa+G4MgHYr2sY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZ44VTK6; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f6da06ba24so50802525ad.2;
        Tue, 18 Jun 2024 14:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745670; x=1719350470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OcBa2u6P2clOiamiMMDyZqm3Cg+UzFfdqXxfF+woqE=;
        b=LZ44VTK6QctCj2uok94PkqnfWltusdSHpy2Ea4BUyM2KRuHqwVm6KugdkpQpQLLcS6
         7axU5+fcnrmV3+Ffil8agNXbEsVTU8ev9PYwam6sggGkvJBFt6BPGLFyoIhpQDlEQqVQ
         /Ad2atzJw/vV7Xq61DYFGUDRRe5yjAJHHauXhrZ1JSk4o6kFiyUhIAljG4yxdMbId5mA
         H/Be0DmkLrRMuzZBwJRT+5zSs+uL0SZGnmeaTUeEknmyfQz0KuX1JnO7gDKtgxHhDcp0
         h2SeySRS8pNdjlllgnG0J0/JxvZtSZNWS8jqjbpOo7XdUZIX54a/AgbqSdTFGJ0Q29BL
         n8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745670; x=1719350470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3OcBa2u6P2clOiamiMMDyZqm3Cg+UzFfdqXxfF+woqE=;
        b=JikKOtfpt5zMC9ZNqB3qZfMHUakRUiWEGCaHgGLjmU0SN5L0T+69Jxn+a2DK6gkyBh
         JVZVkb0G4fKe3fAVHES7lWyT3GnOplECNnDoDl1sf5L/zwj4pDOj3g+4SEYA9P8wo3ID
         k9WpplA+qwPYAfguPyGImeGYQtxXYbN1V2TdfWLZQZUajDGZtm9d8ckGaKf7cXTYNAMw
         PUS90gU2PzmXGreDNxQlvfV2XAgbglmyUFVZ8kORDloKmU4aZykfimCapq2TY+oYFSG4
         61Q1dsWjfVLH+S2rgYaeIH6htrWmIaUDx3BE8/CryCZDsr5LmSRDAsZt3XJ+PTHuUoFP
         SH3w==
X-Forwarded-Encrypted: i=1; AJvYcCXDwRJ05R8KgAqwNphAoR1ZXWBDeqVpdJvKbtbx2QDje/Q06dOIE9VCMmKZG/gekW4i5VrBI7JV980adOdzr3314F5E
X-Gm-Message-State: AOJu0YzyMIGscy9s61rgHU0xGnpisj6WwLYoK1S3s45HPN8Iqmsw08xx
	31DWJA7l+9hnZjUB02/jK+66A7LYxvr3cgPEn2uqM472Aj7OVJ66
X-Google-Smtp-Source: AGHT+IGnN5DOBltjfEvgUlvr6EVNvwDe/ot4SKM6lsMmz/YJJJWN4bqpm34fJApxcTl3F1jJrRkvFA==
X-Received: by 2002:a17:903:2352:b0:1f6:f9aa:e186 with SMTP id d9443c01a7336-1f9aa470c76mr7717165ad.57.1718745670148;
        Tue, 18 Jun 2024 14:21:10 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855ee8004sm102175815ad.121.2024.06.18.14.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:09 -0700 (PDT)
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
	memxor@gmail.com,
	andrea.righi@canonical.com,
	joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/30] sched: Add sched_class->reweight_task()
Date: Tue, 18 Jun 2024 11:17:18 -1000
Message-ID: <20240618212056.2833381-4-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618212056.2833381-1-tj@kernel.org>
References: <20240618212056.2833381-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, during a task weight change, sched core directly calls
reweight_task() defined in fair.c if @p is on CFS. Let's make it a proper
sched_class operation instead. CFS's reweight_task() is renamed to
reweight_task_fair() and now called through sched_class.

While it turns a direct call into an indirect one, set_load_weight() isn't
called from a hot path and this change shouldn't cause any noticeable
difference. This will be used to implement reweight_task for a new BPF
extensible sched_class so that it can keep its cached task weight
up-to-date.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/core.c  | 4 ++--
 kernel/sched/fair.c  | 3 ++-
 kernel/sched/sched.h | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 095604490c26..48f9d00d0666 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1343,8 +1343,8 @@ void set_load_weight(struct task_struct *p, bool update_load)
 	 * SCHED_OTHER tasks have to update their load when changing their
 	 * weight
 	 */
-	if (update_load && p->sched_class == &fair_sched_class) {
-		reweight_task(p, prio);
+	if (update_load && p->sched_class->reweight_task) {
+		p->sched_class->reweight_task(task_rq(p), p, prio);
 	} else {
 		load->weight = scale_load(sched_prio_to_weight[prio]);
 		load->inv_weight = sched_prio_to_wmult[prio];
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 41b58387023d..18ecd4f908e4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3835,7 +3835,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	}
 }
 
-void reweight_task(struct task_struct *p, int prio)
+static void reweight_task_fair(struct rq *rq, struct task_struct *p, int prio)
 {
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
@@ -13221,6 +13221,7 @@ DEFINE_SCHED_CLASS(fair) = {
 	.task_tick		= task_tick_fair,
 	.task_fork		= task_fork_fair,
 
+	.reweight_task		= reweight_task_fair,
 	.prio_changed		= prio_changed_fair,
 	.switched_from		= switched_from_fair,
 	.switched_to		= switched_to_fair,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 62fd8bc6fd08..a2399ccf259a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2324,6 +2324,8 @@ struct sched_class {
 	 */
 	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
 	void (*switched_to)  (struct rq *this_rq, struct task_struct *task);
+	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
+			      int newprio);
 	void (*prio_changed) (struct rq *this_rq, struct task_struct *task,
 			      int oldprio);
 
@@ -2509,8 +2511,6 @@ extern void init_sched_dl_class(void);
 extern void init_sched_rt_class(void);
 extern void init_sched_fair_class(void);
 
-extern void reweight_task(struct task_struct *p, int prio);
-
 extern void resched_curr(struct rq *rq);
 extern void resched_cpu(int cpu);
 
-- 
2.45.2


