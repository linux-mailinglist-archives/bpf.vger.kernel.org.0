Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638F769E3EC
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 16:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjBUPtT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 10:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjBUPtS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 10:49:18 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A1B26844
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 07:49:17 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LDSnDZ001381;
        Tue, 21 Feb 2023 15:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=ooPfe+yd7YRGMFJcFx0q14eJgWY8AE0qz9xHf6MNWLc=;
 b=Fhkb/BBHFT8LB+7wTAtMIMs0liVSYtXUIIQjnMW54Zv1qpErygHSyVMN0AHQ9tTD7nGn
 ky1nq3OJNscSamCbMAnOCO9BdQZgn0NTlrG7ZOiNLptQ6YrXDwuLHyAQv1u+M/c0xUwg
 IxOhP7UF22+FGmX7jUk9lucZoJsOi8MEmBMPyM0xey3VZJLI8wvO1YKAHWlDdIhndkp9
 vnq4kiPIULdX4xMxtYyjqLaHPQihSJBsAOakvlAEb5ny0TvB0hZohXHGulonzmApCFE/
 rm46mX9HzrP0cUdo6GVGPtKeshOYkBhkyGMrm9EWOcPRgCdgOahJUK1PwpccrP+H86DR 4Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn90nhwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 15:48:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31LFgV2u040789;
        Tue, 21 Feb 2023 15:48:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn458y21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 15:48:58 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31LFmmpG007236;
        Tue, 21 Feb 2023 15:48:57 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-204-58.vpn.oracle.com [10.175.204.58])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ntn458xqw-3;
        Tue, 21 Feb 2023 15:48:56 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 2/3] dwarf_loader: fix parameter location retrieval for location lists
Date:   Tue, 21 Feb 2023 15:48:41 +0000
Message-Id: <1676994522-1557-3-git-send-email-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: WOsixx6lOxd1CvIJlF03yQUTaNATgDEF
X-Proofpoint-GUID: WOsixx6lOxd1CvIJlF03yQUTaNATgDEF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

dwarf_getlocation() does not work for location lists; use
dwarf_getlocations() instead.  For parameters we are
only interested in the first expr - the location on function
entry.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarf_loader.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 73e3670..6ae0954 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -8,6 +8,7 @@
 #include <dirent.h>
 #include <dwarf.h>
 #include <elfutils/libdwfl.h>
+#include <elfutils/version.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <fnmatch.h>
@@ -1073,6 +1074,7 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
 	struct parameter *parm = tag__alloc(cu, sizeof(*parm));
 
 	if (parm != NULL) {
+		Dwarf_Addr base, start, end;
 		bool has_const_value;
 		Dwarf_Attribute attr;
 		struct location loc;
@@ -1115,10 +1117,18 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
 		 * between these parameter representations.  See
 		 * ftype__recode_dwarf_types() below for how this is handled.
 		 */
-		parm->has_loc = dwarf_attr(die, DW_AT_location, &attr) != NULL;
 		has_const_value = dwarf_attr(die, DW_AT_const_value, &attr) != NULL;
+		parm->has_loc = dwarf_attr(die, DW_AT_location, &attr) != NULL;
+		/* dwarf_getlocations() handles location lists; here we are
+		 * only interested in the first expr.
+		 */
 		if (parm->has_loc &&
-		    attr_location(die, &loc.expr, &loc.exprlen) == 0 &&
+#if _ELFUTILS_PREREQ(0, 157)
+		    dwarf_getlocations(&attr, 0, &base, &start, &end,
+				       &loc.expr, &loc.exprlen) > 0 &&
+#else
+		    dwarf_getlocation(&attr, &loc.expr, &loc.exprlen) == 0 &&
+#endif
 			loc.exprlen != 0) {
 			int expected_reg = cu->register_params[param_idx];
 			Dwarf_Op *expr = loc.expr;
-- 
2.31.1

