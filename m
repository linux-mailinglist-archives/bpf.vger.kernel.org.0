Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1E16909F1
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 14:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBIN3f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 08:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjBIN3e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 08:29:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF755A902
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 05:29:18 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319BOIPj014410;
        Thu, 9 Feb 2023 13:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=8RceODLNbsW99Z3avqAQvELK4xWnIl6AFKOiBE3SWpw=;
 b=00nGBShC15Nb2Z+/r+yw929vetJVWKdSKR+RPlg7mBgmtI5Yo8d9ZpVlo3FHeiIIR6cV
 6fzVvuuyjrjafnHJ3LB85bwQzCu2QEUPsC7mLiPkOHPDLlUqvZG60B5Q88vTkFh44T6z
 vrD8YWoA19ZK7eBv4nk3K012/+dbdcf/1WlxX8UKQpWcvHD65LWACmBrLGtlrQms5RQG
 pPqS7ZIFiV6jSfcENlIAkVR3bw9KPs8rRZDCPlTILFiMYQgQJTlznZUuq/smyYdyvKVd
 eKfe8GI5D+JBAy4mgYJ8V10F8qmu3WZMB04jG4a+YGeruwD/us0ffSbJzBXIpDF20z2g Ng== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhfdcjrm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Feb 2023 13:28:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 319BfowB025742;
        Thu, 9 Feb 2023 13:28:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtfumk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Feb 2023 13:28:56 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 319DSuUB001778;
        Thu, 9 Feb 2023 13:28:56 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-215-241.vpn.oracle.com [10.175.215.241])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3nhdtfumgs-1;
        Thu, 09 Feb 2023 13:28:55 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        acme@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next] bpf: add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25
Date:   Thu,  9 Feb 2023 13:28:51 +0000
Message-Id: <1675949331-27935-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-09_10,2023-02-09_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090128
X-Proofpoint-GUID: iAs2F7O6zdYnBUgV8OpZ9V9B1A0Yu1BH
X-Proofpoint-ORIG-GUID: iAs2F7O6zdYnBUgV8OpZ9V9B1A0Yu1BH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v1.25 of pahole supports filtering out functions with multiple
inconsistent function prototypes or optimized-out parameters
from the BTF representation.  These present problems because
there is no additional info in BTF saying which inconsistent
prototype matches which function instance to help guide
attachment, and functions with optimized-out parameters can
lead to incorrect assumptions about register contents.

So for now, filter out such functions while adding BTF
representations for functions that have "."-suffixes
(foo.isra.0) but not optimized-out parameters.

This patch assumes changes in [1] land and pahole is bumped
to v1.25.

[1] https://lore.kernel.org/bpf/1675790102-23037-1-git-send-email-alan.maguire@oracle.com/

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

---
 scripts/pahole-flags.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
index 1f1f1d3..728d551 100755
--- a/scripts/pahole-flags.sh
+++ b/scripts/pahole-flags.sh
@@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
 	# see PAHOLE_HAS_LANG_EXCLUDE
 	extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
 fi
+if [ "${pahole_ver}" -ge "125" ]; then
+	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
+fi
 
 echo ${extra_paholeopt}
-- 
1.8.3.1

