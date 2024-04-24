Return-Path: <bpf+bounces-27694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 398088B0F09
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 17:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16199B22291
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 15:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7F3161314;
	Wed, 24 Apr 2024 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GIA0aGN7"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F30615FCE1
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973741; cv=none; b=Y3jBfs/vGvL4h2USkfnYfC1ZocS6Bh/TEGSYrMVU9J2sZpl13VykCo+NSmnZXtzOmxrMytLpDR8iMormG8hD1whGoAGRRocoQWSQivipkFIpI4+O5xtOEdWFYzSkZ5hRN8eTBK0wwXP4txVz065eWjVDecGB0tLas/45AoSxdVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973741; c=relaxed/simple;
	bh=44Cc1/AIc/2DCzwvGnPSYOOrFK7dLVPG6mFMUjrAuPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nnldcHfPg4YN4++Uv4O7mjxdSxwt8zJSbVUld2y3c3MqK58xHMytmDA/o61uvBba7ZvDZ61U3CC4m+FyQmfdfNyboaYOjZO5F969SBWeq/RBsD5AnvYfqRSlukFarW3672e0n2zsIIkn3Avv+/TR0uy/tAdLkojEmN2zX1SOt1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GIA0aGN7; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OFeBA7014728;
	Wed, 24 Apr 2024 15:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=ZiA+gCy0CmRzmrhIzCQ9x+uW8vKTKOdiALEBrbBj0Qg=;
 b=GIA0aGN7T+Qe5L9vmZBW3qasZm+UOyjV5CvfFpMU5PLADsrJfG+PheJkN2mPV92lP+DC
 2rDXw0xhsr89FmkYY2u4x1peHriYCyCPtQhug4h6UmWTEPIo80fJsfWr1m9/xLWV4Sue
 zUOu5gaozzfIscrwNu83b00LiETuzp9yY8aNW0XMX4EsfNht8+UqKvhRHFJxDQqbF17w
 vh5ZnABnmiVvoFoJbUksmXmXJ54rMWKeqgrZoQrHfwNrll8tHDzEQ2ULMxqaRatKWkj6
 rH2gqqOEsu7dHO8oNXHbOA6R5OzRjdbSY+/N24BWppEOxYP709EHSb/rFjNdgtiLD/1T EQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4g4gjet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:48:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OEhdd5025265;
	Wed, 24 Apr 2024 15:48:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45fayhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:48:33 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43OFmCoW008769;
	Wed, 24 Apr 2024 15:48:33 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-216-158.vpn.oracle.com [10.175.216.158])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xm45faxuq-5;
	Wed, 24 Apr 2024 15:48:32 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: jolsa@kernel.org, acme@redhat.com, quentin@isovalent.com,
        eddyz87@gmail.com, mykolal@fb.com, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 04/13] libbpf: add btf__parse_opts() API for flexible BTF parsing
Date: Wed, 24 Apr 2024 16:47:57 +0100
Message-Id: <20240424154806.3417662-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240424154806.3417662-1-alan.maguire@oracle.com>
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_13,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240063
X-Proofpoint-GUID: WlGof1GaCRFcyretH1o51jEknOGPhZPt
X-Proofpoint-ORIG-GUID: WlGof1GaCRFcyretH1o51jEknOGPhZPt

Options cover existing parsing scenarios (ELF, raw, retrieving
.BTF.ext) and also allow specification of the ELF section name
containing BTF.  This will allow consumers to retrieve BTF from
.BTF.base sections (BTF_BASE_ELF_SEC) also.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c      | 50 ++++++++++++++++++++++++++++------------
 tools/lib/bpf/btf.h      | 32 +++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 68 insertions(+), 15 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 419cc4fa2e86..9036c1dc45d0 100644
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
@@ -1293,7 +1293,8 @@ struct btf *btf__parse_raw_split(const char *path, struct btf *base_btf)
 	return libbpf_ptr(btf_parse_raw(path, base_btf));
 }
 
-static struct btf *btf_parse(const char *path, struct btf *base_btf, struct btf_ext **btf_ext)
+static struct btf *btf_parse(const char *path, const char *btf_elf_sec, struct btf *base_btf,
+			     struct btf_ext **btf_ext)
 {
 	struct btf *btf;
 	int err;
@@ -1301,23 +1302,42 @@ static struct btf *btf_parse(const char *path, struct btf *base_btf, struct btf_
 	if (btf_ext)
 		*btf_ext = NULL;
 
-	btf = btf_parse_raw(path, base_btf);
-	err = libbpf_get_error(btf);
-	if (!err)
-		return btf;
-	if (err != -EPROTO)
-		return ERR_PTR(err);
-	return btf_parse_elf(path, base_btf, btf_ext);
+	if (!btf_elf_sec) {
+		btf = btf_parse_raw(path, base_btf);
+		err = libbpf_get_error(btf);
+		if (!err)
+			return btf;
+		if (err != -EPROTO)
+			return ERR_PTR(err);
+	}
+	if (!btf_elf_sec)
+		btf_elf_sec = BTF_ELF_SEC;
+
+	return btf_parse_elf(path, btf_elf_sec, base_btf, btf_ext);
+}
+
+struct btf *btf__parse_opts(const char *path, struct btf_parse_opts *opts)
+{
+	struct btf *base_btf;
+	const char *btf_sec;
+	struct btf_ext **btf_ext;
+
+	if (!OPTS_VALID(opts, btf_parse_opts))
+		return libbpf_err_ptr(-EINVAL);
+	base_btf = OPTS_GET(opts, base_btf, NULL);
+	btf_sec = OPTS_GET(opts, btf_sec, NULL);
+	btf_ext = OPTS_GET(opts, btf_ext, NULL);
+	return libbpf_ptr(btf_parse(path, btf_sec, base_btf, btf_ext));
 }
 
 struct btf *btf__parse(const char *path, struct btf_ext **btf_ext)
 {
-	return libbpf_ptr(btf_parse(path, NULL, btf_ext));
+	return libbpf_ptr(btf_parse(path, NULL, NULL, btf_ext));
 }
 
 struct btf *btf__parse_split(const char *path, struct btf *base_btf)
 {
-	return libbpf_ptr(btf_parse(path, base_btf, NULL));
+	return libbpf_ptr(btf_parse(path, NULL, base_btf, NULL));
 }
 
 static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endian);
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 025ed28b7fe8..94dfdfdef617 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -18,6 +18,7 @@ extern "C" {
 
 #define BTF_ELF_SEC ".BTF"
 #define BTF_EXT_ELF_SEC ".BTF.ext"
+#define BTF_BASE_ELF_SEC ".BTF.base"
 #define MAPS_ELF_SEC ".maps"
 
 struct btf;
@@ -134,6 +135,37 @@ LIBBPF_API struct btf *btf__parse_elf_split(const char *path, struct btf *base_b
 LIBBPF_API struct btf *btf__parse_raw(const char *path);
 LIBBPF_API struct btf *btf__parse_raw_split(const char *path, struct btf *base_btf);
 
+struct btf_parse_opts {
+	size_t sz;
+	/* use base BTF to parse split BTF */
+	struct btf *base_btf;
+	/* retrieve optional .BTF.ext info */
+	struct btf_ext **btf_ext;
+	/* BTF section name */
+	const char *btf_sec;
+	size_t:0;
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
+ * On error, error-code-encoded-as-pointer is returned, not a NULL. To extract
+ * error code from such a pointer `libbpf_get_error()` should be used. If
+ * `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)` is enabled, NULL is
+ * returned on error instead. In both cases thread-local `errno` variable is
+ * always set to error code as well.
+ */
+
+LIBBPF_API struct btf *btf__parse_opts(const char *path, struct btf_parse_opts *opts);
+
 LIBBPF_API struct btf *btf__load_vmlinux_btf(void);
 LIBBPF_API struct btf *btf__load_module_btf(const char *module_name, struct btf *vmlinux_btf);
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index c4d9bd7d3220..a9151e31dfa9 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -421,6 +421,7 @@ LIBBPF_1.5.0 {
 	global:
 		bpf_program__attach_sockmap;
 		btf__distill_base;
+		btf__parse_opts;
 		ring__consume_n;
 		ring_buffer__consume_n;
 } LIBBPF_1.4.0;
-- 
2.31.1


