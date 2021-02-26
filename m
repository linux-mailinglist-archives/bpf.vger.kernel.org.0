Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743683268A7
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 21:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhBZUYz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 15:24:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229993AbhBZUYE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 15:24:04 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QK31dv087297;
        Fri, 26 Feb 2021 15:23:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Kcklwzyw0vmz0tdX2FhnMCn+lyapVpr+qb9JIpL7sg0=;
 b=DI18Mmx701TEil3/ZSjj3BURVeH0XhxI3qnUARpzWXhsQPwD0K90FIC9m/LmMpufCjBK
 lDJiPlgTBZZvJAGPkjj8pkKD1AC1TfCitB06vOU9VTQWjWTypqbI+U+RyoyPLlPTPqbK
 DjhProQh8OywgSLyIHDJ6lKxRrFAlALRJ1gfc0VAqiLPpC0wPKd++DluLmw7VjHBzjCJ
 FBqq9k9YYZUoaLUH1SiGS3SEra1IRCovegxA8WZwp4VFQPaGpGnApdvX4rQov29flRB8
 Np8xigWRTgbmSTTDH6Jk+8nmE1jYfOXZAqXamWac4tPwBrQ+lF1lRzrmKK5O503d1I7n mA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36y3x800g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 15:23:05 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11QK35g2087968;
        Fri, 26 Feb 2021 15:23:05 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36y3x800fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 15:23:05 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11QKMVaR023521;
        Fri, 26 Feb 2021 20:23:02 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 36y223g8m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 20:23:02 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11QKMkKP37486950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 20:22:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAE7011C052;
        Fri, 26 Feb 2021 20:22:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BAE611C04A;
        Fri, 26 Feb 2021 20:22:59 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Feb 2021 20:22:59 +0000 (GMT)
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
Subject: [PATCH v7 bpf-next 00/10] Add BTF_KIND_FLOAT support
Date:   Fri, 26 Feb 2021 21:22:46 +0100
Message-Id: <20210226202256.116518-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_07:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260143
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

v5: https://lore.kernel.org/bpf/20210223231459.99664-1-iii@linux.ibm.com/
v5 -> v6: Fixes for further findings by Andrii: split whitespace issue
          fix into a separate patch; add 12-byte float to "float test #1,
          well-formed".

v6: https://lore.kernel.org/bpf/20210224234535.106970-1-iii@linux.ibm.com/
v6 -> v7: John suggested to add a comment explaining why sanitization
          does not preserve the type name, as well as what effect it has
          on running the code on the older kernels.
          Yonghong has asked to add a comment explaining why we are not
          checking the alignment very precisely in the kernel.
          John suggested to add a bpf_core_field_size test (commit #9).

Based on Alexei's feedback [1] I'm proceeding with the BTF_KIND_FLOAT
approach.

[1] https://lore.kernel.org/bpf/CAADnVQKWPODWZ2RSJ5FJhfYpxkuV0cvSAL1O+FSr9oP1ercoBg@mail.gmail.com/

Ilya Leoshkevich (10):
  bpf: Add BTF_KIND_FLOAT to uapi
  libbpf: Fix whitespace in btf_add_composite() comment
  libbpf: Add BTF_KIND_FLOAT support
  tools/bpftool: Add BTF_KIND_FLOAT support
  selftests/bpf: Use the 25th bit in the "invalid BTF_INFO" test
  bpf: Add BTF_KIND_FLOAT support
  selftest/bpf: Add BTF_KIND_FLOAT tests
  selftests/bpf: Add BTF_KIND_FLOAT to the existing deduplication tests
  selftests/bpf: Add BTF_KIND_FLOAT to test_core_reloc_size
  bpf: Document BTF_KIND_FLOAT in btf.rst

 Documentation/bpf/btf.rst                     |  17 +-
 include/uapi/linux/btf.h                      |   5 +-
 kernel/bpf/btf.c                              |  83 ++++++++-
 tools/bpf/bpftool/btf.c                       |   8 +
 tools/bpf/bpftool/btf_dumper.c                |   1 +
 tools/include/uapi/linux/btf.h                |   5 +-
 tools/lib/bpf/btf.c                           |  51 ++++-
 tools/lib/bpf/btf.h                           |   6 +
 tools/lib/bpf/btf_dump.c                      |   4 +
 tools/lib/bpf/libbpf.c                        |  29 ++-
 tools/lib/bpf/libbpf.map                      |   5 +
 tools/lib/bpf/libbpf_internal.h               |   2 +
 tools/testing/selftests/bpf/btf_helpers.c     |   4 +
 tools/testing/selftests/bpf/prog_tests/btf.c  | 176 ++++++++++++++++--
 .../selftests/bpf/prog_tests/core_reloc.c     |   1 +
 .../selftests/bpf/progs/core_reloc_types.h    |   5 +
 .../bpf/progs/test_core_reloc_size.c          |   3 +
 tools/testing/selftests/bpf/test_btf.h        |   3 +
 18 files changed, 385 insertions(+), 23 deletions(-)

-- 
2.29.2

