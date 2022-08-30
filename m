Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DC75A6B3B
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 19:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiH3RvN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 13:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiH3Ruj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 13:50:39 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2762C654
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:47:32 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UG2pTM028613
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:35:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=QjYiXkalxW1LLJ8pZsb13vQbAqc4bBRpNGuIiYuECnc=;
 b=ckPGQPAKVTGcXE6ameuZqM9IQPKc+e13RBlBgAVIwGEYMZhZ3dZg0umv+nmm74qjXWUF
 EiflyIiqv4jvm6n62bzjy0pawrs9chQsdA6GnLpDVRgtlehwHQ7dUI9Yo9ZjWqbeY3SB
 UrFF7H5X1z58zYd1XyB0AVhDLFB1YhGLHDY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9a6j4521-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:35:19 -0700
Received: from twshared8288.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 10:35:18 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 7FBCFCAD07A1; Tue, 30 Aug 2022 10:28:10 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFCv2 PATCH bpf-next 17/18] selftests/bpf: Lock tracking test changes
Date:   Tue, 30 Aug 2022 10:27:58 -0700
Message-ID: <20220830172759.4069786-18-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220830172759.4069786-1-davemarchevsky@fb.com>
References: <20220830172759.4069786-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Y6roqS7oS3IeJvFYsDNV8VP0dFkSCkbv
X-Proofpoint-GUID: Y6roqS7oS3IeJvFYsDNV8VP0dFkSCkbv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch contains test changes corresponding to the functional changes
in "bpf: Verifier tracking of rbtree_spin_lock held". It will be
squashed with other test patches, leaving in this state for RFCv2
feedback.

iter section of rbtree_map.c prog is commented out because iter helpers
will be tossed anyways.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../selftests/bpf/prog_tests/rbtree_map.c     |  2 +-
 .../testing/selftests/bpf/progs/rbtree_map.c  | 16 ++++++++-------
 .../selftests/bpf/progs/rbtree_map_fail.c     | 20 +++++++++----------
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/rbtree_map.c b/tools/=
testing/selftests/bpf/prog_tests/rbtree_map.c
index 17cadcd05ee4..7634a2d93f0b 100644
--- a/tools/testing/selftests/bpf/prog_tests/rbtree_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/rbtree_map.c
@@ -17,7 +17,7 @@ static struct {
 	{"rb_node__field_store", "only read is supported"},
 	{"rb_node__alloc_no_add", "Unreleased reference id=3D2 alloc_insn=3D3"}=
,
 	{"rb_node__two_alloc_one_add", "Unreleased reference id=3D2 alloc_insn=3D=
3"},
-	{"rb_node__remove_no_free", "Unreleased reference id=3D5 alloc_insn=3D2=
8"},
+	{"rb_node__remove_no_free", "Unreleased reference id=3D6 alloc_insn=3D2=
6"},
 	{"rb_tree__add_wrong_type", "rbtree: R2 is of type task_struct but node=
_data is expected"},
 	{"rb_tree__conditional_release_helper_usage",
 		"R2 type=3Dptr_cond_rel_ expected=3Dptr_"},
diff --git a/tools/testing/selftests/bpf/progs/rbtree_map.c b/tools/testi=
ng/selftests/bpf/progs/rbtree_map.c
index 50f29b9a5b82..957672cce82a 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_map.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_map.c
@@ -65,6 +65,7 @@ int check_rbtree(void *ctx)
 	struct node_data *node, *found, *ret;
 	struct node_data popped;
 	struct node_data search;
+	struct bpf_spin_lock *lock;
 	__u32 search2;
=20
 	node =3D bpf_rbtree_alloc_node(&rbtree, sizeof(struct node_data));
@@ -73,7 +74,8 @@ int check_rbtree(void *ctx)
=20
 	node->one =3D calls;
 	node->two =3D 6;
-	bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));
+	lock =3D &rbtree_lock;
+	bpf_rbtree_lock(lock);
=20
 	ret =3D (struct node_data *)bpf_rbtree_add(&rbtree, node, less);
 	if (!ret) {
@@ -81,28 +83,28 @@ int check_rbtree(void *ctx)
 		goto unlock_ret;
 	}
=20
-	bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
+	bpf_rbtree_unlock(lock);
=20
-	bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));
+	bpf_rbtree_lock(lock);
=20
 	search.one =3D calls;
 	found =3D (struct node_data *)bpf_rbtree_find(&rbtree, &search, cmp);
 	if (!found)
 		goto unlock_ret;
=20
-	int node_ct =3D 0;
+	/*int node_ct =3D 0;
 	struct node_data *iter =3D (struct node_data *)bpf_rbtree_first(&rbtree=
);
=20
 	while (iter) {
 		node_ct++;
 		iter =3D (struct node_data *)bpf_rbtree_next(&rbtree, iter);
-	}
+	}*/
=20
 	ret =3D (struct node_data *)bpf_rbtree_remove(&rbtree, found);
 	if (!ret)
 		goto unlock_ret;
=20
-	bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
+	bpf_rbtree_unlock(lock);
=20
 	bpf_rbtree_free_node(&rbtree, ret);
=20
@@ -110,7 +112,7 @@ int check_rbtree(void *ctx)
 	return 0;
=20
 unlock_ret:
-	bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
+	bpf_rbtree_unlock(&rbtree_lock);
 	return 0;
 }
=20
diff --git a/tools/testing/selftests/bpf/progs/rbtree_map_fail.c b/tools/=
testing/selftests/bpf/progs/rbtree_map_fail.c
index ab4002a8211c..779b85294f37 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_map_fail.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_map_fail.c
@@ -61,7 +61,7 @@ int alloc_node__size_too_small(void *ctx)
 		return 0;
 	}
=20
-	bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));
+	bpf_rbtree_lock(&rbtree_lock);
 	/* will never execute, alloc_node should fail */
 	node->one =3D 1;
 	ret =3D bpf_rbtree_add(&rbtree, node, less);
@@ -71,7 +71,7 @@ int alloc_node__size_too_small(void *ctx)
 	}
=20
 unlock_ret:
-	bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
+	bpf_rbtree_unlock(&rbtree_lock);
 	return 0;
 }
=20
@@ -148,7 +148,7 @@ int rb_node__two_alloc_one_add(void *ctx)
 		return 0;
 	node->one =3D 42;
=20
-	bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));
+	bpf_rbtree_lock(&rbtree_lock);
=20
 	ret =3D bpf_rbtree_add(&rbtree, node, less);
 	if (!ret) {
@@ -157,7 +157,7 @@ int rb_node__two_alloc_one_add(void *ctx)
 	}
=20
 unlock_ret:
-	bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
+	bpf_rbtree_unlock(&rbtree_lock);
 	return 0;
 }
=20
@@ -171,7 +171,7 @@ int rb_node__remove_no_free(void *ctx)
 		return 0;
 	node->one =3D 42;
=20
-	bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));
+	bpf_rbtree_lock(&rbtree_lock);
=20
 	ret =3D bpf_rbtree_add(&rbtree, node, less);
 	if (!ret) {
@@ -188,7 +188,7 @@ int rb_node__remove_no_free(void *ctx)
 	 */
=20
 unlock_ret:
-	bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
+	bpf_rbtree_unlock(&rbtree_lock);
 	return 0;
 }
=20
@@ -202,14 +202,14 @@ int rb_tree__add_wrong_type(void *ctx)
=20
 	task =3D bpf_get_current_task_btf();
=20
-	bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));
+	bpf_rbtree_lock(&rbtree_lock);
=20
 	ret =3D bpf_rbtree_add(&rbtree, task, less);
 	/* Verifier should fail at bpf_rbtree_add, so don't bother handling
 	 * failure.
 	 */
=20
-	bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
+	bpf_rbtree_unlock(&rbtree_lock);
 	return 0;
 }
=20
@@ -223,7 +223,7 @@ int rb_tree__conditional_release_helper_usage(void *c=
tx)
 		return 0;
 	node->one =3D 42;
=20
-	bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));
+	bpf_rbtree_lock(&rbtree_lock);
=20
 	ret =3D bpf_rbtree_add(&rbtree, node, less);
 	/* Verifier should fail when trying to use CONDITIONAL_RELEASE
@@ -236,7 +236,7 @@ int rb_tree__conditional_release_helper_usage(void *c=
tx)
 	}
=20
 unlock_ret:
-	bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
+	bpf_rbtree_unlock(&rbtree_lock);
 	return 0;
 }
=20
--=20
2.30.2

