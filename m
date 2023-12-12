Return-Path: <bpf+bounces-17565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C6B80F578
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 19:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C25C281775
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 18:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1C07E773;
	Tue, 12 Dec 2023 18:26:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2650CA
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 10:26:07 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCH0h6k002852
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 10:26:07 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ux308a74u-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 10:26:07 -0800
Received: from twshared68648.02.prn6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 12 Dec 2023 10:26:04 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 00F5A3D0588E5; Tue, 12 Dec 2023 10:25:53 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        John Fastabend
	<john.fastabend@gmail.com>
Subject: [PATCH v2 bpf-next 2/8] libbpf: split feature detectors definitions from cached results
Date: Tue, 12 Dec 2023 10:25:41 -0800
Message-ID: <20231212182547.1873811-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212182547.1873811-1-andrii@kernel.org>
References: <20231212182547.1873811-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: MnmFzotKnqr61JgS6GuF6O7KLQHe-KkL
X-Proofpoint-ORIG-GUID: MnmFzotKnqr61JgS6GuF6O7KLQHe-KkL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02

Split a list of supported feature detectors with their corresponding
callbacks from actual cached supported/missing values. This will allow
to have more flexible per-token or per-object feature detectors in
subsequent refactorings.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ac54ebc0629f..d2828a26b011 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4999,12 +4999,17 @@ enum kern_feature_result {
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
@@ -5072,6 +5077,7 @@ static struct kern_feature_desc {
 bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id =
feat_id)
 {
 	struct kern_feature_desc *feat =3D &feature_probes[feat_id];
+	struct kern_feature_cache *cache =3D &feature_cache;
 	int ret;
=20
 	if (obj && obj->gen_loader)
@@ -5080,19 +5086,19 @@ bool kernel_supports(const struct bpf_object *obj=
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


