Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED4F100B14
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2019 19:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfKRSEI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Nov 2019 13:04:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbfKRSEI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 18 Nov 2019 13:04:08 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAII2ctt087907
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 13:04:07 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2way8mhrsq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 13:04:07 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Mon, 18 Nov 2019 18:04:05 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Nov 2019 18:04:02 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAII41jQ56557720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 18:04:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51A6FAE045;
        Mon, 18 Nov 2019 18:04:01 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 092E7AE055;
        Mon, 18 Nov 2019 18:04:01 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.97.207])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Nov 2019 18:04:00 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 3/6] s390/bpf: load literal pool register using larl
Date:   Mon, 18 Nov 2019 19:03:37 +0100
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118180340.68373-1-iii@linux.ibm.com>
References: <20191118180340.68373-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111818-0028-0000-0000-000003BA4E39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111818-0029-0000-0000-0000247D6861
Message-Id: <20191118180340.68373-4-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_05:2019-11-15,2019-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911180154
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently literal pool register is loaded using basr, which makes it
point not to the beginning of the literal pool, but rather to the next
instruction. In case JITed code is larger than 512k, this renders
literal pool register absolutely useless due to long displacement range
restrictions.

The solution is to use larl to make literal pool register point to the
very beginning of the literal pool. This makes it always possible to
address 512k worth of literal pool entries using long displacement.

However, for short programs, in which the entire literal pool is covered
by basr-generated base, it is still beneficial to use basr, since it is
4 bytes shorter than larl.

Detect situations when basr-generated base does not cover the entire
literal pool, and in such cases use larl instead.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index bb0215d290f4..964a09fd10f1 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -352,6 +352,15 @@ static bool can_use_rel(struct bpf_jit *jit, int off)
 	return is_valid_rel(off - jit->prg);
 }
 
+/*
+ * Return whether given displacement can be encoded using
+ * Long-Displacement Facility
+ */
+static bool is_valid_ldisp(int disp)
+{
+	return disp >= -524288 && disp <= 524287;
+}
+
 /*
  * Fill whole space with illegal instructions
  */
@@ -476,9 +485,16 @@ static void bpf_jit_prologue(struct bpf_jit *jit, u32 stack_depth)
 	save_restore_regs(jit, REGS_SAVE, stack_depth);
 	/* Setup literal pool */
 	if (is_first_pass(jit) || (jit->seen & SEEN_LITERAL)) {
-		/* basr %r13,0 */
-		EMIT2(0x0d00, REG_L, REG_0);
-		jit->base_ip = jit->prg;
+		if (!is_first_pass(jit) &&
+		    is_valid_ldisp(jit->size - (jit->prg + 2))) {
+			/* basr %l,0 */
+			EMIT2(0x0d00, REG_L, REG_0);
+			jit->base_ip = jit->prg;
+		} else {
+			/* larl %l,lit32_start */
+			EMIT6_PCREL_RILB(0xc0000000, REG_L, jit->lit32_start);
+			jit->base_ip = jit->lit32_start;
+		}
 	}
 	/* Setup stack and backchain */
 	if (is_first_pass(jit) || (jit->seen & SEEN_STACK)) {
-- 
2.23.0

