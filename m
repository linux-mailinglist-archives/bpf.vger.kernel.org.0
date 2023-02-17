Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF64D69A332
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 01:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjBQA4C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 19:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjBQA4A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 19:56:00 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28215193FB
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 16:55:59 -0800 (PST)
Received: by devvm15675.prn0.facebook.com (Postfix, from userid 115148)
        id 9E14E6A86322; Thu, 16 Feb 2023 16:55:46 -0800 (PST)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     martin.lau@kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v1 bpf-next] bpf: Tidy up verifier checking
Date:   Thu, 16 Feb 2023 16:54:51 -0800
Message-Id: <20230217005451.2438147-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,HELO_MISC_IP,NML_ADSP_CUSTOM_MED,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_SOFTFAIL,SPOOFED_FREEMAIL,
        SPOOF_GMAIL_MID,TVD_RCVD_IP autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change refactors check_mem_access() to check against the base type o=
f
the register, and uses switch case checking instead of if / else if
checks. This change also uses the existing clear_called_saved_regs()
function for resetting caller saved regs in check_helper_call().

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 kernel/bpf/verifier.c | 67 +++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 272563a0b770..b40165be2943 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5317,7 +5317,8 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
 	/* for access checks, reg->off is just part of off */
 	off +=3D reg->off;
=20
-	if (reg->type =3D=3D PTR_TO_MAP_KEY) {
+	switch (base_type(reg->type)) {
+	case PTR_TO_MAP_KEY:
 		if (t =3D=3D BPF_WRITE) {
 			verbose(env, "write to change key R%d not allowed\n", regno);
 			return -EACCES;
@@ -5329,7 +5330,10 @@ static int check_mem_access(struct bpf_verifier_en=
v *env, int insn_idx, u32 regn
 			return err;
 		if (value_regno >=3D 0)
 			mark_reg_unknown(env, regs, value_regno);
-	} else if (reg->type =3D=3D PTR_TO_MAP_VALUE) {
+
+		break;
+	case PTR_TO_MAP_VALUE:
+	{
 		struct btf_field *kptr_field =3D NULL;
=20
 		if (t =3D=3D BPF_WRITE && value_regno >=3D 0 &&
@@ -5369,7 +5373,10 @@ static int check_mem_access(struct bpf_verifier_en=
v *env, int insn_idx, u32 regn
 				mark_reg_unknown(env, regs, value_regno);
 			}
 		}
-	} else if (base_type(reg->type) =3D=3D PTR_TO_MEM) {
+		break;
+	}
+	case PTR_TO_MEM:
+	{
 		bool rdonly_mem =3D type_is_rdonly_mem(reg->type);
=20
 		if (type_may_be_null(reg->type)) {
@@ -5394,7 +5401,10 @@ static int check_mem_access(struct bpf_verifier_en=
v *env, int insn_idx, u32 regn
 					      reg->mem_size, false);
 		if (!err && value_regno >=3D 0 && (t =3D=3D BPF_READ || rdonly_mem))
 			mark_reg_unknown(env, regs, value_regno);
-	} else if (reg->type =3D=3D PTR_TO_CTX) {
+		break;
+	}
+	case PTR_TO_CTX:
+	{
 		enum bpf_reg_type reg_type =3D SCALAR_VALUE;
 		struct btf *btf =3D NULL;
 		u32 btf_id =3D 0;
@@ -5438,8 +5448,9 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
 			}
 			regs[value_regno].type =3D reg_type;
 		}
-
-	} else if (reg->type =3D=3D PTR_TO_STACK) {
+		break;
+	}
+	case PTR_TO_STACK:
 		/* Basic bounds checks. */
 		err =3D check_stack_access_within_bounds(env, regno, off, size, ACCESS=
_DIRECT, t);
 		if (err)
@@ -5456,7 +5467,9 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
 		else
 			err =3D check_stack_write(env, regno, off, size,
 						value_regno, insn_idx);
-	} else if (reg_is_pkt_pointer(reg)) {
+		break;
+	case PTR_TO_PACKET:
+	case PTR_TO_PACKET_META:
 		if (t =3D=3D BPF_WRITE && !may_access_direct_pkt_data(env, NULL, t)) {
 			verbose(env, "cannot write into packet\n");
 			return -EACCES;
@@ -5470,7 +5483,8 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
 		err =3D check_packet_access(env, regno, off, size, false);
 		if (!err && t =3D=3D BPF_READ && value_regno >=3D 0)
 			mark_reg_unknown(env, regs, value_regno);
-	} else if (reg->type =3D=3D PTR_TO_FLOW_KEYS) {
+		break;
+	case PTR_TO_FLOW_KEYS:
 		if (t =3D=3D BPF_WRITE && value_regno >=3D 0 &&
 		    is_pointer_value(env, value_regno)) {
 			verbose(env, "R%d leaks addr into flow keys\n",
@@ -5481,7 +5495,11 @@ static int check_mem_access(struct bpf_verifier_en=
v *env, int insn_idx, u32 regn
 		err =3D check_flow_keys_access(env, off, size);
 		if (!err && t =3D=3D BPF_READ && value_regno >=3D 0)
 			mark_reg_unknown(env, regs, value_regno);
-	} else if (type_is_sk_pointer(reg->type)) {
+		break;
+	case PTR_TO_SOCKET:
+	case PTR_TO_SOCK_COMMON:
+	case PTR_TO_TCP_SOCK:
+	case PTR_TO_XDP_SOCK:
 		if (t =3D=3D BPF_WRITE) {
 			verbose(env, "R%d cannot write into %s\n",
 				regno, reg_type_str(env, reg->type));
@@ -5490,18 +5508,18 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, u32 regn
 		err =3D check_sock_access(env, insn_idx, regno, off, size, t);
 		if (!err && value_regno >=3D 0)
 			mark_reg_unknown(env, regs, value_regno);
-	} else if (reg->type =3D=3D PTR_TO_TP_BUFFER) {
+		break;
+	case PTR_TO_TP_BUFFER:
 		err =3D check_tp_buffer_access(env, reg, regno, off, size);
 		if (!err && t =3D=3D BPF_READ && value_regno >=3D 0)
 			mark_reg_unknown(env, regs, value_regno);
-	} else if (base_type(reg->type) =3D=3D PTR_TO_BTF_ID &&
-		   !type_may_be_null(reg->type)) {
-		err =3D check_ptr_to_btf_access(env, regs, regno, off, size, t,
-					      value_regno);
-	} else if (reg->type =3D=3D CONST_PTR_TO_MAP) {
+		break;
+	case CONST_PTR_TO_MAP:
 		err =3D check_ptr_to_map_access(env, regs, regno, off, size, t,
 					      value_regno);
-	} else if (base_type(reg->type) =3D=3D PTR_TO_BUF) {
+		break;
+	case PTR_TO_BUF:
+	{
 		bool rdonly_mem =3D type_is_rdonly_mem(reg->type);
 		u32 *max_access;
=20
@@ -5521,7 +5539,17 @@ static int check_mem_access(struct bpf_verifier_en=
v *env, int insn_idx, u32 regn
=20
 		if (!err && value_regno >=3D 0 && (rdonly_mem || t =3D=3D BPF_READ))
 			mark_reg_unknown(env, regs, value_regno);
-	} else {
+		break;
+	}
+	case PTR_TO_BTF_ID:
+		if (!type_may_be_null(reg->type)) {
+			err =3D check_ptr_to_btf_access(env, regs, regno, off, size, t,
+						      value_regno);
+			break;
+		} else {
+			fallthrough;
+		}
+	default:
 		verbose(env, "R%d invalid mem access '%s'\n", regno,
 			reg_type_str(env, reg->type));
 		return -EACCES;
@@ -8377,10 +8405,7 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 		return err;
=20
 	/* reset caller saved regs */
-	for (i =3D 0; i < CALLER_SAVED_REGS; i++) {
-		mark_reg_not_init(env, regs, caller_saved[i]);
-		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
-	}
+	clear_caller_saved_regs(env, regs);
=20
 	/* helper call returns 64-bit value. */
 	regs[BPF_REG_0].subreg_def =3D DEF_NOT_SUBREG;
--=20
2.30.2

