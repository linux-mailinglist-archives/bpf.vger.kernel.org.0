Return-Path: <bpf+bounces-18491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 695AA81AE38
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 06:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D38D4B23822
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 05:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A0CAD5E;
	Thu, 21 Dec 2023 05:00:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC568F52
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 05:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id A394A2BD13AF6; Wed, 20 Dec 2023 21:00:10 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 3/8] bpf: Allow per unit prefill for non-fix-size percpu memory allocator
Date: Wed, 20 Dec 2023 21:00:10 -0800
Message-Id: <20231221050010.1971932-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221045954.1969955-1-yonghong.song@linux.dev>
References: <20231221045954.1969955-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit 41a5db8d8161 ("Add support for non-fix-size percpu mem allocation"=
)
added support for non-fix-size percpu memory allocation.
Such allocation will allocate percpu memory for all buckets on all
cpus and the memory consumption is in the order to quadratic.
For example, let us say, 4 cpus, unit size 16 bytes, so each
cpu has 16 * 4 =3D 64 bytes, with 4 cpus, total will be 64 * 4 =3D 256 by=
tes.
Then let us say, 8 cpus with the same unit size, each cpu
has 16 * 8 =3D 128 bytes, with 8 cpus, total will be 128 * 8 =3D 1024 byt=
es.
So if the number of cpus doubles, the number of memory consumption
will be 4 times. So for a system with large number of cpus, the
memory consumption goes up quickly with quadratic order.
For example, for 4KB percpu allocation, 128 cpus. The total memory
consumption will 4KB * 128 * 128 =3D 64MB. Things will become
worse if the number of cpus is bigger (e.g., 512, 1024, etc.)

In Commit 41a5db8d8161, the non-fix-size percpu memory allocation is
done in boot time, so for system with large number of cpus, the initial
percpu memory consumption is very visible. For example, for 128 cpu
system, the total percpu memory allocation will be at least
(16 + 32 + 64 + 96 + 128 + 196 + 256 + 512 + 1024 + 2048 + 4096)
  * 128 * 128 =3D ~138MB.
which is pretty big. It will be even bigger for larger number of cpus.

Note that the current prefill also allocates 4 entries if the unit size
is less than 256. So on top of 138MB memory consumption, this will
add more consumption with
3 * (16 + 32 + 64 + 96 + 128 + 196 + 256) * 128 * 128 =3D ~38MB.
Next patch will try to reduce this memory consumption.

Later on, Commit 1fda5bb66ad8 ("bpf: Do not allocate percpu memory
at init stage") moved the non-fix-size percpu memory allocation
to bpf verificaiton stage. Once a particular bpf_percpu_obj_new()
is called by bpf program, the memory allocator will try to fill in
the cache with all sizes, causing the same amount of percpu memory
consumption as in the boot stage.

To reduce the initial percpu memory consumption for non-fix-size
percpu memory allocation, instead of filling the cache with all
supported allocation sizes, this patch intends to fill the cache
only for the requested size. As typically users will not use large
percpu data structure, this can save memory significantly.
For example, the allocation size is 64 bytes with 128 cpus.
Then total percpu memory amount will be 64 * 128 * 128 =3D 1MB,
much less than previous 138MB.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_mem_alloc.h |  7 ++++
 kernel/bpf/memalloc.c         | 62 ++++++++++++++++++++++++++++++++++-
 kernel/bpf/verifier.c         | 34 +++++++++++--------
 3 files changed, 88 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.=
h
index acef8c808599..d1403204379e 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -22,8 +22,15 @@ struct bpf_mem_alloc {
  * 'size =3D 0' is for bpf_mem_alloc which manages many fixed-size objec=
ts.
  * Alloc and free are done with bpf_mem_{alloc,free}() and the size of
  * the returned object is given by the size argument of bpf_mem_alloc().
+ * If percpu equals true, error will be returned in order to avoid
+ * large memory consumption and the below bpf_mem_alloc_percpu_unit_init=
()
+ * should be used to do on-demand per-cpu allocation for each size.
  */
 int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu);
+/* Initialize a non-fix-size percpu memory allocator */
+int bpf_mem_alloc_percpu_init(struct bpf_mem_alloc *ma);
+/* The percpu allocation with a specific unit size. */
+int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size);
 void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
=20
 /* kmalloc/kfree equivalent: */
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 4a21050f0359..a9c87ef4b89a 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -121,6 +121,8 @@ struct bpf_mem_caches {
 	struct bpf_mem_cache cache[NUM_CACHES];
 };
=20
+static const u16 sizes[NUM_CACHES] =3D {96, 192, 16, 32, 64, 128, 256, 5=
12, 1024, 2048, 4096};
+
 static struct llist_node notrace *__llist_del_first(struct llist_head *h=
ead)
 {
 	struct llist_node *entry, *next;
@@ -499,12 +501,14 @@ static void prefill_mem_cache(struct bpf_mem_cache =
*c, int cpu)
  */
 int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 {
-	static u16 sizes[NUM_CACHES] =3D {96, 192, 16, 32, 64, 128, 256, 512, 1=
024, 2048, 4096};
 	struct bpf_mem_caches *cc, __percpu *pcc;
 	struct bpf_mem_cache *c, __percpu *pc;
 	struct obj_cgroup *objcg =3D NULL;
 	int cpu, i, unit_size, percpu_size =3D 0;
=20
+	if (percpu && size =3D=3D 0)
+		return -EINVAL;
+
 	/* room for llist_node and per-cpu pointer */
 	if (percpu)
 		percpu_size =3D LLIST_NODE_SZ + sizeof(void *);
@@ -524,6 +528,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int =
size, bool percpu)
 			objcg =3D get_obj_cgroup_from_current();
 #endif
 		ma->objcg =3D objcg;
+
 		for_each_possible_cpu(cpu) {
 			c =3D per_cpu_ptr(pc, cpu);
 			c->unit_size =3D unit_size;
@@ -562,6 +567,61 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int=
 size, bool percpu)
 	return 0;
 }
=20
+int bpf_mem_alloc_percpu_init(struct bpf_mem_alloc *ma)
+{
+	struct bpf_mem_caches __percpu *pcc;
+
+	pcc =3D __alloc_percpu_gfp(sizeof(struct bpf_mem_caches), 8, GFP_KERNEL=
);
+	if (!pcc)
+		return -ENOMEM;
+
+	ma->caches =3D pcc;
+	ma->percpu =3D true;
+
+#ifdef CONFIG_MEMCG_KMEM
+	ma->objcg =3D get_obj_cgroup_from_current();
+#else
+	ma->objcg =3D NULL;
+#endif
+	return 0;
+}
+
+int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
+{
+	struct bpf_mem_caches *cc, __percpu *pcc;
+	int cpu, i, unit_size, percpu_size;
+	struct obj_cgroup *objcg;
+	struct bpf_mem_cache *c;
+
+	i =3D bpf_mem_cache_idx(size);
+	if (i < 0)
+		return -EINVAL;
+
+	/* room for llist_node and per-cpu pointer */
+	percpu_size =3D LLIST_NODE_SZ + sizeof(void *);
+
+	unit_size =3D sizes[i];
+	objcg =3D ma->objcg;
+	pcc =3D ma->caches;
+
+	for_each_possible_cpu(cpu) {
+		cc =3D per_cpu_ptr(pcc, cpu);
+		c =3D &cc->cache[i];
+		if (cpu =3D=3D 0 && c->unit_size)
+			break;
+
+		c->unit_size =3D unit_size;
+		c->objcg =3D objcg;
+		c->percpu_size =3D percpu_size;
+		c->tgt =3D c;
+
+		init_refill_work(c);
+		prefill_mem_cache(c, cpu);
+	}
+
+	return 0;
+}
+
 static void drain_mem_cache(struct bpf_mem_cache *c)
 {
 	bool percpu =3D !!c->percpu_size;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f13008d27f35..08f9a49cc11c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12141,20 +12141,6 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
 				if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_obj_new_impl] && !=
bpf_global_ma_set)
 					return -ENOMEM;
=20
-				if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_imp=
l]) {
-					if (!bpf_global_percpu_ma_set) {
-						mutex_lock(&bpf_percpu_ma_lock);
-						if (!bpf_global_percpu_ma_set) {
-							err =3D bpf_mem_alloc_init(&bpf_global_percpu_ma, 0, true);
-							if (!err)
-								bpf_global_percpu_ma_set =3D true;
-						}
-						mutex_unlock(&bpf_percpu_ma_lock);
-						if (err)
-							return err;
-					}
-				}
-
 				if (((u64)(u32)meta.arg_constant.value) !=3D meta.arg_constant.value=
) {
 					verbose(env, "local type ID argument must be in range [0, U32_MAX]\=
n");
 					return -EINVAL;
@@ -12175,6 +12161,26 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
 					return -EINVAL;
 				}
=20
+				if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_imp=
l]) {
+					if (!bpf_global_percpu_ma_set) {
+						mutex_lock(&bpf_percpu_ma_lock);
+						if (!bpf_global_percpu_ma_set) {
+							err =3D bpf_mem_alloc_percpu_init(&bpf_global_percpu_ma);
+							if (!err)
+								bpf_global_percpu_ma_set =3D true;
+						}
+						mutex_unlock(&bpf_percpu_ma_lock);
+						if (err)
+							return err;
+					}
+
+					mutex_lock(&bpf_percpu_ma_lock);
+					err =3D bpf_mem_alloc_percpu_unit_init(&bpf_global_percpu_ma, ret_t=
->size);
+					mutex_unlock(&bpf_percpu_ma_lock);
+					if (err)
+						return err;
+				}
+
 				struct_meta =3D btf_find_struct_meta(ret_btf, ret_btf_id);
 				if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_imp=
l]) {
 					if (!__btf_type_is_scalar_struct(env, ret_btf, ret_t, 0)) {
--=20
2.34.1


