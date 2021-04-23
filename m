Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B56369A7A
	for <lists+bpf@lfdr.de>; Fri, 23 Apr 2021 20:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243730AbhDWSyu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 23 Apr 2021 14:54:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16952 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243621AbhDWSyt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 23 Apr 2021 14:54:49 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13NIQUQ1014863
        for <bpf@vger.kernel.org>; Fri, 23 Apr 2021 11:54:12 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 383an28dwy-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 23 Apr 2021 11:54:12 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 11:54:11 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 690692ED5CA8; Fri, 23 Apr 2021 11:54:07 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 4/6] bpftool: handle transformed static map names in BPF skeleton
Date:   Fri, 23 Apr 2021 11:53:55 -0700
Message-ID: <20210423185357.1992756-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423185357.1992756-1-andrii@kernel.org>
References: <20210423185357.1992756-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9oI9hkpiWiFIVgYCMeryu8Y5f4FG-ZRX
X-Proofpoint-GUID: 9oI9hkpiWiFIVgYCMeryu8Y5f4FG-ZRX
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-23_07:2021-04-23,2021-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104230121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Static maps will be renamed according to the same rules as global variables
(<obj_name>..<map_name>) during static linking. This breaks current BPF
skeleton logic that uses normal non-internal maps' names as is. Instead, do
the same map identifier sanitization as is done for global variables, turning
static maps into <obj_name>__<map_name> fields in BPF skeleton. Their original
names with '..' separator are preserved by libbpf and submitted as is into the
kernel. As well as they can be looked up using their unsanitized name with
using bpf_object__find_map_by_name() API.

There are no breaking changes concerns, similarly to static variable renames,
because this renaming happens only during static linking. Plus static maps
never really worked and thus were never used in practice.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/gen.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 06fee4a2910a..72cfe738b0a2 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -23,6 +23,7 @@
 #include "main.h"
 
 #define MAX_OBJ_NAME_LEN 64
+#define MAX_MAP_NAME_LEN (2 * MAX_OBJ_NAME_LEN + 1)
 
 static void sanitize_identifier(char *name)
 {
@@ -67,23 +68,29 @@ static void get_header_guard(char *guard, const char *obj_name)
 		guard[i] = toupper(guard[i]);
 }
 
-static const char *get_map_ident(const struct bpf_map *map)
+static const char *get_map_ident(char *name, const struct bpf_map *map)
 {
-	const char *name = bpf_map__name(map);
+	const char *orig_name = bpf_map__name(map);
 
-	if (!bpf_map__is_internal(map))
+	if (!bpf_map__is_internal(map)) {
+		strncpy(name, orig_name, MAX_MAP_NAME_LEN);
+		name[MAX_MAP_NAME_LEN - 1] = '\0';
+		sanitize_identifier(name);
 		return name;
+	}
 
-	if (str_has_suffix(name, ".data"))
-		return "data";
-	else if (str_has_suffix(name, ".rodata"))
-		return "rodata";
-	else if (str_has_suffix(name, ".bss"))
-		return "bss";
-	else if (str_has_suffix(name, ".kconfig"))
-		return "kconfig";
+	if (str_has_suffix(orig_name, ".data"))
+		strcpy(name, "data");
+	else if (str_has_suffix(orig_name, ".rodata"))
+		strcpy(name, "rodata");
+	else if (str_has_suffix(orig_name, ".bss"))
+		strcpy(name, "bss");
+	else if (str_has_suffix(orig_name, ".kconfig"))
+		strcpy(name, "kconfig");
 	else
 		return NULL;
+
+	return name;
 }
 
 static void codegen_btf_dump_printf(void *ctx, const char *fmt, va_list args)
@@ -273,6 +280,7 @@ static void codegen(const char *template, ...)
 static int do_skeleton(int argc, char **argv)
 {
 	char header_guard[MAX_OBJ_NAME_LEN + sizeof("__SKEL_H__")];
+	char map_ident[MAX_MAP_NAME_LEN];
 	size_t i, map_cnt = 0, prog_cnt = 0, file_sz, mmap_sz;
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
 	char obj_name[MAX_OBJ_NAME_LEN] = "", *obj_data;
@@ -348,7 +356,7 @@ static int do_skeleton(int argc, char **argv)
 	}
 
 	bpf_object__for_each_map(map, obj) {
-		ident = get_map_ident(map);
+		ident = get_map_ident(map_ident, map);
 		if (!ident) {
 			p_err("ignoring unrecognized internal map '%s'...",
 			      bpf_map__name(map));
@@ -382,7 +390,7 @@ static int do_skeleton(int argc, char **argv)
 	if (map_cnt) {
 		printf("\tstruct {\n");
 		bpf_object__for_each_map(map, obj) {
-			ident = get_map_ident(map);
+			ident = get_map_ident(map_ident, map);
 			if (!ident)
 				continue;
 			printf("\t\tstruct bpf_map *%s;\n", ident);
@@ -524,7 +532,7 @@ static int do_skeleton(int argc, char **argv)
 		);
 		i = 0;
 		bpf_object__for_each_map(map, obj) {
-			ident = get_map_ident(map);
+			ident = get_map_ident(map_ident, map);
 
 			if (!ident)
 				continue;
-- 
2.30.2

