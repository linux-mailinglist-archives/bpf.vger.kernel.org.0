Return-Path: <bpf+bounces-1693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E34720520
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 17:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF231C20963
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 15:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1094119BDA;
	Fri,  2 Jun 2023 15:00:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D7A1992C
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 15:00:36 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E40E66
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 08:00:32 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3527Ylew005201
	for <bpf@vger.kernel.org>; Fri, 2 Jun 2023 08:00:32 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qyc4yanx3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 08:00:32 -0700
Received: from twshared68078.02.prn6.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 08:00:31 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 8220431E048FF; Fri,  2 Jun 2023 08:00:28 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>
CC: <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>, <cyphar@cyphar.com>,
        <luto@kernel.org>
Subject: [PATCH RESEND bpf-next 08/18] libbpf: add BPF token support to bpf_map_create() API
Date: Fri, 2 Jun 2023 08:00:01 -0700
Message-ID: <20230602150011.1657856-9-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602150011.1657856-1-andrii@kernel.org>
References: <20230602150011.1657856-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bEtdU1prCI30Q826--bAUKfuohMeuM4k
X-Proofpoint-GUID: bEtdU1prCI30Q826--bAUKfuohMeuM4k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_11,2023-06-02_02,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add ability to provide token_fd for BPF_MAP_CREATE command through
bpf_map_create() API.

Also wire through token_create.allowed_map_types param for
BPF_TOKEN_CREATE command.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 5 ++++-
 tools/lib/bpf/bpf.h | 7 +++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 38be66719485..0318538d43eb 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -169,7 +169,7 @@ int bpf_map_create(enum bpf_map_type map_type,
 		   __u32 max_entries,
 		   const struct bpf_map_create_opts *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, map_extra);
+	const size_t attr_sz =3D offsetofend(union bpf_attr, map_token_fd);
 	union bpf_attr attr;
 	int fd;
=20
@@ -198,6 +198,8 @@ int bpf_map_create(enum bpf_map_type map_type,
 	attr.numa_node =3D OPTS_GET(opts, numa_node, 0);
 	attr.map_ifindex =3D OPTS_GET(opts, map_ifindex, 0);
=20
+	attr.map_token_fd =3D OPTS_GET(opts, token_fd, 0);
+
 	fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
 	return libbpf_err_errno(fd);
 }
@@ -1215,6 +1217,7 @@ int bpf_token_create(struct bpf_token_create_opts *=
opts)
 	attr.token_create.flags =3D OPTS_GET(opts, flags, 0);
 	attr.token_create.token_fd =3D OPTS_GET(opts, token_fd, 0);
 	attr.token_create.allowed_cmds =3D OPTS_GET(opts, allowed_cmds, 0);
+	attr.token_create.allowed_map_types =3D OPTS_GET(opts, allowed_map_type=
s, 0);
=20
 	ret =3D sys_bpf_fd(BPF_TOKEN_CREATE, &attr, attr_sz);
 	return libbpf_err_errno(ret);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index f2b8041ca27a..19a43201d1af 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -51,8 +51,10 @@ struct bpf_map_create_opts {
=20
 	__u32 numa_node;
 	__u32 map_ifindex;
+
+	__u32 token_fd;
 };
-#define bpf_map_create_opts__last_field map_ifindex
+#define bpf_map_create_opts__last_field token_fd
=20
 LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
 			      const char *map_name,
@@ -556,9 +558,10 @@ struct bpf_token_create_opts {
 	__u32 flags;
 	__u32 token_fd;
 	__u64 allowed_cmds;
+	__u64 allowed_map_types;
 	size_t :0;
 };
-#define bpf_token_create_opts__last_field allowed_cmds
+#define bpf_token_create_opts__last_field allowed_map_types
=20
 LIBBPF_API int bpf_token_create(struct bpf_token_create_opts *opts);
=20
--=20
2.34.1


