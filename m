Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247DA4F8810
	for <lists+bpf@lfdr.de>; Thu,  7 Apr 2022 21:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiDGT2m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Apr 2022 15:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiDGT2g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 15:28:36 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA933286F5A
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 12:26:27 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 237IBBUf013988
        for <bpf@vger.kernel.org>; Thu, 7 Apr 2022 12:26:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=1rTbjcREWkItfaJXvnDq6PRV6naAgVQX0T6BqaCB1Dw=;
 b=ImF5dAQ49nqbU2vq4y3ILaVJQl+7g3J9rtGCHUtf5YJYkML8B1zggl1G1tn6WWXPIhLq
 bgs6yKJL2P70mAWxJyxhPdlfAnEmoXKEiKIvesCf3OuNK/M2sDXVQ34mvdxoISrGSnJ3
 yNMQLQeDP4V4MEldn47Jrf20X8ksjAGM9jo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f9nrnen30-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 07 Apr 2022 12:26:26 -0700
Received: from twshared5730.23.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 12:26:24 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 6FF63200EE85; Thu,  7 Apr 2022 12:26:18 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v3 3/5] bpf, x86: Attach a cookie to fentry/fexit/fmod_ret.
Date:   Thu, 7 Apr 2022 12:25:50 -0700
Message-ID: <20220407192552.2343076-4-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407192552.2343076-1-kuifeng@fb.com>
References: <20220407192552.2343076-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -rJn0efp5BWrNpp3ZNVT7ORI8u44-gyw
X-Proofpoint-ORIG-GUID: -rJn0efp5BWrNpp3ZNVT7ORI8u44-gyw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-07_04,2022-04-07_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index 61b72d537f5b..8d834f44efea 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1746,13 +1746,20 @@ static int invoke_bpf_prog(const struct btf_func_=
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
index 7b4896c86dcc..65a9b9c12a6c 100644
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
index 9e34da50440c..9ccc77d93e97 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1429,6 +1429,7 @@ union bpf_attr {
 	struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
 		__u64 name;
 		__u32 prog_fd;
+		__u64 bpf_cookie;
 	} raw_tracepoint;
=20
 	struct { /* anonymous struct for BPF_BTF_LOAD */
@@ -1476,6 +1477,13 @@ union bpf_attr {
 				 */
 				__u64		bpf_cookie;
 			} perf_event;
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
index 12a1c0ff6646..84b3fe2d65d3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2694,9 +2694,10 @@ static const struct bpf_link_ops bpf_tracing_link_=
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
@@ -2761,6 +2762,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog =
*prog,
 	bpf_link_init(&link->link.link, BPF_LINK_TYPE_TRACING,
 		      &bpf_tracing_link_lops, prog);
 	link->attach_type =3D prog->expected_attach_type;
+	link->cookie =3D bpf_cookie;
=20
 	mutex_lock(&prog->aux->dst_mutex);
=20
@@ -2870,6 +2872,13 @@ static int bpf_tracing_prog_attach(struct bpf_prog=
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
@@ -3017,7 +3026,7 @@ static int bpf_perf_link_attach(const union bpf_att=
r *attr, struct bpf_prog *pro
 }
 #endif /* CONFIG_PERF_EVENTS */
=20
-#define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.prog_fd
+#define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.bpf_cookie
=20
 static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 {
@@ -3181,6 +3190,10 @@ attach_type_to_prog_type(enum bpf_attach_type atta=
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
@@ -4245,6 +4258,12 @@ static int tracing_bpf_link_attach(const union bpf=
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
index a2024ba32a20..1558b0476b3a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1063,6 +1063,21 @@ static const struct bpf_func_proto bpf_get_attach_=
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
@@ -1687,6 +1702,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, c=
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
index 9e34da50440c..6c3e2f5a3474 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1476,6 +1476,13 @@ union bpf_attr {
 				 */
 				__u64		bpf_cookie;
 			} perf_event;
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

