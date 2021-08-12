Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442E93EA764
	for <lists+bpf@lfdr.de>; Thu, 12 Aug 2021 17:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237934AbhHLPS5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Aug 2021 11:18:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57592 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237933AbhHLPS4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Aug 2021 11:18:56 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CFDH8j084951;
        Thu, 12 Aug 2021 11:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=iBSNIpLwOZH9WLiMdpzlQyMXkdlOHBCO7NU1Hq3rJQc=;
 b=fIdCcdze+uT38AzVQ2nT+z3+UB+uTgTBranBAxLV6uGJRgSAaK14x8h5UsPk/K2VjfAh
 9Cn63m9lKk+6evpcdpvWPjQrAhNITDpieDC2yKO1Bind+ENwaPeSz+WEoCJ+ySnmVJM6
 FMadz6O3IHZKYKpDmLwTi7peOp9Xb1bmEs8CaB3T4lNIEfpf+Yg39dBqcQxwZ+1oN+Fw
 4gpL0J1kda/xWb8QjMnTrYCBoMFj+n1OKLMjVQHnLbORpAEoBIIVguJI6N2wajGxwDKo
 R0R1pM1R9Tjj84I1ASoF/G4piZPkItgdKb1FnGzC3dOhtXzCHVxOmo/0ctA4trqVydtP AQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3accug17t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 11:18:19 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17CFDPmj030569;
        Thu, 12 Aug 2021 15:18:17 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3acf0ktndg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 15:18:17 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17CFEvqr55312750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 15:14:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9985EA405B;
        Thu, 12 Aug 2021 15:18:13 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46B4BA4060;
        Thu, 12 Aug 2021 15:18:13 +0000 (GMT)
Received: from vm.lan (unknown [9.145.77.113])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Aug 2021 15:18:13 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf v3 1/2] bpf: clear zext_dst of dead insns
Date:   Thu, 12 Aug 2021 17:18:10 +0200
Message-Id: <20210812151811.184086-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210812151811.184086-1-iii@linux.ibm.com>
References: <20210812151811.184086-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -5CaBHfNFXyqM5x9NqAklYoOA0XTv_up
X-Proofpoint-ORIG-GUID: -5CaBHfNFXyqM5x9NqAklYoOA0XTv_up
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-12_05:2021-08-12,2021-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120098
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

The commits that contributed to this problem are:

1. commit 5aa5bd14c5f8 ("bpf: add initial suite for selftests"), which
   introduced the test with the dead code.
2. commit 5327ed3d44b7 ("bpf: verifier: mark verified-insn with
   sub-register zext flag"), which introduced the zext_dst flag.
3. commit 83a2881903f3 ("bpf: Account for BPF_FETCH in
   insn_has_def32()"), which introduced the sanity check.
4. commit 9183671af6db ("bpf: Fix leakage under speculation on
   mispredicted branches"), which bisect points to.

It's best to fix this on stable branches that contain the second one,
since that's the point where the inconsistency was introduced.

Fixes: 5327ed3d44b7 ("bpf: verifier: mark verified-insn with sub-register zext flag")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f9bda5476ea5..381d3d6f24bc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11663,6 +11663,7 @@ static void sanitize_dead_code(struct bpf_verifier_env *env)
 		if (aux_data[i].seen)
 			continue;
 		memcpy(insn + i, &trap, sizeof(trap));
+		aux_data[i].zext_dst = false;
 	}
 }
 
-- 
2.31.1

