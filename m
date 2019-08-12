Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC9A78A322
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2019 18:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfHLQST (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Aug 2019 12:18:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726463AbfHLQST (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 12 Aug 2019 12:18:19 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7CGHXaW039030
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2019 12:18:18 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ubb1798vk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2019 12:18:17 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Mon, 12 Aug 2019 17:18:15 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 12 Aug 2019 17:18:14 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7CGICt249348746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Aug 2019 16:18:12 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8144111C05B;
        Mon, 12 Aug 2019 16:18:12 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41C5A11C050;
        Mon, 12 Aug 2019 16:18:12 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.97.155])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Aug 2019 16:18:12 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     daniel@iogearbox.net, ast@kernel.org
Cc:     bpf@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH bpf] s390/bpf: use 32-bit index for tail calls
Date:   Mon, 12 Aug 2019 18:18:07 +0200
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19081216-0028-0000-0000-0000038EE493
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081216-0029-0000-0000-00002450F107
Message-Id: <20190812161807.1400-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120182
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"p runtime/jit: pass > 32bit index to tail_call" fails when
bpf_jit_enable=1, because the tail call is not executed.

This in turn is because the generated code assumes index is 64-bit,
while it must be 32-bit, and as a result prog array bounds check fails,
while it should pass. Even if bounds check would have passed, the code
that follows uses 64-bit index to compute prog array offset.

Fix by using clrj instead of clgrj for comparing index with array size,
and also by using llgfr for truncating index to 32 bits before using it
to compute prog array offset.

Fixes: 6651ee070b31 ("s390/bpf: implement bpf_tail_call() helper")
Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 6299156f9738..955eb355c2fd 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1049,8 +1049,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
 		/* llgf %w1,map.max_entries(%b2) */
 		EMIT6_DISP_LH(0xe3000000, 0x0016, REG_W1, REG_0, BPF_REG_2,
 			      offsetof(struct bpf_array, map.max_entries));
-		/* clgrj %b3,%w1,0xa,label0: if %b3 >= %w1 goto out */
-		EMIT6_PCREL_LABEL(0xec000000, 0x0065, BPF_REG_3,
+		/* clrj %b3,%w1,0xa,label0: if (u32)%b3 >= (u32)%w1 goto out */
+		EMIT6_PCREL_LABEL(0xec000000, 0x0077, BPF_REG_3,
 				  REG_W1, 0, 0xa);
 
 		/*
@@ -1076,8 +1076,10 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
 		 *         goto out;
 		 */
 
-		/* sllg %r1,%b3,3: %r1 = index * 8 */
-		EMIT6_DISP_LH(0xeb000000, 0x000d, REG_1, BPF_REG_3, REG_0, 3);
+		/* llgfr %r1,%b3: %r1 = (u32) index */
+		EMIT4(0xb9160000, REG_1, BPF_REG_3);
+		/* sllg %r1,%r1,3: %r1 *= 8 */
+		EMIT6_DISP_LH(0xeb000000, 0x000d, REG_1, REG_1, REG_0, 3);
 		/* lg %r1,prog(%b2,%r1) */
 		EMIT6_DISP_LH(0xe3000000, 0x0004, REG_1, BPF_REG_2,
 			      REG_1, offsetof(struct bpf_array, ptrs));
-- 
2.21.0

