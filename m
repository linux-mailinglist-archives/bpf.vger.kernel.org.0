Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876835A6AFD
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 19:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiH3RkY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 13:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiH3Rj6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 13:39:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB43B8B2E2
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:37:13 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27UBSIJ3010941
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:35:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=8N08rjWdYAwkipbOIudqIE5mbw3dqNFIvt/ESVcSr+g=;
 b=npAN54olPuuNpxLR0Hj+eGOTb/pHMOF/QAG0+uYH1n4pa40uVG8H1R017U9S6v8yW7DU
 2XMeMAvf8ObUEKL5H6uSEs42L/rnuJy6h8G057GmR3wAsLoRpeLqEzb7Uc+WwNgsYjbH
 4fIrrwLLXhBxSJMWR8lFYmgcKjvvpLBju1g= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3j9hpwjmcg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:35:12 -0700
Received: from twshared6324.05.ash7.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 10:35:11 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 3E8E2CAD077C; Tue, 30 Aug 2022 10:28:09 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFCv2 PATCH bpf-next 09/18] bpf: Support declarative association of lock with rbtree map
Date:   Tue, 30 Aug 2022 10:27:50 -0700
Message-ID: <20220830172759.4069786-10-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220830172759.4069786-1-davemarchevsky@fb.com>
References: <20220830172759.4069786-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Hjxg4e1Ny2uCNQ6YKUpKKOlKdxQluVbN
X-Proofpoint-GUID: Hjxg4e1Ny2uCNQ6YKUpKKOlKdxQluVbN
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

This patch adds support for association of a bpf_spin_lock in an
internal arraymap with an rbtree, using the following pattern:

  struct bpf_spin_lock rbtree_lock SEC(".bss.private");

  struct {
          __uint(type, BPF_MAP_TYPE_RBTREE);
          __type(value, struct node_data);
          __array(lock, struct bpf_spin_lock);
  } rbtree SEC(".maps") =3D {
          .lock =3D {
                  [0] =3D &rbtree_lock,
          },
  };

There are a few benefits of this pattern over existing "init lock as
part of map, use bpf_rbtree_get_lock" logic:

  * Multiple rbtrees, potentially in different compilation units, may
    share the same lock

  * Lock lifetime does not need to be tied to map lifetime, aside from
    being strictly greater than map's lifetime

  * Can move from bpf_rbtree_{lock,unlock} to more generic
    bpf_{lock,unlock} helpers while still retaining static verification
    of locking behavior
    * struct bpf_rbtree still keeps lock pointer and this declarative
      association guarantees that the pointer address is known at rbtree
      map creation time

Implementation notes:

The mechanics of declarative lock association are heavily inspired by
declarative map-in-map inner map definition using __array(values,... .
Similarly to map-in-map "values", libbpf's bpf_map init_slots is used to
hold the target map, which in the above example is the .bss.private
internal arraymap. However, unlike "values" inner maps, the lock is a
map value within this map, so it's necessary to also pass the offset of
the lock symbol within the internal arraymap.

No uapi changes are necessary as existing BPF_MAP_CREATE map_extra is
used to pass the pair (fd of lock map, offset of symbol within lock map)
to the kernel when creating the rbtree map. rbtree_map_alloc can then
use this pair to find the address of the lock. Logic here is equivalent
to verifier's rewrite of BPF_PSEUDO_MAP_FD in check_ld_imm and
resolve_pseudo_ldimm64 - get actual struct bpf_map using fd, get address
of map's value region using map_direct_value_addr, add offset to get
actual lock addr.

This does introduce a dependency on the internal map containing the lock
("lock map") on both the libbpf- and kernel-side. For the former, it's
now necessary to init internal global data maps before user btf maps, as
the fd of the lock map must be known when data relo on rbtree map is
performed. For the latter, rbtree now holds refcount to the lock map to
ensure it cannot be freed until after the rbtree map is.

[
  RFC NOTE: This patch doesn't change verifier behavior, it's still doing
  dynamic lock checking. Further patches in the series change this
  behavior. This patch and the rest of the locking patches should be
  squashed, leaving in this state for now to make it easier to include
  or toss things piecemeal after feedback
]

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/rbtree.c    | 47 +++++++++++++++++---
 kernel/bpf/syscall.c   |  8 +++-
 tools/lib/bpf/libbpf.c | 99 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 136 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/rbtree.c b/kernel/bpf/rbtree.c
index 85a1d35818d0..c61662822511 100644
--- a/kernel/bpf/rbtree.c
+++ b/kernel/bpf/rbtree.c
@@ -11,6 +11,7 @@ struct bpf_rbtree {
 	struct bpf_map map;
 	struct rb_root_cached root;
 	struct bpf_spin_lock *lock;
+	struct bpf_map *lock_map;
 };
=20
 static bool __rbtree_lock_held(struct bpf_rbtree *tree)
@@ -26,10 +27,22 @@ static int rbtree_map_alloc_check(union bpf_attr *att=
r)
 	return 0;
 }
=20
+static void __rbtree_map_free(struct bpf_rbtree *tree)
+{
+	if (tree->lock_map)
+		bpf_map_put(tree->lock_map);
+	else if (tree->lock)
+		kfree(tree->lock);
+	bpf_map_area_free(tree);
+}
+
 static struct bpf_map *rbtree_map_alloc(union bpf_attr *attr)
 {
+	u32 lock_map_ufd, lock_map_offset;
 	struct bpf_rbtree *tree;
+	u64 lock_map_addr;
 	int numa_node;
+	int err;
=20
 	if (!bpf_capable())
 		return ERR_PTR(-EPERM);
@@ -45,14 +58,35 @@ static struct bpf_map *rbtree_map_alloc(union bpf_att=
r *attr)
 	tree->root =3D RB_ROOT_CACHED;
 	bpf_map_init_from_attr(&tree->map, attr);
=20
-	tree->lock =3D bpf_map_kzalloc(&tree->map, sizeof(struct bpf_spin_lock)=
,
-				     GFP_KERNEL | __GFP_NOWARN);
-	if (!tree->lock) {
-		bpf_map_area_free(tree);
-		return ERR_PTR(-ENOMEM);
+	if (!attr->map_extra) {
+		tree->lock =3D bpf_map_kzalloc(&tree->map, sizeof(struct bpf_spin_lock=
),
+					     GFP_KERNEL | __GFP_NOWARN);
+		if (!tree->lock) {
+			err =3D -ENOMEM;
+			goto err_free;
+		}
+	} else {
+		lock_map_ufd =3D (u32)(attr->map_extra >> 32);
+		lock_map_offset =3D (u32)attr->map_extra;
+		tree->lock_map =3D bpf_map_get(lock_map_ufd);
+		if (IS_ERR(tree->lock_map) || !tree->lock_map->ops->map_direct_value_a=
ddr) {
+			err =3D PTR_ERR(tree->lock_map);
+			tree->lock_map =3D NULL;
+			goto err_free;
+		}
+
+		err =3D tree->lock_map->ops->map_direct_value_addr(tree->lock_map, &lo=
ck_map_addr,
+								 lock_map_offset);
+		if (err)
+			goto err_free;
+
+		tree->lock =3D (struct bpf_spin_lock *)(lock_map_addr + lock_map_offse=
t);
 	}
=20
 	return &tree->map;
+err_free:
+	__rbtree_map_free(tree);
+	return ERR_PTR(err);
 }
=20
 static struct rb_node *rbtree_map_alloc_node(struct bpf_map *map, size_t=
 sz)
@@ -159,8 +193,7 @@ static void rbtree_map_free(struct bpf_map *map)
=20
 	bpf_rbtree_postorder_for_each_entry_safe(pos, n, &tree->root.rb_root)
 		kfree(pos);
-	kfree(tree->lock);
-	bpf_map_area_free(tree);
+	__rbtree_map_free(tree);
 }
=20
 static int rbtree_map_check_btf(const struct bpf_map *map,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3947fbd137af..fa1220394462 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1066,6 +1066,12 @@ static int map_check_btf(struct bpf_map *map, cons=
t struct btf *btf,
 	return ret;
 }
=20
+static bool map_uses_map_extra(enum bpf_map_type type)
+{
+	return type =3D=3D BPF_MAP_TYPE_BLOOM_FILTER ||
+	       type =3D=3D BPF_MAP_TYPE_RBTREE;
+}
+
 #define BPF_MAP_CREATE_LAST_FIELD map_extra
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
@@ -1087,7 +1093,7 @@ static int map_create(union bpf_attr *attr)
 		return -EINVAL;
 	}
=20
-	if (attr->map_type !=3D BPF_MAP_TYPE_BLOOM_FILTER &&
+	if (!map_uses_map_extra(attr->map_type) &&
 	    attr->map_extra !=3D 0)
 		return -EINVAL;
=20
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a6dd53e0c4b4..10c840137bac 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1429,6 +1429,11 @@ bpf_object__init_kversion(struct bpf_object *obj, =
void *data, size_t size)
 	return 0;
 }
=20
+static bool bpf_map_type__uses_lock_def(enum bpf_map_type type)
+{
+	return type =3D=3D BPF_MAP_TYPE_RBTREE;
+}
+
 static bool bpf_map_type__is_map_in_map(enum bpf_map_type type)
 {
 	if (type =3D=3D BPF_MAP_TYPE_ARRAY_OF_MAPS ||
@@ -1517,6 +1522,16 @@ static size_t bpf_map_mmap_sz(const struct bpf_map=
 *map)
 	return map_sz;
 }
=20
+static bool internal_map_in_custom_section(const char *real_name)
+{
+	if (strchr(real_name + 1, '.') !=3D NULL) {
+		if (strcmp(real_name, BSS_SEC_PRIVATE) =3D=3D 0)
+			return false;
+		return true;
+	}
+	return false;
+}
+
 static char *internal_map_name(struct bpf_object *obj, const char *real_=
name)
 {
 	char map_name[BPF_OBJ_NAME_LEN], *p;
@@ -1559,7 +1574,7 @@ static char *internal_map_name(struct bpf_object *o=
bj, const char *real_name)
 		sfx_len =3D BPF_OBJ_NAME_LEN - 1;
=20
 	/* if there are two or more dots in map name, it's a custom dot map */
-	if (strchr(real_name + 1, '.') !=3D NULL)
+	if (internal_map_in_custom_section(real_name))
 		pfx_len =3D 0;
 	else
 		pfx_len =3D min((size_t)BPF_OBJ_NAME_LEN - sfx_len - 1, strlen(obj->na=
me));
@@ -2331,10 +2346,23 @@ int parse_btf_map_def(const char *map_name, struc=
t btf *btf,
 		} else if (strcmp(name, "map_extra") =3D=3D 0) {
 			__u32 map_extra;
=20
+			if (bpf_map_type__uses_lock_def(map_def->map_type)) {
+				pr_warn("map '%s': can't set map_extra for map using 'lock' def.\n",
+					map_name);
+				return -EINVAL;
+			}
+
 			if (!get_map_field_int(map_name, btf, m, &map_extra))
 				return -EINVAL;
 			map_def->map_extra =3D map_extra;
 			map_def->parts |=3D MAP_DEF_MAP_EXTRA;
+		} else if (strcmp(name, "lock") =3D=3D 0) {
+			if (!bpf_map_type__uses_lock_def(map_def->map_type)) {
+				pr_warn("map '%s': can't set 'lock' for map.\n", map_name);
+				return -ENOTSUP;
+			}
+			/* TODO: More sanity checking
+			 */
 		} else {
 			if (strict) {
 				pr_warn("map '%s': unknown field '%s'.\n", map_name, name);
@@ -2603,8 +2631,8 @@ static int bpf_object__init_maps(struct bpf_object =
*obj,
 	strict =3D !OPTS_GET(opts, relaxed_maps, false);
 	pin_root_path =3D OPTS_GET(opts, pin_root_path, NULL);
=20
-	err =3D err ?: bpf_object__init_user_btf_maps(obj, strict, pin_root_pat=
h);
 	err =3D err ?: bpf_object__init_global_data_maps(obj);
+	err =3D err ?: bpf_object__init_user_btf_maps(obj, strict, pin_root_pat=
h);
 	err =3D err ?: bpf_object__init_kconfig_map(obj);
 	err =3D err ?: bpf_object__init_struct_ops_maps(obj);
=20
@@ -4865,6 +4893,25 @@ static bool map_is_reuse_compat(const struct bpf_m=
ap *map, int map_fd)
 		map_info.map_extra =3D=3D map->map_extra);
 }
=20
+static struct bpf_map *find_internal_map_by_shndx(struct bpf_object *obj=
,
+						  int shndx)
+{
+	struct bpf_map *map;
+	int i;
+
+	for (i =3D 0; i < obj->nr_maps; i++) {
+		map =3D &obj->maps[i];
+
+		if (!bpf_map__is_internal(map))
+			continue;
+
+		if (map->sec_idx =3D=3D shndx)
+			return map;
+	}
+
+	return NULL;
+}
+
 static int
 bpf_object__reuse_map(struct bpf_map *map)
 {
@@ -4981,6 +5028,19 @@ static int bpf_object__create_map(struct bpf_objec=
t *obj, struct bpf_map *map, b
 		}
 		if (map->inner_map_fd >=3D 0)
 			create_attr.inner_map_fd =3D map->inner_map_fd;
+	} else if (bpf_map_type__uses_lock_def(def->type)) {
+		if (map->init_slots_sz !=3D 1) {
+			pr_warn("map '%s': expecting single lock def, actual count %d\n",
+				map->name, map->init_slots_sz);
+			return -EINVAL;
+		}
+
+		if (bpf_map__fd(map->init_slots[0]) < 0) {
+			pr_warn("map '%s': failed to find lock map fd\n", map->name);
+			return -EINVAL;
+		}
+
+		create_attr.map_extra |=3D (__u64)bpf_map__fd(map->init_slots[0]) << 3=
2;
 	}
=20
 	switch (def->type) {
@@ -5229,8 +5289,7 @@ bpf_object__create_maps(struct bpf_object *obj)
 					goto err_out;
 				}
 			}
-
-			if (map->init_slots_sz && map->def.type !=3D BPF_MAP_TYPE_PROG_ARRAY)=
 {
+			if (map->init_slots_sz && bpf_map_type__is_map_in_map(map->def.type))=
 {
 				err =3D init_map_in_map_slots(obj, map);
 				if (err < 0) {
 					zclose(map->fd);
@@ -6424,9 +6483,9 @@ static int bpf_object__collect_map_relos(struct bpf=
_object *obj,
 	const struct btf_type *sec, *var, *def;
 	struct bpf_map *map =3D NULL, *targ_map =3D NULL;
 	struct bpf_program *targ_prog =3D NULL;
-	bool is_prog_array, is_map_in_map;
 	const struct btf_member *member;
 	const char *name, *mname, *type;
+	bool is_prog_array;
 	unsigned int moff;
 	Elf64_Sym *sym;
 	Elf64_Rel *rel;
@@ -6474,10 +6533,12 @@ static int bpf_object__collect_map_relos(struct b=
pf_object *obj,
 			return -EINVAL;
 		}
=20
-		is_map_in_map =3D bpf_map_type__is_map_in_map(map->def.type);
+		/* PROG_ARRAY passes prog pointers using init_slots, other map
+		 * types pass map pointers
+		 */
 		is_prog_array =3D map->def.type =3D=3D BPF_MAP_TYPE_PROG_ARRAY;
-		type =3D is_map_in_map ? "map" : "prog";
-		if (is_map_in_map) {
+		type =3D is_prog_array ? "prog" : "map";
+		if (bpf_map_type__is_map_in_map(map->def.type)) {
 			if (sym->st_shndx !=3D obj->efile.btf_maps_shndx) {
 				pr_warn(".maps relo #%d: '%s' isn't a BTF-defined map\n",
 					i, name);
@@ -6509,6 +6570,24 @@ static int bpf_object__collect_map_relos(struct bp=
f_object *obj,
 					i, name);
 				return -LIBBPF_ERRNO__RELOC;
 			}
+		} else if (bpf_map_type__uses_lock_def(map->def.type)) {
+			targ_map =3D find_internal_map_by_shndx(obj, sym->st_shndx);
+			if (!targ_map) {
+				pr_warn(".maps relo #%d: '%s' isn't a valid map reference\n",
+					i, name);
+				return -LIBBPF_ERRNO__RELOC;
+			}
+
+			/* This shouldn't happen, check in parse_btf_map_def
+			 * should catch this, but to be safe let's prevent
+			 * map_extra overwrite
+			 */
+			if (map->map_extra) {
+				pr_warn(".maps rbtree relo #%d: map '%s' has ", i, map->name);
+				pr_warn("map_extra, can't relo lock, internal error.\n");
+				return -EINVAL;
+			}
+			map->map_extra =3D sym->st_value;
 		} else {
 			return -EINVAL;
 		}
@@ -6519,7 +6598,7 @@ static int bpf_object__collect_map_relos(struct bpf=
_object *obj,
 			return -EINVAL;
 		member =3D btf_members(def) + btf_vlen(def) - 1;
 		mname =3D btf__name_by_offset(obj->btf, member->name_off);
-		if (strcmp(mname, "values"))
+		if (strcmp(mname, "values") && strcmp(mname, "lock"))
 			return -EINVAL;
=20
 		moff =3D btf_member_bit_offset(def, btf_vlen(def) - 1) / 8;
@@ -6543,7 +6622,7 @@ static int bpf_object__collect_map_relos(struct bpf=
_object *obj,
 			       (new_sz - map->init_slots_sz) * host_ptr_sz);
 			map->init_slots_sz =3D new_sz;
 		}
-		map->init_slots[moff] =3D is_map_in_map ? (void *)targ_map : (void *)t=
arg_prog;
+		map->init_slots[moff] =3D is_prog_array ? (void *)targ_prog : (void *)=
targ_map;
=20
 		pr_debug(".maps relo #%d: map '%s' slot [%d] points to %s '%s'\n",
 			 i, map->name, moff, type, name);
--=20
2.30.2

