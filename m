Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DA2436E7D
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 01:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhJUXta (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 19:49:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhJUXt3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Oct 2021 19:49:29 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LLvCI3029246;
        Thu, 21 Oct 2021 19:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=7SONM1/3OJW4x6P2w6KM2U/fEnvBHOOPfoMrGRzQkZ0=;
 b=EdLzuN+1TuYhGysXjYNBh4gY1CxhX3Q8G/Uz4I7fIGBGk8gZjgT5L8NwXuDjTGBqYfi+
 qhqqi6cbEGVAJ4a/jks8E5WAD0QwhnQy9H4xFa//QCxw7Wo4svWrbkj1CYOo/J6TAk6Y
 KY1SSnp5C88Pv4h2ZyTC4PdnUOMHiRhx1CUINpgdOQKRFw7lUHdkQLxTZHtMBKs+vPxX
 4L1JHJckXHkgu9iPvShBcpu0rigzG5T880Xd+trMPXXOMtBH2RSbvDJDfVB8ieKDBwis
 9Ty3ySjoh2PuSGtZ7oVJhW1bv68CD+xDNQbE+Hi9ZBJB0pu1YY+XZboTFiQi/qgtMCqs Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bua9hau3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 19:47:00 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19LNjat7007504;
        Thu, 21 Oct 2021 19:47:00 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bua9hau39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 19:47:00 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19LNgApv019471;
        Thu, 21 Oct 2021 23:46:57 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3bqpcakjec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 23:46:57 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19LNks6Y52625868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 23:46:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A7365204F;
        Thu, 21 Oct 2021 23:46:54 +0000 (GMT)
Received: from vm.lan (unknown [9.145.12.156])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 14DD55204E;
        Thu, 21 Oct 2021 23:46:54 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 0/3] core_reloc fixes for s390
Date:   Fri, 22 Oct 2021 01:46:50 +0200
Message-Id: <20211021234653.643302-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D8yEOBmaanyNP3M_F-vPA4XAu-z7O84v
X-Proofpoint-ORIG-GUID: a_f4-LDWuGXJ9prS8o6wqpXCYxIphM6V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_07,2021-10-21_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210117
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

this series fixes test failures in core_reloc on s390.

Patch 1 fixes a bug in byte order determination.
Patch 2 fixes an endianness issue in bitfield relocation.
Patch 3 fixes an endianness issue in test_core_reloc_mods.

Best regards,
Ilya

Ilya Leoshkevich (3):
  bpf: Use __BYTE_ORDER__ everywhere
  libbpf: Fix relocating big-endian bitfields
  selftests/bpf: Fix test_core_reloc_mods on big-endian machines

 samples/seccomp/bpf-helper.h                       |  8 ++++----
 tools/lib/bpf/bpf_core_read.h                      |  2 +-
 tools/lib/bpf/btf.c                                |  4 ++--
 tools/lib/bpf/btf_dump.c                           |  8 ++++----
 tools/lib/bpf/libbpf.c                             |  4 ++--
 tools/lib/bpf/linker.c                             | 12 ++++++------
 tools/lib/bpf/relo_core.c                          | 13 +++++++++----
 .../testing/selftests/bpf/prog_tests/btf_endian.c  |  6 +++---
 .../selftests/bpf/progs/test_core_reloc_mods.c     |  9 +++++++++
 tools/testing/selftests/bpf/test_sysctl.c          |  4 ++--
 tools/testing/selftests/bpf/verifier/ctx_skb.c     | 14 +++++++-------
 tools/testing/selftests/bpf/verifier/lwt.c         |  2 +-
 .../bpf/verifier/perf_event_sample_period.c        |  6 +++---
 tools/testing/selftests/seccomp/seccomp_bpf.c      |  6 +++---
 14 files changed, 56 insertions(+), 42 deletions(-)

-- 
2.31.1

