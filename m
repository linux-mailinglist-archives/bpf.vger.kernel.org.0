Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26A82240FC
	for <lists+bpf@lfdr.de>; Fri, 17 Jul 2020 18:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgGQQ4g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jul 2020 12:56:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728031AbgGQQ4f (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Jul 2020 12:56:35 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06HGXd1a056699;
        Fri, 17 Jul 2020 12:56:23 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32autbh9wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 12:56:23 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06HGoLqm010926;
        Fri, 17 Jul 2020 16:56:21 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 327527kh0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 16:56:21 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06HGuIHc61407314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jul 2020 16:56:18 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69675A405F;
        Fri, 17 Jul 2020 16:56:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDF72A405B;
        Fri, 17 Jul 2020 16:56:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.6.1])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 Jul 2020 16:56:17 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 4/5] s390/bpf: tolerate not converging code shrinking
Date:   Fri, 17 Jul 2020 18:53:25 +0200
Message-Id: <20200717165326.6786-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200717165326.6786-1-iii@linux.ibm.com>
References: <20200717165326.6786-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-17_08:2020-07-17,2020-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007170117
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"BPF_MAXINSNS: Maximum possible literals" unnecessarily falls back to
the interpreter because of failing sanity check in bpf_set_addr. The
problem is that there are a lot of branches that can be shrunk, and
doing so opens up the possibility to shrink even more. This process
does not converge after 3 passes, causing code offsets to change during
the codegen pass, which must never happen.

Fix by inserting nops during codegen pass in order to preserve code
offets.

Fixes: 4e9b4a6883dd ("s390/bpf: Use relative long branches")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 625ebe32b2d1..e68854ab27ae 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -490,6 +490,24 @@ static void save_restore_regs(struct bpf_jit *jit, int op, u32 stack_depth)
 	} while (re <= last);
 }
 
+static void bpf_skip(struct bpf_jit *jit, int size)
+{
+	if (size >= 6 && !is_valid_rel(size)) {
+		/* brcl 0xf,size */
+		EMIT6_PCREL_RIL(0xc0f4000000, size);
+		size -= 6;
+	} else if (size >= 4 && is_valid_rel(size)) {
+		/* brc 0xf,size */
+		EMIT4_PCREL(0xa7f40000, size);
+		size -= 4;
+	}
+	while (size >= 2) {
+		/* bcr 0,%0 */
+		_EMIT2(0x0700);
+		size -= 2;
+	}
+}
+
 /*
  * Emit function prologue
  *
@@ -1610,7 +1628,14 @@ static bool bpf_is_new_addr_sane(struct bpf_jit *jit, int i)
  */
 static int bpf_set_addr(struct bpf_jit *jit, int i)
 {
-	if (!bpf_is_new_addr_sane(jit, i))
+	int delta;
+
+	if (is_codegen_pass(jit)) {
+		delta = jit->prg - jit->addrs[i];
+		if (delta < 0)
+			bpf_skip(jit, -delta);
+	}
+	if (WARN_ON_ONCE(!bpf_is_new_addr_sane(jit, i)))
 		return -1;
 	jit->addrs[i] = jit->prg;
 	return 0;
-- 
2.25.4

