Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C7051EB45
	for <lists+bpf@lfdr.de>; Sun,  8 May 2022 05:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiEHDZh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 7 May 2022 23:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiEHDZg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 7 May 2022 23:25:36 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96624E0F7
        for <bpf@vger.kernel.org>; Sat,  7 May 2022 20:21:46 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2481dkNp010790
        for <bpf@vger.kernel.org>; Sat, 7 May 2022 20:21:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=pS5uOX3EjUlQOnIelqG6ZsagcR+KgkP3W3D1EEXKceQ=;
 b=LERMa249gKimMfZWk8yjt95Z3eQxx4Lf7AjtXXdMvrAe+OCfUIgGRgoZgEo0s/AbFwWD
 2YpmrgUkT6yJfECtKn9s7KMWx00lNPnGzAMmYriswqQ9R+IoxOTLmL2fkOqTrSXnEjIv
 m28kpgArowQiDxBgOmoYckJZFiewPpXFzCk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fwpksahk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 07 May 2022 20:21:45 -0700
Received: from twshared24024.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 7 May 2022 20:21:44 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id F34BC3170388; Sat,  7 May 2022 20:21:34 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v7 3/5] bpf, x86: Attach a cookie to fentry/fexit/fmod_ret/lsm.
Date:   Sat, 7 May 2022 20:21:15 -0700
Message-ID: <20220508032117.2783209-4-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220508032117.2783209-1-kuifeng@fb.com>
References: <20220508032117.2783209-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: F1978M5q3xvWyZV5_C7-dMbXNnkZKCA1
X-Proofpoint-ORIG-GUID: F1978M5q3xvWyZV5_C7-dMbXNnkZKCA1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-08_01,2022-05-06_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
---
 arch/x86/net/bpf_jit_comp.c    | 12 ++++++++++--
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  9 +++++++++
 kernel/bpf/bpf_lsm.c           | 17 +++++++++++++++++
 kernel/bpf/syscall.c           | 12 ++++++++----
 kernel/bpf/trampoline.c        |  7 +++++--
 kernel/trace/bpf_trace.c       | 17 +++++++++++++++++
 tools/include/uapi/linux/bpf.h |  9 +++++++++
 8 files changed, 76 insertions(+), 8 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index bf4576a6938c..52a5eba2d5e8 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1764,13 +1764,21 @@ static int invoke_bpf_prog(const struct btf_func_=
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
+
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
index 29c3188195a6..13d80a4aa45b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1109,6 +1109,7 @@ struct bpf_tracing_link {
 	enum bpf_attach_type attach_type;
 	struct bpf_trampoline *trampoline;
 	struct bpf_prog *tgt_prog;
+	u64 cookie;
 };
=20
 struct bpf_link_primer {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ff9af73859ca..a70e1fd3b3a1 100644
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
index 5ed9a15daaee..dd0f4d51bcf6 100644
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
+	link->cookie =3D bpf_cookie;
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
index ff9af73859ca..a70e1fd3b3a1 100644
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

