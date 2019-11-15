Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC77EFDE08
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2019 13:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfKOMhb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Nov 2019 07:37:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727355AbfKOMhb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 Nov 2019 07:37:31 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFCWwgx037002
        for <bpf@vger.kernel.org>; Fri, 15 Nov 2019 07:37:29 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w9nsmedq7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 15 Nov 2019 07:37:29 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Fri, 15 Nov 2019 12:37:27 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 15 Nov 2019 12:37:26 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAFCbO8952101274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 12:37:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D413742041;
        Fri, 15 Nov 2019 12:37:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85D9F4203F;
        Fri, 15 Nov 2019 12:37:24 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.96.62])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 15 Nov 2019 12:37:24 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2] bpf: support doubleword alignment in bpf_jit_binary_alloc
Date:   Fri, 15 Nov 2019 13:37:22 +0100
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111512-0008-0000-0000-0000032F4595
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111512-0009-0000-0000-00004A4E5834
Message-Id: <20191115123722.58462-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_03:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911150117
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently passing alignment greater than 4 to bpf_jit_binary_alloc does
not work: in such cases it silently aligns only to 4 bytes.

On s390, in order to load a constant from memory in a large (>512k) BPF
program, one must use lgrl instruction, whose memory operand must be
aligned on an 8-byte boundary.

This patch makes it possible to request 8-byte alignment from
bpf_jit_binary_alloc, and also makes it issue a warning when an
unsupported alignment is requested.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v1 -> v2: Simply bump alignment to 8, don't try to be too generic.

 include/linux/filter.h | 6 ++++--
 kernel/bpf/core.c      | 4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7a6f8f6f1da4..ad80e9c6111c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -515,10 +515,12 @@ struct sock_fprog_kern {
 	struct sock_filter	*filter;
 };
 
+/* Some arches need doubleword alignment for their instructions and/or data */
+#define BPF_IMAGE_ALIGNMENT 8
+
 struct bpf_binary_header {
 	u32 pages;
-	/* Some arches need word alignment for their instructions */
-	u8 image[] __aligned(4);
+	u8 image[] __aligned(BPF_IMAGE_ALIGNMENT);
 };
 
 struct bpf_prog {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index c1fde0303280..99693f3c4e99 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -31,6 +31,7 @@
 #include <linux/rcupdate.h>
 #include <linux/perf_event.h>
 #include <linux/extable.h>
+#include <linux/log2.h>
 #include <asm/unaligned.h>
 
 /* Registers */
@@ -815,6 +816,9 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 	struct bpf_binary_header *hdr;
 	u32 size, hole, start, pages;
 
+	WARN_ON_ONCE(!is_power_of_2(alignment) ||
+		     alignment > BPF_IMAGE_ALIGNMENT);
+
 	/* Most of BPF filters are really small, but if some of them
 	 * fill a page, allow at least 128 extra bytes to insert a
 	 * random section of illegal instructions.
-- 
2.23.0

