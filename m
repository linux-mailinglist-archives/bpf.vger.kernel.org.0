Return-Path: <bpf+bounces-3084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B73739322
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 01:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E976228144D
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 23:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880FE1DDC1;
	Wed, 21 Jun 2023 23:38:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637CE1DCA4
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 23:38:42 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3061BD1
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 16:38:40 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LJePnp010760
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 16:38:40 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rbw1y6py9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 16:38:39 -0700
Received: from twshared66906.03.prn6.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 16:38:39 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 69AB9333E88BE; Wed, 21 Jun 2023 16:38:26 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>
CC: <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>, <cyphar@cyphar.com>,
        <luto@kernel.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v3 bpf-next 08/14] libbpf: add BPF token support to bpf_btf_load() API
Date: Wed, 21 Jun 2023 16:38:03 -0700
Message-ID: <20230621233809.1941811-9-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621233809.1941811-1-andrii@kernel.org>
References: <20230621233809.1941811-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: PLnafVlcPoISI8m1hWxpHE0-xatAZXJX
X-Proofpoint-ORIG-GUID: PLnafVlcPoISI8m1hWxpHE0-xatAZXJX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_13,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index 882297b1e136..6fb915069be7 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1098,7 +1098,7 @@ int bpf_raw_tracepoint_open(const char *name, int p=
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
@@ -1123,6 +1123,8 @@ int bpf_btf_load(const void *btf_data, size_t btf_s=
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
index cd3fb5ce6fe2..dc7c4af21ad9 100644
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


