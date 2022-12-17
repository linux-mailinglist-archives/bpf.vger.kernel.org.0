Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6A264F83D
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 09:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiLQIZs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Dec 2022 03:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiLQIZo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 03:25:44 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3E28FC3
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:25:42 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BH5dLHv008990
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:25:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=EdXmAc3STMKUCzmRabnHwxWp4z12OH0CsT/V9Wmt20s=;
 b=NPkXirlyVs71SnCtecPJ4uBUKbM3nPXOWECMtOpzaswYd92dDfK0iWx4yMmR7E8kQQns
 ZTW3jxrj839xr50Er5Vpx6+m7yPxUzXwxcVKBH1ZN4MWyJ76VXS3Y8MM2PUoANxPw13M
 QPQKYAtceMO9a/n23272pWZqDXfp3dWkMxU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mh6uj8mpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:25:41 -0800
Received: from twshared19053.17.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 17 Dec 2022 00:25:40 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id A97BB12A9E061; Sat, 17 Dec 2022 00:25:23 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 13/13] bpf, documentation: Add graph documentation for non-owning refs
Date:   Sat, 17 Dec 2022 00:25:06 -0800
Message-ID: <20221217082506.1570898-14-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221217082506.1570898-1-davemarchevsky@fb.com>
References: <20221217082506.1570898-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MRmzJU252Q83ncyTBHlZ1w8SELlJFRPG
X-Proofpoint-GUID: MRmzJU252Q83ncyTBHlZ1w8SELlJFRPG
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

It is difficult to intuit the semantics of owning and non-owning
references from verifier code. In order to keep the high-level details
from being lost in the mailing list, this patch adds documentation
explaining semantics and details.

The target audience of doc added in this patch is folks working on BPF
internals, as there's focus on "what should the verifier do here". Via
reorganization or copy-and-paste, much of the content can probably be
repurposed for BPF program writer audience as well.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 Documentation/bpf/graph_ds_impl.rst | 208 ++++++++++++++++++++++++++++
 Documentation/bpf/other.rst         |   3 +-
 2 files changed, 210 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/bpf/graph_ds_impl.rst

diff --git a/Documentation/bpf/graph_ds_impl.rst b/Documentation/bpf/grap=
h_ds_impl.rst
new file mode 100644
index 000000000000..f92cbd223dc3
--- /dev/null
+++ b/Documentation/bpf/graph_ds_impl.rst
@@ -0,0 +1,208 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+BPF Graph Data Structures
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+This document describes implementation details of new-style "graph" data
+structures (linked_list, rbtree), with particular focus on verifier
+implementation of semantics particular to those data structures.
+
+Note that the intent of this document is to describe the current state o=
f
+these graph data structures, **no guarantees** of stability for either
+semantics or APIs are made or implied here.
+
+.. contents::
+    :local:
+    :depth: 2
+
+Introduction
+------------
+
+The BPF map API has historically been the main way to expose data struct=
ures
+of various types for use within BPF programs. Some data structures fit n=
aturally
+with the map API (HASH, ARRAY), others less so. Consequentially, program=
s
+interacting with the latter group of data structures can be hard to pars=
e
+for kernel programmers without previous BPF experience.
+
+Luckily, some restrictions which necessitated the use of BPF map semanti=
cs are
+no longer relevant. With the introduction of kfuncs, kptrs, and the any-=
context
+BPF allocator, it is now possible to implement BPF data structures whose=
 API
+and semantics more closely match those exposed to the rest of the kernel=
.
+
+Two such data structures - linked_list and rbtree - have many verificati=
on
+details in common. Because both have "root"s ("head" for linked_list) an=
d
+"node"s, the verifier code and this document refer to common functionali=
ty
+as "graph_api", "graph_root", "graph_node", etc.
+
+Unless otherwise stated, examples and semantics below apply to both grap=
h data
+structures.
+
+Non-owning references
+---------------------
+
+**Motivation**
+
+Consider the following BPF code:
+
+.. code-block:: c
+        struct node_data *n =3D bpf_obj_new(typeof(*n)); /* BEFORE */
+
+        bpf_spin_lock(&lock);
+
+        bpf_rbtree_add(&tree, n); /* AFTER */
+
+        bpf_spin_unlock(&lock);
+----
+
+From the verifier's perspective, after bpf_obj_new ``n`` has type
+``PTR_TO_BTF_ID | MEM_ALLOC`` with btf_id of ``struct node_data`` and a
+nonzero ``ref_obj_id``. Because it holds ``n``, the program has ownershi=
p
+of the pointee's lifetime (object pointed to by ``n``). The BPF program =
must
+pass off ownership before exiting - either via ``bpf_obj_drop``, which f=
ree's
+the object, or by adding it to ``tree`` with ``bpf_rbtree_add``.
+
+(``BEFORE`` and ``AFTER`` comments in the example denote beginning of "b=
efore
+ownership is passed" and "after ownership is passed")
+
+What should the verifier do with ``n`` after ownership is passed off? If=
 the
+object was free'd with ``bpf_obj_drop`` the answer is obvious: the verif=
ier
+should reject programs which attempt to access ``n`` after ``bpf_obj_dro=
p`` as
+the object is no longer valid. The underlying memory may have been reuse=
d for
+some other allocation, unmapped, etc.
+
+When ownership is passed to ``tree`` via ``bpf_rbtree_add`` the answer i=
s less
+obvious. The verifier could enforce the same semantics as for ``bpf_obj_=
drop``,
+but that would result in programs with useful, common coding patterns be=
ing
+rejected, e.g.:
+
+.. code-block:: c
+        int x;
+        struct node_data *n =3D bpf_obj_new(typeof(*n)); /* BEFORE */
+
+        bpf_spin_lock(&lock);
+
+        bpf_rbtree_add(&tree, n); /* AFTER */
+        x =3D n->data;
+        n->data =3D 42;
+
+        bpf_spin_unlock(&lock);
+----
+
+Both the read from and write to ``n->data`` would be rejected. The verif=
ier
+can do better, though, by taking advantage of two details:
+
+  * Graph data structure APIs can only be used when the ``bpf_spin_lock`=
`
+    associated with the graph root is held
+  * Both graph data structures have pointer stability
+    * Because graph nodes are allocated with ``bpf_obj_new`` and
+      adding / removing from the root involves fiddling with the
+      ``bpf_{list,rb}_node`` field of the node struct, a graph node will
+      remain at the same address after either operation.
+
+Because the associated ``bpf_spin_lock`` must be held by any program add=
ing
+or removing, if we're in the critical section bounded by that lock, we k=
now
+that no other program can add or remove until the end of the critical se=
ction.
+This combined with pointer stability means that, until the critical sect=
ion
+ends, we can safely access the graph node through ``n`` even after it wa=
s used
+to pass ownership.
+
+The verifier considers such a reference a *non-owning reference*. The re=
f
+returned by ``bpf_obj_new`` is accordingly considered an *owning referen=
ce*.
+Both terms currently only have meaning in the context of graph nodes and=
 API.
+
+**Details**
+
+Let's enumerate the properties of both types of references.
+
+*owning reference*
+
+  * This reference controls the lifetime of the pointee
+  * Ownership of pointee must be 'released' by passing it to some graph =
API
+    kfunc, or via ``bpf_obj_drop``, which free's the pointee
+    * If not released before program ends, verifier considers program in=
valid
+  * Access to the pointee's memory will not page fault
+
+*non-owning reference*
+
+  * This reference does not own the pointee
+    * It cannot be used to add the graph node to a graph root, nor free =
via
+      ``bpf_obj_drop``
+  * No explicit control of lifetime, but can infer valid lifetime based =
on
+    non-owning ref existence (see explanation below)
+  * Access to the pointee's memory will not page fault
+
+From verifier's perspective non-owning references can only exist
+between spin_lock and spin_unlock. Why? After spin_unlock another progra=
m
+can do arbitrary operations on the data structure like removing and free=
-ing
+via bpf_obj_drop. A non-owning ref to some chunk of memory that was remo=
ve'd,
+free'd, and reused via bpf_obj_new would point to an entirely different =
thing.
+Or the memory could go away.
+
+To prevent this logic violation all non-owning references are invalidate=
d by
+verifier after critical section ends. This is necessary to ensure "will
+not page fault" property of non-owning reference. So if verifier hasn't
+invalidated a non-owning ref, accessing it will not page fault.
+
+Currently ``bpf_obj_drop`` is not allowed in the critical section, so
+if there's a valid non-owning ref, we must be in critical section, and c=
an
+conclude that the ref's memory hasn't been dropped-and-free'd or dropped=
-
+and-reused.
+
+Any reference to a node that is in a rbtree _must_ be non-owning, since
+the tree has control of pointee lifetime. Similarly, any ref to a node
+that isn't in rbtree _must_ be owning. This results in a nice property:
+graph API add / remove implementations don't need to check if a node
+has already been added (or already removed), as the verifier type system
+prevents such a state from being valid.
+
+However, pointer aliasing poses an issue for the above "nice property".
+Consider the following example:
+
+.. code-block:: c
+        struct node_data *n, *m, *o, *p;
+        n =3D bpf_obj_new(typeof(*n));     /* 1 */
+
+        bpf_spin_lock(&lock);
+
+        bpf_rbtree_add(&tree, n);        /* 2 */
+        m =3D bpf_rbtree_first(&tree);     /* 3 */
+
+        o =3D bpf_rbtree_remove(&tree, n); /* 4 */
+        p =3D bpf_rbtree_remove(&tree, m); /* 5 */
+
+        bpf_spin_unlock(&lock);
+
+        bpf_obj_drop(o);
+        bpf_obj_drop(p); /* 6 */
+----
+
+Assume tree is empty before this program runs. If we track verifier stat=
e
+changes here using numbers in above comments:
+
+  1) n is an owning reference
+  2) n is a non-owning reference, it's been added to the tree
+  3) n and m are non-owning references, they both point to the same node
+  4) o is an owning reference, n and m non-owning, all point to same nod=
e
+  5) o and p are owning, n and m non-owning, all point to the same node
+  6) a double-free has occurred, since o and p point to same node and o =
was
+     free'd in previous statement
+
+States 4 and 5 violate our "nice property", as there are non-owning refs=
 to
+a node which is not in a rbtree. Statement 5 will try to remove a node w=
hich
+has already been removed as a result of this violation. State 6 is a dan=
gerous
+double-free.
+
+At a minimum we should prevent state 6 from being possible. If we can't =
also
+prevent state 5 then we must abandon our "nice property" and check wheth=
er a
+node has already been removed at runtime.
+
+We prevent both by generalizing the "invalidate non-owning references" b=
ehavior
+of ``bpf_spin_unlock`` and doing similar invalidation after
+``bpf_rbtree_remove``. The logic here being that any graph API kfunc whi=
ch:
+
+  * takes an arbitrary node argument
+  * removes it from the datastructure
+  * returns an owning reference to the removed node
+
+May result in a state where some other non-owning reference points to th=
e same
+node. So ``remove``-type kfuncs must be considered a non-owning referenc=
e
+invalidation point as well.
diff --git a/Documentation/bpf/other.rst b/Documentation/bpf/other.rst
index 3d61963403b4..7e6b12018802 100644
--- a/Documentation/bpf/other.rst
+++ b/Documentation/bpf/other.rst
@@ -6,4 +6,5 @@ Other
    :maxdepth: 1
=20
    ringbuf
-   llvm_reloc
\ No newline at end of file
+   llvm_reloc
+   graph_ds_impl
--=20
2.30.2

