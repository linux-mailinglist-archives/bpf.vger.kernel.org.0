Return-Path: <bpf+bounces-29458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7071B8C2243
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 12:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1121F1F213EB
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 10:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B56016C6A9;
	Fri, 10 May 2024 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XgvQ0k/f"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD4B14F137
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337417; cv=none; b=kE9xnyQbFKzYInXLlxQR3v7Jo6w33Y/9jXyjhKr8JZ/KIYoEWXexL+Tw6mz6iB3n0ZlFZd9s2xyB8QD9BLOBnXtQ4AMLiocYIVISR5+aEWsRFUfC5x+ueJ4t7Z5/IGwABZ7dol5CwjCCA9zBqYeLz63aVRyijvNcukQdN8ag23E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337417; c=relaxed/simple;
	bh=/+yXlg1Ts9s3xPeHYINfynhz5+7pZAQ2giUpuazZaGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k9ubC5GfR4hxq1IItil/FNo+U8pmpuVrliL2ypeZw7dQ7P2amhNaR7eJzHOxeq8Di+CmsssZp0OOc0ETyDRSLgNCjFX8wvzEJ6ze3FQbbCSKATibo4VDwzJK645sQ7WAUAuEZe63l9UQ0brGBHQIfRWGI5f77sOob2tU3KpnXL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XgvQ0k/f; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44AAaE9n005658;
	Fri, 10 May 2024 10:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=Pgy5/CZsZxyM/Pmv8NhpXNnUAQhuoc8JW/QL2mqOBME=;
 b=XgvQ0k/fVbP9+l5V6uUJKRbbzfKP5N62eKczD6qb1Qq3HlCW6qiXkN4J4RmYi6LMozVk
 3NpmfqMZTjawNUWaRjvqorSNcGmbVxJX12gbfbk5cuapPmWZ1aC5qVoqe36/RI2oM7in
 iX2SQONmLRO99XqsdLG3zbUz9uf405WSArKtdzlQ4Z8lL7kmRZ6pHpcUqF0RjEyeMHW+
 X2o28FLPBo/PhJtEVgOQFjQwbdN4RAFdJjpRltTvesT32/wmTYsC41idTUX5rtYmBWx+
 Mq0a5MlLQDsSVxKLPQx4t+mbffOWeqm6cnM3uH192H26/gAxJHPGVp7wX6+DyDG0ZH+E Bg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y1hyjg01a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 10:36:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44A96QMm019773;
	Fri, 10 May 2024 10:31:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfpcn05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 10:31:31 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44AAV0hb011786;
	Fri, 10 May 2024 10:31:30 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-161-199.vpn.oracle.com [10.175.161.199])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xysfpcm4p-6;
	Fri, 10 May 2024 10:31:30 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 05/11] resolve_btfids: use .BTF.base ELF section as base BTF if -B option is used
Date: Fri, 10 May 2024 11:30:46 +0100
Message-Id: <20240510103052.850012-6-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: Dhj3pnPyBRt78lcAF78IdIPTWcFekWnS
X-Proofpoint-GUID: Dhj3pnPyBRt78lcAF78IdIPTWcFekWnS

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


