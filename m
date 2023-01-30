Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DC568134C
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 15:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbjA3OcU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 09:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237835AbjA3OcA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 09:32:00 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5472A1B572
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 06:30:28 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UAStv8009420;
        Mon, 30 Jan 2023 14:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=ZkJU3BTK7LN6DjlJ53vQ3r3GdppJBKjGGqxCQcsnMxw=;
 b=RDltXSA/QExttXFMOgcpMWJdv5XS3zZLeJxSJHuz0ckXJGXnWJ4hc4RiDZpMV1t44LkH
 6Y+PlroZz9BYM3XMAFfcmdFPprPavRPNub/tQqovf9ydP0grKf7iIXJ0hCew0gGkWiYp
 oQwQ1Jz6eDsA2LLkc0I1UnvLaCU4Yi2QqeRkEv334s76mqvQfkAOVfY+NJgjQIcpadT1
 bSEcTKFTIOscg/mXoCDMBP479ol8P7zAnKDpV0crAw/b68Nu+xs8qgk3KQTShyoo6RRF
 ZxDPwR53M6Sr/9ukIhiypf3zgdeY0IM8xuaBoQs3DaDgW50WiZCWR/5Z5X5KuyXhwlQo QQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvn9tytq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 14:30:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30UDV1XD001501;
        Mon, 30 Jan 2023 14:30:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct54631n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 14:30:07 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30UETrIv020648;
        Mon, 30 Jan 2023 14:30:06 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-214-73.vpn.oracle.com [10.175.214.73])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3nct5462kh-4;
        Mon, 30 Jan 2023 14:30:06 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org, yhs@fb.com, ast@kernel.org, olsajiri@gmail.com,
        eddyz87@gmail.com, sinquersw@gmail.com, timo@incline.eu
Cc:     daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 3/5] btf_encoder: rework btf_encoders__*() API to allow traversal of encoders
Date:   Mon, 30 Jan 2023 14:29:43 +0000
Message-Id: <1675088985-20300-4-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675088985-20300-1-git-send-email-alan.maguire@oracle.com>
References: <1675088985-20300-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_13,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300140
X-Proofpoint-GUID: tJ86XFqPM8F6P3g3KikdmjHgJOCp8eh1
X-Proofpoint-ORIG-GUID: tJ86XFqPM8F6P3g3KikdmjHgJOCp8eh1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To coordinate across multiple encoders at collection time, there
will be a need to access the set of encoders.  Rework the unused
btf_encoders__*() API to facilitate this.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 30 ++++++++++++++++++++++--------
 btf_encoder.h |  6 ------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 44f1905..e20b628 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -30,6 +30,7 @@
 
 #include <errno.h>
 #include <stdint.h>
+#include <pthread.h>
 
 struct elf_function {
 	const char	*name;
@@ -79,21 +80,32 @@ struct btf_encoder {
 	} functions;
 };
 
-void btf_encoders__add(struct list_head *encoders, struct btf_encoder *encoder)
-{
-	list_add_tail(&encoder->node, encoders);
-}
+static LIST_HEAD(encoders);
+static pthread_mutex_t encoders__lock = PTHREAD_MUTEX_INITIALIZER;
 
-struct btf_encoder *btf_encoders__first(struct list_head *encoders)
+/* mutex only needed for add/delete, as this can happen in multiple encoding
+ * threads.  Traversal of the list is currently confined to thread collection.
+ */
+static void btf_encoders__add(struct btf_encoder *encoder)
 {
-	return list_first_entry(encoders, struct btf_encoder, node);
+	pthread_mutex_lock(&encoders__lock);
+	list_add_tail(&encoder->node, &encoders);
+	pthread_mutex_unlock(&encoders__lock);
 }
 
-struct btf_encoder *btf_encoders__next(struct btf_encoder *encoder)
+#define btf_encoders__for_each_encoder(encoder)		\
+	list_for_each_entry(encoder, &encoders, node)
+
+static void btf_encoders__delete(struct btf_encoder *encoder)
 {
-	return list_next_entry(encoder, node);
+	pthread_mutex_lock(&encoders__lock);
+	list_del(&encoder->node);
+	pthread_mutex_unlock(&encoders__lock);
 }
 
+#define btf_encoders__for_each_encoder(encoder)			\
+	list_for_each_entry(encoder, &encoders, node)
+
 #define PERCPU_SECTION ".data..percpu"
 
 /*
@@ -1505,6 +1517,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 
 		if (encoder->verbose)
 			printf("File %s:\n", cu->filename);
+		btf_encoders__add(encoder);
 	}
 out:
 	return encoder;
@@ -1519,6 +1532,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 	if (encoder == NULL)
 		return;
 
+	btf_encoders__delete(encoder);
 	__gobuffer__delete(&encoder->percpu_secinfo);
 	zfree(&encoder->filename);
 	btf__free(encoder->btf);
diff --git a/btf_encoder.h b/btf_encoder.h
index a65120c..34516bb 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -23,12 +23,6 @@ int btf_encoder__encode(struct btf_encoder *encoder);
 
 int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct conf_load *conf_load);
 
-void btf_encoders__add(struct list_head *encoders, struct btf_encoder *encoder);
-
-struct btf_encoder *btf_encoders__first(struct list_head *encoders);
-
-struct btf_encoder *btf_encoders__next(struct btf_encoder *encoder);
-
 struct btf *btf_encoder__btf(struct btf_encoder *encoder);
 
 int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder *other);
-- 
1.8.3.1

