Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7CC641056
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 23:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbiLBWHr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 17:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbiLBWHn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 17:07:43 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D360193E8;
        Fri,  2 Dec 2022 14:07:42 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id fp23so6863212qtb.0;
        Fri, 02 Dec 2022 14:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0veVtjmL6mXLknvIUK78jBH7zQ0IctC8Qa2dmUAgf4=;
        b=WleR2rzN4uyveYskwhMjxiduDbEgmd6wqm+UCxNiKtCcT4zEvO1MhZs408C4NTUkw2
         AfNSC/obHsSPKIyIQ5qMvpnOEt5NBGCuQzcOzc0USC1iNU2zSmJcoupuGffxGrKwzbc+
         lY36hswi/3KC3T5ev91iV8HpLvmJIk4zEQoQjYcKvfZ4JRvbZPq6ImSuMSRAUmNX9JLf
         6zoc9D5xCDQxSqGM0t0tTUkno8+WImanqhZOBOHK/AUZ7mBIs7V1G9qehCZGs5dNOk4v
         jzDZlMn3f0N2YtmPUw3H8JrT0tZ/ioZ6yxHU/W2huxtnW+QsTU5woleBUi6EArQaI+vQ
         Wt2g==
X-Gm-Message-State: ANoB5pnSJQowr+oXnFwGchVi1YGFLoh/jZfDK0zquZKTdB/mwHeNrhwn
        fC1X4Wtkhb8DD/RM/dJsg519wvnGxj23qng4
X-Google-Smtp-Source: AA0mqf5JbZOB1eXBodyOCKcP5A6YkYl68opaUlTFJzZgTYnHUc4nHL3lezgT77FpAGtx08y/bmtSxA==
X-Received: by 2002:ae9:e919:0:b0:6e0:90df:228f with SMTP id x25-20020ae9e919000000b006e090df228fmr47901792qkf.756.1670018861099;
        Fri, 02 Dec 2022 14:07:41 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:6d2e])
        by smtp.gmail.com with ESMTPSA id n16-20020ac86750000000b003a50248b89esm4855689qtp.26.2022.12.02.14.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:07:40 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 2/2] bpf/docs: Document struct cgroup * kfuncs
Date:   Fri,  2 Dec 2022 16:07:36 -0600
Message-Id: <20221202220736.521227-3-void@manifault.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202220736.521227-1-void@manifault.com>
References: <20221202220736.521227-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_cgroup_acquire(), bpf_cgroup_release(), bpf_cgroup_kptr_get(), and
bpf_cgroup_ancestor(), are kfuncs that were recnetly added to
kernel/bpf/helpers.c. These are "core" kfuncs in that they're available
for use in any tracepoint or struct_ops BPF program. Though they have no
ABI stability guarantees, we should still document them. This patch adds
a struct cgroup * subsection to the Core kfuncs section which describes
each of these kfuncs.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/kfuncs.rst | 49 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c         |  2 +-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index b0c35ad6fad4..fd2c8c3b2d52 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -361,3 +361,52 @@ Here is an example of it being used:
 		bpf_task_release(lookup);
 		return 0;
 	}
+
+3.2 struct cgroup * kfuncs
+--------------------------
+
+``struct cgroup *`` objects also have acquire, release, and kptr_get functions:
+
+.. kernel-doc:: kernel/bpf/helpers.c
+   :identifiers: bpf_cgroup_acquire bpf_cgroup_release
+
+.. kernel-doc:: kernel/bpf/helpers.c
+   :identifiers: bpf_cgroup_kptr_get
+
+These kfuncs are used in exactly the same manner as bpf_task_acquire(),
+bpf_task_release(), and bpf_task_kptr_get() respectively, so we won't provide
+examples for them.
+
+Another kfunc available for interacting with ``struct cgroup *`` objects is
+bpf_cgroup_ancestor(). This allows callers to access the ancestor of a cgroup,
+and return it as a cgroup kptr.
+
+.. kernel-doc:: kernel/bpf/helpers.c
+   :identifiers: bpf_cgroup_ancestor
+
+Eventually, BPF should be updated to allow this to happen with a normal memory
+load in the program itself. This is currently not possible without more work in
+the verifier. bpf_cgroup_ancestor() can be used as follows:
+
+.. code-block:: c
+
+	/**
+	 * Simple tracepoint example that illustrates how a cgroup's
+	 * ancestor can be accessed using bpf_cgroup_ancestor().
+	 */
+	SEC("tp_btf/cgroup_mkdir")
+	int BPF_PROG(cgrp_ancestor_example, struct cgroup *cgrp, const char *path)
+	{
+		struct cgroup *parent;
+
+		/* The parent cgroup resides at the level before the current cgroup's level. */
+		parent = bpf_cgroup_ancestor(cgrp, cgrp->level - 1);
+		if (!parent)
+			return -ENOENT;
+
+		bpf_printk("Parent id is %d", parent->self.id);
+
+		/* Return the parent cgroup that was acquired above. */
+		bpf_cgroup_release(parent);
+		return 0;
+	}
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 004afbc14bbf..2a07d216c8f3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1927,7 +1927,7 @@ struct cgroup *bpf_cgroup_kptr_get(struct cgroup **cgrpp)
 }
 
 /**
- * bpf_cgroup_release - Release the reference acquired on a struct cgroup *.
+ * bpf_cgroup_release - Release the reference acquired on a struct cgroup kptr.
  * If this kfunc is invoked in an RCU read region, the cgroup is guaranteed to
  * not be freed until the current grace period has ended, even if its refcount
  * drops to 0.
-- 
2.38.1

