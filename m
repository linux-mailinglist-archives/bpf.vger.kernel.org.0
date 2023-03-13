Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B9C6B81D8
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 20:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCMTqS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 15:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMTqR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 15:46:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228DD838AC
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 12:46:17 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DJNsH6023644;
        Mon, 13 Mar 2023 19:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=3MyLnofbpkn4OuamCfQktsTgY7IU/cVJJfz3uEdN7dY=;
 b=ocexN7hqAjlGqbeAhLWuBuMcZv361Q5i4LQluxN4WO3/aQAFFDzz25hnijDw3n1vBLfi
 NbSxJPI4HjOGv+iShEXOkV/tre+6A9AKWpJJit3jLpxLNGXr+VtVYauv31Tpu9WEXlZp
 lnICZ+jgM7tYtAZ2nAG/lpI/RJLyLK+WrfzFm5JUoGrPxHqFqoWmbqKzoc11v71WeyI2
 +PiSSlm6L97GRvNaKNOxJ+q/f2fiyHIRPP+9kO8AsBNxg8RbZjA/ygAQ6WZzJhptEGzw
 is9QvsAhzXrSi7ogMlrxwzbMLn3H+GLZSvZp2dV7Vxp8kB12ukuiPvoUhbmbT3WkBqwj Jg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8j6u4u8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 19:45:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32DIoAkC002422;
        Mon, 13 Mar 2023 19:45:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g3bnp5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 19:45:47 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32DJjlgn011310;
        Mon, 13 Mar 2023 19:45:47 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-188-11.vpn.oracle.com [10.175.188.11])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3p8g3bnp39-1;
        Mon, 13 Mar 2023 19:45:46 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org, eddyz87@gmail.com
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        haoluo@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
        kpsingh@chromium.org, sinquersw@gmail.com, martin.lau@kernel.org,
        songliubraving@fb.com, sdf@google.com, timo@incline.eu, yhs@fb.com,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] fprintf: reintroduce space after "const"
Date:   Mon, 13 Mar 2023 19:45:42 +0000
Message-Id: <1678736742-6197-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_09,2023-03-13_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130155
X-Proofpoint-GUID: gneWdCPCtFk9C1EwUd82dAcLmln0vstB
X-Proofpoint-ORIG-GUID: gneWdCPCtFk9C1EwUd82dAcLmln0vstB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commmit

2a0b8d7bc7e5 (fprintf: Support skipping modifier)

mistakenly missed out the space after the "const" prefix, resulting
in output like

    struct ZSTD_inBuffer_s {
            constvoid  *               src;                  /*     0     8 */
            ...
    };

Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarves_fprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index c2fdcda..e8399e7 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -584,7 +584,7 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
 			if (!pconf->skip_emitting_modifier) {
 				switch (tag->tag) {
 				case DW_TAG_volatile_type: prefix = "volatile "; break;
-				case DW_TAG_const_type: prefix = "const"; break;
+				case DW_TAG_const_type: prefix = "const "; break;
 				case DW_TAG_restrict_type: suffix = " restrict"; break;
 				case DW_TAG_atomic_type:   prefix = "_Atomic ";  break;
 				}
-- 
1.8.3.1

