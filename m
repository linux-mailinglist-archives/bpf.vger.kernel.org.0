Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C49C4A3563
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2019 13:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfH3LHp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Aug 2019 07:07:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726902AbfH3LHp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 30 Aug 2019 07:07:45 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7UB7fsS135647
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2019 07:07:43 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uq0xcv494-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2019 07:07:43 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Fri, 30 Aug 2019 12:07:38 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 30 Aug 2019 12:07:36 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7UB7YCE37683348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 11:07:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC8C411C050;
        Fri, 30 Aug 2019 11:07:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5817211C04A;
        Fri, 30 Aug 2019 11:07:34 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.96.21])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Aug 2019 11:07:34 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Song Liu <liu.song.a23@gmail.com>,
        Yonghong Song <yhs@fb.com>, Andrey Ignatov <rdna@fb.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf v4 0/4] selftests/bpf: fix endianness issues in test_sysctl
Date:   Fri, 30 Aug 2019 13:07:28 +0200
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19083011-0020-0000-0000-000003659CC7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19083011-0021-0000-0000-000021BAF91C
Message-Id: <20190830110732.8966-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=878 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908300121
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Patch 1 is a preparatory commit, which introduces 64-bit endianness
conversion functions.

Patch 2 fixes reading the wrong byte of an int.

Patch 3 improves error reporting.

Patch 4 uses the new conversion functions to fix wrong endianness of
immediates.

v1->v2: Use bpf_ntohl and bpf_be64_to_cpu, drop __bpf_le64_to_cpu.
v2->v3: Split bpf_be64_to_cpu introduction into a separate patch.
        Use the new functions in test_lwt_seg6local.c and
	test_seg6_loop.c.
v3->v4: Improved commit message, split fixes that are not related to
        each other into separate patches.

Ilya Leoshkevich (4):
  selftests/bpf: introduce bpf_cpu_to_be64 and bpf_be64_to_cpu
  selftests/bpf: fix "ctx:write sysctl:write read ok" on s390
  selftests/bpf: improve unexpected success reporting in test_syctl
  selftests/bpf: fix endianness issues in test_sysctl

 tools/testing/selftests/bpf/bpf_endian.h      |  14 ++
 .../selftests/bpf/progs/test_lwt_seg6local.c  |  16 +--
 .../selftests/bpf/progs/test_seg6_loop.c      |   8 +-
 tools/testing/selftests/bpf/test_sysctl.c     | 130 ++++++++++++------
 4 files changed, 107 insertions(+), 61 deletions(-)

-- 
2.21.0

