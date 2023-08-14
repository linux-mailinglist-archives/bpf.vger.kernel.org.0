Return-Path: <bpf+bounces-7747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E7C77BEE9
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 19:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947151C20384
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 17:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C815CA4C;
	Mon, 14 Aug 2023 17:28:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C71BC2FF
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 17:28:46 +0000 (UTC)
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9BE10DE
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 10:28:44 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 785CD24C21FCE; Mon, 14 Aug 2023 10:28:30 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 04/15] bpf: Add bpf_this_cpu_ptr/bpf_per_cpu_ptr support for allocated percpu obj
Date: Mon, 14 Aug 2023 10:28:30 -0700
Message-Id: <20230814172830.1363918-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814172809.1361446-1-yonghong.song@linux.dev>
References: <20230814172809.1361446-1-yonghong.song@linux.dev>
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
 kernel/bpf/verifier.c        | 51 ++++++++++++++++++++++++++++++------
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f70f9ac884d2..e23480db37ec 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -480,6 +480,7 @@ struct bpf_insn_aux_data {
 	bool zext_dst; /* this insn zero extends dst reg */
 	bool storage_get_func_atomic; /* bpf_*_storage_get() with atomic memory=
 alloc */
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
+	bool percpu_ptr_prog_alloc; /* {this,per}_cpu_ptr() with prog alloc */
 	u8 alu_state; /* used in combination with alu_limit */
=20
 	/* below fields are initialized once */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a985fbf18a11..6fc200cb68b6 100644
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
@@ -7945,6 +7946,7 @@ static int check_reg_type(struct bpf_verifier_env *=
env, u32 regno,
 			return -EACCES;
 		break;
 	case PTR_TO_BTF_ID | MEM_PERCPU:
+	case PTR_TO_BTF_ID | MEM_PERCPU | MEM_RCU:
 	case PTR_TO_BTF_ID | MEM_PERCPU | PTR_TRUSTED:
 		/* Handled by helper specific checks */
 		break;
@@ -8287,6 +8289,16 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
 			verbose(env, "Helper has invalid btf_id in R%d\n", regno);
 			return -EACCES;
 		}
+		if (reg->type & MEM_RCU) {
+			const struct btf_type *type =3D btf_type_by_id(reg->btf, reg->btf_id)=
;
+
+			if (!type || !btf_type_is_struct(type)) {
+				verbose(env, "Helper has invalid btf/btf_id in R%d\n", regno);
+				return -EFAULT;
+			}
+			env->insn_aux_data[insn_idx].percpu_ptr_prog_alloc =3D true;
+		}
+
 		meta->ret_btf =3D reg->btf;
 		meta->ret_btf_id =3D reg->btf_id;
 		break;
@@ -9888,14 +9900,18 @@ static int check_helper_call(struct bpf_verifier_=
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
+			if (env->insn_aux_data[insn_idx].percpu_ptr_prog_alloc) {
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
@@ -18646,6 +18662,25 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
 			goto patch_call_imm;
 		}
=20
+		/* bpf_per_cpu_ptr() and bpf_this_cpu_ptr() */
+		if (env->insn_aux_data[i + delta].percpu_ptr_prog_alloc) {
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


