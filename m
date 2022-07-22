Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C289D57E69A
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 20:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiGVSfF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 14:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbiGVSfE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 14:35:04 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DC981485
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:02 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MAR3Kr022379
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=w+9TPSsRaIPSTDNSwxbhwzSK1J9ruCyz0N0/4MzdIwc=;
 b=nMP2mnJEOwsIR5gCzfHukjWahhbZygR8ivD813II3Mi85LkJUYgFnHUKIH8BoiNqUYy2
 AySYgssfq3//kuOYJ7PfujXaplL28UX3TnhDuyVNyP40eGm8hZEah2uWsnmX+RMY6ARe
 aYUY+L9Kg83ASWiFyMue67Z8cNgVQ2RCYss= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hes8vmye8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:01 -0700
Received: from twshared22934.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 22 Jul 2022 11:34:59 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 668F6AB6F19C; Fri, 22 Jul 2022 11:34:48 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFC PATCH bpf-next 04/11] bpf: Add rbtree map
Date:   Fri, 22 Jul 2022 11:34:31 -0700
Message-ID: <20220722183438.3319790-5-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220722183438.3319790-1-davemarchevsky@fb.com>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Mx618AHTMT2JEBY_yz-SZjvca37MgMAk
X-Proofpoint-ORIG-GUID: Mx618AHTMT2JEBY_yz-SZjvca37MgMAk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce a new map type, bpf_rbtree_map, allowing BPF programs to
create and manipulate rbtree data structures. bpf_rbtree_map differs
from 'classic' BPF map patterns in a few important ways:

  * The map does not allocate its own elements. Instead,
    BPF programs must call bpf_rbtree_alloc_node helper to allocate and
    bpf_rbtree_add to add map elem - referred to as 'node' from now on -
    to the rbtree. This means that rbtree maps can grow dynamically, do
    not preallocate, and that 'max_entries' has no meaning for rbtree
    maps.
    * Separating allocation and insertion allows alloc_node call to
      occur in contexts where it's safe to allocate.

  * It's possible to remove a node from a rbtree map with
    bpf_rbtree_remove helper.
    * Goal here is to allow a node to be removed from one rbtree and
      added to another
      [ NOTE: This functionality is still in progress ]

Helpers are added to manipulate nodes and trees:
  * bpf_rbtree_{alloc,free}_node: Allocate / free node structs
  * bpf_rbtree_{add,remove}: Add / remove nodes from rbtree maps
    * A comparator function is passed to bpf_rbtree_add in order to
      find the correct place to add the node.
  * bpf_rbtree_find: Find a node matching some condition in the rbtree
    * A comparator function is passed in order to determine whether a
      node matches what's being searched for.

bpf_rbtree_add is very similar to the 'map_push_elem' builtin, but since
verifier needs special logic to setup the comparator callback a new
helper is added. Same for bpf_rbtree_find and 'map_lookup_elem' builtin.

In order to safely support separate allocation / insertion and passing
nodes between rbtrees, some invariants must hold:

  * A node that is not in a rbtree map must either be free'd or added to
    a rbtree map before the program terminates
    * Nodes are in this state when returned from bpf_rbtree_alloc_node
      or bpf_rbtree_remove.

If a node is in a rbtree map it is 'owned' by the map, otherwise it is
owned by the BPF program which holds a reference to it. Owner is
responsible for the lifetime of the node.

This matches existing acquire / release semantics well. node_alloc and
remove operations 'acquire' a node while add and node_free operations
'release' the node. The verifier enforces that acquired nodes are
released before program terminates.

Some other implementation details:

  * The value type of an rbtree map is expected to be a struct which
    contains 'struct rb_node' at offset 0.
  * BPF programs may not modify the node struct's rb_node field.
    * Otherwise the tree could be left in corrupted state
  * Rbtree map is value-only. Keys have no meaning
  * Since the value type is not known until the rbtree map is
    instantiated, helper protos have input and return type
    'struct rb_node *' which verifier replaces with actual
    map value type.
  * [ TODO: Existing logic prevents any writes to PTR_TO_BTF_ID. This
    broadly turned off in this patch and replaced with "no writes to
    struct rb_node is PTR_TO_BTF_ID struct has one". This is a hack and
    needs to be replaced. ]

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf_types.h      |   1 +
 include/uapi/linux/bpf.h       |  62 ++++++++
 kernel/bpf/Makefile            |   2 +-
 kernel/bpf/helpers.c           |  15 ++
 kernel/bpf/rbtree.c            | 256 +++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c          | 118 ++++++++++++++-
 tools/include/uapi/linux/bpf.h |  62 ++++++++
 7 files changed, 511 insertions(+), 5 deletions(-)
 create mode 100644 kernel/bpf/rbtree.c

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 2b9112b80171..78e9b5253983 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -126,6 +126,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_STRUCT_OPS, bpf_struct_ops_=
map_ops)
 #endif
 BPF_MAP_TYPE(BPF_MAP_TYPE_RINGBUF, ringbuf_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_RBTREE, rbtree_map_ops)
=20
 BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
 BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ffcbf79a556b..4688ce88caf4 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -909,6 +909,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_INODE_STORAGE,
 	BPF_MAP_TYPE_TASK_STORAGE,
 	BPF_MAP_TYPE_BLOOM_FILTER,
+	BPF_MAP_TYPE_RBTREE,
 };
=20
 /* Note that tracing related programs such as
@@ -5328,6 +5329,62 @@ union bpf_attr {
  *		**-EACCES** if the SYN cookie is not valid.
  *
  *		**-EPROTONOSUPPORT** if CONFIG_IPV6 is not builtin.
+ *
+ * void *bpf_rbtree_alloc_node(struct bpf_map *map, u32 sz)
+ *	Description
+ *		Allocate a node of size *sz* bytes for use in rbtree *map*.
+ *
+ *		*sz* must be >=3D sizeof(struct rb_node)
+ *	Return
+ *		A pointer to the allocated node if successful, otherwise NULL.
+ *
+ *		The verifier considers the type of the returned pointer to be
+ *		the BTF id of *map*'s value type.
+ *
+ * void *bpf_rbtree_add(struct bpf_map *map, void *node, void *cb)
+ *	Description
+ *		Add *node* to rbtree *map* using *cb* comparator callback to
+ *		walk the rbtree.
+ *
+ *		*cb* must take (struct rb_node \*, const struct rb_node \*) as
+ *		input and return a bool signifying whether the first rb_node's
+ *		struct is less than the second.
+ *
+ *	Return
+ *		If success, returns a pointer to the added node in the rbtree.
+ *
+ *		If add fails, returns NULL
+ *
+ * long bpf_rbtree_find(struct bpf_map *map, void *key, void *cb)
+ *	Description
+ *		Find *key* in rbtree *map* using *cb* comparator callback to walk th=
e
+ *		rbtree.
+ *
+ *		*cb* must take (const void \*key, const struct rb_node \*n) as
+ *		input and return an int. If *cb* determines *n* to match *key*, *cb*=
 must
+ *		return 0. If larger, a positive int, and a negative int if smaller.
+ *
+ *		*key* does not need to be a rbtree node struct.
+ *
+ *	Return
+ *		Ptr to rbtree node if found, otherwise NULL.
+ *
+ * void *bpf_rbtree_remove(struct bpf_map *map, void *elem)
+ *	Description
+ *		Remove *elem* from rbtree *map*.
+ *
+ *	Return
+ *		If success, returns a pointer to the removed node.
+ *
+ *		If remove fails, returns NULL
+ *
+ * long bpf_rbtree_free_node(struct bpf_map *map, void *elem)
+ *	Description
+ *		Free rb_node that isn't associated w/ a tree.
+ *
+ *	Return
+ *		0
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5538,6 +5595,11 @@ union bpf_attr {
 	FN(tcp_raw_gen_syncookie_ipv6),	\
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
+	FN(rbtree_alloc_node),		\
+	FN(rbtree_add),		\
+	FN(rbtree_find),		\
+	FN(rbtree_remove),		\
+	FN(rbtree_free_node),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 057ba8e01e70..00eedab3ad53 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -7,7 +7,7 @@ endif
 CFLAGS_core.o +=3D $(call cc-disable-warning, override-init) $(cflags-no=
gcse-yy)
=20
 obj-$(CONFIG_BPF_SYSCALL) +=3D syscall.o verifier.o inode.o helpers.o tn=
um.o bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
-obj-$(CONFIG_BPF_SYSCALL) +=3D hashtab.o arraymap.o percpu_freelist.o bp=
f_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
+obj-$(CONFIG_BPF_SYSCALL) +=3D hashtab.o arraymap.o percpu_freelist.o bp=
f_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o rbtree.o
 obj-$(CONFIG_BPF_SYSCALL) +=3D local_storage.o queue_stack_maps.o ringbu=
f.o
 obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_local_storage.o bpf_task_storage.o
 obj-${CONFIG_BPF_LSM}	  +=3D bpf_inode_storage.o
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a1c84d256f83..35eb66d11bf6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1582,6 +1582,11 @@ const struct bpf_func_proto bpf_probe_read_user_st=
r_proto __weak;
 const struct bpf_func_proto bpf_probe_read_kernel_proto __weak;
 const struct bpf_func_proto bpf_probe_read_kernel_str_proto __weak;
 const struct bpf_func_proto bpf_task_pt_regs_proto __weak;
+const struct bpf_func_proto bpf_rbtree_alloc_node_proto __weak;
+const struct bpf_func_proto bpf_rbtree_add_proto __weak;
+const struct bpf_func_proto bpf_rbtree_find_proto __weak;
+const struct bpf_func_proto bpf_rbtree_remove_proto __weak;
+const struct bpf_func_proto bpf_rbtree_free_node_proto __weak;
=20
 const struct bpf_func_proto *
 bpf_base_func_proto(enum bpf_func_id func_id)
@@ -1671,6 +1676,16 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_timer_cancel_proto;
 	case BPF_FUNC_kptr_xchg:
 		return &bpf_kptr_xchg_proto;
+	case BPF_FUNC_rbtree_alloc_node:
+		return &bpf_rbtree_alloc_node_proto;
+	case BPF_FUNC_rbtree_add:
+		return &bpf_rbtree_add_proto;
+	case BPF_FUNC_rbtree_find:
+		return &bpf_rbtree_find_proto;
+	case BPF_FUNC_rbtree_remove:
+		return &bpf_rbtree_remove_proto;
+	case BPF_FUNC_rbtree_free_node:
+		return &bpf_rbtree_free_node_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/rbtree.c b/kernel/bpf/rbtree.c
new file mode 100644
index 000000000000..250d62210804
--- /dev/null
+++ b/kernel/bpf/rbtree.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/filter.h>
+
+struct bpf_rbtree {
+	struct bpf_map map;
+	struct rb_root_cached root;
+};
+
+BTF_ID_LIST_SINGLE(bpf_rbtree_btf_ids, struct, rb_node);
+
+static int rbtree_map_alloc_check(union bpf_attr *attr)
+{
+	if (attr->max_entries || !attr->btf_value_type_id)
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct bpf_map *rbtree_map_alloc(union bpf_attr *attr)
+{
+	struct bpf_rbtree *tree;
+	int numa_node;
+
+	if (!bpf_capable())
+		return ERR_PTR(-EPERM);
+
+	if (attr->value_size =3D=3D 0)
+		return ERR_PTR(-EINVAL);
+
+	numa_node =3D bpf_map_attr_numa_node(attr);
+	tree =3D bpf_map_area_alloc(sizeof(*tree), numa_node);
+	if (!tree)
+		return ERR_PTR(-ENOMEM);
+
+	tree->root =3D RB_ROOT_CACHED;
+	bpf_map_init_from_attr(&tree->map, attr);
+	return &tree->map;
+}
+
+static struct rb_node *rbtree_map_alloc_node(struct bpf_map *map, size_t=
 sz)
+{
+	struct rb_node *node;
+
+	node =3D bpf_map_kmalloc_node(map, sz, GFP_KERNEL, map->numa_node);
+	if (!node)
+		return NULL;
+	RB_CLEAR_NODE(node);
+	return node;
+}
+
+BPF_CALL_2(bpf_rbtree_alloc_node, struct bpf_map *, map, u32, sz)
+{
+	struct rb_node *node;
+
+	if (map->map_type !=3D BPF_MAP_TYPE_RBTREE)
+		return (u64)NULL;
+
+	if (sz < sizeof(*node))
+		return (u64)NULL;
+
+	node =3D rbtree_map_alloc_node(map, (size_t)sz);
+	if (!node)
+		return (u64)NULL;
+
+	return (u64)node;
+}
+
+const struct bpf_func_proto bpf_rbtree_alloc_node_proto =3D {
+	.func =3D bpf_rbtree_alloc_node,
+	.gpl_only =3D true,
+	.ret_type =3D RET_PTR_TO_BTF_ID_OR_NULL,
+	.ret_btf_id =3D &bpf_rbtree_btf_ids[0],
+	.arg1_type =3D ARG_CONST_MAP_PTR,
+	.arg2_type =3D ARG_CONST_ALLOC_SIZE_OR_ZERO,
+};
+
+BPF_CALL_3(bpf_rbtree_add, struct bpf_map *, map, void *, value, void *,=
 cb)
+{
+	struct bpf_rbtree *tree =3D container_of(map, struct bpf_rbtree, map);
+	struct rb_node *node =3D (struct rb_node *)value;
+
+	if (WARN_ON_ONCE(!RB_EMPTY_NODE(node)))
+		return (u64)NULL;
+
+	rb_add_cached(node, &tree->root, (bool (*)(struct rb_node *, const stru=
ct rb_node *))cb);
+	return (u64)node;
+}
+
+const struct bpf_func_proto bpf_rbtree_add_proto =3D {
+	.func =3D bpf_rbtree_add,
+	.gpl_only =3D true,
+	.ret_type =3D RET_PTR_TO_BTF_ID_OR_NULL,
+	.arg1_type =3D ARG_CONST_MAP_PTR,
+	.arg2_type =3D ARG_PTR_TO_BTF_ID | OBJ_RELEASE,
+	.arg2_btf_id =3D &bpf_rbtree_btf_ids[0],
+	.arg3_type =3D ARG_PTR_TO_FUNC,
+};
+
+BPF_CALL_3(bpf_rbtree_find, struct bpf_map *, map, void *, key, void *, =
cb)
+{
+	struct bpf_rbtree *tree =3D container_of(map, struct bpf_rbtree, map);
+
+	return (u64)rb_find(key, &tree->root.rb_root,
+			    (int (*)(const void *key,
+				     const struct rb_node *))cb);
+}
+
+const struct bpf_func_proto bpf_rbtree_find_proto =3D {
+	.func =3D bpf_rbtree_find,
+	.gpl_only =3D true,
+	.ret_type =3D RET_PTR_TO_BTF_ID_OR_NULL,
+	.ret_btf_id =3D &bpf_rbtree_btf_ids[0],
+	.arg1_type =3D ARG_CONST_MAP_PTR,
+	.arg2_type =3D ARG_ANYTHING,
+	.arg3_type =3D ARG_PTR_TO_FUNC,
+};
+
+/* Like rbtree_postorder_for_each_entry_safe, but 'pos' and 'n' are
+ * 'rb_node *', so field name of rb_node within containing struct is not
+ * needed.
+ *
+ * Since bpf_rb_tree's node always has 'struct rb_node' at offset 0 it's
+ * not necessary to know field name or type of node struct
+ */
+#define bpf_rbtree_postorder_for_each_entry_safe(pos, n, root) \
+	for (pos =3D rb_first_postorder(root); \
+	     pos && ({ n =3D rb_next_postorder(pos); 1; }); \
+	     pos =3D n)
+
+static void rbtree_map_free(struct bpf_map *map)
+{
+	struct rb_node *pos, *n;
+	struct bpf_rbtree *tree =3D container_of(map, struct bpf_rbtree, map);
+
+	bpf_rbtree_postorder_for_each_entry_safe(pos, n, &tree->root.rb_root)
+		kfree(pos);
+	bpf_map_area_free(tree);
+}
+
+static int rbtree_map_check_btf(const struct bpf_map *map,
+				const struct btf *btf,
+				const struct btf_type *key_type,
+				const struct btf_type *value_type)
+{
+	if (!map_value_has_rb_node(map))
+		return -EINVAL;
+
+	if (map->rb_node_off > 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int rbtree_map_push_elem(struct bpf_map *map, void *value, u64 fl=
ags)
+{
+	/* Use bpf_rbtree_add helper instead
+	 */
+	return -ENOTSUPP;
+}
+
+static int rbtree_map_pop_elem(struct bpf_map *map, void *value)
+{
+	return -ENOTSUPP;
+}
+
+static int rbtree_map_peek_elem(struct bpf_map *map, void *value)
+{
+	return -ENOTSUPP;
+}
+
+static void *rbtree_map_lookup_elem(struct bpf_map *map, void *value)
+{
+	/* Use bpf_rbtree_find helper instead
+	 */
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static int rbtree_map_update_elem(struct bpf_map *map, void *key, void *=
value,
+				  u64 flags)
+{
+	return -ENOTSUPP;
+}
+
+static int rbtree_map_delete_elem(struct bpf_map *map, void *value)
+{
+	return -ENOTSUPP;
+}
+
+BPF_CALL_2(bpf_rbtree_remove, struct bpf_map *, map, void *, value)
+{
+	struct bpf_rbtree *tree =3D container_of(map, struct bpf_rbtree, map);
+	struct rb_node *node =3D (struct rb_node *)value;
+
+	if (WARN_ON_ONCE(RB_EMPTY_NODE(node)))
+		return (u64)NULL;
+
+	rb_erase_cached(node, &tree->root);
+	RB_CLEAR_NODE(node);
+	return (u64)node;
+}
+
+const struct bpf_func_proto bpf_rbtree_remove_proto =3D {
+	.func =3D bpf_rbtree_remove,
+	.gpl_only =3D true,
+	.ret_type =3D RET_PTR_TO_BTF_ID_OR_NULL,
+	.ret_btf_id =3D &bpf_rbtree_btf_ids[0],
+	.arg1_type =3D ARG_CONST_MAP_PTR,
+	.arg2_type =3D ARG_PTR_TO_BTF_ID,
+	.arg2_btf_id =3D &bpf_rbtree_btf_ids[0],
+};
+
+BPF_CALL_2(bpf_rbtree_free_node, struct bpf_map *, map, void *, value)
+{
+	struct rb_node *node =3D (struct rb_node *)value;
+
+	WARN_ON_ONCE(!RB_EMPTY_NODE(node));
+	kfree(node);
+	return 0;
+}
+
+const struct bpf_func_proto bpf_rbtree_free_node_proto =3D {
+	.func =3D bpf_rbtree_free_node,
+	.gpl_only =3D true,
+	.ret_type =3D RET_INTEGER,
+	.arg1_type =3D ARG_CONST_MAP_PTR,
+	.arg2_type =3D ARG_PTR_TO_BTF_ID | OBJ_RELEASE,
+	.arg2_btf_id =3D &bpf_rbtree_btf_ids[0],
+};
+
+static int rbtree_map_get_next_key(struct bpf_map *map, void *key,
+				   void *next_key)
+{
+	return -ENOTSUPP;
+}
+
+BTF_ID_LIST_SINGLE(bpf_rbtree_map_btf_ids, struct, bpf_rbtree)
+const struct bpf_map_ops rbtree_map_ops =3D {
+	.map_meta_equal =3D bpf_map_meta_equal,
+	.map_alloc_check =3D rbtree_map_alloc_check,
+	.map_alloc =3D rbtree_map_alloc,
+	.map_free =3D rbtree_map_free,
+	.map_get_next_key =3D rbtree_map_get_next_key,
+	.map_push_elem =3D rbtree_map_push_elem,
+	.map_peek_elem =3D rbtree_map_peek_elem,
+	.map_pop_elem =3D rbtree_map_pop_elem,
+	.map_lookup_elem =3D rbtree_map_lookup_elem,
+	.map_update_elem =3D rbtree_map_update_elem,
+	.map_delete_elem =3D rbtree_map_delete_elem,
+	.map_check_btf =3D rbtree_map_check_btf,
+	.map_btf_id =3D &bpf_rbtree_map_btf_ids[0],
+};
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1f50becce141..535f673882cd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -481,7 +481,9 @@ static bool is_acquire_function(enum bpf_func_id func=
_id,
 	    func_id =3D=3D BPF_FUNC_sk_lookup_udp ||
 	    func_id =3D=3D BPF_FUNC_skc_lookup_tcp ||
 	    func_id =3D=3D BPF_FUNC_ringbuf_reserve ||
-	    func_id =3D=3D BPF_FUNC_kptr_xchg)
+	    func_id =3D=3D BPF_FUNC_kptr_xchg ||
+	    func_id =3D=3D BPF_FUNC_rbtree_alloc_node ||
+	    func_id =3D=3D BPF_FUNC_rbtree_remove)
 		return true;
=20
 	if (func_id =3D=3D BPF_FUNC_map_lookup_elem &&
@@ -531,6 +533,20 @@ static bool is_cmpxchg_insn(const struct bpf_insn *i=
nsn)
 	       insn->imm =3D=3D BPF_CMPXCHG;
 }
=20
+static bool function_manipulates_rbtree_node(enum bpf_func_id func_id)
+{
+	return func_id =3D=3D BPF_FUNC_rbtree_add ||
+		func_id =3D=3D BPF_FUNC_rbtree_remove ||
+		func_id =3D=3D BPF_FUNC_rbtree_free_node;
+}
+
+static bool function_returns_rbtree_node(enum bpf_func_id func_id)
+{
+	return func_id =3D=3D BPF_FUNC_rbtree_alloc_node ||
+		func_id =3D=3D BPF_FUNC_rbtree_add ||
+		func_id =3D=3D BPF_FUNC_rbtree_remove;
+}
+
 /* string representation of 'enum bpf_reg_type'
  *
  * Note that reg_type_str() can not appear more than once in a single ve=
rbose()
@@ -3784,6 +3800,13 @@ static int check_map_kptr_access(struct bpf_verifi=
er_env *env, u32 regno,
 	return 0;
 }
=20
+static bool access_may_touch_field(u32 access_off, size_t access_sz,
+				   u32 field_off, size_t field_sz)
+{
+	return access_off < field_off + field_sz &&
+		field_off < access_off + access_sz;
+}
+
 /* if any part of struct field can be touched by
  * load/store reject this program.
  * To check that [x1, x2) overlaps with [y1, y2)
@@ -4490,7 +4513,7 @@ static int check_ptr_to_btf_access(struct bpf_verif=
ier_env *env,
 	const char *tname =3D btf_name_by_offset(reg->btf, t->name_off);
 	enum bpf_type_flag flag =3D 0;
 	u32 btf_id;
-	int ret;
+	int ret, rb_node_off;
=20
 	if (off < 0) {
 		verbose(env,
@@ -4527,8 +4550,13 @@ static int check_ptr_to_btf_access(struct bpf_veri=
fier_env *env,
 						  off, size, atype, &btf_id, &flag);
 	} else {
 		if (atype !=3D BPF_READ) {
-			verbose(env, "only read is supported\n");
-			return -EACCES;
+			rb_node_off =3D btf_find_rb_node(reg->btf, t);
+			if (rb_node_off < 0 ||
+			    access_may_touch_field(off, size, rb_node_off,
+						   sizeof(struct rb_node))) {
+				verbose(env, "only read is supported\n");
+				return -EACCES;
+			}
 		}
=20
 		ret =3D btf_struct_access(&env->log, reg->btf, t, off, size,
@@ -5764,6 +5792,17 @@ static int check_reg_type(struct bpf_verifier_env =
*env, u32 regno,
 		if (meta->func_id =3D=3D BPF_FUNC_kptr_xchg) {
 			if (map_kptr_match_type(env, meta->kptr_off_desc, reg, regno))
 				return -EACCES;
+		} else if (function_manipulates_rbtree_node(meta->func_id)) {
+			if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
+						  meta->map_ptr->btf,
+						  meta->map_ptr->btf_value_type_id,
+						  strict_type_match)) {
+				verbose(env, "rbtree: R%d is of type %s but %s is expected\n",
+					regno, kernel_type_name(reg->btf, reg->btf_id),
+					kernel_type_name(meta->map_ptr->btf,
+							 meta->map_ptr->btf_value_type_id));
+				return -EACCES;
+			}
 		} else if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg=
->off,
 						 btf_vmlinux, *arg_btf_id,
 						 strict_type_match)) {
@@ -6369,10 +6408,17 @@ static int check_map_func_compatibility(struct bp=
f_verifier_env *env,
 		break;
 	case BPF_FUNC_map_pop_elem:
 		if (map->map_type !=3D BPF_MAP_TYPE_QUEUE &&
+		    map->map_type !=3D BPF_MAP_TYPE_RBTREE &&
 		    map->map_type !=3D BPF_MAP_TYPE_STACK)
 			goto error;
 		break;
 	case BPF_FUNC_map_peek_elem:
+		if (map->map_type !=3D BPF_MAP_TYPE_QUEUE &&
+		    map->map_type !=3D BPF_MAP_TYPE_STACK &&
+		    map->map_type !=3D BPF_MAP_TYPE_RBTREE &&
+		    map->map_type !=3D BPF_MAP_TYPE_BLOOM_FILTER)
+			goto error;
+		break;
 	case BPF_FUNC_map_push_elem:
 		if (map->map_type !=3D BPF_MAP_TYPE_QUEUE &&
 		    map->map_type !=3D BPF_MAP_TYPE_STACK &&
@@ -6828,6 +6874,57 @@ static int set_loop_callback_state(struct bpf_veri=
fier_env *env,
 	return 0;
 }
=20
+static int set_rbtree_add_callback_state(struct bpf_verifier_env *env,
+					 struct bpf_func_state *caller,
+					 struct bpf_func_state *callee,
+					 int insn_idx)
+{
+	struct bpf_map *map_ptr =3D caller->regs[BPF_REG_1].map_ptr;
+
+	/* bpf_rbtree_add(struct bpf_map *map, void *value, void *cb)
+	 * cb(struct rb_node *a, const struct rb_node *b);
+	 */
+	callee->regs[BPF_REG_1].type =3D PTR_TO_MAP_VALUE;
+	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
+	callee->regs[BPF_REG_1].map_ptr =3D map_ptr;
+
+	callee->regs[BPF_REG_2].type =3D PTR_TO_MAP_VALUE;
+	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
+	callee->regs[BPF_REG_2].map_ptr =3D map_ptr;
+
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
+	callee->in_callback_fn =3D true;
+	return 0;
+}
+
+static int set_rbtree_find_callback_state(struct bpf_verifier_env *env,
+					  struct bpf_func_state *caller,
+					  struct bpf_func_state *callee,
+					  int insn_idx)
+{
+	struct bpf_map *map_ptr =3D caller->regs[BPF_REG_1].map_ptr;
+
+	/* bpf_rbtree_find(struct bpf_map *map, void *key, void *cb)
+	 * cb(void *key, const struct rb_node *b);
+	 */
+	callee->regs[BPF_REG_1].type =3D PTR_TO_MAP_VALUE;
+	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
+	callee->regs[BPF_REG_1].map_ptr =3D map_ptr;
+
+	callee->regs[BPF_REG_2].type =3D PTR_TO_MAP_VALUE;
+	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
+	callee->regs[BPF_REG_2].map_ptr =3D map_ptr;
+
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
+	callee->in_callback_fn =3D true;
+	callee->callback_ret_range =3D tnum_range(0, U64_MAX);
+	return 0;
+}
+
 static int set_timer_callback_state(struct bpf_verifier_env *env,
 				    struct bpf_func_state *caller,
 				    struct bpf_func_state *callee,
@@ -7310,6 +7407,14 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 		err =3D __check_func_call(env, insn, insn_idx_p, meta.subprogno,
 					set_loop_callback_state);
 		break;
+	case BPF_FUNC_rbtree_add:
+		err =3D __check_func_call(env, insn, insn_idx_p, meta.subprogno,
+					set_rbtree_add_callback_state);
+		break;
+	case BPF_FUNC_rbtree_find:
+		err =3D __check_func_call(env, insn, insn_idx_p, meta.subprogno,
+					set_rbtree_find_callback_state);
+		break;
 	case BPF_FUNC_dynptr_from_mem:
 		if (regs[BPF_REG_1].type !=3D PTR_TO_MAP_VALUE) {
 			verbose(env, "Unsupported reg type %s for bpf_dynptr_from_mem data\n"=
,
@@ -7424,6 +7529,9 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
 		if (func_id =3D=3D BPF_FUNC_kptr_xchg) {
 			ret_btf =3D meta.kptr_off_desc->kptr.btf;
 			ret_btf_id =3D meta.kptr_off_desc->kptr.btf_id;
+		} else if (function_returns_rbtree_node(func_id)) {
+			ret_btf =3D meta.map_ptr->btf;
+			ret_btf_id =3D meta.map_ptr->btf_value_type_id;
 		} else {
 			ret_btf =3D btf_vmlinux;
 			ret_btf_id =3D *fn->ret_btf_id;
@@ -13462,8 +13570,10 @@ static int convert_ctx_accesses(struct bpf_verif=
ier_env *env)
 					BPF_SIZE((insn)->code);
 				env->prog->aux->num_exentries++;
 			} else if (resolve_prog_type(env->prog) !=3D BPF_PROG_TYPE_STRUCT_OPS=
) {
+				/*TODO: Not sure what to do here
 				verbose(env, "Writes through BTF pointers are not allowed\n");
 				return -EINVAL;
+				*/
 			}
 			continue;
 		default:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index ffcbf79a556b..4688ce88caf4 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -909,6 +909,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_INODE_STORAGE,
 	BPF_MAP_TYPE_TASK_STORAGE,
 	BPF_MAP_TYPE_BLOOM_FILTER,
+	BPF_MAP_TYPE_RBTREE,
 };
=20
 /* Note that tracing related programs such as
@@ -5328,6 +5329,62 @@ union bpf_attr {
  *		**-EACCES** if the SYN cookie is not valid.
  *
  *		**-EPROTONOSUPPORT** if CONFIG_IPV6 is not builtin.
+ *
+ * void *bpf_rbtree_alloc_node(struct bpf_map *map, u32 sz)
+ *	Description
+ *		Allocate a node of size *sz* bytes for use in rbtree *map*.
+ *
+ *		*sz* must be >=3D sizeof(struct rb_node)
+ *	Return
+ *		A pointer to the allocated node if successful, otherwise NULL.
+ *
+ *		The verifier considers the type of the returned pointer to be
+ *		the BTF id of *map*'s value type.
+ *
+ * void *bpf_rbtree_add(struct bpf_map *map, void *node, void *cb)
+ *	Description
+ *		Add *node* to rbtree *map* using *cb* comparator callback to
+ *		walk the rbtree.
+ *
+ *		*cb* must take (struct rb_node \*, const struct rb_node \*) as
+ *		input and return a bool signifying whether the first rb_node's
+ *		struct is less than the second.
+ *
+ *	Return
+ *		If success, returns a pointer to the added node in the rbtree.
+ *
+ *		If add fails, returns NULL
+ *
+ * long bpf_rbtree_find(struct bpf_map *map, void *key, void *cb)
+ *	Description
+ *		Find *key* in rbtree *map* using *cb* comparator callback to walk th=
e
+ *		rbtree.
+ *
+ *		*cb* must take (const void \*key, const struct rb_node \*n) as
+ *		input and return an int. If *cb* determines *n* to match *key*, *cb*=
 must
+ *		return 0. If larger, a positive int, and a negative int if smaller.
+ *
+ *		*key* does not need to be a rbtree node struct.
+ *
+ *	Return
+ *		Ptr to rbtree node if found, otherwise NULL.
+ *
+ * void *bpf_rbtree_remove(struct bpf_map *map, void *elem)
+ *	Description
+ *		Remove *elem* from rbtree *map*.
+ *
+ *	Return
+ *		If success, returns a pointer to the removed node.
+ *
+ *		If remove fails, returns NULL
+ *
+ * long bpf_rbtree_free_node(struct bpf_map *map, void *elem)
+ *	Description
+ *		Free rb_node that isn't associated w/ a tree.
+ *
+ *	Return
+ *		0
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5538,6 +5595,11 @@ union bpf_attr {
 	FN(tcp_raw_gen_syncookie_ipv6),	\
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
+	FN(rbtree_alloc_node),		\
+	FN(rbtree_add),		\
+	FN(rbtree_find),		\
+	FN(rbtree_remove),		\
+	FN(rbtree_free_node),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

