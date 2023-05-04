Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3FC6F646C
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 07:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjEDFeO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 01:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjEDFeM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 01:34:12 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680A12120
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 22:34:09 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3440qV82025505
        for <bpf@vger.kernel.org>; Wed, 3 May 2023 22:34:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=sMkWbAkq5YkcH2ZwIaxp411OtvXYjEWVas3ZsCgZ9uk=;
 b=BLokR3fwz6cXDdRKV8aDcpruyp5eHbKXo1Idp3LXwac1mMk/WT4Z0DeOi7LWXt9YPuJY
 Tg5hWlZsilHgQIJcvewScwn+SKeL8A/cKCZQ4Ndxk89T7HrQWomCGmuJI3VsMqvrw7A2
 Royvx5UaBTi8MCBsvaRQFTMWW4go9TpZbv0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qbjd080mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 22:34:08 -0700
Received: from twshared4902.04.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 3 May 2023 22:34:07 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 66F111D7BFC82; Wed,  3 May 2023 22:33:55 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 7/9] selftests/bpf: Add test exercising bpf_refcount_acquire race condition
Date:   Wed, 3 May 2023 22:33:36 -0700
Message-ID: <20230504053338.1778690-8-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230504053338.1778690-1-davemarchevsky@fb.com>
References: <20230504053338.1778690-1-davemarchevsky@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: OXX5ZJlHc9pckDGTSJb9TSU_sPsAyp6X
X-Proofpoint-ORIG-GUID: OXX5ZJlHc9pckDGTSJb9TSU_sPsAyp6X
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_02,2023-05-03_01,2023-02-09_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The selftest added in this patch is the exact scenario described by
Kumar in [0] and fixed by earlier patches in this series. The long
comment added in progs/refcounted_kptr.c restates the use-after-free
scenario.

The added test uses bpf__unsafe_spin_{lock, unlock} to force the
specific problematic interleaving we're interested in testing, and
bpf_refcount_read to confirm refcount incr/decr work as expected.

  [0]: https://lore.kernel.org/bpf/atfviesiidev4hu53hzravmtlau3wdodm2vqs7rd=
7tnwft34e3@xktodqeqevir/

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../bpf/prog_tests/refcounted_kptr.c          | 104 +++++++++++-
 .../selftests/bpf/progs/refcounted_kptr.c     | 158 ++++++++++++++++++
 2 files changed, 261 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c b/too=
ls/testing/selftests/bpf/prog_tests/refcounted_kptr.c
index 2ab23832062d..e7fcc1dd8864 100644
--- a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
-
+#define _GNU_SOURCE
 #include <test_progs.h>
 #include <network_helpers.h>
+#include <pthread.h>
+#include <sched.h>
=20
 #include "refcounted_kptr.skel.h"
 #include "refcounted_kptr_fail.skel.h"
@@ -16,3 +18,103 @@ void test_refcounted_kptr_fail(void)
 {
 	RUN_TESTS(refcounted_kptr_fail);
 }
+
+static void force_cpu(pthread_t thread, int cpunum)
+{
+	cpu_set_t cpuset;
+	int err;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(cpunum, &cpuset);
+	err =3D pthread_setaffinity_np(thread, sizeof(cpuset), &cpuset);
+	if (!ASSERT_OK(err, "pthread_setaffinity_np"))
+		return;
+}
+
+struct refcounted_kptr *skel;
+
+static void *run_unstash_acq_ref(void *unused)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);
+	long ret, unstash_acq_ref_fd;
+	force_cpu(pthread_self(), 1);
+
+	unstash_acq_ref_fd =3D bpf_program__fd(skel->progs.unstash_add_and_acquir=
e_refcount);
+
+	ret =3D bpf_prog_test_run_opts(unstash_acq_ref_fd, &opts);
+	ASSERT_EQ(opts.retval, 0, "unstash_add_and_acquire_refcount retval");
+	ASSERT_EQ(skel->bss->ref_check_3, 2, "ref_check_3");
+	ASSERT_EQ(skel->bss->ref_check_4, 1, "ref_check_4");
+	ASSERT_EQ(skel->bss->ref_check_5, 0, "ref_check_5");
+	pthread_exit((void *)ret);
+}
+
+void test_refcounted_kptr_races(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);
+	int ref_acq_lock_fd, ref_acq_unlock_fd, rem_node_lock_fd;
+	int add_stash_fd, remove_tree_fd;
+	pthread_t thread_id;
+	int ret;
+
+	force_cpu(pthread_self(), 0);
+	skel =3D refcounted_kptr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "refcounted_kptr__open_and_load"))
+		return;
+
+	add_stash_fd =3D bpf_program__fd(skel->progs.add_refcounted_node_to_tree_=
and_stash);
+	remove_tree_fd =3D bpf_program__fd(skel->progs.remove_refcounted_node_fro=
m_tree);
+	ref_acq_lock_fd =3D bpf_program__fd(skel->progs.unsafe_ref_acq_lock);
+	ref_acq_unlock_fd =3D bpf_program__fd(skel->progs.unsafe_ref_acq_unlock);
+	rem_node_lock_fd =3D bpf_program__fd(skel->progs.unsafe_rem_node_lock);
+
+	ret =3D bpf_prog_test_run_opts(rem_node_lock_fd, &opts);
+	if (!ASSERT_OK(ret, "rem_node_lock"))
+		return;
+
+	ret =3D bpf_prog_test_run_opts(ref_acq_lock_fd, &opts);
+	if (!ASSERT_OK(ret, "ref_acq_lock"))
+		return;
+
+	ret =3D bpf_prog_test_run_opts(add_stash_fd, &opts);
+	if (!ASSERT_OK(ret, "add_stash"))
+		return;
+	if (!ASSERT_OK(opts.retval, "add_stash retval"))
+		return;
+
+	ret =3D pthread_create(&thread_id, NULL, &run_unstash_acq_ref, NULL);
+	if (!ASSERT_OK(ret, "pthread_create"))
+		goto cleanup;
+
+	force_cpu(thread_id, 1);
+
+	/* This program will execute before unstash_acq_ref's refcount_acquire, t=
hen
+	 * unstash_acq_ref can proceed after unsafe_unlock
+	 */
+	ret =3D bpf_prog_test_run_opts(remove_tree_fd, &opts);
+	if (!ASSERT_OK(ret, "remove_tree"))
+		goto cleanup;
+
+	ret =3D bpf_prog_test_run_opts(ref_acq_unlock_fd, &opts);
+	if (!ASSERT_OK(ret, "ref_acq_unlock"))
+		goto cleanup;
+
+	ret =3D pthread_join(thread_id, NULL);
+	if (!ASSERT_OK(ret, "pthread_join"))
+		goto cleanup;
+
+	refcounted_kptr__destroy(skel);
+	return;
+cleanup:
+	bpf_prog_test_run_opts(ref_acq_unlock_fd, &opts);
+	refcounted_kptr__destroy(skel);
+	return;
+}
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/te=
sting/selftests/bpf/progs/refcounted_kptr.c
index a3da610b1e6b..2951f45291c1 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -39,9 +39,20 @@ private(A) struct bpf_spin_lock lock;
 private(A) struct bpf_rb_root root __contains(node_data, r);
 private(A) struct bpf_list_head head __contains(node_data, l);
=20
+private(C) struct bpf_spin_lock lock2;
+private(C) struct bpf_rb_root root2 __contains(node_data, r);
+
 private(B) struct bpf_spin_lock alock;
 private(B) struct bpf_rb_root aroot __contains(node_acquire, node);
=20
+private(D) struct bpf_spin_lock ref_acq_lock;
+private(E) struct bpf_spin_lock rem_node_lock;
+
+/* Provided by bpf_testmod */
+extern void bpf__unsafe_spin_lock(void *lock__ign) __ksym;
+extern void bpf__unsafe_spin_unlock(void *lock__ign) __ksym;
+extern volatile int bpf_refcount_read(void *refcount__ign) __ksym;
+
 static bool less(struct bpf_rb_node *node_a, const struct bpf_rb_node *nod=
e_b)
 {
 	struct node_data *a;
@@ -405,4 +416,151 @@ long rbtree_refcounted_node_ref_escapes_owning_input(=
void *ctx)
 	return 0;
 }
=20
+SEC("tc")
+long unsafe_ref_acq_lock(void *ctx)
+{
+	bpf__unsafe_spin_lock(&ref_acq_lock);
+	return 0;
+}
+
+SEC("tc")
+long unsafe_ref_acq_unlock(void *ctx)
+{
+	bpf__unsafe_spin_unlock(&ref_acq_lock);
+	return 0;
+}
+
+SEC("tc")
+long unsafe_rem_node_lock(void *ctx)
+{
+	bpf__unsafe_spin_lock(&rem_node_lock);
+	return 0;
+}
+
+/* The following 3 progs are used in concert to test a bpf_refcount-related
+ * race. Consider the following pseudocode interleaving of rbtree operatio=
ns:
+ *
+ * (Assumptions: n, m, o, p, q are pointers to nodes, t1 and t2 are differ=
ent
+ * rbtrees, l1 and l2 are locks accompanying the trees, mapval is some
+ * kptr_xchg'able ptr_to_map_value. A single node is being manipulated by =
both
+ * programs. Irrelevant error-checking and casting is omitted.)
+ *
+ *               CPU O                               CPU 1
+ *     ----------------------------------|---------------------------
+ *     n =3D bpf_obj_new  [0]              |
+ *     lock(l1)                          |
+ *     bpf_rbtree_add(t1, &n->r, less)   |
+ *     m =3D bpf_refcount_acquire(n)  [1]  |
+ *     unlock(l1)                        |
+ *     kptr_xchg(mapval, m)         [2]  |
+ *     --------------------------------------------------------------
+ *                                       |    o =3D kptr_xchg(mapval, NULL=
)  [3]
+ *                                       |    lock(l2)
+ *                                       |    rbtree_add(t2, &o->r, less) =
 [4]
+ *     --------------------------------------------------------------
+ *     lock(l1)                          |
+ *     p =3D rbtree_first(t1)              |
+ *     p =3D rbtree_remove(t1, p)          |
+ *     unlock(l1)                        |
+ *     if (p)                            |
+ *       bpf_obj_drop(p)  [5]            |
+ *     --------------------------------------------------------------
+ *                                       |    q =3D bpf_refcount_acquire(o=
)  [6]
+ *                                       |    unlock(l2)
+ *
+ * If bpf_refcount_acquire can't fail, the sequence of operations on the n=
ode's
+ * refcount is:
+ *    [0] - refcount initialized to 1
+ *    [1] - refcount bumped to 2
+ *    [2] - refcount is still 2, but m's ownership passed to mapval
+ *    [3] - refcount is still 2, mapval's ownership passed to o
+ *    [4] - refcount is decr'd to 1, rbtree_add fails, node is already in =
t1
+ *          o is converted to non-owning reference
+ *    [5] - refcount is decr'd to 0, node free'd
+ *    [6] - refcount is incr'd to 1 from 0, ERROR
+ *
+ * To prevent [6] bpf_refcount_acquire was made failable. This interleavin=
g is
+ * used to test failable refcount_acquire.
+ *
+ * The two halves of CPU 0's operations are implemented by
+ * add_refcounted_node_to_tree_and_stash and remove_refcounted_node_from_t=
ree.
+ * We can't do the same for CPU 1's operations due to l2 critical section.
+ * Instead, bpf__unsafe_spin_{lock, unlock} are used to ensure the expected
+ * order of operations.
+ */
+
+SEC("tc")
+long add_refcounted_node_to_tree_and_stash(void *ctx)
+{
+	long err;
+
+	err =3D __stash_map_insert_tree(0, 42, &root, &lock);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+SEC("tc")
+long remove_refcounted_node_from_tree(void *ctx)
+{
+	long ret =3D 0;
+
+	/* rem_node_lock is held by another program to force race */
+	bpf__unsafe_spin_lock(&rem_node_lock);
+	ret =3D __read_from_tree(&root, &lock, true);
+	if (ret !=3D 42)
+		return ret;
+
+	bpf__unsafe_spin_unlock(&rem_node_lock);
+	return 0;
+}
+
+/* ref_check_n numbers correspond to refcount operation points in comment =
above */
+int ref_check_3, ref_check_4, ref_check_5;
+
+SEC("tc")
+long unstash_add_and_acquire_refcount(void *ctx)
+{
+	struct map_value *mapval;
+	struct node_data *n, *m;
+	int idx =3D 0;
+
+	mapval =3D bpf_map_lookup_elem(&stashed_nodes, &idx);
+	if (!mapval)
+		return -1;
+
+	n =3D bpf_kptr_xchg(&mapval->node, NULL);
+	if (!n)
+		return -2;
+	ref_check_3 =3D bpf_refcount_read(&n->ref);
+
+	bpf_spin_lock(&lock2);
+	bpf_rbtree_add(&root2, &n->r, less);
+	ref_check_4 =3D bpf_refcount_read(&n->ref);
+
+	/* Let CPU 0 do first->remove->drop */
+	bpf__unsafe_spin_unlock(&rem_node_lock);
+
+	/* ref_acq_lock is held by another program to force race
+	 * when this program holds the lock, remove_refcounted_node_from_tree
+	 * has finished
+	 */
+	bpf__unsafe_spin_lock(&ref_acq_lock);
+	ref_check_5 =3D bpf_refcount_read(&n->ref);
+
+	/* Error-causing use-after-free incr ([6] in long comment above) */
+	m =3D bpf_refcount_acquire(n);
+	bpf__unsafe_spin_unlock(&ref_acq_lock);
+
+	bpf_spin_unlock(&lock2);
+
+	if (m) {
+		bpf_obj_drop(m);
+		return -3;
+	}
+
+	return !!m;
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.34.1

