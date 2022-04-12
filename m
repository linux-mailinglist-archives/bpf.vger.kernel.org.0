Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB1B4FE662
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 18:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353145AbiDLQ66 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 12:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354551AbiDLQ65 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 12:58:57 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14C35F8D7
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 09:56:39 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23C9IAf3029423
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 09:56:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=kWWHDeisRQHbILd5E8hDuKEs5g5JuvEcpgbUpYjeSPk=;
 b=Hgxrvqpl+izI5oTvd+VZFnki78LHCi6fooLD+G2CFY4fEqPmSnVa+HXBHXV29MtLtM+M
 fLSF8oKvzeklVurlq6f3ygXZ1vUVAeiE7Fzduzj74p4OuvIaNV7TWSLmVvxuyHlY1VQo
 U+wFhxXypVbGVisPIExRlo5os+E1V7XkNdg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fd6p3tfvr-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 09:56:39 -0700
Received: from twshared39027.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 12 Apr 2022 09:56:38 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 5774F2309164; Tue, 12 Apr 2022 09:56:24 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v5 3/5] bpf, x86: Attach a cookie to fentry/fexit/fmod_ret.
Date:   Tue, 12 Apr 2022 09:55:53 -0700
Message-ID: <20220412165555.4146407-4-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220412165555.4146407-1-kuifeng@fb.com>
References: <20220412165555.4146407-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: uniYfUBlMdHDWnAlP4XNtmDhhDRHaUkV
X-Proofpoint-GUID: uniYfUBlMdHDWnAlP4XNtmDhhDRHaUkV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-12_06,2022-04-12_02,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a bpf_cookie field to struct bpf_tracing_link to attach a cookie
to a link of a trace hook.  A cookie of a bpf_tracing_link is
available by calling bpf_get_attach_cookie when running the BPF
program of the attached link.

The value of a cookie will be set at bpf_tramp_run_ctx by the
trampoline of the link.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 arch/x86/net/bpf_jit_comp.c    | 11 +++++++++--
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  8 ++++++++
 kernel/bpf/syscall.c           | 27 +++++++++++++++++++++++----
 kernel/trace/bpf_trace.c       | 17 +++++++++++++++++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 6 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 0f521be68f7b..18d02dcd810a 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1764,13 +1764,20 @@ static int invoke_bpf_prog(const struct btf_func_=
model *m, u8 **pprog,
 			   struct bpf_tramp_link *l, int stack_size,
 			   bool save_ret)
 {
+	u64 cookie =3D 0;
 	u8 *prog =3D *pprog;
 	u8 *jmp_insn;
 	int ctx_cookie_off =3D offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
 	struct bpf_prog *p =3D l->link.prog;
=20
-	/* mov rdi, 0 */
-	emit_mov_imm64(&prog, BPF_REG_1, 0, 0);
+	if (l->link.type =3D=3D BPF_LINK_TYPE_TRACING) {
+		struct bpf_tracing_link *tr_link =3D
+			container_of(l, struct bpf_tracing_link, link);
+		cookie =3D tr_link->cookie;
+	}
+
+	/* mov rdi, cookie */
+	emit_mov_imm64(&prog, BPF_REG_1, (long) cookie >> 32, (u32) (long) cook=
ie);
=20
 	/* Prepare struct bpf_tramp_run_ctx.
 	 *
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d87df049e6b1..49db9c065701 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1062,6 +1062,7 @@ struct bpf_tracing_link {
 	enum bpf_attach_type attach_type;
 	struct bpf_trampoline *trampoline;
 	struct bpf_prog *tgt_prog;
+	u64 cookie;
 };
=20
 struct bpf_link_primer {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a4f557338af7..5e901e6d17ea 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1436,6 +1436,7 @@ union bpf_attr {
 	struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
 		__u64 name;
 		__u32 prog_fd;
+		__u64 bpf_cookie;
 	} raw_tracepoint;
=20
 	struct { /* anonymous struct for BPF_BTF_LOAD */
@@ -1490,6 +1491,13 @@ union bpf_attr {
 				__aligned_u64	addrs;
 				__aligned_u64	cookies;
 			} kprobe_multi;
+			struct {
+				/* black box user-provided value passed through
+				 * to BPF program at the execution time and
+				 * accessible through bpf_get_attach_cookie() BPF helper
+				 */
+				__u64		bpf_cookie;
+			} tracing;
 		};
 	} link_create;
=20
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 56e69a582b21..53d4da5c76b5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2695,9 +2695,10 @@ static const struct bpf_link_ops bpf_tracing_link_=
lops =3D {
 	.fill_link_info =3D bpf_tracing_link_fill_link_info,
 };
=20
-static int bpf_tracing_prog_attach(struct bpf_prog *prog,
-				   int tgt_prog_fd,
-				   u32 btf_id)
+static int bpf_tracing_prog_attach_cookie(struct bpf_prog *prog,
+					  int tgt_prog_fd,
+					  u32 btf_id,
+					  u64 bpf_cookie)
 {
 	struct bpf_link_primer link_primer;
 	struct bpf_prog *tgt_prog =3D NULL;
@@ -2762,6 +2763,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog =
*prog,
 	bpf_link_init(&link->link.link, BPF_LINK_TYPE_TRACING,
 		      &bpf_tracing_link_lops, prog);
 	link->attach_type =3D prog->expected_attach_type;
+	link->cookie =3D bpf_cookie;
=20
 	mutex_lock(&prog->aux->dst_mutex);
=20
@@ -2871,6 +2873,13 @@ static int bpf_tracing_prog_attach(struct bpf_prog=
 *prog,
 	return err;
 }
=20
+static int bpf_tracing_prog_attach(struct bpf_prog *prog,
+				   int tgt_prog_fd,
+				   u32 btf_id)
+{
+	return bpf_tracing_prog_attach_cookie(prog, tgt_prog_fd, btf_id, 0);
+}
+
 struct bpf_raw_tp_link {
 	struct bpf_link link;
 	struct bpf_raw_event_map *btp;
@@ -3023,7 +3032,7 @@ static int bpf_perf_link_attach(const union bpf_att=
r *attr, struct bpf_prog *pro
 }
 #endif /* CONFIG_PERF_EVENTS */
=20
-#define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.prog_fd
+#define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.bpf_cookie
=20
 static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 {
@@ -3187,6 +3196,10 @@ attach_type_to_prog_type(enum bpf_attach_type atta=
ch_type)
 		return BPF_PROG_TYPE_SK_LOOKUP;
 	case BPF_XDP:
 		return BPF_PROG_TYPE_XDP;
+	case BPF_TRACE_FENTRY:
+	case BPF_TRACE_FEXIT:
+	case BPF_MODIFY_RETURN:
+		return BPF_PROG_TYPE_TRACING;
 	default:
 		return BPF_PROG_TYPE_UNSPEC;
 	}
@@ -4251,6 +4264,12 @@ static int tracing_bpf_link_attach(const union bpf=
_attr *attr, bpfptr_t uattr,
 		return bpf_tracing_prog_attach(prog,
 					       attr->link_create.target_fd,
 					       attr->link_create.target_btf_id);
+	else if (prog->type =3D=3D BPF_PROG_TYPE_TRACING)
+		return bpf_tracing_prog_attach_cookie(prog,
+						      0,
+						      0,
+						      attr->link_create.tracing.bpf_cookie);
+
 	return -EINVAL;
 }
=20
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b26f3da943de..c5713d5fba45 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1088,6 +1088,21 @@ static const struct bpf_func_proto bpf_get_attach_=
cookie_proto_pe =3D {
 	.arg1_type	=3D ARG_PTR_TO_CTX,
 };
=20
+BPF_CALL_1(bpf_get_attach_cookie_tracing, void *, ctx)
+{
+	struct bpf_trace_run_ctx *run_ctx;
+
+	run_ctx =3D container_of(current->bpf_ctx, struct bpf_trace_run_ctx, ru=
n_ctx);
+	return run_ctx->bpf_cookie;
+}
+
+static const struct bpf_func_proto bpf_get_attach_cookie_proto_tracing =3D=
 {
+	.func		=3D bpf_get_attach_cookie_tracing,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_CTX,
+};
+
 BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
 {
 #ifndef CONFIG_X86
@@ -1716,6 +1731,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, c=
onst struct bpf_prog *prog)
 		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ret_proto : NULL;
 	case BPF_FUNC_get_func_arg_cnt:
 		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_cnt_proto : N=
ULL;
+	case BPF_FUNC_get_attach_cookie:
+		return bpf_prog_has_trampoline(prog) ? &bpf_get_attach_cookie_proto_tr=
acing : NULL;
 	default:
 		fn =3D raw_tp_prog_func_proto(func_id, prog);
 		if (!fn && prog->expected_attach_type =3D=3D BPF_TRACE_ITER)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index a4f557338af7..a5ee57f09e04 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1490,6 +1490,13 @@ union bpf_attr {
 				__aligned_u64	addrs;
 				__aligned_u64	cookies;
 			} kprobe_multi;
+			struct {
+				/* black box user-provided value passed through
+				 * to BPF program at the execution time and
+				 * accessible through bpf_get_attach_cookie() BPF helper
+				 */
+				__u64		bpf_cookie;
+			} tracing;
 		};
 	} link_create;
=20
--=20
2.30.2

