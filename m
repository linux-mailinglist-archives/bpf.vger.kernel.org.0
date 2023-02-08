Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C255268F923
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 21:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjBHU5N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 15:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbjBHU5L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 15:57:11 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A991E3A59D
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 12:57:06 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318KLhXX031263;
        Wed, 8 Feb 2023 20:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=7yL8spVIDkhl482RfTPr1s2PUxX/qDPuiA+XZeEX8Wk=;
 b=TVofaFSkJGsq/OhcAL4U3PtST8FDK0bNm6QqnhRjau55PVKMF6KwqFdwWCnJah7T9Ikp
 h0tFJ4eKcYswUv180aKaCXWT3+yQlAlXidwwZMVBDUEu1Llt0KvmehZH4ntGvL9mwO+G
 C25AMYsHa44n21HxXUMfwn+PMt7uaJNSX1FITU6+dnb8NAgIffV1iNwkPhxP2YavA1dF
 q8w+6HpzT6uscxM9HMaV8CE1gWEv08SCyWnE42wE4lA4pwtuZodij3YpkHI+mF0EVNvm
 xolo7ppSCJSD/fLBGiJTb+zgVJqocro4206Yid51B/CXYVvR9ebylZUdRH+PrFkUt36w MQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmjq3rr1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 20:56:50 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 318Eeh3U026561;
        Wed, 8 Feb 2023 20:56:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3nhf06utbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 20:56:48 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 318KujhS42860964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Feb 2023 20:56:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0724520043;
        Wed,  8 Feb 2023 20:56:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BA8920040;
        Wed,  8 Feb 2023 20:56:44 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.24.149])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Feb 2023 20:56:44 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 0/9] selftests/bpf: Add Memory Sanitizer support
Date:   Wed,  8 Feb 2023 21:56:33 +0100
Message-Id: <20230208205642.270567-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rRwJuneFte5HCF5D3B5ZYzmrUGiQQ_iS
X-Proofpoint-ORIG-GUID: rRwJuneFte5HCF5D3B5ZYzmrUGiQQ_iS
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_09,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080175
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

This series adds support for building selftests with Memory Sanitizer
[1] - a compiler instrumentation for detecting usages of undefined
memory.

The primary motivation is to make sure that such usages do not occur
during testing, since the ones that have not been caught yet are likely
to affect the CI results on s390x. The secondary motivation is to be
able to use libbpf in applications instrumented with MSan (it requires
all code running in a process to be instrumented).

MSan has found one real issue (fixed by patch 6), and of course a
number of false positives. This rest of this series deals with
preparing the build infrastructure and adding MSan annotations to
libbpf and selftests.

The setup I'm using is as follows:

- Instrumented zlib-ng and patched elfutils [2].
- Patched LLVM [3, 4].
- Clang-built kernel.
- Building tests with MSan:

      make \
          -C tools/testing/selftests/bpf \
          CC="ccache clang-17" \
          LD=ld \
          HOSTCC="ccache clang-17" \
          HOSTLD=ld \
          LLVM=1 \
          LLVM_SUFFIX=-17 \
          OBJCOPY=objcopy \
          CLANG="ccache clang-17" \
          LLVM_STRIP=llvm-strip-17 \
          LLC=llc-17 \
          BPF_GCC= \
          SAN_CFLAGS="-fsanitize=memory \
                      -fsanitize-memory-track-origins \
                      -I$PWD/../zlib-ng/dist/include \
                      -I$PWD/../elfutils/dist/include" \
          SAN_LDFLAGS="-fsanitize=memory \
                       -fsanitize-memory-track-origins \
                       -L$PWD/../zlib-ng/dist/lib \
                       -L$PWD/../elfutils/dist/lib" \
          CROSS_COMPILE=s390x-linux-gnu-

  It's a lot of options, but most of them are trivial: setting up LLVM
  toolchain, taking in account s390x quirks, setting up MSan and
  disabling bpf-gcc. The CROSS_COMPILE one is a hack: instrumenting
  bpftool turned out to be too complicated from the build system
  perspective, so having CROSS_COMPILE forces compiling the host libbpf
  uninstrumented and guest libbpf instrumented.

- Running tests with MSan on s390x:

      LD_LIBRARY_PATH=<instrumented libs> ./test_progs
      ...
      Summary: 282/1624 PASSED, 23 SKIPPED, 4 FAILED
  
  The 4 failures happen without MSan too, they are already known and
  denylisted.

Best regards,
Ilya

[1] https://clang.llvm.org/docs/MemorySanitizer.html
[2] https://sourceware.org/pipermail/elfutils-devel/2023q1/005831.html
[3] https://reviews.llvm.org/D143296
[4] https://reviews.llvm.org/D143330

Ilya Leoshkevich (9):
  selftests/bpf: Quote host tools
  tools: runqslower: Add EXTRA_CFLAGS and EXTRA_LDFLAGS support
  selftests/bpf: Split SAN_CFLAGS and SAN_LDFLAGS
  selftests/bpf: Forward SAN_CFLAGS and SAN_LDFLAGS to runqslower and
    libbpf
  selftests/bpf: Attach to fopen()/fclose() in uprobe_autoattach
  selftests/bpf: Attach to fopen()/fclose() in attach_probe
  libbpf: Fix alen calculation in libbpf_nla_dump_errormsg()
  libbpf: Add MSan annotations
  selftests/bpf: Add MSan annotations

 tools/bpf/runqslower/Makefile                 |  6 ++
 tools/lib/bpf/bpf.c                           | 70 +++++++++++++++++--
 tools/lib/bpf/btf.c                           |  1 +
 tools/lib/bpf/libbpf.c                        |  1 +
 tools/lib/bpf/libbpf_internal.h               | 14 ++++
 tools/lib/bpf/nlattr.c                        |  2 +-
 tools/testing/selftests/bpf/Makefile          | 17 +++--
 tools/testing/selftests/bpf/cap_helpers.c     |  3 +
 .../selftests/bpf/prog_tests/attach_probe.c   | 10 +--
 .../selftests/bpf/prog_tests/bpf_obj_id.c     | 10 +++
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  3 +
 tools/testing/selftests/bpf/prog_tests/btf.c  | 11 +++
 .../selftests/bpf/prog_tests/send_signal.c    |  2 +
 .../bpf/prog_tests/tp_attach_query.c          |  6 ++
 .../bpf/prog_tests/uprobe_autoattach.c        | 12 ++--
 .../selftests/bpf/prog_tests/xdp_bonding.c    |  3 +
 .../selftests/bpf/progs/test_attach_probe.c   |  8 ++-
 .../bpf/progs/test_uprobe_autoattach.c        | 10 +--
 tools/testing/selftests/bpf/xdp_synproxy.c    |  2 +
 19 files changed, 161 insertions(+), 30 deletions(-)

-- 
2.39.1

