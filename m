Return-Path: <bpf+bounces-29932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC568C84B6
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 12:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F60EB23110
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 10:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25A9376F1;
	Fri, 17 May 2024 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V6yeW3tp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED1536B09
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715941416; cv=none; b=fJMnzQGl8BLn6LYXc3ZztRYJFNj3AFGSwnD5x6T98nmOvaA6wbxr2f+9uK7s4a6IvCWW0ZXLw6tHPYf3N+wEvpKXA+SACUiNtXn257vEasC7FIw7Y8utDa6ELa+qs5lVIpH768/7VQCeHFKUR9tMiNNvfeQEk8jEOob5NvpgHRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715941416; c=relaxed/simple;
	bh=ktTHd6NG9BujSe63E5rLvF/t448hfQJWGHk3Upee4c4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nxXIuWy6tT/kk47kFvQxYRPff5XanYAJImcTthq4PDMxmISMyZ8qRL4Gfe399Ch2rse2h6f0XhCqjEEBEqE79Oce6eA+Xxg5zkXlHjXwPU5ppBjN64VW2sziHLzHq9qnZw5ouyqWKosYA1uOcAI2P+NUPn57Zdhk0tPtezRxa8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V6yeW3tp; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44H83FNN013318;
	Fri, 17 May 2024 10:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=K8UcUXxloosLUdwZLJNBsQV9zRGHU/7zSuOp5+5+tWA=;
 b=V6yeW3tpZZ5b9afJJZpGIFkvWfO5ggiGv34MgXoBlRc0J3jVWbGGIXqKWTX0VGeZVcTW
 W48g/doYAza0aGoXA5XqNRxC+znf8l0DaLD1vpxCwMmtWUmk7zirIWS82p+RRwmefBkq
 Heh+kKml5CjuwEGIZEQvz7EABcXZWJ7AnoLuEhM5HmJ2/JnpC8TvA4qBr+XSk0thjbK3
 MekjKeR00hgrvF5cERvIzPiR4S5q7/jOGfy7kZnbqf8EfVP/oPhShBMDVqUtOhMmwKxb
 RFlVOl2UaSAekddP8cpleXV82YZgEx9pvlplBCa+2xpBkH/WLQsz1ZNKbjOZWp9WFHh6 bQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3tx399y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 10:23:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44HA5iIh000505;
	Fri, 17 May 2024 10:23:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y4fsuqs16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 10:23:10 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44HAMqFe036134;
	Fri, 17 May 2024 10:23:09 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-196-17.vpn.oracle.com [10.175.196.17])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3y4fsuqrr2-4;
	Fri, 17 May 2024 10:23:09 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 03/11] libbpf: add btf__parse_opts() API for flexible BTF parsing
Date: Fri, 17 May 2024 11:22:38 +0100
Message-Id: <20240517102246.4070184-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240517102246.4070184-1-alan.maguire@oracle.com>
References: <20240517102246.4070184-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_03,2024-05-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405170082
X-Proofpoint-GUID: St8UHLwcO_6ivb9Zx-u0DJxZF40zSouo
X-Proofpoint-ORIG-GUID: St8UHLwcO_6ivb9Zx-u0DJxZF40zSouo

Options cover existing parsing scenarios (ELF, raw, retrieving
.BTF.ext) and also allow specification of the ELF section name
containing BTF.  This will allow consumers to retrieve BTF from
.BTF.base sections (BTF_BASE_ELF_SEC) also.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c      | 49 +++++++++++++++++++++++++++-------------
 tools/lib/bpf/btf.h      | 31 +++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 65 insertions(+), 16 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 953929d196c3..feba071087a5 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1084,7 +1084,7 @@ struct btf *btf__new_split(const void *data, __u32 size, struct btf *base_btf)
 	return libbpf_ptr(btf_new(data, size, base_btf));
 }
 
-static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
+static struct btf *btf_parse_elf(const char *path, const char *btf_sec, struct btf *base_btf,
 				 struct btf_ext **btf_ext)
 {
 	Elf_Data *btf_data = NULL, *btf_ext_data = NULL;
@@ -1146,7 +1146,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 				idx, path);
 			goto done;
 		}
-		if (strcmp(name, BTF_ELF_SEC) == 0) {
+		if (strcmp(name, btf_sec) == 0) {
 			btf_data = elf_getdata(scn, 0);
 			if (!btf_data) {
 				pr_warn("failed to get section(%d, %s) data from %s\n",
@@ -1166,7 +1166,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 	}
 
 	if (!btf_data) {
-		pr_warn("failed to find '%s' ELF section in %s\n", BTF_ELF_SEC, path);
+		pr_warn("failed to find '%s' ELF section in %s\n", btf_sec, path);
 		err = -ENODATA;
 		goto done;
 	}
@@ -1212,12 +1212,12 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 
 struct btf *btf__parse_elf(const char *path, struct btf_ext **btf_ext)
 {
-	return libbpf_ptr(btf_parse_elf(path, NULL, btf_ext));
+	return libbpf_ptr(btf_parse_elf(path, BTF_ELF_SEC, NULL, btf_ext));
 }
 
 struct btf *btf__parse_elf_split(const char *path, struct btf *base_btf)
 {
-	return libbpf_ptr(btf_parse_elf(path, base_btf, NULL));
+	return libbpf_ptr(btf_parse_elf(path, BTF_ELF_SEC, base_btf, NULL));
 }
 
 static struct btf *btf_parse_raw(const char *path, struct btf *base_btf)
@@ -1293,31 +1293,48 @@ struct btf *btf__parse_raw_split(const char *path, struct btf *base_btf)
 	return libbpf_ptr(btf_parse_raw(path, base_btf));
 }
 
-static struct btf *btf_parse(const char *path, struct btf *base_btf, struct btf_ext **btf_ext)
+struct btf *btf__parse_opts(const char *path, struct btf_parse_opts *opts)
 {
-	struct btf *btf;
+	struct btf *btf, *base_btf;
+	const char *btf_sec;
+	struct btf_ext **btf_ext;
 	int err;
 
+	if (!OPTS_VALID(opts, btf_parse_opts))
+		return libbpf_err_ptr(-EINVAL);
+	base_btf = OPTS_GET(opts, base_btf, NULL);
+	btf_sec = OPTS_GET(opts, btf_sec, NULL);
+	btf_ext = OPTS_GET(opts, btf_ext, NULL);
+
 	if (btf_ext)
 		*btf_ext = NULL;
-
-	btf = btf_parse_raw(path, base_btf);
+	if (!btf_sec) {
+		btf = btf_parse_raw(path, base_btf);
+		err = libbpf_get_error(btf);
+		if (!err)
+			return btf;
+		if (err != -EPROTO)
+			return libbpf_err_ptr(err);
+	}
+	btf = btf_parse_elf(path, btf_sec ?: BTF_ELF_SEC, base_btf, btf_ext);
 	err = libbpf_get_error(btf);
-	if (!err)
-		return btf;
-	if (err != -EPROTO)
-		return ERR_PTR(err);
-	return btf_parse_elf(path, base_btf, btf_ext);
+	if (err)
+		return libbpf_err_ptr(err);
+	return btf;
 }
 
 struct btf *btf__parse(const char *path, struct btf_ext **btf_ext)
 {
-	return libbpf_ptr(btf_parse(path, NULL, btf_ext));
+	LIBBPF_OPTS(btf_parse_opts, opts, .btf_ext = btf_ext);
+
+	return btf__parse_opts(path, &opts);
 }
 
 struct btf *btf__parse_split(const char *path, struct btf *base_btf)
 {
-	return libbpf_ptr(btf_parse(path, base_btf, NULL));
+	LIBBPF_OPTS(btf_parse_opts, opts, .base_btf = base_btf);
+
+	return btf__parse_opts(path, &opts);
 }
 
 static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endian);
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index f3f149a09088..8e1702ad5ef4 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -18,6 +18,7 @@ extern "C" {
 
 #define BTF_ELF_SEC ".BTF"
 #define BTF_EXT_ELF_SEC ".BTF.ext"
+#define BTF_BASE_ELF_SEC ".BTF.base"
 #define MAPS_ELF_SEC ".maps"
 
 struct btf;
@@ -134,6 +135,36 @@ LIBBPF_API struct btf *btf__parse_elf_split(const char *path, struct btf *base_b
 LIBBPF_API struct btf *btf__parse_raw(const char *path);
 LIBBPF_API struct btf *btf__parse_raw_split(const char *path, struct btf *base_btf);
 
+struct btf_parse_opts {
+	size_t sz;
+	/* use base BTF to parse split BTF */
+	struct btf *base_btf;
+	/* retrieve optional .BTF.ext info */
+	struct btf_ext **btf_ext;
+	/* BTF section name; if NULL, try parsing raw BTF, falling back to parsing
+	 * .BTF ELF section if that fails also.  If set, parse named ELF section.
+	 */
+	const char *btf_sec;
+	size_t :0;
+};
+
+#define btf_parse_opts__last_field btf_sec
+
+/* @brief **btf__parse_opts()** parses BTF information from either a
+ * raw BTF file (*btf_sec* is NULL) or from the specified BTF section,
+ * also retrieving  .BTF.ext info if *btf_ext* is non-NULL.  If
+ * *base_btf* is specified, use it to parse split BTF from the
+ * specified location.
+ *
+ * @return new BTF object instance which has to be eventually freed with
+ * **btf__free()**
+ *
+ * On error, NULL is returned, with the `errno` variable set to the
+ * error code.
+ */
+
+LIBBPF_API struct btf *btf__parse_opts(const char *path, struct btf_parse_opts *opts);
+
 LIBBPF_API struct btf *btf__load_vmlinux_btf(void);
 LIBBPF_API struct btf *btf__load_module_btf(const char *module_name, struct btf *vmlinux_btf);
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 9e69d6e2a512..fd7bfeaba542 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -420,6 +420,7 @@ LIBBPF_1.4.0 {
 LIBBPF_1.5.0 {
 	global:
 		btf__distill_base;
+		btf__parse_opts;
 		bpf_program__attach_sockmap;
 		ring__consume_n;
 		ring_buffer__consume_n;
-- 
2.31.1


