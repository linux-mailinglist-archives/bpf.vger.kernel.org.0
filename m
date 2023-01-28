Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC19C67F32F
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjA1Adg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjA1Adf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:33:35 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835781BAF4
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:33:33 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RNrZNg021400;
        Sat, 28 Jan 2023 00:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=zkBzEmKmK+yfvVibxPHY2fn7QJkZ/0HvtoxHGSzyXvs=;
 b=LhwmVmU9Uvt6i32LSiVI5EyU+aDKUNU2g9YR0qEWwbaz0gC4rzUpit67IpA7GU/syZ7L
 6qUOydm8KohwmXwIEp7bDyM8dMgU6g8GqY3fUY/1tddkLTUikaQF/Qbyu/oI3wsEmFJ2
 caoOoi3XUzuXCh7Cp43Ui6mxa6B7R9xwmaXIlDtFzo8wyG6604CpcY7CuHtgNmYeONBg
 s6Ay2D8IiN49Ale8mkerGFGZwReyFktQ6pAEmeB3mlmefuYdDGq/7kueVcQfX+Na1IqZ
 elsgoPTnnRf7aDX1vcHSaRugGtYHy9625oBEV+U/H7OGrel4l4NCErvi8VpqR73Afmrg nQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncrpf0r0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:33:19 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30R1OICc015609;
        Sat, 28 Jan 2023 00:07:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3n87p6dufv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30S06ucq15925660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 00:06:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88E592004B;
        Sat, 28 Jan 2023 00:06:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 114D820040;
        Sat, 28 Jan 2023 00:06:56 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 28 Jan 2023 00:06:55 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 00/31] Support bpf trampoline for s390x
Date:   Sat, 28 Jan 2023 01:06:19 +0100
Message-Id: <20230128000650.1516334-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U-PhJ4651CPI1vCGSzyegaZ5op3QERd6
X-Proofpoint-GUID: U-PhJ4651CPI1vCGSzyegaZ5op3QERd6
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_15,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301280003
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v1: https://lore.kernel.org/bpf/20230125213817.1424447-1-iii@linux.ibm.com/#t
v1 -> v2:
- Fix core_read_macros, sk_assign, test_profiler, test_bpffs (24/31;
  I'm not quite happy with the fix, but don't have better ideas),
  and xdp_synproxy. (Andrii)
- Prettify liburandom_read and verify_pkcs7_sig fixes. (Andrii)
- Fix bpf_usdt_arg using barrier_var(); prettify barrier_var(). (Andrii)
- Change BPF_MAX_TRAMP_LINKS to enum and query it using BTF. (Andrii)
- Improve bpf_jit_supports_kfunc_call() description. (Alexei)
- Always check sign_extend() return value.
- Cc: Alexander Gordeev.

Hi,

This series implements poke, trampoline, kfunc, mixing subprogs and
tailcalls, and fixes a number of tests on s390x.

The following failures still remain:

#82      get_stack_raw_tp:FAIL
get_stack_print_output:FAIL:user_stack corrupted user stack
Known issue:
We cannot reliably unwind userspace on s390x without DWARF.

#101     ksyms_module:FAIL
address of kernel function bpf_testmod_test_mod_kfunc is out of range
Known issue:
Kernel and modules are too far away from each other on s390x.

#190     stacktrace_build_id:FAIL
Known issue:
We cannot reliably unwind userspace on s390x without DWARF.

#281     xdp_metadata:FAIL
See patch 31.

None of these seem to be due to the new changes.

Best regards,
Ilya

Ilya Leoshkevich (31):
  bpf: Use ARG_CONST_SIZE_OR_ZERO for 3rd argument of
    bpf_tcp_raw_gen_syncookie_ipv{4,6}()
  bpf: Change BPF_MAX_TRAMP_LINKS to enum
  selftests/bpf: Query BPF_MAX_TRAMP_LINKS using BTF
  selftests/bpf: Fix liburandom_read.so linker error
  selftests/bpf: Fix symlink creation error
  selftests/bpf: Fix kfree_skb on s390x
  selftests/bpf: Set errno when urand_spawn() fails
  selftests/bpf: Fix decap_sanity_ns cleanup
  selftests/bpf: Fix verify_pkcs7_sig on s390x
  selftests/bpf: Fix xdp_do_redirect on s390x
  selftests/bpf: Fix cgrp_local_storage on s390x
  selftests/bpf: Check stack_mprotect() return value
  selftests/bpf: Increase SIZEOF_BPF_LOCAL_STORAGE_ELEM on s390x
  selftests/bpf: Add a sign-extension test for kfuncs
  selftests/bpf: Fix test_lsm on s390x
  selftests/bpf: Fix test_xdp_adjust_tail_grow2 on s390x
  selftests/bpf: Fix vmlinux test on s390x
  selftests/bpf: Fix sk_assign on s390x
  selftests/bpf: Fix xdp_synproxy/tc on s390x
  selftests/bpf: Fix profiler on s390x
  libbpf: Simplify barrier_var()
  libbpf: Fix unbounded memory access in bpf_usdt_arg()
  libbpf: Fix BPF_PROBE_READ{_STR}_INTO() on s390x
  bpf: iterators: Split iterators.lskel.h into little- and big- endian
    versions
  bpf: btf: Add BTF_FMODEL_SIGNED_ARG flag
  s390/bpf: Fix a typo in a comment
  s390/bpf: Add expoline to tail calls
  s390/bpf: Implement bpf_arch_text_poke()
  s390/bpf: Implement arch_prepare_bpf_trampoline()
  s390/bpf: Implement bpf_jit_supports_subprog_tailcalls()
  s390/bpf: Implement bpf_jit_supports_kfunc_call()

 arch/s390/net/bpf_jit_comp.c                  | 714 +++++++++++++++++-
 include/linux/bpf.h                           |  12 +-
 include/linux/btf.h                           |  15 +-
 kernel/bpf/btf.c                              |  16 +-
 kernel/bpf/preload/bpf_preload_kern.c         |   6 +-
 kernel/bpf/preload/iterators/Makefile         |  12 +-
 kernel/bpf/preload/iterators/README           |   5 +-
 .../iterators/iterators.lskel-big-endian.h    | 419 ++++++++++
 ...skel.h => iterators.lskel-little-endian.h} |   0
 net/bpf/test_run.c                            |   9 +
 net/core/filter.c                             |   4 +-
 tools/lib/bpf/bpf_core_read.h                 |   4 +-
 tools/lib/bpf/bpf_helpers.h                   |   2 +-
 tools/lib/bpf/usdt.bpf.h                      |   5 +-
 tools/testing/selftests/bpf/Makefile          |   5 +-
 tools/testing/selftests/bpf/netcnt_common.h   |   6 +-
 .../selftests/bpf/prog_tests/bpf_cookie.c     |   6 +-
 .../bpf/prog_tests/cgrp_local_storage.c       |   2 +-
 .../selftests/bpf/prog_tests/decap_sanity.c   |   2 +-
 .../selftests/bpf/prog_tests/fexit_stress.c   |  22 +-
 .../selftests/bpf/prog_tests/kfree_skb.c      |   2 +-
 .../selftests/bpf/prog_tests/kfunc_call.c     |   1 +
 .../selftests/bpf/prog_tests/sk_assign.c      |   5 +-
 .../selftests/bpf/prog_tests/test_lsm.c       |   3 +-
 .../bpf/prog_tests/trampoline_count.c         |  18 +-
 tools/testing/selftests/bpf/prog_tests/usdt.c |   1 +
 .../bpf/prog_tests/verify_pkcs7_sig.c         |   3 +
 .../bpf/prog_tests/xdp_adjust_tail.c          |   7 +-
 .../bpf/prog_tests/xdp_do_redirect.c          |   4 +
 .../selftests/bpf/progs/kfunc_call_test.c     |  18 +
 tools/testing/selftests/bpf/progs/lsm.c       |   7 +-
 .../selftests/bpf/progs/profiler.inc.h        |  62 +-
 .../selftests/bpf/progs/test_sk_assign.c      |  24 +-
 .../bpf/progs/test_verify_pkcs7_sig.c         |  12 +-
 .../selftests/bpf/progs/test_vmlinux.c        |   4 +-
 .../bpf/progs/test_xdp_adjust_tail_grow.c     |   8 +-
 .../selftests/bpf/progs/xdp_synproxy_kern.c   |   2 +-
 tools/testing/selftests/bpf/test_progs.c      |  38 +
 tools/testing/selftests/bpf/test_progs.h      |   2 +
 39 files changed, 1350 insertions(+), 137 deletions(-)
 create mode 100644 kernel/bpf/preload/iterators/iterators.lskel-big-endian.h
 rename kernel/bpf/preload/iterators/{iterators.lskel.h => iterators.lskel-little-endian.h} (100%)

-- 
2.39.1

