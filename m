Return-Path: <bpf+bounces-76421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4818ECB3F62
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 21:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60310302FA1C
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 20:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1637732BF48;
	Wed, 10 Dec 2025 20:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U0ZinVCj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A4B7260F;
	Wed, 10 Dec 2025 20:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765398540; cv=none; b=G4xXJ6H7PJLpZYge12Pys8UmArWc7OSNvzotyZtGMnQeR/IGhyNl7+7q7sv3Vqr8UdECPTGw8M3KPqskKzmNbBfGHdgnCIeBfohxQDRTOiY7P7Mi/9HTR5nuciObodifnPveKNUJ1PO5aRX3PZA2xvOH77IJz0Igty1mP3YAmlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765398540; c=relaxed/simple;
	bh=azrOAjkQuUhrKzBVg7PIwFa8OyIOHrJSiYdRogaTv8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTkudYYZ7dwE/rgKUoVrbSWuVKezM2kKOngVSdYPxKQ4F6JQn1ekfzL61qgSCCNDB4/T08IGnIx4VrVmS5HwIV/x1DIv6mEkfvXEPyTt3uZ030381MRCM/iNPCpSmTPQC2vF+jw4C/TFEq3Gy13D2Od8Sps2m6dae/n/WIYNrJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U0ZinVCj; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BAIYoJY3768305;
	Wed, 10 Dec 2025 20:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=RYiXQ
	ShsE8WJQnUt0HWnIlfJw/huWt9YgvamEnKHiYM=; b=U0ZinVCjblUwzo4OCu3Cw
	q039DEiuUBfkaEwL/rO9JFuTsLR4kI6ufuaXII16a3UVQ6ZYTvbWdTxdc+DULEUC
	mqF/1RQ2KwoLot3gVykFYcbCxO07+G8dw8kZUR7FSq99JWpkSZaZx3oc/sHGPifb
	2o/IfCb0YIEBVBFIG6j3H3LsEaPg3YEWt4k8tywYGDvpqCNoYCbufxA6uwJc3zrh
	n/wSgY9e4BzxtPMeL6lLqtg/71oVFqsVNgaAZOLK6qLheOmmpNkqr7j+K4MUhm2Q
	ykh8f1UGDN38BJY8MCrBfkAJPpA5vHJan4U1p6ffJJlJAuUAM4m331RZ3LljGfH8
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aycne0cp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:28:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAJ1Joi020945;
	Wed, 10 Dec 2025 20:28:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxb08fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:28:32 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BAKSNwu003322;
	Wed, 10 Dec 2025 20:28:31 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-41.vpn.oracle.com [10.154.60.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4avaxb080n-3;
	Wed, 10 Dec 2025 20:28:31 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 2/2] man-pages: describe kind_layout BTF feature
Date: Wed, 10 Dec 2025 20:27:52 +0000
Message-ID: <20251210202752.813919-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251210202752.813919-1-alan.maguire@oracle.com>
References: <20251210202752.813919-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512100168
X-Authority-Analysis: v=2.4 cv=F65at6hN c=1 sm=1 tr=0 ts=6939d7f1 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=tfYQNom77gPQtgDtiRgA:9
X-Proofpoint-GUID: B9Gj9w1jNYV3opKW-xZjJbD9ilrHYjIz
X-Proofpoint-ORIG-GUID: B9Gj9w1jNYV3opKW-xZjJbD9ilrHYjIz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDE2NyBTYWx0ZWRfX+BAYLH1taGiU
 LnTZlWNnSSiykyLfbGPJVMYIk82wGe8bKl/YO92SHoqAiZNkbD7xgeJB3hod8lPI7wMBu7L35hU
 15J9twPZm5loiEVjJTRV4O/iHq7L5oe8hNLcqOtEEjCF2IxKyYif/CePTpzgXRJunpAoMyNnlzv
 f0pgbamUKOe+GHBSxqZ/k7le1L5ZN1RqN38wiZMNK1BNmPvz+V1IA2roML+c2zk68YRF+WBK4Hf
 bdbJg2QtIpYaB/oFPAC2pUoo48CmrvjpxVhp+CBZEjebE9Ye6TWQOiZn9sJSjKZLmbZLAVamspl
 woT8Le2whAjfg7HUxdV5GQezN/whHmgnIz/pp3Cn5ONzcEEUuPp7Qi8LMR29VTA0x6rx0gr5rMj
 q6Cy9/VrQT97sOj6TU3ExgSf4C/ldA==

Add this optional feature to btf_features description.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 man-pages/pahole.1 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 3125de3..0226103 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -337,6 +337,8 @@ Supported non-standard features (not enabled for 'default')
 	                   of split BTF with a possibly changed base, storing
 	                   it in a .BTF.base ELF section.
 	global_var         Encode all global variables using BTF_KIND_VAR in BTF.
+	kind_layout        Encode information about BTF kinds available at encoding
+	                   time in kind layout section in BTF.
 .fi
 
 So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
-- 
2.43.5


