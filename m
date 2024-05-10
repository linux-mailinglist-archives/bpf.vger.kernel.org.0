Return-Path: <bpf+bounces-29455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C778C222E
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 12:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD2D1F21D29
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 10:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBDB8004A;
	Fri, 10 May 2024 10:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FcIvQNiS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDC255C3B
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337175; cv=none; b=NQ3vFjfKUF2TP39UQWEDKVulGz320886FEocfNrvtU7UIlebT9qMjz/Xd+zd1mMSL0TWJ10BZD0pqcqjCc8vyzen0s+GMbDpK24NAXZu1mvBvbjoNkcT6QADdEvmkQMLibyjIw1NCFeK9LaAqJtKdqyPSid4Y186fD++sIpG7rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337175; c=relaxed/simple;
	bh=D2oHaI4C8APcpBl2Vc4xlfszus1cjoweC40RbL9PUaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hVoyLTAC2ffjoR7bWLwZTq+okpLqndHWfrMz/lYAXYLy/lc4GOhb4+6f+SSJOedTXWg1L20qGEbwOEyNipUKKQ5a4SoLVwal4iqmqGNMecFiBEjWAWWMYcxuGoFKQWKesbnYuYeHh7e8xb1STtrK24cGQZ4eDluo8COgJnOQTQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FcIvQNiS; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44AAWIgd012335;
	Fri, 10 May 2024 10:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=xv1TpMO2gyI2UgBxwRCKPJln9rX0JmAthyTwMJ5GRFA=;
 b=FcIvQNiSGIQ08CkZjaLn4b+F1msvzwu1TdzIKSJVv+r/3ep0pdYC3NvM5zx0szTL57Uy
 OpjQGud3g5K5tRF4SNdosKUR1407/scoGl6Fr3D5BAW9eQPO4sshThDxAKS+CjjdsnJa
 zxMxTMcV6Dpy1dEU+PJk4kTE+VbRLOxi6/0endC1jDqOSQklgnLHUZ1fm4PLsEBChLbk
 hLpjY6l0W3rkIq3psOFSFgwTdZacr2Env4WEh9/ViTED8Px47nxFaSG5dblPTa+O0Pu5
 2z3z+J4mKoMMCG7h7DB4+V/+19u2w3EtFmpExzFuhgEg98XfyQ1PIcfTRQrUPtpMAtDu fw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y1dfsrkcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 10:32:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44A9wlwT019113;
	Fri, 10 May 2024 10:31:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfpcmut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 10:31:19 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44AAV0hX011786;
	Fri, 10 May 2024 10:31:18 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-161-199.vpn.oracle.com [10.175.161.199])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xysfpcm4p-4;
	Fri, 10 May 2024 10:31:18 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 03/11] libbpf: add btf__parse_opts() API for flexible BTF parsing
Date: Fri, 10 May 2024 11:30:44 +0100
Message-Id: <20240510103052.850012-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240510103052.850012-1-alan.maguire@oracle.com>
References: <20240510103052.850012-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_07,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405100074
X-Proofpoint-GUID: kNXZeVJnjhAS9-2Ta_rqwIOYSTuXUaSg
X-Proofpoint-ORIG-GUID: kNXZeVJnjhAS9-2Ta_rqwIOYSTuXUaSg

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
index 65abd555fa36..1eb66a7a4c46 100644
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


