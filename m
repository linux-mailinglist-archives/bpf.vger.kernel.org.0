Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845193EA62C
	for <lists+bpf@lfdr.de>; Thu, 12 Aug 2021 16:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbhHLOGH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Aug 2021 10:06:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237828AbhHLOGE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Aug 2021 10:06:04 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CE3CYr051531;
        Thu, 12 Aug 2021 10:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=iBSNIpLwOZH9WLiMdpzlQyMXkdlOHBCO7NU1Hq3rJQc=;
 b=AAZGqrFDwRxGQqbEBrNnOphE6lUkqCnhS84QlOT9mVxIuy355IBdTk1WrPnhxdRZcWcu
 dR+5xLc9jUVQisw5Ya+vsz5PfEvTs2jNlFUXVVy39fvChakpbTCpbrY0J9B1G3aBvrzi
 kyvDl9qTGxfk6nq4PF8iLVQkhNcfr65L/xnnIHrlYrOALWPnSPT58cYCRwYYYJ/xlqR+
 58yqFvsmytXkWaGJNE2K78EE7L2zqeqkMy3ZDj+xSnAdLwyhOKhcpeZZWaUR7rBFFi/b
 OQ26G82ji12cPkyXkMZKz2JPUSFUQBLZOHPR0B0fATppNMreUVA1s2GW8lyCFX2W0Lsf hQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3acstnubyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 10:05:27 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17CE3qCn007917;
        Thu, 12 Aug 2021 14:05:25 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3a9ht916cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 14:05:24 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17CE5K0i51904862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 14:05:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BACD711C078;
        Thu, 12 Aug 2021 14:05:20 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73FED11C071;
        Thu, 12 Aug 2021 14:05:20 +0000 (GMT)
Received: from vm.lan (unknown [9.145.77.113])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Aug 2021 14:05:20 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf 1/2] bpf: clear zext_dst of dead insns
Date:   Thu, 12 Aug 2021 16:05:17 +0200
Message-Id: <20210812140518.183178-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210812140518.183178-1-iii@linux.ibm.com>
References: <20210812140518.183178-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jIcCfClnK5ahqJET2-NB-QVmkGCAurzV
X-Proofpoint-ORIG-GUID: jIcCfClnK5ahqJET2-NB-QVmkGCAurzV
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-12_05:2021-08-12,2021-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 impostorscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120091
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

