Return-Path: <bpf+bounces-10433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BF57A7217
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 07:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8941C208E9
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 05:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E077E4418;
	Wed, 20 Sep 2023 05:32:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1323D67
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 05:32:23 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B960B9
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 22:32:22 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K1vGnn022239
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 22:32:21 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t73uyjawm-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 22:32:21 -0700
Received: from twshared22837.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 19 Sep 2023 22:32:18 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
	id D5AE724A600FA; Tue, 19 Sep 2023 22:32:15 -0700 (PDT)
From: Song Liu <song@kernel.org>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@kernel.org>, <kernel-team@meta.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 4/8] bpf: Add helpers for trampoline image management
Date: Tue, 19 Sep 2023 22:31:54 -0700
Message-ID: <20230920053158.3175043-5-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920053158.3175043-1-song@kernel.org>
References: <20230920053158.3175043-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dioQtfaRYngaz-wG7DdrDWCQahNCyCgB
X-Proofpoint-GUID: dioQtfaRYngaz-wG7DdrDWCQahNCyCgB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_02,2023-09-19_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As BPF trampoline of different archs moves from bpf_jit_[alloc|free]_exec=
()
to bpf_prog_pack_[alloc|free](), we need to use different _alloc, _free f=
or
different archs during the transition. Add the following helpers for this
transition:

void *arch_alloc_bpf_trampoline(int size);
void arch_free_bpf_trampoline(void *image, int size);
void arch_protect_bpf_trampoline(void *image, int size);
void arch_unprotect_bpf_trampoline(void *image, int size);

The fallback version of these helpers require size <=3D PAGE_SIZE, but th=
ey
are only called with size =3D=3D PAGE_SIZE. They will be called with size=
 <
PAGE_SIZE when arch_bpf_trampoline_size() helper is introduced later.

Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/bpf.h         |  5 +++++
 kernel/bpf/bpf_struct_ops.c | 12 +++++-----
 kernel/bpf/trampoline.c     | 44 +++++++++++++++++++++++++++++++------
 3 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 27a18c0c10ca..548f3ef34ba1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1083,6 +1083,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
 				const struct btf_func_model *m, u32 flags,
 				struct bpf_tramp_links *tlinks,
 				void *func_addr);
+void *arch_alloc_bpf_trampoline(int size);
+void arch_free_bpf_trampoline(void *image, int size);
+void arch_protect_bpf_trampoline(void *image, int size);
+void arch_unprotect_bpf_trampoline(void *image, int size);
+
 u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
 					     struct bpf_tramp_run_ctx *run_ctx);
 void notrace __bpf_prog_exit_sleepable_recur(struct bpf_prog *prog, u64 =
start,
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index db6176fb64dc..e9e95879bce2 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -515,7 +515,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf=
_map *map, void *key,
 			if (err)
 				goto reset_unlock;
 		}
-		set_memory_rox((long)st_map->image, 1);
+		arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
 		/* Let bpf_link handle registration & unregistration.
 		 *
 		 * Pair with smp_load_acquire() during lookup_elem().
@@ -524,7 +524,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf=
_map *map, void *key,
 		goto unlock;
 	}
=20
-	set_memory_rox((long)st_map->image, 1);
+	arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
 	err =3D st_ops->reg(kdata);
 	if (likely(!err)) {
 		/* This refcnt increment on the map here after
@@ -547,8 +547,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf=
_map *map, void *key,
 	 * there was a race in registering the struct_ops (under the same name)=
 to
 	 * a sub-system through different struct_ops's maps.
 	 */
-	set_memory_nx((long)st_map->image, 1);
-	set_memory_rw((long)st_map->image, 1);
+	arch_unprotect_bpf_trampoline(st_map->image, PAGE_SIZE);
=20
 reset_unlock:
 	bpf_struct_ops_map_put_progs(st_map);
@@ -616,7 +615,7 @@ static void __bpf_struct_ops_map_free(struct bpf_map =
*map)
 		bpf_struct_ops_map_put_progs(st_map);
 	bpf_map_area_free(st_map->links);
 	if (st_map->image) {
-		bpf_jit_free_exec(st_map->image);
+		arch_free_bpf_trampoline(st_map->image, PAGE_SIZE);
 		bpf_jit_uncharge_modmem(PAGE_SIZE);
 	}
 	bpf_map_area_free(st_map->uvalue);
@@ -691,7 +690,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union=
 bpf_attr *attr)
 		return ERR_PTR(ret);
 	}
=20
-	st_map->image =3D bpf_jit_alloc_exec(PAGE_SIZE);
+	st_map->image =3D arch_alloc_bpf_trampoline(PAGE_SIZE);
 	if (!st_map->image) {
 		/* __bpf_struct_ops_map_free() uses st_map->image as flag
 		 * for "charged or not". In this case, we need to unchange
@@ -711,7 +710,6 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union=
 bpf_attr *attr)
 	}
=20
 	mutex_init(&st_map->lock);
-	set_vm_flush_reset_perms(st_map->image);
 	bpf_map_init_from_attr(map, attr);
=20
 	return map;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index e114a1c7961e..5509bdf98067 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -254,7 +254,7 @@ bpf_trampoline_get_progs(const struct bpf_trampoline =
*tr, int *total, bool *ip_a
 static void bpf_tramp_image_free(struct bpf_tramp_image *im)
 {
 	bpf_image_ksym_del(&im->ksym);
-	bpf_jit_free_exec(im->image);
+	arch_free_bpf_trampoline(im->image, PAGE_SIZE);
 	bpf_jit_uncharge_modmem(PAGE_SIZE);
 	percpu_ref_exit(&im->pcref);
 	kfree_rcu(im, rcu);
@@ -365,10 +365,9 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc=
(u64 key)
 		goto out_free_im;
=20
 	err =3D -ENOMEM;
-	im->image =3D image =3D bpf_jit_alloc_exec(PAGE_SIZE);
+	im->image =3D image =3D arch_alloc_bpf_trampoline(PAGE_SIZE);
 	if (!image)
 		goto out_uncharge;
-	set_vm_flush_reset_perms(image);
=20
 	err =3D percpu_ref_init(&im->pcref, __bpf_tramp_image_release, 0, GFP_K=
ERNEL);
 	if (err)
@@ -381,7 +380,7 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(=
u64 key)
 	return im;
=20
 out_free_image:
-	bpf_jit_free_exec(im->image);
+	arch_free_bpf_trampoline(im->image, PAGE_SIZE);
 out_uncharge:
 	bpf_jit_uncharge_modmem(PAGE_SIZE);
 out_free_im:
@@ -444,7 +443,7 @@ static int bpf_trampoline_update(struct bpf_trampolin=
e *tr, bool lock_direct_mut
 	if (err < 0)
 		goto out_free;
=20
-	set_memory_rox((long)im->image, 1);
+	arch_protect_bpf_trampoline(im->image, PAGE_SIZE);
=20
 	WARN_ON(tr->cur_image && total =3D=3D 0);
 	if (tr->cur_image)
@@ -465,8 +464,7 @@ static int bpf_trampoline_update(struct bpf_trampolin=
e *tr, bool lock_direct_mut
 		tr->fops->trampoline =3D 0;
=20
 		/* reset im->image memory attr for arch_prepare_bpf_trampoline */
-		set_memory_nx((long)im->image, 1);
-		set_memory_rw((long)im->image, 1);
+		arch_unprotect_bpf_trampoline(im->image, PAGE_SIZE);
 		goto again;
 	}
 #endif
@@ -1040,6 +1038,38 @@ arch_prepare_bpf_trampoline(struct bpf_tramp_image=
 *im, void *image, void *image
 	return -ENOTSUPP;
 }
=20
+void * __weak arch_alloc_bpf_trampoline(int size)
+{
+	void *image;
+
+	WARN_ON_ONCE(size > PAGE_SIZE || size <=3D 0);
+	image =3D bpf_jit_alloc_exec(PAGE_SIZE);
+	if (image)
+		set_vm_flush_reset_perms(image);
+	return image;
+}
+
+void __weak arch_free_bpf_trampoline(void *image, int size)
+{
+	/* bpf_jit_free_exec doesn't need "size", but
+	 * bpf_prog_pack_free() needs it.
+	 */
+	bpf_jit_free_exec(image);
+}
+
+void __weak arch_protect_bpf_trampoline(void *image, int size)
+{
+	WARN_ON_ONCE(size > PAGE_SIZE || size <=3D 0);
+	set_memory_rox((long)image, 1);
+}
+
+void __weak arch_unprotect_bpf_trampoline(void *image, int size)
+{
+	WARN_ON_ONCE(size > PAGE_SIZE || size <=3D 0);
+	set_memory_nx((long)image, 1);
+	set_memory_rw((long)image, 1);
+}
+
 static int __init init_trampolines(void)
 {
 	int i;
--=20
2.34.1


