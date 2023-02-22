Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C304069EEA9
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 07:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjBVGIx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 01:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjBVGIr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 01:08:47 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DC727488
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 22:08:40 -0800 (PST)
Received: by devvm20151.prn0.facebook.com (Postfix, from userid 115148)
        id 52CE7F67D13; Tue, 21 Feb 2023 22:08:25 -0800 (PST)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     martin.lau@kernel.org, andrii@kernel.org, ast@kernel.org,
        memxor@gmail.com, daniel@iogearbox.net, netdev@vger.kernel.org,
        kernel-team@fb.com, toke@kernel.org,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v11 bpf-next 05/10] bpf: Refactor verifier dynptr into get_dynptr_arg_reg
Date:   Tue, 21 Feb 2023 22:07:42 -0800
Message-Id: <20230222060747.2562549-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230222060747.2562549-1-joannelkoong@gmail.com>
References: <20230222060747.2562549-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,HELO_MISC_IP,NML_ADSP_CUSTOM_MED,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_SOFTFAIL,TVD_RCVD_IP autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit refactors the logic for determining which register in a
function is the dynptr into "get_dynptr_arg_reg". This will be used
in the future when the dynptr reg for BPF_FUNC_dynptr_write will need
to be obtained in order to support writes for skb dynptrs.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 kernel/bpf/verifier.c | 80 +++++++++++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 30 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index de99fa02b8d8..babc82e93ae6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6664,6 +6664,28 @@ int check_func_arg_reg_off(struct bpf_verifier_env=
 *env,
 	}
 }
=20
+static struct bpf_reg_state *get_dynptr_arg_reg(struct bpf_verifier_env =
*env,
+						const struct bpf_func_proto *fn,
+						struct bpf_reg_state *regs)
+{
+	struct bpf_reg_state *state =3D NULL;
+	int i;
+
+	for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++)
+		if (arg_type_is_dynptr(fn->arg_type[i])) {
+			if (state) {
+				verbose(env, "verifier internal error: multiple dynptr args\n");
+				return NULL;
+			}
+			state =3D &regs[BPF_REG_1 + i];
+		}
+
+	if (!state)
+		verbose(env, "verifier internal error: no dynptr arg found\n");
+
+	return state;
+}
+
 static int dynptr_id(struct bpf_verifier_env *env, struct bpf_reg_state =
*reg)
 {
 	struct bpf_func_state *state =3D func(env, reg);
@@ -8305,43 +8327,41 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
 		}
 		break;
 	case BPF_FUNC_dynptr_data:
-		for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
-			if (arg_type_is_dynptr(fn->arg_type[i])) {
-				struct bpf_reg_state *reg =3D &regs[BPF_REG_1 + i];
-				int id, ref_obj_id;
-
-				if (meta.dynptr_id) {
-					verbose(env, "verifier internal error: meta.dynptr_id already set\n=
");
-					return -EFAULT;
-				}
-
-				if (meta.ref_obj_id) {
-					verbose(env, "verifier internal error: meta.ref_obj_id already set\=
n");
-					return -EFAULT;
-				}
+	{
+		struct bpf_reg_state *reg;
+		int id, ref_obj_id;
=20
-				id =3D dynptr_id(env, reg);
-				if (id < 0) {
-					verbose(env, "verifier internal error: failed to obtain dynptr id\n=
");
-					return id;
-				}
+		reg =3D get_dynptr_arg_reg(env, fn, regs);
+		if (!reg)
+			return -EFAULT;
=20
-				ref_obj_id =3D dynptr_ref_obj_id(env, reg);
-				if (ref_obj_id < 0) {
-					verbose(env, "verifier internal error: failed to obtain dynptr ref_=
obj_id\n");
-					return ref_obj_id;
-				}
=20
-				meta.dynptr_id =3D id;
-				meta.ref_obj_id =3D ref_obj_id;
-				break;
-			}
+		if (meta.dynptr_id) {
+			verbose(env, "verifier internal error: meta.dynptr_id already set\n")=
;
+			return -EFAULT;
 		}
-		if (i =3D=3D MAX_BPF_FUNC_REG_ARGS) {
-			verbose(env, "verifier internal error: no dynptr in bpf_dynptr_data()=
\n");
+		if (meta.ref_obj_id) {
+			verbose(env, "verifier internal error: meta.ref_obj_id already set\n"=
);
 			return -EFAULT;
 		}
+
+		id =3D dynptr_id(env, reg);
+		if (id < 0) {
+			verbose(env, "verifier internal error: failed to obtain dynptr id\n")=
;
+			return id;
+		}
+
+		ref_obj_id =3D dynptr_ref_obj_id(env, reg);
+		if (ref_obj_id < 0) {
+			verbose(env, "verifier internal error: failed to obtain dynptr ref_ob=
j_id\n");
+			return ref_obj_id;
+		}
+
+		meta.dynptr_id =3D id;
+		meta.ref_obj_id =3D ref_obj_id;
+
 		break;
+	}
 	case BPF_FUNC_user_ringbuf_drain:
 		err =3D __check_func_call(env, insn, insn_idx_p, meta.subprogno,
 					set_user_ringbuf_callback_state);
--=20
2.30.2

