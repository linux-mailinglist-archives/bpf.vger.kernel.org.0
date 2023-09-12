Return-Path: <bpf+bounces-9801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAD779DAFE
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3C51C20BE6
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 21:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C61B67D;
	Tue, 12 Sep 2023 21:30:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AB0A933
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 21:30:04 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B9410EB
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 14:30:03 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CKgKGu006347
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 14:30:03 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t2y8t8ecf-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 14:30:02 -0700
Received: from twshared40933.03.prn6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 12 Sep 2023 14:29:32 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id BA86537F40769; Tue, 12 Sep 2023 14:29:29 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <brauner@kernel.org>,
        <lennart@poettering.net>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v4 bpf-next 10/12] libbpf: add BPF token support to bpf_btf_load() API
Date: Tue, 12 Sep 2023 14:29:04 -0700
Message-ID: <20230912212906.3975866-11-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912212906.3975866-1-andrii@kernel.org>
References: <20230912212906.3975866-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: oMMWdF2zGvmPsvLS_9hp0QQyrRAfFYX3
X-Proofpoint-ORIG-GUID: oMMWdF2zGvmPsvLS_9hp0QQyrRAfFYX3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_20,2023-09-05_01,2023-05-22_02

Allow user to specify token_fd for bpf_btf_load() API that wraps
kernel's BPF_BTF_LOAD command. This allows loading BTF from unprivileged
process as long as it has BPF token allowing BPF_BTF_LOAD command, which
can be created and delegated by privileged process.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 4 +++-
 tools/lib/bpf/bpf.h | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index f9ee7608a96a..4547ae1037af 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1168,7 +1168,7 @@ int bpf_raw_tracepoint_open(const char *name, int p=
rog_fd)
=20
 int bpf_btf_load(const void *btf_data, size_t btf_size, struct bpf_btf_l=
oad_opts *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, btf_log_true_size)=
;
+	const size_t attr_sz =3D offsetofend(union bpf_attr, btf_token_fd);
 	union bpf_attr attr;
 	char *log_buf;
 	size_t log_size;
@@ -1193,6 +1193,8 @@ int bpf_btf_load(const void *btf_data, size_t btf_s=
ize, struct bpf_btf_load_opts
=20
 	attr.btf =3D ptr_to_u64(btf_data);
 	attr.btf_size =3D btf_size;
+	attr.btf_token_fd =3D OPTS_GET(opts, token_fd, 0);
+
 	/* log_level =3D=3D 0 and log_buf !=3D NULL means "try loading without
 	 * log_buf, but retry with log_buf and log_level=3D1 on error", which i=
s
 	 * consistent across low-level and high-level BTF and program loading
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 415ecebd41aa..20351bfba533 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -132,9 +132,10 @@ struct bpf_btf_load_opts {
 	 * If kernel doesn't support this feature, log_size is left unchanged.
 	 */
 	__u32 log_true_size;
+	__u32 token_fd;
 	size_t :0;
 };
-#define bpf_btf_load_opts__last_field log_true_size
+#define bpf_btf_load_opts__last_field token_fd
=20
 LIBBPF_API int bpf_btf_load(const void *btf_data, size_t btf_size,
 			    struct bpf_btf_load_opts *opts);
--=20
2.34.1


