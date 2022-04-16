Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7454F503313
	for <lists+bpf@lfdr.de>; Sat, 16 Apr 2022 07:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiDPEdJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 16 Apr 2022 00:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiDPEdI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Apr 2022 00:33:08 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776A7F8952
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 21:30:38 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23FL4mIB032279
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 21:30:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=kVClICmPhRu4+zdqxpx7VE2gMIM07yuZ+bMvzcBRTsI=;
 b=TwxWo5uiU+utTL3OHVdLUwzKk/2JtCrf16LtH8nPXWp8+3ydanZkvwXNaJ2efFpm9uVp
 ed+XMgcKIQvA2nI0kk+GAFWRzOL3y+ryI1XiBPmI+GHasYbdEu9MOMsFUn9oJ3bgaPd1
 FFIPCR55vK3CpPyqwsjRkjXTnMh3a0M7YEE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fewgpq0m8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 21:30:37 -0700
Received: from twshared19572.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 21:30:36 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 19CDD252D7D8; Fri, 15 Apr 2022 21:30:26 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH dwarves v6 3/6] bpf, x86: Attach a cookie to fentry/fexit/fmod_ret.
Date:   Fri, 15 Apr 2022 21:29:37 -0700
Message-ID: <20220416042940.656344-4-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220416042940.656344-1-kuifeng@fb.com>
References: <20220416042940.656344-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JRGkNpB5RZdxBmk2x8GqFByCgwWfRydo
X-Proofpoint-GUID: JRGkNpB5RZdxBmk2x8GqFByCgwWfRydo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-16_01,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a bpf_cookie field to struct bpf_tracing_link to attach a cookie.
The cookie of a bpf_tracing_link is available by calling
bpf_get_attach_cookie when running the BPF program of the attached
link.

The value of a cookie will be set at bpf_tramp_run_ctx by the
trampoline of the link.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 12 ++++++++++--
 include/linux/bpf.h         |  1 +
 kernel/bpf/syscall.c        | 10 +++++++---
 kernel/trace/bpf_trace.c    | 17 +++++++++++++++++
 4 files changed, 35 insertions(+), 5 deletions(-)

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
index 1eae81df154e..45963972785b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1060,6 +1060,7 @@ struct bpf_tracing_link {
 	enum bpf_attach_type attach_type;
 	struct bpf_trampoline *trampoline;
 	struct bpf_prog *tgt_prog;
+	u64 cookie;
 };
=20
 struct bpf_link_primer {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 56e69a582b21..966f2d40ae55 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2697,7 +2697,8 @@ static const struct bpf_link_ops bpf_tracing_link_l=
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
@@ -2762,6 +2763,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog =
*prog,
 	bpf_link_init(&link->link.link, BPF_LINK_TYPE_TRACING,
 		      &bpf_tracing_link_lops, prog);
 	link->attach_type =3D prog->expected_attach_type;
+	link->cookie =3D bpf_cookie;
=20
 	mutex_lock(&prog->aux->dst_mutex);
=20
@@ -3058,7 +3060,7 @@ static int bpf_raw_tracepoint_open(const union bpf_=
attr *attr)
 			tp_name =3D prog->aux->attach_func_name;
 			break;
 		}
-		err =3D bpf_tracing_prog_attach(prog, 0, 0);
+		err =3D bpf_tracing_prog_attach(prog, 0, 0, 0);
 		if (err >=3D 0)
 			return err;
 		goto out_put_prog;
@@ -4250,7 +4252,9 @@ static int tracing_bpf_link_attach(const union bpf_=
attr *attr, bpfptr_t uattr,
 	else if (prog->type =3D=3D BPF_PROG_TYPE_EXT)
 		return bpf_tracing_prog_attach(prog,
 					       attr->link_create.target_fd,
-					       attr->link_create.target_btf_id);
+					       attr->link_create.target_btf_id,
+					       0);
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
--=20
2.30.2

