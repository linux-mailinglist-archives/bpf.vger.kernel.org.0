Return-Path: <bpf+bounces-10889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45787AF3A0
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 21:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 631B82818BD
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 19:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586804882C;
	Tue, 26 Sep 2023 19:01:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359AA12B7D
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 19:00:58 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CD019A
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 12:00:54 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QIhqlT016777
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 12:00:54 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tc0h1k1d8-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 12:00:53 -0700
Received: from twshared27355.37.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 26 Sep 2023 12:00:44 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
	id 0E31B250068C4; Tue, 26 Sep 2023 12:00:32 -0700 (PDT)
From: Song Liu <song@kernel.org>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@kernel.org>, <kernel-team@meta.com>, <iii@linux.ibm.com>,
        <bjorn@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH v3 bpf-next 6/8] bpf: Add arch_bpf_trampoline_size()
Date: Tue, 26 Sep 2023 12:00:18 -0700
Message-ID: <20230926190020.1111575-7-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926190020.1111575-1-song@kernel.org>
References: <20230926190020.1111575-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: WMkEYn21ZM6lVuWKrLT4_rMtPnqKvDlP
X-Proofpoint-GUID: WMkEYn21ZM6lVuWKrLT4_rMtPnqKvDlP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This helper will be used to calculate the size of the trampoline before
allocating the memory.

arch_prepare_bpf_trampoline() for arm64 and riscv64 can use
arch_bpf_trampoline_size() to check the trampoline fits in the image.

OTOH, arch_prepare_bpf_trampoline() for s390 has to call the JIT process
twice, so it cannot use arch_bpf_trampoline_size().

Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>  # on s390x
---
 arch/arm64/net/bpf_jit_comp.c   | 56 ++++++++++++++++++++++++---------
 arch/riscv/net/bpf_jit_comp64.c | 22 ++++++++++---
 arch/s390/net/bpf_jit_comp.c    | 56 ++++++++++++++++++++-------------
 arch/x86/net/bpf_jit_comp.c     | 37 +++++++++++++++++++---
 include/linux/bpf.h             |  2 ++
 kernel/bpf/trampoline.c         |  6 ++++
 6 files changed, 133 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
index d81b886ea4df..a6671253b7ed 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2026,18 +2026,10 @@ static int prepare_trampoline(struct jit_ctx *ctx=
, struct bpf_tramp_image *im,
 	return ctx->idx;
 }
=20
-int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
-				void *image_end, const struct btf_func_model *m,
-				u32 flags, struct bpf_tramp_links *tlinks,
-				void *func_addr)
+static int btf_func_model_nregs(const struct btf_func_model *m)
 {
-	int i, ret;
 	int nregs =3D m->nr_args;
-	int max_insns =3D ((long)image_end - (long)image) / AARCH64_INSN_SIZE;
-	struct jit_ctx ctx =3D {
-		.image =3D NULL,
-		.idx =3D 0,
-	};
+	int i;
=20
 	/* extra registers needed for struct argument */
 	for (i =3D 0; i < MAX_BPF_FUNC_ARGS; i++) {
@@ -2046,19 +2038,53 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_=
image *im, void *image,
 			nregs +=3D (m->arg_size[i] + 7) / 8 - 1;
 	}
=20
+	return nregs;
+}
+
+int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
+			     struct bpf_tramp_links *tlinks, void *func_addr)
+{
+	struct jit_ctx ctx =3D {
+		.image =3D NULL,
+		.idx =3D 0,
+	};
+	struct bpf_tramp_image im;
+	int nregs, ret;
+
+	nregs =3D btf_func_model_nregs(m);
 	/* the first 8 registers are used for arguments */
 	if (nregs > 8)
 		return -ENOTSUPP;
=20
-	ret =3D prepare_trampoline(&ctx, im, tlinks, func_addr, nregs, flags);
+	ret =3D prepare_trampoline(&ctx, &im, tlinks, func_addr, nregs, flags);
 	if (ret < 0)
 		return ret;
=20
-	if (ret > max_insns)
-		return -EFBIG;
+	return ret < 0 ? ret : ret * AARCH64_INSN_SIZE;
+}
=20
-	ctx.image =3D image;
-	ctx.idx =3D 0;
+int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
+				void *image_end, const struct btf_func_model *m,
+				u32 flags, struct bpf_tramp_links *tlinks,
+				void *func_addr)
+{
+	int ret, nregs;
+	struct jit_ctx ctx =3D {
+		.image =3D image,
+		.idx =3D 0,
+	};
+
+	nregs =3D btf_func_model_nregs(m);
+	/* the first 8 registers are used for arguments */
+	if (nregs > 8)
+		return -ENOTSUPP;
+
+	ret =3D arch_bpf_trampoline_size(m, flags, tlinks, func_addr);
+	if (ret < 0)
+		return ret;
+
+	if (ret > ((long)image_end - (long)image))
+		return -EFBIG;
=20
 	jit_fill_hole(image, (unsigned int)(image_end - image));
 	ret =3D prepare_trampoline(&ctx, im, tlinks, func_addr, nregs, flags);
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
index ecd3ae6f4116..2e5299943816 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1024,6 +1024,21 @@ static int __arch_prepare_bpf_trampoline(struct bp=
f_tramp_image *im,
 	return ret;
 }
=20
+int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
+			     struct bpf_tramp_links *tlinks, void *func_addr)
+{
+	struct bpf_tramp_image im;
+	struct rv_jit_context ctx;
+	int ret;
+
+	ctx.ninsns =3D 0;
+	ctx.insns =3D NULL;
+	ctx.ro_insns =3D NULL;
+	ret =3D __arch_prepare_bpf_trampoline(&im, m, tlinks, func_addr, flags,=
 &ctx);
+
+	return ret < 0 ? ret : ninsns_rvoff(ctx.ninsns);
+}
+
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 				void *image_end, const struct btf_func_model *m,
 				u32 flags, struct bpf_tramp_links *tlinks,
@@ -1032,14 +1047,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_=
image *im, void *image,
 	int ret;
 	struct rv_jit_context ctx;
=20
-	ctx.ninsns =3D 0;
-	ctx.insns =3D NULL;
-	ctx.ro_insns =3D NULL;
-	ret =3D __arch_prepare_bpf_trampoline(im, m, tlinks, func_addr, flags, =
&ctx);
+	ret =3D arch_bpf_trampoline_size(im, m, flags, tlinks, func_addr);
 	if (ret < 0)
 		return ret;
=20
-	if (ninsns_rvoff(ret) > (long)image_end - (long)image)
+	if (ret > (long)image_end - (long)image)
 		return -EFBIG;
=20
 	ctx.ninsns =3D 0;
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index fd1936a63878..aa83cff3458e 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2622,6 +2622,21 @@ static int __arch_prepare_bpf_trampoline(struct bp=
f_tramp_image *im,
 	return 0;
 }
=20
+int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
+			     struct bpf_tramp_links *tlinks, void *orig_call)
+{
+	struct bpf_tramp_image im;
+	struct bpf_tramp_jit tjit;
+	int ret;
+
+	memset(&tjit, 0, sizeof(tjit));
+
+	ret =3D __arch_prepare_bpf_trampoline(&im, &tjit, m, flags,
+					    tlinks, orig_call);
+
+	return ret < 0 ? ret : tjit.common.prg;
+}
+
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 				void *image_end, const struct btf_func_model *m,
 				u32 flags, struct bpf_tramp_links *tlinks,
@@ -2629,30 +2644,27 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_=
image *im, void *image,
 {
 	struct bpf_tramp_jit tjit;
 	int ret;
-	int i;
=20
-	for (i =3D 0; i < 2; i++) {
-		if (i =3D=3D 0) {
-			/* Compute offsets, check whether the code fits. */
-			memset(&tjit, 0, sizeof(tjit));
-		} else {
-			/* Generate the code. */
-			tjit.common.prg =3D 0;
-			tjit.common.prg_buf =3D image;
-		}
-		ret =3D __arch_prepare_bpf_trampoline(im, &tjit, m, flags,
-						    tlinks, func_addr);
-		if (ret < 0)
-			return ret;
-		if (tjit.common.prg > (char *)image_end - (char *)image)
-			/*
-			 * Use the same error code as for exceeding
-			 * BPF_MAX_TRAMP_LINKS.
-			 */
-			return -E2BIG;
-	}
+	/* Compute offsets, check whether the code fits. */
+	memset(&tjit, 0, sizeof(tjit));
+	ret =3D __arch_prepare_bpf_trampoline(im, &tjit, m, flags,
+					    tlinks, func_addr);
+
+	if (ret < 0)
+		return ret;
+	if (tjit.common.prg > (char *)image_end - (char *)image)
+		/*
+		 * Use the same error code as for exceeding
+		 * BPF_MAX_TRAMP_LINKS.
+		 */
+		return -E2BIG;
+
+	tjit.common.prg =3D 0;
+	tjit.common.prg_buf =3D image;
+	ret =3D __arch_prepare_bpf_trampoline(im, &tjit, m, flags,
+					    tlinks, func_addr);
=20
-	return tjit.common.prg;
+	return ret < 0 ? ret : tjit.common.prg;
 }
=20
 bool bpf_jit_supports_subprog_tailcalls(void)
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 5f7528cac344..561530ef2cdb 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2422,10 +2422,10 @@ static int invoke_bpf_mod_ret(const struct btf_fu=
nc_model *m, u8 **pprog,
  * add rsp, 8                      // skip eth_type_trans's frame
  * ret                             // return to its caller
  */
-int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,=
 void *image_end,
-				const struct btf_func_model *m, u32 flags,
-				struct bpf_tramp_links *tlinks,
-				void *func_addr)
+static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, voi=
d *image, void *image_end,
+					 const struct btf_func_model *m, u32 flags,
+					 struct bpf_tramp_links *tlinks,
+					 void *func_addr)
 {
 	int i, ret, nr_regs =3D m->nr_args, stack_size =3D 0;
 	int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
@@ -2678,6 +2678,35 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
 	return ret;
 }
=20
+int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,=
 void *image_end,
+				const struct btf_func_model *m, u32 flags,
+				struct bpf_tramp_links *tlinks,
+				void *func_addr)
+{
+	return __arch_prepare_bpf_trampoline(im, image, image_end, m, flags, tl=
inks, func_addr);
+}
+
+int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
+			     struct bpf_tramp_links *tlinks, void *func_addr)
+{
+	struct bpf_tramp_image im;
+	void *image;
+	int ret;
+
+	/* Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
+	 * This will NOT cause fragmentation in direct map, as we do not
+	 * call set_memory_*() on this buffer.
+	 */
+	image =3D bpf_jit_alloc_exec(PAGE_SIZE);
+	if (!image)
+		return -ENOMEM;
+
+	ret =3D __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, m,=
 flags,
+					    tlinks, func_addr);
+	bpf_jit_free_exec(image);
+	return ret;
+}
+
 static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 =
*image, u8 *buf)
 {
 	u8 *jg_reloc, *prog =3D *pprog;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b28852351959..0160e92e30f9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1087,6 +1087,8 @@ void *arch_alloc_bpf_trampoline(int size);
 void arch_free_bpf_trampoline(void *image, int size);
 void arch_protect_bpf_trampoline(void *image, int size);
 void arch_unprotect_bpf_trampoline(void *image, int size);
+int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
+			     struct bpf_tramp_links *tlinks, void *func_addr);
=20
 u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
 					     struct bpf_tramp_run_ctx *run_ctx);
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 5509bdf98067..285c5b7c1ea4 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1070,6 +1070,12 @@ void __weak arch_unprotect_bpf_trampoline(void *im=
age, int size)
 	set_memory_rw((long)image, 1);
 }
=20
+int __weak arch_bpf_trampoline_size(const struct btf_func_model *m, u32 =
flags,
+				    struct bpf_tramp_links *tlinks, void *func_addr)
+{
+	return -ENOTSUPP;
+}
+
 static int __init init_trampolines(void)
 {
 	int i;
--=20
2.34.1


