Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7963EA353
	for <lists+bpf@lfdr.de>; Thu, 12 Aug 2021 13:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbhHLLNF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Aug 2021 07:13:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236643AbhHLLNF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Aug 2021 07:13:05 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CB4J3v059494;
        Thu, 12 Aug 2021 07:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8WLtM+aiLH565/fO6EvmwnlQJ/gopHxzEXJqF8sWfls=;
 b=aXpTV88O0lk6pUwKrqYoJ/Tc+I/YSK7dF/WlR7nXRbWpHUMbPiQwAHVSoxOvC/0wkjGD
 jmEs6inQSOpWtgC8ogO8KVkDaZ0/1f7UBP95kqjeUsy1KWTBOan6nBzaHph12oMHbOn4
 mFczA91pnZSGayVKN7zkyslu3kMBexk8Dx3g3eZYHtvWK3MEplUNqoH7Zy78jcAqt5fI
 f3jtue7ZczEiehwI3TaL85bwKChMrdXApTthN4yJUHvZQPRXtBpzNKRq1VCjdQF5tLDC
 osAKIyumZqnfPfcradJcpYmEfoEfslVNO9mcmaTW8ybpE/cygvAK6SRBs96hoOnckfc2 ww== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3acctjaew2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 07:12:27 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17CB7fFW003714;
        Thu, 12 Aug 2021 11:12:25 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3abs2635k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 11:12:25 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17CBCLSV56951280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 11:12:21 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F86FA4824;
        Thu, 12 Aug 2021 11:12:21 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F9B6A4817;
        Thu, 12 Aug 2021 11:12:21 +0000 (GMT)
Received: from vm.lan (unknown [9.145.77.113])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Aug 2021 11:12:21 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] bpf: Clear zext_dst of dead insns
Date:   Thu, 12 Aug 2021 13:12:20 +0200
Message-Id: <20210812111220.181824-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: llqswo0gRoC9tiujB14mW-EtPU4rs8QW
X-Proofpoint-ORIG-GUID: llqswo0gRoC9tiujB14mW-EtPU4rs8QW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-12_03:2021-08-11,2021-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108120073
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"access skb fields ok" verifier test fails on s390 with the "verifier
bug. zext_dst is set, but no reg is defined" message. The first insns
of the test prog are:

   0:	61 01 00 00 00 00 00 00 	ldxw %r0,[%r1+0]
   8:	35 00 00 01 00 00 00 00 	jge %r0,0,1
  10:	61 01 00 08 00 00 00 00 	ldxw %r0,[%r1+8]

and the 3rd one is dead (this does not look intentional to me, but this
is a separate topic).

sanitize_dead_code() converts dead insns into "ja -1", but keeps
zext_dst. When opt_subreg_zext_lo32_rnd_hi32() tries to parse such
an insn, it sees this discrepancy and bails. This problem can be seen
only with JITs whose bpf_jit_needs_zext() returns true.

Fix by clearning dead insns' zext_dst.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5ea2238a6656..e5f2b23bb7c9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11955,6 +11955,7 @@ static void sanitize_dead_code(struct bpf_verifier_env *env)
 		if (aux_data[i].seen)
 			continue;
 		memcpy(insn + i, &trap, sizeof(trap));
+		aux_data[i].zext_dst = false;
 	}
 }
 
-- 
2.31.1

