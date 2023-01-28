Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2601467F2DB
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjA1AQ7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjA1AQ6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:16:58 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2507B7A4;
        Fri, 27 Jan 2023 16:16:55 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m11so6171348pji.0;
        Fri, 27 Jan 2023 16:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRDQhCBgwfQ8yY1Xopw2z/Bq7Rk/zYbqVVbUajPCRmc=;
        b=HEyk5w2j6vHmfk6U3e54rbxPo0XdVCGax0gdOXrMmcBFEr7jOeghdI4JZjsBD/fn/9
         0vLWDAJL8v2JVkkB/4Gwdh2xQFq72LArOXYolPZY4vATmx+unpg26DDP0pI2UZKvq4pZ
         KcsQehsz96z9mgjyGi9eUPy7GjNu/l+5JEx236MuzTUw4CRLKRx2HacMvBN5wF3X+nTo
         KIdwQz87pEzvgZmWNpHwzUYcGK4h2kjUPtIlgBHMLMjJ17veWIk7BM15Bfq/v2ARrtyt
         XARx7wl/l80SY1t6sXp95juEPQIMr+n+EA7WWUl4pK6Q2G9kCZeUwXfW7AOzA83JU++l
         1+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NRDQhCBgwfQ8yY1Xopw2z/Bq7Rk/zYbqVVbUajPCRmc=;
        b=p72bLxDtuqnkn+zAMEfDuof39IikDSmHeK0vmWaD1dESOwF5Jq8MfwuhsGyDIO2nKk
         l9PG/iCw11WfQ15QeAVA2/anCz/er+XyL3kVq85QB1h/rpkhK5BvMAWHUNMtgvCYyedH
         XXhOOKTkplz1i3QmhgZRQm1VUtc67XaDDSncKGTIuVX9IIjECUz1MkxLQYVtIMYKxU7l
         t50sIuT/gpsgO2YNWU3ezWq2cVuaNxkNNBMjMU830H1ohgvEOGaL52koVQ54jDmA0Gj5
         hoKcPi/vF8Acynt9UBEtOnfa6iprwCQoBUZcYyMFShVe8aPntcjN5mI/fhdXe333/e/d
         PV8w==
X-Gm-Message-State: AFqh2kqyloJoWCxKZhWV1YXAgRwhpzRi+/LphvmUqP+VYcINpl17/9fl
        RGyQAC/mZz3q+6hKd7xMh0c=
X-Google-Smtp-Source: AMrXdXsIKi0/c3/RChakxDcLuJFeuklhKik4NKkq0YUhv58lgWGV9adQo0XALxAkUUa3eQrkcQDQGQ==
X-Received: by 2002:a17:90b:3b45:b0:22b:b6c5:fa7e with SMTP id ot5-20020a17090b3b4500b0022bb6c5fa7emr29048413pjb.35.1674865014368;
        Fri, 27 Jan 2023 16:16:54 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090a3cc900b0022bee492a5dsm5503602pjd.23.2023.01.27.16.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:16:54 -0800 (PST)
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
Subject: [PATCH 01/30] cgroup: Implement cgroup_show_cftypes()
Date:   Fri, 27 Jan 2023 14:16:10 -1000
Message-Id: <20230128001639.3510083-2-tj@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128001639.3510083-1-tj@kernel.org>
References: <20230128001639.3510083-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
index c099cf3fa02d..27bafb2732c5 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4196,10 +4196,13 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
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
@@ -4478,6 +4481,24 @@ void cgroup_file_notify(struct cgroup_file *cfile)
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
@@ -4487,15 +4508,20 @@ void cgroup_file_show(struct cgroup_file *cfile, bool show)
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
@@ -5509,6 +5535,63 @@ static void offline_css(struct cgroup_subsys_state *css)
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
2.39.1

