Return-Path: <bpf+bounces-57756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 616E3AAFB3D
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 15:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60B161C078FB
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 13:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E6122B8D2;
	Thu,  8 May 2025 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p/7GVYo4"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E9B22B8A9;
	Thu,  8 May 2025 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746710598; cv=none; b=O/v5J4GKFX0RlaWyucDkbE1IsKpE/bulGEDxEfXmpG1kzUKloi1TmBPurc6NP88Ru7XqK47ZBoPIfSFR2pVlgJBR120BKy+fHyY2Zbjb/ijRc/Xf8Qt0H+vnGvi3A9SP7iDx427RyCepPGS4Ii6ljRwFmyLsJ1mFSSbMNMKz9Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746710598; c=relaxed/simple;
	bh=M6WUT6d64rh0EcYNRq3E3ovdUS20DJyMHsQl9ctUhxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPasFBoTFsM21i0ETh+n7FwIXyIahO8Z6iyeJE9eydF8A7+qGJU7bOJGDJph5+xoCdUvJOJDlIVj977txNQTa3sbb1Xl1Sn7BaLkv2IU3hADYmc28ieorVoakYMZLg2uIGdJEUElYqchtQajUhszzanA89mg5LMMdWwa+kW3sh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p/7GVYo4; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548CqJZq010970;
	Thu, 8 May 2025 13:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=bYF0E
	BXPdQ/h7v2D+9REBGLP1bISC3nqYzRc+mmqDP8=; b=p/7GVYo4MiqXZ/nXcs4yX
	3i0yEqS+pKoht/GtZhr4ZKlO1412nRJLLmvaMcUKQgQmRWRhgml3aZfFuKFPL7ke
	Cty8Y2Q6jp2UFpCRm3AUndZyzAVN7Xod4d9REFOOEIVYX8CfAICBGoTm4//jiACF
	b1C+WvHgalTqNpuAb3SnqjnFlPCOekSi8zQKEEtwM3LtSsFnLIxWFkoXENHpm/g2
	V/sTtefedmvI7SA2HJgASPGGO/+ZHLBSXJyIASRoCqLeMqBsdDfm6m7bdJ1u4RPr
	LMY7knLm4ufKivzPEH3ZwtYusQbBPHyDC06vkHgx6boXwlS0r6OMQtQ1hxk+iGsD
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46gw0882n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 13:22:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 548Ci6nO036000;
	Thu, 8 May 2025 13:22:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kcedr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 13:22:50 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 548DMgbB024112;
	Thu, 8 May 2025 13:22:49 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-49-250.vpn.oracle.com [10.154.49.250])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46d9kcedkj-3;
	Thu, 08 May 2025 13:22:49 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
        tony.ambardar@gmail.com, alexis.lothore@bootlin.com
Cc: eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, dwarves@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 2/3] bpf: allow 0-sized structs as function parameters
Date: Thu,  8 May 2025 14:22:36 +0100
Message-ID: <20250508132237.1817317-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250508132237.1817317-1-alan.maguire@oracle.com>
References: <20250508132237.1817317-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_04,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=969
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505080112
X-Proofpoint-ORIG-GUID: gHTAd68NQe3C2zQOiwVfxhzD6VUv4Y_T
X-Authority-Analysis: v=2.4 cv=YoIPR5YX c=1 sm=1 tr=0 ts=681cb02b cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=llE70hgqCV9oWxFz2BQA:9
X-Proofpoint-GUID: gHTAd68NQe3C2zQOiwVfxhzD6VUv4Y_T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDExMiBTYWx0ZWRfXwCwOIUlHWFEG Gs3tFMDwl69oXc/ZHMMh/pOHObxAwkKyRVZsU5XQpu4c+8z0iOOFBDlfx7P+sUUHMCx4TA2Dne/ /L+S3h8fwQgA4ARH4BVMYGYLuc4pbVdiLJ3pnMGO1wtydCYxy4LSz+Tz/WZjVh5QEa1Tvp2Qnn0
 5GJ4qeDgGezlqYrv4LE/CPv2jfKqDp9/QkxaRi6q3hY4/nxocy6gx+O5SCn72jlGtdzzKMBY7gR MZ763OMX3OV7OhW8Ivsbo/Tqnik3IhmOgyAvp0WWEI2YgcD3LWcwHGlpTpl6cVm7m7k5oUVdKpG 4rr3aAofjpGiZmnBwIhqkO8rE0bJuQxEhqhklRT6lJgk4rguMUuf7wLflLl4fhu61WHJ7AhBb5z
 aVj26ABqRujslaCnB5sO5mEokeNyZms411FJpxh+tmZNlFT714oCVkRnPcHWxTFUV9vIw6Td

Currently we forbid 0-sized parameters and complain that the function
has a malformed void argument, however now that we can handle 0-sized
structs using BPF_PROG2(), carve out an exception for them.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6b21ca67070c..dc18a646b98a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7385,7 +7385,7 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
 				tname, i, btf_type_str(t));
 			return -EINVAL;
 		}
-		if (ret == 0) {
+		if (ret == 0 && !__btf_type_is_struct(t)) {
 			bpf_log(log,
 				"The function %s has malformed void argument.\n",
 				tname);
-- 
2.39.3


