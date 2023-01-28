Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12DC67F2B4
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjA1AHu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjA1AHl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:07:41 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3AC8B79A
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:07:31 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RNBv0O024305;
        Sat, 28 Jan 2023 00:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MxXWFt5QkQWLJaI7ce/kbTTACtOrubWdkbC/C3TDJyE=;
 b=nal9wq0VjaFeGe0gMtsDKLtPAurBnP+KSEKDvJfaZeeE1RC+PG8gjWwoibeEvWhpHrf/
 9Ft3emVyNBw8VfMyYFr534Hc8L4xIgKb+9s3Q811sbQpqsNoJWqH6qXT9nCycWn3i9qZ
 3RDYmxLesgOeaR3D3ab2RIBonJAC0Xq7Nup8y53P4VSeO3WEPK2cxu0DFwWrocdCeMkO
 EzrkHnM9xYoR0ycpfqDAUtC4ikt8/hPtDxUwQAE69t1ES4gAVMwc6ZTgIxszqNc6fTHz
 iqipBhfGYohBC30YX2l9XcVxO0Th+Wf0j40JKlu7Su5IzIpklkCjOs5eq/JcESAlzwWh Cg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncr2nrxjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:17 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30RA2IgH010179;
        Sat, 28 Jan 2023 00:07:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3n87afdvaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:15 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30S07BE742074474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 00:07:11 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95DC120043;
        Sat, 28 Jan 2023 00:07:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2177620040;
        Sat, 28 Jan 2023 00:07:11 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 28 Jan 2023 00:07:11 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 13/31] selftests/bpf: Increase SIZEOF_BPF_LOCAL_STORAGE_ELEM on s390x
Date:   Sat, 28 Jan 2023 01:06:32 +0100
Message-Id: <20230128000650.1516334-14-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128000650.1516334-1-iii@linux.ibm.com>
References: <20230128000650.1516334-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HT7wjGy_59HLe2XFciH5a8aQPyJqukbM
X-Proofpoint-ORIG-GUID: HT7wjGy_59HLe2XFciH5a8aQPyJqukbM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_15,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=520 mlxscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270220
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

