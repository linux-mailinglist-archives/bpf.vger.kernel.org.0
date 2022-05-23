Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626F6531D5C
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 23:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiEWVHs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 17:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiEWVHr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 17:07:47 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFB279822
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 14:07:43 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id C6AF0CC6621F; Mon, 23 May 2022 14:07:31 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v6 2/6] bpf: Add bpf_dynptr_from_mem for local dynptrs
Date:   Mon, 23 May 2022 14:07:08 -0700
Message-Id: <20220523210712.3641569-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220523210712.3641569-1-joannelkoong@gmail.com>
References: <20220523210712.3641569-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds a new api bpf_dynptr_from_mem:

long bpf_dynptr_from_mem(void *data, u32 size, u64 flags, struct bpf_dynp=
tr *ptr);

which initializes a dynptr to point to a bpf program's local memory. For =
now
only local memory that is of reg type PTR_TO_MAP_VALUE is supported.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/uapi/linux/bpf.h       | 12 +++++++
 kernel/bpf/helpers.c           | 65 ++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c          |  6 ++++
 tools/include/uapi/linux/bpf.h | 12 +++++++
 4 files changed, 95 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 610944cb3389..9be3644457dd 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5178,6 +5178,17 @@ union bpf_attr {
  *		Dynamically cast a *sk* pointer to a *mptcp_sock* pointer.
  *	Return
  *		*sk* if casting is valid, or **NULL** otherwise.
+ *
+ * long bpf_dynptr_from_mem(void *data, u32 size, u64 flags, struct bpf_=
dynptr *ptr)
+ *	Description
+ *		Get a dynptr to local memory *data*.
+ *
+ *		*data* must be a ptr to a map value.
+ *		The maximum *size* supported is DYNPTR_MAX_SIZE.
+ *		*flags* is currently unused.
+ *	Return
+ *		0 on success, -E2BIG if the size exceeds DYNPTR_MAX_SIZE,
+ *		-EINVAL if flags is not 0.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5377,6 +5388,7 @@ union bpf_attr {
 	FN(kptr_xchg),			\
 	FN(map_lookup_percpu_elem),     \
 	FN(skc_to_mptcp_sock),		\
+	FN(dynptr_from_mem),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bad96131a510..d3e935c2e25e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1412,6 +1412,69 @@ const struct bpf_func_proto bpf_kptr_xchg_proto =3D=
 {
 	.arg2_btf_id  =3D BPF_PTR_POISON,
 };
=20
+/* Since the upper 8 bits of dynptr->size is reserved, the
+ * maximum supported size is 2^24 - 1.
+ */
+#define DYNPTR_MAX_SIZE	((1UL << 24) - 1)
+#define DYNPTR_TYPE_SHIFT	28
+
+static void bpf_dynptr_set_type(struct bpf_dynptr_kern *ptr, enum bpf_dy=
nptr_type type)
+{
+	ptr->size |=3D type << DYNPTR_TYPE_SHIFT;
+}
+
+static int bpf_dynptr_check_size(u32 size)
+{
+	return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
+}
+
+static void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
+			    enum bpf_dynptr_type type, u32 offset, u32 size)
+{
+	ptr->data =3D data;
+	ptr->offset =3D offset;
+	ptr->size =3D size;
+	bpf_dynptr_set_type(ptr, type);
+}
+
+static void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
+{
+	memset(ptr, 0, sizeof(*ptr));
+}
+
+BPF_CALL_4(bpf_dynptr_from_mem, void *, data, u32, size, u64, flags, str=
uct bpf_dynptr_kern *, ptr)
+{
+	int err;
+
+	err =3D bpf_dynptr_check_size(size);
+	if (err)
+		goto error;
+
+	/* flags is currently unsupported */
+	if (flags) {
+		err =3D -EINVAL;
+		goto error;
+	}
+
+	bpf_dynptr_init(ptr, data, BPF_DYNPTR_TYPE_LOCAL, 0, size);
+
+	return 0;
+
+error:
+	bpf_dynptr_set_null(ptr);
+	return err;
+}
+
+const struct bpf_func_proto bpf_dynptr_from_mem_proto =3D {
+	.func		=3D bpf_dynptr_from_mem,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg2_type	=3D ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	=3D ARG_ANYTHING,
+	.arg4_type	=3D ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
@@ -1466,6 +1529,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_loop_proto;
 	case BPF_FUNC_strncmp:
 		return &bpf_strncmp_proto;
+	case BPF_FUNC_dynptr_from_mem:
+		return &bpf_dynptr_from_mem_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 68bf16cda415..9825a776de59 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7204,6 +7204,12 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 		err =3D __check_func_call(env, insn, insn_idx_p, meta.subprogno,
 					set_loop_callback_state);
 		break;
+	case BPF_FUNC_dynptr_from_mem:
+		if (regs[1].type !=3D PTR_TO_MAP_VALUE) {
+			verbose(env, "Unsupported reg type %s for bpf_dynptr_from_mem data\n"=
,
+				reg_type_str(env, regs[1].type));
+			return -EACCES;
+		}
 	}
=20
 	if (err)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 610944cb3389..9be3644457dd 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5178,6 +5178,17 @@ union bpf_attr {
  *		Dynamically cast a *sk* pointer to a *mptcp_sock* pointer.
  *	Return
  *		*sk* if casting is valid, or **NULL** otherwise.
+ *
+ * long bpf_dynptr_from_mem(void *data, u32 size, u64 flags, struct bpf_=
dynptr *ptr)
+ *	Description
+ *		Get a dynptr to local memory *data*.
+ *
+ *		*data* must be a ptr to a map value.
+ *		The maximum *size* supported is DYNPTR_MAX_SIZE.
+ *		*flags* is currently unused.
+ *	Return
+ *		0 on success, -E2BIG if the size exceeds DYNPTR_MAX_SIZE,
+ *		-EINVAL if flags is not 0.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5377,6 +5388,7 @@ union bpf_attr {
 	FN(kptr_xchg),			\
 	FN(map_lookup_percpu_elem),     \
 	FN(skc_to_mptcp_sock),		\
+	FN(dynptr_from_mem),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

