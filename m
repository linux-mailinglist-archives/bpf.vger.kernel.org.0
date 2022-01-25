Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5BF49A8B1
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 05:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356750AbiAYDKv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 22:10:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43798 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S3415264AbiAYA7t (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 Jan 2022 19:59:49 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20P0RMRa006272
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 16:59:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Z1ZJ0n2HB8wNNRTFyS4MvLEn39nkqs9NF/vTbaCsL8k=;
 b=DyW15teSHuZDv//Wc68JJR5gHyowNq4OSD2SCRQOdFw85/MDDC3XxPJN/iVpZt+Mj48d
 I6P4D0nsfHgm0iDopPeTq8lQCnOOobYnQKPkx9GoZ6dJ7tzTtJzDkW25kf5Ci+rbAsjZ
 jsTGyzg/CNdup36X3RKNPMsFGfLJMQ/nmpc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dssy0dfqm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 16:59:49 -0800
Received: from twshared3399.25.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 16:59:39 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id 0D26C22A47A4; Mon, 24 Jan 2022 16:59:34 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <arnaldo.melo@gmail.com>,
        <christyc.y.lee@gmail.com>
CC:     <bpf@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <kernel-team@fb.com>, Christy Lee <christylee@fb.com>
Subject: [PATCH bpf-next 2/2] perf: stop using bpf_object__open_buffer() API
Date:   Mon, 24 Jan 2022 16:59:23 -0800
Message-ID: <20220125005923.418339-3-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125005923.418339-1-christylee@fb.com>
References: <20220125005923.418339-1-christylee@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: OGukjlcUGVIysBiVnOMbW6hKfFpDclsQ
X-Proofpoint-ORIG-GUID: OGukjlcUGVIysBiVnOMbW6hKfFpDclsQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_10,2022-01-24_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250005
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_object__open_buffer() API is deprecated, use the unified opts
bpf_object__open_mem() API in perf instead. This requires at least
libbpf 6.0.

Signed-off-by: Christy Lee <christylee@fb.com>
---
 tools/perf/tests/llvm.c      |  2 +-
 tools/perf/util/bpf-event.c  | 10 ++++++++++
 tools/perf/util/bpf-loader.c | 10 ++++++++--
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/llvm.c b/tools/perf/tests/llvm.c
index 8ac0a3a457ef..0bc25a56cfef 100644
--- a/tools/perf/tests/llvm.c
+++ b/tools/perf/tests/llvm.c
@@ -13,7 +13,7 @@ static int test__bpf_parsing(void *obj_buf, size_t obj_=
buf_sz)
 {
 	struct bpf_object *obj;
=20
-	obj =3D bpf_object__open_buffer(obj_buf, obj_buf_sz, NULL);
+	obj =3D bpf_object__open_mem(obj_buf, obj_buf_sz, NULL);
 	if (libbpf_get_error(obj))
 		return TEST_FAIL;
 	bpf_object__close(obj);
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index a517eaa51eb3..fd5469bf4ac2 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -51,6 +51,16 @@ bpf_object__next_map(const struct bpf_object *obj, con=
st struct bpf_map *prev)
 #pragma GCC diagnostic pop
 }
=20
+struct bpf_object * __weak
+bpf_object__open_mem(const void *obj_buf, size_t obj_buf_sz,
+		     const struct bpf_object_open_opts *opts)
+{
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+	return bpf_object__open_buffer(obj_buf, obj_buf_sz, opts->object_name);
+#pragma GCC diagnostic pop
+}
+
 const void * __weak
 btf__raw_data(const struct btf *btf_ro, __u32 *size)
 {
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 4631cac3957f..e92b17ad9d89 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -54,6 +54,9 @@ static bool libbpf_initialized;
 struct bpf_object *
 bpf__prepare_load_buffer(void *obj_buf, size_t obj_buf_sz, const char *n=
ame)
 {
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts,
+		.object_name =3D name
+	);
 	struct bpf_object *obj;
=20
 	if (!libbpf_initialized) {
@@ -61,7 +64,7 @@ bpf__prepare_load_buffer(void *obj_buf, size_t obj_buf_=
sz, const char *name)
 		libbpf_initialized =3D true;
 	}
=20
-	obj =3D bpf_object__open_buffer(obj_buf, obj_buf_sz, name);
+	obj =3D bpf_object__open_mem(obj_buf, obj_buf_sz, &opts);
 	if (IS_ERR_OR_NULL(obj)) {
 		pr_debug("bpf: failed to load buffer\n");
 		return ERR_PTR(-EINVAL);
@@ -72,6 +75,9 @@ bpf__prepare_load_buffer(void *obj_buf, size_t obj_buf_=
sz, const char *name)
=20
 struct bpf_object *bpf__prepare_load(const char *filename, bool source)
 {
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts,
+		.object_name =3D filename
+	);
 	struct bpf_object *obj;
=20
 	if (!libbpf_initialized) {
@@ -94,7 +100,7 @@ struct bpf_object *bpf__prepare_load(const char *filen=
ame, bool source)
 				return ERR_PTR(-BPF_LOADER_ERRNO__COMPILE);
 		} else
 			pr_debug("bpf: successful builtin compilation\n");
-		obj =3D bpf_object__open_buffer(obj_buf, obj_buf_sz, filename);
+		obj =3D bpf_object__open_mem(obj_buf, obj_buf_sz, &opts);
=20
 		if (!IS_ERR_OR_NULL(obj) && llvm_param.dump_obj)
 			llvm__dump_obj(filename, obj_buf, obj_buf_sz);
--=20
2.30.2

