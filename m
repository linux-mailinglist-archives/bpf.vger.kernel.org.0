Return-Path: <bpf+bounces-10435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E787A7219
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 07:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7177A1C208C3
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 05:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F51522F;
	Wed, 20 Sep 2023 05:32:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388393C04
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 05:32:32 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D2DA3
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 22:32:30 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K1vGH5002173
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 22:32:30 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t7hnhnn3g-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 22:32:30 -0700
Received: from twshared27355.37.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 19 Sep 2023 22:32:28 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
	id 33BC624A60132; Tue, 19 Sep 2023 22:32:22 -0700 (PDT)
From: Song Liu <song@kernel.org>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@kernel.org>, <kernel-team@meta.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 7/8] bpf: Use arch_bpf_trampoline_size for trampoline
Date: Tue, 19 Sep 2023 22:31:57 -0700
Message-ID: <20230920053158.3175043-8-song@kernel.org>
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
X-Proofpoint-GUID: ugDsFfeXRYVcRjlX731vv30CF2JNnj8v
X-Proofpoint-ORIG-GUID: ugDsFfeXRYVcRjlX731vv30CF2JNnj8v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_02,2023-09-19_01,2023-05-22_02
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

This change does not cover struct_ops trampoline, which will still use a
whole page for multiple trampolines.

Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/bpf.h     |  1 +
 kernel/bpf/trampoline.c | 41 +++++++++++++++++++++++++----------------
 2 files changed, 26 insertions(+), 16 deletions(-)

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
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 285c5b7c1ea4..da97ec6bdfd5 100644
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
@@ -382,7 +383,7 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(=
u64 key)
 out_free_image:
 	arch_free_bpf_trampoline(im->image, PAGE_SIZE);
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
@@ -437,7 +432,20 @@ static int bpf_trampoline_update(struct bpf_trampoli=
ne *tr, bool lock_direct_mut
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
@@ -463,8 +471,9 @@ static int bpf_trampoline_update(struct bpf_trampolin=
e *tr, bool lock_direct_mut
 		tr->fops->func =3D NULL;
 		tr->fops->trampoline =3D 0;
=20
-		/* reset im->image memory attr for arch_prepare_bpf_trampoline */
-		arch_unprotect_bpf_trampoline(im->image, PAGE_SIZE);
+		/* free im->image memory and reallocate later */
+		arch_free_bpf_trampoline(im->image, im->size);
+		im->image =3D NULL;
 		goto again;
 	}
 #endif
--=20
2.34.1


