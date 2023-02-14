Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0719769719D
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 00:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjBNXNI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 18:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjBNXNI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 18:13:08 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE5B13D60
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 15:13:06 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31ENCUcf028634;
        Tue, 14 Feb 2023 23:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=ByIJSL3NkwYeKswss34408Mx9g27X30PPObMqbftsJQ=;
 b=fGWILUYLpbN0mf/scHuO+RiajKOIy33UotWjn59z+DVn9yiU6DzsT7vcKHp4tvYtBupD
 1GQuPTOSEiM+I4cx/ZsXWlSNqJyPGfm6QGYdtSnUb3nw1H67rXzkmppmPHJtCWXUkFuL
 GRAZymBSup0XgSN9dCziAmJFu3gg/kUUgZf1J198xR/YtkfL7vSFOieY1fHfC3GPewXF
 Ymdr03fgJVJkkF1ZaWpZR2qMU0FIZxaBeGFnMJF+iTbFfRYbgiuLZTkEFVXHXfcIfEZy
 2c8rFOcutWLZ3WZfkl8lE1fTyXB2hCge85IibuP2vKoz2KHSH9KaC1B1P/GFmJcG2vOM nA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nrkrur055-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 23:12:29 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31E7AhiO007365;
        Tue, 14 Feb 2023 23:12:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3np29fbefq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 23:12:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31ENCOi441484618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 23:12:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E915A20040;
        Tue, 14 Feb 2023 23:12:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56EEC20043;
        Tue, 14 Feb 2023 23:12:23 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.53.135])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Feb 2023 23:12:23 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 0/8] Add Memory Sanitizer support
Date:   Wed, 15 Feb 2023 00:12:13 +0100
Message-Id: <20230214231221.249277-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rgS1-eGOEb-sNJZMSGrSISZpAWOJUfqs
X-Proofpoint-GUID: rgS1-eGOEb-sNJZMSGrSISZpAWOJUfqs
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140198
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v2: https://lore.kernel.org/bpf/20230210001210.395194-1-iii@linux.ibm.com/
v2 -> v3:
- Improve bpftool commit message, shorten error messages (Quentin).
- Drop perf patch (Andrii).
- Drop integrated patches.

v1: https://lore.kernel.org/bpf/20230208205642.270567-1-iii@linux.ibm.com/
v1 -> v2:
- Apply runqslower's EXTRA_CFLAGS and EXTRA_LDFLAGS unconditionally.
- Use u64 for uretprobe_byname2_rc.
- Use BPF_UPROBE() instead of PT_REGS_xxx().
- Use void * instead of char * for pointer arithmetic.
- Rename libbpf_mark_defined() to __libbpf_mark_mem_written(), add
  convenience wrappers.
- Add a comment about defined(__has_feature) &&
  __has_feature(memory_sanitizer).
- Extract is_percpu_bpf_map_type().
- Introduce bpf_get_{map,prog,link,btf}_info_by_fd() and convert all
  code to use them. If it's too early for that, in particular for
  samples and perf, the respective patches can be dropped.
- Unpoison infos returned by these functions, paying attention to
  potentially missing fields. Use macros to reduce boilerplate.
- Move capget() unpoisoning to LLVM [5].
- With that, only a few cases remain where data needs to be
  unpoisoned in selftests.

Hi,

This series adds support for building selftests with Memory Sanitizer
[1] - a compiler instrumentation for detecting usages of undefined
memory.

The primary motivation is to make sure that such usages do not occur
during testing, since the ones that have not been caught yet are likely
to affect the CI results on s390x. The secondary motivation is to be
able to use libbpf in applications instrumented with MSan (it requires
all code running in a process to be instrumented).

The setup I'm using is as follows:

- Instrumented zlib-ng and elfutils.
- Patched LLVM [2, 3, 4].
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
[2] https://reviews.llvm.org/D143296
[3] https://reviews.llvm.org/D143330
[4] https://reviews.llvm.org/D143660

Ilya Leoshkevich (8):
  libbpf: Introduce bpf_{btf,link,map,prog}_get_info_by_fd()
  libbpf: Use bpf_{btf,link,map,prog}_get_info_by_fd()
  bpftool: Use bpf_{btf,link,map,prog}_get_info_by_fd()
  samples/bpf: Use bpf_{btf,link,map,prog}_get_info_by_fd()
  selftests/bpf: Use bpf_{btf,link,map,prog}_get_info_by_fd()
  libbpf: Factor out is_percpu_bpf_map_type()
  libbpf: Add MSan annotations
  selftests/bpf: Add MSan annotations

 samples/bpf/test_map_in_map_user.c            |   2 +-
 samples/bpf/xdp1_user.c                       |   2 +-
 samples/bpf/xdp_adjust_tail_user.c            |   2 +-
 samples/bpf/xdp_fwd_user.c                    |   4 +-
 samples/bpf/xdp_redirect_cpu_user.c           |   4 +-
 samples/bpf/xdp_rxq_info_user.c               |   2 +-
 samples/bpf/xdp_sample_pkts_user.c            |   2 +-
 samples/bpf/xdp_tx_iptunnel_user.c            |   2 +-
 tools/bpf/bpftool/btf.c                       |  13 +-
 tools/bpf/bpftool/btf_dumper.c                |   4 +-
 tools/bpf/bpftool/cgroup.c                    |   4 +-
 tools/bpf/bpftool/common.c                    |  13 +-
 tools/bpf/bpftool/link.c                      |   4 +-
 tools/bpf/bpftool/main.h                      |   3 +-
 tools/bpf/bpftool/map.c                       |   8 +-
 tools/bpf/bpftool/prog.c                      |  22 +--
 tools/bpf/bpftool/struct_ops.c                |   6 +-
 tools/lib/bpf/bpf.c                           | 179 +++++++++++++++++-
 tools/lib/bpf/bpf.h                           |  13 ++
 tools/lib/bpf/btf.c                           |   9 +-
 tools/lib/bpf/libbpf.c                        |  26 +--
 tools/lib/bpf/libbpf.map                      |   5 +
 tools/lib/bpf/libbpf_internal.h               |  46 +++++
 tools/lib/bpf/netlink.c                       |   2 +-
 tools/lib/bpf/ringbuf.c                       |   4 +-
 .../bpf/map_tests/map_in_map_batch_ops.c      |   2 +-
 .../selftests/bpf/prog_tests/bpf_iter.c       |   8 +-
 .../selftests/bpf/prog_tests/bpf_obj_id.c     |  20 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |   3 +
 tools/testing/selftests/bpf/prog_tests/btf.c  |  24 +--
 .../selftests/bpf/prog_tests/btf_map_in_map.c |   2 +-
 .../selftests/bpf/prog_tests/check_mtu.c      |   2 +-
 .../selftests/bpf/prog_tests/enable_stats.c   |   2 +-
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  |  14 +-
 .../bpf/prog_tests/flow_dissector_reattach.c  |  10 +-
 .../bpf/prog_tests/libbpf_get_fd_by_id_opts.c |   4 +-
 .../selftests/bpf/prog_tests/lsm_cgroup.c     |   3 +-
 .../selftests/bpf/prog_tests/metadata.c       |   8 +-
 tools/testing/selftests/bpf/prog_tests/mmap.c |   2 +-
 .../selftests/bpf/prog_tests/perf_link.c      |   2 +-
 .../selftests/bpf/prog_tests/pinning.c        |   2 +-
 .../selftests/bpf/prog_tests/prog_run_opts.c  |   2 +-
 .../selftests/bpf/prog_tests/recursion.c      |   4 +-
 .../selftests/bpf/prog_tests/send_signal.c    |   2 +
 .../selftests/bpf/prog_tests/sockmap_basic.c  |   6 +-
 .../bpf/prog_tests/task_local_storage.c       |   8 +-
 .../testing/selftests/bpf/prog_tests/tc_bpf.c |   4 +-
 .../bpf/prog_tests/tp_attach_query.c          |   9 +-
 .../bpf/prog_tests/unpriv_bpf_disabled.c      |   8 +-
 .../selftests/bpf/prog_tests/verif_stats.c    |   5 +-
 .../selftests/bpf/prog_tests/xdp_attach.c     |   4 +-
 .../selftests/bpf/prog_tests/xdp_bonding.c    |   3 +
 .../bpf/prog_tests/xdp_cpumap_attach.c        |   8 +-
 .../bpf/prog_tests/xdp_devmap_attach.c        |   8 +-
 .../selftests/bpf/prog_tests/xdp_info.c       |   2 +-
 .../selftests/bpf/prog_tests/xdp_link.c       |  10 +-
 tools/testing/selftests/bpf/test_maps.c       |   2 +-
 .../selftests/bpf/test_skb_cgroup_id_user.c   |   2 +-
 .../bpf/test_tcp_check_syncookie_user.c       |   2 +-
 tools/testing/selftests/bpf/test_verifier.c   |   8 +-
 tools/testing/selftests/bpf/testing_helpers.c |   2 +-
 tools/testing/selftests/bpf/xdp_synproxy.c    |  15 +-
 62 files changed, 429 insertions(+), 174 deletions(-)

-- 
2.39.1

