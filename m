Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A92690F6A
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 18:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjBIRm1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 12:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBIRm1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 12:42:27 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FF05BA4B
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 09:42:25 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319GxPiO003175
        for <bpf@vger.kernel.org>; Thu, 9 Feb 2023 09:42:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=4nDDd7K36eBIN8HRYf/GWx9ZAnQs6hN8IYnvpwI6emM=;
 b=khNLe8J9KW8nsOySJ51SlFqaszeuuHMatXXgfytjIwB5AyuM9PAoMUnDBDTDs4YEg+3L
 aPq8H6XsOdcuWygMTCec2YssgGrzKzgs2DaNRSZor58fFW/RjaTggpshlHO3ghTs7OXh
 yClfrS06bN7J5KXjU6XrDwTf6Szm1jqzVX4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nmce228de-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 09 Feb 2023 09:42:24 -0800
Received: from twshared6017.02.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Thu, 9 Feb 2023 09:42:20 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 80BE816906069; Thu,  9 Feb 2023 09:42:11 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v4 bpf-next 11/11] bpf, documentation: Add graph documentation for non-owning refs
Date:   Thu, 9 Feb 2023 09:41:44 -0800
Message-ID: <20230209174144.3280955-12-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230209174144.3280955-1-davemarchevsky@fb.com>
References: <20230209174144.3280955-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8aiB57dJNeoqLdVB5YGFmzE930o3Fr_n
X-Proofpoint-GUID: 8aiB57dJNeoqLdVB5YGFmzE930o3Fr_n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_13,2023-02-09_03,2023-02-09_01
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
 Documentation/bpf/graph_ds_impl.rst | 266 ++++++++++++++++++++++++++++
 Documentation/bpf/other.rst         |   3 +-
 2 files changed, 268 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/bpf/graph_ds_impl.rst

diff --git a/Documentation/bpf/graph_ds_impl.rst b/Documentation/bpf/grap=
h_ds_impl.rst
new file mode 100644
index 000000000000..8bbf1815efe7
--- /dev/null
+++ b/Documentation/bpf/graph_ds_impl.rst
@@ -0,0 +1,266 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+BPF Graph Data Structures
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+This document describes implementation details of new-style "graph" data
+structures (linked_list, rbtree), with particular focus on the verifier'=
s
+implementation of semantics specific to those data structures.
+
+Although no specific verifier code is referred to in this document, the =
document
+assumes that the reader has general knowledge of BPF verifier internals,=
 BPF
+maps, and BPF program writing.
+
+Note that the intent of this document is to describe the current state o=
f
+these graph data structures. **No guarantees** of stability for either
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
+Unstable API
+------------
+
+Data structures implemented using the BPF map API have historically used=
 BPF
+helper functions - either standard map API helpers like ``bpf_map_update=
_elem``
+or map-specific helpers. The new-style graph data structures instead use=
 kfuncs
+to define their manipulation helpers. Because there are no stability gua=
rantees
+for kfuncs, the API and semantics for these data structures can be evolv=
ed in
+a way that breaks backwards compatibility if necessary.
+
+Root and node types for the new data structures are opaquely defined in =
the
+``uapi/linux/bpf.h`` header.
+
+Locking
+-------
+
+The new-style data structures are intrusive and are defined similarly to=
 their
+vanilla kernel counterparts:
+
+.. code-block:: c
+        struct node_data {
+          long key;
+          long data;
+          struct bpf_rb_node node;
+        };
+
+        struct bpf_spin_lock glock;
+        struct bpf_rb_root groot __contains(node_data, node);
+
+The "root" type for both linked_list and rbtree expects to be in a map_v=
alue
+which also contains a ``bpf_spin_lock`` - in the above example both glob=
al
+variables are placed in a single-value arraymap. The verifier considers =
this
+spin_lock to be associated with the ``bpf_rb_root`` by virtue of both be=
ing in
+the same map_value and will enforce that the correct lock is held when
+verifying BPF programs that manipulate the tree. Since this lock checkin=
g
+happens at verification time, there is no runtime penalty.
+
+Non-owning references
+---------------------
+
+**Motivation**
+
+Consider the following BPF code:
+
+.. code-block:: c
+
+        struct node_data *n =3D bpf_obj_new(typeof(*n)); /* ACQUIRED */
+
+        bpf_spin_lock(&lock);
+
+        bpf_rbtree_add(&tree, n); /* PASSED */
+
+        bpf_spin_unlock(&lock);
+
+From the verifier's perspective, the pointer ``n`` returned from ``bpf_o=
bj_new``
+has type ``PTR_TO_BTF_ID | MEM_ALLOC``, with a ``btf_id`` of
+``struct node_data`` and a nonzero ``ref_obj_id``. Because it holds ``n`=
`, the
+program has ownership of the pointee's (object pointed to by ``n``) life=
time.
+The BPF program must pass off ownership before exiting - either via
+``bpf_obj_drop``, which ``free``'s the object, or by adding it to ``tree=
`` with
+``bpf_rbtree_add``.
+
+(``ACQUIRED`` and ``PASSED`` comments in the example denote statements w=
here
+"ownership is acquired" and "ownership is passed", respectively)
+
+What should the verifier do with ``n`` after ownership is passed off? If=
 the
+object was ``free``'d with ``bpf_obj_drop`` the answer is obvious: the v=
erifier
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
+
+        int x;
+        struct node_data *n =3D bpf_obj_new(typeof(*n)); /* ACQUIRED */
+
+        bpf_spin_lock(&lock);
+
+        bpf_rbtree_add(&tree, n); /* PASSED */
+        x =3D n->data;
+        n->data =3D 42;
+
+        bpf_spin_unlock(&lock);
+
+Both the read from and write to ``n->data`` would be rejected. The verif=
ier
+can do better, though, by taking advantage of two details:
+
+  * Graph data structure APIs can only be used when the ``bpf_spin_lock`=
`
+    associated with the graph root is held
+
+  * Both graph data structures have pointer stability
+
+     * Because graph nodes are allocated with ``bpf_obj_new`` and
+       adding / removing from the root involves fiddling with the
+       ``bpf_{list,rb}_node`` field of the node struct, a graph node wil=
l
+       remain at the same address after either operation.
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
+
+  * Ownership of pointee must be 'released' by passing it to some graph =
API
+    kfunc, or via ``bpf_obj_drop``, which ``free``'s the pointee
+
+    * If not released before program ends, verifier considers program in=
valid
+
+  * Access to the pointee's memory will not page fault
+
+*non-owning reference*
+
+  * This reference does not own the pointee
+
+     * It cannot be used to add the graph node to a graph root, nor ``fr=
ee``'d via
+       ``bpf_obj_drop``
+
+  * No explicit control of lifetime, but can infer valid lifetime based =
on
+    non-owning ref existence (see explanation below)
+
+  * Access to the pointee's memory will not page fault
+
+From verifier's perspective non-owning references can only exist
+between spin_lock and spin_unlock. Why? After spin_unlock another progra=
m
+can do arbitrary operations on the data structure like removing and ``fr=
ee``-ing
+via bpf_obj_drop. A non-owning ref to some chunk of memory that was remo=
ve'd,
+``free``'d, and reused via bpf_obj_new would point to an entirely differ=
ent thing.
+Or the memory could go away.
+
+To prevent this logic violation all non-owning references are invalidate=
d by the
+verifier after a critical section ends. This is necessary to ensure the =
"will
+not page fault" property of non-owning references. So if the verifier ha=
sn't
+invalidated a non-owning ref, accessing it will not page fault.
+
+Currently ``bpf_obj_drop`` is not allowed in the critical section, so
+if there's a valid non-owning ref, we must be in a critical section, and=
 can
+conclude that the ref's memory hasn't been dropped-and- ``free``'d or
+dropped-and-reused.
+
+Any reference to a node that is in an rbtree _must_ be non-owning, since
+the tree has control of the pointee's lifetime. Similarly, any ref to a =
node
+that isn't in rbtree _must_ be owning. This results in a nice property:
+graph API add / remove implementations don't need to check if a node
+has already been added (or already removed), as the ownership model
+allows the verifier to prevent such a state from being valid by simply c=
hecking
+types.
+
+However, pointer aliasing poses an issue for the above "nice property".
+Consider the following example:
+
+.. code-block:: c
+
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
+
+Assume the tree is empty before this program runs. If we track verifier =
state
+changes here using numbers in above comments:
+
+  1) n is an owning reference
+
+  2) n is a non-owning reference, it's been added to the tree
+
+  3) n and m are non-owning references, they both point to the same node
+
+  4) o is an owning reference, n and m non-owning, all point to same nod=
e
+
+  5) o and p are owning, n and m non-owning, all point to the same node
+
+  6) a double-free has occurred, since o and p point to same node and o =
was
+     ``free``'d in previous statement
+
+States 4 and 5 violate our "nice property", as there are non-owning refs=
 to
+a node which is not in an rbtree. Statement 5 will try to remove a node =
which
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
+
+  * removes it from the data structure
+
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

