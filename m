Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50D7220CF5
	for <lists+bpf@lfdr.de>; Wed, 15 Jul 2020 14:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgGOMc4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jul 2020 08:32:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726652AbgGOMcz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Jul 2020 08:32:55 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FCWNrA077225;
        Wed, 15 Jul 2020 08:32:43 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3292unu6ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 08:32:43 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06FCUCo0002414;
        Wed, 15 Jul 2020 12:32:41 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 327527j7y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 12:32:41 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06FCWYoF54657434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 12:32:34 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F41CE4C044;
        Wed, 15 Jul 2020 12:32:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 868CE4C04E;
        Wed, 15 Jul 2020 12:32:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.186.215])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Jul 2020 12:32:33 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/4] s390/bpf: implement BPF_PROBE_MEM
Date:   Wed, 15 Jul 2020 14:32:23 +0200
Message-Id: <20200715123227.912866-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_10:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 mlxlogscore=934 bulkscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150102
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series implements BPF_PROBE_MEM opcode, which is used in BPF
programs that walk chains of kernel pointers. It consists of two parts:
patches 1 and 2 enhance s390 exception table infrastructure, patches 3
and 4 contains the actual implementation and the test.

We would like to take this series via s390 tree, because it contains
dependent s390 extable and bpf jit changes. However, it would be great
if someone knowledgeable could review patches 3 and 4.

Ilya Leoshkevich (4):
  s390/kernel: unify EX_TABLE* implementations
  s390/kernel: expand the exception table logic to allow new handling
    options
  s390/bpf: implement BPF_PROBE_MEM
  selftests/bpf: add exception handling test

 arch/s390/include/asm/asm-const.h             |  12 ++
 arch/s390/include/asm/extable.h               |  50 ++++++-
 arch/s390/include/asm/linkage.h               |  35 ++---
 arch/s390/kernel/kprobes.c                    |   4 +-
 arch/s390/kernel/traps.c                      |   7 +-
 arch/s390/mm/fault.c                          |   4 +-
 arch/s390/net/bpf_jit_comp.c                  | 138 +++++++++++++++++-
 scripts/sorttable.c                           |  25 ++++
 .../selftests/bpf/prog_tests/bpf_iter.c       |  17 +++
 .../selftests/bpf/progs/bpf_iter_exception.c  |  20 +++
 10 files changed, 272 insertions(+), 40 deletions(-)
 create mode 100644 arch/s390/include/asm/asm-const.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_exception.c

-- 
2.25.4

