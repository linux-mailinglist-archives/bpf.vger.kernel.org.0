Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269073198F4
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 05:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhBLEFM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Feb 2021 23:05:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229457AbhBLEFL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Feb 2021 23:05:11 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11C42UTL040614;
        Thu, 11 Feb 2021 23:04:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=owXRwFE9J6tH8NzDtvnmWrxtUd9bLGAqvsmySnK/62Q=;
 b=FEya19AoRqtjwpH3E6xFwFVdYwEYv7OXEPlYZWUz/vpHtZBnOQPNBeooe8sXHzTXfIYt
 kEM2IUfcq+cG5avURI3EO+abtwNdOS8YtZkCzTlFAxy8cuqJR4MVw62N8r1S7Z+LepwK
 w6TBpGuCJJazxC9BF/YrWl1SLSuRGgwFbPMgAqLmzO0R8kObHq4Vt7ybnvwYPWwRfnVR
 lEpHmLj6318RlQBlT+dAdb3UBWCr/GPGkLPLeKoPydNu9tF1QJlG9gKr8ge7F8tuvjoz
 MB6D73jNQI47rq5mWldZbyuNyZ6EguAtlLVpq1qh/Z98g6Gj2zvhbNLqBP0EnZrlpCQn 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36nj8yg31a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 23:04:15 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11C44F39048180;
        Thu, 11 Feb 2021 23:04:15 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36nj8yg310-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 23:04:15 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11C439oL003635;
        Fri, 12 Feb 2021 04:04:13 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 36hjr7ua0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 04:04:13 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11C440Og21168456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 04:04:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A10142045;
        Fri, 12 Feb 2021 04:04:10 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22BC242042;
        Fri, 12 Feb 2021 04:04:10 +0000 (GMT)
Received: from vm.lan (unknown [9.171.67.27])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Feb 2021 04:04:10 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] bpf: Clear subreg_def for global function return values
Date:   Fri, 12 Feb 2021 05:04:08 +0100
Message-Id: <20210212040408.90109-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_07:2021-02-11,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=946 clxscore=1015 spamscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120026
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test_global_func4 fails on s390 as reported by Yauheni in [1].

The immediate problem is that the zext code includes the instruction,
whose result needs to be zero-extended, into the zero-extension
patchlet, and if this instruction happens to be a branch, then its
delta is not adjusted. As a result, the verifier rejects the program
later.

However, according to [2], as far as the verifier's algorithm is
concerned and as specified by the insn_no_def() function, branching
insns do not define anything. This includes call insns, even though
one might argue that they define %r0.

This means that the real problem is that zero extension kicks in at
all. This happens because clear_caller_saved_regs() sets BPF_REG_0's
subreg_def after global function calls. This can be fixed in many
ways; this patch mimics what helper function call handling already
does.

[1] https://lore.kernel.org/bpf/20200903140542.156624-1-yauheni.kaliuta@redhat.com/
[2] https://lore.kernel.org/bpf/CAADnVQ+2RPKcftZw8d+B1UwB35cpBhpF5u3OocNh90D9pETPwg@mail.gmail.com/

Fixes: 51c39bb1d5d1 ("bpf: Introduce function-by-function verification")
Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index beae700bb56e..183fae996ad0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5211,8 +5211,9 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 					subprog);
 			clear_caller_saved_regs(env, caller->regs);
 
-			/* All global functions return SCALAR_VALUE */
+			/* All global functions return a 64-bit SCALAR_VALUE */
 			mark_reg_unknown(env, caller->regs, BPF_REG_0);
+			caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
 
 			/* continue with next insn after call */
 			return 0;
-- 
2.29.2

