Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393EB22411A
	for <lists+bpf@lfdr.de>; Fri, 17 Jul 2020 18:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgGQQ5m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jul 2020 12:57:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727101AbgGQQ5m (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Jul 2020 12:57:42 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06HGXVGp111927;
        Fri, 17 Jul 2020 12:57:30 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32axd2mynq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 12:57:29 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06HGoclJ016655;
        Fri, 17 Jul 2020 16:57:27 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 32b6jsr8tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 16:57:27 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06HGu1Dt52756758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jul 2020 16:56:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C99FBA405F;
        Fri, 17 Jul 2020 16:57:24 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51817A405B;
        Fri, 17 Jul 2020 16:57:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.6.1])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 Jul 2020 16:57:24 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 5/5] s390/bpf: use bpf_skip() in bpf_jit_prologue()
Date:   Fri, 17 Jul 2020 18:53:26 +0200
Message-Id: <20200717165326.6786-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200717165326.6786-1-iii@linux.ibm.com>
References: <20200717165326.6786-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-17_08:2020-07-17,2020-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170115
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that we have bpf_skip() for emitting nops, use it in
bpf_jit_prologue() in order to reduce code duplication.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index e68854ab27ae..be4b8532dd3c 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -520,10 +520,11 @@ static void bpf_jit_prologue(struct bpf_jit *jit, u32 stack_depth)
 		/* xc STK_OFF_TCCNT(4,%r15),STK_OFF_TCCNT(%r15) */
 		_EMIT6(0xd703f000 | STK_OFF_TCCNT, 0xf000 | STK_OFF_TCCNT);
 	} else {
-		/* j tail_call_start: NOP if no tail calls are used */
-		EMIT4_PCREL(0xa7f40000, 6);
-		/* bcr 0,%0 */
-		EMIT2(0x0700, 0, REG_0);
+		/*
+		 * There are no tail calls. Insert nops in order to have
+		 * tail_call_start at a predictable offset.
+		 */
+		bpf_skip(jit, 6);
 	}
 	/* Tail calls have to skip above initialization */
 	jit->tail_call_start = jit->prg;
-- 
2.25.4

