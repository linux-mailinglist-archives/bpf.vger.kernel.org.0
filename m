Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C205A46F426
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 20:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhLITmv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 9 Dec 2021 14:42:51 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27626 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230027AbhLITmt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Dec 2021 14:42:49 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B9Hkmoq021564
        for <bpf@vger.kernel.org>; Thu, 9 Dec 2021 11:39:15 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cujfxawen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 09 Dec 2021 11:39:15 -0800
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 11:39:14 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 8BDDFC6DAE7E; Thu,  9 Dec 2021 11:39:06 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v3 bpf-next 12/12] bpftool: switch bpf_object__load_xattr() to bpf_object__load()
Date:   Thu, 9 Dec 2021 11:38:40 -0800
Message-ID: <20211209193840.1248570-13-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209193840.1248570-1-andrii@kernel.org>
References: <20211209193840.1248570-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 8xQB1AfvDqbNROiLwv0ygrqzrKWW7j-E
X-Proofpoint-GUID: 8xQB1AfvDqbNROiLwv0ygrqzrKWW7j-E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-09_09,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0 malwarescore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112090101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switch all the uses of to-be-deprecated bpf_object__load_xattr() into
a simple bpf_object__load() calls with optional log_level passed through
open_opts.kernel_log_level, if -d option is specified.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/gen.c        | 11 ++++-------
 tools/bpf/bpftool/prog.c       | 24 ++++++++++--------------
 tools/bpf/bpftool/struct_ops.c | 15 +++++++--------
 3 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 997a2865e04a..b4695df2ea3d 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -486,7 +486,6 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
 
 static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *header_guard)
 {
-	struct bpf_object_load_attr load_attr = {};
 	DECLARE_LIBBPF_OPTS(gen_loader_opts, opts);
 	struct bpf_map *map;
 	char ident[256];
@@ -496,12 +495,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 	if (err)
 		return err;
 
-	load_attr.obj = obj;
-	if (verifier_logs)
-		/* log_level1 + log_level2 + stats, but not stable UAPI */
-		load_attr.log_level = 1 + 2 + 4;
-
-	err = bpf_object__load_xattr(&load_attr);
+	err = bpf_object__load(obj);
 	if (err) {
 		p_err("failed to load object file");
 		goto out;
@@ -719,6 +713,9 @@ static int do_skeleton(int argc, char **argv)
 	if (obj_name[0] == '\0')
 		get_obj_name(obj_name, file);
 	opts.object_name = obj_name;
+	if (verifier_logs)
+		/* log_level1 + log_level2 + stats, but not stable UAPI */
+		opts.kernel_log_level = 1 + 2 + 4;
 	obj = bpf_object__open_mem(obj_data, file_sz, &opts);
 	err = libbpf_get_error(obj);
 	if (err) {
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 45ccc254e69f..f874896c4154 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1464,7 +1464,6 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, open_opts,
 		.relaxed_maps = relaxed_maps,
 	);
-	struct bpf_object_load_attr load_attr = { 0 };
 	enum bpf_attach_type expected_attach_type;
 	struct map_replace *map_replace = NULL;
 	struct bpf_program *prog = NULL, *pos;
@@ -1598,6 +1597,10 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 
 	set_max_rlimit();
 
+	if (verifier_logs)
+		/* log_level1 + log_level2 + stats, but not stable UAPI */
+		open_opts.kernel_log_level = 1 + 2 + 4;
+
 	obj = bpf_object__open_file(file, &open_opts);
 	if (libbpf_get_error(obj)) {
 		p_err("failed to open object file");
@@ -1677,12 +1680,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 		goto err_close_obj;
 	}
 
-	load_attr.obj = obj;
-	if (verifier_logs)
-		/* log_level1 + log_level2 + stats, but not stable UAPI */
-		load_attr.log_level = 1 + 2 + 4;
-
-	err = bpf_object__load_xattr(&load_attr);
+	err = bpf_object__load(obj);
 	if (err) {
 		p_err("failed to load object file");
 		goto err_close_obj;
@@ -1809,7 +1807,6 @@ static int do_loader(int argc, char **argv)
 {
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, open_opts);
 	DECLARE_LIBBPF_OPTS(gen_loader_opts, gen);
-	struct bpf_object_load_attr load_attr = {};
 	struct bpf_object *obj;
 	const char *file;
 	int err = 0;
@@ -1818,6 +1815,10 @@ static int do_loader(int argc, char **argv)
 		return -1;
 	file = GET_ARG();
 
+	if (verifier_logs)
+		/* log_level1 + log_level2 + stats, but not stable UAPI */
+		open_opts.kernel_log_level = 1 + 2 + 4;
+
 	obj = bpf_object__open_file(file, &open_opts);
 	if (libbpf_get_error(obj)) {
 		p_err("failed to open object file");
@@ -1828,12 +1829,7 @@ static int do_loader(int argc, char **argv)
 	if (err)
 		goto err_close_obj;
 
-	load_attr.obj = obj;
-	if (verifier_logs)
-		/* log_level1 + log_level2 + stats, but not stable UAPI */
-		load_attr.log_level = 1 + 2 + 4;
-
-	err = bpf_object__load_xattr(&load_attr);
+	err = bpf_object__load(obj);
 	if (err) {
 		p_err("failed to load object file");
 		goto err_close_obj;
diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
index cbdca37a53f0..2f693b082bdb 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -479,7 +479,7 @@ static int do_unregister(int argc, char **argv)
 
 static int do_register(int argc, char **argv)
 {
-	struct bpf_object_load_attr load_attr = {};
+	LIBBPF_OPTS(bpf_object_open_opts, open_opts);
 	const struct bpf_map_def *def;
 	struct bpf_map_info info = {};
 	__u32 info_len = sizeof(info);
@@ -494,18 +494,17 @@ static int do_register(int argc, char **argv)
 
 	file = GET_ARG();
 
-	obj = bpf_object__open(file);
+	if (verifier_logs)
+		/* log_level1 + log_level2 + stats, but not stable UAPI */
+		open_opts.kernel_log_level = 1 + 2 + 4;
+
+	obj = bpf_object__open_file(file, &open_opts);
 	if (libbpf_get_error(obj))
 		return -1;
 
 	set_max_rlimit();
 
-	load_attr.obj = obj;
-	if (verifier_logs)
-		/* log_level1 + log_level2 + stats, but not stable UAPI */
-		load_attr.log_level = 1 + 2 + 4;
-
-	if (bpf_object__load_xattr(&load_attr)) {
+	if (bpf_object__load(obj)) {
 		bpf_object__close(obj);
 		return -1;
 	}
-- 
2.30.2

