Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D10560DA47
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 06:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiJZE3H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 00:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiJZE3H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 00:29:07 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C2DAB831
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 21:29:05 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PMGwDF013394
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 21:29:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=rwO+/Pj6GeKFdoYfqG9KrI3pexA6wtWZrJo0S0eH2DM=;
 b=cLIMR2XO8FtjAfzFZaI3DBqzlPq+xgUuaTjXuULlQpb7WSsgmw/5adjUsjJ+84HVq5As
 gxiadmgGHFExPhugDyscptXwJo77IixGq+ac3LxkRD/cV/wdhXvfROqZHkPkavgJOfKs
 uQksDSOKosaQHQtLon0dq++SmejUlFZTY6Q= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3keb4jum2b-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 21:29:04 -0700
Received: from twshared9088.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 21:29:02 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id E71BC1131B85E; Tue, 25 Oct 2022 21:28:50 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v6 3/9] bpf: Implement cgroup storage available to non-cgroup-attached bpf progs
Date:   Tue, 25 Oct 2022 21:28:50 -0700
Message-ID: <20221026042850.673791-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221026042835.672317-1-yhs@fb.com>
References: <20221026042835.672317-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ZVQIwwXPz3atBodC1TTgxyOjU2eLYZ2m
X-Proofpoint-ORIG-GUID: ZVQIwwXPz3atBodC1TTgxyOjU2eLYZ2m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_02,2022-10-25_01,2022-06-22_01
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similar to sk/inode/task storage, implement similar cgroup local storage.

There already exists a local storage implementation for cgroup-attached
bpf programs.  See map type BPF_MAP_TYPE_CGROUP_STORAGE and helper
bpf_get_local_storage(). But there are use cases such that non-cgroup
attached bpf progs wants to access cgroup local storage data. For example=
,
tc egress prog has access to sk and cgroup. It is possible to use
sk local storage to emulate cgroup local storage by storing data in socke=
t.
But this is a waste as it could be lots of sockets belonging to a particu=
lar
cgroup. Alternatively, a separate map can be created with cgroup id as th=
e key.
But this will introduce additional overhead to manipulate the new map.
A cgroup local storage, similar to existing sk/inode/task storage,
should help for this use case.

The life-cycle of storage is managed with the life-cycle of the
cgroup struct.  i.e. the storage is destroyed along with the owning cgrou=
p
with a call to bpf_cgrp_storage_free() when cgroup itself
is deleted.

The userspace map operations can be done by using a cgroup fd as a key
passed to the lookup, update and delete operations.

Typically, the following code is used to get the current cgroup:
    struct task_struct *task =3D bpf_get_current_task_btf();
    ... task->cgroups->dfl_cgrp ...
and in structure task_struct definition:
    struct task_struct {
        ....
        struct css_set __rcu            *cgroups;
        ....
    }
With sleepable program, accessing task->cgroups is not protected by rcu_r=
ead_lock.
So the current implementation only supports non-sleepable program and sup=
porting
sleepable program will be the next step together with adding rcu_read_loc=
k
protection for rcu tagged structures.

Since map name BPF_MAP_TYPE_CGROUP_STORAGE has been used for old cgroup l=
ocal
storage support, the new map name BPF_MAP_TYPE_CGRP_STORAGE is used
for cgroup storage available to non-cgroup-attached bpf programs. The old
cgroup storage supports bpf_get_local_storage() helper to get the cgroup =
data.
The new cgroup storage helper bpf_cgrp_storage_get() can provide similar
functionality. While old cgroup storage pre-allocates storage memory, the=
 new
mechanism can also pre-allocate with a user space bpf_map_update_elem() c=
all
to avoid potential run-time memory allocation failure.
Therefore, the new cgroup storage can provide all functionality w.r.t.
the old one. So in uapi bpf.h, the old BPF_MAP_TYPE_CGROUP_STORAGE is ali=
as to
BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED to indicate the old cgroup storage=
 can
be deprecated since the new one can provide the same functionality.

Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h            |   7 +
 include/linux/bpf_types.h      |   1 +
 include/linux/cgroup-defs.h    |   4 +
 include/uapi/linux/bpf.h       |  50 ++++++-
 kernel/bpf/Makefile            |   2 +-
 kernel/bpf/bpf_cgrp_storage.c  | 247 +++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c           |   6 +
 kernel/bpf/syscall.c           |   3 +-
 kernel/bpf/verifier.c          |  13 +-
 kernel/cgroup/cgroup.c         |   1 +
 kernel/trace/bpf_trace.c       |   4 +
 scripts/bpf_doc.py             |   2 +
 tools/include/uapi/linux/bpf.h |  50 ++++++-
 13 files changed, 385 insertions(+), 5 deletions(-)
 create mode 100644 kernel/bpf/bpf_cgrp_storage.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9e7d46d16032..0fa3b4f6e777 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2045,6 +2045,7 @@ struct bpf_link *bpf_link_by_id(u32 id);
=20
 const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_i=
d);
 void bpf_task_storage_free(struct task_struct *task);
+void bpf_cgrp_storage_free(struct cgroup *cgroup);
 bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
 const struct btf_func_model *
 bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
@@ -2299,6 +2300,10 @@ static inline bool has_current_bpf_ctx(void)
 static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog)
 {
 }
+
+static inline void bpf_cgrp_storage_free(struct cgroup *cgroup)
+{
+}
 #endif /* CONFIG_BPF_SYSCALL */
=20
 void __bpf_free_used_btfs(struct bpf_prog_aux *aux,
@@ -2537,6 +2542,8 @@ extern const struct bpf_func_proto bpf_copy_from_us=
er_task_proto;
 extern const struct bpf_func_proto bpf_set_retval_proto;
 extern const struct bpf_func_proto bpf_get_retval_proto;
 extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
+extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
+extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
=20
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 2c6a4f2562a7..d4ee3ccd3753 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -86,6 +86,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_PROG_ARRAY, prog_array_map_op=
s)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERF_EVENT_ARRAY, perf_event_array_map_ops)
 #ifdef CONFIG_CGROUPS
 BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_ARRAY, cgroup_array_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_CGRP_STORAGE, cgrp_storage_map_ops)
 #endif
 #ifdef CONFIG_CGROUP_BPF
 BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_STORAGE, cgroup_storage_map_ops)
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 8f481d1b159a..c466fdc3a32a 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -504,6 +504,10 @@ struct cgroup {
 	/* Used to store internal freezer state */
 	struct cgroup_freezer_state freezer;
=20
+#ifdef CONFIG_BPF_SYSCALL
+	struct bpf_local_storage __rcu  *bpf_cgrp_storage;
+#endif
+
 	/* All ancestors including self */
 	struct cgroup *ancestors[];
 };
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 17f61338f8f8..94659f6b3395 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -922,7 +922,14 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_CPUMAP,
 	BPF_MAP_TYPE_XSKMAP,
 	BPF_MAP_TYPE_SOCKHASH,
-	BPF_MAP_TYPE_CGROUP_STORAGE,
+	BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
+	/* BPF_MAP_TYPE_CGROUP_STORAGE is available to bpf programs attaching
+	 * to a cgroup. The newer BPF_MAP_TYPE_CGRP_STORAGE is available to
+	 * both cgroup-attached and other progs and supports all functionality
+	 * provided by BPF_MAP_TYPE_CGROUP_STORAGE. So mark
+	 * BPF_MAP_TYPE_CGROUP_STORAGE deprecated.
+	 */
+	BPF_MAP_TYPE_CGROUP_STORAGE =3D BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
 	BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
 	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
 	BPF_MAP_TYPE_QUEUE,
@@ -935,6 +942,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_TASK_STORAGE,
 	BPF_MAP_TYPE_BLOOM_FILTER,
 	BPF_MAP_TYPE_USER_RINGBUF,
+	BPF_MAP_TYPE_CGRP_STORAGE,
 };
=20
 /* Note that tracing related programs such as
@@ -5435,6 +5443,44 @@ union bpf_attr {
  *		**-E2BIG** if user-space has tried to publish a sample which is
  *		larger than the size of the ring buffer, or which cannot fit
  *		within a struct bpf_dynptr.
+ *
+ * void *bpf_cgrp_storage_get(struct bpf_map *map, struct cgroup *cgroup=
, void *value, u64 flags)
+ *	Description
+ *		Get a bpf_local_storage from the *cgroup*.
+ *
+ *		Logically, it could be thought of as getting the value from
+ *		a *map* with *cgroup* as the **key**.  From this
+ *		perspective,  the usage is not much different from
+ *		**bpf_map_lookup_elem**\ (*map*, **&**\ *cgroup*) except this
+ *		helper enforces the key must be a cgroup struct and the map must als=
o
+ *		be a **BPF_MAP_TYPE_CGRP_STORAGE**.
+ *
+ *		In reality, the local-storage value is embedded directly inside of t=
he
+ *		*cgroup* object itself, rather than being located in the
+ *		**BPF_MAP_TYPE_CGRP_STORAGE** map. When the local-storage value is
+ *		queried for some *map* on a *cgroup* object, the kernel will perform=
 an
+ *		O(n) iteration over all of the live local-storage values for that
+ *		*cgroup* object until the local-storage value for the *map* is found=
.
+ *
+ *		An optional *flags* (**BPF_LOCAL_STORAGE_GET_F_CREATE**) can be
+ *		used such that a new bpf_local_storage will be
+ *		created if one does not exist.  *value* can be used
+ *		together with **BPF_LOCAL_STORAGE_GET_F_CREATE** to specify
+ *		the initial value of a bpf_local_storage.  If *value* is
+ *		**NULL**, the new bpf_local_storage will be zero initialized.
+ *	Return
+ *		A bpf_local_storage pointer is returned on success.
+ *
+ *		**NULL** if not found or there was an error in adding
+ *		a new bpf_local_storage.
+ *
+ * long bpf_cgrp_storage_delete(struct bpf_map *map, struct cgroup *cgro=
up)
+ *	Description
+ *		Delete a bpf_local_storage from a *cgroup*.
+ *	Return
+ *		0 on success.
+ *
+ *		**-ENOENT** if the bpf_local_storage cannot be found.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5647,6 +5693,8 @@ union bpf_attr {
 	FN(tcp_raw_check_syncookie_ipv6, 207, ##ctx)	\
 	FN(ktime_get_tai_ns, 208, ##ctx)		\
 	FN(user_ringbuf_drain, 209, ##ctx)		\
+	FN(cgrp_storage_get, 210, ##ctx)		\
+	FN(cgrp_storage_delete, 211, ##ctx)		\
 	/* */
=20
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that do=
n't
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 341c94f208f4..3a12e6b400a2 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -25,7 +25,7 @@ ifeq ($(CONFIG_PERF_EVENTS),y)
 obj-$(CONFIG_BPF_SYSCALL) +=3D stackmap.o
 endif
 ifeq ($(CONFIG_CGROUPS),y)
-obj-$(CONFIG_BPF_SYSCALL) +=3D cgroup_iter.o
+obj-$(CONFIG_BPF_SYSCALL) +=3D cgroup_iter.o bpf_cgrp_storage.o
 endif
 obj-$(CONFIG_CGROUP_BPF) +=3D cgroup.o
 ifeq ($(CONFIG_INET),y)
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.=
c
new file mode 100644
index 000000000000..309403800f82
--- /dev/null
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ */
+
+#include <linux/types.h>
+#include <linux/bpf.h>
+#include <linux/bpf_local_storage.h>
+#include <uapi/linux/btf.h>
+#include <linux/btf_ids.h>
+
+DEFINE_BPF_STORAGE_CACHE(cgroup_cache);
+
+static DEFINE_PER_CPU(int, bpf_cgrp_storage_busy);
+
+static void bpf_cgrp_storage_lock(void)
+{
+	migrate_disable();
+	this_cpu_inc(bpf_cgrp_storage_busy);
+}
+
+static void bpf_cgrp_storage_unlock(void)
+{
+	this_cpu_dec(bpf_cgrp_storage_busy);
+	migrate_enable();
+}
+
+static bool bpf_cgrp_storage_trylock(void)
+{
+	migrate_disable();
+	if (unlikely(this_cpu_inc_return(bpf_cgrp_storage_busy) !=3D 1)) {
+		this_cpu_dec(bpf_cgrp_storage_busy);
+		migrate_enable();
+		return false;
+	}
+	return true;
+}
+
+static struct bpf_local_storage __rcu **cgroup_storage_ptr(void *owner)
+{
+	struct cgroup *cg =3D owner;
+
+	return &cg->bpf_cgrp_storage;
+}
+
+void bpf_cgrp_storage_free(struct cgroup *cgroup)
+{
+	struct bpf_local_storage *local_storage;
+	bool free_cgroup_storage =3D false;
+	unsigned long flags;
+
+	rcu_read_lock();
+	local_storage =3D rcu_dereference(cgroup->bpf_cgrp_storage);
+	if (!local_storage) {
+		rcu_read_unlock();
+		return;
+	}
+
+	bpf_cgrp_storage_lock();
+	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	free_cgroup_storage =3D bpf_local_storage_unlink_nolock(local_storage);
+	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	bpf_cgrp_storage_unlock();
+	rcu_read_unlock();
+
+	if (free_cgroup_storage)
+		kfree_rcu(local_storage, rcu);
+}
+
+static struct bpf_local_storage_data *
+cgroup_storage_lookup(struct cgroup *cgroup, struct bpf_map *map, bool c=
acheit_lockit)
+{
+	struct bpf_local_storage *cgroup_storage;
+	struct bpf_local_storage_map *smap;
+
+	cgroup_storage =3D rcu_dereference_check(cgroup->bpf_cgrp_storage,
+					       bpf_rcu_lock_held());
+	if (!cgroup_storage)
+		return NULL;
+
+	smap =3D (struct bpf_local_storage_map *)map;
+	return bpf_local_storage_lookup(cgroup_storage, smap, cacheit_lockit);
+}
+
+static void *bpf_cgrp_storage_lookup_elem(struct bpf_map *map, void *key=
)
+{
+	struct bpf_local_storage_data *sdata;
+	struct cgroup *cgroup;
+	int fd;
+
+	fd =3D *(int *)key;
+	cgroup =3D cgroup_get_from_fd(fd);
+	if (IS_ERR(cgroup))
+		return ERR_CAST(cgroup);
+
+	bpf_cgrp_storage_lock();
+	sdata =3D cgroup_storage_lookup(cgroup, map, true);
+	bpf_cgrp_storage_unlock();
+	cgroup_put(cgroup);
+	return sdata ? sdata->data : NULL;
+}
+
+static int bpf_cgrp_storage_update_elem(struct bpf_map *map, void *key,
+					  void *value, u64 map_flags)
+{
+	struct bpf_local_storage_data *sdata;
+	struct cgroup *cgroup;
+	int fd;
+
+	fd =3D *(int *)key;
+	cgroup =3D cgroup_get_from_fd(fd);
+	if (IS_ERR(cgroup))
+		return PTR_ERR(cgroup);
+
+	bpf_cgrp_storage_lock();
+	sdata =3D bpf_local_storage_update(cgroup, (struct bpf_local_storage_ma=
p *)map,
+					 value, map_flags, GFP_ATOMIC);
+	bpf_cgrp_storage_unlock();
+	cgroup_put(cgroup);
+	return PTR_ERR_OR_ZERO(sdata);
+}
+
+static int cgroup_storage_delete(struct cgroup *cgroup, struct bpf_map *=
map)
+{
+	struct bpf_local_storage_data *sdata;
+
+	sdata =3D cgroup_storage_lookup(cgroup, map, false);
+	if (!sdata)
+		return -ENOENT;
+
+	bpf_selem_unlink(SELEM(sdata), true);
+	return 0;
+}
+
+static int bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
+{
+	struct cgroup *cgroup;
+	int err, fd;
+
+	fd =3D *(int *)key;
+	cgroup =3D cgroup_get_from_fd(fd);
+	if (IS_ERR(cgroup))
+		return PTR_ERR(cgroup);
+
+	bpf_cgrp_storage_lock();
+	err =3D cgroup_storage_delete(cgroup, map);
+	bpf_cgrp_storage_unlock();
+	cgroup_put(cgroup);
+	return err;
+}
+
+static int notsupp_get_next_key(struct bpf_map *map, void *key, void *ne=
xt_key)
+{
+	return -ENOTSUPP;
+}
+
+static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
+{
+	return bpf_local_storage_map_alloc(attr, &cgroup_cache);
+}
+
+static void cgroup_storage_map_free(struct bpf_map *map)
+{
+	bpf_local_storage_map_free(map, &cgroup_cache, NULL);
+}
+
+/* *gfp_flags* is a hidden argument provided by the verifier */
+BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *,=
 cgroup,
+	   void *, value, u64, flags, gfp_t, gfp_flags)
+{
+	struct bpf_local_storage_data *sdata;
+
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
+	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
+		return (unsigned long)NULL;
+
+	if (!cgroup)
+		return (unsigned long)NULL;
+
+	if (!bpf_cgrp_storage_trylock())
+		return (unsigned long)NULL;
+
+	sdata =3D cgroup_storage_lookup(cgroup, map, true);
+	if (sdata)
+		goto unlock;
+
+	/* only allocate new storage, when the cgroup is refcounted */
+	if (!percpu_ref_is_dying(&cgroup->self.refcnt) &&
+	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE))
+		sdata =3D bpf_local_storage_update(cgroup, (struct bpf_local_storage_m=
ap *)map,
+						 value, BPF_NOEXIST, gfp_flags);
+
+unlock:
+	bpf_cgrp_storage_unlock();
+	return IS_ERR_OR_NULL(sdata) ? (unsigned long)NULL : (unsigned long)sda=
ta->data;
+}
+
+BPF_CALL_2(bpf_cgrp_storage_delete, struct bpf_map *, map, struct cgroup=
 *, cgroup)
+{
+	int ret;
+
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
+	if (!cgroup)
+		return -EINVAL;
+
+	if (!bpf_cgrp_storage_trylock())
+		return -EBUSY;
+
+	ret =3D cgroup_storage_delete(cgroup, map);
+	bpf_cgrp_storage_unlock();
+	return ret;
+}
+
+BTF_ID_LIST_SINGLE(cgroup_storage_map_btf_ids, struct, bpf_local_storage=
_map)
+const struct bpf_map_ops cgrp_storage_map_ops =3D {
+	.map_meta_equal =3D bpf_map_meta_equal,
+	.map_alloc_check =3D bpf_local_storage_map_alloc_check,
+	.map_alloc =3D cgroup_storage_map_alloc,
+	.map_free =3D cgroup_storage_map_free,
+	.map_get_next_key =3D notsupp_get_next_key,
+	.map_lookup_elem =3D bpf_cgrp_storage_lookup_elem,
+	.map_update_elem =3D bpf_cgrp_storage_update_elem,
+	.map_delete_elem =3D bpf_cgrp_storage_delete_elem,
+	.map_check_btf =3D bpf_local_storage_map_check_btf,
+	.map_btf_id =3D &cgroup_storage_map_btf_ids[0],
+	.map_owner_storage_ptr =3D cgroup_storage_ptr,
+};
+
+const struct bpf_func_proto bpf_cgrp_storage_get_proto =3D {
+	.func		=3D bpf_cgrp_storage_get,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg1_type	=3D ARG_CONST_MAP_PTR,
+	.arg2_type	=3D ARG_PTR_TO_BTF_ID,
+	.arg2_btf_id	=3D &bpf_cgroup_btf_id[0],
+	.arg3_type	=3D ARG_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg4_type	=3D ARG_ANYTHING,
+};
+
+const struct bpf_func_proto bpf_cgrp_storage_delete_proto =3D {
+	.func		=3D bpf_cgrp_storage_delete,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_CONST_MAP_PTR,
+	.arg2_type	=3D ARG_PTR_TO_BTF_ID,
+	.arg2_btf_id	=3D &bpf_cgroup_btf_id[0],
+};
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a6b04faed282..124fd199ce5c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1663,6 +1663,12 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_dynptr_write_proto;
 	case BPF_FUNC_dynptr_data:
 		return &bpf_dynptr_data_proto;
+#ifdef CONFIG_CGROUPS
+	case BPF_FUNC_cgrp_storage_get:
+		return &bpf_cgrp_storage_get_proto;
+	case BPF_FUNC_cgrp_storage_delete:
+		return &bpf_cgrp_storage_delete_proto;
+#endif
 	default:
 		break;
 	}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7b373a5e861f..b95c276f92e3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1016,7 +1016,8 @@ static int map_check_btf(struct bpf_map *map, const=
 struct btf *btf,
 		    map->map_type !=3D BPF_MAP_TYPE_CGROUP_STORAGE &&
 		    map->map_type !=3D BPF_MAP_TYPE_SK_STORAGE &&
 		    map->map_type !=3D BPF_MAP_TYPE_INODE_STORAGE &&
-		    map->map_type !=3D BPF_MAP_TYPE_TASK_STORAGE)
+		    map->map_type !=3D BPF_MAP_TYPE_TASK_STORAGE &&
+		    map->map_type !=3D BPF_MAP_TYPE_CGRP_STORAGE)
 			return -ENOTSUPP;
 		if (map->spin_lock_off + sizeof(struct bpf_spin_lock) >
 		    map->value_size) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ddc1452cf023..8f849a763b79 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6350,6 +6350,11 @@ static int check_map_func_compatibility(struct bpf=
_verifier_env *env,
 		    func_id !=3D BPF_FUNC_task_storage_delete)
 			goto error;
 		break;
+	case BPF_MAP_TYPE_CGRP_STORAGE:
+		if (func_id !=3D BPF_FUNC_cgrp_storage_get &&
+		    func_id !=3D BPF_FUNC_cgrp_storage_delete)
+			goto error;
+		break;
 	case BPF_MAP_TYPE_BLOOM_FILTER:
 		if (func_id !=3D BPF_FUNC_map_peek_elem &&
 		    func_id !=3D BPF_FUNC_map_push_elem)
@@ -6462,6 +6467,11 @@ static int check_map_func_compatibility(struct bpf=
_verifier_env *env,
 		if (map->map_type !=3D BPF_MAP_TYPE_TASK_STORAGE)
 			goto error;
 		break;
+	case BPF_FUNC_cgrp_storage_get:
+	case BPF_FUNC_cgrp_storage_delete:
+		if (map->map_type !=3D BPF_MAP_TYPE_CGRP_STORAGE)
+			goto error;
+		break;
 	default:
 		break;
 	}
@@ -14139,7 +14149,8 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
=20
 		if (insn->imm =3D=3D BPF_FUNC_task_storage_get ||
 		    insn->imm =3D=3D BPF_FUNC_sk_storage_get ||
-		    insn->imm =3D=3D BPF_FUNC_inode_storage_get) {
+		    insn->imm =3D=3D BPF_FUNC_inode_storage_get ||
+		    insn->imm =3D=3D BPF_FUNC_cgrp_storage_get) {
 			if (env->prog->aux->sleepable)
 				insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_KERNEL);
 			else
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 764bdd5fd8d1..12001928511b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5245,6 +5245,7 @@ static void css_free_rwork_fn(struct work_struct *w=
ork)
 		atomic_dec(&cgrp->root->nr_cgrps);
 		cgroup1_pidlist_destroy_all(cgrp);
 		cancel_work_sync(&cgrp->release_agent_work);
+		bpf_cgrp_storage_free(cgrp);
=20
 		if (cgroup_parent(cgrp)) {
 			/*
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2460e38f75ff..e7d919194f82 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1454,6 +1454,10 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, c=
onst struct bpf_prog *prog)
 		return &bpf_get_current_cgroup_id_proto;
 	case BPF_FUNC_get_current_ancestor_cgroup_id:
 		return &bpf_get_current_ancestor_cgroup_id_proto;
+	case BPF_FUNC_cgrp_storage_get:
+		return &bpf_cgrp_storage_get_proto;
+	case BPF_FUNC_cgrp_storage_delete:
+		return &bpf_cgrp_storage_delete_proto;
 #endif
 	case BPF_FUNC_send_signal:
 		return &bpf_send_signal_proto;
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index c0e6690be82a..fdb0aff8cb5a 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -685,6 +685,7 @@ class PrinterHelpers(Printer):
             'struct udp6_sock',
             'struct unix_sock',
             'struct task_struct',
+            'struct cgroup',
=20
             'struct __sk_buff',
             'struct sk_msg_md',
@@ -742,6 +743,7 @@ class PrinterHelpers(Printer):
             'struct udp6_sock',
             'struct unix_sock',
             'struct task_struct',
+            'struct cgroup',
             'struct path',
             'struct btf_ptr',
             'struct inode',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 17f61338f8f8..94659f6b3395 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -922,7 +922,14 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_CPUMAP,
 	BPF_MAP_TYPE_XSKMAP,
 	BPF_MAP_TYPE_SOCKHASH,
-	BPF_MAP_TYPE_CGROUP_STORAGE,
+	BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
+	/* BPF_MAP_TYPE_CGROUP_STORAGE is available to bpf programs attaching
+	 * to a cgroup. The newer BPF_MAP_TYPE_CGRP_STORAGE is available to
+	 * both cgroup-attached and other progs and supports all functionality
+	 * provided by BPF_MAP_TYPE_CGROUP_STORAGE. So mark
+	 * BPF_MAP_TYPE_CGROUP_STORAGE deprecated.
+	 */
+	BPF_MAP_TYPE_CGROUP_STORAGE =3D BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
 	BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
 	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
 	BPF_MAP_TYPE_QUEUE,
@@ -935,6 +942,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_TASK_STORAGE,
 	BPF_MAP_TYPE_BLOOM_FILTER,
 	BPF_MAP_TYPE_USER_RINGBUF,
+	BPF_MAP_TYPE_CGRP_STORAGE,
 };
=20
 /* Note that tracing related programs such as
@@ -5435,6 +5443,44 @@ union bpf_attr {
  *		**-E2BIG** if user-space has tried to publish a sample which is
  *		larger than the size of the ring buffer, or which cannot fit
  *		within a struct bpf_dynptr.
+ *
+ * void *bpf_cgrp_storage_get(struct bpf_map *map, struct cgroup *cgroup=
, void *value, u64 flags)
+ *	Description
+ *		Get a bpf_local_storage from the *cgroup*.
+ *
+ *		Logically, it could be thought of as getting the value from
+ *		a *map* with *cgroup* as the **key**.  From this
+ *		perspective,  the usage is not much different from
+ *		**bpf_map_lookup_elem**\ (*map*, **&**\ *cgroup*) except this
+ *		helper enforces the key must be a cgroup struct and the map must als=
o
+ *		be a **BPF_MAP_TYPE_CGRP_STORAGE**.
+ *
+ *		In reality, the local-storage value is embedded directly inside of t=
he
+ *		*cgroup* object itself, rather than being located in the
+ *		**BPF_MAP_TYPE_CGRP_STORAGE** map. When the local-storage value is
+ *		queried for some *map* on a *cgroup* object, the kernel will perform=
 an
+ *		O(n) iteration over all of the live local-storage values for that
+ *		*cgroup* object until the local-storage value for the *map* is found=
.
+ *
+ *		An optional *flags* (**BPF_LOCAL_STORAGE_GET_F_CREATE**) can be
+ *		used such that a new bpf_local_storage will be
+ *		created if one does not exist.  *value* can be used
+ *		together with **BPF_LOCAL_STORAGE_GET_F_CREATE** to specify
+ *		the initial value of a bpf_local_storage.  If *value* is
+ *		**NULL**, the new bpf_local_storage will be zero initialized.
+ *	Return
+ *		A bpf_local_storage pointer is returned on success.
+ *
+ *		**NULL** if not found or there was an error in adding
+ *		a new bpf_local_storage.
+ *
+ * long bpf_cgrp_storage_delete(struct bpf_map *map, struct cgroup *cgro=
up)
+ *	Description
+ *		Delete a bpf_local_storage from a *cgroup*.
+ *	Return
+ *		0 on success.
+ *
+ *		**-ENOENT** if the bpf_local_storage cannot be found.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5647,6 +5693,8 @@ union bpf_attr {
 	FN(tcp_raw_check_syncookie_ipv6, 207, ##ctx)	\
 	FN(ktime_get_tai_ns, 208, ##ctx)		\
 	FN(user_ringbuf_drain, 209, ##ctx)		\
+	FN(cgrp_storage_get, 210, ##ctx)		\
+	FN(cgrp_storage_delete, 211, ##ctx)		\
 	/* */
=20
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that do=
n't
--=20
2.30.2

