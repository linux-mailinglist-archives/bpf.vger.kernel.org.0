Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7108E23097F
	for <lists+bpf@lfdr.de>; Tue, 28 Jul 2020 14:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgG1MCP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jul 2020 08:02:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728636AbgG1MCN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Jul 2020 08:02:13 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06SBWlkw148926;
        Tue, 28 Jul 2020 08:02:02 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32jganpm5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 08:02:01 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06SC0ZLT023181;
        Tue, 28 Jul 2020 12:01:59 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 32gcr0j4h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 12:01:58 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06SC1t7Z55378074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jul 2020 12:01:55 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C012311C058;
        Tue, 28 Jul 2020 12:01:55 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E4E011C050;
        Tue, 28 Jul 2020 12:01:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.173.62])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Jul 2020 12:01:55 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 2/3] samples/bpf: Fix test_map_in_map on s390
Date:   Tue, 28 Jul 2020 14:00:58 +0200
Message-Id: <20200728120059.132256-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200728120059.132256-1-iii@linux.ibm.com>
References: <20200728120059.132256-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-28_07:2020-07-28,2020-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007280088
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

s390 uses socketcall multiplexer instead of individual socket syscalls.
Therefore, "kprobe/" SYSCALL(sys_connect) does not trigger and
test_map_in_map fails. Fix by using "kprobe/__sys_connect" instead.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 samples/bpf/test_map_in_map_kern.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/samples/bpf/test_map_in_map_kern.c b/samples/bpf/test_map_in_map_kern.c
index 8def45c5b697..b0200c8eac09 100644
--- a/samples/bpf/test_map_in_map_kern.c
+++ b/samples/bpf/test_map_in_map_kern.c
@@ -103,10 +103,9 @@ static __always_inline int do_inline_hash_lookup(void *inner_map, u32 port)
 	return result ? *result : -ENOENT;
 }
 
-SEC("kprobe/" SYSCALL(sys_connect))
+SEC("kprobe/__sys_connect")
 int trace_sys_connect(struct pt_regs *ctx)
 {
-	struct pt_regs *real_regs = (struct pt_regs *)PT_REGS_PARM1_CORE(ctx);
 	struct sockaddr_in6 *in6;
 	u16 test_case, port, dst6[8];
 	int addrlen, ret, inline_ret, ret_key = 0;
@@ -114,8 +113,8 @@ int trace_sys_connect(struct pt_regs *ctx)
 	void *outer_map, *inner_map;
 	bool inline_hash = false;
 
-	in6 = (struct sockaddr_in6 *)PT_REGS_PARM2_CORE(real_regs);
-	addrlen = (int)PT_REGS_PARM3_CORE(real_regs);
+	in6 = (struct sockaddr_in6 *)PT_REGS_PARM2_CORE(ctx);
+	addrlen = (int)PT_REGS_PARM3_CORE(ctx);
 
 	if (addrlen != sizeof(*in6))
 		return 0;
-- 
2.25.4

