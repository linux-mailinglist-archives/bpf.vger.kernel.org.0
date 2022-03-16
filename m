Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FF64DA70C
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 01:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352840AbiCPAqB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 20:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiCPAqA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 20:46:00 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9487F4EA37
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 17:44:46 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22FNkbs1019721
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 17:44:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=HnlxMMm7i7o54M6+vV+VyJdHv6EzHwj25Gw1NHNIFIM=;
 b=Ck6CWof2A0k4YNKZE7p7kvuUfJxJFMl55s6OLyAfxOvu/cznteQ8kTSP2vnIaEHG6TJi
 cnG91XDhVagfUcgVVoFineHFa5ebPEX1a8tS4bjOriQfkAgFFPpl+oOYa0FaLQipehPt
 BCBUdyyN+fgEPkuLsV24thQg1qapZ35orhs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eu2brhcmh-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 17:44:45 -0700
Received: from twshared33837.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 17:44:43 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 320331269EDE; Tue, 15 Mar 2022 17:44:39 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v2 3/4] bpf, x86: Support BPF cookie for fentry/fexit/fmod_ret.
Date:   Tue, 15 Mar 2022 17:42:30 -0700
Message-ID: <20220316004231.1103318-4-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220316004231.1103318-1-kuifeng@fb.com>
References: <20220316004231.1103318-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: tJcivi4ryg2woqTrIfO7osm9oDfxsyov
X-Proofpoint-ORIG-GUID: tJcivi4ryg2woqTrIfO7osm9oDfxsyov
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_11,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a bpf_cookie field to attach a cookie to an instance of struct
bpf_link.  The cookie of a bpf_link will be installed when calling the
associated program to make it available to the program.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 arch/x86/net/bpf_jit_comp.c    |  4 ++--
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/syscall.c           | 11 +++++++----
 kernel/trace/bpf_trace.c       | 17 +++++++++++++++++
 tools/include/uapi/linux/bpf.h |  1 +
 tools/lib/bpf/bpf.c            | 14 ++++++++++++++
 tools/lib/bpf/bpf.h            |  1 +
 tools/lib/bpf/libbpf.map       |  1 +
 9 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 29775a475513..5fab8530e909 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1753,8 +1753,8 @@ static int invoke_bpf_prog(const struct btf_func_mo=
del *m, u8 **pprog,
=20
 	EMIT1(0x52);		 /* push rdx */
=20
-	/* mov rdi, 0 */
-	emit_mov_imm64(&prog, BPF_REG_1, 0, 0);
+	/* mov rdi, cookie */
+	emit_mov_imm64(&prog, BPF_REG_1, (long) l->cookie >> 32, (u32) (long) l=
->cookie);
=20
 	/* Prepare struct bpf_trace_run_ctx.
 	 * sub rsp, sizeof(struct bpf_trace_run_ctx)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d20a23953696..9469f9264b4f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1040,6 +1040,7 @@ struct bpf_link {
 	struct bpf_prog *prog;
 	struct work_struct work;
 	struct hlist_node tramp_hlist;
+	u64 cookie;
 };
=20
 struct bpf_link_ops {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 9e34da50440c..a52ec1797828 100644
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
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a289ef55ea17..cf6e22a3ab61 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2703,7 +2703,8 @@ static const struct bpf_link_ops bpf_tracing_link_l=
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
@@ -2768,6 +2769,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog =
*prog,
 	bpf_link_init(&link->link, BPF_LINK_TYPE_TRACING,
 		      &bpf_tracing_link_lops, prog);
 	link->attach_type =3D prog->expected_attach_type;
+	link->link.cookie =3D bpf_cookie;
=20
 	mutex_lock(&prog->aux->dst_mutex);
=20
@@ -3024,7 +3026,7 @@ static int bpf_perf_link_attach(const union bpf_att=
r *attr, struct bpf_prog *pro
 }
 #endif /* CONFIG_PERF_EVENTS */
=20
-#define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.prog_fd
+#define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.bpf_cookie
=20
 static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 {
@@ -3059,7 +3061,7 @@ static int bpf_raw_tracepoint_open(const union bpf_=
attr *attr)
 			tp_name =3D prog->aux->attach_func_name;
 			break;
 		}
-		err =3D bpf_tracing_prog_attach(prog, 0, 0);
+		err =3D bpf_tracing_prog_attach(prog, 0, 0, attr->raw_tracepoint.bpf_c=
ookie);
 		if (err >=3D 0)
 			return err;
 		goto out_put_prog;
@@ -4251,7 +4253,8 @@ static int tracing_bpf_link_attach(const union bpf_=
attr *attr, bpfptr_t uattr,
 	else if (prog->type =3D=3D BPF_PROG_TYPE_EXT)
 		return bpf_tracing_prog_attach(prog,
 					       attr->link_create.target_fd,
-					       attr->link_create.target_btf_id);
+					       attr->link_create.target_btf_id,
+					       0);
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
index 9e34da50440c..a52ec1797828 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1429,6 +1429,7 @@ union bpf_attr {
 	struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
 		__u64 name;
 		__u32 prog_fd;
+		__u64 bpf_cookie;
 	} raw_tracepoint;
=20
 	struct { /* anonymous struct for BPF_BTF_LOAD */
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index f69ce3a01385..dbbf09c84c21 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1133,6 +1133,20 @@ int bpf_raw_tracepoint_open(const char *name, int =
prog_fd)
 	return libbpf_err_errno(fd);
 }
=20
+int bpf_raw_tracepoint_cookie_open(const char *name, int prog_fd, __u64 =
bpf_cookie)
+{
+	union bpf_attr attr;
+	int fd;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.raw_tracepoint.name =3D ptr_to_u64(name);
+	attr.raw_tracepoint.prog_fd =3D prog_fd;
+	attr.raw_tracepoint.bpf_cookie =3D bpf_cookie;
+
+	fd =3D sys_bpf_fd(BPF_RAW_TRACEPOINT_OPEN, &attr, sizeof(attr));
+	return libbpf_err_errno(fd);
+}
+
 int bpf_btf_load(const void *btf_data, size_t btf_size, const struct bpf=
_btf_load_opts *opts)
 {
 	const size_t attr_sz =3D offsetofend(union bpf_attr, btf_log_level);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 5253cb4a4c0a..23bebcdaf23b 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -477,6 +477,7 @@ LIBBPF_API int bpf_prog_query(int target_fd, enum bpf=
_attach_type type,
 			      __u32 query_flags, __u32 *attach_flags,
 			      __u32 *prog_ids, __u32 *prog_cnt);
 LIBBPF_API int bpf_raw_tracepoint_open(const char *name, int prog_fd);
+LIBBPF_API int bpf_raw_tracepoint_cookie_open(const char *name, int prog=
_fd, __u64 bpf_cookie);
 LIBBPF_API int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf=
,
 				 __u32 *buf_len, __u32 *prog_id, __u32 *fd_type,
 				 __u64 *probe_offset, __u64 *probe_addr);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index df1b947792c8..20f947a385fa 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -434,6 +434,7 @@ LIBBPF_0.7.0 {
 		bpf_xdp_detach;
 		bpf_xdp_query;
 		bpf_xdp_query_id;
+		bpf_raw_tracepoint_cookie_open;
 		libbpf_probe_bpf_helper;
 		libbpf_probe_bpf_map_type;
 		libbpf_probe_bpf_prog_type;
--=20
2.30.2

