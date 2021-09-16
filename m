Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4480340E147
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 18:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241260AbhIPQ3B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Sep 2021 12:29:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43128 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241990AbhIPQ0b (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Sep 2021 12:26:31 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GFgtmp005023
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 09:25:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=FEngnceCHNRk7KyGdfiXouOzgaCwaRfn74nt54cqj9c=;
 b=R2FkPkU1U0cINYp3qHN+FvlK6++yo6b1tp9TDrhJTBuDM4iUDST3vzKn4+oIdKha00xy
 V4zBtj+gytyT+z7oyraZaapOi44uONzNwRmnclkTqR3Fz9+oghLcy2v0UlMQFhn3U59N
 u6UeP3zEEdohUNW2G2osY7g/0ctVAk23oBE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b3dkwjsbt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 09:25:10 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 16 Sep 2021 09:25:09 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 4305CBE68AB4; Thu, 16 Sep 2021 09:25:02 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Mel Gorman <mgorman@techsingularity.net>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH rfc 5/6] libbpf: add support for scheduler bpf programs
Date:   Thu, 16 Sep 2021 09:24:50 -0700
Message-ID: <20210916162451.709260-6-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916162451.709260-1-guro@fb.com>
References: <20210915213550.3696532-1-guro@fb.com>
 <20210916162451.709260-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: PheQcomK4p2WdO4EtqnTKaGPa5wq9CVP
X-Proofpoint-ORIG-GUID: PheQcomK4p2WdO4EtqnTKaGPa5wq9CVP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_04,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds a support for loading and attaching scheduler bpf
programs.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 tools/lib/bpf/libbpf.c   | 27 +++++++++++++++++++++++++--
 tools/lib/bpf/libbpf.h   |  4 ++++
 tools/lib/bpf/libbpf.map |  3 +++
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 62a43c408d73..8374a8d4aafe 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2633,7 +2633,8 @@ static int bpf_object__finalize_btf(struct bpf_obje=
ct *obj)
 static bool prog_needs_vmlinux_btf(struct bpf_program *prog)
 {
 	if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS ||
-	    prog->type =3D=3D BPF_PROG_TYPE_LSM)
+	    prog->type =3D=3D BPF_PROG_TYPE_LSM ||
+	    prog->type =3D=3D BPF_PROG_TYPE_SCHED)
 		return true;
=20
 	/* BPF_PROG_TYPE_TRACING programs which do not attach to other programs
@@ -6280,7 +6281,8 @@ int bpf_program__load(struct bpf_program *prog, cha=
r *license, __u32 kern_ver)
=20
 	if ((prog->type =3D=3D BPF_PROG_TYPE_TRACING ||
 	     prog->type =3D=3D BPF_PROG_TYPE_LSM ||
-	     prog->type =3D=3D BPF_PROG_TYPE_EXT) && !prog->attach_btf_id) {
+	     prog->type =3D=3D BPF_PROG_TYPE_EXT ||
+	     prog->type =3D=3D BPF_PROG_TYPE_SCHED) && !prog->attach_btf_id) {
 		int btf_obj_fd =3D 0, btf_type_id =3D 0;
=20
 		err =3D libbpf_find_attach_btf_id(prog, &btf_obj_fd, &btf_type_id);
@@ -7892,6 +7894,7 @@ BPF_PROG_TYPE_FNS(tracing, BPF_PROG_TYPE_TRACING);
 BPF_PROG_TYPE_FNS(struct_ops, BPF_PROG_TYPE_STRUCT_OPS);
 BPF_PROG_TYPE_FNS(extension, BPF_PROG_TYPE_EXT);
 BPF_PROG_TYPE_FNS(sk_lookup, BPF_PROG_TYPE_SK_LOOKUP);
+BPF_PROG_TYPE_FNS(sched, BPF_PROG_TYPE_SCHED);
=20
 enum bpf_attach_type
 bpf_program__get_expected_attach_type(const struct bpf_program *prog)
@@ -7950,6 +7953,7 @@ static struct bpf_link *attach_raw_tp(struct bpf_pr=
ogram *prog);
 static struct bpf_link *attach_trace(struct bpf_program *prog);
 static struct bpf_link *attach_lsm(struct bpf_program *prog);
 static struct bpf_link *attach_iter(struct bpf_program *prog);
+static struct bpf_link *attach_sched(struct bpf_program *prog);
=20
 static const struct bpf_sec_def section_defs[] =3D {
 	BPF_PROG_SEC("socket",			BPF_PROG_TYPE_SOCKET_FILTER),
@@ -8022,6 +8026,10 @@ static const struct bpf_sec_def section_defs[] =3D=
 {
 		.attach_fn =3D attach_iter),
 	SEC_DEF("syscall", SYSCALL,
 		.is_sleepable =3D true),
+	SEC_DEF("sched/", SCHED,
+		.is_attach_btf =3D true,
+		.expected_attach_type =3D BPF_SCHED,
+		.attach_fn =3D attach_sched),
 	BPF_EAPROG_SEC("xdp_devmap/",		BPF_PROG_TYPE_XDP,
 						BPF_XDP_DEVMAP),
 	BPF_EAPROG_SEC("xdp_cpumap/",		BPF_PROG_TYPE_XDP,
@@ -8311,6 +8319,7 @@ static int bpf_object__collect_st_ops_relos(struct =
bpf_object *obj,
 #define BTF_TRACE_PREFIX "btf_trace_"
 #define BTF_LSM_PREFIX "bpf_lsm_"
 #define BTF_ITER_PREFIX "bpf_iter_"
+#define BTF_SCHED_PREFIX "bpf_sched_"
 #define BTF_MAX_NAME_SIZE 128
=20
 void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
@@ -8329,6 +8338,10 @@ void btf_get_kernel_prefix_kind(enum bpf_attach_ty=
pe attach_type,
 		*prefix =3D BTF_ITER_PREFIX;
 		*kind =3D BTF_KIND_FUNC;
 		break;
+	case BPF_SCHED:
+		*prefix =3D BTF_SCHED_PREFIX;
+		*kind =3D BTF_KIND_FUNC;
+		break;
 	default:
 		*prefix =3D "";
 		*kind =3D BTF_KIND_FUNC;
@@ -9675,6 +9688,11 @@ struct bpf_link *bpf_program__attach_lsm(struct bp=
f_program *prog)
 	return bpf_program__attach_btf_id(prog);
 }
=20
+struct bpf_link *bpf_program__attach_sched(struct bpf_program *prog)
+{
+	return bpf_program__attach_btf_id(prog);
+}
+
 static struct bpf_link *attach_trace(struct bpf_program *prog)
 {
 	return bpf_program__attach_trace(prog);
@@ -9685,6 +9703,11 @@ static struct bpf_link *attach_lsm(struct bpf_prog=
ram *prog)
 	return bpf_program__attach_lsm(prog);
 }
=20
+static struct bpf_link *attach_sched(struct bpf_program *prog)
+{
+	return bpf_program__attach_sched(prog);
+}
+
 static struct bpf_link *
 bpf_program__attach_fd(struct bpf_program *prog, int target_fd, int btf_=
id,
 		       const char *target_name)
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 2f6f0e15d1e7..42a3dfcca778 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -339,6 +339,8 @@ bpf_program__attach_xdp(struct bpf_program *prog, int=
 ifindex);
 LIBBPF_API struct bpf_link *
 bpf_program__attach_freplace(struct bpf_program *prog,
 			     int target_fd, const char *attach_func_name);
+LIBBPF_API struct bpf_link *
+bpf_program__attach_sched(struct bpf_program *prog);
=20
 struct bpf_map;
=20
@@ -435,6 +437,7 @@ LIBBPF_API int bpf_program__set_tracing(struct bpf_pr=
ogram *prog);
 LIBBPF_API int bpf_program__set_struct_ops(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_extension(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_sk_lookup(struct bpf_program *prog);
+LIBBPF_API int bpf_program__set_sched(struct bpf_program *prog);
=20
 LIBBPF_API enum bpf_prog_type bpf_program__get_type(const struct bpf_pro=
gram *prog);
 LIBBPF_API void bpf_program__set_type(struct bpf_program *prog,
@@ -463,6 +466,7 @@ LIBBPF_API bool bpf_program__is_tracing(const struct =
bpf_program *prog);
 LIBBPF_API bool bpf_program__is_struct_ops(const struct bpf_program *pro=
g);
 LIBBPF_API bool bpf_program__is_extension(const struct bpf_program *prog=
);
 LIBBPF_API bool bpf_program__is_sk_lookup(const struct bpf_program *prog=
);
+LIBBPF_API bool bpf_program__is_sched(const struct bpf_program *prog);
=20
 /*
  * No need for __attribute__((packed)), all members of 'bpf_map_def'
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 9e649cf9e771..02f149aced5a 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -390,4 +390,7 @@ LIBBPF_0.5.0 {
 LIBBPF_0.6.0 {
 	global:
 		btf__add_tag;
+		bpf_program__attach_sched;
+		bpf_program__is_sched;
+		bpf_program__set_sched;
 } LIBBPF_0.5.0;
--=20
2.31.1

