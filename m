Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593136E337E
	for <lists+bpf@lfdr.de>; Sat, 15 Apr 2023 22:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjDOUSo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Apr 2023 16:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjDOUSn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Apr 2023 16:18:43 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536163C23
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 13:18:40 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33FCXbC3032196
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 13:18:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=rfzF5+DbYFG9TKW5Vz7c2luVLjAtDDfiHsXzHao0WTo=;
 b=mks6UjREkqHSfmfZFWVSHnndDkGS6gcSZYIFh0DJpidlvQroGw6O7zJnIlJ7FAYoPlgR
 oiRkvTKX1svAgiS0Jl2vQ9LPol2RHKIQFfI+NAIez1UXIHUKkmBe4eRoBnJSk7yLGbNw
 +gyDSLJZcLttuwedVOKrLAdlSiHUhbDLLqI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pysrw9pc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 13:18:39 -0700
Received: from twshared8568.05.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 15 Apr 2023 13:18:37 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 4A9D11C270286; Sat, 15 Apr 2023 13:18:19 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 7/9] bpf: Migrate bpf_rbtree_remove to possibly fail
Date:   Sat, 15 Apr 2023 13:18:09 -0700
Message-ID: <20230415201811.343116-8-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230415201811.343116-1-davemarchevsky@fb.com>
References: <20230415201811.343116-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PJW-QfTVfTE-u5EWDhRm_OxunLmpFNVR
X-Proofpoint-GUID: PJW-QfTVfTE-u5EWDhRm_OxunLmpFNVR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-15_10,2023-04-14_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch modifies bpf_rbtree_remove to account for possible failure
due to the input rb_node already not being in any collection.
The function can now return NULL, and does when the aforementioned
scenario occurs. As before, on successful removal an owning reference to
the removed node is returned.

Adding KF_RET_NULL to bpf_rbtree_remove's kfunc flags - now KF_RET_NULL |
KF_ACQUIRE - provides the desired verifier semantics:

  * retval must be checked for NULL before use
  * if NULL, retval's ref_obj_id is released
  * retval is a "maybe acquired" owning ref, not a non-owning ref,
    so it will live past end of critical section (bpf_spin_unlock), and
    thus can be checked for NULL after the end of the CS

BPF programs must add checks
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

This does change bpf_rbtree_remove's verifier behavior. BPF program
writers will need to add NULL checks to their programs, but the
resulting UX looks natural:

  bpf_spin_lock(&glock);

  n =3D bpf_rbtree_first(&ghead);
  if (!n) { /* ... */}
  res =3D bpf_rbtree_remove(&ghead, &n->node);

  bpf_spin_unlock(&glock);

  if (!res)  /* Newly-added check after this patch */
    return 1;

  n =3D container_of(res, /* ... */);
  /* Do something else with n */
  bpf_obj_drop(n);
  return 0;

The "if (!res)" check above is the only addition necessary for the above
program to pass verification after this patch.

bpf_rbtree_remove no longer clobbers non-owning refs
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

An issue arises when bpf_rbtree_remove fails, though. Consider this
example:

  struct node_data {
    long key;
    struct bpf_list_node l;
    struct bpf_rb_node r;
    struct bpf_refcount ref;
  };

  long failed_sum;

  void bpf_prog()
  {
    struct node_data *n =3D bpf_obj_new(/* ... */);
    struct bpf_rb_node *res;
    n->key =3D 10;

    bpf_spin_lock(&glock);

    bpf_list_push_back(&some_list, &n->l); /* n is now a non-owning ref *=
/
    res =3D bpf_rbtree_remove(&some_tree, &n->r, /* ... */);
    if (!res)
      failed_sum +=3D n->key;  /* not possible */

    bpf_spin_unlock(&glock);
    /* if (res) { do something useful and drop } ... */
  }

The bpf_rbtree_remove in this example will always fail. Similarly to
bpf_spin_unlock, bpf_rbtree_remove is a non-owning reference
invalidation point. The verifier clobbers all non-owning refs after a
bpf_rbtree_remove call, so the "failed_sum +=3D n->key" line will fail
verification, and in fact there's no good way to get information about
the node which failed to add after the invalidation. This patch removes
non-owning reference invalidation from bpf_rbtree_remove to allow the
above usecase to pass verification. The logic for why this is now
possible is as follows:

Before this series, bpf_rbtree_add couldn't fail and thus assumed that
its input, a non-owning reference, was in the tree. But it's easy to
construct an example where two non-owning references pointing to the same
underlying memory are acquired and passed to rbtree_remove one after
another (see rbtree_api_release_aliasing in
selftests/bpf/progs/rbtree_fail.c).

So it was necessary to clobber non-owning refs to prevent this
case and, more generally, to enforce "non-owning ref is definitely
in some collection" invariant. This series removes that invariant and
the failure / runtime checking added in this patch provide a clean way
to deal with the aliasing issue - just fail to remove.

Because the aliasing issue prevented by clobbering non-owning refs is no
longer an issue, this patch removes the invalidate_non_owning_refs
call from verifier handling of bpf_rbtree_remove. Note that
bpf_spin_unlock - the other caller of invalidate_non_owning_refs -
clobbers non-owning refs for a different reason, so its clobbering
behavior remains unchanged.

No BPF program changes are necessary for programs to remain valid as a
result of this clobbering change. A valid program before this patch
passed verification with its non-owning refs having shorter (or equal)
lifetimes due to more aggressive clobbering.

Also, update existing tests to check bpf_rbtree_remove retval for NULL
where necessary, and move rbtree_api_release_aliasing from
progs/rbtree_fail.c to progs/rbtree.c since it's now expected to pass
verification.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/btf.c                              | 21 +----
 kernel/bpf/helpers.c                          |  8 +-
 kernel/bpf/verifier.c                         |  3 -
 .../selftests/bpf/prog_tests/linked_list.c    | 90 ++++++++++++-------
 .../testing/selftests/bpf/prog_tests/rbtree.c | 25 ++++++
 tools/testing/selftests/bpf/progs/rbtree.c    | 74 ++++++++++++++-
 .../testing/selftests/bpf/progs/rbtree_fail.c | 77 ++++++----------
 7 files changed, 191 insertions(+), 107 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 14889fd5ba8e..027f9f8a3551 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3805,25 +3805,8 @@ struct btf_record *btf_parse_fields(const struct b=
tf *btf, const struct btf_type
 		goto end;
 	}
=20
-	/* need collection identity for non-owning refs before allowing this
-	 *
-	 * Consider a node type w/ both list and rb_node fields:
-	 *   struct node {
-	 *     struct bpf_list_node l;
-	 *     struct bpf_rb_node r;
-	 *   }
-	 *
-	 * Used like so:
-	 *   struct node *n =3D bpf_obj_new(....);
-	 *   bpf_list_push_front(&list_head, &n->l);
-	 *   bpf_rbtree_remove(&rb_root, &n->r);
-	 *
-	 * It should not be possible to rbtree_remove the node since it hasn't
-	 * been added to a tree. But push_front converts n to a non-owning
-	 * reference, and rbtree_remove accepts the non-owning reference to
-	 * a type w/ bpf_rb_node field.
-	 */
-	if (btf_record_has_field(rec, BPF_LIST_NODE) &&
+	if (rec->refcount_off < 0 &&
+	    btf_record_has_field(rec, BPF_LIST_NODE) &&
 	    btf_record_has_field(rec, BPF_RB_NODE)) {
 		ret =3D -EINVAL;
 		goto end;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5067f8d46872..1835df333287 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2000,6 +2000,12 @@ __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(=
struct bpf_rb_root *root,
 	struct rb_root_cached *r =3D (struct rb_root_cached *)root;
 	struct rb_node *n =3D (struct rb_node *)node;
=20
+	if (!n->__rb_parent_color)
+		RB_CLEAR_NODE(n);
+
+	if (RB_EMPTY_NODE(n))
+		return NULL;
+
 	rb_erase_cached(n, r);
 	RB_CLEAR_NODE(n);
 	return (struct bpf_rb_node *)n;
@@ -2328,7 +2334,7 @@ BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE |=
 KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE)
+BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_rbtree_add_impl)
 BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 736cb7cec0bd..6a41b69a424e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10922,9 +10922,6 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 			ref_set_non_owning(env, &regs[BPF_REG_0]);
 		}
=20
-		if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_remove])
-			invalidate_non_owning_refs(env);
-
 		if (reg_may_point_to_spin_lock(&regs[BPF_REG_0]) && !regs[BPF_REG_0].i=
d)
 			regs[BPF_REG_0].id =3D ++env->id_gen;
 	} else if (btf_type_is_void(t)) {
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools=
/testing/selftests/bpf/prog_tests/linked_list.c
index 872e4bd500fd..f63309fd0e28 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -266,6 +266,59 @@ static struct btf *init_btf(void)
 	return NULL;
 }
=20
+static void list_and_rb_node_same_struct(bool refcount_field)
+{
+	int bpf_rb_node_btf_id, bpf_refcount_btf_id, foo_btf_id;
+	struct btf *btf;
+	int id, err;
+
+	btf =3D init_btf();
+	if (!ASSERT_OK_PTR(btf, "init_btf"))
+		return;
+
+	bpf_rb_node_btf_id =3D btf__add_struct(btf, "bpf_rb_node", 24);
+	if (!ASSERT_GT(bpf_rb_node_btf_id, 0, "btf__add_struct bpf_rb_node"))
+		return;
+
+	if (refcount_field) {
+		bpf_refcount_btf_id =3D btf__add_struct(btf, "bpf_refcount", 4);
+		if (!ASSERT_GT(bpf_refcount_btf_id, 0, "btf__add_struct bpf_refcount")=
)
+			return;
+	}
+
+	id =3D btf__add_struct(btf, "bar", refcount_field ? 44 : 40);
+	if (!ASSERT_GT(id, 0, "btf__add_struct bar"))
+		return;
+	err =3D btf__add_field(btf, "a", LIST_NODE, 0, 0);
+	if (!ASSERT_OK(err, "btf__add_field bar::a"))
+		return;
+	err =3D btf__add_field(btf, "c", bpf_rb_node_btf_id, 128, 0);
+	if (!ASSERT_OK(err, "btf__add_field bar::c"))
+		return;
+	if (refcount_field) {
+		err =3D btf__add_field(btf, "ref", bpf_refcount_btf_id, 320, 0);
+		if (!ASSERT_OK(err, "btf__add_field bar::ref"))
+			return;
+	}
+
+	foo_btf_id =3D btf__add_struct(btf, "foo", 20);
+	if (!ASSERT_GT(foo_btf_id, 0, "btf__add_struct foo"))
+		return;
+	err =3D btf__add_field(btf, "a", LIST_HEAD, 0, 0);
+	if (!ASSERT_OK(err, "btf__add_field foo::a"))
+		return;
+	err =3D btf__add_field(btf, "b", SPIN_LOCK, 128, 0);
+	if (!ASSERT_OK(err, "btf__add_field foo::b"))
+		return;
+	id =3D btf__add_decl_tag(btf, "contains:bar:a", foo_btf_id, 0);
+	if (!ASSERT_GT(id, 0, "btf__add_decl_tag contains:bar:a"))
+		return;
+
+	err =3D btf__load_into_kernel(btf);
+	ASSERT_EQ(err, refcount_field ? 0 : -EINVAL, "check btf");
+	btf__free(btf);
+}
+
 static void test_btf(void)
 {
 	struct btf *btf =3D NULL;
@@ -717,39 +770,12 @@ static void test_btf(void)
 	}
=20
 	while (test__start_subtest("btf: list_node and rb_node in same struct")=
) {
-		btf =3D init_btf();
-		if (!ASSERT_OK_PTR(btf, "init_btf"))
-			break;
-
-		id =3D btf__add_struct(btf, "bpf_rb_node", 24);
-		if (!ASSERT_EQ(id, 5, "btf__add_struct bpf_rb_node"))
-			break;
-		id =3D btf__add_struct(btf, "bar", 40);
-		if (!ASSERT_EQ(id, 6, "btf__add_struct bar"))
-			break;
-		err =3D btf__add_field(btf, "a", LIST_NODE, 0, 0);
-		if (!ASSERT_OK(err, "btf__add_field bar::a"))
-			break;
-		err =3D btf__add_field(btf, "c", 5, 128, 0);
-		if (!ASSERT_OK(err, "btf__add_field bar::c"))
-			break;
-
-		id =3D btf__add_struct(btf, "foo", 20);
-		if (!ASSERT_EQ(id, 7, "btf__add_struct foo"))
-			break;
-		err =3D btf__add_field(btf, "a", LIST_HEAD, 0, 0);
-		if (!ASSERT_OK(err, "btf__add_field foo::a"))
-			break;
-		err =3D btf__add_field(btf, "b", SPIN_LOCK, 128, 0);
-		if (!ASSERT_OK(err, "btf__add_field foo::b"))
-			break;
-		id =3D btf__add_decl_tag(btf, "contains:bar:a", 7, 0);
-		if (!ASSERT_EQ(id, 8, "btf__add_decl_tag contains:bar:a"))
-			break;
+		list_and_rb_node_same_struct(true);
+		break;
+	}
=20
-		err =3D btf__load_into_kernel(btf);
-		ASSERT_EQ(err, -EINVAL, "check btf");
-		btf__free(btf);
+	while (test__start_subtest("btf: list_node and rb_node in same struct, =
no bpf_refcount")) {
+		list_and_rb_node_same_struct(false);
 		break;
 	}
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/rbtree.c b/tools/test=
ing/selftests/bpf/prog_tests/rbtree.c
index 156fa95c42f6..e9300c96607d 100644
--- a/tools/testing/selftests/bpf/prog_tests/rbtree.c
+++ b/tools/testing/selftests/bpf/prog_tests/rbtree.c
@@ -77,6 +77,29 @@ static void test_rbtree_first_and_remove(void)
 	rbtree__destroy(skel);
 }
=20
+static void test_rbtree_api_release_aliasing(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .data_in =3D &pkt_v4,
+		    .data_size_in =3D sizeof(pkt_v4),
+		    .repeat =3D 1,
+	);
+	struct rbtree *skel;
+	int ret;
+
+	skel =3D rbtree__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "rbtree__open_and_load"))
+		return;
+
+	ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.rbtree_api_r=
elease_aliasing), &opts);
+	ASSERT_OK(ret, "rbtree_api_release_aliasing");
+	ASSERT_OK(opts.retval, "rbtree_api_release_aliasing retval");
+	ASSERT_EQ(skel->data->first_data[0], 42, "rbtree_api_release_aliasing f=
irst rbtree_remove()");
+	ASSERT_EQ(skel->data->first_data[1], -1, "rbtree_api_release_aliasing s=
econd rbtree_remove()");
+
+	rbtree__destroy(skel);
+}
+
 void test_rbtree_success(void)
 {
 	if (test__start_subtest("rbtree_add_nodes"))
@@ -85,6 +108,8 @@ void test_rbtree_success(void)
 		test_rbtree_add_and_remove();
 	if (test__start_subtest("rbtree_first_and_remove"))
 		test_rbtree_first_and_remove();
+	if (test__start_subtest("rbtree_api_release_aliasing"))
+		test_rbtree_api_release_aliasing();
 }
=20
 #define BTF_FAIL_TEST(suffix)									\
diff --git a/tools/testing/selftests/bpf/progs/rbtree.c b/tools/testing/s=
elftests/bpf/progs/rbtree.c
index 4c90aa6abddd..b09f4fffe57c 100644
--- a/tools/testing/selftests/bpf/progs/rbtree.c
+++ b/tools/testing/selftests/bpf/progs/rbtree.c
@@ -93,9 +93,11 @@ long rbtree_add_and_remove(void *ctx)
 	res =3D bpf_rbtree_remove(&groot, &n->node);
 	bpf_spin_unlock(&glock);
=20
+	if (!res)
+		return 1;
+
 	n =3D container_of(res, struct node_data, node);
 	removed_key =3D n->key;
-
 	bpf_obj_drop(n);
=20
 	return 0;
@@ -148,9 +150,11 @@ long rbtree_first_and_remove(void *ctx)
 	res =3D bpf_rbtree_remove(&groot, &o->node);
 	bpf_spin_unlock(&glock);
=20
+	if (!res)
+		return 5;
+
 	o =3D container_of(res, struct node_data, node);
 	removed_key =3D o->key;
-
 	bpf_obj_drop(o);
=20
 	bpf_spin_lock(&glock);
@@ -173,4 +177,70 @@ long rbtree_first_and_remove(void *ctx)
 	return 1;
 }
=20
+SEC("tc")
+long rbtree_api_release_aliasing(void *ctx)
+{
+	struct node_data *n, *m, *o;
+	struct bpf_rb_node *res, *res2;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+	n->key =3D 41;
+	n->data =3D 42;
+
+	bpf_spin_lock(&glock);
+	bpf_rbtree_add(&groot, &n->node, less);
+	bpf_spin_unlock(&glock);
+
+	bpf_spin_lock(&glock);
+
+	/* m and o point to the same node,
+	 * but verifier doesn't know this
+	 */
+	res =3D bpf_rbtree_first(&groot);
+	if (!res)
+		goto err_out;
+	o =3D container_of(res, struct node_data, node);
+
+	res =3D bpf_rbtree_first(&groot);
+	if (!res)
+		goto err_out;
+	m =3D container_of(res, struct node_data, node);
+
+	res =3D bpf_rbtree_remove(&groot, &m->node);
+	/* Retval of previous remove returns an owning reference to m,
+	 * which is the same node non-owning ref o is pointing at.
+	 * We can safely try to remove o as the second rbtree_remove will
+	 * return NULL since the node isn't in a tree.
+	 *
+	 * Previously we relied on the verifier type system + rbtree_remove
+	 * invalidating non-owning refs to ensure that rbtree_remove couldn't
+	 * fail, but now rbtree_remove does runtime checking so we no longer
+	 * invalidate non-owning refs after remove.
+	 */
+	res2 =3D bpf_rbtree_remove(&groot, &o->node);
+
+	bpf_spin_unlock(&glock);
+
+	if (res) {
+		o =3D container_of(res, struct node_data, node);
+		first_data[0] =3D o->data;
+		bpf_obj_drop(o);
+	}
+	if (res2) {
+		/* The second remove fails, so res2 is null and this doesn't
+		 * execute
+		 */
+		m =3D container_of(res2, struct node_data, node);
+		first_data[1] =3D m->data;
+		bpf_obj_drop(m);
+	}
+	return 0;
+
+err_out:
+	bpf_spin_unlock(&glock);
+	return 1;
+}
+
 char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/test=
ing/selftests/bpf/progs/rbtree_fail.c
index 46d7d18a218f..3fecf1c6dfe5 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
@@ -105,7 +105,7 @@ long rbtree_api_remove_unadded_node(void *ctx)
 }
=20
 SEC("?tc")
-__failure __msg("Unreleased reference id=3D2 alloc_insn=3D10")
+__failure __msg("Unreleased reference id=3D3 alloc_insn=3D10")
 long rbtree_api_remove_no_drop(void *ctx)
 {
 	struct bpf_rb_node *res;
@@ -118,11 +118,13 @@ long rbtree_api_remove_no_drop(void *ctx)
=20
 	res =3D bpf_rbtree_remove(&groot, res);
=20
-	n =3D container_of(res, struct node_data, node);
-	__sink(n);
+	if (res) {
+		n =3D container_of(res, struct node_data, node);
+		__sink(n);
+	}
 	bpf_spin_unlock(&glock);
=20
-	/* bpf_obj_drop(n) is missing here */
+	/* if (res) { bpf_obj_drop(n); } is missing here */
 	return 0;
=20
 unlock_err:
@@ -150,35 +152,36 @@ long rbtree_api_add_to_multiple_trees(void *ctx)
 }
=20
 SEC("?tc")
-__failure __msg("rbtree_remove node input must be non-owning ref")
-long rbtree_api_add_release_unlock_escape(void *ctx)
+__failure __msg("dereference of modified ptr_or_null_ ptr R2 off=3D16 di=
sallowed")
+long rbtree_api_use_unchecked_remove_retval(void *ctx)
 {
-	struct node_data *n;
-
-	n =3D bpf_obj_new(typeof(*n));
-	if (!n)
-		return 1;
+	struct bpf_rb_node *res;
=20
 	bpf_spin_lock(&glock);
-	bpf_rbtree_add(&groot, &n->node, less);
+
+	res =3D bpf_rbtree_first(&groot);
+	if (!res)
+		goto err_out;
+	res =3D bpf_rbtree_remove(&groot, res);
+
 	bpf_spin_unlock(&glock);
=20
 	bpf_spin_lock(&glock);
-	/* After add() in previous critical section, n should be
-	 * release_on_unlock and released after previous spin_unlock,
-	 * so should not be possible to use it here
-	 */
-	bpf_rbtree_remove(&groot, &n->node);
+	/* Must check res for NULL before using in rbtree_add below */
+	bpf_rbtree_add(&groot, res, less);
 	bpf_spin_unlock(&glock);
 	return 0;
+
+err_out:
+	bpf_spin_unlock(&glock);
+	return 1;
 }
=20
 SEC("?tc")
 __failure __msg("rbtree_remove node input must be non-owning ref")
-long rbtree_api_release_aliasing(void *ctx)
+long rbtree_api_add_release_unlock_escape(void *ctx)
 {
-	struct node_data *n, *m, *o;
-	struct bpf_rb_node *res;
+	struct node_data *n;
=20
 	n =3D bpf_obj_new(typeof(*n));
 	if (!n)
@@ -189,37 +192,11 @@ long rbtree_api_release_aliasing(void *ctx)
 	bpf_spin_unlock(&glock);
=20
 	bpf_spin_lock(&glock);
-
-	/* m and o point to the same node,
-	 * but verifier doesn't know this
-	 */
-	res =3D bpf_rbtree_first(&groot);
-	if (!res)
-		return 1;
-	o =3D container_of(res, struct node_data, node);
-
-	res =3D bpf_rbtree_first(&groot);
-	if (!res)
-		return 1;
-	m =3D container_of(res, struct node_data, node);
-
-	bpf_rbtree_remove(&groot, &m->node);
-	/* This second remove shouldn't be possible. Retval of previous
-	 * remove returns owning reference to m, which is the same
-	 * node o's non-owning ref is pointing at
-	 *
-	 * In order to preserve property
-	 *   * owning ref must not be in rbtree
-	 *   * non-owning ref must be in rbtree
-	 *
-	 * o's ref must be invalidated after previous remove. Otherwise
-	 * we'd have non-owning ref to node that isn't in rbtree, and
-	 * verifier wouldn't be able to use type system to prevent remove
-	 * of ref that already isn't in any tree. Would have to do runtime
-	 * checks in that case.
+	/* After add() in previous critical section, n should be
+	 * release_on_unlock and released after previous spin_unlock,
+	 * so should not be possible to use it here
 	 */
-	bpf_rbtree_remove(&groot, &o->node);
-
+	bpf_rbtree_remove(&groot, &n->node);
 	bpf_spin_unlock(&glock);
 	return 0;
 }
--=20
2.34.1

