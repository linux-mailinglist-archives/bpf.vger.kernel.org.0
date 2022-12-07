Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FC36462D7
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 21:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiLGUvJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 15:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiLGUup (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 15:50:45 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E67183240;
        Wed,  7 Dec 2022 12:49:43 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id a16so2014822qtw.10;
        Wed, 07 Dec 2022 12:49:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ozx8HNR3j09lD1WSaVCyEtZyByu8AeZ7MG8IeRe+csc=;
        b=3qjwDcVG+xdzB8LPFy/DEBCWhSsx5+juynE6RFXRCkJp2tNoG93VBgZpSnfy1kEi//
         MIY/U3LHIi6e90ghRKg6R9EnayNrIIZCIE8+iAO0AtgbrKZ6LbhV6Ub26sE2Y0lSLNCs
         k6MYZaQdRp90dTlHQFL6UELq/a+xKAielv9fBrh+C0o/cuOuAYtqhGoXDDf21Nniz6Wb
         UuXhSWb5odQWwQUoRoOV1AJc/9+VAW6KeJt6RiMGdW2g7rbLy4LVdWWv2W6wgWracXdx
         8mM7efGRHgFlI444laGeP1bdN6Vm8e5J1gHDohiGY8k/+dAiXyki3H6EEnnQDUNDNbOX
         cA1A==
X-Gm-Message-State: ANoB5pn3pBOYnKdI6kN3VPcrT/z0vTC4YtBXhJsXT8F078wrT7ndFugf
        5f7T2vRGwmeGJVC2T1ZmXfIQ1eZVrQ3qbfqQ
X-Google-Smtp-Source: AA0mqf5pX4Lpd5WATrmIV5PFb6KJdLt41JuWtmA7RPhnHNQabs8iy8PhF8oW0k3a2Fjgzgku+6NDQw==
X-Received: by 2002:ac8:4788:0:b0:3a5:9191:da4c with SMTP id k8-20020ac84788000000b003a59191da4cmr66457660qtq.540.1670446181749;
        Wed, 07 Dec 2022 12:49:41 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:629d])
        by smtp.gmail.com with ESMTPSA id ga23-20020a05622a591700b003a526675c07sm14219679qtb.52.2022.12.07.12.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:49:41 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next v3 2/2] bpf/docs: Document struct cgroup * kfuncs
Date:   Wed,  7 Dec 2022 14:49:11 -0600
Message-Id: <20221207204911.873646-3-void@manifault.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207204911.873646-1-void@manifault.com>
References: <20221207204911.873646-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_cgroup_acquire(), bpf_cgroup_release(), bpf_cgroup_kptr_get(), and
bpf_cgroup_ancestor(), are kfuncs that were recently added to
kernel/bpf/helpers.c. These are "core" kfuncs in that they're available
for use in any tracepoint or struct_ops BPF program. Though they have no
ABI stability guarantees, we should still document them. This patch adds
a struct cgroup * subsection to the Core kfuncs section which describes
each of these kfuncs.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/kfuncs.rst | 115 +++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c         |   2 +-
 2 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 24ed109afc98..9fd7fb539f85 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -305,3 +305,118 @@ Here is an example of it being used:
 		bpf_task_release(lookup);
 		return 0;
 	}
+
+3.2 struct cgroup * kfuncs
+--------------------------
+
+``struct cgroup *`` objects also have acquire and release functions:
+
+.. kernel-doc:: kernel/bpf/helpers.c
+   :identifiers: bpf_cgroup_acquire bpf_cgroup_release
+
+These kfuncs are used in exactly the same manner as bpf_task_acquire() and
+bpf_task_release() respectively, so we won't provide examples for them.
+
+----
+
+You may also acquire a reference to a ``struct cgroup`` kptr that's already
+stored in a map using bpf_cgroup_kptr_get():
+
+.. kernel-doc:: kernel/bpf/helpers.c
+   :identifiers: bpf_cgroup_kptr_get
+
+Here's an example of how it can be used:
+
+.. code-block:: c
+
+	/* struct containing the struct task_struct kptr which is actually stored in the map. */
+	struct __cgroups_kfunc_map_value {
+		struct cgroup __kptr_ref * cgroup;
+	};
+
+	/* The map containing struct __cgroups_kfunc_map_value entries. */
+	struct {
+		__uint(type, BPF_MAP_TYPE_HASH);
+		__type(key, int);
+		__type(value, struct __cgroups_kfunc_map_value);
+		__uint(max_entries, 1);
+	} __cgroups_kfunc_map SEC(".maps");
+
+	/* ... */
+
+	/**
+	 * A simple example tracepoint program showing how a
+	 * struct cgroup kptr that is stored in a map can
+	 * be acquired using the bpf_cgroup_kptr_get() kfunc.
+	 */
+	 SEC("tp_btf/cgroup_mkdir")
+	 int BPF_PROG(cgroup_kptr_get_example, struct cgroup *cgrp, const char *path)
+	 {
+		struct cgroup *kptr;
+		struct __cgroups_kfunc_map_value *v;
+		s32 id = cgrp->self.id;
+
+		/* Assume a cgroup kptr was previously stored in the map. */
+		v = bpf_map_lookup_elem(&__cgroups_kfunc_map, &id);
+		if (!v)
+			return -ENOENT;
+
+		/* Acquire a reference to the cgroup kptr that's already stored in the map. */
+		kptr = bpf_cgroup_kptr_get(&v->cgroup);
+		if (!kptr)
+			/* If no cgroup was present in the map, it's because
+			 * we're racing with another CPU that removed it with
+			 * bpf_kptr_xchg() between the bpf_map_lookup_elem()
+			 * above, and our call to bpf_cgroup_kptr_get().
+			 * bpf_cgroup_kptr_get() internally safely handles this
+			 * race, and will return NULL if the task is no longer
+			 * present in the map by the time we invoke the kfunc.
+			 */
+			return -EBUSY;
+
+		/* Free the reference we just took above. Note that the
+		 * original struct cgroup kptr is still in the map. It will
+		 * be freed either at a later time if another context deletes
+		 * it from the map, or automatically by the BPF subsystem if
+		 * it's still present when the map is destroyed.
+		 */
+		bpf_cgroup_release(kptr);
+
+		return 0;
+        }
+
+----
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
index 1e4bf466b08f..1478862702fc 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1960,7 +1960,7 @@ struct cgroup *bpf_cgroup_kptr_get(struct cgroup **cgrpp)
 }
 
 /**
- * bpf_cgroup_release - Release the reference acquired on a struct cgroup *.
+ * bpf_cgroup_release - Release the reference acquired on a struct cgroup kptr.
  * If this kfunc is invoked in an RCU read region, the cgroup is guaranteed to
  * not be freed until the current grace period has ended, even if its refcount
  * drops to 0.
-- 
2.38.1

