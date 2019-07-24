Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15ACD73F88
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2019 22:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389727AbfGXUdc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jul 2019 16:33:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24370 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728257AbfGXT2G (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Jul 2019 15:28:06 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6OJQl8A002976
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2019 12:28:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=W3MDWZXtfmHCQe2ch+wwiGqfOlC4s5RHrNHgzn0myxA=;
 b=ok9jRR+zIStKjSWkGMrngLNPJ2nmwCBr8aK9p4cuJix2Vh9WpwX/1tsVZRwFaQXYzL5l
 9etcEK7KkWaeV87P2QwKoCSAPKCO1OU0NdvgS3AQIyE85DX/J6kzPn75LsNemktmNDga
 lDJidNei5Xpxsk0kukPpcijhGKMxOMq93Kc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0b-00082601.pphosted.com with ESMTP id 2txu1ugp62-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2019 12:28:05 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 24 Jul 2019 12:28:03 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 86DCA8615F8; Wed, 24 Jul 2019 12:28:01 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <yhs@fb.com>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 01/10] libbpf: add .BTF.ext offset relocation section loading
Date:   Wed, 24 Jul 2019 12:27:33 -0700
Message-ID: <20190724192742.1419254-2-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190724192742.1419254-1-andriin@fb.com>
References: <20190724192742.1419254-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907240208
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support for BPF CO-RE offset relocations. Add section/record
iteration macros for .BTF.ext. These macro are useful for iterating over
each .BTF.ext record, either for dumping out contents or later for BPF
CO-RE relocation handling.

To enable other parts of libbpf to work with .BTF.ext contents, moved
a bunch of type definitions into libbpf_internal.h.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/btf.c             | 64 +++++++++--------------
 tools/lib/bpf/btf.h             |  4 ++
 tools/lib/bpf/libbpf_internal.h | 91 +++++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+), 41 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 467224feb43b..4a36bc783848 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -42,47 +42,6 @@ struct btf {
 	int fd;
 };
 
-struct btf_ext_info {
-	/*
-	 * info points to the individual info section (e.g. func_info and
-	 * line_info) from the .BTF.ext. It does not include the __u32 rec_size.
-	 */
-	void *info;
-	__u32 rec_size;
-	__u32 len;
-};
-
-struct btf_ext {
-	union {
-		struct btf_ext_header *hdr;
-		void *data;
-	};
-	struct btf_ext_info func_info;
-	struct btf_ext_info line_info;
-	__u32 data_size;
-};
-
-struct btf_ext_info_sec {
-	__u32	sec_name_off;
-	__u32	num_info;
-	/* Followed by num_info * record_size number of bytes */
-	__u8	data[0];
-};
-
-/* The minimum bpf_func_info checked by the loader */
-struct bpf_func_info_min {
-	__u32   insn_off;
-	__u32   type_id;
-};
-
-/* The minimum bpf_line_info checked by the loader */
-struct bpf_line_info_min {
-	__u32	insn_off;
-	__u32	file_name_off;
-	__u32	line_off;
-	__u32	line_col;
-};
-
 static inline __u64 ptr_to_u64(const void *ptr)
 {
 	return (__u64) (unsigned long) ptr;
@@ -831,6 +790,9 @@ static int btf_ext_setup_info(struct btf_ext *btf_ext,
 	/* The start of the info sec (including the __u32 record_size). */
 	void *info;
 
+	if (ext_sec->len == 0)
+		return 0;
+
 	if (ext_sec->off & 0x03) {
 		pr_debug(".BTF.ext %s section is not aligned to 4 bytes\n",
 		     ext_sec->desc);
@@ -934,6 +896,19 @@ static int btf_ext_setup_line_info(struct btf_ext *btf_ext)
 	return btf_ext_setup_info(btf_ext, &param);
 }
 
+static int btf_ext_setup_offset_reloc(struct btf_ext *btf_ext)
+{
+	struct btf_ext_sec_setup_param param = {
+		.off = btf_ext->hdr->offset_reloc_off,
+		.len = btf_ext->hdr->offset_reloc_len,
+		.min_rec_size = sizeof(struct bpf_offset_reloc),
+		.ext_info = &btf_ext->offset_reloc_info,
+		.desc = "offset_reloc",
+	};
+
+	return btf_ext_setup_info(btf_ext, &param);
+}
+
 static int btf_ext_parse_hdr(__u8 *data, __u32 data_size)
 {
 	const struct btf_ext_header *hdr = (struct btf_ext_header *)data;
@@ -1004,6 +979,13 @@ struct btf_ext *btf_ext__new(__u8 *data, __u32 size)
 	if (err)
 		goto done;
 
+	/* check if there is offset_reloc_off/offset_reloc_len fields */
+	if (btf_ext->hdr->hdr_len < sizeof(struct btf_ext_header))
+		goto done;
+	err = btf_ext_setup_offset_reloc(btf_ext);
+	if (err)
+		goto done;
+
 done:
 	if (err) {
 		btf_ext__free(btf_ext);
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 88a52ae56fc6..287361ee1f6b 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -57,6 +57,10 @@ struct btf_ext_header {
 	__u32	func_info_len;
 	__u32	line_info_off;
 	__u32	line_info_len;
+
+	/* optional part of .BTF.ext header */
+	__u32	offset_reloc_off;
+	__u32	offset_reloc_len;
 };
 
 LIBBPF_API void btf__free(struct btf *btf);
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 2ac29bd36226..087ff512282f 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -46,4 +46,95 @@ do {				\
 int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
 			 const char *str_sec, size_t str_len);
 
+struct btf_ext_info {
+	/*
+	 * info points to the individual info section (e.g. func_info and
+	 * line_info) from the .BTF.ext. It does not include the __u32 rec_size.
+	 */
+	void *info;
+	__u32 rec_size;
+	__u32 len;
+};
+
+#define for_each_btf_ext_sec(seg, sec)					\
+	for (sec = (seg)->info;						\
+	     (void *)sec < (seg)->info + (seg)->len;			\
+	     sec = (void *)sec + sizeof(struct btf_ext_info_sec) +	\
+		   (seg)->rec_size * sec->num_info)
+
+#define for_each_btf_ext_rec(seg, sec, i, rec)				\
+	for (i = 0, rec = (void *)&(sec)->data;				\
+	     i < (sec)->num_info;					\
+	     i++, rec = (void *)rec + (seg)->rec_size)
+
+struct btf_ext {
+	union {
+		struct btf_ext_header *hdr;
+		void *data;
+	};
+	struct btf_ext_info func_info;
+	struct btf_ext_info line_info;
+	struct btf_ext_info offset_reloc_info;
+	__u32 data_size;
+};
+
+struct btf_ext_info_sec {
+	__u32	sec_name_off;
+	__u32	num_info;
+	/* Followed by num_info * record_size number of bytes */
+	__u8	data[0];
+};
+
+/* The minimum bpf_func_info checked by the loader */
+struct bpf_func_info_min {
+	__u32   insn_off;
+	__u32   type_id;
+};
+
+/* The minimum bpf_line_info checked by the loader */
+struct bpf_line_info_min {
+	__u32	insn_off;
+	__u32	file_name_off;
+	__u32	line_off;
+	__u32	line_col;
+};
+
+/* The minimum bpf_offset_reloc checked by the loader
+ *
+ * Offset relocation captures the following data:
+ * - insn_off - instruction offset (in bytes) within a BPF program that needs
+ *   its insn->imm field to be relocated with actual offset;
+ * - type_id - BTF type ID of the "root" (containing) entity of a relocatable
+ *   offset;
+ * - access_str_off - offset into corresponding .BTF string section. String
+ *   itself encodes an accessed field using a sequence of field and array
+ *   indicies, separated by colon (:). It's conceptually very close to LLVM's
+ *   getelementptr ([0]) instruction's arguments for identifying offset to 
+ *   a field.
+ *
+ * Example to provide a better feel.
+ *
+ *   struct sample {
+ *       int a;
+ *       struct {
+ *           int b[10];
+ *       };
+ *   };
+ * 
+ *   struct sample *s = ...;
+ *   int x = &s->a;     // encoded as "0:0" (a is field #0)
+ *   int y = &s->b[5];  // encoded as "0:1:5" (b is field #1, arr elem #5)
+ *   int z = &s[10]->b; // encoded as "10:1" (ptr is used as an array)
+ *
+ * type_id for all relocs in this example  will capture BTF type id of
+ * `struct sample`.
+ *
+ *   [0] https://llvm.org/docs/LangRef.html#getelementptr-instruction
+ */
+struct bpf_offset_reloc {
+	__u32   insn_off;
+	__u32   type_id;
+	__u32   access_str_off;
+};
+
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
-- 
2.17.1

