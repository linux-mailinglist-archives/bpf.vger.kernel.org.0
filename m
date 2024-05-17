Return-Path: <bpf+bounces-29934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 511258C84B7
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 12:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2E2284BE7
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 10:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8EA36B00;
	Fri, 17 May 2024 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QiOEXJlq"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E48936137
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715941427; cv=none; b=Z9wDyk93o29MDJ5cQfZsxt0VFeJlfHaURKyjoUPiBgoMchoRlxOfEV7Xh5HS4ysh5iNSncTG62aqlyiOh+T8JLV5imKXYlYOMDabG9s3Mj58YkNaLAPcNB/a7T7A0T1+DbO2Ex39MMnLuB73WfC+agKKkRD9FAlwyO9Kisd2UZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715941427; c=relaxed/simple;
	bh=/+yXlg1Ts9s3xPeHYINfynhz5+7pZAQ2giUpuazZaGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PIt3ycJLNHZjVNYrkdaF3Ix9UzRV6RqwLDPGntUZI+mDz3xk38b9XXkZOlgNGL6nB+s4l2k4pvDGYXQwTJ6xjLh96BD5ip182s2AtmLyrLcaRBULsJNPJJIteHKQdYyKLyeJ+LEBYTBiebIbcVNJfXUZrN488XoqWxRM6x33p+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QiOEXJlq; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44H8mOmE031133;
	Fri, 17 May 2024 10:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=Pgy5/CZsZxyM/Pmv8NhpXNnUAQhuoc8JW/QL2mqOBME=;
 b=QiOEXJlqOngq4GFp0eRTta2TBfwZk3mC99AnCP4N2OW5kumZFep8r860RRbg1Tyi/gNg
 A5OiZ3dAHtLst11GjoP47ILbKcgfZnYNSwqOEvFZrDT0JwCpCe6mmeCYQ8U3lI/H4U7V
 iTH/5A7EF56Pjz/IW0mNDymM8y5nsWtIWtYdUCmmU/cI8lBC2iMPBl4deAZGDE5MrMVd
 VzjpOs+tkjqJ7YOPT5BXVWNR9kntgS3TOP/WUoGNsb6+cITndAxqbL3TEKyJpgVsuOjU
 mvJu16RFAvS07w/kvGKA2bIQnyljpl0tGuQvSXawkN7+sP6k7Bg++/oHYUAlwPdiqEGy Ew== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3t4fhg6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 10:23:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44H9wkBn001205;
	Fri, 17 May 2024 10:23:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y4fsuqs58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 10:23:21 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44HAMqFi036134;
	Fri, 17 May 2024 10:23:20 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-196-17.vpn.oracle.com [10.175.196.17])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3y4fsuqrr2-6;
	Fri, 17 May 2024 10:23:20 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 05/11] resolve_btfids: use .BTF.base ELF section as base BTF if -B option is used
Date: Fri, 17 May 2024 11:22:40 +0100
Message-Id: <20240517102246.4070184-6-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: Jh1SCqI9eZ_p6mNvvejngkVIucr3CNkY
X-Proofpoint-GUID: Jh1SCqI9eZ_p6mNvvejngkVIucr3CNkY

When resolving BTF ids, use the BTF in the module .BTF.base section
when passed the -B option.  Both references to base BTF from split
BTF and BTF ids will be relocated for base vmlinux on module load.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/resolve_btfids/main.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index d9520cb826b3..4f2ff52c3ea7 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -115,6 +115,7 @@ struct object {
 	const char *path;
 	const char *btf;
 	const char *base_btf_path;
+	int base;
 
 	struct {
 		int		 fd;
@@ -527,22 +528,37 @@ static int symbols_resolve(struct object *obj)
 	int nr_unions   = obj->nr_unions;
 	int nr_funcs    = obj->nr_funcs;
 	struct btf *base_btf = NULL;
-	int err, type_id;
+	int err = 0, type_id;
 	struct btf *btf;
 	__u32 nr_types;
 
 	if (obj->base_btf_path) {
-		base_btf = btf__parse(obj->base_btf_path, NULL);
-		err = libbpf_get_error(base_btf);
+		LIBBPF_OPTS(btf_parse_opts, optp);
+		const char *path;
+
+		if (obj->base) {
+			optp.btf_sec = BTF_BASE_ELF_SEC;
+			path = obj->path;
+			base_btf = btf__parse_opts(path, &optp);
+			/* fall back to normal base parsing if no BTF_BASE_ELF_SEC */
+		}
+		if (!base_btf) {
+			optp.btf_sec = BTF_ELF_SEC;
+			path = obj->base_btf_path;
+			base_btf = btf__parse_opts(path, &optp);
+		}
+		if (!base_btf)
+			err = -errno;
 		if (err) {
 			pr_err("FAILED: load base BTF from %s: %s\n",
-			       obj->base_btf_path, strerror(-err));
+			       path, strerror(-err));
 			return -1;
 		}
 	}
 
 	btf = btf__parse_split(obj->btf ?: obj->path, base_btf);
-	err = libbpf_get_error(btf);
+	if (!btf)
+		err = -errno;
 	if (err) {
 		pr_err("FAILED: load BTF from %s: %s\n",
 			obj->btf ?: obj->path, strerror(-err));
@@ -781,6 +797,8 @@ int main(int argc, const char **argv)
 			   "BTF data"),
 		OPT_STRING('b', "btf_base", &obj.base_btf_path, "file",
 			   "path of file providing base BTF"),
+		OPT_INCR('B', "base", &obj.base,
+			 "use " BTF_BASE_ELF_SEC " ELF section BTF as base"),
 		OPT_END()
 	};
 	int err = -1;
-- 
2.31.1


