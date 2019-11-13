Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFEBFB5D1
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2019 18:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKMRAS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Nov 2019 12:00:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726195AbfKMRAS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 Nov 2019 12:00:18 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADGvh73084632
        for <bpf@vger.kernel.org>; Wed, 13 Nov 2019 12:00:17 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w8kkkdk73-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 Nov 2019 12:00:16 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Wed, 13 Nov 2019 17:00:12 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Nov 2019 17:00:10 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xADH09xB54198488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 17:00:09 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38D6B4C063;
        Wed, 13 Nov 2019 17:00:09 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00C824C04E;
        Wed, 13 Nov 2019 17:00:09 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.98.44])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Nov 2019 17:00:08 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] bpf: make bpf_jit_binary_alloc support alignment > 4
Date:   Wed, 13 Nov 2019 18:00:05 +0100
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111317-0012-0000-0000-0000036358DA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111317-0013-0000-0000-0000219ECE9B
Message-Id: <20191113170005.48813-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-13_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911130147
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently passing alignment greater than 4 to bpf_jit_binary_alloc does
not work: in such cases it aligns only to 4 bytes.

However, this is required on s390, where in order to load a constant
from memory in a large (>512k) BPF program, one must use lgrl
instruction, whose memory operand must be aligned on an 8-byte boundary.

This patch makes it possible to request an arbitrary power-of-2
alignment from bpf_jit_binary_alloc by allocating extra padding bytes
and aligning the resulting pointer rather than the start offset.

An alternative would be to simply increase the alignment of
bpf_binary_header.image to 8, but this would increase the risk of
wasting a page on arches that don't need it, and would also be
insufficient in case someone needs e.g. 16-byte alignment in the
future.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 include/linux/filter.h |  6 ++++--
 kernel/bpf/core.c      | 22 +++++++++++++++++-----
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7a6f8f6f1da4..351a31eec24b 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -515,10 +515,12 @@ struct sock_fprog_kern {
 	struct sock_filter	*filter;
 };
 
+/* Some arches need word alignment for their instructions */
+#define BPF_IMAGE_ALIGNMENT 4
+
 struct bpf_binary_header {
 	u32 pages;
-	/* Some arches need word alignment for their instructions */
-	u8 image[] __aligned(4);
+	u8 image[] __aligned(BPF_IMAGE_ALIGNMENT);
 };
 
 struct bpf_prog {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index c1fde0303280..75dd3a43ada0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -31,6 +31,8 @@
 #include <linux/rcupdate.h>
 #include <linux/perf_event.h>
 #include <linux/extable.h>
+#include <linux/kernel.h>
+#include <linux/log2.h>
 #include <asm/unaligned.h>
 
 /* Registers */
@@ -812,14 +814,20 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 		     unsigned int alignment,
 		     bpf_jit_fill_hole_t bpf_fill_ill_insns)
 {
+	u32 size, hole, start, pages, padding;
 	struct bpf_binary_header *hdr;
-	u32 size, hole, start, pages;
+
+	WARN_ON_ONCE(!is_power_of_2(alignment));
+	if (alignment <= BPF_IMAGE_ALIGNMENT)
+		padding = 0;
+	else
+		padding = alignment - BPF_IMAGE_ALIGNMENT + 1;
 
 	/* Most of BPF filters are really small, but if some of them
 	 * fill a page, allow at least 128 extra bytes to insert a
 	 * random section of illegal instructions.
 	 */
-	size = round_up(proglen + sizeof(*hdr) + 128, PAGE_SIZE);
+	size = round_up(proglen + sizeof(*hdr) + padding + 128, PAGE_SIZE);
 	pages = size / PAGE_SIZE;
 
 	if (bpf_jit_charge_modmem(pages))
@@ -834,12 +842,16 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 	bpf_fill_ill_insns(hdr, size);
 
 	hdr->pages = pages;
-	hole = min_t(unsigned int, size - (proglen + sizeof(*hdr)),
+	hole = min_t(unsigned int,
+		     size - (proglen + sizeof(*hdr) + padding),
 		     PAGE_SIZE - sizeof(*hdr));
-	start = (get_random_int() % hole) & ~(alignment - 1);
+	start = get_random_int() % hole;
 
 	/* Leave a random number of instructions before BPF code. */
-	*image_ptr = &hdr->image[start];
+	if (alignment <= BPF_IMAGE_ALIGNMENT)
+		*image_ptr = &hdr->image[start & ~(alignment - 1)];
+	else
+		*image_ptr = PTR_ALIGN(&hdr->image[start], alignment);
 
 	return hdr;
 }
-- 
2.23.0

