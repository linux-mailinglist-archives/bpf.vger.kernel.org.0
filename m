Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD53E477FF9
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 23:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhLPWWS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 17:22:18 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20862 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230462AbhLPWWR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Dec 2021 17:22:17 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BGIGdCQ005165
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 14:22:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Pfo3UsKN3O1jo4uA6FReV7n4chz+Sjc55SZDasJta7Q=;
 b=XFmD+0f4kK4HSn6REezbW5Ehb2qCb4sMmC3+HoCLVG8igcjLQgRmbKJ2DsmSmDWe1/cd
 on3gp8moEgb5H7HIBeHT7VKNtY4cbOArss4IZEwbCihsxRPJW6yFSSvqyGSh4DmyKfao
 0OQvCf3inkJ4AzG2YnsSm06BQ1WU/kDTh8E= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d02jgdhre-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 14:22:17 -0800
Received: from twshared10140.39.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 14:22:14 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id DD61B790A6F; Thu, 16 Dec 2021 14:22:07 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>
CC:     <christylee@fb.com>, <christyc.y.lee@gmail.com>,
        <bpf@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/2] perf: stop using deprecated bpf__object_next() API
Date:   Thu, 16 Dec 2021 14:21:08 -0800
Message-ID: <20211216222108.110518-3-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211216222108.110518-1-christylee@fb.com>
References: <20211216222108.110518-1-christylee@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: MotSGubxxiv5txGbp7nPH3W3C3JRdrDU
X-Proofpoint-ORIG-GUID: MotSGubxxiv5txGbp7nPH3W3C3JRdrDU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_09,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 mlxscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf__object_next is deprecated, track bpf_objects directly in
perf instead.

Signed-off-by: Christy Lee <christylee@fb.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/perf/util/bpf-loader.c | 72 +++++++++++++++++++++++++++---------
 tools/perf/util/bpf-loader.h |  1 +
 2 files changed, 55 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 528aeb0ab79d..9e3988fd719a 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -29,9 +29,6 @@
=20
 #include <internal/xyarray.h>
=20
-/* temporarily disable libbpf deprecation warnings */
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-
 static int libbpf_perf_print(enum libbpf_print_level level __attribute__=
((unused)),
 			      const char *fmt, va_list args)
 {
@@ -49,6 +46,36 @@ struct bpf_prog_priv {
 	int *type_mapping;
 };
=20
+struct bpf_perf_object {
+	struct bpf_object *obj;
+	struct list_head list;
+};
+
+static LIST_HEAD(bpf_objects_list);
+
+struct bpf_perf_object *bpf_perf_object__next(struct bpf_perf_object *pr=
ev)
+{
+	struct bpf_perf_object *next;
+
+	if (!prev)
+		next =3D list_first_entry(&bpf_objects_list,
+					struct bpf_perf_object, list);
+	else
+		next =3D list_next_entry(prev, list);
+
+	/* Empty list is noticed here so don't need checking on entry. */
+	if (&next->list =3D=3D &bpf_objects_list)
+		return NULL;
+
+	return next;
+}
+
+#define bpf_perf_object__for_each(perf_obj, tmp, obj)                   =
       \
+	for ((perf_obj) =3D bpf_perf_object__next(NULL),                       =
  \
+	    (tmp) =3D bpf_perf_object__next(perf_obj), (obj) =3D NULL;         =
    \
+	     (perf_obj) !=3D NULL; (perf_obj) =3D (tmp),                       =
    \
+	    (tmp) =3D bpf_perf_object__next(tmp), (obj) =3D (perf_obj)->obj)
+
 static bool libbpf_initialized;
=20
 struct bpf_object *
@@ -113,9 +140,10 @@ struct bpf_object *bpf__prepare_load(const char *fil=
ename, bool source)
=20
 void bpf__clear(void)
 {
-	struct bpf_object *obj, *tmp;
+	struct bpf_perf_object *perf_obj, *tmp;
+	struct bpf_object *obj;
=20
-	bpf_object__for_each_safe(obj, tmp) {
+	bpf_perf_object__for_each(perf_obj, tmp, obj) {
 		bpf__unprobe(obj);
 		bpf_object__close(obj);
 	}
@@ -621,8 +649,12 @@ static int hook_load_preprocessor(struct bpf_program=
 *prog)
 	if (err)
 		return err;
=20
+/* temporarily disable libbpf deprecation warnings */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
 	err =3D bpf_program__set_prep(prog, priv->nr_types,
 				    preproc_gen_prologue);
+#pragma GCC diagnostic pop
 	return err;
 }
=20
@@ -776,7 +808,11 @@ int bpf__foreach_event(struct bpf_object *obj,
 			if (priv->need_prologue) {
 				int type =3D priv->type_mapping[i];
=20
+/* temporarily disable libbpf deprecation warnings */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
 				fd =3D bpf_program__nth_fd(prog, type);
+#pragma GCC diagnostic pop
 			} else {
 				fd =3D bpf_program__fd(prog);
 			}
@@ -1498,10 +1534,11 @@ apply_obj_config_object(struct bpf_object *obj)
=20
 int bpf__apply_obj_config(void)
 {
-	struct bpf_object *obj, *tmp;
+	struct bpf_perf_object *perf_obj, *tmp;
+	struct bpf_object *obj;
 	int err;
=20
-	bpf_object__for_each_safe(obj, tmp) {
+	bpf_perf_object__for_each(perf_obj, tmp, obj) {
 		err =3D apply_obj_config_object(obj);
 		if (err)
 			return err;
@@ -1510,26 +1547,25 @@ int bpf__apply_obj_config(void)
 	return 0;
 }
=20
-#define bpf__for_each_map(pos, obj, objtmp)	\
-	bpf_object__for_each_safe(obj, objtmp)	\
-		bpf_object__for_each_map(pos, obj)
+#define bpf__perf_for_each_map(perf_obj, tmp, obj, map)                 =
       \
+	bpf_perf_object__for_each(perf_obj, tmp, obj)                          =
\
+		bpf_object__for_each_map(map, obj)
=20
-#define bpf__for_each_map_named(pos, obj, objtmp, name)	\
-	bpf__for_each_map(pos, obj, objtmp) 		\
-		if (bpf_map__name(pos) && 		\
-			(strcmp(name, 			\
-				bpf_map__name(pos)) =3D=3D 0))
+#define bpf__perf_for_each_map_named(perf_obj, tmp, obj, map, name)     =
       \
+	bpf__perf_for_each_map(perf_obj, tmp, obj, map)                        =
\
+		if (bpf_map__name(map) && (strcmp(name, bpf_map__name(map)) =3D=3D 0))
=20
 struct evsel *bpf__setup_output_event(struct evlist *evlist, const char =
*name)
 {
 	struct bpf_map_priv *tmpl_priv =3D NULL;
-	struct bpf_object *obj, *tmp;
+	struct bpf_perf_object *perf_obj, *tmp;
+	struct bpf_object *obj;
 	struct evsel *evsel =3D NULL;
 	struct bpf_map *map;
 	int err;
 	bool need_init =3D false;
=20
-	bpf__for_each_map_named(map, obj, tmp, name) {
+	bpf__perf_for_each_map_named(perf_obj, tmp, obj, map, name) {
 		struct bpf_map_priv *priv =3D bpf_map__priv(map);
=20
 		if (IS_ERR(priv))
@@ -1565,7 +1601,7 @@ struct evsel *bpf__setup_output_event(struct evlist=
 *evlist, const char *name)
 		evsel =3D evlist__last(evlist);
 	}
=20
-	bpf__for_each_map_named(map, obj, tmp, name) {
+	bpf__perf_for_each_map_named(perf_obj, tmp, obj, map, name) {
 		struct bpf_map_priv *priv =3D bpf_map__priv(map);
=20
 		if (IS_ERR(priv))
diff --git a/tools/perf/util/bpf-loader.h b/tools/perf/util/bpf-loader.h
index 5d1c725cea29..95262b7e936f 100644
--- a/tools/perf/util/bpf-loader.h
+++ b/tools/perf/util/bpf-loader.h
@@ -53,6 +53,7 @@ typedef int (*bpf_prog_iter_callback_t)(const char *gro=
up, const char *event,
=20
 #ifdef HAVE_LIBBPF_SUPPORT
 struct bpf_object *bpf__prepare_load(const char *filename, bool source);
+struct bpf_perf_object *bpf_perf_object__next(struct bpf_perf_object *pr=
ev);
 int bpf__strerror_prepare_load(const char *filename, bool source,
 			       int err, char *buf, size_t size);
=20
--=20
2.30.2

