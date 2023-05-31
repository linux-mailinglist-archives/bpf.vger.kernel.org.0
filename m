Return-Path: <bpf+bounces-1544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E898718B08
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 22:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA35D2815C3
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 20:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B96B3D38F;
	Wed, 31 May 2023 20:21:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19983C0B3
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 20:21:50 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D8912F
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 13:21:49 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VK8wPX027627;
	Wed, 31 May 2023 20:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=ChEoXaLy2bpe6uJDlcCe7o+5RqE+y02pBdTn7k/bXSU=;
 b=rZ2+ztJDlvPHTtrLSws6PCqb35VxEs/JkKh4tRaS8ysDQulf8aolYctCUttDMb7M0tY7
 IlOy9uDZitUOgNbZyJ2DDuMoDWniCM1rwG35NwCSb/XwBhQh0uiPtURACe30V9VK7/Uv
 NfYKdrPRDIoScCNN1448rSK8XXge0dPJ1Xiac/A/ESr0VnAPxsVfobXHUz3W92l0oX/7
 KMuKigstXwExnPWdJKwd7GXrPmzlPDvaVGKL8ddtRHELpcW5yEkfbmMgiB94SUIB5KxH
 iNBpCheSQ+UfCFiF0BLiESUA9CqiUYGiAgEVzaNPFHv6qwXubT9oaXGyOT6YySasKOEg uw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhwweuct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 20:21:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKEfB3019715;
	Wed, 31 May 2023 20:21:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a6djxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 20:21:02 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34VKKaEX000653;
	Wed, 31 May 2023 20:21:01 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-201-40.vpn.oracle.com [10.175.201.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3qu8a6djab-7;
	Wed, 31 May 2023 20:21:01 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, acme@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
        mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 6/8] btf: generate metadata for vmlinux/module BTF
Date: Wed, 31 May 2023 21:19:33 +0100
Message-Id: <20230531201936.1992188-7-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230531201936.1992188-1-alan.maguire@oracle.com>
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_14,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310172
X-Proofpoint-ORIG-GUID: ShR4g_SQpXxrBDXASGKo4ou6_yTR-j8L
X-Proofpoint-GUID: ShR4g_SQpXxrBDXASGKo4ou6_yTR-j8L
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Generate BTF metadata for kernel and module BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 scripts/pahole-flags.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
index 728d55190d97..28fa9120a770 100755
--- a/scripts/pahole-flags.sh
+++ b/scripts/pahole-flags.sh
@@ -24,7 +24,7 @@ if [ "${pahole_ver}" -ge "124" ]; then
 	extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
 fi
 if [ "${pahole_ver}" -ge "125" ]; then
-	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
+	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized --btf_gen_meta"
 fi
 
 echo ${extra_paholeopt}
-- 
2.31.1


