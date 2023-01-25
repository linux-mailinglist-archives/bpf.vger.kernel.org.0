Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D61567BEC5
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 22:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbjAYVj5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 16:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbjAYVjy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 16:39:54 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C526943902
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 13:39:42 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKLcxc010746;
        Wed, 25 Jan 2023 21:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MxXWFt5QkQWLJaI7ce/kbTTACtOrubWdkbC/C3TDJyE=;
 b=GAsimhYFHo2Rt7/Au3RMJVIQ3W5MbS9tyUc05rsZus5oX9rNPk+mkhY+c9EVhaA64EQ9
 3h+aukEoD4NNYs8cQS2gJ155bmBPkQBfu50+2Cf8IkvaeBeRzEKpBAhzeTewZU7ejgs5
 sK+eNZrUVtGI3R9MjiXtYp5TBXTT2qZ5hBGP/oT/dmB8mzLQNyeL6s7SpSOYB+wwZ2ek
 hs/3SxaN/FhhiwOy0qIUeMbsKSeGCK0oZxQG+8PfoLwMl1o9kOrAO+Bsn/L0uWyLMeJv
 J00HzMquczUDrZLPbfN9e92BreeQ7zhsconOUXtRW8DuAvXXd7ePGLi1TT8caquQhLCZ ug== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nb8n9edxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:29 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PE9hpP016211;
        Wed, 25 Jan 2023 21:39:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3n87p6c1e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PLdNO749938784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 21:39:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFFDA20043;
        Wed, 25 Jan 2023 21:39:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A18020040;
        Wed, 25 Jan 2023 21:39:23 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.209.149])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 21:39:23 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 12/24] selftests/bpf: Increase SIZEOF_BPF_LOCAL_STORAGE_ELEM on s390x
Date:   Wed, 25 Jan 2023 22:38:05 +0100
Message-Id: <20230125213817.1424447-13-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125213817.1424447-1-iii@linux.ibm.com>
References: <20230125213817.1424447-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0-fqnCG-g0HcsRt0aFLzIDM2VJzftpih
X-Proofpoint-ORIG-GUID: 0-fqnCG-g0HcsRt0aFLzIDM2VJzftpih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=571 malwarescore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250193
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

sizeof(struct bpf_local_storage_elem) is 512 on s390x:

    struct bpf_local_storage_elem {
            struct hlist_node          map_node;             /*     0    16 */
            struct hlist_node          snode;                /*    16    16 */
            struct bpf_local_storage * local_storage;        /*    32     8 */
            struct callback_head       rcu __attribute__((__aligned__(8))); /*    40    16 */

            /* XXX 200 bytes hole, try to pack */

            /* --- cacheline 1 boundary (256 bytes) --- */
            struct bpf_local_storage_data sdata __attribute__((__aligned__(256))); /*   256     8 */

            /* size: 512, cachelines: 2, members: 5 */
            /* sum members: 64, holes: 1, sum holes: 200 */
            /* padding: 248 */
            /* forced alignments: 2, forced holes: 1, sum forced holes: 200 */
    } __attribute__((__aligned__(256)));

As the existing comment suggests, use a larger number in order to be
future-proof.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/netcnt_common.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/netcnt_common.h b/tools/testing/selftests/bpf/netcnt_common.h
index 0ab1c88041cd..2d4a58e4e39c 100644
--- a/tools/testing/selftests/bpf/netcnt_common.h
+++ b/tools/testing/selftests/bpf/netcnt_common.h
@@ -8,11 +8,11 @@
 
 /* sizeof(struct bpf_local_storage_elem):
  *
- * It really is about 128 bytes on x86_64, but allocate more to account for
- * possible layout changes, different architectures, etc.
+ * It is about 128 bytes on x86_64 and 512 bytes on s390x, but allocate more to
+ * account for possible layout changes, different architectures, etc.
  * The kernel will wrap up to PAGE_SIZE internally anyway.
  */
-#define SIZEOF_BPF_LOCAL_STORAGE_ELEM		256
+#define SIZEOF_BPF_LOCAL_STORAGE_ELEM		768
 
 /* Try to estimate kernel's BPF_LOCAL_STORAGE_MAX_VALUE_SIZE: */
 #define BPF_LOCAL_STORAGE_MAX_VALUE_SIZE	(0xFFFF - \
-- 
2.39.1

