Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7B569B75C
	for <lists+bpf@lfdr.de>; Sat, 18 Feb 2023 02:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBRBOC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 20:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjBRBOB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 20:14:01 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56EB2528C
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 17:14:00 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HLi03l018446;
        Fri, 17 Feb 2023 23:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=yRDXjG5zXZIfSywz3VUYN2RB/0AGt373rA0mlbi4pw4=;
 b=Z14tk2b3XJ1FHbjpQjz4dVg7ZMPN1szZY7dFFKfpxPGHZqTM5sOo5q/h1oJgw28726+T
 sbFG/GYOjTakXclJ0bDL00OnoohKM3ZwvD1gdRi5+73+pEwcYQZw40iFkGN8Xdgx85TW
 UElOSJJumZS/7OwfqRAmEfoa3TXbTU9A+DgGjGPemro9sOvpyQtgd/N0+D9PdG+OjVTe
 qp1dpAN16MUyldUNaSdpS9l8q/yQ8qA5TfKiLD6RKRqZ17lXWlEdG3cfduNI1fSninIL
 NXR/QN4wx3j7NkXjYy5dWBEGMxGpxufV6jGUkCx5TbNjqpre5mnws+swvIYBwNF1amqh RA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np32cq6gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 23:10:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HMXlwm015276;
        Fri, 17 Feb 2023 23:10:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fas7x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 23:10:49 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31HNAcmQ007180;
        Fri, 17 Feb 2023 23:10:48 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-171-27.vpn.oracle.com [10.175.171.27])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3np1fas7py-4;
        Fri, 17 Feb 2023 23:10:48 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org, olsajiri@gmail.com, ast@kernel.org
Cc:     daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        eddyz87@gmail.com, sinquersw@gmail.com, timo@incline.eu,
        songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 3/4] pahole: update descriptions for btf_gen_optimized, skip_encoding_btf_inconsistent_proto
Date:   Fri, 17 Feb 2023 23:10:32 +0000
Message-Id: <1676675433-10583-4-git-send-email-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: N1GyGaoV5T8AfQriBSSD89jObxswHRxs
X-Proofpoint-ORIG-GUID: N1GyGaoV5T8AfQriBSSD89jObxswHRxs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Semantics are changed such that we do not skip for optimized-out parameters,
rather unexpected register use.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 pahole.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pahole.c b/pahole.c
index 53dfb07..6fc4ed6 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1647,12 +1647,12 @@ static const struct argp_option pahole__options[] = {
 	{
 		.name = "btf_gen_optimized",
 		.key  = ARGP_btf_gen_optimized,
-		.doc  = "Generate BTF for functions with optimization-related suffixes (.isra, .constprop).  BTF will only be generated if a function does not optimize out parameters."
+		.doc  = "Generate BTF for functions with optimization-related suffixes (.isra, .constprop)."
 	},
 	{
 		.name = "skip_encoding_btf_inconsistent_proto",
 		.key = ARGP_skip_encoding_btf_inconsistent_proto,
-		.doc = "Skip functions that have multiple inconsistent function prototypes sharing the same name, or have optimized-out parameters."
+		.doc = "Skip functions that have multiple inconsistent function prototypes sharing the same name, or that use unexpected registers for parameter values."
 	},
 	{
 		.name = NULL,
-- 
2.31.1

