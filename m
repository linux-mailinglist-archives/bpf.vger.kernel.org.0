Return-Path: <bpf+bounces-16310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217DF7FFA4A
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 19:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B79B1B2160B
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 18:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CE754FB4;
	Thu, 30 Nov 2023 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69EB194
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 10:53:10 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUEeBRm021440
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 10:53:10 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3upp3uc7hf-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 10:53:10 -0800
Received: from twshared15991.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 10:53:07 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 054CC3C602970; Thu, 30 Nov 2023 10:52:57 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v12 bpf-next 13/17] libbpf: add BPF token support to bpf_map_create() API
Date: Thu, 30 Nov 2023 10:52:25 -0800
Message-ID: <20231130185229.2688956-14-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130185229.2688956-1-andrii@kernel.org>
References: <20231130185229.2688956-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: DhgXzXSZ9wTatlivZAI48o5OWFJljlll
X-Proofpoint-ORIG-GUID: DhgXzXSZ9wTatlivZAI48o5OWFJljlll
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_18,2023-11-30_01,2023-05-22_02

Add ability to provide token_fd for BPF_MAP_CREATE command through
bpf_map_create() API.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 4 +++-
 tools/lib/bpf/bpf.h | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index d4019928a864..1653b64b7015 100644
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
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index e49254c9f68f..ae2136f596b4 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -51,8 +51,11 @@ struct bpf_map_create_opts {
=20
 	__u32 numa_node;
 	__u32 map_ifindex;
+
+	__u32 token_fd;
+	size_t :0;
 };
-#define bpf_map_create_opts__last_field map_ifindex
+#define bpf_map_create_opts__last_field token_fd
=20
 LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
 			      const char *map_name,
--=20
2.34.1


