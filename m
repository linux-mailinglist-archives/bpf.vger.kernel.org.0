Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B57B32342A
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 00:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhBWXYj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 18:24:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7120 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233552AbhBWXQg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Feb 2021 18:16:36 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11NN7GHT060430;
        Tue, 23 Feb 2021 18:15:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=j8zxhy3LKU8HXFwqxKNU3nkw6nU+1Ma2uygM7fNxIvw=;
 b=mVBf9BDCvtIi1Df7LDAdhKh9qYDIaeUmBs+V0JuSm7T5Qn1aw93S5jNCEFWb21G7YZTD
 D34BzSEspSiBjTdLqJOQ36zXYEa14RX83m22hB1hTchhjzW+HOO3w1pO3xtQJWCyTlk4
 jnSH2vUROQ7GZ8po5tvBI9ap4N0geNgy0pBB1dmezNFSTjyl/nsZZd0TVbJETjeo0rOF
 q9dICuEbsD/ak2uWGbkXrJuRdWdo2rEJDgUiVPJg0a7KW2EjwQdophcWwXxXvXpWfiKI
 hiz86m8mXcpggHeYnye68pzYH7JADFgFgrt4/k5x2ySaFgsWmh1BlcDewON12GJ6nMwO YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkf9147y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 18:15:09 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11NNAbwY071202;
        Tue, 23 Feb 2021 18:15:08 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkf91471-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 18:15:08 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11NNBxv6025268;
        Tue, 23 Feb 2021 23:15:06 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 36tt28sk91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 23:15:05 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11NNEob630474576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 23:14:50 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF1DAA4055;
        Tue, 23 Feb 2021 23:15:02 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6ACBCA404D;
        Tue, 23 Feb 2021 23:15:02 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Feb 2021 23:15:02 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v5 bpf-next 0/8] Add BTF_KIND_FLOAT support
Date:   Wed, 24 Feb 2021 00:14:51 +0100
Message-Id: <20210223231459.99664-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_12:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230190
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

v2: https://lore.kernel.org/bpf/20210219022543.20893-1-iii@linux.ibm.com/
v2 -> v3: Based on Yonghong's suggestions: Use BTF_KIND_CONST instead of
          BTF_KIND_TYPEDEF and make sure that the C code generated from
          the sanitized BTF is well-formed; fix size calculation in
          tests and use NAME_TBD everywhere; limit allowed sizes to 2,
          4, 8, 12 and 16 (this should also fix m68k and nds32le
          builds).

v3: https://lore.kernel.org/bpf/20210220034959.27006-1-iii@linux.ibm.com/
v3 -> v4: More fixes for the Yonghong's findings: fix the outdated
          comment in bpf_object__sanitize_btf() and add the error
          handling there (I've decided to check uint_id and uchar_id
          too in order to simplify debugging); add bpftool output
          example; use div64_u64_rem() instead of % in order to fix the
          linker error.
          Also fix the "invalid BTF_INFO" test (new commit, #4).

v4: https://lore.kernel.org/bpf/20210222214917.83629-1-iii@linux.ibm.com/
v4 -> v5: Fixes for the Andrii's findings: Use BTF_KIND_STRUCT instead
          of BTF_KIND_TYPEDEF for sanitization; check byte_sz in
          libbpf; move btf__add_float; remove relo support; add a dedup
          test (new commit, #7).

Based on Alexei's feedback [1] I'm proceeding with the BTF_KIND_FLOAT
approach.

[1] https://lore.kernel.org/bpf/CAADnVQKWPODWZ2RSJ5FJhfYpxkuV0cvSAL1O+FSr9oP1ercoBg@mail.gmail.com/

Ilya Leoshkevich (8):
  bpf: Add BTF_KIND_FLOAT to uapi
  libbpf: Add BTF_KIND_FLOAT support
  tools/bpftool: Add BTF_KIND_FLOAT support
  selftests/bpf: Use the 25th bit in the "invalid BTF_INFO" test
  bpf: Add BTF_KIND_FLOAT support
  selftest/bpf: Add BTF_KIND_FLOAT tests
  selftests/bpf: Add BTF_KIND_FLOAT to the existing deduplication tests
  bpf: Document BTF_KIND_FLOAT in btf.rst

 Documentation/bpf/btf.rst                    |  17 +-
 include/uapi/linux/btf.h                     |   5 +-
 kernel/bpf/btf.c                             |  79 ++++++++-
 tools/bpf/bpftool/btf.c                      |   8 +
 tools/bpf/bpftool/btf_dumper.c               |   1 +
 tools/include/uapi/linux/btf.h               |   5 +-
 tools/lib/bpf/btf.c                          |  51 +++++-
 tools/lib/bpf/btf.h                          |   6 +
 tools/lib/bpf/btf_dump.c                     |   4 +
 tools/lib/bpf/libbpf.c                       |  26 ++-
 tools/lib/bpf/libbpf.map                     |   5 +
 tools/lib/bpf/libbpf_internal.h              |   2 +
 tools/testing/selftests/bpf/btf_helpers.c    |   4 +
 tools/testing/selftests/bpf/prog_tests/btf.c | 174 +++++++++++++++++--
 tools/testing/selftests/bpf/test_btf.h       |   3 +
 15 files changed, 367 insertions(+), 23 deletions(-)

-- 
2.29.2

