Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD181644F58
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 00:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiLFXKZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 18:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLFXKY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 18:10:24 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9165D42990
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 15:10:23 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2B6LhJTo020790
        for <bpf@vger.kernel.org>; Tue, 6 Dec 2022 15:10:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=6mm73TzkCorKP8T+ZzdSvErGNG0u8UCkXICczBQ+EBk=;
 b=L215kiPHLqcNTmEBeGLTLAZNdqoi7NwEW1wScgApgZ84VsyZNKaIJkuzfhUOU7T+EZSY
 W8IU3FbTzz9XqhH8GDHB233NQgK/gDGrMb0Es4ekWmOyWAX8FXlL/GBRomSlWK1KEIK9
 fLa7ciBwsr8fD95Dn+AVMmBAldVWS+8NFdk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3m9g8cdf9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 15:10:22 -0800
Received: from twshared0551.06.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Dec 2022 15:10:21 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 778C6120B376F; Tue,  6 Dec 2022 15:10:05 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 06/13] bpf: Add bpf_rbtree_{add,remove,first} kfuncs
Date:   Tue, 6 Dec 2022 15:09:53 -0800
Message-ID: <20221206231000.3180914-7-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221206231000.3180914-1-davemarchevsky@fb.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: E1ODOP83ohtx76CVibLloXVIjce7ykKS
X-Proofpoint-ORIG-GUID: E1ODOP83ohtx76CVibLloXVIjce7ykKS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_12,2022-12-06_01,2022-06-22_01
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
			should be released on unlock.

  * bpf_rbtree_remove:  Returns ptr_to_node_type(off=3Drb_node_off) inste=
ad
                        of ptr_to_rb_node(off=3D0). 2nd arg (node) is a
			release_on_unlock + PTR_UNTRUSTED reg.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/helpers.c  | 31 +++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c | 11 +++++++++++
 2 files changed, 42 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4d04432b162e..d216c54b65ab 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1865,6 +1865,33 @@ struct bpf_list_node *bpf_list_pop_back(struct bpf=
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
+	if (WARN_ON_ONCE(RB_EMPTY_NODE(n)))
+		return (struct bpf_rb_node *)NULL;
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
@@ -2069,6 +2096,10 @@ BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | =
KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_task_acquire_not_zero, KF_ACQUIRE | KF_RCU | KF_R=
ET_NULL)
 BTF_ID_FLAGS(func, bpf_task_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RET_=
NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_rbtree_add)
+BTF_ID_FLAGS(func, bpf_rbtree_first, KF_ACQUIRE | KF_RET_NULL)
+
 #ifdef CONFIG_CGROUPS
 BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_cgroup_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RE=
T_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9d9e00fd6dfa..e36dbde8736c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8135,6 +8135,8 @@ BTF_ID_LIST(kf_arg_btf_ids)
 BTF_ID(struct, bpf_dynptr_kern)
 BTF_ID(struct, bpf_list_head)
 BTF_ID(struct, bpf_list_node)
+BTF_ID(struct, bpf_rb_root)
+BTF_ID(struct, bpf_rb_node)
=20
 static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
 				    const struct btf_param *arg, int type)
@@ -8240,6 +8242,9 @@ enum special_kfunc_type {
 	KF_bpf_rdonly_cast,
 	KF_bpf_rcu_read_lock,
 	KF_bpf_rcu_read_unlock,
+	KF_bpf_rbtree_remove,
+	KF_bpf_rbtree_add,
+	KF_bpf_rbtree_first,
 };
=20
 BTF_SET_START(special_kfunc_set)
@@ -8251,6 +8256,9 @@ BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
 BTF_ID(func, bpf_cast_to_kern_ctx)
 BTF_ID(func, bpf_rdonly_cast)
+BTF_ID(func, bpf_rbtree_remove)
+BTF_ID(func, bpf_rbtree_add)
+BTF_ID(func, bpf_rbtree_first)
 BTF_SET_END(special_kfunc_set)
=20
 BTF_ID_LIST(special_kfunc_list)
@@ -8264,6 +8272,9 @@ BTF_ID(func, bpf_cast_to_kern_ctx)
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

