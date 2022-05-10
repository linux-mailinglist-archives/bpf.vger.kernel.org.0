Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F226522603
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 23:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbiEJVCU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 17:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiEJVCT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 17:02:19 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0FF269EF6
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 14:02:18 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AFM5AM002580
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 14:02:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=hds/l+EZne5Bx4C7SMfW/3q9vpOqEfefSjgmE92tPHU=;
 b=V75fvXsc51JVP39HilXsOODjCGJRNA71xBRRR0yZnAIPhIKxmuUeEnRkDfji5eJEkNLO
 nIu3p8h3jg6qU2YL0drRgaa2gXIu7SdNYYZKHPFJ56CYQ0FAjXyVR2FMMJIqJp7UhzS0
 zumZJaQnFsOyr40QQ4S8jYsrwvWq9Nj/GmI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fygdk6924-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 14:02:18 -0700
Received: from twshared19572.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 14:02:17 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 4178E32F2033; Tue, 10 May 2022 13:59:44 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v8 3/5] bpf, x86: Attach a cookie to fentry/fexit/fmod_ret/lsm.
Date:   Tue, 10 May 2022 13:59:21 -0700
Message-ID: <20220510205923.3206889-4-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220510205923.3206889-1-kuifeng@fb.com>
References: <20220510205923.3206889-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2ppIHwocV1ly9rrTmxMJR7QsdSNJsYDw
X-Proofpoint-GUID: 2ppIHwocV1ly9rrTmxMJR7QsdSNJsYDw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_07,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pass a cookie along with BPF_LINK_CREATE requests.

Add a bpf_cookie field to struct bpf_tracing_link to attach a cookie.
The cookie of a bpf_tracing_link is available by calling
bpf_get_attach_cookie when running the BPF program of the attached
link.

The value of a cookie will be set at bpf_tramp_run_ctx by the
trampoline of the link.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c    |  7 +++++--
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  9 +++++++++
 kernel/bpf/bpf_lsm.c           | 17 +++++++++++++++++
 kernel/bpf/syscall.c           | 12 ++++++++----
 kernel/bpf/trampoline.c        |  7 +++++--
 kernel/trace/bpf_trace.c       | 17 +++++++++++++++++
 tools/include/uapi/linux/bpf.h |  9 +++++++++
 8 files changed, 71 insertions(+), 8 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 1fbc5cf1c7a7..f94582c2875d 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1765,13 +1765,16 @@ static int invoke_bpf_prog(const struct btf_func_=
model *m, u8 **pprog,
 			   struct bpf_tramp_link *l, int stack_size,
 			   int run_ctx_off, bool save_ret)
 {
+	u64 cookie =3D 0;
 	u8 *prog =3D *pprog;
 	u8 *jmp_insn;
 	int ctx_cookie_off =3D offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
 	struct bpf_prog *p =3D l->link.prog;
=20
-	/* mov rdi, 0 */
-	emit_mov_imm64(&prog, BPF_REG_1, 0, 0);
+	cookie =3D l->cookie;
+
+	/* mov rdi, cookie */
+	emit_mov_imm64(&prog, BPF_REG_1, (long) cookie >> 32, (u32) (long) cook=
ie);
=20
 	/* Prepare struct bpf_tramp_run_ctx.
 	 *
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 256fb802e580..aba7ded56436 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1102,6 +1102,7 @@ struct bpf_link_ops {
 struct bpf_tramp_link {
 	struct bpf_link link;
 	struct hlist_node tramp_hlist;
+	u64 cookie;
 };
=20
 struct bpf_tracing_link {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3d032ea1b6a3..c04eff1a00b8 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1490,6 +1490,15 @@ union bpf_attr {
 				__aligned_u64	addrs;
 				__aligned_u64	cookies;
 			} kprobe_multi;
+			struct {
+				/* this is overliad with the target_btf_id above. */
+				__u32		target_btf_id;
+				/* black box user-provided value passed through
+				 * to BPF program at the execution time and
+				 * accessible through bpf_get_attach_cookie() BPF helper
+				 */
+				__u64		cookie;
+			} tracing;
 		};
 	} link_create;
=20
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 064eccba641d..c1351df9f7ee 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -117,6 +117,21 @@ static const struct bpf_func_proto bpf_ima_file_hash=
_proto =3D {
 	.allowed	=3D bpf_ima_inode_hash_allowed,
 };
=20
+BPF_CALL_1(bpf_get_attach_cookie, void *, ctx)
+{
+	struct bpf_trace_run_ctx *run_ctx;
+
+	run_ctx =3D container_of(current->bpf_ctx, struct bpf_trace_run_ctx, ru=
n_ctx);
+	return run_ctx->bpf_cookie;
+}
+
+static const struct bpf_func_proto bpf_get_attach_cookie_proto =3D {
+	.func		=3D bpf_get_attach_cookie,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_CTX,
+};
+
 static const struct bpf_func_proto *
 bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog=
)
 {
@@ -141,6 +156,8 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const st=
ruct bpf_prog *prog)
 		return prog->aux->sleepable ? &bpf_ima_inode_hash_proto : NULL;
 	case BPF_FUNC_ima_file_hash:
 		return prog->aux->sleepable ? &bpf_ima_file_hash_proto : NULL;
+	case BPF_FUNC_get_attach_cookie:
+		return bpf_prog_has_trampoline(prog) ? &bpf_get_attach_cookie_proto : =
NULL;
 	default:
 		return tracing_prog_func_proto(func_id, prog);
 	}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d48165fccf49..72e53489165d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2921,7 +2921,8 @@ static const struct bpf_link_ops bpf_tracing_link_l=
ops =3D {
=20
 static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 				   int tgt_prog_fd,
-				   u32 btf_id)
+				   u32 btf_id,
+				   u64 bpf_cookie)
 {
 	struct bpf_link_primer link_primer;
 	struct bpf_prog *tgt_prog =3D NULL;
@@ -2986,6 +2987,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog =
*prog,
 	bpf_link_init(&link->link.link, BPF_LINK_TYPE_TRACING,
 		      &bpf_tracing_link_lops, prog);
 	link->attach_type =3D prog->expected_attach_type;
+	link->link.cookie =3D bpf_cookie;
=20
 	mutex_lock(&prog->aux->dst_mutex);
=20
@@ -3271,7 +3273,7 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *=
prog,
 			tp_name =3D prog->aux->attach_func_name;
 			break;
 		}
-		return bpf_tracing_prog_attach(prog, 0, 0);
+		return bpf_tracing_prog_attach(prog, 0, 0, 0);
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
 		if (strncpy_from_user(buf, user_tp_name, sizeof(buf) - 1) < 0)
@@ -4524,7 +4526,8 @@ static int link_create(union bpf_attr *attr, bpfptr=
_t uattr)
 	case BPF_PROG_TYPE_EXT:
 		ret =3D bpf_tracing_prog_attach(prog,
 					      attr->link_create.target_fd,
-					      attr->link_create.target_btf_id);
+					      attr->link_create.target_btf_id,
+					      attr->link_create.tracing.cookie);
 		break;
 	case BPF_PROG_TYPE_LSM:
 	case BPF_PROG_TYPE_TRACING:
@@ -4539,7 +4542,8 @@ static int link_create(union bpf_attr *attr, bpfptr=
_t uattr)
 		else
 			ret =3D bpf_tracing_prog_attach(prog,
 						      attr->link_create.target_fd,
-						      attr->link_create.target_btf_id);
+						      attr->link_create.target_btf_id,
+						      attr->link_create.tracing.cookie);
 		break;
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_SK_LOOKUP:
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index baf1b65d523e..0e9b3aefc34a 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -30,9 +30,12 @@ static DEFINE_MUTEX(trampoline_mutex);
 bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 {
 	enum bpf_attach_type eatype =3D prog->expected_attach_type;
+	enum bpf_prog_type ptype =3D prog->type;
=20
-	return eatype =3D=3D BPF_TRACE_FENTRY || eatype =3D=3D BPF_TRACE_FEXIT =
||
-	       eatype =3D=3D BPF_MODIFY_RETURN;
+	return (ptype =3D=3D BPF_PROG_TYPE_TRACING &&
+		(eatype =3D=3D BPF_TRACE_FENTRY || eatype =3D=3D BPF_TRACE_FEXIT ||
+		 eatype =3D=3D BPF_MODIFY_RETURN)) ||
+		(ptype =3D=3D BPF_PROG_TYPE_LSM && eatype =3D=3D BPF_LSM_MAC);
 }
=20
 void *bpf_jit_alloc_exec_page(void)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f15b826f9899..6377ed23e17f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1091,6 +1091,21 @@ static const struct bpf_func_proto bpf_get_attach_=
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
@@ -1719,6 +1734,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, c=
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
index 3d032ea1b6a3..c04eff1a00b8 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1490,6 +1490,15 @@ union bpf_attr {
 				__aligned_u64	addrs;
 				__aligned_u64	cookies;
 			} kprobe_multi;
+			struct {
+				/* this is overliad with the target_btf_id above. */
+				__u32		target_btf_id;
+				/* black box user-provided value passed through
+				 * to BPF program at the execution time and
+				 * accessible through bpf_get_attach_cookie() BPF helper
+				 */
+				__u64		cookie;
+			} tracing;
 		};
 	} link_create;
=20
--=20
2.30.2

