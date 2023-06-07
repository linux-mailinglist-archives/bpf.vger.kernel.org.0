Return-Path: <bpf+bounces-2069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED838727384
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 01:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94A82815E3
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 23:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3933924F;
	Wed,  7 Jun 2023 23:54:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3C219BC8
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 23:54:46 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05652697
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 16:54:44 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357HVCex021694
	for <bpf@vger.kernel.org>; Wed, 7 Jun 2023 16:54:44 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r2a792t57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 16:54:44 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 16:54:43 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id B882D32857E7B; Wed,  7 Jun 2023 16:54:30 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>
CC: <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>, <cyphar@cyphar.com>,
        <luto@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 17/18] libbpf: add BPF token support to bpf_prog_load() API
Date: Wed, 7 Jun 2023 16:53:51 -0700
Message-ID: <20230607235352.1723243-18-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607235352.1723243-1-andrii@kernel.org>
References: <20230607235352.1723243-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: nW2D5ZNAdDA5Ju1wAyfuLYKTLyyhgwNi
X-Proofpoint-ORIG-GUID: nW2D5ZNAdDA5Ju1wAyfuLYKTLyyhgwNi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wire through token_fd into bpf_prog_load(). Also make sure to pass
allowed_{prog,attach}_types to kernel in bpf_token_create().

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 5 ++++-
 tools/lib/bpf/bpf.h | 7 +++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 193993dbbdc4..cd8f0c525de6 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -234,7 +234,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 		  const struct bpf_insn *insns, size_t insn_cnt,
 		  struct bpf_prog_load_opts *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, log_true_size);
+	const size_t attr_sz =3D offsetofend(union bpf_attr, prog_token_fd);
 	void *finfo =3D NULL, *linfo =3D NULL;
 	const char *func_info, *line_info;
 	__u32 log_size, log_level, attach_prog_fd, attach_btf_obj_fd;
@@ -263,6 +263,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 	attr.prog_flags =3D OPTS_GET(opts, prog_flags, 0);
 	attr.prog_ifindex =3D OPTS_GET(opts, prog_ifindex, 0);
 	attr.kern_version =3D OPTS_GET(opts, kern_version, 0);
+	attr.prog_token_fd =3D OPTS_GET(opts, token_fd, 0);
=20
 	if (prog_name && kernel_supports(NULL, FEAT_PROG_NAME))
 		libbpf_strlcpy(attr.prog_name, prog_name, sizeof(attr.prog_name));
@@ -1220,6 +1221,8 @@ int bpf_token_create(struct bpf_token_create_opts *=
opts)
 	attr.token_create.token_fd =3D OPTS_GET(opts, token_fd, 0);
 	attr.token_create.allowed_cmds =3D OPTS_GET(opts, allowed_cmds, 0);
 	attr.token_create.allowed_map_types =3D OPTS_GET(opts, allowed_map_type=
s, 0);
+	attr.token_create.allowed_prog_types =3D OPTS_GET(opts, allowed_prog_ty=
pes, 0);
+	attr.token_create.allowed_attach_types =3D OPTS_GET(opts, allowed_attac=
h_types, 0);
=20
 	ret =3D sys_bpf_fd(BPF_TOKEN_CREATE, &attr, attr_sz);
 	return libbpf_err_errno(ret);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 3153a9e697e2..f9afc7846762 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -104,9 +104,10 @@ struct bpf_prog_load_opts {
 	 * If kernel doesn't support this feature, log_size is left unchanged.
 	 */
 	__u32 log_true_size;
+	__u32 token_fd;
 	size_t :0;
 };
-#define bpf_prog_load_opts__last_field log_true_size
+#define bpf_prog_load_opts__last_field token_fd
=20
 LIBBPF_API int bpf_prog_load(enum bpf_prog_type prog_type,
 			     const char *prog_name, const char *license,
@@ -560,9 +561,11 @@ struct bpf_token_create_opts {
 	__u32 token_fd;
 	__u64 allowed_cmds;
 	__u64 allowed_map_types;
+	__u64 allowed_prog_types;
+	__u64 allowed_attach_types;
 	size_t :0;
 };
-#define bpf_token_create_opts__last_field allowed_map_types
+#define bpf_token_create_opts__last_field allowed_attach_types
=20
 LIBBPF_API int bpf_token_create(struct bpf_token_create_opts *opts);
=20
--=20
2.34.1


