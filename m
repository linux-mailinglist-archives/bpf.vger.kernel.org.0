Return-Path: <bpf+bounces-10430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C35B7A7212
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 07:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52AE91C2091D
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 05:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410D43C29;
	Wed, 20 Sep 2023 05:32:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684A428F1
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 05:32:21 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0A5DE
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 22:32:19 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K1v8Vu005308
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 22:32:19 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t76krh2gt-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 22:32:18 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 19 Sep 2023 22:32:17 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
	id 3B31524A600DB; Tue, 19 Sep 2023 22:32:13 -0700 (PDT)
From: Song Liu <song@kernel.org>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@kernel.org>, <kernel-team@meta.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 3/8] bpf: Adjust argument names of arch_prepare_bpf_trampoline()
Date: Tue, 19 Sep 2023 22:31:53 -0700
Message-ID: <20230920053158.3175043-4-song@kernel.org>
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
X-Proofpoint-ORIG-GUID: cdKmAcceISgd4ithLgVW46U0SySyd0mA
X-Proofpoint-GUID: cdKmAcceISgd4ithLgVW46U0SySyd0mA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_02,2023-09-19_01,2023-05-22_02
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We are using "im" for "struct bpf_tramp_image" and "tr" for "struct
bpf_trampoline" in most of the code base. The only exception is the
prototype and fallback version of arch_prepare_bpf_trampoline(). Update
them to match the rest of the code base.

We mix "orig_call" and "func_addr" for the argument in different versions
of arch_prepare_bpf_trampoline(). s/orig_call/func_addr/g so they match.

Signed-off-by: Song Liu <song@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 10 +++++-----
 include/linux/bpf.h           |  4 ++--
 kernel/bpf/trampoline.c       |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
index 7d4af64e3982..d81b886ea4df 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1828,7 +1828,7 @@ static void restore_args(struct jit_ctx *ctx, int a=
rgs_off, int nregs)
  *
  */
 static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_imag=
e *im,
-			      struct bpf_tramp_links *tlinks, void *orig_call,
+			      struct bpf_tramp_links *tlinks, void *func_addr,
 			      int nregs, u32 flags)
 {
 	int i;
@@ -1926,7 +1926,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, =
struct bpf_tramp_image *im,
=20
 	if (flags & BPF_TRAMP_F_IP_ARG) {
 		/* save ip address of the traced function */
-		emit_addr_mov_i64(A64_R(10), (const u64)orig_call, ctx);
+		emit_addr_mov_i64(A64_R(10), (const u64)func_addr, ctx);
 		emit(A64_STR64I(A64_R(10), A64_SP, ip_off), ctx);
 	}
=20
@@ -2029,7 +2029,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, =
struct bpf_tramp_image *im,
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 				void *image_end, const struct btf_func_model *m,
 				u32 flags, struct bpf_tramp_links *tlinks,
-				void *orig_call)
+				void *func_addr)
 {
 	int i, ret;
 	int nregs =3D m->nr_args;
@@ -2050,7 +2050,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image,
 	if (nregs > 8)
 		return -ENOTSUPP;
=20
-	ret =3D prepare_trampoline(&ctx, im, tlinks, orig_call, nregs, flags);
+	ret =3D prepare_trampoline(&ctx, im, tlinks, func_addr, nregs, flags);
 	if (ret < 0)
 		return ret;
=20
@@ -2061,7 +2061,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image,
 	ctx.idx =3D 0;
=20
 	jit_fill_hole(image, (unsigned int)(image_end - image));
-	ret =3D prepare_trampoline(&ctx, im, tlinks, orig_call, nregs, flags);
+	ret =3D prepare_trampoline(&ctx, im, tlinks, func_addr, nregs, flags);
=20
 	if (ret > 0 && validate_code(&ctx) < 0)
 		ret =3D -EINVAL;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 30063a760b5a..27a18c0c10ca 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1079,10 +1079,10 @@ struct bpf_tramp_run_ctx;
  *      fexit =3D a set of program to run after original function
  */
 struct bpf_tramp_image;
-int arch_prepare_bpf_trampoline(struct bpf_tramp_image *tr, void *image,=
 void *image_end,
+int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,=
 void *image_end,
 				const struct btf_func_model *m, u32 flags,
 				struct bpf_tramp_links *tlinks,
-				void *orig_call);
+				void *func_addr);
 u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
 					     struct bpf_tramp_run_ctx *run_ctx);
 void notrace __bpf_prog_exit_sleepable_recur(struct bpf_prog *prog, u64 =
start,
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index e97aeda3a86b..e114a1c7961e 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1032,10 +1032,10 @@ bpf_trampoline_exit_t bpf_trampoline_exit(const s=
truct bpf_prog *prog)
 }
=20
 int __weak
-arch_prepare_bpf_trampoline(struct bpf_tramp_image *tr, void *image, voi=
d *image_end,
+arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, voi=
d *image_end,
 			    const struct btf_func_model *m, u32 flags,
 			    struct bpf_tramp_links *tlinks,
-			    void *orig_call)
+			    void *func_addr)
 {
 	return -ENOTSUPP;
 }
--=20
2.34.1


