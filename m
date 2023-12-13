Return-Path: <bpf+bounces-17713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E61811E3E
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 20:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4241F20628
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 19:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E8C67B6B;
	Wed, 13 Dec 2023 19:09:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED652113
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 11:09:43 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDIXaKi002215
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 11:09:43 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uy2sp5jgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 11:09:42 -0800
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 13 Dec 2023 11:09:42 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 3432A3D185B26; Wed, 13 Dec 2023 11:09:28 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v3 bpf-next 09/10] libbpf: support BPF token path setting through LIBBPF_BPF_TOKEN_PATH envvar
Date: Wed, 13 Dec 2023 11:08:41 -0800
Message-ID: <20231213190842.3844987-10-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213190842.3844987-1-andrii@kernel.org>
References: <20231213190842.3844987-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: JWFR0SEZlYYTNZOd-BCg_A2j8ggoHe-K
X-Proofpoint-ORIG-GUID: JWFR0SEZlYYTNZOd-BCg_A2j8ggoHe-K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_12,2023-12-13_01,2023-05-22_02

To allow external admin authority to override default BPF FS location
(/sys/fs/bpf) for implicit BPF token creation, teach libbpf to recognize
LIBBPF_BPF_TOKEN_PATH envvar. If it is specified and user application
didn't explicitly specify neither bpf_token_path nor bpf_token_fd
option, it will be treated exactly like bpf_token_path option,
overriding default /sys/fs/bpf location and making BPF token mandatory.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 14 ++++++++++----
 tools/lib/bpf/libbpf.h | 13 +++++++++++--
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index db94bbe163e3..4b5ff9508e18 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7171,11 +7171,17 @@ static struct bpf_object *bpf_object_open(const c=
har *path, const void *obj_buf,
 	/* non-empty token path can't be combined with invalid token FD */
 	if (token_path && token_path[0] !=3D '\0' && token_fd < 0)
 		return ERR_PTR(-EINVAL);
+	/* empty token path can't be combined with valid token FD */
+	if (token_path && token_path[0] =3D=3D '\0' && token_fd > 0)
+		return ERR_PTR(-EINVAL);
+	/* if user didn't specify bpf_token_path/bpf_token_fd explicitly,
+	 * check if LIBBPF_BPF_TOKEN_PATH envvar was set and treat it as
+	 * bpf_token_path option
+	 */
+	if (token_fd =3D=3D 0 && !token_path)
+		token_path =3D getenv("LIBBPF_BPF_TOKEN_PATH");
+	/* empty token_path is equivalent to invalid token_fd */
 	if (token_path && token_path[0] =3D=3D '\0') {
-		/* empty token path can't be combined with valid token FD */
-		if (token_fd > 0)
-			return ERR_PTR(-EINVAL);
-		/* empty token_path is equivalent to invalid token_fd */
 		token_path =3D NULL;
 		token_fd =3D -1;
 	}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d3de39b537f3..916904bd2a7a 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -185,8 +185,16 @@ struct bpf_object_open_opts {
 	 * attempt to create BPF token from default BPF FS mount point
 	 * (/sys/fs/bpf), in case this default behavior is undesirable.
 	 *
+	 * If bpf_token_path and bpf_token_fd are not specified, libbpf will
+	 * consult LIBBPF_BPF_TOKEN_PATH environment variable. If set, it will
+	 * be taken as a value of bpf_token_path option and will force libbpf
+	 * to either create BPF token from provided custom BPF FS path, or
+	 * will disable implicit BPF token creation, if envvar value is an
+	 * empty string.
+	 *
 	 * bpf_token_path and bpf_token_fd are mutually exclusive and only one
-	 * of those options should be set.
+	 * of those options should be set. Either of them overrides
+	 * LIBBPF_BPF_TOKEN_PATH envvar.
 	 */
 	int bpf_token_fd;
 	/* Path to BPF FS mount point to derive BPF token from.
@@ -200,7 +208,8 @@ struct bpf_object_open_opts {
 	 * point (/sys/fs/bpf), in case this default behavior is undesirable.
 	 *
 	 * bpf_token_path and bpf_token_fd are mutually exclusive and only one
-	 * of those options should be set.
+	 * of those options should be set. Either of them overrides
+	 * LIBBPF_BPF_TOKEN_PATH envvar.
 	 */
 	const char *bpf_token_path;
=20
--=20
2.34.1


