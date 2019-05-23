Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE2F28ADA
	for <lists+bpf@lfdr.de>; Thu, 23 May 2019 21:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbfEWTsl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 May 2019 15:48:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33924 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731685AbfEWTsj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 May 2019 15:48:39 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x4NJiCd5027409
        for <bpf@vger.kernel.org>; Thu, 23 May 2019 12:48:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=5nyWBUY7eHsl4qWlSlVkVSWq1BGJ/cDp1XSF7QS6Mi8=;
 b=pvt0S3X/oS/v4FmYAkBjHJA0Ho89ZNrzayGVtUR/fr9oYSr+NgipSmAzerIdYp5eRRlq
 kAkQXch/Lj5seB7LQBfDApa5SxZ4itANrDQx/3HXo5ywccMws+YkrVHFLvB8xckcCd6Z
 Us7ghS7Y7+/PV73RTHjzAKy8RSm1Ikce+8k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2snv541cu6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 23 May 2019 12:48:38 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 May 2019 12:48:37 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 4D891125B047F; Thu, 23 May 2019 12:45:33 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Alexei Starovoitov <ast@kernel.org>, <bpf@vger.kernel.org>
CC:     Daniel Borkmann <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <cgroups@vger.kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Yonghong Song <yhs@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>, <jolsa@redhat.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 bpf-next 1/4] bpf: decouple the lifetime of cgroup_bpf from cgroup itself
Date:   Thu, 23 May 2019 12:45:29 -0700
Message-ID: <20190523194532.2376233-2-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523194532.2376233-1-guro@fb.com>
References: <20190523194532.2376233-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-23_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=729 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905230128
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently the lifetime of bpf programs attached to a cgroup is bound
to the lifetime of the cgroup itself. It means that if a user
forgets (or intentionally avoids) to detach a bpf program before
removing the cgroup, it will stay attached up to the release of the
cgroup. Since the cgroup can stay in the dying state (the state
between being rmdir()'ed and being released) for a very long time, it
leads to a waste of memory. Also, it blocks a possibility to implement
the memcg-based memory accounting for bpf objects, because a circular
reference dependency will occur. Charged memory pages are pinning the
corresponding memory cgroup, and if the memory cgroup is pinning
the attached bpf program, nothing will be ever released.

A dying cgroup can not contain any processes, so the only chance for
an attached bpf program to be executed is a live socket associated
with the cgroup. So in order to release all bpf data early, let's
count associated sockets using a new percpu refcounter. On cgroup
removal the counter is transitioned to the atomic mode, and as soon
as it reaches 0, all bpf programs are detached.

The reference counter is not socket specific, and can be used for any
other types of programs, which can be executed from a cgroup-bpf hook
outside of the process context, had such a need arise in the future.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: jolsa@redhat.com
Acked-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf-cgroup.h |  8 ++++++--
 include/linux/cgroup.h     | 18 ++++++++++++++++++
 kernel/bpf/cgroup.c        | 25 ++++++++++++++++++++++---
 kernel/cgroup/cgroup.c     | 11 ++++++++---
 4 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index cb3c6b3b89c8..a0945de9ba5f 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -6,6 +6,7 @@
 #include <linux/errno.h>
 #include <linux/jump_label.h>
 #include <linux/percpu.h>
+#include <linux/percpu-refcount.h>
 #include <linux/rbtree.h>
 #include <uapi/linux/bpf.h>
 
@@ -72,10 +73,13 @@ struct cgroup_bpf {
 
 	/* temp storage for effective prog array used by prog_attach/detach */
 	struct bpf_prog_array __rcu *inactive;
+
+	/* reference counter used to detach bpf programs after cgroup removal */
+	struct percpu_ref refcnt;
 };
 
-void cgroup_bpf_put(struct cgroup *cgrp);
 int cgroup_bpf_inherit(struct cgroup *cgrp);
+void cgroup_bpf_offline(struct cgroup *cgrp);
 
 int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 			enum bpf_attach_type type, u32 flags);
@@ -283,8 +287,8 @@ int cgroup_bpf_prog_query(const union bpf_attr *attr,
 
 struct bpf_prog;
 struct cgroup_bpf {};
-static inline void cgroup_bpf_put(struct cgroup *cgrp) {}
 static inline int cgroup_bpf_inherit(struct cgroup *cgrp) { return 0; }
+static inline void cgroup_bpf_offline(struct cgroup *cgrp) {}
 
 static inline int cgroup_bpf_prog_attach(const union bpf_attr *attr,
 					 enum bpf_prog_type ptype,
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index c0077adeea83..49e8facf7c4a 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -924,4 +924,22 @@ static inline bool cgroup_task_frozen(struct task_struct *task)
 
 #endif /* !CONFIG_CGROUPS */
 
+#ifdef CONFIG_CGROUP_BPF
+static inline void cgroup_bpf_get(struct cgroup *cgrp)
+{
+	percpu_ref_get(&cgrp->bpf.refcnt);
+}
+
+static inline void cgroup_bpf_put(struct cgroup *cgrp)
+{
+	percpu_ref_put(&cgrp->bpf.refcnt);
+}
+
+#else /* CONFIG_CGROUP_BPF */
+
+static inline void cgroup_bpf_get(struct cgroup *cgrp) {}
+static inline void cgroup_bpf_put(struct cgroup *cgrp) {}
+
+#endif /* CONFIG_CGROUP_BPF */
+
 #endif /* _LINUX_CGROUP_H */
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index fcde0f7b2585..27d683bec231 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -22,12 +22,20 @@
 DEFINE_STATIC_KEY_FALSE(cgroup_bpf_enabled_key);
 EXPORT_SYMBOL(cgroup_bpf_enabled_key);
 
+void cgroup_bpf_offline(struct cgroup *cgrp)
+{
+	cgroup_get(cgrp);
+	percpu_ref_kill(&cgrp->bpf.refcnt);
+}
+
 /**
- * cgroup_bpf_put() - put references of all bpf programs
+ * cgroup_bpf_release() - put references of all bpf programs and
+ *                        release all cgroup bpf data
  * @cgrp: the cgroup to modify
  */
-void cgroup_bpf_put(struct cgroup *cgrp)
+static void cgroup_bpf_release(struct percpu_ref *ref)
 {
+	struct cgroup *cgrp = container_of(ref, struct cgroup, bpf.refcnt);
 	enum bpf_cgroup_storage_type stype;
 	unsigned int type;
 
@@ -47,6 +55,9 @@ void cgroup_bpf_put(struct cgroup *cgrp)
 		}
 		bpf_prog_array_free(cgrp->bpf.effective[type]);
 	}
+
+	percpu_ref_exit(&cgrp->bpf.refcnt);
+	cgroup_put(cgrp);
 }
 
 /* count number of elements in the list.
@@ -167,7 +178,12 @@ int cgroup_bpf_inherit(struct cgroup *cgrp)
  */
 #define	NR ARRAY_SIZE(cgrp->bpf.effective)
 	struct bpf_prog_array __rcu *arrays[NR] = {};
-	int i;
+	int ret, i;
+
+	ret = percpu_ref_init(&cgrp->bpf.refcnt, cgroup_bpf_release, 0,
+			      GFP_KERNEL);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < NR; i++)
 		INIT_LIST_HEAD(&cgrp->bpf.progs[i]);
@@ -183,6 +199,9 @@ int cgroup_bpf_inherit(struct cgroup *cgrp)
 cleanup:
 	for (i = 0; i < NR; i++)
 		bpf_prog_array_free(arrays[i]);
+
+	percpu_ref_exit(&cgrp->bpf.refcnt);
+
 	return -ENOMEM;
 }
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 217cec4e22c6..ef9cfbfc82a9 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4955,8 +4955,6 @@ static void css_release_work_fn(struct work_struct *work)
 		if (cgrp->kn)
 			RCU_INIT_POINTER(*(void __rcu __force **)&cgrp->kn->priv,
 					 NULL);
-
-		cgroup_bpf_put(cgrp);
 	}
 
 	mutex_unlock(&cgroup_mutex);
@@ -5482,6 +5480,8 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
 
 	cgroup1_check_for_release(parent);
 
+	cgroup_bpf_offline(cgrp);
+
 	/* put the base reference */
 	percpu_ref_kill(&cgrp->self.refcnt);
 
@@ -6221,6 +6221,7 @@ void cgroup_sk_alloc(struct sock_cgroup_data *skcd)
 		 * Don't use cgroup_get_live().
 		 */
 		cgroup_get(sock_cgroup_ptr(skcd));
+		cgroup_bpf_get(sock_cgroup_ptr(skcd));
 		return;
 	}
 
@@ -6232,6 +6233,7 @@ void cgroup_sk_alloc(struct sock_cgroup_data *skcd)
 		cset = task_css_set(current);
 		if (likely(cgroup_tryget(cset->dfl_cgrp))) {
 			skcd->val = (unsigned long)cset->dfl_cgrp;
+			cgroup_bpf_get(cset->dfl_cgrp);
 			break;
 		}
 		cpu_relax();
@@ -6242,7 +6244,10 @@ void cgroup_sk_alloc(struct sock_cgroup_data *skcd)
 
 void cgroup_sk_free(struct sock_cgroup_data *skcd)
 {
-	cgroup_put(sock_cgroup_ptr(skcd));
+	struct cgroup *cgrp = sock_cgroup_ptr(skcd);
+
+	cgroup_bpf_put(cgrp);
+	cgroup_put(cgrp);
 }
 
 #endif	/* CONFIG_SOCK_CGROUP_DATA */
-- 
2.20.1

