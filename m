Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043A762851A
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 17:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237480AbiKNQYL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 11:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbiKNQXz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 11:23:55 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77D42F00F
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 08:23:54 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AEF4o6t022456
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 08:23:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=uUKRhsM5jRddKpkUUjav180R/n9P0rYxx5g053cT06Q=;
 b=LPYOzGSWPcK0Oe+rJ/gBW2MHhmb0XRr8jEwyDhG8Nxm3G2mN3g84We3vRuwfIpp0ZDym
 eUvf+LqsjBtNumtDlBEAZ2CERXXY58K0QJLCuZzNlAyPRPFUeEoqbqAxysj6h1GWIczy
 tVJljbxZ/Oh9JeVfAFxlLFGgYQBPCFydsmQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kur0e8w11-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 08:23:54 -0800
Received: from twshared9088.05.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 08:23:53 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 9024C12265EF1; Mon, 14 Nov 2022 08:23:40 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [RFC PATCH bpf-next 2/3] bpf: Implement bpf_get_kern_btf_id() kfunc
Date:   Mon, 14 Nov 2022 08:23:39 -0800
Message-ID: <20221114162339.625320-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221114162328.622665-1-yhs@fb.com>
References: <20221114162328.622665-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 1M1dLRsDsOm_oNPO4O44QcLrD6ehYhhc
X-Proofpoint-ORIG-GUID: 1M1dLRsDsOm_oNPO4O44QcLrD6ehYhhc
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_12,2022-11-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The signature of bpf_get_kern_btf_id() function looks like
  void *bpf_get_kern_btf_id(obj, expected_btf_id)
The obj has a pointer type. The expected_btf_id is 0 or
a btf id to be returned by the kfunc. The function
currently supports two kinds of obj:
  - obj: ptr_to_ctx, expected_btf_id: 0
    return the expected kernel ctx btf id
  - obj: ptr to char/unsigned char, expected_btf_id: a struct btf id
    return expected_btf_id
The second case looks like a type casting, e.g., in kernel we have
  #define skb_shinfo(SKB) ((struct skb_shared_info *)(skb_end_pointer(SKB)))
bpf program can get a skb_shared_info btf id ptr with bpf_get_kern_btf_id()
kfunc.

The current prototype is incomplete in the following areas:
  - ptr to char/unsigned char is not supported. In btf_struct_walk(),
    for a pointer not pointing to a struct, a WALK_SCALAR is returned.
    this needs to be improved to recognize walking ptr to non-struct.
  - the current implementation didn't validate non-zero expected_btf_id
    parameter has to be a struct. This can be added easily later.
  - The forced type casting case may not be reliable, so the resulted
    ptr and later walked ptr cannot be passed to helper/kfunc's.
    We need to resolve this some how. David Vernet has some work ([1])
    in this area and it is not finalized yet.

  [1] https://lore.kernel.org/bpf/20221020222416.3415511-1-void@manifault.c=
om/

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h   |  2 ++
 kernel/bpf/btf.c      | 67 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/bpf/helpers.c  |  5 ++++
 kernel/bpf/verifier.c |  8 +++++-
 4 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 798aec816970..d6a1c463b87e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2087,6 +2087,7 @@ struct bpf_kfunc_arg_meta {
 	bool r0_rdonly;
 	int ref_obj_id;
 	u32 flags;
+	u32 expected_ret_btf_id;
 };
=20
 struct bpf_reg_state;
@@ -2113,6 +2114,7 @@ bool bpf_prog_has_kfunc_call(const struct bpf_prog *p=
rog);
 const struct btf_func_model *
 bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 			 const struct bpf_insn *insn);
+void *bpf_get_kern_btf_id(void *, u32 expected_btf_id);
 struct bpf_core_ctx {
 	struct bpf_verifier_log *log;
 	const struct btf *btf;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 84f09235857c..b0a2555c8ca3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6309,6 +6309,9 @@ static bool btf_is_kfunc_arg_mem_size(const struct bt=
f *btf,
 	return true;
 }
=20
+BTF_ID_LIST_SINGLE(bpf_get_kern_btf_id_id, func, bpf_get_kern_btf_id)
+
+
 static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				    const struct btf *btf, u32 func_id,
 				    struct bpf_reg_state *regs,
@@ -6318,7 +6321,7 @@ static int btf_check_func_arg_match(struct bpf_verifi=
er_env *env,
 {
 	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
 	bool rel =3D false, kptr_get =3D false, trusted_args =3D false;
-	bool sleepable =3D false;
+	bool sleepable =3D false, get_btf_id_kfunc =3D false;
 	struct bpf_verifier_log *log =3D &env->log;
 	u32 i, nargs, ref_id, ref_obj_id =3D 0;
 	bool is_kfunc =3D btf_is_kernel(btf);
@@ -6357,6 +6360,67 @@ static int btf_check_func_arg_match(struct bpf_verif=
ier_env *env,
 		kptr_get =3D kfunc_meta->flags & KF_KPTR_GET;
 		trusted_args =3D kfunc_meta->flags & KF_TRUSTED_ARGS;
 		sleepable =3D kfunc_meta->flags & KF_SLEEPABLE;
+		get_btf_id_kfunc =3D func_id =3D=3D *bpf_get_kern_btf_id_id;
+	}
+
+	/* special processing for bpf_get_btf_id kfunc.
+	 * arg1:
+	 *   must be a ptr_to_ctx or ptr_to_u8/s8.
+	 * arg2:
+	 *   must be a constant, if non-zero representing an user specified expec=
ted
+	 *   ret_btf_id.
+	 * If ptr_to_ctx, arg2 must be 0 or a value equals to corresponding kctx =
btf_id
+	 * and the ret ptr can be passed to a helper/kfunc. Otherwise, arg2 must =
be a
+	 * valid struct type btf_id, and the ret ptr cannot be passed to a helper=
/kfunc.
+	 */
+	if (get_btf_id_kfunc) {
+		struct bpf_reg_state *reg =3D &regs[1];
+		int kctx_btf_id =3D 0;
+		s64 val;
+
+		if (nargs !=3D 2) {
+			bpf_log(log, "Incorrect number of arguments %s, actual %d expect 2\n",
+				func_name, nargs);
+			return -EINVAL;
+		}
+
+		/* arg1 */
+		if (reg->type =3D=3D PTR_TO_CTX) {
+			enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
+			const struct btf_type *conv_struct;
+			const struct btf_member *ctx_type;
+
+			conv_struct =3D bpf_ctx_convert.t;
+			ctx_type =3D btf_type_member(conv_struct) + bpf_ctx_convert_map[prog_ty=
pe] * 2;
+			ctx_type++;
+
+			/* find the kctx type */
+			kctx_btf_id =3D ctx_type->type;
+		} else if (reg->type !=3D SCALAR_VALUE) {
+			/* FIXME: we actually expects a pointer to char/unsigned_char */
+			bpf_log(log, "Incorrect type %x\n", reg->type);
+			return -EINVAL;
+		}
+
+		reg =3D &regs[2];
+		if (!tnum_is_const(reg->var_off)) {
+			bpf_log(log, "arg 2 is not constant\n");
+			return -EINVAL;
+		}
+
+		val =3D reg->var_off.value;
+		if (kctx_btf_id =3D=3D 0) {
+			/* FIXME: ensure val is a btf_id pointing to a struct */
+			kctx_btf_id =3D val;
+		} else {
+			if (val !=3D 0 && val !=3D kctx_btf_id) {
+				bpf_log(log, "Incorrect expected_btf_id %lld, expect 0 or %d\n", val, =
kctx_btf_id);
+				return -EINVAL;
+			}
+		}
+
+		kfunc_meta->expected_ret_btf_id =3D kctx_btf_id;
+		goto check;
 	}
=20
 	/* check that BTF function arguments match actual types that the
@@ -6639,6 +6703,7 @@ static int btf_check_func_arg_match(struct bpf_verifi=
er_env *env,
 		return -EINVAL;
 	}
=20
+check:
 	if (sleepable && !env->prog->aux->sleepable) {
 		bpf_log(log, "kernel function %s is sleepable but the program is not\n",
 			func_name);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2f11e22eefba..f8995947a790 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1717,7 +1717,12 @@ static const struct btf_kfunc_id_set tracing_kfunc_s=
et =3D {
 	.set   =3D &tracing_btf_ids,
 };
=20
+void *bpf_get_kern_btf_id(void *obj, u32 expected_btf_id) {
+	return obj;
+}
+
 BTF_SET8_START(generic_btf_ids)
+BTF_ID_FLAGS(func, bpf_get_kern_btf_id)
 BTF_SET8_END(generic_btf_ids)
=20
 static const struct btf_kfunc_id_set generic_kfunc_set =3D {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 07c0259dfc1a..cf284af382a3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7868,7 +7868,13 @@ static int check_kfunc_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
 	} else if (btf_type_is_ptr(t)) {
 		ptr_type =3D btf_type_skip_modifiers(desc_btf, t->type,
 						   &ptr_type_id);
-		if (!btf_type_is_struct(ptr_type)) {
+		if (meta.expected_ret_btf_id) {
+			mark_reg_known_zero(env, regs, BPF_REG_0);
+			regs[BPF_REG_0].btf =3D desc_btf;
+			regs[BPF_REG_0].type =3D PTR_TO_BTF_ID;
+			regs[BPF_REG_0].btf_id =3D meta.expected_ret_btf_id;
+
+		} else if (!btf_type_is_struct(ptr_type)) {
 			if (!meta.r0_size) {
 				ptr_type_name =3D btf_name_by_offset(desc_btf,
 								   ptr_type->name_off);
--=20
2.30.2

