Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5996C5827B0
	for <lists+bpf@lfdr.de>; Wed, 27 Jul 2022 15:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbiG0N3Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jul 2022 09:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiG0N3Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jul 2022 09:29:24 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594E625586
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 06:29:23 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RDOcjY013429;
        Wed, 27 Jul 2022 13:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=lLY27aftW9IIa4KK9mmwBVT+lN4jf9hls2WhJaMvKGM=;
 b=HTXX4jwt3pA1qpSbPsrUU4IaClYG+h4WJQNPqy1b2ISSJw9qmG0Aaef63nzOR+Q84QfA
 V4LYmBqxgMIjprsDh+KFRAbcmN6afGPyQ6SO8+cMQ7lJSTOIbb25qlk8xNmqi0/JRhes
 ohO/3jsNMkt25BWHHk6WrXH3xxf99bsPhnv9vdSxbM5VC6XjrY3D3HnZGvR6zEi6Qgv9
 G/gSfB/+x6vaRPeXl0Fj/1CrAm/wcm8VUQuWzhgfwSsJeEGTnzPYBlHDBMCqjJGexD16
 xfgshXwOGpPfkVGzNbjpY97CjxiSR4qxm7i616MiXt6Q6R54EZU3YJiUXaYuhKYAdxBA dw== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hk67jr2vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 13:29:11 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26RDL9PM014153;
        Wed, 27 Jul 2022 13:29:10 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma05wdc.us.ibm.com with ESMTP id 3hg943hd27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 13:29:10 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26RDT9qF15205272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 13:29:09 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2F7CAE060;
        Wed, 27 Jul 2022 13:29:08 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41BDDAE05C;
        Wed, 27 Jul 2022 13:29:08 +0000 (GMT)
Received: from fuzzy-bm.sl.cloud9.ibm.com (unknown [9.59.150.27])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 Jul 2022 13:29:08 +0000 (GMT)
From:   Jinghao Jia <jinghao@linux.ibm.com>
To:     bpf@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        mvle@us.ibm.com, jamjoom@us.ibm.com, sahmed@ibm.com,
        Daniel.Williams2@ibm.com, Jinghao Jia <jinghao@linux.ibm.com>
Subject: [PATCH] BPF: Fix potential bad pointer dereference in bpf_sys_bpf
Date:   Wed, 27 Jul 2022 13:29:05 +0000
Message-Id: <20220727132905.45166-1-jinghao@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xncHtaObwusyqvO28UOsPDLKOIOPzwau
X-Proofpoint-ORIG-GUID: xncHtaObwusyqvO28UOsPDLKOIOPzwau
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_04,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011
 spamscore=0 impostorscore=0 mlxlogscore=754 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207270054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf_sys_bpf() helper function allows an eBPF program to load another
eBPF program from within the kernel. In this case the argument union
bpf_attr pointer (as well as the insns and license pointers inside) is a
kernel address instead of a userspace address (which is the case of a
usual bpf() syscall). To make the memory copying process in the syscall
work in both cases, bpfptr_t [1] was introduced to wrap around the
pointer and distinguish its origin. Specifically, when copying memory
contents from a bpfptr_t, a copy_from_user() is performed in case of a
userspace address and a memcpy() is performed for a kernel address [2].

This can lead to problems because the in-kernel pointer is never checked
for validity. If an eBPF syscall program tries to call bpf_sys_bpf()
with a bad insns pointer, say 0xdeadbeef (which is supposed to point to
the start of the instruction array) in the bpf_attr union, memcpy() is
always happy to dereference the bad pointer to cause a un-handle-able
page fault and in turn an oops. However, this is not supposed to happen
because at that point the eBPF program is already verified and should
not cause a memory error. The same issue in userspace is handled
gracefully by copy_from_user(), which would return -EFAULT in such a
case.

Replace memcpy() with the safer copy_from_kernel_nofault() and
strncpy_from_kernel_nofault().

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/include/linux/bpfptr.h
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/include/linux/sockptr.h#n44

Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
---
 include/linux/sockptr.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
index d45902fb4cad..3b8a41c82516 100644
--- a/include/linux/sockptr.h
+++ b/include/linux/sockptr.h
@@ -46,8 +46,7 @@ static inline int copy_from_sockptr_offset(void *dst, sockptr_t src,
 {
 	if (!sockptr_is_kernel(src))
 		return copy_from_user(dst, src.user + offset, size);
-	memcpy(dst, src.kernel + offset, size);
-	return 0;
+	return copy_from_kernel_nofault(dst, src.kernel + offset, size);
 }
 
 static inline int copy_from_sockptr(void *dst, sockptr_t src, size_t size)
@@ -93,12 +92,8 @@ static inline void *memdup_sockptr_nul(sockptr_t src, size_t len)
 
 static inline long strncpy_from_sockptr(char *dst, sockptr_t src, size_t count)
 {
-	if (sockptr_is_kernel(src)) {
-		size_t len = min(strnlen(src.kernel, count - 1) + 1, count);
-
-		memcpy(dst, src.kernel, len);
-		return len;
-	}
+	if (sockptr_is_kernel(src))
+		return strncpy_from_kernel_nofault(dst, src.kernel, count);
 	return strncpy_from_user(dst, src.user, count);
 }
 

base-commit: d295daf505758f9a0e4d05f4ee3bfdfb4192c18f
-- 
2.35.1

