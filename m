Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798356B4819
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 15:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjCJO6y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 09:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbjCJO63 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 09:58:29 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0E31B543
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 06:53:08 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AAmAW1026414;
        Fri, 10 Mar 2023 14:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=NKYzB1fXBT6kd3GjEcb3Yosl5mmtOzFl2r0oPTbs7iA=;
 b=tgjbwjx3y/hUsaOfLzmx1dh6Mz7iGnLlpz59o4xDlLPX9B2wLzDtjMlaLMAPUiWP/pD/
 o77jEZysFbW095JaHyoH/zsOHKChFBsCPWE+Li+tmCw9Z560ok6/RhZIjWm5StPJBfrM
 IyHGyK49dftXKn5/ADk9nWLmRHxQjtSrsHz6m+u15gDnAWxDb/pv8VdHyUJl517xcqp0
 KRIwXcAcCb2bMASut0leFYVOA+dL5fm1m4zYxMA8LcVeGfqwPf7a4o6YZhy5ODc4s2OZ
 DgreQfP1sV3NFES7dhK1e4CC6mcc0TAfAM49oMYPN5bKtha6DUv4sqVQ2ZOh9lQyRtne XA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p415j5g9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 14:50:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32ADuVdV020762;
        Fri, 10 Mar 2023 14:50:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fub0du7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 14:50:58 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32AEosCN013152;
        Fri, 10 Mar 2023 14:50:57 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-184-199.vpn.oracle.com [10.175.184.199])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3p6fub0dkf-2;
        Fri, 10 Mar 2023 14:50:57 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 1/3] dwarves_fprintf: generalize function prototype print to support passing conf
Date:   Fri, 10 Mar 2023 14:50:48 +0000
Message-Id: <1678459850-16140-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1678459850-16140-1-git-send-email-alan.maguire@oracle.com>
References: <1678459850-16140-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_06,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100121
X-Proofpoint-GUID: PfHB2J8n_8wVyDs_ljZxTAv4dM6nkVa3
X-Proofpoint-ORIG-GUID: PfHB2J8n_8wVyDs_ljZxTAv4dM6nkVa3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

function__prototype() writes the function prototype to the passed-in
buffer, but uses the default conf_fprint structure which prints
parameter names.  Generalize into function__prototype_conf() so that
callers can pass in their own conf_fprintf; this will be useful
for generating prototype strings for type matching.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarves.h         |  5 +++++
 dwarves_fprintf.c | 22 +++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/dwarves.h b/dwarves.h
index e92b2fd..d04a36d 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -133,6 +133,7 @@ struct conf_fprintf {
 	uint8_t	   hex_fmt:1;
 	uint8_t	   strip_inline:1;
 	uint8_t	   skip_emitting_atomic_typedefs:1;
+	uint8_t	   skip_emitting_errors:1;
 };
 
 struct cus;
@@ -944,6 +945,10 @@ size_t function__fprintf_stats(const struct tag *tag_func,
 			       FILE *fp);
 const char *function__prototype(const struct function *func,
 				const struct cu *cu, char *bf, size_t len);
+const char *function__prototype_conf(const struct function *func,
+				     const struct cu *cu,
+				     const struct conf_fprintf *conf,
+				     char *bf, size_t len);
 
 static __pure inline uint64_t function__addr(const struct function *func)
 {
diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index 30355b4..5c6bf9c 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -1102,21 +1102,33 @@ static size_t union__fprintf(struct type *type, const struct cu *cu,
 				 conf->suffix ? " " : "", conf->suffix ?: "");
 }
 
-const char *function__prototype(const struct function *func,
-				const struct cu *cu, char *bf, size_t len)
+const char *function__prototype_conf(const struct function *func,
+				     const struct cu *cu,
+				     const struct conf_fprintf *conf,
+				     char *bf, size_t len)
 {
 	FILE *bfp = fmemopen(bf, len, "w");
 
 	if (bfp != NULL) {
-		ftype__fprintf(&func->proto, cu, NULL, 0, 0, 0, true,
-			       &conf_fprintf__defaults, bfp);
+		ftype__fprintf(&func->proto, cu, NULL, 0, 0, 0, true, conf,
+			       bfp);
 		fclose(bfp);
-	} else
+	} else {
+		if (conf->skip_emitting_errors)
+			return NULL;
 		snprintf(bf, len, "<ERROR(%s): fmemopen failed!>", __func__);
+	}
 
 	return bf;
 }
 
+const char *function__prototype(const struct function *func,
+				const struct cu *cu, char *bf, size_t len)
+{
+	return function__prototype_conf(func, cu, &conf_fprintf__defaults,
+					bf, len);
+}
+
 size_t ftype__fprintf_parms(const struct ftype *ftype,
 			    const struct cu *cu, int indent,
 			    const struct conf_fprintf *conf, FILE *fp)
-- 
1.8.3.1

