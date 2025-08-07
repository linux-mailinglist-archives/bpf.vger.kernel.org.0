Return-Path: <bpf+bounces-65207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A13B1DA1D
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 16:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E245617EB
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 14:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A42266565;
	Thu,  7 Aug 2025 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j5J/fowN"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3FF264FBD;
	Thu,  7 Aug 2025 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577744; cv=none; b=s0JjvSKH8yduyd4kmndwa+LYX7dg8WY4RFtCG0WJg6Y8M2UaDCc5HB0Zcg5EDQ9ewLKc3g7ngnhg0TVEGTX6tj9Vnf1v735h2+7BsgNcHaj5KgmNOTGskfE0cfVfojta6MkpOpTlZNMeEifLyseJDEJJRLnSOLwhh2Pnd9Vx7pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577744; c=relaxed/simple;
	bh=m2ve9CekviKYuOFdmd61vJlxc9SVovYd6CwTCTq7McE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioY32L0qiREhsKFI1kEgBrtA8rpJ6KrRzbL2p/4CbvRjOM3yCeB69S3bP4ySVSYOXATXtfDZA294iI+Ep2IbLBaLe/hTgPy+Wb3ksg2zaCFhUFQAVMOmqK7512HVsGniMCgvFZLEBeaZDblpx7xzGX0g0qFg9VUbnQD/gyF5VQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j5J/fowN; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5777NJE1032362;
	Thu, 7 Aug 2025 14:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=3YziI
	fidJ93Ssw9nK0vQi6ur7YGuct+zlYn3WZOma9E=; b=j5J/fowNbcwXWXfLhqotQ
	/2Cfar21wK2PxVoHs0P1ELn7SUk32BbpRywvF2dwIdVL16mhQ0NvdXDVGuMcpReH
	bCcCOpnmc5YD74KMNxP+/CJ4mZuQotLOQCpq1wENfhgkSiJS0S3mui2FYbF+m92v
	QKyZ0UBvdjh33/BmQ6p6dfkuXpdsANJzj4/10oz/aYmWCmjY0BF4WRB7G1OCskib
	BwflbhaeAbFpoemeFRfOBTDdJstGWDra8yAPf1oQdiSc6GStOIY+cD4qAy4EJqp2
	tUM8TyNZzq8N8wFdvcmgLI49A0+PfbV+v8JUk/5CA6SgbmrHHNPzBQknAUXWyIMu
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvjv6gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 14:42:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 577ERouq005718;
	Thu, 7 Aug 2025 14:42:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwyhvxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 14:42:14 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 577EgAIr014830;
	Thu, 7 Aug 2025 14:42:14 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-8.vpn.oracle.com [10.154.53.8])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48bpwyhvt5-5;
	Thu, 07 Aug 2025 14:42:14 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 4/6] btf_loader: read ELF for BTF encoding
Date: Thu,  7 Aug 2025 15:42:07 +0100
Message-ID: <20250807144209.1845760-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250807144209.1845760-1-alan.maguire@oracle.com>
References: <20250807144209.1845760-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508070118
X-Proofpoint-ORIG-GUID: bopsGoEG5X6Oh72Iy0PD0exLsH0MV66Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDExOCBTYWx0ZWRfX1fLJV3WrVjQG
 f76V2ioafE8OuLkBpfry5Q9FPX1raWyjmAIdt+jzZHKBxTM8hdPQW2R0/LDJg6ozWdoRXmKnJw6
 bQayHM+iGQDXC3hDPB9mF3s6QyKbxif6WoQhXjKTr2Xcz9xEvAkdYLUk1eNmLCBYuGzrfiwk+jw
 mVakj4HYm7e8o6I/wCR+0+OF4EOvGNnHOdVLvTlyN877+IInhRQd3admbIBBOMPbaisxZRyOWFc
 2nYlwNEj6I4eSe7eu5O2k4IZfAyL87h9Sxlj9qkRsMeI2jWukqYCcEJbAc2atLj2ihhH74/hvDr
 +JW323l4gz7qM4jKxKuNo2eq4tu7Jc6nSnWUA2ZqG6vQq8RUM1nbhDJzW+jiS1WvwNWjEnjFXGC
 x2cRZ71Bn2LHlAQlFZzH4COsIqYFibVZjpV7WQvnCqyUR+U6HD/xJiD2Mz+gGkUx9R1pRf9w
X-Authority-Analysis: v=2.4 cv=dobbC0g4 c=1 sm=1 tr=0 ts=6894bb48 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=3-OkzrrpBkj9chBrwXIA:9 cc=ntf
 awl=host:12069
X-Proofpoint-GUID: bopsGoEG5X6Oh72Iy0PD0exLsH0MV66Y

When encoding BTF we need ELF information also; read it for BTF encoding case.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_loader.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index 42bca92..504a07d 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -735,7 +735,7 @@ struct debug_fmt_ops btf__ops;
 
 static int cus__load_btf(struct cus *cus, struct conf_load *conf, const char *filename)
 {
-	int err = -1;
+	int fd = -1, err = -1;
 
 	// Pass a zero for addr_size, we'll get it after we load via btf__pointer_size()
 	struct cu *cu = cu__new(filename, 0, NULL, 0, filename, false);
@@ -746,6 +746,23 @@ static int cus__load_btf(struct cus *cus, struct conf_load *conf, const char *fi
 	cu->uses_global_strings = false;
 	cu->dfops = &btf__ops;
 
+	/* Need ELF information for BTF encoding also */
+	if (conf->btf_encode) {
+		fd = open(filename, O_RDONLY), err = -1;
+		if (fd >= 0) {
+			if (elf_version(EV_CURRENT) == EV_NONE) {
+				fprintf(stderr, "%s: cannot set libelf version.\n", __func__);
+				goto out_free;
+			}
+			cu->elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
+			if (cu->elf == NULL) {
+				fprintf(stderr, "%s: cannot read %s ELF file.\n",
+					__func__, filename);
+				goto out_free;
+			}
+		}
+	}
+
 	libbpf_set_print(libbpf_log);
 
 	struct btf *btf = btf__parse_split(filename, conf->base_btf);
@@ -771,10 +788,16 @@ static int cus__load_btf(struct cus *cus, struct conf_load *conf, const char *fi
 		return 0;
 
 	cus__add(cus, cu);
-	return err;
 
 out_free:
-	cu__delete(cu); // will call btf__free(cu->priv);
+	if (cu->elf) {
+		elf_end(cu->elf);
+		cu->elf = NULL;
+	}
+	if (fd != -1)
+		close(fd);
+	if (err)
+		cu__delete(cu); // will call btf__free(cu->priv);
 	return err;
 }
 
-- 
2.43.5


