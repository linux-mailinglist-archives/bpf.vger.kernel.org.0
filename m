Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DAD3221C7
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 22:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhBVVuu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 16:50:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231638AbhBVVum (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Feb 2021 16:50:42 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11MLYMXw060741;
        Mon, 22 Feb 2021 16:49:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=uf/Kvz+X7vcBZK/Dc8/vlS1IwtaSQIgiJyNb3u8gv+I=;
 b=sNzZEzj2j8/FBlvqmm55ZDFxAkgODEcFo5R7xC/9BEzyxEUqzNGlhGXtK48U1Gl5WP9x
 pW//KexdubRtnFJgx4xz+AYmoScqsur1bjn6TUXQkk5Duptf5vQTvYgIwR82A6wX49qj
 e6JlEJWUM594qxyWRdZVgsy+Sw6ENFUodAcC1YN6YEBUpXLlFq42iI+Dmfmo9Ei7a+aQ
 +6l+1kiNuwWcXs4O/AfsK17HRDDvsVCKr28AqkuESg9ZQbY7Ghf1eGNTntGFlUrCAsCS
 F5dndSV3GxPXrMGjzBbVkmRNxFglD5AH0eRstlbBCJNDPHtdXFnFyAYjxlJnP6TPY+Ma ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36vkg0360w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 16:49:48 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11MLi0WM114273;
        Mon, 22 Feb 2021 16:49:47 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36vkg0360c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 16:49:47 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11MLm1Sv018397;
        Mon, 22 Feb 2021 21:49:45 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 36tsph21gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 21:49:45 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11MLnUOu36700602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 21:49:30 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F20CCA404D;
        Mon, 22 Feb 2021 21:49:42 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68F68A4040;
        Mon, 22 Feb 2021 21:49:42 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Feb 2021 21:49:42 +0000 (GMT)
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
Subject: [PATCH v4 bpf-next 0/7] Add BTF_KIND_FLOAT support
Date:   Mon, 22 Feb 2021 22:49:10 +0100
Message-Id: <20210222214917.83629-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-22_07:2021-02-22,2021-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220187
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

Based on Alexei's feedback [1] I'm proceeding with the BTF_KIND_FLOAT
approach.

[1] https://lore.kernel.org/bpf/CAADnVQKWPODWZ2RSJ5FJhfYpxkuV0cvSAL1O+FSr9oP1ercoBg@mail.gmail.com/

Ilya Leoshkevich (7):
  bpf: Add BTF_KIND_FLOAT to uapi
  libbpf: Add BTF_KIND_FLOAT support
  tools/bpftool: Add BTF_KIND_FLOAT support
  selftests/bpf: Use 25th bit in "invalid BTF_INFO" test
  bpf: Add BTF_KIND_FLOAT support
  selftest/bpf: Add BTF_KIND_FLOAT tests
  bpf: Document BTF_KIND_FLOAT in btf.rst

 Documentation/bpf/btf.rst                    |  17 ++-
 include/uapi/linux/btf.h                     |   5 +-
 kernel/bpf/btf.c                             |  79 ++++++++++-
 tools/bpf/bpftool/btf.c                      |   8 ++
 tools/bpf/bpftool/btf_dumper.c               |   1 +
 tools/include/uapi/linux/btf.h               |   5 +-
 tools/lib/bpf/btf.c                          |  44 +++++++
 tools/lib/bpf/btf.h                          |   8 ++
 tools/lib/bpf/btf_dump.c                     |   4 +
 tools/lib/bpf/libbpf.c                       |  84 +++++++++++-
 tools/lib/bpf/libbpf.map                     |   5 +
 tools/lib/bpf/libbpf_internal.h              |   2 +
 tools/testing/selftests/bpf/btf_helpers.c    |   4 +
 tools/testing/selftests/bpf/prog_tests/btf.c | 131 ++++++++++++++++++-
 tools/testing/selftests/bpf/test_btf.h       |   3 +
 15 files changed, 386 insertions(+), 14 deletions(-)

-- 
2.29.2

