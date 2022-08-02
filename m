Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619445883C0
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 23:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiHBVrx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 17:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiHBVrv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 17:47:51 -0400
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04893139B
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 14:47:49 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id DF621FDB972A; Tue,  2 Aug 2022 14:47:36 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1] bpf: verifier cleanups
Date:   Tue,  2 Aug 2022 14:46:38 -0700
Message-Id: <20220802214638.3643235-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,SPOOFED_FREEMAIL,SPOOF_GMAIL_MID,
        TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch cleans up a few things in the verifier:
  * type_is_pkt_pointer():
    Future work (skb + xdp dynptrs [0]) will be using the reg type
    PTR_TO_PACKET | PTR_MAYBE_NULL. type_is_pkt_pointer() should return
    true for any type whose base type is PTR_TO_PACKET, regardless of
    flags attached to it.

  * reg_type_may_be_refcounted_or_null():
    Get the base type at the start of the function to avoid
    having to recompute it / improve readability

  * check_func_proto(): remove unnecessary 'meta' arg

  * check_helper_call():
    Use switch casing on the base type of return value instead of
    nested ifs on the full type

There are no functional behavior changes.

[0] https://lore.kernel.org/bpf/20220726184706.954822-1-joannelkoong@gmai=
l.com/

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 kernel/bpf/verifier.c | 50 +++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 096fdac70165..843a966cd02b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -427,6 +427,7 @@ static void verbose_invalid_scalar(struct bpf_verifie=
r_env *env,
=20
 static bool type_is_pkt_pointer(enum bpf_reg_type type)
 {
+	type =3D base_type(type);
 	return type =3D=3D PTR_TO_PACKET ||
 	       type =3D=3D PTR_TO_PACKET_META;
 }
@@ -456,10 +457,9 @@ static bool reg_may_point_to_spin_lock(const struct =
bpf_reg_state *reg)
=20
 static bool reg_type_may_be_refcounted_or_null(enum bpf_reg_type type)
 {
-	return base_type(type) =3D=3D PTR_TO_SOCKET ||
-		base_type(type) =3D=3D PTR_TO_TCP_SOCK ||
-		base_type(type) =3D=3D PTR_TO_MEM ||
-		base_type(type) =3D=3D PTR_TO_BTF_ID;
+	type =3D base_type(type);
+	return type =3D=3D PTR_TO_SOCKET || type =3D=3D PTR_TO_TCP_SOCK ||
+		type =3D=3D PTR_TO_MEM || type =3D=3D PTR_TO_BTF_ID;
 }
=20
 static bool type_is_rdonly_mem(u32 type)
@@ -6498,8 +6498,7 @@ static bool check_btf_id_ok(const struct bpf_func_p=
roto *fn)
 	return true;
 }
=20
-static int check_func_proto(const struct bpf_func_proto *fn, int func_id=
,
-			    struct bpf_call_arg_meta *meta)
+static int check_func_proto(const struct bpf_func_proto *fn, int func_id=
)
 {
 	return check_raw_mode_ok(fn) &&
 	       check_arg_pair_ok(fn) &&
@@ -7218,7 +7217,7 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
 	memset(&meta, 0, sizeof(meta));
 	meta.pkt_access =3D fn->pkt_access;
=20
-	err =3D check_func_proto(fn, func_id, &meta);
+	err =3D check_func_proto(fn, func_id);
 	if (err) {
 		verbose(env, "kernel subsystem misconfigured func %s#%d\n",
 			func_id_name(func_id), func_id);
@@ -7359,13 +7358,17 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
=20
 	/* update return register (already marked as written above) */
 	ret_type =3D fn->ret_type;
-	ret_flag =3D type_flag(fn->ret_type);
-	if (ret_type =3D=3D RET_INTEGER) {
+	ret_flag =3D type_flag(ret_type);
+
+	switch (base_type(ret_type)) {
+	case RET_INTEGER:
 		/* sets type to SCALAR_VALUE */
 		mark_reg_unknown(env, regs, BPF_REG_0);
-	} else if (ret_type =3D=3D RET_VOID) {
+		break;
+	case RET_VOID:
 		regs[BPF_REG_0].type =3D NOT_INIT;
-	} else if (base_type(ret_type) =3D=3D RET_PTR_TO_MAP_VALUE) {
+		break;
+	case RET_PTR_TO_MAP_VALUE:
 		/* There is no offset yet applied, variable or fixed */
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		/* remember map_ptr, so that check_map_access()
@@ -7384,20 +7387,26 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
 		    map_value_has_spin_lock(meta.map_ptr)) {
 			regs[BPF_REG_0].id =3D ++env->id_gen;
 		}
-	} else if (base_type(ret_type) =3D=3D RET_PTR_TO_SOCKET) {
+		break;
+	case RET_PTR_TO_SOCKET:
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type =3D PTR_TO_SOCKET | ret_flag;
-	} else if (base_type(ret_type) =3D=3D RET_PTR_TO_SOCK_COMMON) {
+		break;
+	case RET_PTR_TO_SOCK_COMMON:
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type =3D PTR_TO_SOCK_COMMON | ret_flag;
-	} else if (base_type(ret_type) =3D=3D RET_PTR_TO_TCP_SOCK) {
+		break;
+	case RET_PTR_TO_TCP_SOCK:
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type =3D PTR_TO_TCP_SOCK | ret_flag;
-	} else if (base_type(ret_type) =3D=3D RET_PTR_TO_ALLOC_MEM) {
+		break;
+	case RET_PTR_TO_ALLOC_MEM:
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type =3D PTR_TO_MEM | ret_flag;
 		regs[BPF_REG_0].mem_size =3D meta.mem_size;
-	} else if (base_type(ret_type) =3D=3D RET_PTR_TO_MEM_OR_BTF_ID) {
+		break;
+	case RET_PTR_TO_MEM_OR_BTF_ID:
+	{
 		const struct btf_type *t;
=20
 		mark_reg_known_zero(env, regs, BPF_REG_0);
@@ -7429,7 +7438,10 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 			regs[BPF_REG_0].btf =3D meta.ret_btf;
 			regs[BPF_REG_0].btf_id =3D meta.ret_btf_id;
 		}
-	} else if (base_type(ret_type) =3D=3D RET_PTR_TO_BTF_ID) {
+		break;
+	}
+	case RET_PTR_TO_BTF_ID:
+	{
 		struct btf *ret_btf;
 		int ret_btf_id;
=20
@@ -7450,7 +7462,9 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
 		}
 		regs[BPF_REG_0].btf =3D ret_btf;
 		regs[BPF_REG_0].btf_id =3D ret_btf_id;
-	} else {
+		break;
+	}
+	default:
 		verbose(env, "unknown return type %u of func %s#%d\n",
 			base_type(ret_type), func_id_name(func_id), func_id);
 		return -EINVAL;
--=20
2.30.2

