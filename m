Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD82F69B6F3
	for <lists+bpf@lfdr.de>; Sat, 18 Feb 2023 01:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjBRAiQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 19:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjBRAiP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 19:38:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D148A4E
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 16:37:51 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HLhkA6007323;
        Fri, 17 Feb 2023 23:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=cbK5M5lYnO/a8UFDUfv/NH5Hb2iCgjkQZ7Hs+joTXps=;
 b=PMshrNJS7pX+nUQ8aiA2hmCCxUbSPRwhWRklU2mRQI+oKkCPFkDQ7sRGUUzCisW6TKmZ
 AYNwzoIgMusQOlawF3uI1iJ7DY1uPTQ2IF7qZ9VLNJSzFsgg8eIVhl7eUPeZ7Jp104mi
 AKYN33KrlA9koksKasaJN8GZulIWs3hCtiFGtZuTH+3pA0Fmagdl8P3i3NQz5nmHFPAK
 XaZ4ZKcVfTopRxSdCw5ubXpcPeJDiJqaUWtW2TKwZ9/J+R24bOz/mZ8iyLSgSYSMnYog
 56ACjmfjuvC3HV+Vjj989Umy3UvmseIGGCPS8wtsI7cHV8cDwgEmH7CaWUi/D/ss5OC4 9Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2mtq56f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 23:10:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HKo4vp015379;
        Fri, 17 Feb 2023 23:10:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fas7v6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 23:10:46 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31HNAcmO007180;
        Fri, 17 Feb 2023 23:10:45 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-171-27.vpn.oracle.com [10.175.171.27])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3np1fas7py-3;
        Fri, 17 Feb 2023 23:10:45 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org, olsajiri@gmail.com, ast@kernel.org
Cc:     daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        eddyz87@gmail.com, sinquersw@gmail.com, timo@incline.eu,
        songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 2/4] btf_encoder: exclude functions with unexpected param register use not optimizations
Date:   Fri, 17 Feb 2023 23:10:31 +0000
Message-Id: <1676675433-10583-3-git-send-email-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: LdwKI-w56sQFASbRGq9OwGsfD75K3wFm
X-Proofpoint-ORIG-GUID: LdwKI-w56sQFASbRGq9OwGsfD75K3wFm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A key problem with the existing approach of excluding functions
with optimized-out parameters is that it does not distinguish
between cases where a parameter was passed but not used versus
cases where a parameter is not passed or used.  The latter
is the only problematic case as for the former case, the
expected register states at function call time are as
they would be absent optimization.  Ideally call-site analysis
could tell us what actually happens when a function is called,
but in practice we use a different method to exclude functions
from BTF representation.  If a function clearly violates the
calling-convention expectations, where such a violation
means "parameter X does not use the expected register
as specified in calling conventions", it is excluded.

Note that we continue to mark functions which have optimized-out
parameters as this is good to know, but only actively exclude
functions with unexpected register usage for parameters or
multiple inconsistent function prototypes.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index ea5b47b..da776f4 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -871,14 +871,16 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 
 		/* If saving and we find an existing entry, we want to merge
 		 * observations across both functions, checking that the
-		 * "seen optimized parameters" and "inconsistent prototype"
-		 * status is reflected in the func entry.
+		 * "seen optimized parameters", "inconsistent prototype"
+		 * and "unexpected register" status is reflected in the
+		 * the func entry.
 		 * If the entry is new, record encoder state required
 		 * to add the local function later (encoder + type_id_off)
 		 * such that we can add the function later.
 		 */
 		existing->proto.optimized_parms |= fn->proto.optimized_parms;
-		if (!existing->proto.optimized_parms && !existing->proto.inconsistent_proto &&
+		existing->proto.unexpected_reg |= fn->proto.unexpected_reg;
+		if (!existing->proto.unexpected_reg && !existing->proto.inconsistent_proto &&
 		     !funcs__match(encoder, func, fn))
 			existing->proto.inconsistent_proto = 1;
 	} else {
@@ -940,20 +942,26 @@ static void btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
 			if (!other_fn)
 				continue;
 			fn->proto.optimized_parms |= other_fn->proto.optimized_parms;
+			fn->proto.unexpected_reg |= other_fn->proto.unexpected_reg;
 			if (other_fn->proto.inconsistent_proto)
 				fn->proto.inconsistent_proto = 1;
-			if (!fn->proto.optimized_parms && !fn->proto.inconsistent_proto &&
+			if (!fn->proto.unexpected_reg && !fn->proto.inconsistent_proto &&
 			    !funcs__match(encoder, func, other_fn))
 				fn->proto.inconsistent_proto = 1;
 			other_fn->proto.processed = 1;
 		}
-		if (fn->proto.optimized_parms || fn->proto.inconsistent_proto) {
+		/* do not exclude functions with optimized-out parameters; they
+		 * may still be _called_ with the right parameter values, they
+		 * just do not _use_ them.  Only exclude functions with
+		 * unexpected register use or multiple inconsistent prototypes.
+		 */
+		if (fn->proto.unexpected_reg || fn->proto.inconsistent_proto) {
 			if (encoder->verbose) {
 				const char *name = function__name(fn);
 
 				printf("skipping addition of '%s'(%s) due to %s\n",
 				       name, fn->alias ?: name,
-				       fn->proto.optimized_parms ? "optimized-out parameters" :
+				       fn->proto.unexpected_reg ? "unexpected register used for parameter" :
 								   "multiple inconsistent function prototypes");
 			}
 		} else {
@@ -1856,7 +1864,9 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 						printf("matched function '%s' with '%s'%s\n",
 						       name, func->name,
 						       fn->proto.optimized_parms ?
-						       ", has optimized-out parameters" : "");
+						       ", has optimized-out parameters" :
+						       fn->proto.unexpected_reg ? ", has unexpected register use by params" :
+						       "");
 					fn->alias = func->name;
 				}
 			}
-- 
2.31.1

