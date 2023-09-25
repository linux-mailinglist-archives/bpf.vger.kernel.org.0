Return-Path: <bpf+bounces-10796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B655D7AE10C
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 47DA91F2501E
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 21:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977ED25104;
	Mon, 25 Sep 2023 21:53:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A77D250EC
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 21:53:55 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC83AF
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 14:53:53 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PKHEUN001051
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 14:53:53 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3taxd3ubte-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 14:53:52 -0700
Received: from twshared19625.39.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 25 Sep 2023 14:53:48 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
	id 6071124F39531; Mon, 25 Sep 2023 14:53:41 -0700 (PDT)
From: Song Liu <song@kernel.org>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@kernel.org>, <kernel-team@meta.com>, <iii@linux.ibm.com>,
        Song
 Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 7/8] bpf: Use arch_bpf_trampoline_size
Date: Mon, 25 Sep 2023 14:53:23 -0700
Message-ID: <20230925215324.2962716-8-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925215324.2962716-1-song@kernel.org>
References: <20230925215324.2962716-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ApiZvUkmIHIN4Cq1EwdqNAvK-ZCH_uK6
X-Proofpoint-GUID: ApiZvUkmIHIN4Cq1EwdqNAvK-ZCH_uK6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Instead of blindly allocating PAGE_SIZE for each trampoline, check the si=
ze
of the trampoline with arch_bpf_trampoline_size(). This size is saved in
bpf_tramp_image->size, and used for modmem charge/uncharge. The fallback
arch_alloc_bpf_trampoline() still allocates a whole page because we need =
to
use set_memory_* to protect the memory.

struct_ops trampoline still uses a whole page for multiple trampolines.

With this size check at caller (regular trampoline and struct_ops
trampoline), remove arch_bpf_trampoline_size() from
arch_prepare_bpf_trampoline() in archs.

Signed-off-by: Song Liu <song@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c   |  7 -----
 arch/riscv/net/bpf_jit_comp64.c |  7 -----
 arch/s390/net/bpf_jit_comp.c    | 11 --------
 include/linux/bpf.h             |  1 +
 kernel/bpf/bpf_struct_ops.c     |  7 +++++
 kernel/bpf/trampoline.c         | 49 +++++++++++++++++++++------------
 6 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
index a6671253b7ed..8955da5c47cf 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2079,13 +2079,6 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image,
 	if (nregs > 8)
 		return -ENOTSUPP;
=20
-	ret =3D arch_bpf_trampoline_size(m, flags, tlinks, func_addr);
-	if (ret < 0)
-		return ret;
-
-	if (ret > ((long)image_end - (long)image))
-		return -EFBIG;
-
 	jit_fill_hole(image, (unsigned int)(image_end - image));
 	ret =3D prepare_trampoline(&ctx, im, tlinks, func_addr, nregs, flags);
=20
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
index 50bd92e3e708..53e7a0228c7e 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1046,13 +1046,6 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image,
 	int ret;
 	struct rv_jit_context ctx;
=20
-	ret =3D arch_bpf_trampoline_size(im, m, flags, tlinks, func_addr);
-	if (ret < 0)
-		return ret;
-
-	if (ret > (long)image_end - (long)image)
-		return -EFBIG;
-
 	ctx.ninsns =3D 0;
 	/*
 	 * The bpf_int_jit_compile() uses a RW buffer (ctx.insns) to write the
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index a316e9e73446..4414f9d7efe0 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2645,17 +2645,6 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image,
 	struct bpf_tramp_jit tjit;
 	int ret;
=20
-	ret =3D arch_bpf_trampoline_size(m, flags, tlinks, func_addr);
-	if (ret < 0)
-		return ret;
-
-	if (ret > (char *)image_end - (char *)image)
-		/*
-		 * Use the same error code as for exceeding
-		 * BPF_MAX_TRAMP_LINKS.
-		 */
-		return -E2BIG;
-
 	memset(&tjit, 0, sizeof(tjit));
 	tjit.common.prg_buf =3D image;
 	ret =3D __arch_prepare_bpf_trampoline(im, &tjit, m, flags,
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5bbac549b0a0..20ce9b536344 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1122,6 +1122,7 @@ enum bpf_tramp_prog_type {
=20
 struct bpf_tramp_image {
 	void *image;
+	int size;
 	struct bpf_ksym ksym;
 	struct percpu_ref pcref;
 	void *ip_after_call;
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index e9e95879bce2..4d53c53fc5aa 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -355,6 +355,7 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tram=
p_links *tlinks,
 				      void *image, void *image_end)
 {
 	u32 flags;
+	int size;
=20
 	tlinks[BPF_TRAMP_FENTRY].links[0] =3D link;
 	tlinks[BPF_TRAMP_FENTRY].nr_links =3D 1;
@@ -362,6 +363,12 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tra=
mp_links *tlinks,
 	 * and it must be used alone.
 	 */
 	flags =3D model->ret_size > 0 ? BPF_TRAMP_F_RET_FENTRY_RET : 0;
+
+	size =3D arch_bpf_trampoline_size(model, flags, tlinks, NULL);
+	if (size < 0)
+		return size;
+	if (size > (unsigned long)image_end - (unsigned long)image)
+		return -E2BIG;
 	return arch_prepare_bpf_trampoline(NULL, image, image_end,
 					   model, flags, tlinks, NULL);
 }
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 285c5b7c1ea4..7c0535edab3f 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -254,8 +254,8 @@ bpf_trampoline_get_progs(const struct bpf_trampoline =
*tr, int *total, bool *ip_a
 static void bpf_tramp_image_free(struct bpf_tramp_image *im)
 {
 	bpf_image_ksym_del(&im->ksym);
-	arch_free_bpf_trampoline(im->image, PAGE_SIZE);
-	bpf_jit_uncharge_modmem(PAGE_SIZE);
+	arch_free_bpf_trampoline(im->image, im->size);
+	bpf_jit_uncharge_modmem(im->size);
 	percpu_ref_exit(&im->pcref);
 	kfree_rcu(im, rcu);
 }
@@ -349,7 +349,7 @@ static void bpf_tramp_image_put(struct bpf_tramp_imag=
e *im)
 	call_rcu_tasks_trace(&im->rcu, __bpf_tramp_image_put_rcu_tasks);
 }
=20
-static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key)
+static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, int size)
 {
 	struct bpf_tramp_image *im;
 	struct bpf_ksym *ksym;
@@ -360,12 +360,13 @@ static struct bpf_tramp_image *bpf_tramp_image_allo=
c(u64 key)
 	if (!im)
 		goto out;
=20
-	err =3D bpf_jit_charge_modmem(PAGE_SIZE);
+	err =3D bpf_jit_charge_modmem(size);
 	if (err)
 		goto out_free_im;
+	im->size =3D size;
=20
 	err =3D -ENOMEM;
-	im->image =3D image =3D arch_alloc_bpf_trampoline(PAGE_SIZE);
+	im->image =3D image =3D arch_alloc_bpf_trampoline(size);
 	if (!image)
 		goto out_uncharge;
=20
@@ -380,9 +381,9 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(=
u64 key)
 	return im;
=20
 out_free_image:
-	arch_free_bpf_trampoline(im->image, PAGE_SIZE);
+	arch_free_bpf_trampoline(im->image, im->size);
 out_uncharge:
-	bpf_jit_uncharge_modmem(PAGE_SIZE);
+	bpf_jit_uncharge_modmem(size);
 out_free_im:
 	kfree(im);
 out:
@@ -395,7 +396,7 @@ static int bpf_trampoline_update(struct bpf_trampolin=
e *tr, bool lock_direct_mut
 	struct bpf_tramp_links *tlinks;
 	u32 orig_flags =3D tr->flags;
 	bool ip_arg =3D false;
-	int err, total;
+	int err, total, size;
=20
 	tlinks =3D bpf_trampoline_get_progs(tr, &total, &ip_arg);
 	if (IS_ERR(tlinks))
@@ -408,12 +409,6 @@ static int bpf_trampoline_update(struct bpf_trampoli=
ne *tr, bool lock_direct_mut
 		goto out;
 	}
=20
-	im =3D bpf_tramp_image_alloc(tr->key);
-	if (IS_ERR(im)) {
-		err =3D PTR_ERR(im);
-		goto out;
-	}
-
 	/* clear all bits except SHARE_IPMODIFY and TAIL_CALL_CTX */
 	tr->flags &=3D (BPF_TRAMP_F_SHARE_IPMODIFY | BPF_TRAMP_F_TAIL_CALL_CTX)=
;
=20
@@ -437,13 +432,31 @@ static int bpf_trampoline_update(struct bpf_trampol=
ine *tr, bool lock_direct_mut
 		tr->flags |=3D BPF_TRAMP_F_ORIG_STACK;
 #endif
=20
-	err =3D arch_prepare_bpf_trampoline(im, im->image, im->image + PAGE_SIZ=
E,
+	size =3D arch_bpf_trampoline_size(&tr->func.model, tr->flags,
+					tlinks, tr->func.addr);
+	if (size < 0) {
+		err =3D size;
+		goto out;
+	}
+
+	if (size > PAGE_SIZE) {
+		err =3D -E2BIG;
+		goto out;
+	}
+
+	im =3D bpf_tramp_image_alloc(tr->key, size);
+	if (IS_ERR(im)) {
+		err =3D PTR_ERR(im);
+		goto out;
+	}
+
+	err =3D arch_prepare_bpf_trampoline(im, im->image, im->image + size,
 					  &tr->func.model, tr->flags, tlinks,
 					  tr->func.addr);
 	if (err < 0)
 		goto out_free;
=20
-	arch_protect_bpf_trampoline(im->image, PAGE_SIZE);
+	arch_protect_bpf_trampoline(im->image, im->size);
=20
 	WARN_ON(tr->cur_image && total =3D=3D 0);
 	if (tr->cur_image)
@@ -463,8 +476,8 @@ static int bpf_trampoline_update(struct bpf_trampolin=
e *tr, bool lock_direct_mut
 		tr->fops->func =3D NULL;
 		tr->fops->trampoline =3D 0;
=20
-		/* reset im->image memory attr for arch_prepare_bpf_trampoline */
-		arch_unprotect_bpf_trampoline(im->image, PAGE_SIZE);
+		/* free im memory and reallocate later */
+		bpf_tramp_image_free(im);
 		goto again;
 	}
 #endif
--=20
2.34.1


