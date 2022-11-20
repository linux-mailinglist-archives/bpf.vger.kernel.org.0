Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471CB631619
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 20:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKTT5I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 14:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiKTT5C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 14:57:02 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546AF13D1F
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:56:58 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2AK7gUSP005656
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:56:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=mCkCwerHM440pWEv+HBQUhkQqSt2aaQX2dbeZJmY6Eg=;
 b=WYtHVf922P4+RCCqyHicNBJKkY8fyFOClUdckvmQcf8kxQHGe4MkdmGhGK1Dd1eurejm
 p0Wm1vY9DN3PdPdtK+di+m1fQazAbOCKkQVsFo9eLTU8Sdk6QV+I7pesEwkYvHYuzGjK
 OQ/vU5mLFADz5P4cma1J5Ywk3/41yHignro= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3kxuq08f2y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:56:57 -0800
Received: from twshared13940.35.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 11:56:55 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 67D1B12774494; Sun, 20 Nov 2022 11:54:37 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <kernel-team@fb.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 3/4] bpf: Add a kfunc for generic type cast
Date:   Sun, 20 Nov 2022 11:54:37 -0800
Message-ID: <20221120195437.3114585-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221120195421.3112414-1-yhs@fb.com>
References: <20221120195421.3112414-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ELt0__ekbcoDgjiJwJD5bi4fpTTi9GXG
X-Proofpoint-GUID: ELt0__ekbcoDgjiJwJD5bi4fpTTi9GXG
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

Implement bpf_rdonly_cast() which tries to cast the object
to a specified type. This tries to support use case like below:
  #define skb_shinfo(SKB) ((struct skb_shared_info *)(skb_end_pointer(SKB=
)))
where skb_end_pointer(SKB) is a 'unsigned char *' and needs to
be casted to 'struct skb_shared_info *'.

The signature of bpf_rdonly_cast() looks like
   void *bpf_rdonly_cast(void *obj, __u32 btf_id)
The function returns the same 'obj' but with PTR_TO_BTF_ID with
btf_id. The verifier will ensure btf_id being a struct type.

Since the supported type cast may not reflect what the 'obj'
represents, the returned btf_id is marked as PTR_UNTRUSTED, so
the return value and subsequent pointer chasing cannot be
used as helper/kfunc arguments.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/helpers.c  |  6 ++++++
 kernel/bpf/verifier.c | 26 ++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a4b9cfcecb00..89310c2ca03e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1886,6 +1886,11 @@ void *bpf_cast_to_kern_ctx(void *obj)
 	return obj;
 }
=20
+void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k)
+{
+	return obj__ign;
+}
+
 __diag_pop();
=20
 BTF_SET8_START(generic_btf_ids)
@@ -1915,6 +1920,7 @@ BTF_ID(func, bpf_task_release)
=20
 BTF_SET8_START(common_btf_ids)
 BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx)
+BTF_ID_FLAGS(func, bpf_rdonly_cast)
 BTF_SET8_END(common_btf_ids)
=20
 static const struct btf_kfunc_id_set common_kfunc_set =3D {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a035356ed5df..8e01a7eebf7f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8153,6 +8153,7 @@ enum special_kfunc_type {
 	KF_bpf_list_pop_front,
 	KF_bpf_list_pop_back,
 	KF_bpf_cast_to_kern_ctx,
+	KF_bpf_rdonly_cast,
 };
=20
 BTF_SET_START(special_kfunc_set)
@@ -8163,6 +8164,7 @@ BTF_ID(func, bpf_list_push_back)
 BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
 BTF_ID(func, bpf_cast_to_kern_ctx)
+BTF_ID(func, bpf_rdonly_cast)
 BTF_SET_END(special_kfunc_set)
=20
 BTF_ID_LIST(special_kfunc_list)
@@ -8173,6 +8175,7 @@ BTF_ID(func, bpf_list_push_back)
 BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
 BTF_ID(func, bpf_cast_to_kern_ctx)
+BTF_ID(func, bpf_rdonly_cast)
=20
 static enum kfunc_ptr_arg_type
 get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
@@ -8809,6 +8812,7 @@ static int check_kfunc_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
 	u32 i, nargs, func_id, ptr_type_id;
 	int err, insn_idx =3D *insn_idx_p;
 	const struct btf_param *args;
+	const struct btf_type *ret_t;
 	struct btf *desc_btf;
 	u32 *kfunc_flags;
=20
@@ -8888,7 +8892,6 @@ static int check_kfunc_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
=20
 		if (meta.btf =3D=3D btf_vmlinux && btf_id_set_contains(&special_kfunc_=
set, meta.func_id)) {
 			if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_obj_new_impl]) {
-				const struct btf_type *ret_t;
 				struct btf *ret_btf;
 				u32 ret_btf_id;
=20
@@ -8938,6 +8941,24 @@ static int check_kfunc_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
 				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | PTR_TRUSTED;
 				regs[BPF_REG_0].btf =3D desc_btf;
 				regs[BPF_REG_0].btf_id =3D meta.ret_btf_id;
+			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_rdonly_cast]=
) {
+				if (!capable(CAP_PERFMON)) {
+					verbose(env,
+						"kfunc bpf_rdonly_cast requires CAP_PERFMON capability\n");
+					return -EACCES;
+				}
+
+				ret_t =3D btf_type_by_id(desc_btf, meta.arg_constant.value);
+				if (!ret_t || !btf_type_is_struct(ret_t)) {
+					verbose(env,
+						"kfunc bpf_rdonly_cast type ID argument must be of a struct\n");
+					return -EINVAL;
+				}
+
+				mark_reg_known_zero(env, regs, BPF_REG_0);
+				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | PTR_UNTRUSTED;
+				regs[BPF_REG_0].btf =3D desc_btf;
+				regs[BPF_REG_0].btf_id =3D meta.arg_constant.value;
 			} else {
 				verbose(env, "kernel function %s unhandled dynamic return type\n",
 					meta.func_name);
@@ -15191,7 +15212,8 @@ static int fixup_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 		insn_buf[1] =3D addr[1];
 		insn_buf[2] =3D *insn;
 		*cnt =3D 3;
-	} else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern_=
ctx]) {
+	} else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern_=
ctx] ||
+		   desc->func_id =3D=3D special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] =3D BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt =3D 1;
 	}
--=20
2.30.2

