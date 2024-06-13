Return-Path: <bpf+bounces-32056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD20590694F
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 11:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D1F2860BC
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 09:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B93140E22;
	Thu, 13 Jun 2024 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BZNMFLf+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4552C1411F4
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272265; cv=none; b=iPjsETQVzlGCdXqRo5IynrP4mbXoGMX33sIDREvlphkbTDAJjjjlh2XRDS051s0ZP29ucbucQoQvYDEabWR5zBNJHHey7TaNoY3XtCn4ya6hXwi99z4B+WCcBqk3zznSPMhNaxJpFP7P6gRMb/QHWbfBmChyUcTM2WqBBHzGCns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272265; c=relaxed/simple;
	bh=3nINqMlL16ibXtXjq9+ZFFANZ16uTi6zKV3f2OMKSgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gf9HtWQS4cAcJw0SSl/k2L6iQ0aupWO53pu6oPJQn+EwxekSi7KrrZo7mTrbjySuZpdNUPPZrUz4rFx4s/0Ou5ndpG6LE5q/+ggUhdIDKT3IhsIhxsOD0nv6puG/aIjMGpe6GzzpDSDp4csF//Tz0hita0tpdLTRpkOsOX+GNFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BZNMFLf+; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D7tQPZ028039;
	Thu, 13 Jun 2024 09:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=y
	U77YsQ7JkPV/dK2pEcCCh1jpbSWKJUimeSk15jZTOQ=; b=BZNMFLf+izIHq/sg7
	m5uIENAaB9p7JuBA40yA9HbGu9KBXlXggk5DaMQn+1v4eVEgRBnUYhd/gjL3Wl0S
	C3fO2aDiFkH5M00KUoXLDjGMDJCcyW9UcW8zCCJbd1GMn2nUa8ne3C3npWHz9I28
	JxA8d/k/CRfku4MYNMvdFudk03bOmjbRXYb1usWlZfG1No0xg+vrdSEChelwf6ET
	uZ28SUBPiTCGumOK1dGf75XTLg3roUXHaZJGaLoyeSy8RsI7LVUwHc6SybCKhypv
	QihGvA6lzpuOZOTtGQNLaP6Mr5eFoUD5uqL7eqL43AobKmEXO71ztJSazQJxwcKo
	W3EDQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1ghab8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 09:50:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45D9ZkBR014232;
	Thu, 13 Jun 2024 09:50:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yncewnm8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 09:50:43 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45D9oJq0005489;
	Thu, 13 Jun 2024 09:50:42 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-212-187.vpn.oracle.com [10.175.212.187])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3yncewnkqw-6;
	Thu, 13 Jun 2024 09:50:41 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, mykolal@fb.com, dxu@dxuuu.xyz,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v6 bpf-next 5/9] libbpf: make btf_parse_elf process .BTF.base transparently
Date: Thu, 13 Jun 2024 10:50:10 +0100
Message-Id: <20240613095014.357981-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240613095014.357981-1-alan.maguire@oracle.com>
References: <20240613095014.357981-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_02,2024-06-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130070
X-Proofpoint-ORIG-GUID: kZViNotenyVCtE1AG66aTegXK2budKPU
X-Proofpoint-GUID: kZViNotenyVCtE1AG66aTegXK2budKPU

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
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 164 +++++++++++++++++++++++++++++---------------
 tools/lib/bpf/btf.h |   1 +
 2 files changed, 111 insertions(+), 54 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 5e20354fbcfa..ef1b2f573c1b 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -116,6 +116,9 @@ struct btf {
 	/* whether strings are already deduplicated */
 	bool strs_deduped;
 
+	/* whether base_btf should be freed in btf_free for this instance */
+	bool owns_base;
+
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
+struct btf_elf_secs {
+	Elf_Data *btf_data;
+	Elf_Data *btf_ext_data;
+	Elf_Data *btf_base_data;
+};
+
+static int btf_find_elf_sections(Elf *elf, const char *path, struct btf_elf_secs *secs)
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
 
@@ -1138,42 +1128,102 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
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
+			field = &secs->btf_data;
+		else if (strcmp(name, BTF_EXT_ELF_SEC) == 0)
+			field = &secs->btf_ext_data;
+		else if (strcmp(name, BTF_BASE_ELF_SEC) == 0)
+			field = &secs->btf_base_data;
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
+	}
+
+	return 0;
+
+err:
+	return -LIBBPF_ERRNO__FORMAT;
+}
+
+static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
+				 struct btf_ext **btf_ext)
+{
+	struct btf_elf_secs secs = {};
+	struct btf *dist_base_btf = NULL;
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
 	}
 
-	if (!btf_data) {
+	elf = elf_begin(fd, ELF_C_READ, NULL);
+	if (!elf) {
+		pr_warn("failed to open %s as ELF file\n", path);
+		goto done;
+	}
+
+	err = btf_find_elf_sections(elf, path, &secs);
+	if (err)
+		goto done;
+
+	if (!secs.btf_data) {
 		pr_warn("failed to find '%s' ELF section in %s\n", BTF_ELF_SEC, path);
 		err = -ENODATA;
 		goto done;
 	}
-	btf = btf_new(btf_data->d_buf, btf_data->d_size, base_btf);
-	err = libbpf_get_error(btf);
-	if (err)
+
+	if (secs.btf_base_data) {
+		dist_base_btf = btf_new(secs.btf_base_data->d_buf, secs.btf_base_data->d_size,
+					NULL);
+		if (IS_ERR(dist_base_btf)) {
+			err = PTR_ERR(dist_base_btf);
+			dist_base_btf = NULL;
+			goto done;
+		}
+	}
+
+	btf = btf_new(secs.btf_data->d_buf, secs.btf_data->d_size,
+		      dist_base_btf ?: base_btf);
+	if (IS_ERR(btf)) {
+		err = PTR_ERR(btf);
 		goto done;
+	}
+	if (dist_base_btf && base_btf) {
+		err = btf__relocate(btf, base_btf);
+		if (err)
+			goto done;
+		btf__free(dist_base_btf);
+		dist_base_btf = NULL;
+	}
+
+	if (dist_base_btf)
+		btf->owns_base = true;
 
 	switch (gelf_getclass(elf)) {
 	case ELFCLASS32:
@@ -1187,11 +1237,12 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 		break;
 	}
 
-	if (btf_ext && btf_ext_data) {
-		*btf_ext = btf_ext__new(btf_ext_data->d_buf, btf_ext_data->d_size);
-		err = libbpf_get_error(*btf_ext);
-		if (err)
+	if (btf_ext && secs.btf_ext_data) {
+		*btf_ext = btf_ext__new(secs.btf_ext_data->d_buf, secs.btf_ext_data->d_size);
+		if (IS_ERR(*btf_ext)) {
+			err = PTR_ERR(*btf_ext);
 			goto done;
+		}
 	} else if (btf_ext) {
 		*btf_ext = NULL;
 	}
@@ -1205,6 +1256,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 
 	if (btf_ext)
 		btf_ext__free(*btf_ext);
+	btf__free(dist_base_btf);
 	btf__free(btf);
 
 	return ERR_PTR(err);
@@ -5598,5 +5650,9 @@ void btf_set_base_btf(struct btf *btf, const struct btf *base_btf)
 
 int btf__relocate(struct btf *btf, const struct btf *base_btf)
 {
-	return libbpf_err(btf_relocate(btf, base_btf, NULL));
+	int err = btf_relocate(btf, base_btf, NULL);
+
+	if (!err)
+		btf->owns_base = false;
+	return libbpf_err(err);
 }
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


