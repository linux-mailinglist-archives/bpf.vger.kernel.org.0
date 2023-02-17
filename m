Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C28E69B652
	for <lists+bpf@lfdr.de>; Sat, 18 Feb 2023 00:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjBQXMf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 18:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjBQXMd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 18:12:33 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1490859715
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 15:12:03 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HLi82v006002;
        Fri, 17 Feb 2023 23:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=NNNmUpXlhYCscihZ3f9Wh2Bg2NpAo/vVNyUVY/ASkW4=;
 b=2ga0Q64RTCUb25mcuoEV+/lP4CLUy9iHlazyXG8baUdXLNCBigD5UBVQrpfZg+cfk0LC
 gSmL4o/MSwde/lw/PgOK73vlT/MVTIi4HIuq2J5C7Gvxk+BpN88tfYmuyFubhf6+O0gU
 ZC9VrgydGkSRCP33MuRxIx+EAkm+nq9k969lopRPUPI/ttFIqACX+DoYM8gGPTXCIW3Z
 MtVcxxVPZfMYHyZ7wjBgZgDA26UuzEkQdd2Ix6Ah2sbuNG2pW2XLMPyX55EsrBenUgCV
 /wMMP8FR7ErbO8OmNPmC5nphafb6F2+qHZ5vJbJ/vUcsf4c2fmUoMdyaX/ZsRnX5e0nK Jw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1t3q2sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 23:10:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HN5A2t015370;
        Fri, 17 Feb 2023 23:10:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fas7yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 23:10:52 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31HNAcmS007180;
        Fri, 17 Feb 2023 23:10:51 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-171-27.vpn.oracle.com [10.175.171.27])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3np1fas7py-5;
        Fri, 17 Feb 2023 23:10:51 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org, olsajiri@gmail.com, ast@kernel.org
Cc:     daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        eddyz87@gmail.com, sinquersw@gmail.com, timo@incline.eu,
        songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 4/4] pahole: update man page for options also
Date:   Fri, 17 Feb 2023 23:10:33 +0000
Message-Id: <1676675433-10583-5-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1676675433-10583-1-git-send-email-alan.maguire@oracle.com>
References: <1676675433-10583-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_15,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170202
X-Proofpoint-GUID: 4t2mhGFqyaPuNvV9L8RmiNNOt4XUoRlE
X-Proofpoint-ORIG-GUID: 4t2mhGFqyaPuNvV9L8RmiNNOt4XUoRlE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

...in line with changes made to skip logic.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 man-pages/pahole.1 | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index bfa20dc..c1b48de 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -231,8 +231,7 @@ Do not encode type tags in BTF.
 
 .TP
 .B \-\-skip_encoding_btf_inconsistent_proto
-Do not encode functions with multiple inconsistent prototypes or optimized-out
-parameters.
+Do not encode functions with multiple inconsistent prototypes or unexpected register use for their parameters, where the registers used do not match calling conventions.
 
 .TP
 .B \-j, \-\-jobs=N
@@ -269,7 +268,6 @@ information has float types.
 .TP
 .B \-\-btf_gen_optimized
 Generate BTF for functions with optimization-related suffixes (.isra, .constprop).
-BTF will only be generated if a function does not optimize out parameters.
 
 .TP
 .B \-\-btf_gen_all
-- 
2.31.1

