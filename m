Return-Path: <bpf+bounces-17027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9E18090BB
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 19:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0E31C20CA9
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 18:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EFB4F5FD;
	Thu,  7 Dec 2023 18:55:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89245171F
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 10:55:00 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7EKQdw031422
	for <bpf@vger.kernel.org>; Thu, 7 Dec 2023 10:54:59 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uufqft7ha-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 10:54:59 -0800
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 7 Dec 2023 10:54:54 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 37D2E3CC1CA38; Thu,  7 Dec 2023 10:54:50 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH bpf-next 3/8] libbpf: further decouple feature checking logic from bpf_object
Date: Thu, 7 Dec 2023 10:54:38 -0800
Message-ID: <20231207185443.2297160-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207185443.2297160-1-andrii@kernel.org>
References: <20231207185443.2297160-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: y3HdkwJb8JP6MbEsQPoVEClEUenZiqF6
X-Proofpoint-GUID: y3HdkwJb8JP6MbEsQPoVEClEUenZiqF6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_15,2023-12-07_01,2023-05-22_02

Add feat_supported() helper that accepts feature cache instead of
bpf_object. This allows low-level code in bpf.c to not know or care
about higher-level concept of bpf_object, yet it will be able to utilize
custom feature checking in cases where BPF token might influence the
outcome.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c             |  6 +++---
 tools/lib/bpf/libbpf.c          | 23 ++++++++++++++++-------
 tools/lib/bpf/libbpf_internal.h |  5 ++++-
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index f4e1da3c6d5f..120855ac6859 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -146,7 +146,7 @@ int bump_rlimit_memlock(void)
 	struct rlimit rlim;
=20
 	/* if kernel supports memcg-based accounting, skip bumping RLIMIT_MEMLO=
CK */
-	if (memlock_bumped || kernel_supports(NULL, FEAT_MEMCG_ACCOUNT))
+	if (memlock_bumped || feat_supported(NULL, FEAT_MEMCG_ACCOUNT))
 		return 0;
=20
 	memlock_bumped =3D true;
@@ -181,7 +181,7 @@ int bpf_map_create(enum bpf_map_type map_type,
 		return libbpf_err(-EINVAL);
=20
 	attr.map_type =3D map_type;
-	if (map_name && kernel_supports(NULL, FEAT_PROG_NAME))
+	if (map_name && feat_supported(NULL, FEAT_PROG_NAME))
 		libbpf_strlcpy(attr.map_name, map_name, sizeof(attr.map_name));
 	attr.key_size =3D key_size;
 	attr.value_size =3D value_size;
@@ -265,7 +265,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 	attr.kern_version =3D OPTS_GET(opts, kern_version, 0);
 	attr.prog_token_fd =3D OPTS_GET(opts, token_fd, 0);
=20
-	if (prog_name && kernel_supports(NULL, FEAT_PROG_NAME))
+	if (prog_name && feat_supported(NULL, FEAT_PROG_NAME))
 		libbpf_strlcpy(attr.prog_name, prog_name, sizeof(attr.prog_name));
 	attr.license =3D ptr_to_u64(license);
=20
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a6b8d6f70918..af5e777efcbd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -637,6 +637,7 @@ struct elf_state {
 };
=20
 struct usdt_manager;
+struct kern_feature_cache;
=20
 struct bpf_object {
 	char name[BPF_OBJ_NAME_LEN];
@@ -5063,17 +5064,14 @@ static struct kern_feature_desc {
 	},
 };
=20
-bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id =
feat_id)
+bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_=
id feat_id)
 {
 	struct kern_feature_desc *feat =3D &feature_probes[feat_id];
-	struct kern_feature_cache *cache =3D &feature_cache;
 	int ret;
=20
-	if (obj && obj->gen_loader)
-		/* To generate loader program assume the latest kernel
-		 * to avoid doing extra prog_load, map_create syscalls.
-		 */
-		return true;
+	/* assume global feature cache, unless custom one is provided */
+	if (!cache)
+		cache =3D &feature_cache;
=20
 	if (READ_ONCE(cache->res[feat_id]) =3D=3D FEAT_UNKNOWN) {
 		ret =3D feat->probe();
@@ -5090,6 +5088,17 @@ bool kernel_supports(const struct bpf_object *obj,=
 enum kern_feature_id feat_id)
 	return READ_ONCE(cache->res[feat_id]) =3D=3D FEAT_SUPPORTED;
 }
=20
+bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id =
feat_id)
+{
+	if (obj && obj->gen_loader)
+		/* To generate loader program assume the latest kernel
+		 * to avoid doing extra prog_load, map_create syscalls.
+		 */
+		return true;
+
+	return feat_supported(NULL, feat_id);
+}
+
 static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
 {
 	struct bpf_map_info map_info;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
index b5d334754e5d..754a432335e4 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -360,8 +360,11 @@ enum kern_feature_id {
 	__FEAT_CNT,
 };
=20
-int probe_memcg_account(void);
+struct kern_feature_cache;
+bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_=
id feat_id);
 bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id =
feat_id);
+
+int probe_memcg_account(void);
 int bump_rlimit_memlock(void);
=20
 int parse_cpu_mask_str(const char *s, bool **mask, int *mask_sz);
--=20
2.34.1


