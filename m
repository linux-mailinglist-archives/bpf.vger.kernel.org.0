Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBA969E3EB
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 16:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbjBUPtP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 10:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjBUPtP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 10:49:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E1C23309
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 07:49:14 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LDg3Am016180;
        Tue, 21 Feb 2023 15:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=YzNkA86FMIi5Lnanj3X8pW+hsNT7m0FSJtEZJAYKJ+U=;
 b=cz/A/KmZI+9D5nDkS/TqDliy4VcxrhkAgDPRL6OvDaY1+mefOrGN1/tViiH8Cw31pJ2f
 7xOYHVHFtEDGF6T/sXZyXklRWO7cOl1mLy5CfhkzYNh3sHnXS7mmJcIQK2uCOr6mjxfr
 1LBkBNfIvcMw8PkHyL/1k9FfYhoo9MwFOM9pt4YHQw4WlLLXA8RKLiHbob0qv7HNQqyD
 4aY55P+nn4uF9irNjxJjwtt2YPFC1V9uA1g15dfGS08eJql8z28K0jOYJWP0WlJerjiX
 R8x8i8zGngnOIDRuTaMtFEqiAIoRPAkX1Y61ehsGAwOhoAt1ib+VPvfmjiIupqnnFVo6 wA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntp9tnhj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 15:48:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31LFVwiW040888;
        Tue, 21 Feb 2023 15:48:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn458xx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 15:48:53 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31LFmmpE007236;
        Tue, 21 Feb 2023 15:48:52 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-204-58.vpn.oracle.com [10.175.204.58])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ntn458xqw-2;
        Tue, 21 Feb 2023 15:48:52 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 1/3] dwarf_loader: fix detection of struct parameters
Date:   Tue, 21 Feb 2023 15:48:40 +0000
Message-Id: <1676994522-1557-2-git-send-email-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: Sc597oGMIPr5DMX3QFhsAaZhpAZfTSV_
X-Proofpoint-ORIG-GUID: Sc597oGMIPr5DMX3QFhsAaZhpAZfTSV_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In some cases, param__is_struct() was failing to notice that
a parameter was a struct.  The first was where a parameter
was a const struct; the second was where the type information
was in the original subroutine information, and additional
parameters that referred to it via abstract origin did not
also specify type information.  We combine information
about type, name etc in ftype__recode_dwarf_types(), but
since we share the tag->type (rather than the dwarf tag),
param__is_struct() was failing to handle this case as
it represents parameters like this:

    <7e0f7d4>   DW_AT_sibling     : <0x7e0f924>
 <2><7e0f7d8>: Abbrev Number: 7 (DW_TAG_formal_parameter)
    <7e0f7d9>   DW_AT_abstract_origin: <0x7e0dc80>
    <7e0f7dd>   DW_AT_location    : 0x2797488 (location list)
    <7e0f7e1>   DW_AT_GNU_locviews: 0x2797484
 <2><7e0f7e5>: Abbrev Number: 7 (DW_TAG_formal_parameter)
    <7e0f7e6>   DW_AT_abstract_origin: <0x7e0dc8b>
    <7e0f7ea>   DW_AT_location    : 0x27974ca (location list)
    <7e0f7ee>   DW_AT_GNU_locviews: 0x27974c8

...which do not specify a type and did not use the tag->type
information.

Fix param__is_struct() to use cu__type(cu, tag->type)
to look up type information, and to handle the const case.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarf_loader.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 014e130..73e3670 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2645,19 +2645,17 @@ out:
 
 static bool param__is_struct(struct cu *cu, struct tag *tag)
 {
-	const struct dwarf_tag *dtag = tag->priv;
-	struct dwarf_tag *dtype = dwarf_cu__find_type_by_ref(cu->priv, &dtag->type);
-	struct tag *type;
+	struct tag *type = cu__type(cu, tag->type);
 
-	if (!dtype)
+	if (!type)
 		return false;
-	type = dtype->tag;
 
 	switch (type->tag) {
 	case DW_TAG_structure_type:
 		return true;
+	case DW_TAG_const_type:
 	case DW_TAG_typedef:
-		/* handle "typedef struct" */
+		/* handle "typedef struct", const parameter */
 		return param__is_struct(cu, type);
 	default:
 		return false;
-- 
2.31.1

