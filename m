Return-Path: <bpf+bounces-4663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3C774E315
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF761C20BFB
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 01:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974F5621;
	Tue, 11 Jul 2023 01:14:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616C337E
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 01:14:20 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01127106;
	Mon, 10 Jul 2023 18:14:18 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666e6ecb52dso2819494b3a.2;
        Mon, 10 Jul 2023 18:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038058; x=1691630058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m01QlMbPsmHe+hL9CZfrqpQzRrLlm6KCDzWm4xR0A9c=;
        b=k5ol8NWNvuZBmimlcX1li9+43KDMLpHAgFA5nNZuU/U6u0PxVxmkfpOFv6cfD0eCQn
         3Bzl03TWZqjvw5ZsfDgbTjLmmHWk5Ui4Omx0IlCO6kPXCkcQBa5JZNCls/gXLFd8Kqmh
         8KFH6O8cVQG6bDeY7Jdrg7DU6iUnLoAs3Mn1UTcMNNZ/UORWFU/qaF4dq3/eDPgGjzk5
         9HQRd/0YEiFKod6M/jo+0t3Y0wEePxv4RKUAf+JUjPKcpuhJ1Ax4V6GGi+p0+4z7NyFH
         RlbE8TIvRXYY8Uz9c44I7OLh6ELTuNB9AJ7n/cCC81v9tA62fS7bzEdKAQ2X3W8PtVax
         2+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038058; x=1691630058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m01QlMbPsmHe+hL9CZfrqpQzRrLlm6KCDzWm4xR0A9c=;
        b=Fc86dY6cjdbIeJhsD47Iy1rLxxOMM5Iv9J8EInyrF1kPmuLjoVnqW1MZO9Blb+h+L7
         0/DCQZRTZ1c/TjQumkVnLZHFWz1M5HEyBLEI3CFQD44hHdJ4h6jus/A+jz8v/+oiQn/T
         ZDawvk5d1JCoojFfgvf289nxLT8fUi7TsR86ol8gTd6BKpe+fSi4exOMQurwHhLG23KL
         RlS9LoKG/s+89UY1EoXK2dqBFqF/qhFzKg5cPoo7olBw0SnJtibEa0xC9rLYcq28Hb4I
         aDm7VHMq/n+28rvngZ8NY7O73cVZewXXaW8K3a1i90sY5O0ZiqlRBo+is96b3XoTBwC0
         m9FQ==
X-Gm-Message-State: ABy/qLa/iSUocxyL2wq24G8GH1DlzWZPkib2ctdb2iaq9EfawHjhOWFw
	tV4mQGT/on9EYVioLKwWfl4=
X-Google-Smtp-Source: APBJJlHf9BOtEyoZelKGnLacx0b+VoLE978a9+DoHUGprbhCPpgXPDN9J05bxH0D8Ij7RwP9dTyqZg==
X-Received: by 2002:a05:6a20:3d90:b0:126:9f02:da6f with SMTP id s16-20020a056a203d9000b001269f02da6fmr13480508pzi.14.1689038058124;
        Mon, 10 Jul 2023 18:14:18 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id g16-20020a170902869000b001b54dcd84e2sm491772plo.240.2023.07.10.18.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:14:17 -0700 (PDT)
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
	riel@surriel.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/34] cgroup: Implement cgroup_show_cftypes()
Date: Mon, 10 Jul 2023 15:13:19 -1000
Message-ID: <20230711011412.100319-2-tj@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711011412.100319-1-tj@kernel.org>
References: <20230711011412.100319-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement cgroup_show_cftypes() which shows and hides all cgroup files
associated with the specified set of cgroup file types. CFTYPE_HIDDEN flag
is added so that files can be created hidden from the get-go.

cgroup_show_cftypes() can be used whether the cftypes are added or not. It
also combines with cgroup_show_file() so that a given file is visible iff
both its cftype and cfile are visible.

This will be used by a new sched_class to selectively show and hide CPU
controller interface files depending on whether they're supported.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/cgroup-defs.h |  8 +++
 include/linux/cgroup.h      |  1 +
 kernel/cgroup/cgroup.c      | 97 ++++++++++++++++++++++++++++++++++---
 3 files changed, 99 insertions(+), 7 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 8a0d5466c7be..8af1e7d487cb 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -127,12 +127,18 @@ enum {
 	CFTYPE_WORLD_WRITABLE	= (1 << 4),	/* (DON'T USE FOR NEW FILES) S_IWUGO */
 	CFTYPE_DEBUG		= (1 << 5),	/* create when cgroup_debug */
 
+	CFTYPE_HIDDEN		= (1 << 6),	/* file type hidden, see cgroup_show_cftypes() */
+
 	/* internal flags, do not use outside cgroup core proper */
 	__CFTYPE_ONLY_ON_DFL	= (1 << 16),	/* only on default hierarchy */
 	__CFTYPE_NOT_ON_DFL	= (1 << 17),	/* not on default hierarchy */
 	__CFTYPE_ADDED		= (1 << 18),
 };
 
+enum cfile_flags {
+	CFILE_HIDDEN		= (1 << 0),	/* file instance hidden */
+};
+
 /*
  * cgroup_file is the handle for a file instance created in a cgroup which
  * is used, for example, to generate file changed notifications.  This can
@@ -140,7 +146,9 @@ enum {
  */
 struct cgroup_file {
 	/* do not access any fields from outside cgroup core */
+	struct cftype *cft;
 	struct kernfs_node *kn;
+	unsigned int flags;
 	unsigned long notified_at;
 	struct timer_list notify_timer;
 };
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 885f5395fcd0..5d1e8432d9af 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -115,6 +115,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from);
 int cgroup_add_dfl_cftypes(struct cgroup_subsys *ss, struct cftype *cfts);
 int cgroup_add_legacy_cftypes(struct cgroup_subsys *ss, struct cftype *cfts);
 int cgroup_rm_cftypes(struct cftype *cfts);
+void cgroup_show_cftype(struct cftype *cft, bool show);
 void cgroup_file_notify(struct cgroup_file *cfile);
 void cgroup_file_show(struct cgroup_file *cfile, bool show);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 625d7483951c..bd04bdd5caeb 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4206,10 +4206,13 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 		return ret;
 	}
 
+	kernfs_show(kn, !(cft->flags & CFTYPE_HIDDEN));
+
 	if (cft->file_offset) {
 		struct cgroup_file *cfile = (void *)css + cft->file_offset;
 
 		timer_setup(&cfile->notify_timer, cgroup_file_notify_timer, 0);
+		cfile->cft = cft;
 
 		spin_lock_irq(&cgroup_file_kn_lock);
 		cfile->kn = kn;
@@ -4488,6 +4491,24 @@ void cgroup_file_notify(struct cgroup_file *cfile)
 	spin_unlock_irqrestore(&cgroup_file_kn_lock, flags);
 }
 
+static struct kernfs_node *cfile_kn_get(struct cgroup_file *cfile)
+{
+	struct kernfs_node *kn;
+
+	spin_lock_irq(&cgroup_file_kn_lock);
+	kn = cfile->kn;
+	kernfs_get(kn);
+	spin_unlock_irq(&cgroup_file_kn_lock);
+
+	return kn;
+}
+
+static bool cfile_visible(struct cgroup_file *cfile)
+{
+	return !(cfile->cft->flags & CFTYPE_HIDDEN) &&
+		!(cfile->flags & CFILE_HIDDEN);
+}
+
 /**
  * cgroup_file_show - show or hide a hidden cgroup file
  * @cfile: target cgroup_file obtained by setting cftype->file_offset
@@ -4497,15 +4518,20 @@ void cgroup_file_show(struct cgroup_file *cfile, bool show)
 {
 	struct kernfs_node *kn;
 
-	spin_lock_irq(&cgroup_file_kn_lock);
-	kn = cfile->kn;
-	kernfs_get(kn);
-	spin_unlock_irq(&cgroup_file_kn_lock);
+	mutex_lock(&cgroup_mutex);
 
-	if (kn)
-		kernfs_show(kn, show);
+	if (show)
+		cfile->flags &= ~CFILE_HIDDEN;
+	else
+		cfile->flags |= CFILE_HIDDEN;
 
-	kernfs_put(kn);
+	kn = cfile_kn_get(cfile);
+	if (kn) {
+		kernfs_show(kn, cfile_visible(cfile));
+		kernfs_put(kn);
+	}
+
+	mutex_unlock(&cgroup_mutex);
 }
 
 /**
@@ -5519,6 +5545,63 @@ static void offline_css(struct cgroup_subsys_state *css)
 	wake_up_all(&css->cgroup->offline_waitq);
 }
 
+/**
+ * cgroup_show_cftype - show or hide a cgroup file type
+ * @cft: cftype to show or hide
+ * @show: whether to show or hide
+ *
+ * Sets %CFTYPE_HIDDEN and shows/hides the matching files according to @show.
+ * @cft may or may not be added at the time of this call. After hiding, it's
+ * guaranteed that there are no in-flight operations on the hidden files.
+ */
+void cgroup_show_cftype(struct cftype *cft, bool show)
+{
+	struct cgroup_subsys *ss = cft->ss;
+	struct cgroup *root = ss ? &ss->root->cgrp : &cgrp_dfl_root.cgrp;
+	struct cgroup_subsys_state *css;
+
+	mutex_lock(&cgroup_mutex);
+
+	if (show)
+		cft->flags &= ~CFTYPE_HIDDEN;
+	else
+		cft->flags |= CFTYPE_HIDDEN;
+
+	if (!(cft->flags & __CFTYPE_ADDED))
+		goto out_unlock;
+
+	css_for_each_descendant_pre(css, cgroup_css(root, ss)) {
+		struct cgroup *cgrp = css->cgroup;
+		struct kernfs_node *kn;
+
+		if (!(css->flags & CSS_VISIBLE))
+			continue;
+
+		if (cft->file_offset) {
+			struct cgroup_file *cfile =
+				(void *)css + cft->file_offset;
+
+			kn = cfile_kn_get(cfile);
+			if (kn) {
+				kernfs_show(kn, cfile_visible(cfile));
+				kernfs_put(kn);
+			}
+		} else {
+			char buf[CGROUP_FILE_NAME_MAX];
+
+			kn = kernfs_find_and_get(cgrp->kn,
+					cgroup_file_name(cgrp, cft, buf));
+			if (kn) {
+				kernfs_show(kn, show);
+				kernfs_put(kn);
+			}
+		}
+	}
+
+out_unlock:
+	mutex_unlock(&cgroup_mutex);
+}
+
 /**
  * css_create - create a cgroup_subsys_state
  * @cgrp: the cgroup new css will be associated with
-- 
2.41.0


