Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C468A2D0E0
	for <lists+bpf@lfdr.de>; Tue, 28 May 2019 23:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfE1VOx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 May 2019 17:14:53 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:47362 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfE1VOw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 May 2019 17:14:52 -0400
Received: by mail-yw1-f74.google.com with SMTP id y18so131687ywy.14
        for <bpf@vger.kernel.org>; Tue, 28 May 2019 14:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RjCMpaxFBCIr41uxzEp35fewBQyFMymSFrwG39nzlf8=;
        b=U8EWu9erkzD9tFU0Ey9nWGkyzs2QHjPaxm706hmNEb3KmFuHQTm0KVTZxv9c6IkslW
         BrEfzMisZRGA19EGhaRPtPJVhtYWMRWUAajLwtgRgwmzZYpQz0IFj8ZDUv5wAX/c55ys
         WZszm8AL26Vfmn6hI4Efgw1LnP2iRpEqhHETswy4mYNPv0bS8EOHlfAqXWjkaWoOyw2G
         KVikt7VqHEyRuIdaL1f1FXgMP1prB4zPfqaI9CIxqZR+dgi89Te/nS0fKhexOUgJF4De
         Hls1xzBt4Ot7Xx5WDxl9SKiL9m1sG6X5XNHivtgjrmVduPYUv52DfE0D632WyNOeP9cD
         fLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RjCMpaxFBCIr41uxzEp35fewBQyFMymSFrwG39nzlf8=;
        b=IQu/NYI8ghoI4X1UxUXirDT6AlVFPAgLp4molocOF5vI9xhT0fAZKHQYERWdUMpbSI
         GmtwQzfWiZ2pUlDpYORblJtKy81rKLSvn/FAP6DHXLDWQfqR7krIuX1S+MDMC7m7rKCo
         fjiqoqVPaExZtRLlaLZNJlUg0Gxu5Prq9F5H8x/Ubw6M1ygdPXj4nilDtHcpyuwTde7U
         jjWkEDfZzv+IBr4pxR0HUGtS7pI4iDfVddI3+7qA5L6tSkTB3tBDO+Yv5hSz4G0Hy/00
         vW54rU+9ERqq2k3E0oFFgzatlL9pedZ6GpagyrExzlbkAc9Ic7UNEwI9rDEF9XjLfI38
         +9pA==
X-Gm-Message-State: APjAAAUmPOsDaekm21dc4yNd8S0CJjVHJ/s0/1zHSk2IKIMOBYcargP0
        8i77yNG6FAVneH0SK2NS46+PLeQ=
X-Google-Smtp-Source: APXvYqzp8Jmt4c1k8jC62Lx1xilqGciAz+fL0Q8Lp4A9qPa6rOSxlPsAJ4EgLRN+wlI2QX37+4FoCiw=
X-Received: by 2002:a25:d7d3:: with SMTP id o202mr38391272ybg.235.1559078091565;
 Tue, 28 May 2019 14:14:51 -0700 (PDT)
Date:   Tue, 28 May 2019 14:14:43 -0700
In-Reply-To: <20190528211444.166437-1-sdf@google.com>
Message-Id: <20190528211444.166437-3-sdf@google.com>
Mime-Version: 1.0
References: <20190528211444.166437-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH bpf-next v4 3/4] bpf: cgroup: properly use bpf_prog_array api
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that we don't have __rcu markers on the bpf_prog_array helpers,
let's use proper rcu_dereference_protected to obtain array pointer
under mutex.

We also don't need __rcu annotations on cgroup_bpf.inactive since
it's not read/updated concurrently.

v4:
* drop cgroup_rcu_xyz wrappers and use rcu APIs directly; presumably
  should be more clear to understand which mutex/refcount protects
  each particular place

v3:
* amend cgroup_rcu_dereference to include percpu_ref_is_dying;
  cgroup_bpf is now reference counted and we don't hold cgroup_mutex
  anymore in cgroup_bpf_release

v2:
* replace xchg with rcu_swap_protected

Cc: Roman Gushchin <guro@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf-cgroup.h |  2 +-
 kernel/bpf/cgroup.c        | 28 +++++++++++++++++-----------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 9f100fc422c3..b631ee75762d 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -72,7 +72,7 @@ struct cgroup_bpf {
 	u32 flags[MAX_BPF_ATTACH_TYPE];
 
 	/* temp storage for effective prog array used by prog_attach/detach */
-	struct bpf_prog_array __rcu *inactive;
+	struct bpf_prog_array *inactive;
 
 	/* reference counter used to detach bpf programs after cgroup removal */
 	struct percpu_ref refcnt;
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index d995edbe816d..ff594eb86fd7 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -38,6 +38,7 @@ static void cgroup_bpf_release(struct work_struct *work)
 	struct cgroup *cgrp = container_of(work, struct cgroup,
 					   bpf.release_work);
 	enum bpf_cgroup_storage_type stype;
+	struct bpf_prog_array *old_array;
 	unsigned int type;
 
 	for (type = 0; type < ARRAY_SIZE(cgrp->bpf.progs); type++) {
@@ -54,7 +55,10 @@ static void cgroup_bpf_release(struct work_struct *work)
 			kfree(pl);
 			static_branch_dec(&cgroup_bpf_enabled_key);
 		}
-		bpf_prog_array_free(cgrp->bpf.effective[type]);
+		old_array = rcu_dereference_protected(
+				cgrp->bpf.effective[type],
+				percpu_ref_is_dying(&cgrp->bpf.refcnt));
+		bpf_prog_array_free(old_array);
 	}
 
 	percpu_ref_exit(&cgrp->bpf.refcnt);
@@ -126,7 +130,7 @@ static bool hierarchy_allows_attach(struct cgroup *cgrp,
  */
 static int compute_effective_progs(struct cgroup *cgrp,
 				   enum bpf_attach_type type,
-				   struct bpf_prog_array __rcu **array)
+				   struct bpf_prog_array **array)
 {
 	enum bpf_cgroup_storage_type stype;
 	struct bpf_prog_array *progs;
@@ -164,17 +168,16 @@ static int compute_effective_progs(struct cgroup *cgrp,
 		}
 	} while ((p = cgroup_parent(p)));
 
-	rcu_assign_pointer(*array, progs);
+	*array = progs;
 	return 0;
 }
 
 static void activate_effective_progs(struct cgroup *cgrp,
 				     enum bpf_attach_type type,
-				     struct bpf_prog_array __rcu *array)
+				     struct bpf_prog_array *old_array)
 {
-	struct bpf_prog_array __rcu *old_array;
-
-	old_array = xchg(&cgrp->bpf.effective[type], array);
+	rcu_swap_protected(cgrp->bpf.effective[type], old_array,
+			   lockdep_is_held(&cgroup_mutex));
 	/* free prog array after grace period, since __cgroup_bpf_run_*()
 	 * might be still walking the array
 	 */
@@ -191,7 +194,7 @@ int cgroup_bpf_inherit(struct cgroup *cgrp)
  * that array below is variable length
  */
 #define	NR ARRAY_SIZE(cgrp->bpf.effective)
-	struct bpf_prog_array __rcu *arrays[NR] = {};
+	struct bpf_prog_array *arrays[NR] = {};
 	int ret, i;
 
 	ret = percpu_ref_init(&cgrp->bpf.refcnt, cgroup_bpf_release_fn, 0,
@@ -477,10 +480,14 @@ int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 	enum bpf_attach_type type = attr->query.attach_type;
 	struct list_head *progs = &cgrp->bpf.progs[type];
 	u32 flags = cgrp->bpf.flags[type];
+	struct bpf_prog_array *effective;
 	int cnt, ret = 0, i;
 
+	effective = rcu_dereference_protected(cgrp->bpf.effective[type],
+					      lockdep_is_held(&cgroup_mutex));
+
 	if (attr->query.query_flags & BPF_F_QUERY_EFFECTIVE)
-		cnt = bpf_prog_array_length(cgrp->bpf.effective[type]);
+		cnt = bpf_prog_array_length(effective);
 	else
 		cnt = prog_list_length(progs);
 
@@ -497,8 +504,7 @@ int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 	}
 
 	if (attr->query.query_flags & BPF_F_QUERY_EFFECTIVE) {
-		return bpf_prog_array_copy_to_user(cgrp->bpf.effective[type],
-						   prog_ids, cnt);
+		return bpf_prog_array_copy_to_user(effective, prog_ids, cnt);
 	} else {
 		struct bpf_prog_list *pl;
 		u32 id;
-- 
2.22.0.rc1.257.g3120a18244-goog

