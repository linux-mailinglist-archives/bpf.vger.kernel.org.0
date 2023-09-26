Return-Path: <bpf+bounces-10890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 960417AF3A2
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 21:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 459E12818FE
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 19:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE1F4882E;
	Tue, 26 Sep 2023 19:01:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197D412B7D
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 19:01:06 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB1C194
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 12:01:04 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QIgZDC012050
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 12:01:03 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tc4h1gdtp-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 12:01:03 -0700
Received: from twshared19625.39.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 26 Sep 2023 12:00:45 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
	id E9ED4250068CD; Tue, 26 Sep 2023 12:00:33 -0700 (PDT)
From: Song Liu <song@kernel.org>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@kernel.org>, <kernel-team@meta.com>, <iii@linux.ibm.com>,
        <bjorn@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH v3 bpf-next 8/8] x86, bpf: Use bpf_prog_pack for bpf trampoline
Date: Tue, 26 Sep 2023 12:00:20 -0700
Message-ID: <20230926190020.1111575-9-song@kernel.org>
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
X-Proofpoint-ORIG-GUID: tOJlP2Ed407r-PFTgHcVMZ96asulyGu3
X-Proofpoint-GUID: tOJlP2Ed407r-PFTgHcVMZ96asulyGu3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There are three major changes here:

1. Add arch_[alloc|free]_bpf_trampoline based on bpf_prog_pack;
2. Let arch_prepare_bpf_trampoline handle ROX input image, this requires
   arch_prepare_bpf_trampoline allocating a temporary RW buffer;
3. Update __arch_prepare_bpf_trampoline() to handle a RW buffer (rw_image=
)
   and a ROX buffer (image). This part is similar to the image/rw_image
   logic in bpf_int_jit_compile().

Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/x86/net/bpf_jit_comp.c | 95 +++++++++++++++++++++++++++----------
 1 file changed, 69 insertions(+), 26 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 561530ef2cdb..52e1e3e57848 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2198,7 +2198,8 @@ static void restore_regs(const struct btf_func_mode=
l *m, u8 **prog,
=20
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 			   struct bpf_tramp_link *l, int stack_size,
-			   int run_ctx_off, bool save_ret)
+			   int run_ctx_off, bool save_ret,
+			   void *image, void *rw_image)
 {
 	u8 *prog =3D *pprog;
 	u8 *jmp_insn;
@@ -2226,7 +2227,7 @@ static int invoke_bpf_prog(const struct btf_func_mo=
del *m, u8 **pprog,
 	else
 		EMIT4(0x48, 0x8D, 0x75, -run_ctx_off);
=20
-	if (emit_rsb_call(&prog, bpf_trampoline_enter(p), prog))
+	if (emit_rsb_call(&prog, bpf_trampoline_enter(p), image + (prog - (u8 *=
)rw_image)))
 		return -EINVAL;
 	/* remember prog start time returned by __bpf_prog_enter */
 	emit_mov_reg(&prog, true, BPF_REG_6, BPF_REG_0);
@@ -2250,7 +2251,7 @@ static int invoke_bpf_prog(const struct btf_func_mo=
del *m, u8 **pprog,
 			       (long) p->insnsi >> 32,
 			       (u32) (long) p->insnsi);
 	/* call JITed bpf program or interpreter */
-	if (emit_rsb_call(&prog, p->bpf_func, prog))
+	if (emit_rsb_call(&prog, p->bpf_func, image + (prog - (u8 *)rw_image)))
 		return -EINVAL;
=20
 	/*
@@ -2277,7 +2278,7 @@ static int invoke_bpf_prog(const struct btf_func_mo=
del *m, u8 **pprog,
 		EMIT3_off32(0x48, 0x8D, 0x95, -run_ctx_off);
 	else
 		EMIT4(0x48, 0x8D, 0x55, -run_ctx_off);
-	if (emit_rsb_call(&prog, bpf_trampoline_exit(p), prog))
+	if (emit_rsb_call(&prog, bpf_trampoline_exit(p), image + (prog - (u8 *)=
rw_image)))
 		return -EINVAL;
=20
 	*pprog =3D prog;
@@ -2312,14 +2313,15 @@ static int emit_cond_near_jump(u8 **pprog, void *=
func, void *ip, u8 jmp_cond)
=20
 static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 		      struct bpf_tramp_links *tl, int stack_size,
-		      int run_ctx_off, bool save_ret)
+		      int run_ctx_off, bool save_ret,
+		      void *image, void *rw_image)
 {
 	int i;
 	u8 *prog =3D *pprog;
=20
 	for (i =3D 0; i < tl->nr_links; i++) {
 		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
-				    run_ctx_off, save_ret))
+				    run_ctx_off, save_ret, image, rw_image))
 			return -EINVAL;
 	}
 	*pprog =3D prog;
@@ -2328,7 +2330,8 @@ static int invoke_bpf(const struct btf_func_model *=
m, u8 **pprog,
=20
 static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog=
,
 			      struct bpf_tramp_links *tl, int stack_size,
-			      int run_ctx_off, u8 **branches)
+			      int run_ctx_off, u8 **branches,
+			      void *image, void *rw_image)
 {
 	u8 *prog =3D *pprog;
 	int i;
@@ -2339,7 +2342,8 @@ static int invoke_bpf_mod_ret(const struct btf_func=
_model *m, u8 **pprog,
 	emit_mov_imm32(&prog, false, BPF_REG_0, 0);
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
 	for (i =3D 0; i < tl->nr_links; i++) {
-		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size, run_ctx_off, t=
rue))
+		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size, run_ctx_off, t=
rue,
+				    image, rw_image))
 			return -EINVAL;
=20
 		/* mod_ret prog stored return value into [rbp - 8]. Emit:
@@ -2422,7 +2426,8 @@ static int invoke_bpf_mod_ret(const struct btf_func=
_model *m, u8 **pprog,
  * add rsp, 8                      // skip eth_type_trans's frame
  * ret                             // return to its caller
  */
-static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, voi=
d *image, void *image_end,
+static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, voi=
d *rw_image,
+					 void *rw_image_end, void *image,
 					 const struct btf_func_model *m, u32 flags,
 					 struct bpf_tramp_links *tlinks,
 					 void *func_addr)
@@ -2521,7 +2526,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *image
 		orig_call +=3D X86_PATCH_SIZE;
 	}
=20
-	prog =3D image;
+	prog =3D rw_image;
=20
 	EMIT_ENDBR();
 	/*
@@ -2563,7 +2568,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *image
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* arg1: mov rdi, im */
 		emit_mov_imm64(&prog, BPF_REG_1, (long) im >> 32, (u32) (long) im);
-		if (emit_rsb_call(&prog, __bpf_tramp_enter, prog)) {
+		if (emit_rsb_call(&prog, __bpf_tramp_enter,
+				  image + (prog - (u8 *)rw_image))) {
 			ret =3D -EINVAL;
 			goto cleanup;
 		}
@@ -2571,7 +2577,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *image
=20
 	if (fentry->nr_links)
 		if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off,
-			       flags & BPF_TRAMP_F_RET_FENTRY_RET))
+			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image))
 			return -EINVAL;
=20
 	if (fmod_ret->nr_links) {
@@ -2581,7 +2587,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *image
 			return -ENOMEM;
=20
 		if (invoke_bpf_mod_ret(m, &prog, fmod_ret, regs_off,
-				       run_ctx_off, branches)) {
+				       run_ctx_off, branches, image, rw_image)) {
 			ret =3D -EINVAL;
 			goto cleanup;
 		}
@@ -2602,14 +2608,14 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im, void *image
 			EMIT2(0xff, 0xd3); /* call *rbx */
 		} else {
 			/* call original function */
-			if (emit_rsb_call(&prog, orig_call, prog)) {
+			if (emit_rsb_call(&prog, orig_call, image + (prog - (u8 *)rw_image)))=
 {
 				ret =3D -EINVAL;
 				goto cleanup;
 			}
 		}
 		/* remember return value in a stack for bpf prog to access */
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
-		im->ip_after_call =3D prog;
+		im->ip_after_call =3D image + (prog - (u8 *)rw_image);
 		memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
 		prog +=3D X86_PATCH_SIZE;
 	}
@@ -2625,12 +2631,13 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im, void *image
 		 * aligned address of do_fexit.
 		 */
 		for (i =3D 0; i < fmod_ret->nr_links; i++)
-			emit_cond_near_jump(&branches[i], prog, branches[i],
-					    X86_JNE);
+			emit_cond_near_jump(&branches[i], image + (prog - (u8 *)rw_image),
+					    image + (branches[i] - (u8 *)rw_image), X86_JNE);
 	}
=20
 	if (fexit->nr_links)
-		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off, false)) {
+		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off,
+			       false, image, rw_image)) {
 			ret =3D -EINVAL;
 			goto cleanup;
 		}
@@ -2643,10 +2650,10 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im, void *image
 	 * restored to R0.
 	 */
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		im->ip_epilogue =3D prog;
+		im->ip_epilogue =3D image + (prog - (u8 *)rw_image);
 		/* arg1: mov rdi, im */
 		emit_mov_imm64(&prog, BPF_REG_1, (long) im >> 32, (u32) (long) im);
-		if (emit_rsb_call(&prog, __bpf_tramp_exit, prog)) {
+		if (emit_rsb_call(&prog, __bpf_tramp_exit, image + (prog - (u8 *)rw_im=
age))) {
 			ret =3D -EINVAL;
 			goto cleanup;
 		}
@@ -2665,25 +2672,61 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im, void *image
 	if (flags & BPF_TRAMP_F_SKIP_FRAME)
 		/* skip our return address and return to parent */
 		EMIT4(0x48, 0x83, 0xC4, 8); /* add rsp, 8 */
-	emit_return(&prog, prog);
+	emit_return(&prog, image + (prog - (u8 *)rw_image));
 	/* Make sure the trampoline generation logic doesn't overflow */
-	if (WARN_ON_ONCE(prog > (u8 *)image_end - BPF_INSN_SAFETY)) {
+	if (WARN_ON_ONCE(prog > (u8 *)rw_image_end - BPF_INSN_SAFETY)) {
 		ret =3D -EFAULT;
 		goto cleanup;
 	}
-	ret =3D prog - (u8 *)image + BPF_INSN_SAFETY;
+	ret =3D prog - (u8 *)rw_image + BPF_INSN_SAFETY;
=20
 cleanup:
 	kfree(branches);
 	return ret;
 }
=20
+void *arch_alloc_bpf_trampoline(int size)
+{
+	return bpf_prog_pack_alloc(size, jit_fill_hole);
+}
+
+void arch_free_bpf_trampoline(void *image, int size)
+{
+	bpf_prog_pack_free(image, size);
+}
+
+void arch_protect_bpf_trampoline(void *image, int size)
+{
+}
+
+void arch_unprotect_bpf_trampoline(void *image, int size)
+{
+}
+
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,=
 void *image_end,
 				const struct btf_func_model *m, u32 flags,
 				struct bpf_tramp_links *tlinks,
 				void *func_addr)
 {
-	return __arch_prepare_bpf_trampoline(im, image, image_end, m, flags, tl=
inks, func_addr);
+	void *rw_image, *tmp;
+	int ret;
+	u32 size =3D image_end - image;
+
+	rw_image =3D bpf_jit_alloc_exec(size);
+	if (!rw_image)
+		return -ENOMEM;
+
+	ret =3D __arch_prepare_bpf_trampoline(im, rw_image, rw_image + size, im=
age, m,
+					    flags, tlinks, func_addr);
+	if (ret < 0)
+		goto out;
+
+	tmp =3D bpf_arch_text_copy(image, rw_image, size);
+	if (IS_ERR(tmp))
+		ret =3D PTR_ERR(tmp);
+out:
+	bpf_jit_free_exec(rw_image);
+	return ret;
 }
=20
 int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
@@ -2701,8 +2744,8 @@ int arch_bpf_trampoline_size(const struct btf_func_=
model *m, u32 flags,
 	if (!image)
 		return -ENOMEM;
=20
-	ret =3D __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, m,=
 flags,
-					    tlinks, func_addr);
+	ret =3D __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, im=
age,
+					    m, flags, tlinks, func_addr);
 	bpf_jit_free_exec(image);
 	return ret;
 }
--=20
2.34.1


