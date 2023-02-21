Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B1E69E3EE
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 16:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjBUPt1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 10:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbjBUPt0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 10:49:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B7026844
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 07:49:25 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LDTScU010595;
        Tue, 21 Feb 2023 15:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=G5K9lfph9lh8VH3VEPHCa+6ChOPqIpYQaKe0Gka29Do=;
 b=0fuifpb42rLS3IhfC6lD/SV3wh4/2+0PRngnvL3jjealLvss4dWar13HWwqAKomzqGUp
 QgbmtjjQ/opEfPEWIsh+Qc1MAq0uV5rbr14XVRXX5V99UH3lxECTq2sD/Qaj/sNvsQOE
 lv07BCmTP3jyAkfaPmhSBFCROaVSPe/SzywM6gNWHOJ3QEArMEHS6xLtVqC3T1TReWoN
 t9q51t8bvuOxYcJIXzfxw3UOoxbQme7+XmeKfxnUWY9VLu9xCwYPdFNlL334WbgFtVdk
 2PeFZRftEWTOBgDwsA++7uGF1E9UFvY0+CpmE/TH6CvB3ow/XztEuGuswmC3Q0QeAHuL hA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntq7udev2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 15:49:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31LFEUFs040784;
        Tue, 21 Feb 2023 15:49:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn458y4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 15:49:02 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31LFmmpI007236;
        Tue, 21 Feb 2023 15:49:01 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-204-58.vpn.oracle.com [10.175.204.58])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ntn458xqw-4;
        Tue, 21 Feb 2023 15:49:01 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 3/3] dwarf_loader: only mark parameter as using an unexpected register when it does
Date:   Tue, 21 Feb 2023 15:48:42 +0000
Message-Id: <1676994522-1557-4-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1676994522-1557-1-git-send-email-alan.maguire@oracle.com>
References: <1676994522-1557-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210131
X-Proofpoint-GUID: BYYMAnKpKtCuyRslFawVk_T1_wBM_QBH
X-Proofpoint-ORIG-GUID: BYYMAnKpKtCuyRslFawVk_T1_wBM_QBH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It is important to distinguish between cases where a parameter uses
an unexpected register versus cases where it is optimized out;
the function may still be called with the right parameter values
in the latter case, they just are not used.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarf_loader.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 6ae0954..791845a 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1144,14 +1144,12 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
 				if (expected_reg >= 0 && expected_reg != expr->atom)
 					parm->unexpected_reg = 1;
 				break;
-			case DW_OP_breg0 ... DW_OP_breg31:
-				break;
 			default:
-				parm->unexpected_reg = 1;
+				parm->optimized = 1;
 				break;
 			}
 		} else if (has_const_value) {
-			parm->unexpected_reg = 1;
+			parm->optimized = 1;
 		}
 	}
 
-- 
2.31.1

