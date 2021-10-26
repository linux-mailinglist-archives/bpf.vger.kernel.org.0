Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109AB43A995
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 03:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhJZBLS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 21:11:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6980 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236018AbhJZBLR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 21:11:17 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PLW3AK005703;
        Tue, 26 Oct 2021 01:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=oJcj0bwXRu/VwnBMVxZyVRbcfqa4HlnBXlQ44yGofss=;
 b=LUR5ffDp/SlHzO4URlMznJmhhhYktfnq02nJ9axaPHyFyRxgnaXZ0dY7P1GywcVsIZC4
 TiWT5ZLQG90tm3nN4yCaHO0tNRv6r3k3g0uN73f8XvnFdEX9jnIZYOi4n3NlL+gjsG7a
 k9YCXGGwcwkJVdoZtr8QqnUlhNSOvjyhbdw+O87muUiVil5fOEezYt1cJUzgxzCR4nFL
 x3gynCHxysFCYIko8ZdHXHoiIvxLXDNy9zm29ixN9/1KNuZal4SRerWnQjpKFWGHmcng
 VTXTvXOH+zvgHRnV3AVypn4M9NgmANdCaE6HedFWE/ML1M7yU+JDcNbMHXuQyUCOdUNd Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bx4k3bwdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 01:08:42 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19Q0gOHe031494;
        Tue, 26 Oct 2021 01:08:42 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bx4k3bwd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 01:08:41 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19Q12LC9009087;
        Tue, 26 Oct 2021 01:08:39 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3bx4esrt94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 01:08:39 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19Q18anM7012964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Oct 2021 01:08:36 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 398CF42045;
        Tue, 26 Oct 2021 01:08:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C933C4203F;
        Tue, 26 Oct 2021 01:08:35 +0000 (GMT)
Received: from vm.lan (unknown [9.145.12.156])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Oct 2021 01:08:35 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 5/6] selftests/seccomp: Use __BYTE_ORDER__
Date:   Tue, 26 Oct 2021 03:08:30 +0200
Message-Id: <20211026010831.748682-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026010831.748682-1-iii@linux.ibm.com>
References: <20211026010831.748682-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: esPN6FNWr_EJbCyDIJMAuHLgO1iyj2zG
X-Proofpoint-ORIG-GUID: 8v0lynQ7E1XuEv_uhhMN8G-u7BTtjWVR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_07,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110260001
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use the compiler-defined __BYTE_ORDER__ instead of the libc-defined
__BYTE_ORDER for consistency.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 1d64891e6492..d425688cf59c 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -276,12 +276,12 @@ int seccomp(unsigned int op, unsigned int flags, void *args)
 }
 #endif
 
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 #define syscall_arg(_n) (offsetof(struct seccomp_data, args[_n]))
-#elif __BYTE_ORDER == __BIG_ENDIAN
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 #define syscall_arg(_n) (offsetof(struct seccomp_data, args[_n]) + sizeof(__u32))
 #else
-#error "wut? Unknown __BYTE_ORDER?!"
+#error "wut? Unknown __BYTE_ORDER__?!"
 #endif
 
 #define SIBLING_EXIT_UNKILLED	0xbadbeef
-- 
2.31.1

