Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF711EC176
	for <lists+bpf@lfdr.de>; Tue,  2 Jun 2020 19:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgFBR53 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jun 2020 13:57:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726019AbgFBR53 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Jun 2020 13:57:29 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 052HX9GS027861;
        Tue, 2 Jun 2020 13:57:17 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31cw8uhjw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 13:57:17 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 052HtVxP023431;
        Tue, 2 Jun 2020 17:57:15 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 31bf482mps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 17:57:15 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 052HtvoR65601808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Jun 2020 17:55:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C562AE053;
        Tue,  2 Jun 2020 17:57:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB118AE045;
        Tue,  2 Jun 2020 17:57:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.174.225])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  2 Jun 2020 17:57:11 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf 2/2] selftests/bpf: Add a default $(CXX) value
Date:   Tue,  2 Jun 2020 19:56:49 +0200
Message-Id: <20200602175649.2501580-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200602175649.2501580-1-iii@linux.ibm.com>
References: <20200602175649.2501580-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-02_13:2020-06-02,2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 mlxlogscore=999 cotscore=-2147483648 priorityscore=1501
 spamscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006020127
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When using make kselftest TARGETS=bpf, tools/bpf is built with
MAKEFLAGS=rR, which causes $(CXX) to be undefined, which in turn causes
the build to fail with

  CXX      test_cpp
/bin/sh: 2: g: not found

Fix by adding a default $(CXX) value, like tools/build/feature/Makefile
already does.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b59cd1042f9d..03017be02fac 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -2,6 +2,7 @@
 include ../../../../scripts/Kbuild.include
 include ../../../scripts/Makefile.arch
 
+CXX ?= $(CROSS_COMPILE)g++
 CURDIR := $(abspath .)
 TOOLSDIR := $(abspath ../../..)
 LIBDIR := $(TOOLSDIR)/lib
-- 
2.25.4

