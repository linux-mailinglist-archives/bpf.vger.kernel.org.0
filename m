Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED4126B851
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 02:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgIPAki (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Sep 2020 20:40:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726514AbgIONEL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 15 Sep 2020 09:04:11 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08FBZEsb024566;
        Tue, 15 Sep 2020 07:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8jc0SXJ1+FJzBin3JWyKBP7mYbU4+vs/pld2JWJcTfM=;
 b=eQnfgOGh4PGhjCkZlzwwcuZz1O7Hg7fGRDGS1rAH0kBADxVR5sEODGIvMafwa7eLY8rv
 hN23x2QLJoHqdLnuphSBT9L5yGvWnO2Y3Q3euOiPbncuogjLMqC/PaVfdv46p3GoHgAn
 VfFgLoYgn0xqT4u5U4x+gKsN4gIhz/6zFPSYT4MRDXud17QOt74RaWCX0BvkRNtq/jaL
 hePyPTj67pQ8de5kg/JeP41y40SPooL7GGlNGbD7x8y3hQKwxY60yQmF6d7oWSY88EAE
 VPh8GiaAuXCjswFm0j7xGzIKx4ubcYcocEdv0H7HuM3G0EJky6cMi3vHuJBeqSri3NHI sg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33jt2awxcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 07:55:30 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08FBq8e8027276;
        Tue, 15 Sep 2020 11:55:28 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 33gny8bhys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 11:55:28 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08FBtPh224314312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 11:55:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2D2BA404D;
        Tue, 15 Sep 2020 11:55:25 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C290A4040;
        Tue, 15 Sep 2020 11:55:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.7.183])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Sep 2020 11:55:25 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Song Liu <song@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RESEND bpf-next] samples/bpf: Fix test_map_in_map on s390
Date:   Tue, 15 Sep 2020 13:55:19 +0200
Message-Id: <20200915115519.3769807-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_08:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 mlxscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009150100
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

s390 uses socketcall multiplexer instead of individual socket syscalls.
Therefore, "kprobe/" SYSCALL(sys_connect) does not trigger and
test_map_in_map fails. Fix by using "kprobe/__sys_connect" instead.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

Previous discussion:
https://lore.kernel.org/bpf/20200728120059.132256-3-iii@linux.ibm.com

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

