Return-Path: <bpf+bounces-794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DE8706DFE
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 18:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D3D1C20E66
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 16:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8310E1EA63;
	Wed, 17 May 2023 16:20:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E00111A1
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 16:20:27 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E818DD93
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 09:20:07 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HE4nF8014834;
	Wed, 17 May 2023 16:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=2PnMZKauLrhwNDeDK+Wxd2UYWXBYYbdNaE1ImNmwdxs=;
 b=rZE1TVut4IQtAgqEgjLZa0I+VmSB8exRHYNE1SLHs7JWDqo61R0dvuvKk2CxnlFojZHZ
 X2MTeQCF8abQuiPm9Ju1Xip6253STZr6tAZ4zbMEepSZVPQyYRvTzFRbKuACPEXHxVgM
 bQU+PtnmZN5nlk8n9slxAl6/BGMmcDSb5XFhnSCg+rHnmjLO/OxB6CxAuFRxIW8JtRkU
 P2eVulvb04eEm/GwZAmqyndCG0TAd0Opi0wlnOdL7DjhEgcBbnFtxa+ALvmG+sdNh0lK
 dhkpbJQMGS3im9cnCjZFtdYcp3SETm+ZxPWfHXDtI7TywwLKOYo8kqJYQ60j0DxZBs8a JA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxps0krk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 May 2023 16:19:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HFIidt004216;
	Wed, 17 May 2023 16:19:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10bx12b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 May 2023 16:19:16 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34HGHdXJ034295;
	Wed, 17 May 2023 16:19:15 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-213-201.vpn.oracle.com [10.175.213.201])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qj10bwyb5-7;
	Wed, 17 May 2023 16:19:15 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, jolsa@kernel.org, yhs@fb.com,
        andrii@kernel.org
Cc: daniel@iogearbox.net, laoar.shao@gmail.com, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 6/6] pahole: document --btf_gen_func_addr
Date: Wed, 17 May 2023 17:16:48 +0100
Message-Id: <20230517161648.17582-7-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230517161648.17582-1-alan.maguire@oracle.com>
References: <20230517161648.17582-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170133
X-Proofpoint-GUID: 6b04TBmNFu1pYcr-GfU9pAJ-AwOMDla3
X-Proofpoint-ORIG-GUID: 6b04TBmNFu1pYcr-GfU9pAJ-AwOMDla3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Document how we can generate declaration tags specifying
function address.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 man-pages/pahole.1 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index c1b48de..aa0a3a4 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -265,6 +265,14 @@ to "/sys/kernel/btf/vmlinux".
 Allow producing BTF_KIND_FLOAT entries in systems where the vmlinux DWARF
 information has float types.
 
+.TP
+.B \-\-btf_gen_func_addr
+Generate DECL_TAG references that specify "address=0x<address of function>"
+tags for each instance of a function.
+This allows us to map from a function description in BTF to instances of its use
+in code;
+this is helpful if a function has multiple static definitions in different CUs that are incompatible.
+
 .TP
 .B \-\-btf_gen_optimized
 Generate BTF for functions with optimization-related suffixes (.isra, .constprop).
-- 
2.31.1


