Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FF331F402
	for <lists+bpf@lfdr.de>; Fri, 19 Feb 2021 03:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229474AbhBSC0u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 21:26:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30526 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229468AbhBSC0t (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Feb 2021 21:26:49 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11J21AuK160534;
        Thu, 18 Feb 2021 21:25:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=KgyAyBOcYFwaiUbqX79haC7255x2675kRkkr0NTa73w=;
 b=XzkuuC4pqGdJJFtCkuHLTfwtdqaaXelmR6VfDckzR47Nv3H08JpvTl1lyQCYkrK8b5Tr
 mmH0eDiOY3yVwdAYScmDA3RXAQMy5Duf0p8L5fp9HuzXmBvZo773ZFH72bBC3j1Ac6xX
 rtHVfgTCdml3Pb6wgts6k4QW5Ml30MlCUba5M98ZHRX4tMAF5okoSNQMGf3oFY1OTcTe
 D8B5t3DHZogK7NaGssYa7YMC8sfWdEImBBHWd/HQxBJQregFtKj/E8MSsWZ+VyvWEvMf
 Ct0xFwGxWCupR15TuTr17hsoqquRr/1Xyrz7R/DLNBvuCdEDNqvk+A5nsTmSwfg2HYn0 Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36t3vx0sqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 21:25:54 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11J2PsQu063885;
        Thu, 18 Feb 2021 21:25:54 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36t3vx0sqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 21:25:54 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11J2MpFO025472;
        Fri, 19 Feb 2021 02:25:52 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 36p6d8apvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 02:25:52 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11J2PbYp28967296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 02:25:37 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F0ECA4040;
        Fri, 19 Feb 2021 02:25:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEB8AA404D;
        Fri, 19 Feb 2021 02:25:48 +0000 (GMT)
Received: from vm.lan (unknown [9.145.178.56])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Feb 2021 02:25:48 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 bpf-next 0/6] Add BTF_KIND_FLOAT support
Date:   Fri, 19 Feb 2021 03:25:37 +0100
Message-Id: <20210219022543.20893-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_14:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190007
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some BPF programs compiled on s390 fail to load, because s390
arch-specific linux headers contain float and double types.
    
Introduce support for such types by representing them using the new
BTF_KIND_FLOAT. This series deals with libbpf, bpftool, in-kernel BTF
parser as well as selftests and documentation.

There are also pahole and LLVM parts:

* https://github.com/iii-i/dwarves/commit/btf-kind-float-v2
* https://reviews.llvm.org/D83289

but they should go in after the libbpf part is integrated.

---

v0: https://lore.kernel.org/bpf/20210210030317.78820-1-iii@linux.ibm.com/
v0 -> v1: Per Andrii's suggestion, remove the unnecessary trailing u32.

v1: https://lore.kernel.org/bpf/20210216011216.3168-1-iii@linux.ibm.com/
v1 -> v2: John noticed that sanitization corrupts BTF, because new and
          old sizes don't match. Per Yonghong's suggestion, use a
          modifier type (which has the same size as the float type) as
          a replacement.
          Per Yonghong's suggestion, add size and alignment checks to
          the kernel BTF parser.

Based on Alexei's feedback [1] I'm proceeding with the BTF_KIND_FLOAT
approach.

[1] https://lore.kernel.org/bpf/CAADnVQKWPODWZ2RSJ5FJhfYpxkuV0cvSAL1O+FSr9oP1ercoBg@mail.gmail.com/

Ilya Leoshkevich (6):
  bpf: Add BTF_KIND_FLOAT to uapi
  libbpf: Add BTF_KIND_FLOAT support
  tools/bpftool: Add BTF_KIND_FLOAT support
  bpf: Add BTF_KIND_FLOAT support
  selftest/bpf: Add BTF_KIND_FLOAT tests
  bpf: Document BTF_KIND_FLOAT in btf.rst

 Documentation/bpf/btf.rst                    |  17 ++-
 include/uapi/linux/btf.h                     |   5 +-
 kernel/bpf/btf.c                             |  76 +++++++++++-
 tools/bpf/bpftool/btf.c                      |   8 ++
 tools/bpf/bpftool/btf_dumper.c               |   1 +
 tools/include/uapi/linux/btf.h               |   5 +-
 tools/lib/bpf/btf.c                          |  44 +++++++
 tools/lib/bpf/btf.h                          |   8 ++
 tools/lib/bpf/btf_dump.c                     |   4 +
 tools/lib/bpf/libbpf.c                       |  45 ++++++-
 tools/lib/bpf/libbpf.map                     |   5 +
 tools/lib/bpf/libbpf_internal.h              |   2 +
 tools/testing/selftests/bpf/btf_helpers.c    |   4 +
 tools/testing/selftests/bpf/prog_tests/btf.c | 122 +++++++++++++++++++
 tools/testing/selftests/bpf/test_btf.h       |   3 +
 15 files changed, 340 insertions(+), 9 deletions(-)

-- 
2.29.2

