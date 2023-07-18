Return-Path: <bpf+bounces-5163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C488F7576DD
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 10:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B2C281517
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 08:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BD3C157;
	Tue, 18 Jul 2023 08:41:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6652ABE55
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 08:41:51 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16BA10C
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 01:41:49 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I1PZT4000791
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 01:41:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Y3Wg+Px0GnG/bjmqKhLr6j/fe+eRbIw8UpzIx0+oFKc=;
 b=CiacdA5KweePndeU7KAbVA4UveLii+dpVIn9U5PUXWSWS/9BuWpSJ8x4tejYNFuJk8Fc
 rhHY6Y378GfT2fvpVSiHFSooltosMQ/YAX/Tn8cxF7iylmv7gQZ2p0d8wvs5dT+vRgcM
 HXlkNyfKCypg19M875wjNuFD3ymTou/V9D0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rwh29jcv9-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 01:41:49 -0700
Received: from twshared10975.09.ash9.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 01:41:46 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 5AFB1214366C6; Tue, 18 Jul 2023 01:38:24 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH v2 bpf-next 4/6] selftests/bpf: Add rbtree test exercising race which 'owner' field prevents
Date: Tue, 18 Jul 2023 01:38:11 -0700
Message-ID: <20230718083813.3416104-5-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718083813.3416104-1-davemarchevsky@fb.com>
References: <20230718083813.3416104-1-davemarchevsky@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: hqbAjX9XieoHDxo0Zr9PuFWGA5gil2Gt
X-Proofpoint-ORIG-GUID: hqbAjX9XieoHDxo0Zr9PuFWGA5gil2Gt
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds a runnable version of one of the races described by
Kumar in [0]. Specifically, this interleaving:

(rbtree1 and list head protected by lock1, rbtree2 protected by lock2)

Prog A                          Prog B
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
n =3D bpf_obj_new(...)
m =3D bpf_refcount_acquire(n)
kptr_xchg(map, m)

                                m =3D kptr_xchg(map, NULL)
                                lock(lock2)
				bpf_rbtree_add(rbtree2, m->r, less)
				unlock(lock2)

lock(lock1)
bpf_list_push_back(head, n->l)
/* make n non-owning ref */
bpf_rbtree_remove(rbtree1, n->r)
unlock(lock1)

The above interleaving, the node's struct bpf_rb_node *r can be used to
add it to either rbtree1 or rbtree2, which are protected by different
locks. If the node has been added to rbtree2, we should not be allowed
to remove it while holding rbtree1's lock.

Before changes in the previous patch in this series, the rbtree_remove
in the second part of Prog A would succeed as the verifier has no way of
knowing which tree owns a particular node at verification time. The
addition of 'owner' field results in bpf_rbtree_remove correctly
failing.

The test added in this patch splits "Prog A" above into two separate BPF
programs - A1 and A2 - and uses a second mapval + kptr_xchg to pass n
from A1 to A2 similarly to the pass from A1 to B. If the test is run
without the fix applied, the remove will succeed.

Kumar's example had the two programs running on separate CPUs. This
patch doesn't do this as it's not necessary to exercise the broken
behavior / validate fixed behavior.

  [0]: https://lore.kernel.org/bpf/d7hyspcow5wtjcmw4fugdgyp3fwhljwuscp3xyut=
5qnwivyeru@ysdq543otzv2

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/refcounted_kptr.c          | 28 ++++++
 .../selftests/bpf/progs/refcounted_kptr.c     | 94 ++++++++++++++++++-
 2 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c b/too=
ls/testing/selftests/bpf/prog_tests/refcounted_kptr.c
index 2ab23832062d..d6bd5e16e637 100644
--- a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
@@ -16,3 +16,31 @@ void test_refcounted_kptr_fail(void)
 {
 	RUN_TESTS(refcounted_kptr_fail);
 }
+
+void test_refcounted_kptr_wrong_owner(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .data_in =3D &pkt_v4,
+		    .data_size_in =3D sizeof(pkt_v4),
+		    .repeat =3D 1,
+	);
+	struct refcounted_kptr *skel;
+	int ret;
+
+	skel =3D refcounted_kptr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "refcounted_kptr__open_and_load"))
+		return;
+
+	ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.rbtree_wrong_o=
wner_remove_fail_a1), &opts);
+	ASSERT_OK(ret, "rbtree_wrong_owner_remove_fail_a1");
+	ASSERT_OK(opts.retval, "rbtree_wrong_owner_remove_fail_a1 retval");
+
+	ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.rbtree_wrong_o=
wner_remove_fail_b), &opts);
+	ASSERT_OK(ret, "rbtree_wrong_owner_remove_fail_b");
+	ASSERT_OK(opts.retval, "rbtree_wrong_owner_remove_fail_b retval");
+
+	ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.rbtree_wrong_o=
wner_remove_fail_a2), &opts);
+	ASSERT_OK(ret, "rbtree_wrong_owner_remove_fail_a2");
+	ASSERT_OK(opts.retval, "rbtree_wrong_owner_remove_fail_a2 retval");
+	refcounted_kptr__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/te=
sting/selftests/bpf/progs/refcounted_kptr.c
index a3da610b1e6b..c55652fdc63a 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -24,7 +24,7 @@ struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
 	__type(key, int);
 	__type(value, struct map_value);
-	__uint(max_entries, 1);
+	__uint(max_entries, 2);
 } stashed_nodes SEC(".maps");
=20
 struct node_acquire {
@@ -42,6 +42,9 @@ private(A) struct bpf_list_head head __contains(node_data=
, l);
 private(B) struct bpf_spin_lock alock;
 private(B) struct bpf_rb_root aroot __contains(node_acquire, node);
=20
+private(C) struct bpf_spin_lock block;
+private(C) struct bpf_rb_root broot __contains(node_data, r);
+
 static bool less(struct bpf_rb_node *node_a, const struct bpf_rb_node *nod=
e_b)
 {
 	struct node_data *a;
@@ -405,4 +408,93 @@ long rbtree_refcounted_node_ref_escapes_owning_input(v=
oid *ctx)
 	return 0;
 }
=20
+static long __stash_map_empty_xchg(struct node_data *n, int idx)
+{
+	struct map_value *mapval =3D bpf_map_lookup_elem(&stashed_nodes, &idx);
+
+	if (!mapval) {
+		bpf_obj_drop(n);
+		return 1;
+	}
+	n =3D bpf_kptr_xchg(&mapval->node, n);
+	if (n) {
+		bpf_obj_drop(n);
+		return 2;
+	}
+	return 0;
+}
+
+SEC("tc")
+long rbtree_wrong_owner_remove_fail_a1(void *ctx)
+{
+	struct node_data *n, *m;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+	m =3D bpf_refcount_acquire(n);
+
+	if (__stash_map_empty_xchg(n, 0)) {
+		bpf_obj_drop(m);
+		return 2;
+	}
+
+	if (__stash_map_empty_xchg(m, 1))
+		return 3;
+
+	return 0;
+}
+
+SEC("tc")
+long rbtree_wrong_owner_remove_fail_b(void *ctx)
+{
+	struct map_value *mapval;
+	struct node_data *n;
+	int idx =3D 0;
+
+	mapval =3D bpf_map_lookup_elem(&stashed_nodes, &idx);
+	if (!mapval)
+		return 1;
+
+	n =3D bpf_kptr_xchg(&mapval->node, NULL);
+	if (!n)
+		return 2;
+
+	bpf_spin_lock(&block);
+
+	bpf_rbtree_add(&broot, &n->r, less);
+
+	bpf_spin_unlock(&block);
+	return 0;
+}
+
+SEC("tc")
+long rbtree_wrong_owner_remove_fail_a2(void *ctx)
+{
+	struct map_value *mapval;
+	struct bpf_rb_node *res;
+	struct node_data *m;
+	int idx =3D 1;
+
+	mapval =3D bpf_map_lookup_elem(&stashed_nodes, &idx);
+	if (!mapval)
+		return 1;
+
+	m =3D bpf_kptr_xchg(&mapval->node, NULL);
+	if (!m)
+		return 2;
+	bpf_spin_lock(&lock);
+
+	/* make m non-owning ref */
+	bpf_list_push_back(&head, &m->l);
+	res =3D bpf_rbtree_remove(&root, &m->r);
+
+	bpf_spin_unlock(&lock);
+	if (res) {
+		bpf_obj_drop(container_of(res, struct node_data, r));
+		return 3;
+	}
+	return 0;
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


