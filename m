Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A543E32F0C5
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 18:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhCERJb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Mar 2021 12:09:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46120 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231414AbhCERJJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Mar 2021 12:09:09 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125H8VTc083639;
        Fri, 5 Mar 2021 12:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7pTcNla1k4RzwyJh+1dV7FR+0hi73hfEFLyIFh8VVVU=;
 b=RcSV6aOUnXOx+Wa6uEtczYHC1+40Zowga7S/+VhobHbxhY5V5ZX1+bj9vAghsg9NJRXE
 /aJXHFeV/SWDitTUO83+eFzEnm7Ur2XY74WDlaITj+cCpu2eNYF7mAtM1eH5u8aWAR/H
 zV8khq8GzxeKbz0jMZNVxb17vlpEbDEWRZ6xGrGdZO0uLF4xRQSLczUt8OGueWSW7U+m
 4i4+IsssO4VomsfonMeUdynZfgxzgaKsZzeWiSGZquekv5YP7A3o+Gv5P37wSqa7yVzY
 JbxnT/X6XEbJXE75Z8IUfHTiXg9yCIFdKzTGOKygQE2X1Je0xuewgO/aiLTEwSJ3LPZA 9Q== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 373nykn1yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 12:08:57 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 125H7k1G017921;
        Fri, 5 Mar 2021 17:08:56 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 37293ft6mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 17:08:56 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 125H8c8F34341260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Mar 2021 17:08:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35386A4059;
        Fri,  5 Mar 2021 17:08:53 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4271A404D;
        Fri,  5 Mar 2021 17:08:52 +0000 (GMT)
Received: from vm.lan (unknown [9.145.31.74])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  5 Mar 2021 17:08:52 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add BTF_KIND_FLOAT to btf_dump_test_case_syntax
Date:   Fri,  5 Mar 2021 18:08:44 +0100
Message-Id: <20210305170844.151594-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305170844.151594-1-iii@linux.ibm.com>
References: <20210305170844.151594-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_10:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103050086
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Check that dumping various floating-point types produces a valid C
code.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../selftests/bpf/progs/btf_dump_test_case_syntax.c        | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
index 31975c96e2c9..09d8d1e01ed6 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
@@ -205,6 +205,12 @@ struct struct_with_embedded_stuff {
 	int t[11];
 };
 
+struct float_struct {
+	float *f;
+	const double *d;
+	volatile long double *ld;
+};
+
 struct root_struct {
 	enum e1 _1;
 	enum e2 _2;
@@ -219,6 +225,7 @@ struct root_struct {
 	union_fwd_t *_12;
 	union_fwd_ptr_t _13;
 	struct struct_with_embedded_stuff _14;
+	struct float_struct _15;
 };
 
 /* ------ END-EXPECTED-OUTPUT ------ */
-- 
2.29.2

