Return-Path: <bpf+bounces-8688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 146AE788F6C
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 21:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCAFB28184F
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 19:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A691938D;
	Fri, 25 Aug 2023 19:53:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC25F322B
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 19:53:58 +0000 (UTC)
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5699E2686
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 12:53:57 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id B8AF125659FF7; Fri, 25 Aug 2023 12:53:48 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 04/13] bpf: Add bpf_this_cpu_ptr/bpf_per_cpu_ptr support for allocated percpu obj
Date: Fri, 25 Aug 2023 12:53:48 -0700
Message-Id: <20230825195348.93644-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825195328.92126-1-yonghong.song@linux.dev>
References: <20230825195328.92126-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_SOFTFAIL,
	TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The bpf helpers bpf_this_cpu_ptr() and bpf_per_cpu_ptr() are re-purposed
for allocated percpu objects. For an allocated percpu obj,
the reg type is 'PTR_TO_BTF_ID | MEM_PERCPU | MEM_RCU'.

The return type for these two re-purposed helpera is
'PTR_TO_MEM | MEM_RCU | MEM_ALLOC'.
The MEM_ALLOC allows that the per-cpu data can be read and written.

Since the memory allocator bpf_mem_alloc() returns
a ptr to a percpu ptr for percpu data, the first argument
of bpf_this_cpu_ptr() and bpf_per_cpu_ptr() is patched
with a dereference before passing to the helper func.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 59 +++++++++++++++++++++++++++++++-----
 2 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b6e58dab8e27..a3236651ec64 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -480,6 +480,7 @@ struct bpf_insn_aux_data {
 	bool zext_dst; /* this insn zero extends dst reg */
 	bool storage_get_func_atomic; /* bpf_*_storage_get() with atomic memory=
 alloc */
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
+	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog perc=
pu alloc */
 	u8 alu_state; /* used in combination with alu_limit */
=20
 	/* below fields are initialized once */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6c886ead18f6..6b7e7ca611f3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6221,7 +6221,7 @@ static int check_ptr_to_btf_access(struct bpf_verif=
ier_env *env,
 		}
=20
 		if (type_is_alloc(reg->type) && !type_is_non_owning_ref(reg->type) &&
-		    !reg->ref_obj_id) {
+		    !(reg->type & MEM_RCU) && !reg->ref_obj_id) {
 			verbose(env, "verifier internal error: ref_obj_id for allocated objec=
t must be non-zero\n");
 			return -EFAULT;
 		}
@@ -7765,6 +7765,7 @@ static const struct bpf_reg_types btf_ptr_types =3D=
 {
 static const struct bpf_reg_types percpu_btf_ptr_types =3D {
 	.types =3D {
 		PTR_TO_BTF_ID | MEM_PERCPU,
+		PTR_TO_BTF_ID | MEM_PERCPU | MEM_RCU,
 		PTR_TO_BTF_ID | MEM_PERCPU | PTR_TRUSTED,
 	}
 };
@@ -7941,6 +7942,7 @@ static int check_reg_type(struct bpf_verifier_env *=
env, u32 regno,
 		}
 		break;
 	case PTR_TO_BTF_ID | MEM_PERCPU:
+	case PTR_TO_BTF_ID | MEM_PERCPU | MEM_RCU:
 	case PTR_TO_BTF_ID | MEM_PERCPU | PTR_TRUSTED:
 		/* Handled by helper specific checks */
 		break;
@@ -9547,6 +9549,7 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
 			     int *insn_idx_p)
 {
 	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
+	bool returns_cpu_specific_alloc_ptr =3D false;
 	const struct bpf_func_proto *fn =3D NULL;
 	enum bpf_return_type ret_type;
 	enum bpf_type_flag ret_flag;
@@ -9785,6 +9788,23 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
=20
 		break;
 	}
+	case BPF_FUNC_per_cpu_ptr:
+	case BPF_FUNC_this_cpu_ptr:
+	{
+		struct bpf_reg_state *reg =3D &regs[BPF_REG_1];
+		const struct btf_type *type;
+
+		if (reg->type & MEM_RCU) {
+			type =3D btf_type_by_id(reg->btf, reg->btf_id);
+			if (!type || !btf_type_is_struct(type)) {
+				verbose(env, "Helper has invalid btf/btf_id in R1\n");
+				return -EFAULT;
+			}
+			returns_cpu_specific_alloc_ptr =3D true;
+			env->insn_aux_data[insn_idx].call_with_percpu_alloc_ptr =3D true;
+		}
+		break;
+	}
 	case BPF_FUNC_user_ringbuf_drain:
 		err =3D __check_func_call(env, insn, insn_idx_p, meta.subprogno,
 					set_user_ringbuf_callback_state);
@@ -9874,14 +9894,18 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
 			regs[BPF_REG_0].type =3D PTR_TO_MEM | ret_flag;
 			regs[BPF_REG_0].mem_size =3D tsize;
 		} else {
-			/* MEM_RDONLY may be carried from ret_flag, but it
-			 * doesn't apply on PTR_TO_BTF_ID. Fold it, otherwise
-			 * it will confuse the check of PTR_TO_BTF_ID in
-			 * check_mem_access().
-			 */
-			ret_flag &=3D ~MEM_RDONLY;
+			if (returns_cpu_specific_alloc_ptr) {
+				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | MEM_ALLOC | MEM_RCU;
+			} else {
+				/* MEM_RDONLY may be carried from ret_flag, but it
+				 * doesn't apply on PTR_TO_BTF_ID. Fold it, otherwise
+				 * it will confuse the check of PTR_TO_BTF_ID in
+				 * check_mem_access().
+				 */
+				ret_flag &=3D ~MEM_RDONLY;
+				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | ret_flag;
+			}
=20
-			regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | ret_flag;
 			regs[BPF_REG_0].btf =3D meta.ret_btf;
 			regs[BPF_REG_0].btf_id =3D meta.ret_btf_id;
 		}
@@ -18676,6 +18700,25 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
 			goto patch_call_imm;
 		}
=20
+		/* bpf_per_cpu_ptr() and bpf_this_cpu_ptr() */
+		if (env->insn_aux_data[i + delta].call_with_percpu_alloc_ptr) {
+			/* patch with 'r1 =3D *(u64 *)(r1 + 0)' since for percpu data,
+			 * bpf_mem_alloc() returns a ptr to the percpu data ptr.
+			 */
+			insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
+			insn_buf[1] =3D *insn;
+			cnt =3D 2;
+
+			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta +=3D cnt - 1;
+			env->prog =3D prog =3D new_prog;
+			insn =3D new_prog->insnsi + i + delta;
+			goto patch_call_imm;
+		}
+
 		/* BPF_EMIT_CALL() assumptions in some of the map_gen_lookup
 		 * and other inlining handlers are currently limited to 64 bit
 		 * only.
--=20
2.34.1


