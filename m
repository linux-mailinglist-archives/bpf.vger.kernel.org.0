Return-Path: <bpf+bounces-27698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1238B0F01
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 17:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7812957C2
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 15:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7DB161B6B;
	Wed, 24 Apr 2024 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iZmCjJvR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E2913DBB2
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973756; cv=none; b=KE/KK/vZzI/puKS5kAwR0svmSITwnucfVvoitDAmhg99Q6c18NrA5w1pyWEKDXraToqyUnoa4gRNHv5A78d6cwJxo6UN7W1S0wJ1nAf/bnikqWKFMsPTmFh2mANHdv3ZoUCUtDx06TqasyTbQi8VRlKKMbzLiDcQEj9Bj48DDuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973756; c=relaxed/simple;
	bh=LrtakGVwnNjl3RUAG7TSbYfqN76f4eEpCagAxQacSV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qol9hL1Whn0VfTsfuYTa8oS4It2yCNATsgLXanlK5XQDKTunLkYWX3z7YYyYTN8kuhoCYRNynTrNZ84KbERgnW+NuYrTmWn5HdPIpnQcWx8IF4/+W4RMbeJ2xLxXIAuC2KZS1Tzk7Hu2TwqGJSSJbp/CGWvK8EVfS+Ez0yku0OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iZmCjJvR; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OF4FcV009721;
	Wed, 24 Apr 2024 15:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=9vVumfilR+beseT9VynUB6rIgLLZavAEYPMF8/CttSk=;
 b=iZmCjJvRf4raAi10ftVpAuGMPF79Gg/xocaqgY3/bE9fEykddM7iJrKDw5e9ofc3LB1n
 C+xft+sj61vgo/31Cc5OWVXFGHv+5bs0EzFdoG06l8Mhwat8ue1oD6mUbJ1YSxrZguGy
 RzEa1VP3wpmUH3SgiUdH/fpDQ68Zapjidq6x5kAt3IKFTy9PTMw2Kj1dBPzLHpdrBErw
 fztU7wQgmia5Kws+zU1PVOJ2rI5uYJ1vbOUGXhCt3P0bniuP86faaZIA/+drztIRtniK
 NApsBw9k9eEoj66NYlFgvK1vbZG++SLxZgqbR5+TmVGDN2mW5+cMhiYDMTehyf1PLUIZ zg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5kbs3up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:48:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OEmeYx025298;
	Wed, 24 Apr 2024 15:48:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45fb028-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:48:49 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43OFmCoc008769;
	Wed, 24 Apr 2024 15:48:48 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-216-158.vpn.oracle.com [10.175.216.158])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xm45faxuq-8;
	Wed, 24 Apr 2024 15:48:48 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: jolsa@kernel.org, acme@redhat.com, quentin@isovalent.com,
        eddyz87@gmail.com, mykolal@fb.com, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 07/13] resolve_btfids: use .BTF.base ELF section as base BTF if -B option is used
Date: Wed, 24 Apr 2024 16:48:00 +0100
Message-Id: <20240424154806.3417662-8-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: gOcq5k3l6GKL5ZfjK_eVrFS_wJfPnzfz
X-Proofpoint-ORIG-GUID: gOcq5k3l6GKL5ZfjK_eVrFS_wJfPnzfz

When resolving BTF ids, use the BTF in the module .BTF.base section
when passed the -B option.  Both references to base BTF from split
BTF and BTF ids will be relocated for base vmlinux on module load.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/resolve_btfids/main.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index d9520cb826b3..c5b622a31f18 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -115,6 +115,7 @@ struct object {
 	const char *path;
 	const char *btf;
 	const char *base_btf_path;
+	int base;
 
 	struct {
 		int		 fd;
@@ -532,11 +533,26 @@ static int symbols_resolve(struct object *obj)
 	__u32 nr_types;
 
 	if (obj->base_btf_path) {
-		base_btf = btf__parse(obj->base_btf_path, NULL);
+		LIBBPF_OPTS(btf_parse_opts, optp);
+		const char *path;
+
+		if (obj->base) {
+			optp.btf_sec = BTF_BASE_ELF_SEC;
+			path = obj->path;
+			base_btf = btf__parse_opts(path, &optp);
+			/* fall back to normal base parsing if no BTF_BASE_ELF_SEC */
+			if (libbpf_get_error(base_btf))
+				base_btf = NULL;
+		}
+		if (!base_btf) {
+			optp.btf_sec = BTF_ELF_SEC;
+			path = obj->base_btf_path;
+			base_btf = btf__parse_opts(path, &optp);
+		}
 		err = libbpf_get_error(base_btf);
 		if (err) {
 			pr_err("FAILED: load base BTF from %s: %s\n",
-			       obj->base_btf_path, strerror(-err));
+			       path, strerror(-err));
 			return -1;
 		}
 	}
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


