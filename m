Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFBD485C00
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 00:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245245AbiAEXBa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jan 2022 18:01:30 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57922 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S245249AbiAEXB3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 5 Jan 2022 18:01:29 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 205L7OV9023767
        for <bpf@vger.kernel.org>; Wed, 5 Jan 2022 15:01:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=HO4aZeNDe8heIPTq9AacIuc6EOUQqbZ7HymP19c1bWs=;
 b=hjWA9PkKeFxGUk44QXC0qUjxn9mKmPourNmqlvFVojlHCyGjDCynVyR7NvDk806nM7HS
 XgjT5rfivpWptOS7L1NpZTgC0r5Myr6h+tcwvM+Q4qwlbIQzyFnCTK9Y5uoRUs0oZo4k
 Oei5U8pzwZvb/do0lgx076BmP97sQ3aIsOo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3dcxpr77t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 05 Jan 2022 15:01:28 -0800
Received: from twshared10140.39.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 15:01:27 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id 702CD15060B4; Wed,  5 Jan 2022 15:01:10 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>
CC:     <christyc.y.lee@gmail.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-perf-users@vger.kernel.org>,
        Christy Lee <christylee@fb.com>
Subject: [PATCH bpf-next 3/5] perf: stop using bpf_map__def() API
Date:   Wed, 5 Jan 2022 15:00:55 -0800
Message-ID: <20220105230057.853163-4-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220105230057.853163-1-christylee@fb.com>
References: <20220105230057.853163-1-christylee@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: iiPffsoG5vwrcD-YLCqG1sYFL5r79DK9
X-Proofpoint-GUID: iiPffsoG5vwrcD-YLCqG1sYFL5r79DK9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-05_08,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201050145
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf bpf_map__def() API is being deprecated, replace bpftool's
usage with the appropriate getters and setters.

Signed-off-by: Christy Lee <christylee@fb.com>
---
 tools/perf/util/bpf-loader.c | 58 ++++++++++++++++--------------------
 tools/perf/util/bpf_map.c    | 28 ++++++++---------
 2 files changed, 39 insertions(+), 47 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 528aeb0ab79d..ea5ccf0aed1b 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1002,24 +1002,22 @@ __bpf_map__config_value(struct bpf_map *map,
 {
 	struct bpf_map_op *op;
 	const char *map_name =3D bpf_map__name(map);
-	const struct bpf_map_def *def =3D bpf_map__def(map);
=20
-	if (IS_ERR(def)) {
-		pr_debug("Unable to get map definition from '%s'\n",
-			 map_name);
+	if (!map) {
+		pr_debug("Map '%s' is invalid\n", map_name);
 		return -BPF_LOADER_ERRNO__INTERNAL;
 	}
=20
-	if (def->type !=3D BPF_MAP_TYPE_ARRAY) {
+	if (bpf_map__type(map) !=3D BPF_MAP_TYPE_ARRAY) {
 		pr_debug("Map %s type is not BPF_MAP_TYPE_ARRAY\n",
 			 map_name);
 		return -BPF_LOADER_ERRNO__OBJCONF_MAP_TYPE;
 	}
-	if (def->key_size < sizeof(unsigned int)) {
+	if (bpf_map__key_size(map) < sizeof(unsigned int)) {
 		pr_debug("Map %s has incorrect key size\n", map_name);
 		return -BPF_LOADER_ERRNO__OBJCONF_MAP_KEYSIZE;
 	}
-	switch (def->value_size) {
+	switch (bpf_map__value_size(map)) {
 	case 1:
 	case 2:
 	case 4:
@@ -1061,7 +1059,6 @@ __bpf_map__config_event(struct bpf_map *map,
 			struct parse_events_term *term,
 			struct evlist *evlist)
 {
-	const struct bpf_map_def *def;
 	struct bpf_map_op *op;
 	const char *map_name =3D bpf_map__name(map);
 	struct evsel *evsel =3D evlist__find_evsel_by_str(evlist, term->val.str=
);
@@ -1072,18 +1069,16 @@ __bpf_map__config_event(struct bpf_map *map,
 		return -BPF_LOADER_ERRNO__OBJCONF_MAP_NOEVT;
 	}
=20
-	def =3D bpf_map__def(map);
-	if (IS_ERR(def)) {
-		pr_debug("Unable to get map definition from '%s'\n",
-			 map_name);
-		return PTR_ERR(def);
+	if (!map) {
+		pr_debug("Map '%s' is invalid\n", map_name);
+		return PTR_ERR(map);
 	}
=20
 	/*
 	 * No need to check key_size and value_size:
 	 * kernel has already checked them.
 	 */
-	if (def->type !=3D BPF_MAP_TYPE_PERF_EVENT_ARRAY) {
+	if (bpf_map__type(map) !=3D BPF_MAP_TYPE_PERF_EVENT_ARRAY) {
 		pr_debug("Map %s type is not BPF_MAP_TYPE_PERF_EVENT_ARRAY\n",
 			 map_name);
 		return -BPF_LOADER_ERRNO__OBJCONF_MAP_TYPE;
@@ -1132,7 +1127,6 @@ config_map_indices_range_check(struct parse_events_=
term *term,
 			       const char *map_name)
 {
 	struct parse_events_array *array =3D &term->array;
-	const struct bpf_map_def *def;
 	unsigned int i;
=20
 	if (!array->nr_ranges)
@@ -1143,10 +1137,8 @@ config_map_indices_range_check(struct parse_events=
_term *term,
 		return -BPF_LOADER_ERRNO__INTERNAL;
 	}
=20
-	def =3D bpf_map__def(map);
-	if (IS_ERR(def)) {
-		pr_debug("ERROR: Unable to get map definition from '%s'\n",
-			 map_name);
+	if (!map) {
+		pr_debug("Map '%s' is invalid\n", map_name);
 		return -BPF_LOADER_ERRNO__INTERNAL;
 	}
=20
@@ -1155,7 +1147,7 @@ config_map_indices_range_check(struct parse_events_=
term *term,
 		size_t length =3D array->ranges[i].length;
 		unsigned int idx =3D start + length - 1;
=20
-		if (idx >=3D def->max_entries) {
+		if (idx >=3D bpf_map__max_entries(map)) {
 			pr_debug("ERROR: index %d too large\n", idx);
 			return -BPF_LOADER_ERRNO__OBJCONF_MAP_IDX2BIG;
 		}
@@ -1248,21 +1240,21 @@ int bpf__config_obj(struct bpf_object *obj,
 }
=20
 typedef int (*map_config_func_t)(const char *name, int map_fd,
-				 const struct bpf_map_def *pdef,
+				 const struct bpf_map *map,
 				 struct bpf_map_op *op,
 				 void *pkey, void *arg);
=20
 static int
 foreach_key_array_all(map_config_func_t func,
 		      void *arg, const char *name,
-		      int map_fd, const struct bpf_map_def *pdef,
+		      int map_fd, const struct bpf_map *map,
 		      struct bpf_map_op *op)
 {
 	unsigned int i;
 	int err;
=20
-	for (i =3D 0; i < pdef->max_entries; i++) {
-		err =3D func(name, map_fd, pdef, op, &i, arg);
+	for (i =3D 0; i < bpf_map__max_entries(map); i++) {
+		err =3D func(name, map_fd, map, op, &i, arg);
 		if (err) {
 			pr_debug("ERROR: failed to insert value to %s[%u]\n",
 				 name, i);
@@ -1275,7 +1267,7 @@ foreach_key_array_all(map_config_func_t func,
 static int
 foreach_key_array_ranges(map_config_func_t func, void *arg,
 			 const char *name, int map_fd,
-			 const struct bpf_map_def *pdef,
+			 const struct bpf_map *map,
 			 struct bpf_map_op *op)
 {
 	unsigned int i, j;
@@ -1288,7 +1280,7 @@ foreach_key_array_ranges(map_config_func_t func, vo=
id *arg,
 		for (j =3D 0; j < length; j++) {
 			unsigned int idx =3D start + j;
=20
-			err =3D func(name, map_fd, pdef, op, &idx, arg);
+			err =3D func(name, map_fd, map, op, &idx, arg);
 			if (err) {
 				pr_debug("ERROR: failed to insert value to %s[%u]\n",
 					 name, idx);
@@ -1304,7 +1296,7 @@ bpf_map_config_foreach_key(struct bpf_map *map,
 			   map_config_func_t func,
 			   void *arg)
 {
-	int err, map_fd;
+	int err, map_fd, type;
 	struct bpf_map_op *op;
 	const struct bpf_map_def *def;
 	const char *name =3D bpf_map__name(map);
@@ -1330,19 +1322,19 @@ bpf_map_config_foreach_key(struct bpf_map *map,
 		return map_fd;
 	}
=20
+	type =3D bpf_map__type(map);
 	list_for_each_entry(op, &priv->ops_list, list) {
-		switch (def->type) {
+		switch (type) {
 		case BPF_MAP_TYPE_ARRAY:
 		case BPF_MAP_TYPE_PERF_EVENT_ARRAY:
 			switch (op->key_type) {
 			case BPF_MAP_KEY_ALL:
 				err =3D foreach_key_array_all(func, arg, name,
-							    map_fd, def, op);
+						map_fd, map, op);
 				break;
 			case BPF_MAP_KEY_RANGES:
 				err =3D foreach_key_array_ranges(func, arg, name,
-							       map_fd, def,
-							       op);
+						map_fd, map, op);
 				break;
 			default:
 				pr_debug("ERROR: keytype for map '%s' invalid\n",
@@ -1451,7 +1443,7 @@ apply_config_evsel_for_key(const char *name, int ma=
p_fd, void *pkey,
=20
 static int
 apply_obj_config_map_for_key(const char *name, int map_fd,
-			     const struct bpf_map_def *pdef,
+			     const struct bpf_map *map,
 			     struct bpf_map_op *op,
 			     void *pkey, void *arg __maybe_unused)
 {
@@ -1460,7 +1452,7 @@ apply_obj_config_map_for_key(const char *name, int =
map_fd,
 	switch (op->op_type) {
 	case BPF_MAP_OP_SET_VALUE:
 		err =3D apply_config_value_for_key(map_fd, pkey,
-						 pdef->value_size,
+						 bpf_map__value_size(map),
 						 op->v.value);
 		break;
 	case BPF_MAP_OP_SET_EVSEL:
diff --git a/tools/perf/util/bpf_map.c b/tools/perf/util/bpf_map.c
index eb853ca67cf4..c863ae0c5cb5 100644
--- a/tools/perf/util/bpf_map.c
+++ b/tools/perf/util/bpf_map.c
@@ -9,25 +9,25 @@
 #include <stdlib.h>
 #include <unistd.h>
=20
-static bool bpf_map_def__is_per_cpu(const struct bpf_map_def *def)
+static bool bpf_map__is_per_cpu(enum bpf_map_type type)
 {
-	return def->type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
-	       def->type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY ||
-	       def->type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH ||
-	       def->type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE;
+	return type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
+	       type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY ||
+	       type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+	       type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE;
 }
=20
-static void *bpf_map_def__alloc_value(const struct bpf_map_def *def)
+static void *bpf_map__alloc_value(const struct bpf_map *map)
 {
-	if (bpf_map_def__is_per_cpu(def))
-		return malloc(round_up(def->value_size, 8) * sysconf(_SC_NPROCESSORS_C=
ONF));
+	if (bpf_map__is_per_cpu(bpf_map__type(map)))
+		return malloc(round_up(bpf_map__value_size(map), 8) *
+			      sysconf(_SC_NPROCESSORS_CONF));
=20
-	return malloc(def->value_size);
+	return malloc(bpf_map__value_size(map));
 }
=20
 int bpf_map__fprintf(struct bpf_map *map, FILE *fp)
 {
-	const struct bpf_map_def *def =3D bpf_map__def(map);
 	void *prev_key =3D NULL, *key, *value;
 	int fd =3D bpf_map__fd(map), err;
 	int printed =3D 0;
@@ -35,15 +35,15 @@ int bpf_map__fprintf(struct bpf_map *map, FILE *fp)
 	if (fd < 0)
 		return fd;
=20
-	if (IS_ERR(def))
-		return PTR_ERR(def);
+	if (!map)
+		return PTR_ERR(map);
=20
 	err =3D -ENOMEM;
-	key =3D malloc(def->key_size);
+	key =3D malloc(bpf_map__key_size(map));
 	if (key =3D=3D NULL)
 		goto out;
=20
-	value =3D bpf_map_def__alloc_value(def);
+	value =3D bpf_map__alloc_value(map);
 	if (value =3D=3D NULL)
 		goto out_free_key;
=20
--=20
2.30.2

