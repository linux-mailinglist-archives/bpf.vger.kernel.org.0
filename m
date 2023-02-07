Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E384A68DEBB
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 18:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjBGRRC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 12:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjBGRQf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 12:16:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2B13E604
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 09:15:47 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317GngBL011626;
        Tue, 7 Feb 2023 17:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=pHtIvD7be9A1K3g+dVBTCm9BEyP5y5tyThnMB9T024U=;
 b=bfrDB8u7GQcqmYOM9dfRSGPL7FHBk0H4zma0vGFuu0m9wfexL8LpdOqoR0+oEbJj3L+r
 02jWs+JT17pD/9m1NFt4xhUDJO9bhwXib5kgrACp3xGsxHOLVjFIn9RfiFBp/63vxUiO
 YwCOyhUE6Kl86zDqnAHyPHVL+HrMmkxbNfJryucDgUUsjApqetV1zyB7rEV6J1RcQ45j
 joxiV8/k6G82iqA0yNKCdAkou99U2gdr876vRQALTk+9bci2u5er4ci9EAbEJVQ8ngJn
 NO6cXJGEXq+DrFAui8SNnoWjxNPdEjRJ93Z0V4Si1w4cZ3GfLsXjQ5l0ZUSfccaJtFd1 xQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe9ne3y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 17:15:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 317GWZ2q007904;
        Tue, 7 Feb 2023 17:15:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdt6e85k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 17:15:23 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 317HF7gU007936;
        Tue, 7 Feb 2023 17:15:22 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-168-65.vpn.oracle.com [10.175.168.65])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3nhdt6e7g6-5;
        Tue, 07 Feb 2023 17:15:22 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 4/8] btf_encoder: Rework btf_encoders__*() API to allow traversal of encoders
Date:   Tue,  7 Feb 2023 17:14:58 +0000
Message-Id: <1675790102-23037-5-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675790102-23037-1-git-send-email-alan.maguire@oracle.com>
References: <1675790102-23037-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_09,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070153
X-Proofpoint-ORIG-GUID: _ogNr1TpffHXZQJikOPrntbusrnkvGzO
X-Proofpoint-GUID: _ogNr1TpffHXZQJikOPrntbusrnkvGzO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To coordinate across multiple encoders at collection time, there will be
a need to access the set of encoders.  Rework the unused
btf_encoders__*() API to facilitate this.

Committer notes:

Removed btf_encoders__for_each_encoder() duplicate define, pointed out
by Jiri Olsa.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@chromium.org>
Cc: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Timo Beckers <timo@incline.eu>
Cc: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org
---
 btf_encoder.c | 36 ++++++++++++++++++++++++++++--------
 btf_encoder.h |  6 ------
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 71f67ae..74ab61b 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -30,6 +30,7 @@
 
 #include <errno.h>
 #include <stdint.h>
+#include <pthread.h>
 
 struct elf_function {
 	const char	*name;
@@ -79,19 +80,36 @@ struct btf_encoder {
 	} functions;
 };
 
-void btf_encoders__add(struct list_head *encoders, struct btf_encoder *encoder)
-{
-	list_add_tail(&encoder->node, encoders);
-}
+static LIST_HEAD(encoders);
+static pthread_mutex_t encoders__lock = PTHREAD_MUTEX_INITIALIZER;
+
+/* mutex only needed for add/delete, as this can happen in multiple encoding
+ * threads.  Traversal of the list is currently confined to thread collection.
+ */
 
-struct btf_encoder *btf_encoders__first(struct list_head *encoders)
+#define btf_encoders__for_each_encoder(encoder)		\
+	list_for_each_entry(encoder, &encoders, node)
+
+static void btf_encoders__add(struct btf_encoder *encoder)
 {
-	return list_first_entry(encoders, struct btf_encoder, node);
+	pthread_mutex_lock(&encoders__lock);
+	list_add_tail(&encoder->node, &encoders);
+	pthread_mutex_unlock(&encoders__lock);
 }
 
-struct btf_encoder *btf_encoders__next(struct btf_encoder *encoder)
+static void btf_encoders__delete(struct btf_encoder *encoder)
 {
-	return list_next_entry(encoder, node);
+	struct btf_encoder *existing = NULL;
+
+	pthread_mutex_lock(&encoders__lock);
+	/* encoder may not have been added to list yet; check. */
+	btf_encoders__for_each_encoder(existing) {
+		if (encoder == existing)
+			break;
+	}
+	if (encoder == existing)
+		list_del(&encoder->node);
+	pthread_mutex_unlock(&encoders__lock);
 }
 
 #define PERCPU_SECTION ".data..percpu"
@@ -1505,6 +1523,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 
 		if (encoder->verbose)
 			printf("File %s:\n", cu->filename);
+		btf_encoders__add(encoder);
 	}
 out:
 	return encoder;
@@ -1519,6 +1538,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
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
2.31.1

