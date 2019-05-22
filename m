Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC06226E9F
	for <lists+bpf@lfdr.de>; Wed, 22 May 2019 21:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbfEVTvE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 May 2019 15:51:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59838 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387918AbfEVTvD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 May 2019 15:51:03 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x4MJlH5T023849
        for <bpf@vger.kernel.org>; Wed, 22 May 2019 12:51:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=09zR1jbBVhYXt9NleKvpqzItnvPFECoeoIX74novJLM=;
 b=e8uiXc14dRpCusBDkd/TqDkECUt9/EywF9tF9Lh5+wO4rvFSLkYXxEifzp8gkmUDuP2W
 exbQncadJcxFe2UBaR0El5a8WM1D9TkpX/37GumGoLyt7QQM8cPJHl7iYuFQu893eEgm
 M4yytghVOGZvWwNv1Won3E7j/hpXyLthOuQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2sn5ta1rme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 22 May 2019 12:51:01 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 22 May 2019 12:51:00 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 23E3E862334; Wed, 22 May 2019 12:50:59 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <ast@fb.com>, <daniel@iogearbox.net>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 02/12] libbpf: add btf__parse_elf API to load .BTF and .BTF.ext
Date:   Wed, 22 May 2019 12:50:43 -0700
Message-ID: <20190522195053.4017624-3-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522195053.4017624-1-andriin@fb.com>
References: <20190522195053.4017624-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-22_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905220138
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Loading BTF and BTF.ext from ELF file is a common need. Instead of
requiring every user to re-implement it, let's provide this API from
libbpf itself. It's mostly copy/paste from `bpftool btf dump`
implementation, which will be switched to libbpf's version in next
patch. btf__parse_elf allows to load BTF and optionally BTF.ext.
This is also useful for tests that need to load/work with BTF, loaded
from test ELF files.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/btf.c      | 128 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h      |   2 +
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 131 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 03348c4d6bd4..6139550810a1 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4,10 +4,12 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <fcntl.h>
 #include <unistd.h>
 #include <errno.h>
 #include <linux/err.h>
 #include <linux/btf.h>
+#include <gelf.h>
 #include "btf.h"
 #include "bpf.h"
 #include "libbpf.h"
@@ -417,6 +419,132 @@ struct btf *btf__new(__u8 *data, __u32 size)
 	return btf;
 }
 
+static bool btf_check_endianness(const GElf_Ehdr *ehdr)
+{
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	return ehdr->e_ident[EI_DATA] == ELFDATA2LSB;
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+	return ehdr->e_ident[EI_DATA] == ELFDATA2MSB;
+#else
+# error "Unrecognized __BYTE_ORDER__"
+#endif
+}
+
+struct btf *btf__parse_elf(const char *path, struct btf_ext **btf_ext)
+{
+	Elf_Data *btf_data = NULL, *btf_ext_data = NULL;
+	int err = 0, fd = -1, idx = 0;
+	struct btf *btf = NULL;
+	Elf_Scn *scn = NULL;
+	Elf *elf = NULL;
+	GElf_Ehdr ehdr;
+
+	if (elf_version(EV_CURRENT) == EV_NONE) {
+		pr_warning("failed to init libelf for %s\n", path);
+		return ERR_PTR(-LIBBPF_ERRNO__LIBELF);
+	}
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0) {
+		err = -errno;
+		pr_warning("failed to open %s: %s\n", path, strerror(errno));
+		return ERR_PTR(err);
+	}
+
+	err = -LIBBPF_ERRNO__FORMAT;
+
+	elf = elf_begin(fd, ELF_C_READ, NULL);
+	if (!elf) {
+		pr_warning("failed to open %s as ELF file\n", path);
+		goto done;
+	}
+	if (!gelf_getehdr(elf, &ehdr)) {
+		pr_warning("failed to get EHDR from %s\n", path);
+		goto done;
+	}
+	if (!btf_check_endianness(&ehdr)) {
+		pr_warning("non-native ELF endianness is not supported\n");
+		goto done;
+	}
+	if (!elf_rawdata(elf_getscn(elf, ehdr.e_shstrndx), NULL)) {
+		pr_warning("failed to get e_shstrndx from %s\n", path);
+		goto done;
+	}
+
+	while ((scn = elf_nextscn(elf, scn)) != NULL) {
+		GElf_Shdr sh;
+		char *name;
+
+		idx++;
+		if (gelf_getshdr(scn, &sh) != &sh) {
+			pr_warning("failed to get section(%d) header from %s\n",
+				   idx, path);
+			goto done;
+		}
+		name = elf_strptr(elf, ehdr.e_shstrndx, sh.sh_name);
+		if (!name) {
+			pr_warning("failed to get section(%d) name from %s\n",
+				   idx, path);
+			goto done;
+		}
+		if (strcmp(name, BTF_ELF_SEC) == 0) {
+			btf_data = elf_getdata(scn, 0);
+			if (!btf_data) {
+				pr_warning("failed to get section(%d, %s) data from %s\n",
+					   idx, name, path);
+				goto done;
+			}
+			continue;
+		} else if (btf_ext && strcmp(name, BTF_EXT_ELF_SEC) == 0) {
+			btf_ext_data = elf_getdata(scn, 0);
+			if (!btf_ext_data) {
+				pr_warning("failed to get section(%d, %s) data from %s\n",
+					   idx, name, path);
+				goto done;
+			}
+			continue;
+		}
+	}
+
+	err = 0;
+
+	if (!btf_data) {
+		err = -ENOENT;
+		goto done;
+	}
+	btf = btf__new(btf_data->d_buf, btf_data->d_size);
+	if (IS_ERR(btf))
+		goto done;
+
+	if (btf_ext && btf_ext_data) {
+		*btf_ext = btf_ext__new(btf_ext_data->d_buf,
+					btf_ext_data->d_size);
+		if (IS_ERR(*btf_ext))
+			goto done;
+	} else if (btf_ext) {
+		*btf_ext = NULL;
+	}
+done:
+	if (elf)
+		elf_end(elf);
+	close(fd);
+
+	if (err)
+		return ERR_PTR(err);
+	/*
+	 * btf is always parsed before btf_ext, so no need to clean up
+	 * btf_ext, if btf loading failed
+	 */
+	if (IS_ERR(btf))
+		return btf;
+	if (btf_ext && IS_ERR(*btf_ext)) {
+		btf__free(btf);
+		err = PTR_ERR(*btf_ext);
+		return ERR_PTR(err);
+	}
+	return btf;
+}
+
 static int compare_vsi_off(const void *_a, const void *_b)
 {
 	const struct btf_var_secinfo *a = _a;
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index c7b399e81fce..bded210df9e8 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -59,6 +59,8 @@ struct btf_ext_header {
 
 LIBBPF_API void btf__free(struct btf *btf);
 LIBBPF_API struct btf *btf__new(__u8 *data, __u32 size);
+LIBBPF_API struct btf *btf__parse_elf(const char *path,
+				      struct btf_ext **btf_ext);
 LIBBPF_API int btf__finalize_data(struct bpf_object *obj, struct btf *btf);
 LIBBPF_API int btf__load(struct btf *btf);
 LIBBPF_API __s32 btf__find_by_name(const struct btf *btf,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 673001787cba..e0ec3fa52255 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -163,4 +163,5 @@ LIBBPF_0.0.3 {
 		bpf_map__is_internal;
 		bpf_map_freeze;
 		btf__finalize_data;
+		btf__parse_elf;
 } LIBBPF_0.0.2;
-- 
2.17.1

