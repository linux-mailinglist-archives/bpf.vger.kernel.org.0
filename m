Return-Path: <bpf+bounces-30726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 808FB8D1B41
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 14:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8CB1C21D28
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 12:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63F216EC12;
	Tue, 28 May 2024 12:26:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D532A16DEA7
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899204; cv=none; b=H+FhaHB7pRACYMI+SeMGgWMuRHhw8tBoDLq/jCXFO0ZW1Iz3su1XOn1sRf2dG8OmxvZm215n9iqs/HG92h+lh3+XrrnXo7O+BpJpwR/yRFXP0ej4+9G7M6NX2cJzw3a8sE3C3rZR0syvzyUcCK8+6kAw3IjsJtfJlqoAyYQcJnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899204; c=relaxed/simple;
	bh=AsRJta7zkej/Y5aTgXeNYh9dH5JKMbfcaIQO+F+RtD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fJ/9ASwm5cvCWMFPQDj11Ioh/PSHX7Ptd9lvGSUdztF21QDNabk8b+M19thuSIx3Fkhq99CMNdgQUGmQlUhU3pYcS+CTpRMt8uB45wm3thuK4e0JrE/FlWq7flKuajv+JPQ+ODazs7wTr7eLVKtaYzQoSNlQXDDa3BeUNXtzF2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44SBnZJ8000422;
	Tue, 28 May 2024 12:24:41 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:date:from:in-reply-to:message-i?=
 =?UTF-8?Q?d:mime-version:references:subject:to;_s=3Dcorp-2023-11-20;_bh?=
 =?UTF-8?Q?=3DP8Ut94UgrwdfAcQTLrYpu1KiAvEdCdTevTSqBLcI/7Y=3D;_b=3DoRzhQfGL?=
 =?UTF-8?Q?i85zN4VX3yRXdIOF4IskoH4se1FqZTAduega5WbSXLUNkXjpIK/era5UzU6b_U7?=
 =?UTF-8?Q?Mpylz35j7ygsX3mav5CMCambcmGbl4tICBJcGOUrnr6/gA56SZB5lf0g9NB+baK?=
 =?UTF-8?Q?fjD_h2JBYsQzLNdj2Gq9tB0O+MgdGFrzbW/PA0/sMDl4XzobtvcW5LjrncSdsne?=
 =?UTF-8?Q?0dPKZbagz_pIpcl2juPp6T2uNnPH2eQy43yoJ3Fq1yKm63F43iNvxi/t6mqsMAc?=
 =?UTF-8?Q?zjia7IgwvtoKbg+_Yl8JBQyQ9YvYYH1WvpPKLn0XZyHOTjL4sPVTaqD92QrKQju?=
 =?UTF-8?Q?BfwpzMvNbEcE64CUTCLGQ_Dw=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g9m74f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 12:24:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44SCI4t4036542;
	Tue, 28 May 2024 12:24:40 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-164-70.vpn.oracle.com [10.175.164.70])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3yc5359yey-6;
	Tue, 28 May 2024 12:24:40 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Subject: [PATCH v5 bpf-next 5/9] libbpf: make btf_parse_elf process .BTF.base transparently
Date: Tue, 28 May 2024 13:24:04 +0100
Message-Id: <20240528122408.3154936-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240528122408.3154936-1-alan.maguire@oracle.com>
References: <20240528122408.3154936-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_08,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280093
X-Proofpoint-GUID: WQJSWVfD7ko-rQv_CmfoQgsbh5GrBqzG
X-Proofpoint-ORIG-GUID: WQJSWVfD7ko-rQv_CmfoQgsbh5GrBqzG

From: Eduard Zingerman <eddyz87@gmail.com>

Update btf_parse_elf() to check if .BTF.base section is present.
The logic is as follows:

  if .BTF.base section exists:
     distilled_base := btf_new(.BTF.base)
  if distilled_base:
     btf := btf_new(.BTF, .base_btf=distilled_base)
     if base_btf:
        btf_relocate(btf, base_btf)
  else:
     btf := btf_new(.BTF)
  return btf

In other words:
- if .BTF.base section exists, load BTF from it and use it as a base
  for .BTF load;
- if base_btf is specified and .BTF.base section exist, relocate newly
  loaded .BTF against base_btf.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/btf.c | 151 +++++++++++++++++++++++++++++---------------
 tools/lib/bpf/btf.h |   1 +
 2 files changed, 102 insertions(+), 50 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index cb762d7a5dd7..b57f74eedda0 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -114,7 +114,10 @@ struct btf {
 	/* a set of unique strings */
 	struct strset *strs_set;
 	/* whether strings are already deduplicated */
-	bool strs_deduped;
+	unsigned strs_deduped:1;
+
+	/* whether base_btf should be freed in btf_free for this instance */
+	unsigned owns_base:1;
 
 	/* BTF object FD, if loaded into kernel */
 	int fd;
@@ -969,6 +972,8 @@ void btf__free(struct btf *btf)
 	free(btf->raw_data);
 	free(btf->raw_data_swapped);
 	free(btf->type_offs);
+	if (btf->owns_base)
+		btf__free(btf->base_btf);
 	free(btf);
 }
 
@@ -1084,53 +1089,38 @@ struct btf *btf__new_split(const void *data, __u32 size, struct btf *base_btf)
 	return libbpf_ptr(btf_new(data, size, base_btf));
 }
 
-static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
-				 struct btf_ext **btf_ext)
+struct elf_sections_info {
+	Elf_Data *btf_data;
+	Elf_Data *btf_ext_data;
+	Elf_Data *btf_base_data;
+};
+
+static int btf_find_elf_sections(Elf *elf, const char *path, struct elf_sections_info *info)
 {
-	Elf_Data *btf_data = NULL, *btf_ext_data = NULL;
-	int err = 0, fd = -1, idx = 0;
-	struct btf *btf = NULL;
 	Elf_Scn *scn = NULL;
-	Elf *elf = NULL;
+	Elf_Data *data;
 	GElf_Ehdr ehdr;
 	size_t shstrndx;
+	int idx = 0;
 
-	if (elf_version(EV_CURRENT) == EV_NONE) {
-		pr_warn("failed to init libelf for %s\n", path);
-		return ERR_PTR(-LIBBPF_ERRNO__LIBELF);
-	}
-
-	fd = open(path, O_RDONLY | O_CLOEXEC);
-	if (fd < 0) {
-		err = -errno;
-		pr_warn("failed to open %s: %s\n", path, strerror(errno));
-		return ERR_PTR(err);
-	}
-
-	err = -LIBBPF_ERRNO__FORMAT;
-
-	elf = elf_begin(fd, ELF_C_READ, NULL);
-	if (!elf) {
-		pr_warn("failed to open %s as ELF file\n", path);
-		goto done;
-	}
 	if (!gelf_getehdr(elf, &ehdr)) {
 		pr_warn("failed to get EHDR from %s\n", path);
-		goto done;
+		goto err;
 	}
 
 	if (elf_getshdrstrndx(elf, &shstrndx)) {
 		pr_warn("failed to get section names section index for %s\n",
 			path);
-		goto done;
+		goto err;
 	}
 
 	if (!elf_rawdata(elf_getscn(elf, shstrndx), NULL)) {
 		pr_warn("failed to get e_shstrndx from %s\n", path);
-		goto done;
+		goto err;
 	}
 
 	while ((scn = elf_nextscn(elf, scn)) != NULL) {
+		Elf_Data **field;
 		GElf_Shdr sh;
 		char *name;
 
@@ -1138,43 +1128,103 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 		if (gelf_getshdr(scn, &sh) != &sh) {
 			pr_warn("failed to get section(%d) header from %s\n",
 				idx, path);
-			goto done;
+			goto err;
 		}
 		name = elf_strptr(elf, shstrndx, sh.sh_name);
 		if (!name) {
 			pr_warn("failed to get section(%d) name from %s\n",
 				idx, path);
-			goto done;
+			goto err;
 		}
-		if (strcmp(name, BTF_ELF_SEC) == 0) {
-			btf_data = elf_getdata(scn, 0);
-			if (!btf_data) {
-				pr_warn("failed to get section(%d, %s) data from %s\n",
-					idx, name, path);
-				goto done;
-			}
-			continue;
-		} else if (btf_ext && strcmp(name, BTF_EXT_ELF_SEC) == 0) {
-			btf_ext_data = elf_getdata(scn, 0);
-			if (!btf_ext_data) {
-				pr_warn("failed to get section(%d, %s) data from %s\n",
-					idx, name, path);
-				goto done;
-			}
+
+		if (strcmp(name, BTF_ELF_SEC) == 0)
+			field = &info->btf_data;
+		else if (strcmp(name, BTF_EXT_ELF_SEC) == 0)
+			field = &info->btf_ext_data;
+		else if (strcmp(name, BTF_BASE_ELF_SEC) == 0)
+			field = &info->btf_base_data;
+		else
 			continue;
+
+		data = elf_getdata(scn, 0);
+		if (!data) {
+			pr_warn("failed to get section(%d, %s) data from %s\n",
+				idx, name, path);
+			goto err;
 		}
+		*field = data;
 	}
 
-	if (!btf_data) {
+	return 0;
+
+err:
+	return -LIBBPF_ERRNO__FORMAT;
+}
+
+static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
+				 struct btf_ext **btf_ext)
+{
+	struct elf_sections_info info = {};
+	struct btf *distilled_base_btf = NULL;
+	struct btf *btf = NULL;
+	int err = 0, fd = -1;
+	Elf *elf = NULL;
+
+	if (elf_version(EV_CURRENT) == EV_NONE) {
+		pr_warn("failed to init libelf for %s\n", path);
+		return ERR_PTR(-LIBBPF_ERRNO__LIBELF);
+	}
+
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0) {
+		err = -errno;
+		pr_warn("failed to open %s: %s\n", path, strerror(errno));
+		return ERR_PTR(err);
+	}
+
+	elf = elf_begin(fd, ELF_C_READ, NULL);
+	if (!elf) {
+		pr_warn("failed to open %s as ELF file\n", path);
+		goto done;
+	}
+
+	err = btf_find_elf_sections(elf, path, &info);
+	if (err)
+		goto done;
+
+	if (!info.btf_data) {
 		pr_warn("failed to find '%s' ELF section in %s\n", BTF_ELF_SEC, path);
 		err = -ENODATA;
 		goto done;
 	}
-	btf = btf_new(btf_data->d_buf, btf_data->d_size, base_btf);
+
+	if (info.btf_base_data) {
+		distilled_base_btf = btf_new(info.btf_base_data->d_buf, info.btf_base_data->d_size,
+					     NULL);
+		err = libbpf_get_error(distilled_base_btf);
+		if (err) {
+			distilled_base_btf = NULL;
+			goto done;
+		}
+	}
+
+	btf = btf_new(info.btf_data->d_buf, info.btf_data->d_size,
+		      distilled_base_btf ? distilled_base_btf : base_btf);
 	err = libbpf_get_error(btf);
 	if (err)
 		goto done;
 
+	if (distilled_base_btf && base_btf) {
+		err = btf__relocate(btf, base_btf);
+		if (err)
+			goto done;
+		btf__free(distilled_base_btf);
+		distilled_base_btf = NULL;
+	}
+
+	if (distilled_base_btf)
+		btf->owns_base = true;
+
 	switch (gelf_getclass(elf)) {
 	case ELFCLASS32:
 		btf__set_pointer_size(btf, 4);
@@ -1187,8 +1237,8 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 		break;
 	}
 
-	if (btf_ext && btf_ext_data) {
-		*btf_ext = btf_ext__new(btf_ext_data->d_buf, btf_ext_data->d_size);
+	if (btf_ext && info.btf_ext_data) {
+		*btf_ext = btf_ext__new(info.btf_ext_data->d_buf, info.btf_ext_data->d_size);
 		err = libbpf_get_error(*btf_ext);
 		if (err)
 			goto done;
@@ -1205,6 +1255,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 
 	if (btf_ext)
 		btf_ext__free(*btf_ext);
+	btf__free(distilled_base_btf);
 	btf__free(btf);
 
 	return ERR_PTR(err);
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 8a93120b7385..b68d216837a9 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -18,6 +18,7 @@ extern "C" {
 
 #define BTF_ELF_SEC ".BTF"
 #define BTF_EXT_ELF_SEC ".BTF.ext"
+#define BTF_BASE_ELF_SEC ".BTF.base"
 #define MAPS_ELF_SEC ".maps"
 
 struct btf;
-- 
2.31.1


