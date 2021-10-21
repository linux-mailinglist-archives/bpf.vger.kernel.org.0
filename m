Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDDC436E7F
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 01:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhJUXtb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 19:49:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230500AbhJUXta (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Oct 2021 19:49:30 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LNPGhj004424;
        Thu, 21 Oct 2021 19:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UMmsHuwqogpihFTHrWTJl8fiUXfbQZqrId5jnEUVJss=;
 b=f2ysCjxevJq/uFOlZbJePmpMTO5C6PgKwcOREA6gW7ScN/v35pobK89dFp7YpAZ2TPNb
 cxPumgFaogAqY8s2C40LMhHKJxiy/YaCpaAnkLibrBswlSxPkZUYpp+VAlsNRtHGwBPO
 CP2LdvsUs3EGk3d4Hy+llxa6wljDCazO56gcn9+aUamXJ2APVRsuV0qhh13stWnKEeOs
 0BsE87nKyRDFj44C/qg75EXcBrz+h7Yc2egD7z3RXqqJ5GMfSnG2UJPGfcPNtBYwaqkq
 yxAwJjvfC5hB2NRb2PR8xR4IFqE16rB06FvSKZW5v/gdbg77/xl8bCKaWhxkFt7G/swa Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bucwypkr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 19:47:02 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19LNYADJ025801;
        Thu, 21 Oct 2021 19:47:02 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bucwypkqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 19:47:02 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19LNfqk0014085;
        Thu, 21 Oct 2021 23:46:59 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3bqp0kkmnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 23:46:59 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19LNkuFt65798512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 23:46:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9ACA652052;
        Thu, 21 Oct 2021 23:46:56 +0000 (GMT)
Received: from vm.lan (unknown [9.145.12.156])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3AA715204E;
        Thu, 21 Oct 2021 23:46:56 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Fix test_core_reloc_mods on big-endian machines
Date:   Fri, 22 Oct 2021 01:46:53 +0200
Message-Id: <20211021234653.643302-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211021234653.643302-1-iii@linux.ibm.com>
References: <20211021234653.643302-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XvhIFmecTcCB0QvqQ8D2u4C4Oqg0ajex
X-Proofpoint-GUID: o4IHVnuY80lBux8vtUVB5h6hMyDuMULP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_07,2021-10-21_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210117
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is the same as commit d164dd9a5c08 ("selftests/bpf: Fix
test_core_autosize on big-endian machines"), but for
test_core_reloc_mods.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/test_core_reloc_mods.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_mods.c b/tools/testing/selftests/bpf/progs/test_core_reloc_mods.c
index 8b533db4a7a5..b2ded497572a 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_mods.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_mods.c
@@ -42,7 +42,16 @@ struct core_reloc_mods {
 	core_reloc_mods_substruct_t h;
 };
 
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 #define CORE_READ(dst, src) bpf_core_read(dst, sizeof(*(dst)), src)
+#else
+#define CORE_READ(dst, src) ({ \
+	int __sz = sizeof(*(dst)) < sizeof(*(src)) ? sizeof(*(dst)) : \
+						     sizeof(*(src)); \
+	bpf_core_read((char *)(dst) + sizeof(*(dst)) - __sz, __sz, \
+		      (const char *)(src) + sizeof(*(src)) - __sz); \
+})
+#endif
 
 SEC("raw_tracepoint/sys_enter")
 int test_core_mods(void *ctx)
-- 
2.31.1

