Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802896BF43E
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 22:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjCQVfw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 17:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjCQVfv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 17:35:51 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548CD4DBF0;
        Fri, 17 Mar 2023 14:35:13 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id bc12so6074285plb.0;
        Fri, 17 Mar 2023 14:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+D2VxsDjgx5RznEN8EkWnubE1j52YbpUkDkSBr+7kQ=;
        b=gFNKLoV1dc2fIFb4muJinOYD2SxBlMJB2XwOtJ9/WcIrD5VXz78iZ58zcVrzBy6NIM
         t0bCMduv5I3N5MxhwRZMNIrW5IfjLXbnxE/Xst3YsOqi8MSNt4C3ZPOZmTpw0hwelGWj
         81Pfuc5785G9GF+v74KCxixsKWMtzjnFu9TeCAXwGDbmgmdNa4/Dm4J2CtFrHfg7Dxrp
         BUigiUKOdQ8Pd/gfGOGKd+/p+J0xgtG4RWBkhLKSdAMSjeDPBi0HckooQT4o8ro12m26
         QeXNRNsBlx0zpRRRb/YWesMIrzt/tWkJj/sfPh9nJ8z5mjHNU/TC83W4eHnJcZ50M//G
         FSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n+D2VxsDjgx5RznEN8EkWnubE1j52YbpUkDkSBr+7kQ=;
        b=Q47rXz1mJmo1TvwM2qlwtQLQEKmhBdLpFIq40DHMoItBq49uH7DtrS85WqBdw6KYCP
         KcvGaZtdbXVKrbqDsyXUDUjk5x7u3tQ593vwAZasAKp5ug0RNNhzO43b0k2hOUEFUpr1
         rfOUJ3Gjl3NzL5BpbOcKqhlNfKAwZ+bFHhGJIwMa4ItgI/Sw47my+kOUuhDj5BA6IsKu
         a3A7nIQJxv92J+hM5ZVjc00Wcm6OWUMshN8H+oGS4ZUknKXCR20R70U/fYUGMnsePl9Q
         Tmy/2ekURrj/eggHhzcfgJig+XjS05DtM0be33KRnevWpQo0elIAlLBJtLEmBD6uRCb5
         FHgw==
X-Gm-Message-State: AO0yUKXUUiIrcW08BH3eZkC2wsDNBp6Sc5SkWgI0RKFaXzrVQG6dl2j/
        xPK0MYHKzo9uQwLvqQ2W/8o=
X-Google-Smtp-Source: AK7set/A2qB++jds/iZG+RqEjX7Dq2ydf3yp6aW33jgUyume0DXf61IzucLf8KIXpCv5ZAixvpv7rA==
X-Received: by 2002:a17:90a:e7cb:b0:23f:4882:f0e5 with SMTP id kb11-20020a17090ae7cb00b0023f4882f0e5mr5588042pjb.5.1679088825134;
        Fri, 17 Mar 2023 14:33:45 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id h3-20020a17090a130300b0023d36aa85fesm5313212pja.40.2023.03.17.14.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:33:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/32] cgroup: Implement cgroup_show_cftypes()
Date:   Fri, 17 Mar 2023 11:33:02 -1000
Message-Id: <20230317213333.2174969-2-tj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317213333.2174969-1-tj@kernel.org>
References: <20230317213333.2174969-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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
index 3410aecffdb4..a8c6982c2c24 100644
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
index 8a5294f4ce72..f762bfb78f4a 100644
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
2.39.2

