Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3A9435868
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 03:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhJUBqo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 20 Oct 2021 21:46:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21032 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230326AbhJUBqo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Oct 2021 21:46:44 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KN9rCn030738
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 18:44:29 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3btn2yvjnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 18:44:29 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 20 Oct 2021 18:44:28 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 046716E3E191; Wed, 20 Oct 2021 18:44:22 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 bpf-next 05/10] bpftool: support multiple .rodata/.data internal maps in skeleton
Date:   Wed, 20 Oct 2021 18:43:59 -0700
Message-ID: <20211021014404.2635234-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021014404.2635234-1-andrii@kernel.org>
References: <20211021014404.2635234-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: ajedodzYQvmEUSrktf99HaLxl3V1T_tx
X-Proofpoint-ORIG-GUID: ajedodzYQvmEUSrktf99HaLxl3V1T_tx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_06,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210008
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove the assumption about only single instance of each of .rodata and
.data internal maps. Nothing changes for '.rodata' and '.data' maps, but new
'.rodata.something' map will get 'rodata_something' section in BPF
skeleton for them (as well as having struct bpf_map * field in maps
section with the same field name).

Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/gen.c | 107 ++++++++++++++++++++++------------------
 1 file changed, 60 insertions(+), 47 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index b2ffc18eafc1..59afe9a2ca3c 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -33,6 +33,11 @@ static void sanitize_identifier(char *name)
 			name[i] = '_';
 }
 
+static bool str_has_prefix(const char *str, const char *prefix)
+{
+	return strncmp(str, prefix, strlen(prefix)) == 0;
+}
+
 static bool str_has_suffix(const char *str, const char *suffix)
 {
 	size_t i, n1 = strlen(str), n2 = strlen(suffix);
@@ -67,23 +72,47 @@ static void get_header_guard(char *guard, const char *obj_name)
 		guard[i] = toupper(guard[i]);
 }
 
-static const char *get_map_ident(const struct bpf_map *map)
+static bool get_map_ident(const struct bpf_map *map, char *buf, size_t buf_sz)
 {
+	static const char *sfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
 	const char *name = bpf_map__name(map);
+	int i, n;
+
+	if (!bpf_map__is_internal(map)) {
+		snprintf(buf, buf_sz, "%s", name);
+		return true;
+	}
+
+	for  (i = 0, n = ARRAY_SIZE(sfxs); i < n; i++) {
+		const char *sfx = sfxs[i], *p;
+
+		p = strstr(name, sfx);
+		if (p) {
+			snprintf(buf, buf_sz, "%s", p + 1);
+			sanitize_identifier(buf);
+			return true;
+		}
+	}
 
-	if (!bpf_map__is_internal(map))
-		return name;
-
-	if (str_has_suffix(name, ".data"))
-		return "data";
-	else if (str_has_suffix(name, ".rodata"))
-		return "rodata";
-	else if (str_has_suffix(name, ".bss"))
-		return "bss";
-	else if (str_has_suffix(name, ".kconfig"))
-		return "kconfig";
-	else
-		return NULL;
+	return false;
+}
+
+static bool get_datasec_ident(const char *sec_name, char *buf, size_t buf_sz)
+{
+	static const char *pfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
+	int i, n;
+
+	for  (i = 0, n = ARRAY_SIZE(pfxs); i < n; i++) {
+		const char *pfx = pfxs[i];
+
+		if (str_has_prefix(sec_name, pfx)) {
+			snprintf(buf, buf_sz, "%s", sec_name + 1);
+			sanitize_identifier(buf);
+			return true;
+		}
+	}
+
+	return false;
 }
 
 static void codegen_btf_dump_printf(void *ctx, const char *fmt, va_list args)
@@ -100,24 +129,14 @@ static int codegen_datasec_def(struct bpf_object *obj,
 	const char *sec_name = btf__name_by_offset(btf, sec->name_off);
 	const struct btf_var_secinfo *sec_var = btf_var_secinfos(sec);
 	int i, err, off = 0, pad_cnt = 0, vlen = btf_vlen(sec);
-	const char *sec_ident;
-	char var_ident[256];
+	char var_ident[256], sec_ident[256];
 	bool strip_mods = false;
 
-	if (strcmp(sec_name, ".data") == 0) {
-		sec_ident = "data";
-		strip_mods = true;
-	} else if (strcmp(sec_name, ".bss") == 0) {
-		sec_ident = "bss";
-		strip_mods = true;
-	} else if (strcmp(sec_name, ".rodata") == 0) {
-		sec_ident = "rodata";
-		strip_mods = true;
-	} else if (strcmp(sec_name, ".kconfig") == 0) {
-		sec_ident = "kconfig";
-	} else {
+	if (!get_datasec_ident(sec_name, sec_ident, sizeof(sec_ident)))
 		return 0;
-	}
+
+	if (strcmp(sec_name, ".kconfig") != 0)
+		strip_mods = true;
 
 	printf("	struct %s__%s {\n", obj_name, sec_ident);
 	for (i = 0; i < vlen; i++, sec_var++) {
@@ -385,6 +404,7 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
 {
 	struct bpf_program *prog;
 	struct bpf_map *map;
+	char ident[256];
 
 	codegen("\
 		\n\
@@ -405,10 +425,7 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
 	}
 
 	bpf_object__for_each_map(map, obj) {
-		const char *ident;
-
-		ident = get_map_ident(map);
-		if (!ident)
+		if (!get_map_ident(map, ident, sizeof(ident)))
 			continue;
 		if (bpf_map__is_internal(map) &&
 		    (bpf_map__def(map)->map_flags & BPF_F_MMAPABLE))
@@ -432,6 +449,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 	struct bpf_object_load_attr load_attr = {};
 	DECLARE_LIBBPF_OPTS(gen_loader_opts, opts);
 	struct bpf_map *map;
+	char ident[256];
 	int err = 0;
 
 	err = bpf_object__gen_loader(obj, &opts);
@@ -477,12 +495,10 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		",
 		obj_name, opts.data_sz);
 	bpf_object__for_each_map(map, obj) {
-		const char *ident;
 		const void *mmap_data = NULL;
 		size_t mmap_size = 0;
 
-		ident = get_map_ident(map);
-		if (!ident)
+		if (!get_map_ident(map, ident, sizeof(ident)))
 			continue;
 
 		if (!bpf_map__is_internal(map) ||
@@ -544,15 +560,15 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 				return err;				    \n\
 		", obj_name);
 	bpf_object__for_each_map(map, obj) {
-		const char *ident, *mmap_flags;
+		const char *mmap_flags;
 
-		ident = get_map_ident(map);
-		if (!ident)
+		if (!get_map_ident(map, ident, sizeof(ident)))
 			continue;
 
 		if (!bpf_map__is_internal(map) ||
 		    !(bpf_map__def(map)->map_flags & BPF_F_MMAPABLE))
 			continue;
+
 		if (bpf_map__def(map)->map_flags & BPF_F_RDONLY_PROG)
 			mmap_flags = "PROT_READ";
 		else
@@ -602,7 +618,8 @@ static int do_skeleton(int argc, char **argv)
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
 	char obj_name[MAX_OBJ_NAME_LEN] = "", *obj_data;
 	struct bpf_object *obj = NULL;
-	const char *file, *ident;
+	const char *file;
+	char ident[256];
 	struct bpf_program *prog;
 	int fd, err = -1;
 	struct bpf_map *map;
@@ -673,8 +690,7 @@ static int do_skeleton(int argc, char **argv)
 	}
 
 	bpf_object__for_each_map(map, obj) {
-		ident = get_map_ident(map);
-		if (!ident) {
+		if (!get_map_ident(map, ident, sizeof(ident))) {
 			p_err("ignoring unrecognized internal map '%s'...",
 			      bpf_map__name(map));
 			continue;
@@ -727,8 +743,7 @@ static int do_skeleton(int argc, char **argv)
 	if (map_cnt) {
 		printf("\tstruct {\n");
 		bpf_object__for_each_map(map, obj) {
-			ident = get_map_ident(map);
-			if (!ident)
+			if (!get_map_ident(map, ident, sizeof(ident)))
 				continue;
 			if (use_loader)
 				printf("\t\tstruct bpf_map_desc %s;\n", ident);
@@ -897,9 +912,7 @@ static int do_skeleton(int argc, char **argv)
 		);
 		i = 0;
 		bpf_object__for_each_map(map, obj) {
-			ident = get_map_ident(map);
-
-			if (!ident)
+			if (!get_map_ident(map, ident, sizeof(ident)))
 				continue;
 
 			codegen("\
-- 
2.30.2

