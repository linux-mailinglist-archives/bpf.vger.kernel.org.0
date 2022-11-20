Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ABD631616
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 20:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiKTTyu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 14:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKTTys (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 14:54:48 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA27CEE02
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:54:47 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AKAcror021424
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:54:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=EyRlEGjesgvtlkPB/hAY8zzvqv/Iebnc4tXJv55c8ww=;
 b=ad6Z4HIKJXbiB/Yd6PGaTzg7LVCOJq165zoLhikMGZLrkvwZpuWFlnqEDdKsH2jY/A7H
 bDEYJVH1dgkJ/LCEUiNUKKYmn2kChqAv2M5sc1zEh/3j50y04zxc0M+yripdCHl7qywF
 JqlRAWlZwvxlQQzpKpP/fL9FKl4XeX29zN8= 
Received: from maileast.thefacebook.com ([163.114.130.3])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kxwuyyysc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:54:46 -0800
Received: from twshared9088.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 11:54:46 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 275A31277447F; Sun, 20 Nov 2022 11:54:32 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <kernel-team@fb.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 2/4] bpf: Add a kfunc to type cast from bpf uapi ctx to kernel ctx
Date:   Sun, 20 Nov 2022 11:54:32 -0800
Message-ID: <20221120195432.3113982-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221120195421.3112414-1-yhs@fb.com>
References: <20221120195421.3112414-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5G6XlS7nmjb2fnElk558zzRIlzVJ40Jm
X-Proofpoint-GUID: 5G6XlS7nmjb2fnElk558zzRIlzVJ40Jm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-20_13,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement bpf_cast_to_kern_ctx() kfunc which does a type cast
of a uapi ctx object to the corresponding kernel ctx. Previously
if users want to access some data available in kctx but not
in uapi ctx, bpf_probe_read_kernel() helper is needed.
The introduction of bpf_cast_to_kern_ctx() allows direct
memory access which makes code simpler and easier to understand.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/btf.h   |  5 +++++
 kernel/bpf/btf.c      | 20 ++++++++++++++++++++
 kernel/bpf/helpers.c  |  6 ++++++
 kernel/bpf/verifier.c | 22 ++++++++++++++++++++++
 4 files changed, 53 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index d38aa4251c28..9ed00077db6e 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -487,6 +487,7 @@ const struct btf_member *
 btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *bt=
f,
 		      const struct btf_type *t, enum bpf_prog_type prog_type,
 		      int arg);
+int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type=
 prog_type);
 bool btf_types_are_same(const struct btf *btf1, u32 id1,
 			const struct btf *btf2, u32 id2);
 #else
@@ -531,6 +532,10 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, =
const struct btf *btf,
 {
 	return NULL;
 }
+static inline int get_kern_ctx_btf_id(struct bpf_verifier_log *log,
+				      enum bpf_prog_type prog_type) {
+	return -EINVAL;
+}
 static inline bool btf_types_are_same(const struct btf *btf1, u32 id1,
 				      const struct btf *btf2, u32 id2)
 {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 1c78d4df9e18..1a59cc7ad730 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5603,6 +5603,26 @@ static int btf_translate_to_vmlinux(struct bpf_ver=
ifier_log *log,
 	return kern_ctx_type->type;
 }
=20
+int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type=
 prog_type)
+{
+	const struct btf_member *kctx_member;
+	const struct btf_type *conv_struct;
+	const struct btf_type *kctx_type;
+	u32 kctx_type_id;
+
+	conv_struct =3D bpf_ctx_convert.t;
+	/* get member for kernel ctx type */
+	kctx_member =3D btf_type_member(conv_struct) + bpf_ctx_convert_map[prog=
_type] * 2 + 1;
+	kctx_type_id =3D kctx_member->type;
+	kctx_type =3D btf_type_by_id(btf_vmlinux, kctx_type_id);
+	if (!btf_type_is_struct(kctx_type)) {
+		bpf_log(log, "kern ctx type id %u is not a struct\n", kctx_type_id);
+		return -EINVAL;
+	}
+
+	return kctx_type_id;
+}
+
 BTF_ID_LIST(bpf_ctx_convert_btf_id)
 BTF_ID(struct, bpf_ctx_convert)
=20
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6b2de097b950..a4b9cfcecb00 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1881,6 +1881,11 @@ void bpf_task_release(struct task_struct *p)
 	put_task_struct_rcu_user(p);
 }
=20
+void *bpf_cast_to_kern_ctx(void *obj)
+{
+	return obj;
+}
+
 __diag_pop();
=20
 BTF_SET8_START(generic_btf_ids)
@@ -1909,6 +1914,7 @@ BTF_ID(struct, task_struct)
 BTF_ID(func, bpf_task_release)
=20
 BTF_SET8_START(common_btf_ids)
+BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx)
 BTF_SET8_END(common_btf_ids)
=20
 static const struct btf_kfunc_id_set common_kfunc_set =3D {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5bc9d84d7924..a035356ed5df 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7907,6 +7907,7 @@ struct bpf_kfunc_call_arg_meta {
 	u32 ref_obj_id;
 	u8 release_regno;
 	bool r0_rdonly;
+	u32 ret_btf_id;
 	u64 r0_size;
 	struct {
 		u64 value;
@@ -8151,6 +8152,7 @@ enum special_kfunc_type {
 	KF_bpf_list_push_back,
 	KF_bpf_list_pop_front,
 	KF_bpf_list_pop_back,
+	KF_bpf_cast_to_kern_ctx,
 };
=20
 BTF_SET_START(special_kfunc_set)
@@ -8160,6 +8162,7 @@ BTF_ID(func, bpf_list_push_front)
 BTF_ID(func, bpf_list_push_back)
 BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
+BTF_ID(func, bpf_cast_to_kern_ctx)
 BTF_SET_END(special_kfunc_set)
=20
 BTF_ID_LIST(special_kfunc_list)
@@ -8169,6 +8172,7 @@ BTF_ID(func, bpf_list_push_front)
 BTF_ID(func, bpf_list_push_back)
 BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
+BTF_ID(func, bpf_cast_to_kern_ctx)
=20
 static enum kfunc_ptr_arg_type
 get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
@@ -8182,6 +8186,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env=
,
 	struct bpf_reg_state *reg =3D &regs[regno];
 	bool arg_mem_size =3D false;
=20
+	if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern_ctx])
+		return KF_ARG_PTR_TO_CTX;
+
 	/* In this function, we verify the kfunc's BTF as per the argument type=
,
 	 * leaving the rest of the verification with respect to the register
 	 * type to our caller. When a set of conditions hold in the BTF type of
@@ -8668,6 +8675,13 @@ static int check_kfunc_args(struct bpf_verifier_en=
v *env, struct bpf_kfunc_call_
 				verbose(env, "arg#%d expected pointer to ctx, but got %s\n", i, btf_=
type_str(t));
 				return -EINVAL;
 			}
+
+			if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern_ctx])=
 {
+				ret =3D get_kern_ctx_btf_id(&env->log, resolve_prog_type(env->prog))=
;
+				if (ret < 0)
+					return -EINVAL;
+				meta->ret_btf_id  =3D ret;
+			}
 			break;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 			if (reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC)) {
@@ -8919,6 +8933,11 @@ static int check_kfunc_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
 				regs[BPF_REG_0].btf =3D field->list_head.btf;
 				regs[BPF_REG_0].btf_id =3D field->list_head.value_btf_id;
 				regs[BPF_REG_0].off =3D field->list_head.node_offset;
+			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern=
_ctx]) {
+				mark_reg_known_zero(env, regs, BPF_REG_0);
+				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | PTR_TRUSTED;
+				regs[BPF_REG_0].btf =3D desc_btf;
+				regs[BPF_REG_0].btf_id =3D meta.ret_btf_id;
 			} else {
 				verbose(env, "kernel function %s unhandled dynamic return type\n",
 					meta.func_name);
@@ -15172,6 +15191,9 @@ static int fixup_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 		insn_buf[1] =3D addr[1];
 		insn_buf[2] =3D *insn;
 		*cnt =3D 3;
+	} else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern_=
ctx]) {
+		insn_buf[0] =3D BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
+		*cnt =3D 1;
 	}
 	return 0;
 }
--=20
2.30.2

