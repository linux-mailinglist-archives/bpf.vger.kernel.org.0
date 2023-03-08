Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C606AFB8B
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 01:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjCHAvL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 19:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjCHAvK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 19:51:10 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F57A9DE6
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 16:51:07 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32805C3U001603
        for <bpf@vger.kernel.org>; Tue, 7 Mar 2023 16:51:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=FmFC/fk4R/DY9zzfOK97UWbCCbj8c72kQ/I1CQbIrXE=;
 b=K59yPESZTMjZTycqy/ffEzrxzPVsU2ENTo8m5Ak4JJXp/9P1RztU3983MZXdY9SVl3oL
 TCHnb4kbbjZ4ZMNmmTQgeunaCLnS2vChFRJzdbSzqYCbo4ZZa9hBnpgqoMPkoPkYI/l1
 iu7Zz8qpEzl/EdnD1VcHfjUtCRyrcvYUnkz7dzanPzSWi4ZELavpO+tS1pWXkMhKgJZs
 osBK/SHqJ63GE+pL3OvRCUhjEusNybAvXWLrjNJVWETDX2VTO6BZken7xs4QsoigyBK1
 XzlAQ3NiOPnvIYBKgnwCjtngdaoSdHP4+XQKOlT4JY24v71C80VfL1IBOOkQi86YLIOV YA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p6fgp071f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 16:51:07 -0800
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 7 Mar 2023 16:51:05 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 8A4496C92E18; Tue,  7 Mar 2023 16:50:54 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>,
        <sdf@google.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v5 3/8] bpf: Create links for BPF struct_ops maps.
Date:   Tue, 7 Mar 2023 16:50:45 -0800
Message-ID: <20230308005050.255859-4-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308005050.255859-1-kuifeng@meta.com>
References: <20230308005050.255859-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: oS69KoqU65lUhApCNs69NE7QLodRCJ_I
X-Proofpoint-ORIG-GUID: oS69KoqU65lUhApCNs69NE7QLodRCJ_I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_18,2023-03-07_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF struct_ops maps are employed directly to register TCP Congestion
Control algorithms. Unlike other BPF programs that terminate when
their links gone. The link of a BPF struct_ops map provides a uniform
experience akin to other types of BPF programs.

bpf_links are responsible for registering their associated
struct_ops. You can only use a struct_ops that has the BPF_F_LINK flag
set to create a bpf_link, while a structs without this flag behaves in
the same manner as before and is registered upon updating its value.

The BPF_LINK_TYPE_STRUCT_OPS serves a dual purpose. Not only is it
used to craft the links for BPF struct_ops programs, but also to
create links for BPF struct_ops them-self.  Since the links of BPF
struct_ops programs are only used to create trampolines internally,
they are never seen in other contexts. Thus, they can be reused for
struct_ops themself.

To maintain a reference to the map supporting this link, we add
bpf_struct_ops_link as an additional type. The pointer of the map is
RCU and won't be necessary until later in the patchset.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 include/linux/bpf.h            |  11 +++
 include/uapi/linux/bpf.h       |  12 +++-
 kernel/bpf/bpf_struct_ops.c    | 124 +++++++++++++++++++++++++++++++--
 kernel/bpf/syscall.c           |  23 +++---
 tools/include/uapi/linux/bpf.h |  12 +++-
 5 files changed, 168 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 00b6e1a2edaf..afca6c526fe4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1548,6 +1548,7 @@ static inline void bpf_module_put(const void *data,=
 struct module *owner)
 	else
 		module_put(owner);
 }
+int bpf_struct_ops_link_create(union bpf_attr *attr);
=20
 #ifdef CONFIG_NET
 /* Define it here to avoid the use of forward declaration */
@@ -1588,6 +1589,11 @@ static inline int bpf_struct_ops_map_sys_lookup_el=
em(struct bpf_map *map,
 {
 	return -EINVAL;
 }
+static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
=20
 #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_LSM)
@@ -2379,6 +2385,11 @@ static inline void bpf_link_put(struct bpf_link *l=
ink)
 {
 }
=20
+static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int bpf_obj_get_user(const char __user *pathname, int flag=
s)
 {
 	return -EOPNOTSUPP;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 976b194eb775..f9fc7b8af3c4 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1033,6 +1033,7 @@ enum bpf_attach_type {
 	BPF_PERF_EVENT,
 	BPF_TRACE_KPROBE_MULTI,
 	BPF_LSM_CGROUP,
+	BPF_STRUCT_OPS,
 	__MAX_BPF_ATTACH_TYPE
 };
=20
@@ -1266,6 +1267,9 @@ enum {
=20
 /* Create a map that is suitable to be an inner map with dynamic max ent=
ries */
 	BPF_F_INNER_MAP		=3D (1U << 12),
+
+/* Create a map that will be registered/unregesitered by the backed bpf_=
link */
+	BPF_F_LINK		=3D (1U << 13),
 };
=20
 /* Flags for BPF_PROG_QUERY. */
@@ -1507,7 +1511,10 @@ union bpf_attr {
 	} task_fd_query;
=20
 	struct { /* struct used by BPF_LINK_CREATE command */
-		__u32		prog_fd;	/* eBPF program to attach */
+		union {
+			__u32		prog_fd;	/* eBPF program to attach */
+			__u32		map_fd;		/* struct_ops to attach */
+		};
 		union {
 			__u32		target_fd;	/* object to attach to */
 			__u32		target_ifindex; /* target ifindex */
@@ -6379,6 +6386,9 @@ struct bpf_link_info {
 		struct {
 			__u32 ifindex;
 		} xdp;
+		struct {
+			__u32 map_id;
+		} struct_ops;
 	};
 } __attribute__((aligned(8)));
=20
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 9e097fcc9cf4..5a7e86cf67b5 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -16,6 +16,7 @@ enum bpf_struct_ops_state {
 	BPF_STRUCT_OPS_STATE_INIT,
 	BPF_STRUCT_OPS_STATE_INUSE,
 	BPF_STRUCT_OPS_STATE_TOBEFREE,
+	BPF_STRUCT_OPS_STATE_READY,
 };
=20
 #define BPF_STRUCT_OPS_COMMON_VALUE			\
@@ -58,6 +59,11 @@ struct bpf_struct_ops_map {
 	struct bpf_struct_ops_value kvalue;
 };
=20
+struct bpf_struct_ops_link {
+	struct bpf_link link;
+	struct bpf_map __rcu *map;
+};
+
 static DEFINE_MUTEX(update_mutex);
=20
 #define VALUE_PREFIX "bpf_struct_ops_"
@@ -496,11 +502,24 @@ static int bpf_struct_ops_map_update_elem(struct bp=
f_map *map, void *key,
 		*(unsigned long *)(udata + moff) =3D prog->aux->id;
 	}
=20
-	bpf_map_inc(map);
-
 	set_memory_rox((long)st_map->image, 1);
+	if (st_map->map.map_flags & BPF_F_LINK) {
+		if (st_ops->validate) {
+			err =3D st_ops->validate(kdata);
+			if (err)
+				goto unlock;
+		}
+		/* Let bpf_link handle registration & unregistration.
+		 *
+		 * Pair with smp_load_acquire() during lookup_elem().
+		 */
+		smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_READY);
+		goto unlock;
+	}
+
 	err =3D st_ops->reg(kdata);
 	if (likely(!err)) {
+		bpf_map_inc(map);
 		/* Pair with smp_load_acquire() during lookup_elem().
 		 * It ensures the above udata updates (e.g. prog->aux->id)
 		 * can be seen once BPF_STRUCT_OPS_STATE_INUSE is set.
@@ -516,7 +535,6 @@ static int bpf_struct_ops_map_update_elem(struct bpf_=
map *map, void *key,
 	 */
 	set_memory_nx((long)st_map->image, 1);
 	set_memory_rw((long)st_map->image, 1);
-	bpf_map_put(map);
=20
 reset_unlock:
 	bpf_struct_ops_map_put_progs(st_map);
@@ -534,6 +552,9 @@ static int bpf_struct_ops_map_delete_elem(struct bpf_=
map *map, void *key)
 	struct bpf_struct_ops_map *st_map;
=20
 	st_map =3D (struct bpf_struct_ops_map *)map;
+	if (st_map->map.map_flags & BPF_F_LINK)
+		return -EOPNOTSUPP;
+
 	prev_state =3D cmpxchg(&st_map->kvalue.state,
 			     BPF_STRUCT_OPS_STATE_INUSE,
 			     BPF_STRUCT_OPS_STATE_TOBEFREE);
@@ -601,7 +622,7 @@ static void bpf_struct_ops_map_free(struct bpf_map *m=
ap)
 static int bpf_struct_ops_map_alloc_check(union bpf_attr *attr)
 {
 	if (attr->key_size !=3D sizeof(unsigned int) || attr->max_entries !=3D =
1 ||
-	    attr->map_flags || !attr->btf_vmlinux_value_type_id)
+	    (attr->map_flags & ~BPF_F_LINK) || !attr->btf_vmlinux_value_type_id=
)
 		return -EINVAL;
 	return 0;
 }
@@ -712,3 +733,98 @@ void bpf_struct_ops_put(const void *kdata)
=20
 	bpf_map_put(&st_map->map);
 }
+
+static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
+{
+	struct bpf_struct_ops_link *st_link;
+	struct bpf_struct_ops_map *st_map;
+
+	st_link =3D container_of(link, struct bpf_struct_ops_link, link);
+	st_map =3D (struct bpf_struct_ops_map *)st_link->map;
+	st_map->st_ops->unreg(&st_map->kvalue.data);
+	bpf_map_put(st_link->map);
+	kfree(st_link);
+}
+
+static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link *l=
ink,
+					    struct seq_file *seq)
+{
+	struct bpf_struct_ops_link *st_link;
+	struct bpf_map *map;
+
+	st_link =3D container_of(link, struct bpf_struct_ops_link, link);
+	rcu_read_lock();
+	map =3D rcu_dereference(st_link->map);
+	if (map)
+		seq_printf(seq, "map_id:\t%d\n", map->id);
+	rcu_read_unlock();
+}
+
+static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link =
*link,
+					       struct bpf_link_info *info)
+{
+	struct bpf_struct_ops_link *st_link;
+	struct bpf_map *map;
+
+	st_link =3D container_of(link, struct bpf_struct_ops_link, link);
+	rcu_read_lock();
+	map =3D rcu_dereference(st_link->map);
+	if (map)
+		info->struct_ops.map_id =3D map->id;
+	rcu_read_unlock();
+	return 0;
+}
+
+static const struct bpf_link_ops bpf_struct_ops_map_lops =3D {
+	.dealloc =3D bpf_struct_ops_map_link_dealloc,
+	.show_fdinfo =3D bpf_struct_ops_map_link_show_fdinfo,
+	.fill_link_info =3D bpf_struct_ops_map_link_fill_link_info,
+};
+
+int bpf_struct_ops_link_create(union bpf_attr *attr)
+{
+	struct bpf_struct_ops_link *link =3D NULL;
+	struct bpf_link_primer link_primer;
+	struct bpf_struct_ops_map *st_map;
+	struct bpf_map *map;
+	int err;
+
+	map =3D bpf_map_get(attr->link_create.map_fd);
+	if (!map)
+		return -EINVAL;
+
+	st_map =3D (struct bpf_struct_ops_map *)map;
+
+	if (map->map_type !=3D BPF_MAP_TYPE_STRUCT_OPS || !(map->map_flags & BP=
F_F_LINK) ||
+	    /* Pair with smp_store_release() during map_update */
+	    smp_load_acquire(&st_map->kvalue.state) !=3D BPF_STRUCT_OPS_STATE_R=
EADY) {
+		err =3D -EINVAL;
+		goto err_out;
+	}
+
+	link =3D kzalloc(sizeof(*link), GFP_USER);
+	if (!link) {
+		err =3D -ENOMEM;
+		goto err_out;
+	}
+	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_ma=
p_lops, NULL);
+	RCU_INIT_POINTER(link->map, map);
+
+	err =3D bpf_link_prime(&link->link, &link_primer);
+	if (err)
+		goto err_out;
+
+	err =3D st_map->st_ops->reg(st_map->kvalue.data);
+	if (err) {
+		bpf_link_cleanup(&link_primer);
+		goto err_out;
+	}
+
+	return bpf_link_settle(&link_primer);
+
+err_out:
+	bpf_map_put(map);
+	kfree(link);
+	return err;
+}
+
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 03273cddd6bd..3a4503987a48 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2806,16 +2806,19 @@ static void bpf_link_show_fdinfo(struct seq_file =
*m, struct file *filp)
 	const struct bpf_prog *prog =3D link->prog;
 	char prog_tag[sizeof(prog->tag) * 2 + 1] =3D { };
=20
-	bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
 	seq_printf(m,
 		   "link_type:\t%s\n"
-		   "link_id:\t%u\n"
-		   "prog_tag:\t%s\n"
-		   "prog_id:\t%u\n",
+		   "link_id:\t%u\n",
 		   bpf_link_type_strs[link->type],
-		   link->id,
-		   prog_tag,
-		   prog->aux->id);
+		   link->id);
+	if (prog) {
+		bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
+		seq_printf(m,
+			   "prog_tag:\t%s\n"
+			   "prog_id:\t%u\n",
+			   prog_tag,
+			   prog->aux->id);
+	}
 	if (link->ops->show_fdinfo)
 		link->ops->show_fdinfo(link, m);
 }
@@ -4290,7 +4293,8 @@ static int bpf_link_get_info_by_fd(struct file *fil=
e,
=20
 	info.type =3D link->type;
 	info.id =3D link->id;
-	info.prog_id =3D link->prog->aux->id;
+	if (link->prog)
+		info.prog_id =3D link->prog->aux->id;
=20
 	if (link->ops->fill_link_info) {
 		err =3D link->ops->fill_link_info(link, &info);
@@ -4553,6 +4557,9 @@ static int link_create(union bpf_attr *attr, bpfptr=
_t uattr)
 	if (CHECK_ATTR(BPF_LINK_CREATE))
 		return -EINVAL;
=20
+	if (attr->link_create.attach_type =3D=3D BPF_STRUCT_OPS)
+		return bpf_struct_ops_link_create(attr);
+
 	prog =3D bpf_prog_get(attr->link_create.prog_fd);
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 976b194eb775..051b85525302 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1033,6 +1033,7 @@ enum bpf_attach_type {
 	BPF_PERF_EVENT,
 	BPF_TRACE_KPROBE_MULTI,
 	BPF_LSM_CGROUP,
+	BPF_STRUCT_OPS,
 	__MAX_BPF_ATTACH_TYPE
 };
=20
@@ -1266,6 +1267,9 @@ enum {
=20
 /* Create a map that is suitable to be an inner map with dynamic max ent=
ries */
 	BPF_F_INNER_MAP		=3D (1U << 12),
+
+/* Create a map that will be registered/unregesitered by the backed bpf_=
link */
+	BPF_F_LINK		=3D (1U << 13),
 };
=20
 /* Flags for BPF_PROG_QUERY. */
@@ -1507,7 +1511,10 @@ union bpf_attr {
 	} task_fd_query;
=20
 	struct { /* struct used by BPF_LINK_CREATE command */
-		__u32		prog_fd;	/* eBPF program to attach */
+		union {
+			__u32		prog_fd;	/* eBPF program to attach */
+			__u32		map_fd;		/* eBPF struct_ops to attach */
+		};
 		union {
 			__u32		target_fd;	/* object to attach to */
 			__u32		target_ifindex; /* target ifindex */
@@ -6379,6 +6386,9 @@ struct bpf_link_info {
 		struct {
 			__u32 ifindex;
 		} xdp;
+		struct {
+			__u32 map_id;
+		} struct_ops;
 	};
 } __attribute__((aligned(8)));
=20
--=20
2.34.1

