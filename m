Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F1C643798
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 23:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiLEWCV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 17:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiLEWB5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 17:01:57 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9CA2612;
        Mon,  5 Dec 2022 14:01:56 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id fu10so4025453qtb.0;
        Mon, 05 Dec 2022 14:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufEai0X98xSIbsVv1GkGx7mHK14NYcBCVwyl1M7ZF5A=;
        b=MK/ItkuQPb8RLVH7CJVvYOR8KqvNXDTYztejtrxtg4gBuUUDGIiZ6rpbq+GhV0+bcG
         mQ3aOSWyHHHRV/Buhpenug7FTQb/cgS0ZOVeAG4fIWcNoDLz/owUh+/ZhYe8NxjDKlnY
         GBX+hcGyS0KdQPAmkXVBwbKQVDaW5nrURn9045U1D9D9UISRggh2rU3pFLf5aH7AoYq4
         E5koJlZgXt65ZvLeiz/6DDdgavEHfh+Gdya6HDKq4mWtMqQxf3lubqQiY5rImyuo3W8d
         /79hYZDNRn5HDY/uleDvyCJo7pz7tQ2xzMonqfR7QpnQ5vP16S78ohDH+XzMbaU/VngL
         9fbA==
X-Gm-Message-State: ANoB5pmoeycalfeqVL0oqZYTzNqa9CfUk4A6uaDjfYf1GLuhuqFkQ8Kj
        f+4BpJN4xnSNfRbjybUl8MkoPr8hX8gEElVc
X-Google-Smtp-Source: AA0mqf4iYk9DTB78BHYbz1btTx6XFsfTXEBLChBWd1h+ESfc3uHV856UH11JUKxA4Hl+Fy6GUOmLeg==
X-Received: by 2002:a05:622a:581a:b0:3a6:59d5:5ec9 with SMTP id fg26-20020a05622a581a00b003a659d55ec9mr55244611qtb.349.1670277715006;
        Mon, 05 Dec 2022 14:01:55 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:cc23])
        by smtp.gmail.com with ESMTPSA id o6-20020ac85546000000b003a69225c2cdsm8841069qtr.56.2022.12.05.14.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:01:54 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/2] bpf/docs: Document struct cgroup * kfuncs
Date:   Mon,  5 Dec 2022 16:01:44 -0600
Message-Id: <20221205220144.63885-3-void@manifault.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221205220144.63885-1-void@manifault.com>
References: <20221205220144.63885-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
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
index 59bff92f313c..0eadb28a6ee2 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -370,3 +370,52 @@ Here is an example of it being used:
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
index a05880f05a78..bc569fce217f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1940,7 +1940,7 @@ struct cgroup *bpf_cgroup_kptr_get(struct cgroup **cgrpp)
 }
 
 /**
- * bpf_cgroup_release - Release the reference acquired on a struct cgroup *.
+ * bpf_cgroup_release - Release the reference acquired on a struct cgroup kptr.
  * If this kfunc is invoked in an RCU read region, the cgroup is guaranteed to
  * not be freed until the current grace period has ended, even if its refcount
  * drops to 0.
-- 
2.38.1

