Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADD5435869
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 03:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhJUBqr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 20 Oct 2021 21:46:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16218 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230326AbhJUBqp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Oct 2021 21:46:45 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KNAbSf016206
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 18:44:30 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3btct0yyps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 18:44:30 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 20 Oct 2021 18:44:30 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 2010C6E3E1A0; Wed, 20 Oct 2021 18:44:27 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 bpf-next 07/10] libbpf: support multiple .rodata.* and .data.* BPF maps
Date:   Wed, 20 Oct 2021 18:44:01 -0700
Message-ID: <20211021014404.2635234-8-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021014404.2635234-1-andrii@kernel.org>
References: <20211021014404.2635234-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: s8wlJQb0DIOxONbBxx1Fr60LVHpk7z_S
X-Proofpoint-ORIG-GUID: s8wlJQb0DIOxONbBxx1Fr60LVHpk7z_S
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_06,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210008
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support for having multiple .rodata and .data data sections ([0]).
.rodata/.data are supported like the usual, but now also
.rodata.<whatever> and .data.<whatever> are also supported. Each such
section will get its own backing BPF_MAP_TYPE_ARRAY, just like
.rodata and .data.

Multiple .bss maps are not supported, as the whole '.bss' name is
confusing and might be deprecated soon, as well as user would need to
specify custom ELF section with SEC() attribute anyway, so might as well
stick to just .data.* and .rodata.* convention.

User-visible map name for such new maps is going to be just their ELF
section names.

  [0] https://github.com/libbpf/libbpf/issues/274

Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 130 ++++++++++++++++++++++++++++++++---------
 1 file changed, 101 insertions(+), 29 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a7320d272b34..031f4611e0ff 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -370,15 +370,14 @@ enum libbpf_map_type {
 	LIBBPF_MAP_KCONFIG,
 };
 
-static const char * const libbpf_type_to_btf_name[] = {
-	[LIBBPF_MAP_DATA]	= DATA_SEC,
-	[LIBBPF_MAP_BSS]	= BSS_SEC,
-	[LIBBPF_MAP_RODATA]	= RODATA_SEC,
-	[LIBBPF_MAP_KCONFIG]	= KCONFIG_SEC,
-};
-
 struct bpf_map {
 	char *name;
+	/* real_name is defined for special internal maps (.rodata*,
+	 * .data*, .bss, .kconfig) and preserves their original ELF section
+	 * name. This is important to be be able to find corresponding BTF
+	 * DATASEC information.
+	 */
+	char *real_name;
 	int fd;
 	int sec_idx;
 	size_t sec_offset;
@@ -1429,17 +1428,55 @@ static size_t bpf_map_mmap_sz(const struct bpf_map *map)
 	return map_sz;
 }
 
-static char *internal_map_name(struct bpf_object *obj,
-			       enum libbpf_map_type type)
+static char *internal_map_name(struct bpf_object *obj, const char *real_name)
 {
 	char map_name[BPF_OBJ_NAME_LEN], *p;
-	const char *sfx = libbpf_type_to_btf_name[type];
-	int sfx_len = max((size_t)7, strlen(sfx));
-	int pfx_len = min((size_t)BPF_OBJ_NAME_LEN - sfx_len - 1,
-			  strlen(obj->name));
+	int pfx_len, sfx_len = max((size_t)7, strlen(real_name));
+
+	/* This is one of the more confusing parts of libbpf for various
+	 * reasons, some of which are historical. The original idea for naming
+	 * internal names was to include as much of BPF object name prefix as
+	 * possible, so that it can be distinguished from similar internal
+	 * maps of a different BPF object.
+	 * As an example, let's say we have bpf_object named 'my_object_name'
+	 * and internal map corresponding to '.rodata' ELF section. The final
+	 * map name advertised to user and to the kernel will be
+	 * 'my_objec.rodata', taking first 8 characters of object name and
+	 * entire 7 characters of '.rodata'.
+	 * Somewhat confusingly, if internal map ELF section name is shorter
+	 * than 7 characters, e.g., '.bss', we still reserve 7 characters
+	 * for the suffix, even though we only have 4 actual characters, and
+	 * resulting map will be called 'my_objec.bss', not even using all 15
+	 * characters allowed by the kernel. Oh well, at least the truncated
+	 * object name is somewhat consistent in this case. But if the map
+	 * name is '.kconfig', we'll still have entirety of '.kconfig' added
+	 * (8 chars) and thus will be left with only first 7 characters of the
+	 * object name ('my_obje'). Happy guessing, user, that the final map
+	 * name will be "my_obje.kconfig".
+	 * Now, with libbpf starting to support arbitrarily named .rodata.*
+	 * and .data.* data sections, it's possible that ELF section name is
+	 * longer than allowed 15 chars, so we now need to be careful to take
+	 * only up to 15 first characters of ELF name, taking no BPF object
+	 * name characters at all. So '.rodata.abracadabra' will result in
+	 * '.rodata.abracad' kernel and user-visible name.
+	 * We need to keep this convoluted logic intact for .data, .bss and
+	 * .rodata maps, but for new custom .data.custom and .rodata.custom
+	 * maps we use their ELF names as is, not prepending bpf_object name
+	 * in front. We still need to truncate them to 15 characters for the
+	 * kernel. Full name can be recovered for such maps by using DATASEC
+	 * BTF type associated with such map's value type, though.
+	 */
+	if (sfx_len >= BPF_OBJ_NAME_LEN)
+		sfx_len = BPF_OBJ_NAME_LEN - 1;
+
+	/* if there are two or more dots in map name, it's a custom dot map */
+	if (strchr(real_name + 1, '.') != NULL)
+		pfx_len = 0;
+	else
+		pfx_len = min((size_t)BPF_OBJ_NAME_LEN - sfx_len - 1, strlen(obj->name));
 
 	snprintf(map_name, sizeof(map_name), "%.*s%.*s", pfx_len, obj->name,
-		 sfx_len, libbpf_type_to_btf_name[type]);
+		 sfx_len, real_name);
 
 	/* sanitise map name to characters allowed by kernel */
 	for (p = map_name; *p && p < map_name + sizeof(map_name); p++)
@@ -1451,7 +1488,7 @@ static char *internal_map_name(struct bpf_object *obj,
 
 static int
 bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
-			      int sec_idx, void *data, size_t data_sz)
+			      const char *real_name, int sec_idx, void *data, size_t data_sz)
 {
 	struct bpf_map_def *def;
 	struct bpf_map *map;
@@ -1464,9 +1501,11 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	map->libbpf_type = type;
 	map->sec_idx = sec_idx;
 	map->sec_offset = 0;
-	map->name = internal_map_name(obj, type);
-	if (!map->name) {
-		pr_warn("failed to alloc map name\n");
+	map->real_name = strdup(real_name);
+	map->name = internal_map_name(obj, real_name);
+	if (!map->real_name || !map->name) {
+		zfree(&map->real_name);
+		zfree(&map->name);
 		return -ENOMEM;
 	}
 
@@ -1489,6 +1528,7 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 		map->mmaped = NULL;
 		pr_warn("failed to alloc map '%s' content buffer: %d\n",
 			map->name, err);
+		zfree(&map->real_name);
 		zfree(&map->name);
 		return err;
 	}
@@ -1503,6 +1543,7 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 static int bpf_object__init_global_data_maps(struct bpf_object *obj)
 {
 	struct elf_sec_desc *sec_desc;
+	const char *sec_name;
 	int err = 0, sec_idx;
 
 	/*
@@ -1513,21 +1554,24 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
 
 		switch (sec_desc->sec_type) {
 		case SEC_DATA:
+			sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
 			err = bpf_object__init_internal_map(obj, LIBBPF_MAP_DATA,
-							    sec_idx,
+							    sec_name, sec_idx,
 							    sec_desc->data->d_buf,
 							    sec_desc->data->d_size);
 			break;
 		case SEC_RODATA:
 			obj->has_rodata = true;
+			sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
 			err = bpf_object__init_internal_map(obj, LIBBPF_MAP_RODATA,
-							    sec_idx,
+							    sec_name, sec_idx,
 							    sec_desc->data->d_buf,
 							    sec_desc->data->d_size);
 			break;
 		case SEC_BSS:
+			sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
 			err = bpf_object__init_internal_map(obj, LIBBPF_MAP_BSS,
-							    sec_idx,
+							    sec_name, sec_idx,
 							    NULL,
 							    sec_desc->data->d_size);
 			break;
@@ -1831,7 +1875,7 @@ static int bpf_object__init_kconfig_map(struct bpf_object *obj)
 
 	map_sz = last_ext->kcfg.data_off + last_ext->kcfg.sz;
 	err = bpf_object__init_internal_map(obj, LIBBPF_MAP_KCONFIG,
-					    obj->efile.symbols_shndx,
+					    ".kconfig", obj->efile.symbols_shndx,
 					    NULL, map_sz);
 	if (err)
 		return err;
@@ -1931,7 +1975,7 @@ static int bpf_object__init_user_maps(struct bpf_object *obj, bool strict)
 
 		map->name = strdup(map_name);
 		if (!map->name) {
-			pr_warn("failed to alloc map name\n");
+			pr_warn("map '%s': failed to alloc map name\n", map_name);
 			return -ENOMEM;
 		}
 		pr_debug("map %d is \"%s\"\n", i, map->name);
@@ -3216,11 +3260,13 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 				err = bpf_object__add_programs(obj, data, name, idx);
 				if (err)
 					return err;
-			} else if (strcmp(name, DATA_SEC) == 0) {
+			} else if (strcmp(name, DATA_SEC) == 0 ||
+				   str_has_pfx(name, DATA_SEC ".")) {
 				sec_desc->sec_type = SEC_DATA;
 				sec_desc->shdr = sh;
 				sec_desc->data = data;
-			} else if (strcmp(name, RODATA_SEC) == 0) {
+			} else if (strcmp(name, RODATA_SEC) == 0 ||
+				   str_has_pfx(name, RODATA_SEC ".")) {
 				sec_desc->sec_type = SEC_RODATA;
 				sec_desc->shdr = sh;
 				sec_desc->data = data;
@@ -4060,8 +4106,7 @@ static int bpf_map_find_btf_info(struct bpf_object *obj, struct bpf_map *map)
 		 * LLVM annotates global data differently in BTF, that is,
 		 * only as '.data', '.bss' or '.rodata'.
 		 */
-		ret = btf__find_by_name(obj->btf,
-				libbpf_type_to_btf_name[map->libbpf_type]);
+		ret = btf__find_by_name(obj->btf, map->real_name);
 	}
 	if (ret < 0)
 		return ret;
@@ -7831,6 +7876,7 @@ static void bpf_map__destroy(struct bpf_map *map)
 	}
 
 	zfree(&map->name);
+	zfree(&map->real_name);
 	zfree(&map->pin_path);
 
 	if (map->fd >= 0)
@@ -8755,9 +8801,30 @@ const struct bpf_map_def *bpf_map__def(const struct bpf_map *map)
 	return map ? &map->def : libbpf_err_ptr(-EINVAL);
 }
 
+static bool map_uses_real_name(const struct bpf_map *map)
+{
+	/* Since libbpf started to support custom .data.* and .rodata.* maps,
+	 * their user-visible name differs from kernel-visible name. Users see
+	 * such map's corresponding ELF section name as a map name.
+	 * This check distinguishes .data/.rodata from .data.* and .rodata.*
+	 * maps to know which name has to be returned to the user.
+	 */
+	if (map->libbpf_type == LIBBPF_MAP_DATA && strcmp(map->real_name, DATA_SEC) != 0)
+		return true;
+	if (map->libbpf_type == LIBBPF_MAP_RODATA && strcmp(map->real_name, RODATA_SEC) != 0)
+		return true;
+	return false;
+}
+
 const char *bpf_map__name(const struct bpf_map *map)
 {
-	return map ? map->name : NULL;
+	if (!map)
+		return NULL;
+
+	if (map_uses_real_name(map))
+		return map->real_name;
+
+	return map->name;
 }
 
 enum bpf_map_type bpf_map__type(const struct bpf_map *map)
@@ -8976,7 +9043,12 @@ bpf_object__find_map_by_name(const struct bpf_object *obj, const char *name)
 	struct bpf_map *pos;
 
 	bpf_object__for_each_map(pos, obj) {
-		if (pos->name && !strcmp(pos->name, name))
+		if (map_uses_real_name(pos)) {
+			if (strcmp(pos->real_name, name) == 0)
+				return pos;
+			continue;
+		}
+		if (strcmp(pos->name, name) == 0)
 			return pos;
 	}
 	return errno = ENOENT, NULL;
-- 
2.30.2

