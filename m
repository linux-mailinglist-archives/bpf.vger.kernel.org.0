Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899A157E628
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 20:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbiGVSAD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 14:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235856AbiGVSAC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 14:00:02 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3645B071
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:00:01 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id F250EF52A4BC; Fri, 22 Jul 2022 10:59:46 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, jolsa@kernel.org, haoluo@google.com,
        andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v2 1/2] bpf: Fix ref_obj_id for dynptr data slices in verifier
Date:   Fri, 22 Jul 2022 10:58:06 -0700
Message-Id: <20220722175807.4038317-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,SPOOFED_FREEMAIL,SPOOF_GMAIL_MID,
        TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When a data slice is obtained from a dynptr (through the bpf_dynptr_data =
API),
the ref obj id of the dynptr must be found and then associated with the d=
ata
slice.

The ref obj id of the dynptr must be found *before* the caller saved regs=
 are
reset. Without this fix, the ref obj id tracking is not correct for
dynptrs that are at an offset from the frame pointer.

Please also note that the data slice's ref obj id must be assigned after =
the
ret types are parsed, since RET_PTR_TO_ALLOC_MEM-type return regs get
zero-marked.

Fixes: 34d4ef5775f776ec4b0d53a02d588bf3195cada6 ("bpf: Add dynptr data sl=
ices");
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 kernel/bpf/verifier.c | 62 ++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 33 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c59c3df0fea6..29987b2ea26f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5830,7 +5830,8 @@ static u32 stack_slot_get_id(struct bpf_verifier_en=
v *env, struct bpf_reg_state
=20
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
-			  const struct bpf_func_proto *fn)
+			  const struct bpf_func_proto *fn,
+			  int func_id)
 {
 	u32 regno =3D BPF_REG_1 + arg;
 	struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[regno];
@@ -6040,23 +6041,33 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
 			}
=20
 			meta->uninit_dynptr_regno =3D regno;
-		} else if (!is_dynptr_reg_valid_init(env, reg, arg_type)) {
-			const char *err_extra =3D "";
+		} else {
+			if (!is_dynptr_reg_valid_init(env, reg, arg_type)) {
+				const char *err_extra =3D "";
=20
-			switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
-			case DYNPTR_TYPE_LOCAL:
-				err_extra =3D "local ";
-				break;
-			case DYNPTR_TYPE_RINGBUF:
-				err_extra =3D "ringbuf ";
-				break;
-			default:
-				break;
-			}
+				switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
+				case DYNPTR_TYPE_LOCAL:
+					err_extra =3D "local ";
+					break;
+				case DYNPTR_TYPE_RINGBUF:
+					err_extra =3D "ringbuf ";
+					break;
+				default:
+					break;
+				}
=20
-			verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
-				err_extra, arg + 1);
-			return -EINVAL;
+				verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
+					err_extra, arg + 1);
+				return -EINVAL;
+			}
+			if (func_id =3D=3D BPF_FUNC_dynptr_data) {
+				if (meta->ref_obj_id) {
+					verbose(env, "verifier internal error: multiple refcounted args in =
BPF_FUNC_dynptr_data");
+					return -EFAULT;
+				}
+				/* Find the id of the dynptr we're tracking the reference of */
+				meta->ref_obj_id =3D stack_slot_get_id(env, reg);
+			}
 		}
 		break;
 	case ARG_CONST_ALLOC_SIZE_OR_ZERO:
@@ -7227,7 +7238,7 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
 	meta.func_id =3D func_id;
 	/* check args */
 	for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
-		err =3D check_func_arg(env, i, &meta, fn);
+		err =3D check_func_arg(env, i, &meta, fn, func_id);
 		if (err)
 			return err;
 	}
@@ -7457,7 +7468,7 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
 	if (type_may_be_null(regs[BPF_REG_0].type))
 		regs[BPF_REG_0].id =3D ++env->id_gen;
=20
-	if (is_ptr_cast_function(func_id)) {
+	if (is_ptr_cast_function(func_id) || func_id =3D=3D BPF_FUNC_dynptr_dat=
a) {
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id =3D meta.ref_obj_id;
 	} else if (is_acquire_function(func_id, meta.map_ptr)) {
@@ -7469,21 +7480,6 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 		regs[BPF_REG_0].id =3D id;
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id =3D id;
-	} else if (func_id =3D=3D BPF_FUNC_dynptr_data) {
-		int dynptr_id =3D 0, i;
-
-		/* Find the id of the dynptr we're acquiring a reference to */
-		for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
-			if (arg_type_is_dynptr(fn->arg_type[i])) {
-				if (dynptr_id) {
-					verbose(env, "verifier internal error: multiple dynptr args in func=
\n");
-					return -EFAULT;
-				}
-				dynptr_id =3D stack_slot_get_id(env, &regs[BPF_REG_1 + i]);
-			}
-		}
-		/* For release_reference() */
-		regs[BPF_REG_0].ref_obj_id =3D dynptr_id;
 	}
=20
 	do_refine_retval_range(regs, fn->ret_type, func_id, &meta);
--=20
2.30.2

