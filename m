Return-Path: <bpf+bounces-17026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A59648090B9
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 19:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1861C20918
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 18:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8034F5F1;
	Thu,  7 Dec 2023 18:55:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575D3171D
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 10:54:59 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7EK3gK022459
	for <bpf@vger.kernel.org>; Thu, 7 Dec 2023 10:54:58 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uufqaj8gf-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 10:54:57 -0800
Received: from twshared2123.40.prn1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 7 Dec 2023 10:54:52 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 2764E3CC1CA12; Thu,  7 Dec 2023 10:54:48 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH bpf-next 2/8] libbpf: split feature detectors definitions from cached results
Date: Thu, 7 Dec 2023 10:54:37 -0800
Message-ID: <20231207185443.2297160-3-andrii@kernel.org>
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
X-Proofpoint-GUID: LNVoNUHhJwPYCHhNtTvWxR5bMYpSXiTL
X-Proofpoint-ORIG-GUID: LNVoNUHhJwPYCHhNtTvWxR5bMYpSXiTL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_15,2023-12-07_01,2023-05-22_02

Split a list of supported feature detectors with their corresponding
callbacks from actual cached supported/missing values. This will allow
to have more flexible per-token or per-object feature detectors in
subsequent refactorings.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ea9b8158c20d..a6b8d6f70918 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4988,12 +4988,17 @@ enum kern_feature_result {
 	FEAT_MISSING =3D 2,
 };
=20
+struct kern_feature_cache {
+	enum kern_feature_result res[__FEAT_CNT];
+};
+
 typedef int (*feature_probe_fn)(void);
=20
+static struct kern_feature_cache feature_cache;
+
 static struct kern_feature_desc {
 	const char *desc;
 	feature_probe_fn probe;
-	enum kern_feature_result res;
 } feature_probes[__FEAT_CNT] =3D {
 	[FEAT_PROG_NAME] =3D {
 		"BPF program name", probe_kern_prog_name,
@@ -5061,6 +5066,7 @@ static struct kern_feature_desc {
 bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id =
feat_id)
 {
 	struct kern_feature_desc *feat =3D &feature_probes[feat_id];
+	struct kern_feature_cache *cache =3D &feature_cache;
 	int ret;
=20
 	if (obj && obj->gen_loader)
@@ -5069,19 +5075,19 @@ bool kernel_supports(const struct bpf_object *obj=
, enum kern_feature_id feat_id)
 		 */
 		return true;
=20
-	if (READ_ONCE(feat->res) =3D=3D FEAT_UNKNOWN) {
+	if (READ_ONCE(cache->res[feat_id]) =3D=3D FEAT_UNKNOWN) {
 		ret =3D feat->probe();
 		if (ret > 0) {
-			WRITE_ONCE(feat->res, FEAT_SUPPORTED);
+			WRITE_ONCE(cache->res[feat_id], FEAT_SUPPORTED);
 		} else if (ret =3D=3D 0) {
-			WRITE_ONCE(feat->res, FEAT_MISSING);
+			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
 		} else {
 			pr_warn("Detection of kernel %s support failed: %d\n", feat->desc, re=
t);
-			WRITE_ONCE(feat->res, FEAT_MISSING);
+			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
 		}
 	}
=20
-	return READ_ONCE(feat->res) =3D=3D FEAT_SUPPORTED;
+	return READ_ONCE(cache->res[feat_id]) =3D=3D FEAT_SUPPORTED;
 }
=20
 static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
--=20
2.34.1


