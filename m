Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF214AD0E1
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 06:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347279AbiBHFc6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 00:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiBHFRI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 00:17:08 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123B1C0401EA
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 21:17:06 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2181kDZc015536;
        Tue, 8 Feb 2022 05:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=wGxUsxUT98ocyOZCPYt0L0A9VcsO4BUmgbrKbeA8jNo=;
 b=m/E0wENr1mMAxRhEa0qFqmzek26aGHEWjVXdzNlt+9XtnZYIuh52T1TMH8As8Tpl+7Q1
 OFhsS7MZX59fewj9O2e9nX8yri6YCTImgzaYtPcNfvwHB4C68XhSpCewSuHZVCLyMXUq
 lid7JqYsnHpiMNUtUm/TkcQLFUUrDAUldfGd0ElCfXMM8BEeTMXkaToe9XIxBWT7okQs
 76msknvpXxTJLu13Ewk0Jzp3Axort5l5lYGHSyDyysxbgH2gaBDxY1YYjOsC8D6ZxoV4
 065k4txFMq+Jqah+rzX0tJ2ObrOGVFMRZadYdR8+p7Xj5r+k8NhqWfj02/UUTizRhebY DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e236f77fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:48 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2184owRg018264;
        Tue, 8 Feb 2022 05:16:48 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e236f77ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:48 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2185ClXF000994;
        Tue, 8 Feb 2022 05:16:46 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3e1gv99bac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:46 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2185Gcca42009012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 05:16:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1B4E11C054;
        Tue,  8 Feb 2022 05:16:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B0F911C052;
        Tue,  8 Feb 2022 05:16:37 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Feb 2022 05:16:37 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v4 00/14] Fix accessing syscall arguments
Date:   Tue,  8 Feb 2022 06:16:21 +0100
Message-Id: <20220208051635.2160304-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ABE5ZTGLJoSm_KxfJgiUSx1E_cYYzmPx
X-Proofpoint-GUID: XN3FB68PpXYy5l7jO21egihBYxuv0S8j
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_01,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202080025
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf now has macros to access syscall arguments in an
architecture-agnostic manner, but unfortunately they have a number of
issues on non-Intel arches, which this series aims to fix.

v1: https://lore.kernel.org/bpf/20220201234200.1836443-1-iii@linux.ibm.com/
v1 -> v2:
* Put orig_gpr2 in place of args[1] on s390 (Vasily).
* Fix arm64, powerpc and riscv (Heiko).

v2: https://lore.kernel.org/bpf/20220204041955.1958263-1-iii@linux.ibm.com/
v2 -> v3:
* Undo args[1] change (Andrii).
* Rename PT_REGS_SYSCALL to PT_REGS_SYSCALL_REGS (Andrii).
* Split the riscv patch (Andrii).

v3: https://lore.kernel.org/bpf/20220204145018.1983773-1-iii@linux.ibm.com/
v3 -> v4:
* Undo arm64's and s390's user_pt_regs changes.
* Use struct pt_regs when vmlinux.h is available (Andrii).
* Use offsetofend for accessing orig_gpr2 and orig_x0 (Andrii).
* Move libbpf's copy of offsetofend to a new header.
* Fix riscv's __PT_FP_REG.
* Use PT_REGS_SYSCALL_REGS in test_probe_user.c.
* Test bpf_syscall_macro with userspace headers.
* Use Naveen's suggestions and code in patches 5 and 6.
* Add warnings to arm64's and s390's ptrace.h (Andrii).

Tested on x86_64, s390x, arm64, ppc64el and riscv64 in QEMU.

+cc Mark.

Ilya Leoshkevich (14):
  selftests/bpf: Fix an endianness issue in bpf_syscall_macro test
  selftests/bpf: Fix a potential offsetofend redefinition in
    test_cls_redirect
  selftests/bpf: Compile bpf_syscall_macro test also with user headers
  libbpf: Fix a typo in bpf_tracing.h
  libbpf: Generalize overriding syscall parameter access macros
  libbpf: Add PT_REGS_SYSCALL_REGS macro
  selftests/bpf: Use PT_REGS_SYSCALL_REGS in bpf_syscall_macro
  libbpf: Use struct pt_regs when compiling with kernel headers
  libbpf: Fix riscv register names
  libbpf: Move data structure manipulation macros to
    bpf_common_helpers.h
  libbpf: Fix accessing the first syscall argument on s390
  s390: add a comment that warns that orig_gpr2 should not be moved
  libbpf: Fix accessing the first syscall argument on arm64
  arm64: add a comment that warns that orig_x0 should not be moved

 arch/arm64/include/asm/ptrace.h               |   4 +
 arch/s390/include/asm/ptrace.h                |   4 +
 tools/lib/bpf/Makefile                        |   2 +-
 tools/lib/bpf/bpf_common_helpers.h            |  30 +++++
 tools/lib/bpf/bpf_helpers.h                   |  15 +--
 tools/lib/bpf/bpf_tracing.h                   | 107 +++++++++++++++---
 tools/testing/selftests/bpf/bpf_util.h        |  10 +-
 ...acro.c => test_bpf_syscall_macro_common.h} |   8 +-
 .../test_bpf_syscall_macro_kernel.c           |  13 +++
 .../prog_tests/test_bpf_syscall_macro_user.c  |  13 +++
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   4 -
 ...all_macro.c => bpf_syscall_macro_common.h} |  15 ++-
 .../bpf/progs/bpf_syscall_macro_kernel.c      |   4 +
 .../bpf/progs/bpf_syscall_macro_user.c        |  10 ++
 .../selftests/bpf/progs/test_cls_redirect.c   |   2 +
 .../selftests/bpf/progs/test_probe_user.c     |   8 +-
 16 files changed, 191 insertions(+), 58 deletions(-)
 create mode 100644 tools/lib/bpf/bpf_common_helpers.h
 rename tools/testing/selftests/bpf/prog_tests/{test_bpf_syscall_macro.c => test_bpf_syscall_macro_common.h} (89%)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_kernel.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_user.c
 rename tools/testing/selftests/bpf/progs/{bpf_syscall_macro.c => bpf_syscall_macro_common.h} (79%)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_syscall_macro_kernel.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_syscall_macro_user.c

-- 
2.34.1

