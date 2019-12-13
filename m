Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C63611EDCC
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2019 23:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfLMWcX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Dec 2019 17:32:23 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20258 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbfLMWcW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 13 Dec 2019 17:32:22 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBDMVQMb025669
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2019 14:32:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=9TuvFlVSh/MEviEKUem9gXwewdcgbhb6xSu8YH4t42A=;
 b=qiD10Fhto70PQIKe6H8pcbLfUlDRWqRDIG/SWPEFHtiJlZBU9iZOffkhAH0MhUY/H7qj
 vwpMAwnGVHZE8+M+0unp2dSHuiqFmvAFWwEW37ARyFCdMn49KLrW9dmT3NrUC0j4k4lq
 F3PYyiaGyCSrr27fhJDjBn9/RRZVBTjIEic= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wusrmxwcn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2019 14:32:21 -0800
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 13 Dec 2019 14:32:19 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id DE1422EC1C8E; Fri, 13 Dec 2019 14:32:18 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next 01/17] libbpf: don't require root for bpf_object__open()
Date:   Fri, 13 Dec 2019 14:31:58 -0800
Message-ID: <20191213223214.2791885-2-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191213223214.2791885-1-andriin@fb.com>
References: <20191213223214.2791885-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_08:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 suspectscore=25 impostorscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912130159
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Reorganize bpf_object__open and bpf_object__load steps such that
bpf_object__open doesn't need root access. This was previously done for
feature probing and BTF sanitization. This doesn't have to happen on open,
though, so move all those steps into the load phase.

This is important, because it makes it possible for tools like bpftool, to
just open BPF object file and inspect their contents: programs, maps, BTF,
etc. For such operations it is prohibitive to require root access. On the
other hand, there is a lot of custom libbpf logic in those steps, so its best
avoided for tools to reimplement all that on their own.

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 83 +++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 42 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 27d5f7ecba32..dc993112b40b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -101,13 +101,6 @@ void libbpf_print(enum libbpf_print_level level, const char *format, ...)
 
 #define STRERR_BUFSIZE  128
 
-#define CHECK_ERR(action, err, out) do {	\
-	err = action;			\
-	if (err)			\
-		goto out;		\
-} while (0)
-
-
 /* Copied from tools/perf/util/util.h */
 #ifndef zfree
 # define zfree(ptr) ({ free(*ptr); *ptr = NULL; })
@@ -864,8 +857,7 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	def->value_size = data->d_size;
 	def->max_entries = 1;
 	def->map_flags = type == LIBBPF_MAP_RODATA ? BPF_F_RDONLY_PROG : 0;
-	if (obj->caps.array_mmap)
-		def->map_flags |= BPF_F_MMAPABLE;
+	def->map_flags |= BPF_F_MMAPABLE;
 
 	pr_debug("map '%s' (global data): at sec_idx %d, offset %zu, flags %x.\n",
 		 map_name, map->sec_idx, map->sec_offset, def->map_flags);
@@ -888,8 +880,6 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
 {
 	int err;
 
-	if (!obj->caps.global_data)
-		return 0;
 	/*
 	 * Populate obj->maps with libbpf internal maps.
 	 */
@@ -1393,10 +1383,11 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 	return 0;
 }
 
-static int bpf_object__init_maps(struct bpf_object *obj, bool relaxed_maps,
-				 const char *pin_root_path)
+static int bpf_object__init_maps(struct bpf_object *obj,
+				 struct bpf_object_open_opts *opts)
 {
-	bool strict = !relaxed_maps;
+	const char *pin_root_path = OPTS_GET(opts, pin_root_path, NULL);
+	bool strict = !OPTS_GET(opts, relaxed_maps, false);
 	int err;
 
 	err = bpf_object__init_user_maps(obj, strict);
@@ -1592,8 +1583,7 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 	return 0;
 }
 
-static int bpf_object__elf_collect(struct bpf_object *obj, bool relaxed_maps,
-				   const char *pin_root_path)
+static int bpf_object__elf_collect(struct bpf_object *obj)
 {
 	Elf *elf = obj->efile.elf;
 	GElf_Ehdr *ep = &obj->efile.ehdr;
@@ -1728,14 +1718,7 @@ static int bpf_object__elf_collect(struct bpf_object *obj, bool relaxed_maps,
 		pr_warn("Corrupted ELF file: index of strtab invalid\n");
 		return -LIBBPF_ERRNO__FORMAT;
 	}
-	err = bpf_object__init_btf(obj, btf_data, btf_ext_data);
-	if (!err)
-		err = bpf_object__init_maps(obj, relaxed_maps, pin_root_path);
-	if (!err)
-		err = bpf_object__sanitize_and_load_btf(obj);
-	if (!err)
-		err = bpf_object__init_prog_names(obj);
-	return err;
+	return bpf_object__init_btf(obj, btf_data, btf_ext_data);
 }
 
 static struct bpf_program *
@@ -1876,11 +1859,6 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 		pr_warn("bad data relo against section %u\n", shdr_idx);
 		return -LIBBPF_ERRNO__RELOC;
 	}
-	if (!obj->caps.global_data) {
-		pr_warn("relocation: kernel does not support global \'%s\' variable access in insns[%d]\n",
-			name, insn_idx);
-		return -LIBBPF_ERRNO__RELOC;
-	}
 	for (map_idx = 0; map_idx < nr_maps; map_idx++) {
 		map = &obj->maps[map_idx];
 		if (map->libbpf_type != type)
@@ -3918,12 +3896,10 @@ static struct bpf_object *
 __bpf_object__open(const char *path, const void *obj_buf, size_t obj_buf_sz,
 		   struct bpf_object_open_opts *opts)
 {
-	const char *pin_root_path;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
 	const char *obj_name;
 	char tmp_name[64];
-	bool relaxed_maps;
 	__u32 attach_prog_fd;
 	int err;
 
@@ -3953,16 +3929,16 @@ __bpf_object__open(const char *path, const void *obj_buf, size_t obj_buf_sz,
 		return obj;
 
 	obj->relaxed_core_relocs = OPTS_GET(opts, relaxed_core_relocs, false);
-	relaxed_maps = OPTS_GET(opts, relaxed_maps, false);
-	pin_root_path = OPTS_GET(opts, pin_root_path, NULL);
 	attach_prog_fd = OPTS_GET(opts, attach_prog_fd, 0);
 
-	CHECK_ERR(bpf_object__elf_init(obj), err, out);
-	CHECK_ERR(bpf_object__check_endianness(obj), err, out);
-	CHECK_ERR(bpf_object__probe_caps(obj), err, out);
-	CHECK_ERR(bpf_object__elf_collect(obj, relaxed_maps, pin_root_path),
-		  err, out);
-	CHECK_ERR(bpf_object__collect_reloc(obj), err, out);
+	err = bpf_object__elf_init(obj);
+	err = err ? : bpf_object__check_endianness(obj);
+	err = err ? : bpf_object__elf_collect(obj);
+	err = err ? : bpf_object__init_maps(obj, opts);
+	err = err ? : bpf_object__init_prog_names(obj);
+	err = err ? : bpf_object__collect_reloc(obj);
+	if (err)
+		goto out;
 	bpf_object__elf_finish(obj);
 
 	bpf_object__for_each_program(prog, obj) {
@@ -4080,6 +4056,24 @@ int bpf_object__unload(struct bpf_object *obj)
 	return 0;
 }
 
+static int bpf_object__sanitize_maps(struct bpf_object *obj)
+{
+	struct bpf_map *m;
+
+	bpf_object__for_each_map(m, obj) {
+		if (!bpf_map__is_internal(m))
+			continue;
+		if (!obj->caps.global_data) {
+			pr_warn("kernel doesn't support global data\n");
+			return -ENOTSUP;
+		}
+		if (!obj->caps.array_mmap)
+			m->def.map_flags ^= BPF_F_MMAPABLE;
+	}
+
+	return 0;
+}
+
 int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 {
 	struct bpf_object *obj;
@@ -4098,9 +4092,14 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 
 	obj->loaded = true;
 
-	CHECK_ERR(bpf_object__create_maps(obj), err, out);
-	CHECK_ERR(bpf_object__relocate(obj, attr->target_btf_path), err, out);
-	CHECK_ERR(bpf_object__load_progs(obj, attr->log_level), err, out);
+	err = bpf_object__probe_caps(obj);
+	err = err ? : bpf_object__sanitize_and_load_btf(obj);
+	err = err ? : bpf_object__sanitize_maps(obj);
+	err = err ? : bpf_object__create_maps(obj);
+	err = err ? : bpf_object__relocate(obj, attr->target_btf_path);
+	err = err ? : bpf_object__load_progs(obj, attr->log_level);
+	if (err)
+		goto out;
 
 	return 0;
 out:
-- 
2.17.1

