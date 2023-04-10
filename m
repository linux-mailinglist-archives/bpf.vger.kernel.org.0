Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CF06DCB51
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 21:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDJTJI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Apr 2023 15:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjDJTJH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 15:09:07 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C8E170B
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:09:04 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AFlxbo013667
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:09:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=pXFKA5ykom3wH/Dy0RtrxMikIuIwH44F8H8jyv0o4Zs=;
 b=Jjr+/L9UbVUTVCdmY0yoeKwHTU9k5I+8fSySOEbZN9+R1ZfYF6BqM2Eg2cXU8s+0cFMf
 E7ljv2hTthLSlWc8rteVhyO1utVabd2l3GOH4h75L629lTW30H7YIoHMBk5M9iWVaeyG
 rJT6R+RchdTtKGQ5fvzsH08abLqJaVXig4U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pu5t22gjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:09:03 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 10 Apr 2023 12:09:03 -0700
Received: from twshared16996.15.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 10 Apr 2023 12:09:03 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 2E6EE1BB3FCE4; Mon, 10 Apr 2023 12:08:43 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 5/9] bpf: Migrate bpf_rbtree_add and bpf_list_push_{front,back} to possibly fail
Date:   Mon, 10 Apr 2023 12:07:49 -0700
Message-ID: <20230410190753.2012798-6-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410190753.2012798-1-davemarchevsky@fb.com>
References: <20230410190753.2012798-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: f11dSL042npRRPL4vi3RxwyL1CnpF77B
X-Proofpoint-GUID: f11dSL042npRRPL4vi3RxwyL1CnpF77B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_14,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Consider this code snippet:

  struct node {
    long key;
    bpf_list_node l;
    bpf_rb_node r;
    bpf_refcount ref;
  }

  int some_bpf_prog(void *ctx)
  {
    struct node *n =3D bpf_obj_new(/*...*/), *m;

    bpf_spin_lock(&glock);

    bpf_rbtree_add(&some_tree, &n->r, /* ... */);
    m =3D bpf_refcount_acquire(n);
    bpf_rbtree_add(&other_tree, &m->r, /* ... */);

    bpf_spin_unlock(&glock);

    /* ... */
  }

After bpf_refcount_acquire, n and m point to the same underlying memory,
and that node's bpf_rb_node field is being used by the some_tree insert,
so overwriting it as a result of the second insert is an error. In order
to properly support refcounted nodes, the rbtree and list insert
functions must be allowed to fail. This patch adds such support.

The kfuncs bpf_rbtree_add, bpf_list_push_{front,back} are modified to
return an int indicating success/failure, with 0 -> success, nonzero ->
failure.

bpf_obj_drop on failure
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Currently the only reason an insert can fail is the example above: the
bpf_{list,rb}_node is already in use. When such a failure occurs, the
insert kfuncs will bpf_obj_drop the input node. This allows the insert
operations to logically fail without changing their verifier owning ref
behavior, namely the unconditional release_reference of the input
owning ref.

With insert that always succeeds, ownership of the node is always passed
to the collection, since the node always ends up in the collection.

With a possibly-failed insert w/ bpf_obj_drop, ownership of the node
is always passed either to the collection (success), or to bpf_obj_drop
(failure). Regardless, it's correct to continue unconditionally
releasing the input owning ref, as something is always taking ownership
from the calling program on insert.

Keeping owning ref behavior unchanged results in a nice default UX for
insert functions that can fail. If the program's reaction to a failed
insert is "fine, just get rid of this owning ref for me and let me go
on with my business", then there's no reason to check for failure since
that's default behavior. e.g.:

  long important_failures =3D 0;

  int some_bpf_prog(void *ctx)
  {
    struct node *n, *m, *o; /* all bpf_obj_new'd */

    bpf_spin_lock(&glock);
    bpf_rbtree_add(&some_tree, &n->node, /* ... */);
    bpf_rbtree_add(&some_tree, &m->node, /* ... */);
    if (bpf_rbtree_add(&some_tree, &o->node, /* ... */)) {
      important_failures++;
    }
    bpf_spin_unlock(&glock);
  }

If we instead chose to pass ownership back to the program on failed
insert - by returning NULL on success or an owning ref on failure -
programs would always have to do something with the returned ref on
failure. The most likely action is probably "I'll just get rid of this
owning ref and go about my business", which ideally would look like:

  if (n =3D bpf_rbtree_add(&some_tree, &n->node, /* ... */))
    bpf_obj_drop(n);

But bpf_obj_drop isn't allowed in a critical section and inserts must
occur within one, so in reality error handling would become a
hard-to-parse mess.

For refcounted nodes, we can replicate the "pass ownership back to
program on failure" logic with this patch's semantics, albeit in an ugly
way:

  struct node *n =3D bpf_obj_new(/* ... */), *m;

  bpf_spin_lock(&glock);

  m =3D bpf_refcount_acquire(n);
  if (bpf_rbtree_add(&some_tree, &n->node, /* ... */)) {
    /* Do something with m */
  }

  bpf_spin_unlock(&glock);
  bpf_obj_drop(m);

bpf_refcount_acquire is used to simulate "return owning ref on failure".
This should be an uncommon occurrence, though.

Addition of two verifier-fixup'd args to collection inserts
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

The actual bpf_obj_drop kfunc is
bpf_obj_drop_impl(void *, struct btf_struct_meta *), with bpf_obj_drop
macro populating the second arg with 0 and the verifier later filling in
the arg during insn fixup.

Because bpf_rbtree_add and bpf_list_push_{front,back} now might do
bpf_obj_drop, these kfuncs need a btf_struct_meta parameter that can be
passed to bpf_obj_drop_impl.

Similarly, because the 'node' param to those insert functions is the
bpf_{list,rb}_node within the node type, and bpf_obj_drop expects a
pointer to the beginning of the node, the insert functions need to be
able to find the beginning of the node struct. A second
verifier-populated param is necessary: the offset of {list,rb}_node withi=
n the
node type.

These two new params allow the insert kfuncs to correctly call
__bpf_obj_drop_impl:

  beginning_of_node =3D bpf_rb_node_ptr - offset
  if (already_inserted)
    __bpf_obj_drop_impl(beginning_of_node, btf_struct_meta->record);

Similarly to other kfuncs with "hidden" verifier-populated params, the
insert functions are renamed with _impl prefix and a macro is provided
for common usage. For example, bpf_rbtree_add kfunc is now
bpf_rbtree_add_impl and bpf_rbtree_add is now a macro which sets
"hidden" args to 0.

Due to the two new args BPF progs will need to be recompiled to work
with the new _impl kfuncs.

This patch also rewrites the "hidden argument" explanation to more
directly say why the BPF program writer doesn't need to populate the
arguments with anything meaningful.

How does this new logic affect non-owning references?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

Currently, non-owning refs are valid until the end of the critical
section in which they're created. We can make this guarantee because, if
a non-owning ref exists, the referent was added to some collection. The
collection will drop() its nodes when it goes away, but it can't go away
while our program is accessing it, so that's not a problem. If the
referent is removed from the collection in the same CS that it was added
in, it can't be bpf_obj_drop'd until after CS end. Those are the only
two ways to free the referent's memory and neither can happen until
after the non-owning ref's lifetime ends.

On first glance, having these collection insert functions potentially
bpf_obj_drop their input seems like it breaks the "can't be
bpf_obj_drop'd until after CS end" line of reasoning. But we care about
the memory not being _freed_ until end of CS end, and a previous patch
in the series modified bpf_obj_drop such that it doesn't free refcounted
nodes until refcount =3D=3D 0. So the statement can be more accurately
rewritten as "can't be free'd until after CS end".

We can prove that this rewritten statement holds for any non-owning
reference produced by collection insert functions:

* If the input to the insert function is _not_ refcounted
  * We have an owning reference to the input, and can conclude it isn't
    in any collection
    * Inserting a node in a collection turns owning refs into
      non-owning, and since our input type isn't refcounted, there's no
      way to obtain additional owning refs to the same underlying
      memory
  * Because our node isn't in any collection, the insert operation
    cannot fail, so bpf_obj_drop will not execute
  * If bpf_obj_drop is guaranteed not to execute, there's no risk of
    memory being free'd

* Otherwise, the input to the insert function is refcounted
  * If the insert operation fails due to the node's list_head or rb_root
    already being in some collection, there was some previous successful
    insert which passed refcount to the collection
  * We have an owning reference to the input, it must have been
    acquired via bpf_refcount_acquire, which bumped the refcount
  * refcount must be >=3D 2 since there's a valid owning reference and th=
e
    node is already in a collection
  * Insert triggering bpf_obj_drop will decr refcount to >=3D 1, never
    resulting in a free

So although we may do bpf_obj_drop during the critical section, this
will never result in memory being free'd, and no changes to non-owning
ref logic are needed in this patch.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf_verifier.h                  |  7 +-
 kernel/bpf/helpers.c                          | 65 +++++++++++-----
 kernel/bpf/verifier.c                         | 76 +++++++++++++------
 .../testing/selftests/bpf/bpf_experimental.h  | 49 +++++++++---
 4 files changed, 147 insertions(+), 50 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 81d525d057c7..fbad5bcc9d2f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -464,7 +464,12 @@ struct bpf_insn_aux_data {
 		 */
 		struct bpf_loop_inline_state loop_inline_state;
 	};
-	u64 obj_new_size; /* remember the size of type passed to bpf_obj_new to=
 rewrite R1 */
+	union {
+		/* remember the size of type passed to bpf_obj_new to rewrite R1 */
+		u64 obj_new_size;
+		/* remember the offset of node field within type to rewrite */
+		u64 insert_off;
+	};
 	struct btf_struct_meta *kptr_struct_meta;
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b752068cead5..3f4ca3407961 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1931,7 +1931,8 @@ __bpf_kfunc void *bpf_refcount_acquire_impl(void *p=
__refcounted_kptr, void *meta
 	return (void *)p__refcounted_kptr;
 }
=20
-static void __bpf_list_add(struct bpf_list_node *node, struct bpf_list_h=
ead *head, bool tail)
+static int __bpf_list_add(struct bpf_list_node *node, struct bpf_list_he=
ad *head,
+			  bool tail, struct btf_record *rec, u64 off)
 {
 	struct list_head *n =3D (void *)node, *h =3D (void *)head;
=20
@@ -1939,17 +1940,35 @@ static void __bpf_list_add(struct bpf_list_node *=
node, struct bpf_list_head *hea
 		INIT_LIST_HEAD(h);
 	if (unlikely(!n->next))
 		INIT_LIST_HEAD(n);
+	if (!list_empty(n)) {
+		/* Only called from BPF prog, no need to migrate_disable */
+		__bpf_obj_drop_impl(n - off, rec);
+		return -EINVAL;
+	}
+
 	tail ? list_add_tail(n, h) : list_add(n, h);
+
+	return 0;
 }
=20
-__bpf_kfunc void bpf_list_push_front(struct bpf_list_head *head, struct =
bpf_list_node *node)
+__bpf_kfunc int bpf_list_push_front_impl(struct bpf_list_head *head,
+					 struct bpf_list_node *node,
+					 void *meta__ign, u64 off)
 {
-	return __bpf_list_add(node, head, false);
+	struct btf_struct_meta *meta =3D meta__ign;
+
+	return __bpf_list_add(node, head, false,
+			      meta ? meta->record : NULL, off);
 }
=20
-__bpf_kfunc void bpf_list_push_back(struct bpf_list_head *head, struct b=
pf_list_node *node)
+__bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
+					struct bpf_list_node *node,
+					void *meta__ign, u64 off)
 {
-	return __bpf_list_add(node, head, true);
+	struct btf_struct_meta *meta =3D meta__ign;
+
+	return __bpf_list_add(node, head, true,
+			      meta ? meta->record : NULL, off);
 }
=20
 static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, =
bool tail)
@@ -1989,14 +2008,23 @@ __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove=
(struct bpf_rb_root *root,
 /* Need to copy rbtree_add_cached's logic here because our 'less' is a B=
PF
  * program
  */
-static void __bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_nod=
e *node,
-			     void *less)
+static int __bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node=
 *node,
+			    void *less, struct btf_record *rec, u64 off)
 {
 	struct rb_node **link =3D &((struct rb_root_cached *)root)->rb_root.rb_=
node;
+	struct rb_node *parent =3D NULL, *n =3D (struct rb_node *)node;
 	bpf_callback_t cb =3D (bpf_callback_t)less;
-	struct rb_node *parent =3D NULL;
 	bool leftmost =3D true;
=20
+	if (!n->__rb_parent_color)
+		RB_CLEAR_NODE(n);
+
+	if (!RB_EMPTY_NODE(n)) {
+		/* Only called from BPF prog, no need to migrate_disable */
+		__bpf_obj_drop_impl(n - off, rec);
+		return -EINVAL;
+	}
+
 	while (*link) {
 		parent =3D *link;
 		if (cb((uintptr_t)node, (uintptr_t)parent, 0, 0, 0)) {
@@ -2007,15 +2035,18 @@ static void __bpf_rbtree_add(struct bpf_rb_root *=
root, struct bpf_rb_node *node,
 		}
 	}
=20
-	rb_link_node((struct rb_node *)node, parent, link);
-	rb_insert_color_cached((struct rb_node *)node,
-			       (struct rb_root_cached *)root, leftmost);
+	rb_link_node(n, parent, link);
+	rb_insert_color_cached(n, (struct rb_root_cached *)root, leftmost);
+	return 0;
 }
=20
-__bpf_kfunc void bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_=
node *node,
-				bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b))
+__bpf_kfunc int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf=
_rb_node *node,
+				    bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b),
+				    void *meta__ign, u64 off)
 {
-	__bpf_rbtree_add(root, node, (void *)less);
+	struct btf_struct_meta *meta =3D meta__ign;
+
+	return __bpf_rbtree_add(root, node, (void *)less, meta ? meta->record :=
 NULL, off);
 }
=20
 __bpf_kfunc struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *roo=
t)
@@ -2323,14 +2354,14 @@ BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_refcount_acquire_impl, KF_ACQUIRE)
-BTF_ID_FLAGS(func, bpf_list_push_front)
-BTF_ID_FLAGS(func, bpf_list_push_back)
+BTF_ID_FLAGS(func, bpf_list_push_front_impl)
+BTF_ID_FLAGS(func, bpf_list_push_back_impl)
 BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE)
-BTF_ID_FLAGS(func, bpf_rbtree_add)
+BTF_ID_FLAGS(func, bpf_rbtree_add_impl)
 BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
=20
 #ifdef CONFIG_CGROUPS
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eae94c14db36..642f644356ea 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8541,10 +8541,10 @@ static int set_rbtree_add_callback_state(struct b=
pf_verifier_env *env,
 					 struct bpf_func_state *callee,
 					 int insn_idx)
 {
-	/* void bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *no=
de,
+	/* void bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_nod=
e *node,
 	 *                     bool (less)(struct bpf_rb_node *a, const struct =
bpf_rb_node *b));
 	 *
-	 * 'struct bpf_rb_node *node' arg to bpf_rbtree_add is the same PTR_TO_=
BTF_ID w/ offset
+	 * 'struct bpf_rb_node *node' arg to bpf_rbtree_add_impl is the same PT=
R_TO_BTF_ID w/ offset
 	 * that 'less' callback args will be receiving. However, 'node' arg was=
 release_reference'd
 	 * by this point, so look at 'root'
 	 */
@@ -9612,8 +9612,8 @@ enum special_kfunc_type {
 	KF_bpf_obj_new_impl,
 	KF_bpf_obj_drop_impl,
 	KF_bpf_refcount_acquire_impl,
-	KF_bpf_list_push_front,
-	KF_bpf_list_push_back,
+	KF_bpf_list_push_front_impl,
+	KF_bpf_list_push_back_impl,
 	KF_bpf_list_pop_front,
 	KF_bpf_list_pop_back,
 	KF_bpf_cast_to_kern_ctx,
@@ -9621,7 +9621,7 @@ enum special_kfunc_type {
 	KF_bpf_rcu_read_lock,
 	KF_bpf_rcu_read_unlock,
 	KF_bpf_rbtree_remove,
-	KF_bpf_rbtree_add,
+	KF_bpf_rbtree_add_impl,
 	KF_bpf_rbtree_first,
 	KF_bpf_dynptr_from_skb,
 	KF_bpf_dynptr_from_xdp,
@@ -9633,14 +9633,14 @@ BTF_SET_START(special_kfunc_set)
 BTF_ID(func, bpf_obj_new_impl)
 BTF_ID(func, bpf_obj_drop_impl)
 BTF_ID(func, bpf_refcount_acquire_impl)
-BTF_ID(func, bpf_list_push_front)
-BTF_ID(func, bpf_list_push_back)
+BTF_ID(func, bpf_list_push_front_impl)
+BTF_ID(func, bpf_list_push_back_impl)
 BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
 BTF_ID(func, bpf_cast_to_kern_ctx)
 BTF_ID(func, bpf_rdonly_cast)
 BTF_ID(func, bpf_rbtree_remove)
-BTF_ID(func, bpf_rbtree_add)
+BTF_ID(func, bpf_rbtree_add_impl)
 BTF_ID(func, bpf_rbtree_first)
 BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
@@ -9652,8 +9652,8 @@ BTF_ID_LIST(special_kfunc_list)
 BTF_ID(func, bpf_obj_new_impl)
 BTF_ID(func, bpf_obj_drop_impl)
 BTF_ID(func, bpf_refcount_acquire_impl)
-BTF_ID(func, bpf_list_push_front)
-BTF_ID(func, bpf_list_push_back)
+BTF_ID(func, bpf_list_push_front_impl)
+BTF_ID(func, bpf_list_push_back_impl)
 BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
 BTF_ID(func, bpf_cast_to_kern_ctx)
@@ -9661,7 +9661,7 @@ BTF_ID(func, bpf_rdonly_cast)
 BTF_ID(func, bpf_rcu_read_lock)
 BTF_ID(func, bpf_rcu_read_unlock)
 BTF_ID(func, bpf_rbtree_remove)
-BTF_ID(func, bpf_rbtree_add)
+BTF_ID(func, bpf_rbtree_add_impl)
 BTF_ID(func, bpf_rbtree_first)
 BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
@@ -9995,15 +9995,15 @@ static int check_reg_allocation_locked(struct bpf=
_verifier_env *env, struct bpf_
=20
 static bool is_bpf_list_api_kfunc(u32 btf_id)
 {
-	return btf_id =3D=3D special_kfunc_list[KF_bpf_list_push_front] ||
-	       btf_id =3D=3D special_kfunc_list[KF_bpf_list_push_back] ||
+	return btf_id =3D=3D special_kfunc_list[KF_bpf_list_push_front_impl] ||
+	       btf_id =3D=3D special_kfunc_list[KF_bpf_list_push_back_impl] ||
 	       btf_id =3D=3D special_kfunc_list[KF_bpf_list_pop_front] ||
 	       btf_id =3D=3D special_kfunc_list[KF_bpf_list_pop_back];
 }
=20
 static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
 {
-	return btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add] ||
+	return btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add_impl] ||
 	       btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_remove] ||
 	       btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_first];
 }
@@ -10016,7 +10016,7 @@ static bool is_bpf_graph_api_kfunc(u32 btf_id)
=20
 static bool is_callback_calling_kfunc(u32 btf_id)
 {
-	return btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add];
+	return btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add_impl];
 }
=20
 static bool is_rbtree_lock_required_kfunc(u32 btf_id)
@@ -10057,12 +10057,12 @@ static bool check_kfunc_is_graph_node_api(struc=
t bpf_verifier_env *env,
=20
 	switch (node_field_type) {
 	case BPF_LIST_NODE:
-		ret =3D (kfunc_btf_id =3D=3D special_kfunc_list[KF_bpf_list_push_front=
] ||
-		       kfunc_btf_id =3D=3D special_kfunc_list[KF_bpf_list_push_back]);
+		ret =3D (kfunc_btf_id =3D=3D special_kfunc_list[KF_bpf_list_push_front=
_impl] ||
+		       kfunc_btf_id =3D=3D special_kfunc_list[KF_bpf_list_push_back_im=
pl]);
 		break;
 	case BPF_RB_NODE:
 		ret =3D (kfunc_btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_remove] =
||
-		       kfunc_btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add]);
+		       kfunc_btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add_impl])=
;
 		break;
 	default:
 		verbose(env, "verifier internal error: unexpected graph node argument =
type %s\n",
@@ -10743,10 +10743,11 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
 		}
 	}
=20
-	if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_list_push_front] ||
-	    meta.func_id =3D=3D special_kfunc_list[KF_bpf_list_push_back] ||
-	    meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add]) {
+	if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_list_push_front_impl]=
 ||
+	    meta.func_id =3D=3D special_kfunc_list[KF_bpf_list_push_back_impl] =
||
+	    meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add_impl]) {
 		release_ref_obj_id =3D regs[BPF_REG_2].ref_obj_id;
+		insn_aux->insert_off =3D regs[BPF_REG_2].off;
 		err =3D ref_convert_owning_non_owning(env, release_ref_obj_id);
 		if (err) {
 			verbose(env, "kfunc %s#%d conversion of owning ref to non-owning fail=
ed\n",
@@ -10762,7 +10763,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 		}
 	}
=20
-	if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add]) {
+	if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add_impl]) {
 		err =3D __check_func_call(env, insn, insn_idx_p, meta.subprogno,
 					set_rbtree_add_callback_state);
 		if (err) {
@@ -17413,6 +17414,23 @@ static int fixup_call_args(struct bpf_verifier_e=
nv *env)
 	return err;
 }
=20
+static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *in=
sn_aux,
+					    u16 struct_meta_reg,
+					    u16 node_offset_reg,
+					    struct bpf_insn *insn,
+					    struct bpf_insn *insn_buf,
+					    int *cnt)
+{
+	struct btf_struct_meta *kptr_struct_meta =3D insn_aux->kptr_struct_meta=
;
+	struct bpf_insn addr[2] =3D { BPF_LD_IMM64(struct_meta_reg, (long)kptr_=
struct_meta) };
+
+	insn_buf[0] =3D addr[0];
+	insn_buf[1] =3D addr[1];
+	insn_buf[2] =3D BPF_MOV64_IMM(node_offset_reg, insn_aux->insert_off);
+	insn_buf[3] =3D *insn;
+	*cnt =3D 4;
+}
+
 static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_ins=
n *insn,
 			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
@@ -17468,6 +17486,20 @@ static int fixup_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
 		insn_buf[1] =3D addr[1];
 		insn_buf[2] =3D *insn;
 		*cnt =3D 3;
+	} else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_list_push_bac=
k_impl] ||
+		   desc->func_id =3D=3D special_kfunc_list[KF_bpf_list_push_front_impl=
] ||
+		   desc->func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add_impl]) {
+		int struct_meta_reg =3D BPF_REG_3;
+		int node_offset_reg =3D BPF_REG_4;
+
+		/* rbtree_add has extra 'less' arg, so args-to-fixup are in diff regs =
*/
+		if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add_impl]) {
+			struct_meta_reg =3D BPF_REG_4;
+			node_offset_reg =3D BPF_REG_5;
+		}
+
+		__fixup_collection_insert_kfunc(&env->insn_aux_data[insn_idx], struct_=
meta_reg,
+						node_offset_reg, insn, insn_buf, cnt);
 	} else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern_=
ctx] ||
 		   desc->func_id =3D=3D special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] =3D BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
index 619afcab2ab0..209811b1993a 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -14,7 +14,8 @@
  *	type ID of a struct in program BTF.
  *
  *	The 'local_type_id' parameter must be a known constant.
- *	The 'meta' parameter is a hidden argument that is ignored.
+ *	The 'meta' parameter is rewritten by the verifier, no need for BPF
+ *	program to set it.
  * Returns
  *	A pointer to an object of the type corresponding to the passed in
  *	'local_type_id', or NULL on failure.
@@ -28,7 +29,8 @@ extern void *bpf_obj_new_impl(__u64 local_type_id, void=
 *meta) __ksym;
  *	Free an allocated object. All fields of the object that require
  *	destruction will be destructed before the storage is freed.
  *
- *	The 'meta' parameter is a hidden argument that is ignored.
+ *	The 'meta' parameter is rewritten by the verifier, no need for BPF
+ *	program to set it.
  * Returns
  *	Void.
  */
@@ -41,7 +43,8 @@ extern void bpf_obj_drop_impl(void *kptr, void *meta) _=
_ksym;
  *	Increment the refcount on a refcounted local kptr, turning the
  *	non-owning reference input into an owning reference in the process.
  *
- *	The 'meta' parameter is a hidden argument that is ignored.
+ *	The 'meta' parameter is rewritten by the verifier, no need for BPF
+ *	program to set it.
  * Returns
  *	An owning reference to the object pointed to by 'kptr'
  */
@@ -52,17 +55,35 @@ extern void *bpf_refcount_acquire_impl(void *kptr, vo=
id *meta) __ksym;
=20
 /* Description
  *	Add a new entry to the beginning of the BPF linked list.
+ *
+ *	The 'meta' and 'off' parameters are rewritten by the verifier, no nee=
d
+ *	for BPF programs to set them
  * Returns
- *	Void.
+ *	0 if the node was successfully added
+ *	-EINVAL if the node wasn't added because it's already in a list
  */
-extern void bpf_list_push_front(struct bpf_list_head *head, struct bpf_l=
ist_node *node) __ksym;
+extern int bpf_list_push_front_impl(struct bpf_list_head *head,
+				    struct bpf_list_node *node,
+				    void *meta, __u64 off) __ksym;
+
+/* Convenience macro to wrap over bpf_list_push_front_impl */
+#define bpf_list_push_front(head, node) bpf_list_push_front_impl(head, n=
ode, NULL, 0)
=20
 /* Description
  *	Add a new entry to the end of the BPF linked list.
+ *
+ *	The 'meta' and 'off' parameters are rewritten by the verifier, no nee=
d
+ *	for BPF programs to set them
  * Returns
- *	Void.
+ *	0 if the node was successfully added
+ *	-EINVAL if the node wasn't added because it's already in a list
  */
-extern void bpf_list_push_back(struct bpf_list_head *head, struct bpf_li=
st_node *node) __ksym;
+extern int bpf_list_push_back_impl(struct bpf_list_head *head,
+				   struct bpf_list_node *node,
+				   void *meta, __u64 off) __ksym;
+
+/* Convenience macro to wrap over bpf_list_push_back_impl */
+#define bpf_list_push_back(head, node) bpf_list_push_back_impl(head, nod=
e, NULL, 0)
=20
 /* Description
  *	Remove the entry at the beginning of the BPF linked list.
@@ -88,11 +109,19 @@ extern struct bpf_rb_node *bpf_rbtree_remove(struct =
bpf_rb_root *root,
=20
 /* Description
  *	Add 'node' to rbtree with root 'root' using comparator 'less'
+ *
+ *	The 'meta' and 'off' parameters are rewritten by the verifier, no nee=
d
+ *	for BPF programs to set them
  * Returns
- *	Nothing
+ *	0 if the node was successfully added
+ *	-EINVAL if the node wasn't added because it's already in a tree
  */
-extern void bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node =
*node,
-			   bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b)) _=
_ksym;
+extern int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_n=
ode *node,
+			       bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b=
),
+			       void *meta, __u64 off) __ksym;
+
+/* Convenience macro to wrap over bpf_rbtree_add_impl */
+#define bpf_rbtree_add(head, node, less) bpf_rbtree_add_impl(head, node,=
 less, NULL, 0)
=20
 /* Description
  *	Return the first (leftmost) node in input tree
--=20
2.34.1

