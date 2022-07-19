Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FFF57A6DB
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 20:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiGSS7K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 14:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237815AbiGSS7C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 14:59:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D483AB3E
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 11:59:01 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26JI4xN2010284
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 11:59:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=iyJcgX8GWqiMPq0wCx/FN7nedyFJIa1k0vmgHgO2kYQ=;
 b=T0yOgCiPUNq4HjfmmVFfv7DbIe1uAR7lEYv4HnMMXdMNpJcN5fdYWDH6nWfEcGLSwmh+
 ZVo4vFL/yiGdeAWBw/sbBKq2FvLiH9MuNs3U2AnDB0RoxTLBJH1mM2KKzXCMmt4hOGjp
 L7N+tML1b3nBQcN8eumfFld/KWe8eO4Pwaw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3he0ry8sr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 11:59:01 -0700
Received: from twshared30313.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 19 Jul 2022 11:58:59 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id AF3C8A8D8B21; Tue, 19 Jul 2022 11:58:54 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next] bpf: Cleanup check_refcount_ok
Date:   Tue, 19 Jul 2022 11:58:53 -0700
Message-ID: <20220719185853.1650806-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -Cg7mF2me-0C8Nf76GOBYOt7N1QIoTnw
X-Proofpoint-ORIG-GUID: -Cg7mF2me-0C8Nf76GOBYOt7N1QIoTnw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_06,2022-07-19_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Discussion around a recently-submitted patch provided historical
context for check_refcount_ok [0]. Specifically, the function and its
helpers - may_be_acquire_function and arg_type_may_be_refcounted -
predate the OBJ_RELEASE type flag and the addition of many more helpers
with acquire/release semantics.

The purpose of check_refcount_ok is to ensure:
  1) Helper doesn't have multiple uses of return reg's ref_obj_id
  2) Helper with release semantics only has one arg needing to be
  released, since that's tracked using meta->ref_obj_id

With current verifier, it's safe to remove check_refcount_ok and its
helpers. Since addition of OBJ_RELEASE type flag, case 2) has been
handled by the arg_type_is_release check in check_func_arg. To ensure
case 1) won't result in verifier silently prioritizing one use of
ref_obj_id, this patch adds a helper_multiple_ref_obj_use check which
fails loudly if a helper passes > 1 test for use of ref_obj_id.

  [0]: lore.kernel.org/bpf/20220713234529.4154673-1-davemarchevsky@fb.com

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
No extant helpers fail the helper_multiple_ref_obj_use check (as
expected). I validated this by adding BPF_FUNC_dynptr_data to
is_acquire_function check and observing that dynptr selftests failed
with expected error, then doing the same for is_ptr_cast_function.

 kernel/bpf/verifier.c | 72 +++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 44 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c59c3df0fea6..b3e057a9384d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -467,25 +467,11 @@ static bool type_is_rdonly_mem(u32 type)
 	return type & MEM_RDONLY;
 }
=20
-static bool arg_type_may_be_refcounted(enum bpf_arg_type type)
-{
-	return type =3D=3D ARG_PTR_TO_SOCK_COMMON;
-}
-
 static bool type_may_be_null(u32 type)
 {
 	return type & PTR_MAYBE_NULL;
 }
=20
-static bool may_be_acquire_function(enum bpf_func_id func_id)
-{
-	return func_id =3D=3D BPF_FUNC_sk_lookup_tcp ||
-		func_id =3D=3D BPF_FUNC_sk_lookup_udp ||
-		func_id =3D=3D BPF_FUNC_skc_lookup_tcp ||
-		func_id =3D=3D BPF_FUNC_map_lookup_elem ||
-	        func_id =3D=3D BPF_FUNC_ringbuf_reserve;
-}
-
 static bool is_acquire_function(enum bpf_func_id func_id,
 				const struct bpf_map *map)
 {
@@ -518,6 +504,26 @@ static bool is_ptr_cast_function(enum bpf_func_id fu=
nc_id)
 		func_id =3D=3D BPF_FUNC_skc_to_tcp_request_sock;
 }
=20
+static bool is_dynptr_acquire_function(enum bpf_func_id func_id)
+{
+	return func_id =3D=3D BPF_FUNC_dynptr_data;
+}
+
+static bool helper_multiple_ref_obj_use(enum bpf_func_id func_id,
+					const struct bpf_map *map)
+{
+	int ref_obj_uses =3D 0;
+
+	if (is_ptr_cast_function(func_id))
+		ref_obj_uses++;
+	if (is_acquire_function(func_id, map))
+		ref_obj_uses++;
+	if (is_dynptr_acquire_function(func_id))
+		ref_obj_uses++;
+
+	return ref_obj_uses > 1;
+}
+
 static bool is_cmpxchg_insn(const struct bpf_insn *insn)
 {
 	return BPF_CLASS(insn->code) =3D=3D BPF_STX &&
@@ -6453,33 +6459,6 @@ static bool check_arg_pair_ok(const struct bpf_fun=
c_proto *fn)
 	return true;
 }
=20
-static bool check_refcount_ok(const struct bpf_func_proto *fn, int func_=
id)
-{
-	int count =3D 0;
-
-	if (arg_type_may_be_refcounted(fn->arg1_type))
-		count++;
-	if (arg_type_may_be_refcounted(fn->arg2_type))
-		count++;
-	if (arg_type_may_be_refcounted(fn->arg3_type))
-		count++;
-	if (arg_type_may_be_refcounted(fn->arg4_type))
-		count++;
-	if (arg_type_may_be_refcounted(fn->arg5_type))
-		count++;
-
-	/* A reference acquiring function cannot acquire
-	 * another refcounted ptr.
-	 */
-	if (may_be_acquire_function(func_id) && count)
-		return false;
-
-	/* We only support one arg being unreferenced at the moment,
-	 * which is sufficient for the helper functions we have right now.
-	 */
-	return count <=3D 1;
-}
-
 static bool check_btf_id_ok(const struct bpf_func_proto *fn)
 {
 	int i;
@@ -6503,8 +6482,7 @@ static int check_func_proto(const struct bpf_func_p=
roto *fn, int func_id,
 {
 	return check_raw_mode_ok(fn) &&
 	       check_arg_pair_ok(fn) &&
-	       check_btf_id_ok(fn) &&
-	       check_refcount_ok(fn, func_id) ? 0 : -EINVAL;
+	       check_btf_id_ok(fn) ? 0 : -EINVAL;
 }
=20
 /* Packet data might have moved, any old PTR_TO_PACKET[_META,_END]
@@ -7457,6 +7435,12 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 	if (type_may_be_null(regs[BPF_REG_0].type))
 		regs[BPF_REG_0].id =3D ++env->id_gen;
=20
+	if (helper_multiple_ref_obj_use(func_id, meta.map_ptr)) {
+		verbose(env, "verifier internal error: func %s#%d sets ref_obj_id more=
 than once\n",
+			func_id_name(func_id), func_id);
+		return -EINVAL;
+	}
+
 	if (is_ptr_cast_function(func_id)) {
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id =3D meta.ref_obj_id;
@@ -7469,7 +7453,7 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
 		regs[BPF_REG_0].id =3D id;
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id =3D id;
-	} else if (func_id =3D=3D BPF_FUNC_dynptr_data) {
+	} else if (is_dynptr_acquire_function(func_id)) {
 		int dynptr_id =3D 0, i;
=20
 		/* Find the id of the dynptr we're acquiring a reference to */
--=20
2.30.2

