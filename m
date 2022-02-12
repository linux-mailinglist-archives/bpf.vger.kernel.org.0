Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B654B3399
	for <lists+bpf@lfdr.de>; Sat, 12 Feb 2022 08:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbiBLHbM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 12 Feb 2022 02:31:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiBLHbK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Feb 2022 02:31:10 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3DC26AD6
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 23:31:08 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21C0YfsK004002
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 23:31:08 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e62fk15w0-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 23:31:07 -0800
Received: from twshared10140.39.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 23:31:04 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5AB2710C02D74; Fri, 11 Feb 2022 23:31:01 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Christy Lee <christylee@fb.com>,
        Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH v5 bpf-next 2/2] perf: Stop using deprecated bpf_object__next() API
Date:   Fri, 11 Feb 2022 23:30:54 -0800
Message-ID: <20220212073054.1052880-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220212073054.1052880-1-andrii@kernel.org>
References: <20220212073054.1052880-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tK6sMuPCiAntLelrf9cejPsAJpFft3YK
X-Proofpoint-GUID: tK6sMuPCiAntLelrf9cejPsAJpFft3YK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-12_02,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202120044
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Christy Lee <christylee@fb.com>

Libbpf has deprecated the ability to keep track of object list inside
libbpf, it now requires applications to track usage multiple bpf
objects directly. Remove usage of bpf_object__next() API and hoist the
tracking logic to perf.

Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Christy Lee <christylee@fb.com>
Signed-off-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/perf/util/bpf-loader.c | 98 +++++++++++++++++++++++++++++-------
 1 file changed, 79 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 3cd5ae200f2c..7ff556ef1137 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -49,8 +49,52 @@ struct bpf_prog_priv {
 	int *type_mapping;
 };
 
+struct bpf_perf_object {
+	struct list_head list;
+	struct bpf_object *obj;
+};
+
+static LIST_HEAD(bpf_objects_list);
+
+static struct bpf_perf_object *
+bpf_perf_object__next(struct bpf_perf_object *prev)
+{
+	struct bpf_perf_object *next;
+
+	if (!prev)
+		next = list_first_entry(&bpf_objects_list,
+					struct bpf_perf_object,
+					list);
+	else
+		next = list_next_entry(prev, list);
+
+	/* Empty list is noticed here so don't need checking on entry. */
+	if (&next->list == &bpf_objects_list)
+		return NULL;
+
+	return next;
+}
+
+#define bpf_perf_object__for_each(perf_obj, tmp)	\
+	for ((perf_obj) = bpf_perf_object__next(NULL),	\
+	     (tmp) = bpf_perf_object__next(perf_obj);	\
+	     (perf_obj) != NULL;			\
+	     (perf_obj) = (tmp), (tmp) = bpf_perf_object__next(tmp))
+
 static bool libbpf_initialized;
 
+static int bpf_perf_object__add(struct bpf_object *obj)
+{
+	struct bpf_perf_object *perf_obj = zalloc(sizeof(*perf_obj));
+
+	if (perf_obj) {
+		INIT_LIST_HEAD(&perf_obj->list);
+		perf_obj->obj = obj;
+		list_add_tail(&perf_obj->list, &bpf_objects_list);
+	}
+	return perf_obj ? 0 : -ENOMEM;
+}
+
 struct bpf_object *
 bpf__prepare_load_buffer(void *obj_buf, size_t obj_buf_sz, const char *name)
 {
@@ -68,9 +112,21 @@ bpf__prepare_load_buffer(void *obj_buf, size_t obj_buf_sz, const char *name)
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (bpf_perf_object__add(obj)) {
+		bpf_object__close(obj);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	return obj;
 }
 
+static void bpf_perf_object__close(struct bpf_perf_object *perf_obj)
+{
+	list_del(&perf_obj->list);
+	bpf_object__close(perf_obj->obj);
+	free(perf_obj);
+}
+
 struct bpf_object *bpf__prepare_load(const char *filename, bool source)
 {
 	LIBBPF_OPTS(bpf_object_open_opts, opts, .object_name = filename);
@@ -102,24 +158,30 @@ struct bpf_object *bpf__prepare_load(const char *filename, bool source)
 			llvm__dump_obj(filename, obj_buf, obj_buf_sz);
 
 		free(obj_buf);
-	} else
+	} else {
 		obj = bpf_object__open(filename);
+	}
 
 	if (IS_ERR_OR_NULL(obj)) {
 		pr_debug("bpf: failed to load %s\n", filename);
 		return obj;
 	}
 
+	if (bpf_perf_object__add(obj)) {
+		bpf_object__close(obj);
+		return ERR_PTR(-BPF_LOADER_ERRNO__COMPILE);
+	}
+
 	return obj;
 }
 
 void bpf__clear(void)
 {
-	struct bpf_object *obj, *tmp;
+	struct bpf_perf_object *perf_obj, *tmp;
 
-	bpf_object__for_each_safe(obj, tmp) {
-		bpf__unprobe(obj);
-		bpf_object__close(obj);
+	bpf_perf_object__for_each(perf_obj, tmp) {
+		bpf__unprobe(perf_obj->obj);
+		bpf_perf_object__close(perf_obj);
 	}
 }
 
@@ -1493,11 +1555,11 @@ apply_obj_config_object(struct bpf_object *obj)
 
 int bpf__apply_obj_config(void)
 {
-	struct bpf_object *obj, *tmp;
+	struct bpf_perf_object *perf_obj, *tmp;
 	int err;
 
-	bpf_object__for_each_safe(obj, tmp) {
-		err = apply_obj_config_object(obj);
+	bpf_perf_object__for_each(perf_obj, tmp) {
+		err = apply_obj_config_object(perf_obj->obj);
 		if (err)
 			return err;
 	}
@@ -1505,26 +1567,24 @@ int bpf__apply_obj_config(void)
 	return 0;
 }
 
-#define bpf__for_each_map(pos, obj, objtmp)	\
-	bpf_object__for_each_safe(obj, objtmp)	\
-		bpf_object__for_each_map(pos, obj)
+#define bpf__perf_for_each_map(map, pobj, tmp)			\
+	bpf_perf_object__for_each(pobj, tmp)			\
+		bpf_object__for_each_map(map, pobj->obj)
 
-#define bpf__for_each_map_named(pos, obj, objtmp, name)	\
-	bpf__for_each_map(pos, obj, objtmp) 		\
-		if (bpf_map__name(pos) && 		\
-			(strcmp(name, 			\
-				bpf_map__name(pos)) == 0))
+#define bpf__perf_for_each_map_named(map, pobj, pobjtmp, name)	\
+	bpf__perf_for_each_map(map, pobj, pobjtmp)		\
+		if (bpf_map__name(map) && (strcmp(name, bpf_map__name(map)) == 0))
 
 struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name)
 {
 	struct bpf_map_priv *tmpl_priv = NULL;
-	struct bpf_object *obj, *tmp;
+	struct bpf_perf_object *perf_obj, *tmp;
 	struct evsel *evsel = NULL;
 	struct bpf_map *map;
 	int err;
 	bool need_init = false;
 
-	bpf__for_each_map_named(map, obj, tmp, name) {
+	bpf__perf_for_each_map_named(map, perf_obj, tmp, name) {
 		struct bpf_map_priv *priv = bpf_map__priv(map);
 
 		if (IS_ERR(priv))
@@ -1560,7 +1620,7 @@ struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name)
 		evsel = evlist__last(evlist);
 	}
 
-	bpf__for_each_map_named(map, obj, tmp, name) {
+	bpf__perf_for_each_map_named(map, perf_obj, tmp, name) {
 		struct bpf_map_priv *priv = bpf_map__priv(map);
 
 		if (IS_ERR(priv))
-- 
2.30.2

