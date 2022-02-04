Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16934A9B6F
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 15:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359399AbiBDOuy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 09:50:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229837AbiBDOux (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 09:50:53 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214EC5af006848;
        Fri, 4 Feb 2022 14:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VCHu/cf1QhL+5aQWhz9GFGCdY+Xy6o9NOl3cx3xXOno=;
 b=numjXpGc21NMN6bqFwOArsFWVjH56Buc/45DCHTluFs/FywtRAu+2DIjcnnHAFPw25iK
 U0n/mqLui9IFX4HVEAk8Ms0o2i4GdaYRQ0B8KD93vlCicES0CkNqPI3a8URgF/qi1i/j
 jT9LJTYIjPP5WgVJbTQL8OklG2QYui9aZtQ8eTcvx2vVUEuMZg7GFJL3I85fL9XTOs00
 Gx3U2KiDEOL86Oiuld42PBh1DshwwczsSIAXtujxy/V5UotVaBibkhwIyrPNUCYWHtbk
 kxihqN/yHbC07J3NaY5Ovb2bweUAir2Upgr7RiWMIWXE+F7F89cgejeEoLFHPh50QzGi EA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx0q52a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 14:50:37 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 214Eo4db028912;
        Fri, 4 Feb 2022 14:50:36 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx0q51g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 14:50:36 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 214EjWYo002486;
        Fri, 4 Feb 2022 14:50:33 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3e0r10dupk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 14:50:33 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 214EoUxt46465386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 14:50:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5766952067;
        Fri,  4 Feb 2022 14:50:30 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BB0F052059;
        Fri,  4 Feb 2022 14:50:29 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 10/11] libbpf: Fix accessing syscall arguments on riscv
Date:   Fri,  4 Feb 2022 15:50:17 +0100
Message-Id: <20220204145018.1983773-11-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204145018.1983773-1-iii@linux.ibm.com>
References: <20220204145018.1983773-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5gr-z2J0-4kGG6hzIjuWK99VZznFdDtk
X-Proofpoint-ORIG-GUID: piNtwq_2A7nTbk-pqZJkAbPf2z-gkMtP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_05,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040082
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

riscv's syscall handlers get "unpacked" arguments instead of a
struct pt_regs pointer. Indicate this to libbpf using
PT_REGS_SYSCALL_REGS macro.

Reported-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/bpf_tracing.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 8629441304df..169d47aa0a79 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -214,6 +214,7 @@
 #define __PT_RC_REG a5
 #define __PT_SP_REG sp
 #define __PT_IP_REG pc
+#define PT_REGS_SYSCALL_REGS(ctx) ctx
 
 #endif
 
-- 
2.34.1

