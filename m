Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07CA58DD7E
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 19:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiHIRwo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 13:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244985AbiHIRwm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 13:52:42 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3391A20F40
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 10:52:42 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 4D743102FBCDC; Tue,  9 Aug 2022 10:52:28 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, void@manifault.com, andrii@kernel.org,
        daniel@iogearbox.net, ast@kernel.org,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v3 1/2] bpf: Fix ref_obj_id for dynptr data slices in verifier
Date:   Tue,  9 Aug 2022 10:52:07 -0700
Message-Id: <20220809175208.2224443-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,SPOOFED_FREEMAIL,SPOOF_GMAIL_MID,
        TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
 kernel/bpf/verifier.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 843a966cd02b..671786a56bb6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7342,6 +7342,23 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 			}
 		}
 		break;
+	case BPF_FUNC_dynptr_data:
+		for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
+			if (arg_type_is_dynptr(fn->arg_type[i])) {
+				if (meta.ref_obj_id) {
+					verbose(env, "verifier internal error: meta.ref_obj_id already set\=
n");
+					return -EFAULT;
+				}
+				/* Find the id of the dynptr we're tracking the reference of */
+				meta.ref_obj_id =3D stack_slot_get_id(env, &regs[BPF_REG_1 + i]);
+				break;
+			}
+		}
+		if (i =3D=3D MAX_BPF_FUNC_REG_ARGS) {
+			verbose(env, "verifier internal error: no dynptr in bpf_dynptr_data()=
\n");
+			return -EFAULT;
+		}
+		break;
 	}
=20
 	if (err)
@@ -7473,7 +7490,7 @@ static int check_helper_call(struct bpf_verifier_en=
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
@@ -7485,21 +7502,6 @@ static int check_helper_call(struct bpf_verifier_e=
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

