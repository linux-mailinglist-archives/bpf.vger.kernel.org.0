Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B11221880
	for <lists+bpf@lfdr.de>; Thu, 16 Jul 2020 01:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgGOXid (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jul 2020 19:38:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726770AbgGOXid (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Jul 2020 19:38:33 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FNX2ol037451;
        Wed, 15 Jul 2020 19:38:20 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 329x5y9kqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 19:38:20 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06FNQVT9030800;
        Wed, 15 Jul 2020 23:33:18 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 327527jgmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 23:33:18 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06FNVpcI57868624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 23:31:52 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC92FA4060;
        Wed, 15 Jul 2020 23:33:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3226EA4054;
        Wed, 15 Jul 2020 23:33:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.186.215])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Jul 2020 23:33:14 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 0/4] s390/bpf: implement BPF_PROBE_MEM
Date:   Thu, 16 Jul 2020 01:32:57 +0200
Message-Id: <20200715233301.933201-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150171
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

v1 -> v2:

- Add `jit->excnt = 0` in order to fix WARNINGs and fallbacks to the
  interpreter when running extra_pass. This wasn't easy to spot on
  bpf-next, since tests passed anyway. However, on v5.8-rc5 this led
  to panics.

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
 arch/s390/net/bpf_jit_comp.c                  | 139 +++++++++++++++++-
 scripts/sorttable.c                           |  25 ++++
 .../selftests/bpf/prog_tests/bpf_iter.c       |  17 +++
 .../selftests/bpf/progs/bpf_iter_exception.c  |  20 +++
 10 files changed, 273 insertions(+), 40 deletions(-)
 create mode 100644 arch/s390/include/asm/asm-const.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_exception.c

-- 
2.25.4

