Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38DC4A030E
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2019 15:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfH1NW2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Aug 2019 09:22:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50750 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726394AbfH1NW2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Aug 2019 09:22:28 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SDJiEb157007
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2019 09:22:27 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2unqr3xnxa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2019 09:22:22 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Wed, 28 Aug 2019 14:22:20 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 28 Aug 2019 14:22:18 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7SDLsrd38076802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 13:21:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A547A4054;
        Wed, 28 Aug 2019 13:22:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4012AA4062;
        Wed, 28 Aug 2019 13:22:16 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.98.121])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 13:22:16 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf v3 0/2] selftests/bpf: fix endianness issues in test_sysctl
Date:   Wed, 28 Aug 2019 15:22:12 +0200
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19082813-0028-0000-0000-00000394E866
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082813-0029-0000-0000-00002457250C
Message-Id: <20190828132214.68828-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=761 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280143
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The first patch is a preparatory commit, which introduces 64-bit
endianness conversion functions.

The second patch is an actual fix.

v1->v2: Use bpf_ntohl and bpf_be64_to_cpu, drop __bpf_le64_to_cpu.
v2->v3: Split bpf_be64_to_cpu introduction into a separate patch.
        Use the new functions in test_lwt_seg6local.c and
	test_seg6_loop.c.

Ilya Leoshkevich (2):
  selftests/bpf: introduce bpf_cpu_to_be64 and bpf_be64_to_cpu
  selftests/bpf: fix endianness issues in test_sysctl

 tools/testing/selftests/bpf/bpf_endian.h      |  14 ++
 .../selftests/bpf/progs/test_lwt_seg6local.c  |  16 +--
 .../selftests/bpf/progs/test_seg6_loop.c      |   8 +-
 tools/testing/selftests/bpf/test_sysctl.c     | 130 ++++++++++++------
 4 files changed, 107 insertions(+), 61 deletions(-)

-- 
2.21.0

