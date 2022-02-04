Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53ED24A987A
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 12:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347893AbiBDLgV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 06:36:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54560 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358437AbiBDLgT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 06:36:19 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214B3BG2006609;
        Fri, 4 Feb 2022 11:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=32EjQaLO3m2dkGp5VkGq/TCJZnqyRrYV+KxpY+jCeLI=;
 b=YkW7gWvC5+iYIw+eTZz0bkiMKvOBpaAjpFRcoboXdisNxPchQIAC2GGK+TO7a3QMZNxE
 boAyYRcNBDG2aRMVCy9F3Xwk/QviUgJoM3MuL+oHxQ6mhhRr2iIqdR/5WQ82Z8V996s8
 Ez7R3fVGyrv7gebq4Wd6IrugVwAZ9dQPSU6M/8iqmlKMMt7GsX3l+BqJDa9xsPajxFw6
 /i5AdDFp8StWTR2yhomWfC95uKoRE0c2yBObo8iQfvoq5BCzDLOP7EicbKI9fGjTMg3X
 409yCim86LDuDg9F21I4vwVTsphoddEdxTB3B7Ms7FTIw8iVuHNPQGn1RWbCaeFUI/1y hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx0kb56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 11:36:04 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 214BXV49026548;
        Fri, 4 Feb 2022 11:36:03 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx0kb4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 11:36:03 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 214BXU9m027341;
        Fri, 4 Feb 2022 11:36:01 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3e0r10c4em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 11:36:01 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 214BZwGu46530900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 11:35:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25E4611C050;
        Fri,  4 Feb 2022 11:35:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA5E811C058;
        Fri,  4 Feb 2022 11:35:55 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.69.119])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Feb 2022 11:35:55 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf: Use "__se_" prefix on architectures without syscall wrapper
Date:   Fri,  4 Feb 2022 17:05:19 +0530
Message-Id: <013d632aacd3e41290445c0025db6a7055ec6e18.1643973917.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1643973917.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1643973917.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aHnVCSJpMzh-3HQZfwYpBLCb0ovqLnvm
X-Proofpoint-ORIG-GUID: HvY3-ixYfuaPwyy0ftRnOLafKpkA812R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_04,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040063
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On architectures that don't use a syscall wrapper, sys_* function names
are set as an alias of __se_sys_* functions. Due to this, there is no
BTF associated with sys_* function names. This results in some of the
test progs failing to load. Set the SYS_PREFIX to "__se_" to fix this
issue.

Fixes: 38261f369fb905 ("selftests/bpf: Fix probe_user test failure with clang build kernel")
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 0b78bc9b1b4ce5..5bb11fe595a439 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -13,7 +13,7 @@
 #define SYS_PREFIX "__arm64_"
 #else
 #define SYSCALL_WRAPPER 0
-#define SYS_PREFIX ""
+#define SYS_PREFIX "__se_"
 #endif
 
 #endif
-- 
2.34.1

