Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD500522601
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 23:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiEJVCR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 17:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbiEJVCP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 17:02:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0179A26820C
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 14:02:12 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AFLtCR002067
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 14:02:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=RzrYgh7Mgtx+u/w1fOb5TPoOVTS+RN0yAeNQlXRRrG4=;
 b=gz3tB6+4XfKxrH5/9z0VH+cA60ktKLAj05vPBZ7ydbBJesfh1JT9oQ5XbPtcs/afbYup
 Q+kE/9NosSoiG8LKt11cdGGls7UNu95pTREgUxcCVKTxLG4wE2BXXqPda93usK9+AdwR
 cJwajhILDs2vxDtpP5YeJMPZf+AGTOIWFKc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fygdk691g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 14:02:12 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub202.TheFacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 14:02:11 -0700
Received: from twshared11660.23.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 14:02:11 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id B990232F202F; Tue, 10 May 2022 13:59:43 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v8 1/5] bpf, x86: Generate trampolines from bpf_tramp_links
Date:   Tue, 10 May 2022 13:59:19 -0700
Message-ID: <20220510205923.3206889-2-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220510205923.3206889-1-kuifeng@fb.com>
References: <20220510205923.3206889-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: iIPwcIeOCWFbw-2xh3pheX_f7qVABKve
X-Proofpoint-GUID: iIPwcIeOCWFbw-2xh3pheX_f7qVABKve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_07,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace struct bpf_tramp_progs with struct bpf_tramp_links to collect
struct bpf_tramp_link(s) for a trampoline.  struct bpf_tramp_link
extends bpf_link to act as a linked list node.

arch_prepare_bpf_trampoline() accepts a struct bpf_tramp_links to
collects all bpf_tramp_link(s) that a trampoline should call.

Change BPF trampoline and bpf_struct_ops to pass bpf_tramp_links
instead of bpf_tramp_progs.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c    | 36 +++++++++--------
 include/linux/bpf.h            | 36 +++++++++++------
 include/linux/bpf_types.h      |  1 +
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/bpf_struct_ops.c    | 71 +++++++++++++++++++++++----------
 kernel/bpf/syscall.c           | 23 ++++-------
 kernel/bpf/trampoline.c        | 73 +++++++++++++++++++---------------
 net/bpf/bpf_dummy_struct_ops.c | 24 ++++++++---
 tools/bpf/bpftool/link.c       |  1 +
 tools/include/uapi/linux/bpf.h |  1 +
 10 files changed, 164 insertions(+), 103 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 16b6efacf7c6..38eb43159230 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1762,10 +1762,12 @@ static void restore_regs(const struct btf_func_mo=
del *m, u8 **prog, int nr_args,
 }
=20
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
-			   struct bpf_prog *p, int stack_size, bool save_ret)
+			   struct bpf_tramp_link *l, int stack_size,
+			   bool save_ret)
 {
 	u8 *prog =3D *pprog;
 	u8 *jmp_insn;
+	struct bpf_prog *p =3D l->link.prog;
=20
 	/* arg1: mov rdi, progs[i] */
 	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
@@ -1850,14 +1852,14 @@ static int emit_cond_near_jump(u8 **pprog, void *=
func, void *ip, u8 jmp_cond)
 }
=20
 static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
-		      struct bpf_tramp_progs *tp, int stack_size,
+		      struct bpf_tramp_links *tl, int stack_size,
 		      bool save_ret)
 {
 	int i;
 	u8 *prog =3D *pprog;
=20
-	for (i =3D 0; i < tp->nr_progs; i++) {
-		if (invoke_bpf_prog(m, &prog, tp->progs[i], stack_size,
+	for (i =3D 0; i < tl->nr_links; i++) {
+		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
 				    save_ret))
 			return -EINVAL;
 	}
@@ -1866,7 +1868,7 @@ static int invoke_bpf(const struct btf_func_model *=
m, u8 **pprog,
 }
=20
 static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog=
,
-			      struct bpf_tramp_progs *tp, int stack_size,
+			      struct bpf_tramp_links *tl, int stack_size,
 			      u8 **branches)
 {
 	u8 *prog =3D *pprog;
@@ -1877,8 +1879,8 @@ static int invoke_bpf_mod_ret(const struct btf_func=
_model *m, u8 **pprog,
 	 */
 	emit_mov_imm32(&prog, false, BPF_REG_0, 0);
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
-	for (i =3D 0; i < tp->nr_progs; i++) {
-		if (invoke_bpf_prog(m, &prog, tp->progs[i], stack_size, true))
+	for (i =3D 0; i < tl->nr_links; i++) {
+		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size, true))
 			return -EINVAL;
=20
 		/* mod_ret prog stored return value into [rbp - 8]. Emit:
@@ -1980,14 +1982,14 @@ static bool is_valid_bpf_tramp_flags(unsigned int=
 flags)
  */
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,=
 void *image_end,
 				const struct btf_func_model *m, u32 flags,
-				struct bpf_tramp_progs *tprogs,
+				struct bpf_tramp_links *tlinks,
 				void *orig_call)
 {
 	int ret, i, nr_args =3D m->nr_args;
 	int regs_off, ip_off, args_off, stack_size =3D nr_args * 8;
-	struct bpf_tramp_progs *fentry =3D &tprogs[BPF_TRAMP_FENTRY];
-	struct bpf_tramp_progs *fexit =3D &tprogs[BPF_TRAMP_FEXIT];
-	struct bpf_tramp_progs *fmod_ret =3D &tprogs[BPF_TRAMP_MODIFY_RETURN];
+	struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
+	struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
+	struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RETURN];
 	u8 **branches =3D NULL;
 	u8 *prog;
 	bool save_ret;
@@ -2078,13 +2080,13 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_=
image *im, void *image, void *i
 		}
 	}
=20
-	if (fentry->nr_progs)
+	if (fentry->nr_links)
 		if (invoke_bpf(m, &prog, fentry, regs_off,
 			       flags & BPF_TRAMP_F_RET_FENTRY_RET))
 			return -EINVAL;
=20
-	if (fmod_ret->nr_progs) {
-		branches =3D kcalloc(fmod_ret->nr_progs, sizeof(u8 *),
+	if (fmod_ret->nr_links) {
+		branches =3D kcalloc(fmod_ret->nr_links, sizeof(u8 *),
 				   GFP_KERNEL);
 		if (!branches)
 			return -ENOMEM;
@@ -2111,7 +2113,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
 		prog +=3D X86_PATCH_SIZE;
 	}
=20
-	if (fmod_ret->nr_progs) {
+	if (fmod_ret->nr_links) {
 		/* From Intel 64 and IA-32 Architectures Optimization
 		 * Reference Manual, 3.4.1.4 Code Alignment, Assembly/Compiler
 		 * Coding Rule 11: All branch targets should be 16-byte
@@ -2121,12 +2123,12 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_=
image *im, void *image, void *i
 		/* Update the branches saved in invoke_bpf_mod_ret with the
 		 * aligned address of do_fexit.
 		 */
-		for (i =3D 0; i < fmod_ret->nr_progs; i++)
+		for (i =3D 0; i < fmod_ret->nr_links; i++)
 			emit_cond_near_jump(&branches[i], prog, branches[i],
 					    X86_JNE);
 	}
=20
-	if (fexit->nr_progs)
+	if (fexit->nr_links)
 		if (invoke_bpf(m, &prog, fexit, regs_off, false)) {
 			ret =3D -EINVAL;
 			goto cleanup;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 551b7198ae8a..75e0110a65e1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -723,11 +723,11 @@ struct btf_func_model {
 /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is =
~50
  * bytes on x86.  Pick a number to fit into BPF_IMAGE_SIZE / 2
  */
-#define BPF_MAX_TRAMP_PROGS 38
+#define BPF_MAX_TRAMP_LINKS 38
=20
-struct bpf_tramp_progs {
-	struct bpf_prog *progs[BPF_MAX_TRAMP_PROGS];
-	int nr_progs;
+struct bpf_tramp_links {
+	struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
+	int nr_links;
 };
=20
 /* Different use cases for BPF trampoline:
@@ -753,7 +753,7 @@ struct bpf_tramp_progs {
 struct bpf_tramp_image;
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *tr, void *image,=
 void *image_end,
 				const struct btf_func_model *m, u32 flags,
-				struct bpf_tramp_progs *tprogs,
+				struct bpf_tramp_links *tlinks,
 				void *orig_call);
 /* these two functions are called from generated trampoline */
 u64 notrace __bpf_prog_enter(struct bpf_prog *prog);
@@ -852,9 +852,10 @@ static __always_inline __nocfi unsigned int bpf_disp=
atcher_nop_func(
 {
 	return bpf_func(ctx, insnsi);
 }
+
 #ifdef CONFIG_BPF_JIT
-int bpf_trampoline_link_prog(struct bpf_prog *prog, struct bpf_trampolin=
e *tr);
-int bpf_trampoline_unlink_prog(struct bpf_prog *prog, struct bpf_trampol=
ine *tr);
+int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tra=
mpoline *tr);
+int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_t=
rampoline *tr);
 struct bpf_trampoline *bpf_trampoline_get(u64 key,
 					  struct bpf_attach_target_info *tgt_info);
 void bpf_trampoline_put(struct bpf_trampoline *tr);
@@ -905,12 +906,12 @@ int bpf_jit_charge_modmem(u32 size);
 void bpf_jit_uncharge_modmem(u32 size);
 bool bpf_prog_has_trampoline(const struct bpf_prog *prog);
 #else
-static inline int bpf_trampoline_link_prog(struct bpf_prog *prog,
+static inline int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 					   struct bpf_trampoline *tr)
 {
 	return -ENOTSUPP;
 }
-static inline int bpf_trampoline_unlink_prog(struct bpf_prog *prog,
+static inline int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link=
,
 					     struct bpf_trampoline *tr)
 {
 	return -ENOTSUPP;
@@ -1009,7 +1010,6 @@ struct bpf_prog_aux {
 	bool tail_call_reachable;
 	bool xdp_has_frags;
 	bool use_bpf_prog_pack;
-	struct hlist_node tramp_hlist;
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
 	/* function name for valid attach_btf_id */
@@ -1096,6 +1096,18 @@ struct bpf_link_ops {
 			      struct bpf_link_info *info);
 };
=20
+struct bpf_tramp_link {
+	struct bpf_link link;
+	struct hlist_node tramp_hlist;
+};
+
+struct bpf_tracing_link {
+	struct bpf_tramp_link link;
+	enum bpf_attach_type attach_type;
+	struct bpf_trampoline *trampoline;
+	struct bpf_prog *tgt_prog;
+};
+
 struct bpf_link_primer {
 	struct bpf_link *link;
 	struct file *file;
@@ -1133,8 +1145,8 @@ bool bpf_struct_ops_get(const void *kdata);
 void bpf_struct_ops_put(const void *kdata);
 int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
 				       void *value);
-int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_progs *tprogs,
-				      struct bpf_prog *prog,
+int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
+				      struct bpf_tramp_link *link,
 				      const struct btf_func_model *model,
 				      void *image, void *image_end);
 static inline bool bpf_try_module_get(const void *data, struct module *o=
wner)
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 3e24ad0c4b3c..2b9112b80171 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -141,3 +141,4 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_XDP, xdp)
 BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
 #endif
 BPF_LINK_TYPE(BPF_LINK_TYPE_KPROBE_MULTI, kprobe_multi)
+BPF_LINK_TYPE(BPF_LINK_TYPE_STRUCT_OPS, struct_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 95a3d1ff6255..3d032ea1b6a3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1013,6 +1013,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_XDP =3D 6,
 	BPF_LINK_TYPE_PERF_EVENT =3D 7,
 	BPF_LINK_TYPE_KPROBE_MULTI =3D 8,
+	BPF_LINK_TYPE_STRUCT_OPS =3D 9,
=20
 	MAX_BPF_LINK_TYPE,
 };
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 3a0103ad97bc..d9a3c9207240 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -33,15 +33,15 @@ struct bpf_struct_ops_map {
 	const struct bpf_struct_ops *st_ops;
 	/* protect map_update */
 	struct mutex lock;
-	/* progs has all the bpf_prog that is populated
+	/* link has all the bpf_links that is populated
 	 * to the func ptr of the kernel's struct
 	 * (in kvalue.data).
 	 */
-	struct bpf_prog **progs;
+	struct bpf_link **links;
 	/* image is a page that has all the trampolines
 	 * that stores the func args before calling the bpf_prog.
 	 * A PAGE_SIZE "image" is enough to store all trampoline for
-	 * "progs[]".
+	 * "links[]".
 	 */
 	void *image;
 	/* uvalue->data stores the kernel struct
@@ -283,9 +283,9 @@ static void bpf_struct_ops_map_put_progs(struct bpf_s=
truct_ops_map *st_map)
 	u32 i;
=20
 	for (i =3D 0; i < btf_type_vlen(t); i++) {
-		if (st_map->progs[i]) {
-			bpf_prog_put(st_map->progs[i]);
-			st_map->progs[i] =3D NULL;
+		if (st_map->links[i]) {
+			bpf_link_put(st_map->links[i]);
+			st_map->links[i] =3D NULL;
 		}
 	}
 }
@@ -316,18 +316,34 @@ static int check_zero_holes(const struct btf_type *=
t, void *data)
 	return 0;
 }
=20
-int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_progs *tprogs,
-				      struct bpf_prog *prog,
+static void bpf_struct_ops_link_release(struct bpf_link *link)
+{
+}
+
+static void bpf_struct_ops_link_dealloc(struct bpf_link *link)
+{
+	struct bpf_tramp_link *tlink =3D container_of(link, struct bpf_tramp_li=
nk, link);
+
+	kfree(tlink);
+}
+
+const struct bpf_link_ops bpf_struct_ops_link_lops =3D {
+	.release =3D bpf_struct_ops_link_release,
+	.dealloc =3D bpf_struct_ops_link_dealloc,
+};
+
+int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
+				      struct bpf_tramp_link *link,
 				      const struct btf_func_model *model,
 				      void *image, void *image_end)
 {
 	u32 flags;
=20
-	tprogs[BPF_TRAMP_FENTRY].progs[0] =3D prog;
-	tprogs[BPF_TRAMP_FENTRY].nr_progs =3D 1;
+	tlinks[BPF_TRAMP_FENTRY].links[0] =3D link;
+	tlinks[BPF_TRAMP_FENTRY].nr_links =3D 1;
 	flags =3D model->ret_size > 0 ? BPF_TRAMP_F_RET_FENTRY_RET : 0;
 	return arch_prepare_bpf_trampoline(NULL, image, image_end,
-					   model, flags, tprogs, NULL);
+					   model, flags, tlinks, NULL);
 }
=20
 static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key=
,
@@ -338,7 +354,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_=
map *map, void *key,
 	struct bpf_struct_ops_value *uvalue, *kvalue;
 	const struct btf_member *member;
 	const struct btf_type *t =3D st_ops->type;
-	struct bpf_tramp_progs *tprogs =3D NULL;
+	struct bpf_tramp_links *tlinks =3D NULL;
 	void *udata, *kdata;
 	int prog_fd, err =3D 0;
 	void *image, *image_end;
@@ -362,8 +378,8 @@ static int bpf_struct_ops_map_update_elem(struct bpf_=
map *map, void *key,
 	if (uvalue->state || refcount_read(&uvalue->refcnt))
 		return -EINVAL;
=20
-	tprogs =3D kcalloc(BPF_TRAMP_MAX, sizeof(*tprogs), GFP_KERNEL);
-	if (!tprogs)
+	tlinks =3D kcalloc(BPF_TRAMP_MAX, sizeof(*tlinks), GFP_KERNEL);
+	if (!tlinks)
 		return -ENOMEM;
=20
 	uvalue =3D (struct bpf_struct_ops_value *)st_map->uvalue;
@@ -386,6 +402,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_=
map *map, void *key,
 	for_each_member(i, t, member) {
 		const struct btf_type *mtype, *ptype;
 		struct bpf_prog *prog;
+		struct bpf_tramp_link *link;
 		u32 moff;
=20
 		moff =3D __btf_member_bit_offset(t, member) / 8;
@@ -439,16 +456,26 @@ static int bpf_struct_ops_map_update_elem(struct bp=
f_map *map, void *key,
 			err =3D PTR_ERR(prog);
 			goto reset_unlock;
 		}
-		st_map->progs[i] =3D prog;
=20
 		if (prog->type !=3D BPF_PROG_TYPE_STRUCT_OPS ||
 		    prog->aux->attach_btf_id !=3D st_ops->type_id ||
 		    prog->expected_attach_type !=3D i) {
+			bpf_prog_put(prog);
 			err =3D -EINVAL;
 			goto reset_unlock;
 		}
=20
-		err =3D bpf_struct_ops_prepare_trampoline(tprogs, prog,
+		link =3D kzalloc(sizeof(*link), GFP_USER);
+		if (!link) {
+			bpf_prog_put(prog);
+			err =3D -ENOMEM;
+			goto reset_unlock;
+		}
+		bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS,
+			      &bpf_struct_ops_link_lops, prog);
+		st_map->links[i] =3D &link->link;
+
+		err =3D bpf_struct_ops_prepare_trampoline(tlinks, link,
 							&st_ops->func_models[i],
 							image, image_end);
 		if (err < 0)
@@ -491,7 +518,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_=
map *map, void *key,
 	memset(uvalue, 0, map->value_size);
 	memset(kvalue, 0, map->value_size);
 unlock:
-	kfree(tprogs);
+	kfree(tlinks);
 	mutex_unlock(&st_map->lock);
 	return err;
 }
@@ -546,9 +573,9 @@ static void bpf_struct_ops_map_free(struct bpf_map *m=
ap)
 {
 	struct bpf_struct_ops_map *st_map =3D (struct bpf_struct_ops_map *)map;
=20
-	if (st_map->progs)
+	if (st_map->links)
 		bpf_struct_ops_map_put_progs(st_map);
-	bpf_map_area_free(st_map->progs);
+	bpf_map_area_free(st_map->links);
 	bpf_jit_free_exec(st_map->image);
 	bpf_map_area_free(st_map->uvalue);
 	bpf_map_area_free(st_map);
@@ -597,11 +624,11 @@ static struct bpf_map *bpf_struct_ops_map_alloc(uni=
on bpf_attr *attr)
 	map =3D &st_map->map;
=20
 	st_map->uvalue =3D bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
-	st_map->progs =3D
-		bpf_map_area_alloc(btf_type_vlen(t) * sizeof(struct bpf_prog *),
+	st_map->links =3D
+		bpf_map_area_alloc(btf_type_vlen(t) * sizeof(struct bpf_links *),
 				   NUMA_NO_NODE);
 	st_map->image =3D bpf_jit_alloc_exec(PAGE_SIZE);
-	if (!st_map->uvalue || !st_map->progs || !st_map->image) {
+	if (!st_map->uvalue || !st_map->links || !st_map->image) {
 		bpf_struct_ops_map_free(map);
 		return ERR_PTR(-ENOMEM);
 	}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 50164d324eaf..2dc582773344 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2864,19 +2864,12 @@ struct bpf_link *bpf_link_get_from_fd(u32 ufd)
 }
 EXPORT_SYMBOL(bpf_link_get_from_fd);
=20
-struct bpf_tracing_link {
-	struct bpf_link link;
-	enum bpf_attach_type attach_type;
-	struct bpf_trampoline *trampoline;
-	struct bpf_prog *tgt_prog;
-};
-
 static void bpf_tracing_link_release(struct bpf_link *link)
 {
 	struct bpf_tracing_link *tr_link =3D
-		container_of(link, struct bpf_tracing_link, link);
+		container_of(link, struct bpf_tracing_link, link.link);
=20
-	WARN_ON_ONCE(bpf_trampoline_unlink_prog(link->prog,
+	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link,
 						tr_link->trampoline));
=20
 	bpf_trampoline_put(tr_link->trampoline);
@@ -2889,7 +2882,7 @@ static void bpf_tracing_link_release(struct bpf_lin=
k *link)
 static void bpf_tracing_link_dealloc(struct bpf_link *link)
 {
 	struct bpf_tracing_link *tr_link =3D
-		container_of(link, struct bpf_tracing_link, link);
+		container_of(link, struct bpf_tracing_link, link.link);
=20
 	kfree(tr_link);
 }
@@ -2898,7 +2891,7 @@ static void bpf_tracing_link_show_fdinfo(const stru=
ct bpf_link *link,
 					 struct seq_file *seq)
 {
 	struct bpf_tracing_link *tr_link =3D
-		container_of(link, struct bpf_tracing_link, link);
+		container_of(link, struct bpf_tracing_link, link.link);
=20
 	seq_printf(seq,
 		   "attach_type:\t%d\n",
@@ -2909,7 +2902,7 @@ static int bpf_tracing_link_fill_link_info(const st=
ruct bpf_link *link,
 					   struct bpf_link_info *info)
 {
 	struct bpf_tracing_link *tr_link =3D
-		container_of(link, struct bpf_tracing_link, link);
+		container_of(link, struct bpf_tracing_link, link.link);
=20
 	info->tracing.attach_type =3D tr_link->attach_type;
 	bpf_trampoline_unpack_key(tr_link->trampoline->key,
@@ -2990,7 +2983,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog =
*prog,
 		err =3D -ENOMEM;
 		goto out_put_prog;
 	}
-	bpf_link_init(&link->link, BPF_LINK_TYPE_TRACING,
+	bpf_link_init(&link->link.link, BPF_LINK_TYPE_TRACING,
 		      &bpf_tracing_link_lops, prog);
 	link->attach_type =3D prog->expected_attach_type;
=20
@@ -3060,11 +3053,11 @@ static int bpf_tracing_prog_attach(struct bpf_pro=
g *prog,
 		tgt_prog =3D prog->aux->dst_prog;
 	}
=20
-	err =3D bpf_link_prime(&link->link, &link_primer);
+	err =3D bpf_link_prime(&link->link.link, &link_primer);
 	if (err)
 		goto out_unlock;
=20
-	err =3D bpf_trampoline_link_prog(prog, tr);
+	err =3D bpf_trampoline_link_prog(&link->link, tr);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
 		link =3D NULL;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index ada97751ae1b..d5e6bc5517cb 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -168,30 +168,30 @@ static int register_fentry(struct bpf_trampoline *t=
r, void *new_addr)
 	return ret;
 }
=20
-static struct bpf_tramp_progs *
+static struct bpf_tramp_links *
 bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bo=
ol *ip_arg)
 {
-	const struct bpf_prog_aux *aux;
-	struct bpf_tramp_progs *tprogs;
-	struct bpf_prog **progs;
+	struct bpf_tramp_link *link;
+	struct bpf_tramp_links *tlinks;
+	struct bpf_tramp_link **links;
 	int kind;
=20
 	*total =3D 0;
-	tprogs =3D kcalloc(BPF_TRAMP_MAX, sizeof(*tprogs), GFP_KERNEL);
-	if (!tprogs)
+	tlinks =3D kcalloc(BPF_TRAMP_MAX, sizeof(*tlinks), GFP_KERNEL);
+	if (!tlinks)
 		return ERR_PTR(-ENOMEM);
=20
 	for (kind =3D 0; kind < BPF_TRAMP_MAX; kind++) {
-		tprogs[kind].nr_progs =3D tr->progs_cnt[kind];
+		tlinks[kind].nr_links =3D tr->progs_cnt[kind];
 		*total +=3D tr->progs_cnt[kind];
-		progs =3D tprogs[kind].progs;
+		links =3D tlinks[kind].links;
=20
-		hlist_for_each_entry(aux, &tr->progs_hlist[kind], tramp_hlist) {
-			*ip_arg |=3D aux->prog->call_get_func_ip;
-			*progs++ =3D aux->prog;
+		hlist_for_each_entry(link, &tr->progs_hlist[kind], tramp_hlist) {
+			*ip_arg |=3D link->link.prog->call_get_func_ip;
+			*links++ =3D link;
 		}
 	}
-	return tprogs;
+	return tlinks;
 }
=20
 static void __bpf_tramp_image_put_deferred(struct work_struct *work)
@@ -330,14 +330,14 @@ static struct bpf_tramp_image *bpf_tramp_image_allo=
c(u64 key, u32 idx)
 static int bpf_trampoline_update(struct bpf_trampoline *tr)
 {
 	struct bpf_tramp_image *im;
-	struct bpf_tramp_progs *tprogs;
+	struct bpf_tramp_links *tlinks;
 	u32 flags =3D BPF_TRAMP_F_RESTORE_REGS;
 	bool ip_arg =3D false;
 	int err, total;
=20
-	tprogs =3D bpf_trampoline_get_progs(tr, &total, &ip_arg);
-	if (IS_ERR(tprogs))
-		return PTR_ERR(tprogs);
+	tlinks =3D bpf_trampoline_get_progs(tr, &total, &ip_arg);
+	if (IS_ERR(tlinks))
+		return PTR_ERR(tlinks);
=20
 	if (total =3D=3D 0) {
 		err =3D unregister_fentry(tr, tr->cur_image->image);
@@ -353,15 +353,15 @@ static int bpf_trampoline_update(struct bpf_trampol=
ine *tr)
 		goto out;
 	}
=20
-	if (tprogs[BPF_TRAMP_FEXIT].nr_progs ||
-	    tprogs[BPF_TRAMP_MODIFY_RETURN].nr_progs)
+	if (tlinks[BPF_TRAMP_FEXIT].nr_links ||
+	    tlinks[BPF_TRAMP_MODIFY_RETURN].nr_links)
 		flags =3D BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_SKIP_FRAME;
=20
 	if (ip_arg)
 		flags |=3D BPF_TRAMP_F_IP_ARG;
=20
 	err =3D arch_prepare_bpf_trampoline(im, im->image, im->image + PAGE_SIZ=
E,
-					  &tr->func.model, flags, tprogs,
+					  &tr->func.model, flags, tlinks,
 					  tr->func.addr);
 	if (err < 0)
 		goto out;
@@ -381,7 +381,7 @@ static int bpf_trampoline_update(struct bpf_trampolin=
e *tr)
 	tr->cur_image =3D im;
 	tr->selector++;
 out:
-	kfree(tprogs);
+	kfree(tlinks);
 	return err;
 }
=20
@@ -407,13 +407,14 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_=
tramp(struct bpf_prog *prog)
 	}
 }
=20
-int bpf_trampoline_link_prog(struct bpf_prog *prog, struct bpf_trampolin=
e *tr)
+int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tra=
mpoline *tr)
 {
 	enum bpf_tramp_prog_type kind;
+	struct bpf_tramp_link *link_exiting;
 	int err =3D 0;
 	int cnt;
=20
-	kind =3D bpf_attach_type_to_tramp(prog);
+	kind =3D bpf_attach_type_to_tramp(link->link.prog);
 	mutex_lock(&tr->mutex);
 	if (tr->extension_prog) {
 		/* cannot attach fentry/fexit if extension prog is attached.
@@ -429,25 +430,33 @@ int bpf_trampoline_link_prog(struct bpf_prog *prog,=
 struct bpf_trampoline *tr)
 			err =3D -EBUSY;
 			goto out;
 		}
-		tr->extension_prog =3D prog;
+		tr->extension_prog =3D link->link.prog;
 		err =3D bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP, NULL,
-					 prog->bpf_func);
+					 link->link.prog->bpf_func);
 		goto out;
 	}
-	if (cnt >=3D BPF_MAX_TRAMP_PROGS) {
+	if (cnt >=3D BPF_MAX_TRAMP_LINKS) {
 		err =3D -E2BIG;
 		goto out;
 	}
-	if (!hlist_unhashed(&prog->aux->tramp_hlist)) {
+	if (!hlist_unhashed(&link->tramp_hlist)) {
 		/* prog already linked */
 		err =3D -EBUSY;
 		goto out;
 	}
-	hlist_add_head(&prog->aux->tramp_hlist, &tr->progs_hlist[kind]);
+	hlist_for_each_entry(link_exiting, &tr->progs_hlist[kind], tramp_hlist)=
 {
+		if (link_exiting->link.prog !=3D link->link.prog)
+			continue;
+		/* prog already linked */
+		err =3D -EBUSY;
+		goto out;
+	}
+
+	hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
 	tr->progs_cnt[kind]++;
 	err =3D bpf_trampoline_update(tr);
 	if (err) {
-		hlist_del_init(&prog->aux->tramp_hlist);
+		hlist_del_init(&link->tramp_hlist);
 		tr->progs_cnt[kind]--;
 	}
 out:
@@ -456,12 +465,12 @@ int bpf_trampoline_link_prog(struct bpf_prog *prog,=
 struct bpf_trampoline *tr)
 }
=20
 /* bpf_trampoline_unlink_prog() should never fail. */
-int bpf_trampoline_unlink_prog(struct bpf_prog *prog, struct bpf_trampol=
ine *tr)
+int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_t=
rampoline *tr)
 {
 	enum bpf_tramp_prog_type kind;
 	int err;
=20
-	kind =3D bpf_attach_type_to_tramp(prog);
+	kind =3D bpf_attach_type_to_tramp(link->link.prog);
 	mutex_lock(&tr->mutex);
 	if (kind =3D=3D BPF_TRAMP_REPLACE) {
 		WARN_ON_ONCE(!tr->extension_prog);
@@ -470,7 +479,7 @@ int bpf_trampoline_unlink_prog(struct bpf_prog *prog,=
 struct bpf_trampoline *tr)
 		tr->extension_prog =3D NULL;
 		goto out;
 	}
-	hlist_del_init(&prog->aux->tramp_hlist);
+	hlist_del_init(&link->tramp_hlist);
 	tr->progs_cnt[kind]--;
 	err =3D bpf_trampoline_update(tr);
 out:
@@ -635,7 +644,7 @@ void notrace __bpf_tramp_exit(struct bpf_tramp_image =
*tr)
 int __weak
 arch_prepare_bpf_trampoline(struct bpf_tramp_image *tr, void *image, voi=
d *image_end,
 			    const struct btf_func_model *m, u32 flags,
-			    struct bpf_tramp_progs *tprogs,
+			    struct bpf_tramp_links *tlinks,
 			    void *orig_call)
 {
 	return -ENOTSUPP;
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_op=
s.c
index d0e54e30658a..e78dadfc5829 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -72,13 +72,16 @@ static int dummy_ops_call_op(void *image, struct bpf_=
dummy_ops_test_args *args)
 		    args->args[3], args->args[4]);
 }
=20
+extern const struct bpf_link_ops bpf_struct_ops_link_lops;
+
 int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr =
*kattr,
 			    union bpf_attr __user *uattr)
 {
 	const struct bpf_struct_ops *st_ops =3D &bpf_bpf_dummy_ops;
 	const struct btf_type *func_proto;
 	struct bpf_dummy_ops_test_args *args;
-	struct bpf_tramp_progs *tprogs;
+	struct bpf_tramp_links *tlinks;
+	struct bpf_tramp_link *link =3D NULL;
 	void *image =3D NULL;
 	unsigned int op_idx;
 	int prog_ret;
@@ -92,8 +95,8 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, cons=
t union bpf_attr *kattr,
 	if (IS_ERR(args))
 		return PTR_ERR(args);
=20
-	tprogs =3D kcalloc(BPF_TRAMP_MAX, sizeof(*tprogs), GFP_KERNEL);
-	if (!tprogs) {
+	tlinks =3D kcalloc(BPF_TRAMP_MAX, sizeof(*tlinks), GFP_KERNEL);
+	if (!tlinks) {
 		err =3D -ENOMEM;
 		goto out;
 	}
@@ -105,8 +108,17 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, c=
onst union bpf_attr *kattr,
 	}
 	set_vm_flush_reset_perms(image);
=20
+	link =3D kzalloc(sizeof(*link), GFP_USER);
+	if (!link) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+	/* prog doesn't take the ownership of the reference from caller */
+	bpf_prog_inc(prog);
+	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_li=
nk_lops, prog);
+
 	op_idx =3D prog->expected_attach_type;
-	err =3D bpf_struct_ops_prepare_trampoline(tprogs, prog,
+	err =3D bpf_struct_ops_prepare_trampoline(tlinks, link,
 						&st_ops->func_models[op_idx],
 						image, image + PAGE_SIZE);
 	if (err < 0)
@@ -124,7 +136,9 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, co=
nst union bpf_attr *kattr,
 out:
 	kfree(args);
 	bpf_jit_free_exec(image);
-	kfree(tprogs);
+	if (link)
+		bpf_link_put(&link->link);
+	kfree(tlinks);
 	return err;
 }
=20
diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 8fb0116f9136..6353a789322b 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -23,6 +23,7 @@ static const char * const link_type_name[] =3D {
 	[BPF_LINK_TYPE_XDP]			=3D "xdp",
 	[BPF_LINK_TYPE_PERF_EVENT]		=3D "perf_event",
 	[BPF_LINK_TYPE_KPROBE_MULTI]		=3D "kprobe_multi",
+	[BPF_LINK_TYPE_STRUCT_OPS]               =3D "struct_ops",
 };
=20
 static struct hashmap *link_table;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 95a3d1ff6255..3d032ea1b6a3 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1013,6 +1013,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_XDP =3D 6,
 	BPF_LINK_TYPE_PERF_EVENT =3D 7,
 	BPF_LINK_TYPE_KPROBE_MULTI =3D 8,
+	BPF_LINK_TYPE_STRUCT_OPS =3D 9,
=20
 	MAX_BPF_LINK_TYPE,
 };
--=20
2.30.2

