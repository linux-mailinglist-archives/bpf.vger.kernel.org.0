Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96DE49D4B5
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 22:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiAZVsd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 16:48:33 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56982 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232753AbiAZVsd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 Jan 2022 16:48:33 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20QL2CSo026288
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 13:48:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=G+L5UcpNoW1pJd0B+pXYwY+knt0rLNsTVuTun1DhQ6k=;
 b=oUCZQIG1CPGS+25YP0j5YZOP8aISRU9si0XJtBxMs7aAHP2iYjSE2s+tapwo/stxZK9P
 7mLLiGDr8kgmzQrXzEl0dzSRIcTnq5MG3yK6VAlnivhhUewILG+LOEoC/oVGzy7fmH21
 FPs5w/VZiGSCjrs3WyZcHMBQtYqCZ+XcCUM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dts3ef786-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 13:48:32 -0800
Received: from twshared3115.02.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 13:48:31 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id 290E12C9AA2E; Wed, 26 Jan 2022 13:48:16 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next 4/5] bpf: Attach a cookie to a BPF program.
Date:   Wed, 26 Jan 2022 13:48:08 -0800
Message-ID: <20220126214809.3868787-5-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126214809.3868787-1-kuifeng@fb.com>
References: <20220126214809.3868787-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7N2poUs50HJgFYT4NSaNxRI_GvhXMBdE
X-Proofpoint-GUID: 7N2poUs50HJgFYT4NSaNxRI_GvhXMBdE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_08,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 adultscore=0 mlxlogscore=909 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend bpf() to attach a tracing program with a cookie by adding a
bpf_cookie field to bpf_attr for raw tracepoints.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/syscall.c           | 12 ++++++++----
 tools/include/uapi/linux/bpf.h |  1 +
 tools/lib/bpf/bpf.c            | 14 ++++++++++++++
 tools/lib/bpf/bpf.h            |  1 +
 tools/lib/bpf/libbpf.map       |  1 +
 7 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 37353745fee5..d5196514e9bd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1004,6 +1004,7 @@ struct bpf_prog_aux {
 		struct work_struct work;
 		struct rcu_head	rcu;
 	};
+	u64 cookie;
 };
=20
 struct bpf_array_aux {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 16a7574292a5..3fa27346ab4b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1425,6 +1425,7 @@ union bpf_attr {
 	struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
 		__u64 name;
 		__u32 prog_fd;
+		__u64 bpf_cookie;
 	} raw_tracepoint;
=20
 	struct { /* anonymous struct for BPF_BTF_LOAD */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 72ce1edde950..79d057918c76 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2696,7 +2696,8 @@ static const struct bpf_link_ops bpf_tracing_link_l=
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
@@ -2832,6 +2833,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog =
*prog,
 	if (err)
 		goto out_unlock;
=20
+	prog->aux->cookie =3D bpf_cookie;
+
 	err =3D bpf_trampoline_link_prog(prog, tr);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
@@ -3017,7 +3020,7 @@ static int bpf_perf_link_attach(const union bpf_att=
r *attr, struct bpf_prog *pro
 }
 #endif /* CONFIG_PERF_EVENTS */
=20
-#define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.prog_fd
+#define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.bpf_cookie
=20
 static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 {
@@ -3052,7 +3055,7 @@ static int bpf_raw_tracepoint_open(const union bpf_=
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
@@ -4244,7 +4247,8 @@ static int tracing_bpf_link_attach(const union bpf_=
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
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 16a7574292a5..3fa27346ab4b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1425,6 +1425,7 @@ union bpf_attr {
 	struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
 		__u64 name;
 		__u32 prog_fd;
+		__u64 bpf_cookie;
 	} raw_tracepoint;
=20
 	struct { /* anonymous struct for BPF_BTF_LOAD */
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 418b259166f8..c28b017de515 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1131,6 +1131,20 @@ int bpf_raw_tracepoint_open(const char *name, int =
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
index c2e8327010f9..c3d2c6a4cb15 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -475,6 +475,7 @@ LIBBPF_API int bpf_prog_query(int target_fd, enum bpf=
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
index e10f0822845a..05af5bb8de92 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -432,6 +432,7 @@ LIBBPF_0.7.0 {
 		bpf_xdp_detach;
 		bpf_xdp_query;
 		bpf_xdp_query_id;
+		bpf_raw_tracepoint_cookie_open;
 		libbpf_probe_bpf_helper;
 		libbpf_probe_bpf_map_type;
 		libbpf_probe_bpf_prog_type;
--=20
2.30.2

