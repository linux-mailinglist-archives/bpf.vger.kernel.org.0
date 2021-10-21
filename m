Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92100435865
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 03:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhJUBqc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 20 Oct 2021 21:46:32 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55756 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230299AbhJUBqc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Oct 2021 21:46:32 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KNASON027829
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 18:44:17 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3btk7mnhg6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 18:44:17 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 20 Oct 2021 18:44:15 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id BDBC06E3E142; Wed, 20 Oct 2021 18:44:14 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 bpf-next 02/10] libbpf: extract ELF processing state into separate struct
Date:   Wed, 20 Oct 2021 18:43:56 -0700
Message-ID: <20211021014404.2635234-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021014404.2635234-1-andrii@kernel.org>
References: <20211021014404.2635234-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 1DHBV6r7ZWB887rKLIekFvQWZ0WROlAS
X-Proofpoint-ORIG-GUID: 1DHBV6r7ZWB887rKLIekFvQWZ0WROlAS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_06,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 clxscore=1034 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210008
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Name currently anonymous internal struct that keeps ELF-related state
for bpf_object. Just a bit of clean up, no functional changes.

Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 70 ++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 36 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fdc25a112150..84a0683d214b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -462,6 +462,35 @@ struct module_btf {
 	int fd_array_idx;
 };
 
+struct elf_state {
+	int fd;
+	const void *obj_buf;
+	size_t obj_buf_sz;
+	Elf *elf;
+	GElf_Ehdr ehdr;
+	Elf_Data *symbols;
+	Elf_Data *data;
+	Elf_Data *rodata;
+	Elf_Data *bss;
+	Elf_Data *st_ops_data;
+	size_t shstrndx; /* section index for section name strings */
+	size_t strtabidx;
+	struct {
+		GElf_Shdr shdr;
+		Elf_Data *data;
+	} *reloc_sects;
+	int nr_reloc_sects;
+	int maps_shndx;
+	int btf_maps_shndx;
+	__u32 btf_maps_sec_btf_id;
+	int text_shndx;
+	int symbols_shndx;
+	int data_shndx;
+	int rodata_shndx;
+	int bss_shndx;
+	int st_ops_shndx;
+};
+
 struct bpf_object {
 	char name[BPF_OBJ_NAME_LEN];
 	char license[64];
@@ -484,40 +513,10 @@ struct bpf_object {
 
 	struct bpf_gen *gen_loader;
 
+	/* Information when doing ELF related work. Only valid if efile.elf is not NULL */
+	struct elf_state efile;
 	/*
-	 * Information when doing elf related work. Only valid if fd
-	 * is valid.
-	 */
-	struct {
-		int fd;
-		const void *obj_buf;
-		size_t obj_buf_sz;
-		Elf *elf;
-		GElf_Ehdr ehdr;
-		Elf_Data *symbols;
-		Elf_Data *data;
-		Elf_Data *rodata;
-		Elf_Data *bss;
-		Elf_Data *st_ops_data;
-		size_t shstrndx; /* section index for section name strings */
-		size_t strtabidx;
-		struct {
-			GElf_Shdr shdr;
-			Elf_Data *data;
-		} *reloc_sects;
-		int nr_reloc_sects;
-		int maps_shndx;
-		int btf_maps_shndx;
-		__u32 btf_maps_sec_btf_id;
-		int text_shndx;
-		int symbols_shndx;
-		int data_shndx;
-		int rodata_shndx;
-		int bss_shndx;
-		int st_ops_shndx;
-	} efile;
-	/*
-	 * All loaded bpf_object is linked in a list, which is
+	 * All loaded bpf_object are linked in a list, which is
 	 * hidden to caller. bpf_objects__<func> handlers deal with
 	 * all objects.
 	 */
@@ -551,7 +550,6 @@ struct bpf_object {
 
 	char path[];
 };
-#define obj_elf_valid(o)	((o)->efile.elf)
 
 static const char *elf_sym_str(const struct bpf_object *obj, size_t off);
 static const char *elf_sec_str(const struct bpf_object *obj, size_t off);
@@ -1185,7 +1183,7 @@ static struct bpf_object *bpf_object__new(const char *path,
 
 static void bpf_object__elf_finish(struct bpf_object *obj)
 {
-	if (!obj_elf_valid(obj))
+	if (!obj->efile.elf)
 		return;
 
 	if (obj->efile.elf) {
@@ -1210,7 +1208,7 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 	int err = 0;
 	GElf_Ehdr *ep;
 
-	if (obj_elf_valid(obj)) {
+	if (obj->efile.elf) {
 		pr_warn("elf: init internal error\n");
 		return -LIBBPF_ERRNO__LIBELF;
 	}
-- 
2.30.2

