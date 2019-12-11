Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC1A11A166
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2019 03:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfLKCed (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Dec 2019 21:34:33 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53052 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727702AbfLKCec (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 10 Dec 2019 21:34:32 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xBB2YShV004998
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2019 18:34:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=j+BjHCe2bRq9ZY+DgE8lYrK82SbnmfZo+iJzFqjTOYw=;
 b=YJbfmpmq8OoZbmqYFbkUpMZtoKM35TwAmAyd990Immgc8t9D0+646dI44bS7CWdAXKBp
 dVkV2JMl94dsLjknhLAG18yiWwEpurLa/Ph9UNdNPOnlrmXNQZXtR698YjbJxMNpPKGG
 0smEhGdSn7qsHJiUHGHigjX8vC72NKFYvrs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2wtpneg7a7-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2019 18:34:31 -0800
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Dec 2019 18:34:13 -0800
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 195BB3713892; Tue, 10 Dec 2019 18:34:11 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 1/5] bpf: Simplify __cgroup_bpf_attach
Date:   Tue, 10 Dec 2019 18:33:27 -0800
Message-ID: <555e684ef08c2513ce71fc0e36edb2986bb7f7b0.1576031228.git.rdna@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1576031228.git.rdna@fb.com>
References: <cover.1576031228.git.rdna@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_08:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 clxscore=1015 suspectscore=38 phishscore=0 mlxlogscore=817 mlxscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110022
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

__cgroup_bpf_attach has a lot of identical code to handle two scenarios:
BPF_F_ALLOW_MULTI is set and unset.

Simplify it by splitting the two main steps:

* First, the decision is made whether a new bpf_prog_list entry should
  be allocated or existing entry should be reused for the new program.
  This decision is saved in replace_pl pointer;

* Next, replace_pl pointer is used to handle both possible states of
  BPF_F_ALLOW_MULTI flag (set / unset) instead of doing similar work for
  them separately.

This splitting, in turn, allows to make further simplifications:

* The check for attaching same program twice in BPF_F_ALLOW_MULTI mode
  can be done before allocating cgroup storage, so that if user tries to
  attach same program twice no alloc/free happens as it was before;

* pl_was_allocated becomes redundant so it's removed.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 kernel/bpf/cgroup.c | 62 +++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 39 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 9f90d3c92bda..e8cbdd1be687 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -295,9 +295,8 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 	struct bpf_prog *old_prog = NULL;
 	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE],
 		*old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {NULL};
+	struct bpf_prog_list *pl, *replace_pl = NULL;
 	enum bpf_cgroup_storage_type stype;
-	struct bpf_prog_list *pl;
-	bool pl_was_allocated;
 	int err;
 
 	if ((flags & BPF_F_ALLOW_OVERRIDE) && (flags & BPF_F_ALLOW_MULTI))
@@ -317,6 +316,16 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 	if (prog_list_length(progs) >= BPF_CGROUP_MAX_PROGS)
 		return -E2BIG;
 
+	if (flags & BPF_F_ALLOW_MULTI) {
+		list_for_each_entry(pl, progs, node) {
+			if (pl->prog == prog)
+				/* disallow attaching the same prog twice */
+				return -EINVAL;
+		}
+	} else if (!list_empty(progs)) {
+		replace_pl = list_first_entry(progs, typeof(*pl), node);
+	}
+
 	for_each_cgroup_storage_type(stype) {
 		storage[stype] = bpf_cgroup_storage_alloc(prog, stype);
 		if (IS_ERR(storage[stype])) {
@@ -327,52 +336,27 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 		}
 	}
 
-	if (flags & BPF_F_ALLOW_MULTI) {
-		list_for_each_entry(pl, progs, node) {
-			if (pl->prog == prog) {
-				/* disallow attaching the same prog twice */
-				for_each_cgroup_storage_type(stype)
-					bpf_cgroup_storage_free(storage[stype]);
-				return -EINVAL;
-			}
+	if (replace_pl) {
+		pl = replace_pl;
+		old_prog = pl->prog;
+		for_each_cgroup_storage_type(stype) {
+			old_storage[stype] = pl->storage[stype];
+			bpf_cgroup_storage_unlink(old_storage[stype]);
 		}
-
+	} else {
 		pl = kmalloc(sizeof(*pl), GFP_KERNEL);
 		if (!pl) {
 			for_each_cgroup_storage_type(stype)
 				bpf_cgroup_storage_free(storage[stype]);
 			return -ENOMEM;
 		}
-
-		pl_was_allocated = true;
-		pl->prog = prog;
-		for_each_cgroup_storage_type(stype)
-			pl->storage[stype] = storage[stype];
 		list_add_tail(&pl->node, progs);
-	} else {
-		if (list_empty(progs)) {
-			pl = kmalloc(sizeof(*pl), GFP_KERNEL);
-			if (!pl) {
-				for_each_cgroup_storage_type(stype)
-					bpf_cgroup_storage_free(storage[stype]);
-				return -ENOMEM;
-			}
-			pl_was_allocated = true;
-			list_add_tail(&pl->node, progs);
-		} else {
-			pl = list_first_entry(progs, typeof(*pl), node);
-			old_prog = pl->prog;
-			for_each_cgroup_storage_type(stype) {
-				old_storage[stype] = pl->storage[stype];
-				bpf_cgroup_storage_unlink(old_storage[stype]);
-			}
-			pl_was_allocated = false;
-		}
-		pl->prog = prog;
-		for_each_cgroup_storage_type(stype)
-			pl->storage[stype] = storage[stype];
 	}
 
+	pl->prog = prog;
+	for_each_cgroup_storage_type(stype)
+		pl->storage[stype] = storage[stype];
+
 	cgrp->bpf.flags[type] = flags;
 
 	err = update_effective_progs(cgrp, type);
@@ -401,7 +385,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 		pl->storage[stype] = old_storage[stype];
 		bpf_cgroup_storage_link(old_storage[stype], cgrp, type);
 	}
-	if (pl_was_allocated) {
+	if (!replace_pl) {
 		list_del(&pl->node);
 		kfree(pl);
 	}
-- 
2.17.1

