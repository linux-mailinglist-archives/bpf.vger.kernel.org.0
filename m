Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D14224111
	for <lists+bpf@lfdr.de>; Fri, 17 Jul 2020 18:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgGQQ50 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jul 2020 12:57:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727870AbgGQQ5V (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Jul 2020 12:57:21 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06HGWh21080245;
        Fri, 17 Jul 2020 12:57:09 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32ax79473g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 12:57:09 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06HGnf6X027378;
        Fri, 17 Jul 2020 16:57:07 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 327527y40h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 16:57:07 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06HGtoE154591736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jul 2020 16:55:50 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15C21A405C;
        Fri, 17 Jul 2020 16:55:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E7C0A405B;
        Fri, 17 Jul 2020 16:55:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.6.1])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 Jul 2020 16:55:49 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 3/5] s390/bpf: use brcl for jumping to exit_ip if necessary
Date:   Fri, 17 Jul 2020 18:53:24 +0200
Message-Id: <20200717165326.6786-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200717165326.6786-1-iii@linux.ibm.com>
References: <20200717165326.6786-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-17_08:2020-07-17,2020-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=865 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170117
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"BPF_MAXINSNS: Maximum possible literals" test causes panic with
bpf_jit_harden = 2. The reason is that BPF_JMP | BPF_EXIT is always
emitted as brc, however, after removal of JITed image size
limitations, brcl might be required.

Fix by using brcl when necessary.

Fixes: 4e9b4a6883dd ("s390/bpf: Use relative long branches")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 67608f6092f8..625ebe32b2d1 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1358,8 +1358,12 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		last = (i == fp->len - 1) ? 1 : 0;
 		if (last)
 			break;
-		/* j <exit> */
-		EMIT4_PCREL(0xa7f40000, jit->exit_ip - jit->prg);
+		if (!is_first_pass(jit) && can_use_rel(jit, jit->exit_ip))
+			/* brc 0xf, <exit> */
+			EMIT4_PCREL_RIC(0xa7040000, 0xf, jit->exit_ip);
+		else
+			/* brcl 0xf, <exit> */
+			EMIT6_PCREL_RILC(0xc0040000, 0xf, jit->exit_ip);
 		break;
 	/*
 	 * Branch relative (number of skipped instructions) to offset on
-- 
2.25.4

