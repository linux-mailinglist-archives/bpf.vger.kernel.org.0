Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10148125C2D
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 08:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfLSHpU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 02:45:20 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34790 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726303AbfLSHpU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Dec 2019 02:45:20 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xBJ7e9bu005753
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 23:45:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=JeiNrwK3nN609xWf/hZeu91oUmpTSWNq/TZS00HXDL4=;
 b=mwSPjTDYI9qt0aQ1QGaE7PO6+ItDc+73LCzkZCUruR9z5JXeeynmT99sqMTR/anOBmua
 uK7GhVym5pp9LWzmPDsx9nkoeghGKEkGjKuhQ9mnBjkIkbFbiHSYuU7aD0uGUiur7RT0
 pzZ6ObhAWZmP9bW55sgT3VFypWW3xPh8uhU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2wyhy255ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 23:45:18 -0800
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 18 Dec 2019 23:45:16 -0800
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 85EE137138B6; Wed, 18 Dec 2019 23:45:16 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <andriin@fb.com>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v4 bpf-next 3/6] bpf: Support replacing cgroup-bpf program in MULTI mode
Date:   Wed, 18 Dec 2019 23:44:35 -0800
Message-ID: <30cd850044a0057bdfcaaf154b7d2f39850ba813.1576741281.git.rdna@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1576741281.git.rdna@fb.com>
References: <cover.1576741281.git.rdna@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_08:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 suspectscore=38 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912190065
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The common use-case in production is to have multiple cgroup-bpf
programs per attach type that cover multiple use-cases. Such programs
are attached with BPF_F_ALLOW_MULTI and can be maintained by different
people.

Order of programs usually matters, for example imagine two egress
programs: the first one drops packets and the second one counts packets.
If they're swapped the result of counting program will be different.

It brings operational challenges with updating cgroup-bpf program(s)
attached with BPF_F_ALLOW_MULTI since there is no way to replace a
program:

* One way to update is to detach all programs first and then attach the
  new version(s) again in the right order. This introduces an
  interruption in the work a program is doing and may not be acceptable
  (e.g. if it's egress firewall);

* Another way is attach the new version of a program first and only then
  detach the old version. This introduces the time interval when two
  versions of same program are working, what may not be acceptable if a
  program is not idempotent. It also imposes additional burden on
  program developers to make sure that two versions of their program can
  co-exist.

Solve the problem by introducing a "replace" mode in BPF_PROG_ATTACH
command for cgroup-bpf programs being attached with BPF_F_ALLOW_MULTI
flag. This mode is enabled by newly introduced BPF_F_REPLACE attach flag
and bpf_attr.replace_bpf_fd attribute to pass fd of the old program to
replace

That way user can replace any program among those attached with
BPF_F_ALLOW_MULTI flag without the problems described above.

Details of the new API:

* If BPF_F_REPLACE is set but replace_bpf_fd doesn't have valid
  descriptor of BPF program, BPF_PROG_ATTACH will return corresponding
  error (EINVAL or EBADF).

* If replace_bpf_fd has valid descriptor of BPF program but such a
  program is not attached to specified cgroup, BPF_PROG_ATTACH will
  return ENOENT.

BPF_F_REPLACE is introduced to make the user intent clear, since
replace_bpf_fd alone can't be used for this (its default value, 0, is a
valid fd). BPF_F_REPLACE also makes it possible to extend the API in the
future (e.g. add BPF_F_BEFORE and BPF_F_AFTER if needed).

Signed-off-by: Andrey Ignatov <rdna@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf-cgroup.h     |  4 +++-
 include/uapi/linux/bpf.h       | 10 ++++++++++
 kernel/bpf/cgroup.c            | 30 ++++++++++++++++++++++++++----
 kernel/bpf/syscall.c           |  4 ++--
 kernel/cgroup/cgroup.c         |  5 +++--
 tools/include/uapi/linux/bpf.h | 10 ++++++++++
 6 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 169fd25f6bc2..18f6a6da7c3c 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -85,6 +85,7 @@ int cgroup_bpf_inherit(struct cgroup *cgrp);
 void cgroup_bpf_offline(struct cgroup *cgrp);
 
 int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
+			struct bpf_prog *replace_prog,
 			enum bpf_attach_type type, u32 flags);
 int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 			enum bpf_attach_type type);
@@ -93,7 +94,8 @@ int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 
 /* Wrapper for __cgroup_bpf_*() protected by cgroup_mutex */
 int cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
-		      enum bpf_attach_type type, u32 flags);
+		      struct bpf_prog *replace_prog, enum bpf_attach_type type,
+		      u32 flags);
 int cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 		      enum bpf_attach_type type, u32 flags);
 int cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index dbbcf0b02970..7df436da542d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -231,6 +231,11 @@ enum bpf_attach_type {
  * When children program makes decision (like picking TCP CA or sock bind)
  * parent program has a chance to override it.
  *
+ * With BPF_F_ALLOW_MULTI a new program is added to the end of the list of
+ * programs for a cgroup. Though it's possible to replace an old program at
+ * any position by also specifying BPF_F_REPLACE flag and position itself in
+ * replace_bpf_fd attribute. Old program at this position will be released.
+ *
  * A cgroup with MULTI or OVERRIDE flag allows any attach flags in sub-cgroups.
  * A cgroup with NONE doesn't allow any programs in sub-cgroups.
  * Ex1:
@@ -249,6 +254,7 @@ enum bpf_attach_type {
  */
 #define BPF_F_ALLOW_OVERRIDE	(1U << 0)
 #define BPF_F_ALLOW_MULTI	(1U << 1)
+#define BPF_F_REPLACE		(1U << 2)
 
 /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
  * verifier will perform strict alignment checking as if the kernel
@@ -442,6 +448,10 @@ union bpf_attr {
 		__u32		attach_bpf_fd;	/* eBPF program to attach */
 		__u32		attach_type;
 		__u32		attach_flags;
+		__u32		replace_bpf_fd;	/* previously attached eBPF
+						 * program to replace if
+						 * BPF_F_REPLACE is used
+						 */
 	};
 
 	struct { /* anonymous struct used by BPF_PROG_TEST_RUN command */
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 283efe3ce052..45346c79613a 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -282,14 +282,17 @@ static int update_effective_progs(struct cgroup *cgrp,
  *                         propagate the change to descendants
  * @cgrp: The cgroup which descendants to traverse
  * @prog: A program to attach
+ * @replace_prog: Previously attached program to replace if BPF_F_REPLACE is set
  * @type: Type of attach operation
  * @flags: Option flags
  *
  * Must be called with cgroup_mutex held.
  */
 int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
+			struct bpf_prog *replace_prog,
 			enum bpf_attach_type type, u32 flags)
 {
+	u32 saved_flags = (flags & (BPF_F_ALLOW_OVERRIDE | BPF_F_ALLOW_MULTI));
 	struct list_head *progs = &cgrp->bpf.progs[type];
 	struct bpf_prog *old_prog = NULL;
 	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE],
@@ -298,14 +301,15 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 	enum bpf_cgroup_storage_type stype;
 	int err;
 
-	if ((flags & BPF_F_ALLOW_OVERRIDE) && (flags & BPF_F_ALLOW_MULTI))
+	if (((flags & BPF_F_ALLOW_OVERRIDE) && (flags & BPF_F_ALLOW_MULTI)) ||
+	    ((flags & BPF_F_REPLACE) && !(flags & BPF_F_ALLOW_MULTI)))
 		/* invalid combination */
 		return -EINVAL;
 
 	if (!hierarchy_allows_attach(cgrp, type))
 		return -EPERM;
 
-	if (!list_empty(progs) && cgrp->bpf.flags[type] != flags)
+	if (!list_empty(progs) && cgrp->bpf.flags[type] != saved_flags)
 		/* Disallow attaching non-overridable on top
 		 * of existing overridable in this cgroup.
 		 * Disallow attaching multi-prog if overridable or none
@@ -320,7 +324,12 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 			if (pl->prog == prog)
 				/* disallow attaching the same prog twice */
 				return -EINVAL;
+			if (pl->prog == replace_prog)
+				replace_pl = pl;
 		}
+		if ((flags & BPF_F_REPLACE) && !replace_pl)
+			/* prog to replace not found for cgroup */
+			return -ENOENT;
 	} else if (!list_empty(progs)) {
 		replace_pl = list_first_entry(progs, typeof(*pl), node);
 	}
@@ -356,7 +365,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 	for_each_cgroup_storage_type(stype)
 		pl->storage[stype] = storage[stype];
 
-	cgrp->bpf.flags[type] = flags;
+	cgrp->bpf.flags[type] = saved_flags;
 
 	err = update_effective_progs(cgrp, type);
 	if (err)
@@ -522,6 +531,7 @@ int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 int cgroup_bpf_prog_attach(const union bpf_attr *attr,
 			   enum bpf_prog_type ptype, struct bpf_prog *prog)
 {
+	struct bpf_prog *replace_prog = NULL;
 	struct cgroup *cgrp;
 	int ret;
 
@@ -529,8 +539,20 @@ int cgroup_bpf_prog_attach(const union bpf_attr *attr,
 	if (IS_ERR(cgrp))
 		return PTR_ERR(cgrp);
 
-	ret = cgroup_bpf_attach(cgrp, prog, attr->attach_type,
+	if ((attr->attach_flags & BPF_F_ALLOW_MULTI) &&
+	    (attr->attach_flags & BPF_F_REPLACE)) {
+		replace_prog = bpf_prog_get_type(attr->replace_bpf_fd, ptype);
+		if (IS_ERR(replace_prog)) {
+			cgroup_put(cgrp);
+			return PTR_ERR(replace_prog);
+		}
+	}
+
+	ret = cgroup_bpf_attach(cgrp, prog, replace_prog, attr->attach_type,
 				attr->attach_flags);
+
+	if (replace_prog)
+		bpf_prog_put(replace_prog);
 	cgroup_put(cgrp);
 	return ret;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b08c362f4e02..81ee8595dfee 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2073,10 +2073,10 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 	}
 }
 
-#define BPF_PROG_ATTACH_LAST_FIELD attach_flags
+#define BPF_PROG_ATTACH_LAST_FIELD replace_bpf_fd
 
 #define BPF_F_ATTACH_MASK \
-	(BPF_F_ALLOW_OVERRIDE | BPF_F_ALLOW_MULTI)
+	(BPF_F_ALLOW_OVERRIDE | BPF_F_ALLOW_MULTI | BPF_F_REPLACE)
 
 static int bpf_prog_attach(const union bpf_attr *attr)
 {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 735af8f15f95..725365df066d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6288,12 +6288,13 @@ void cgroup_sk_free(struct sock_cgroup_data *skcd)
 
 #ifdef CONFIG_CGROUP_BPF
 int cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
-		      enum bpf_attach_type type, u32 flags)
+		      struct bpf_prog *replace_prog, enum bpf_attach_type type,
+		      u32 flags)
 {
 	int ret;
 
 	mutex_lock(&cgroup_mutex);
-	ret = __cgroup_bpf_attach(cgrp, prog, type, flags);
+	ret = __cgroup_bpf_attach(cgrp, prog, replace_prog, type, flags);
 	mutex_unlock(&cgroup_mutex);
 	return ret;
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index dbbcf0b02970..7df436da542d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -231,6 +231,11 @@ enum bpf_attach_type {
  * When children program makes decision (like picking TCP CA or sock bind)
  * parent program has a chance to override it.
  *
+ * With BPF_F_ALLOW_MULTI a new program is added to the end of the list of
+ * programs for a cgroup. Though it's possible to replace an old program at
+ * any position by also specifying BPF_F_REPLACE flag and position itself in
+ * replace_bpf_fd attribute. Old program at this position will be released.
+ *
  * A cgroup with MULTI or OVERRIDE flag allows any attach flags in sub-cgroups.
  * A cgroup with NONE doesn't allow any programs in sub-cgroups.
  * Ex1:
@@ -249,6 +254,7 @@ enum bpf_attach_type {
  */
 #define BPF_F_ALLOW_OVERRIDE	(1U << 0)
 #define BPF_F_ALLOW_MULTI	(1U << 1)
+#define BPF_F_REPLACE		(1U << 2)
 
 /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
  * verifier will perform strict alignment checking as if the kernel
@@ -442,6 +448,10 @@ union bpf_attr {
 		__u32		attach_bpf_fd;	/* eBPF program to attach */
 		__u32		attach_type;
 		__u32		attach_flags;
+		__u32		replace_bpf_fd;	/* previously attached eBPF
+						 * program to replace if
+						 * BPF_F_REPLACE is used
+						 */
 	};
 
 	struct { /* anonymous struct used by BPF_PROG_TEST_RUN command */
-- 
2.17.1

