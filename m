Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8195964F83A
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 09:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiLQIZk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Dec 2022 03:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiLQIZh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 03:25:37 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B042F67A
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:25:36 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BH5qrba029210
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:25:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=PdraTZfUc4QmkJRAWa+UY8+op0TAfZxi9o6GHSlE0Hc=;
 b=Z5QDCEFERFlnv9/96TtSRLGw3GeFmzv6znmI5gIjaf9Efg+Iyv1sfi9zEpS5Vd441Lx5
 DRT9Z0bzKCeEjmEhZphmixwzrOWQ1VNT2Zwohs4tK/qb6NBYIESJB3vy8QNgMj8D3kDZ
 pkjHXxmXkedqRIMYvJ4H7OQUl9KPL7DflYY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mh6um0mj2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:25:35 -0800
Received: from twshared2003.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 17 Dec 2022 00:25:34 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 5E38812A9E01E; Sat, 17 Dec 2022 00:25:16 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 06/13] bpf: Add bpf_rbtree_{add,remove,first} kfuncs
Date:   Sat, 17 Dec 2022 00:24:59 -0800
Message-ID: <20221217082506.1570898-7-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221217082506.1570898-1-davemarchevsky@fb.com>
References: <20221217082506.1570898-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: f7KDw6JfGhC8D7TgxgOjrLtfwaiQAtWC
X-Proofpoint-GUID: f7KDw6JfGhC8D7TgxgOjrLtfwaiQAtWC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-17_03,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds implementations of bpf_rbtree_{add,remove,first}
and teaches verifier about their BTF_IDs as well as those of
bpf_rb_{root,node}.

All three kfuncs have some nonstandard component to their verification
that needs to be addressed in future patches before programs can
properly use them:

  * bpf_rbtree_add:     Takes 'less' callback, need to verify it

  * bpf_rbtree_first:   Returns ptr_to_node_type(off=3Drb_node_off) inste=
ad
                        of ptr_to_rb_node(off=3D0). Return value ref is
			non-owning.

  * bpf_rbtree_remove:  Returns ptr_to_node_type(off=3Drb_node_off) inste=
ad
                        of ptr_to_rb_node(off=3D0). 2nd arg (node) is a
			non-owning reference.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/helpers.c  | 28 ++++++++++++++++++++++++++++
 kernel/bpf/verifier.c | 11 +++++++++++
 2 files changed, 39 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 30fff015f9a1..de4523c777b7 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1873,6 +1873,30 @@ struct bpf_list_node *bpf_list_pop_back(struct bpf=
_list_head *head)
 	return __bpf_list_del(head, true);
 }
=20
+struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root, struct b=
pf_rb_node *node)
+{
+	struct rb_root_cached *r =3D (struct rb_root_cached *)root;
+	struct rb_node *n =3D (struct rb_node *)node;
+
+	rb_erase_cached(n, r);
+	RB_CLEAR_NODE(n);
+	return (struct bpf_rb_node *)n;
+}
+
+void bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
+		    bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b))
+{
+	rb_add_cached((struct rb_node *)node, (struct rb_root_cached *)root,
+		      (bool (*)(struct rb_node *, const struct rb_node *))less);
+}
+
+struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root)
+{
+	struct rb_root_cached *r =3D (struct rb_root_cached *)root;
+
+	return (struct bpf_rb_node *)rb_first_cached(r);
+}
+
 /**
  * bpf_task_acquire - Acquire a reference to a task. A task acquired by =
this
  * kfunc which is not stored in a map as a kptr, must be released by cal=
ling
@@ -2097,6 +2121,10 @@ BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | =
KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_task_acquire_not_zero, KF_ACQUIRE | KF_RCU | KF_R=
ET_NULL)
 BTF_ID_FLAGS(func, bpf_task_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RET_=
NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE)
+BTF_ID_FLAGS(func, bpf_rbtree_add, KF_RELEASE | KF_RELEASE_NON_OWN)
+BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
+
 #ifdef CONFIG_CGROUPS
 BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_cgroup_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RE=
T_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 89d8d754567b..e90cf0b74571 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8406,6 +8406,8 @@ BTF_ID_LIST(kf_arg_btf_ids)
 BTF_ID(struct, bpf_dynptr_kern)
 BTF_ID(struct, bpf_list_head)
 BTF_ID(struct, bpf_list_node)
+BTF_ID(struct, bpf_rb_root)
+BTF_ID(struct, bpf_rb_node)
=20
 static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
 				    const struct btf_param *arg, int type)
@@ -8511,6 +8513,9 @@ enum special_kfunc_type {
 	KF_bpf_rdonly_cast,
 	KF_bpf_rcu_read_lock,
 	KF_bpf_rcu_read_unlock,
+	KF_bpf_rbtree_remove,
+	KF_bpf_rbtree_add,
+	KF_bpf_rbtree_first,
 };
=20
 BTF_SET_START(special_kfunc_set)
@@ -8522,6 +8527,9 @@ BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
 BTF_ID(func, bpf_cast_to_kern_ctx)
 BTF_ID(func, bpf_rdonly_cast)
+BTF_ID(func, bpf_rbtree_remove)
+BTF_ID(func, bpf_rbtree_add)
+BTF_ID(func, bpf_rbtree_first)
 BTF_SET_END(special_kfunc_set)
=20
 BTF_ID_LIST(special_kfunc_list)
@@ -8535,6 +8543,9 @@ BTF_ID(func, bpf_cast_to_kern_ctx)
 BTF_ID(func, bpf_rdonly_cast)
 BTF_ID(func, bpf_rcu_read_lock)
 BTF_ID(func, bpf_rcu_read_unlock)
+BTF_ID(func, bpf_rbtree_remove)
+BTF_ID(func, bpf_rbtree_add)
+BTF_ID(func, bpf_rbtree_first)
=20
 static bool is_kfunc_bpf_rcu_read_lock(struct bpf_kfunc_call_arg_meta *m=
eta)
 {
--=20
2.30.2

