Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADF94F205D
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 01:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiDDXot convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 4 Apr 2022 19:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiDDXon (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 19:44:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8557268992
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 16:42:39 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 234NPFYT024304
        for <bpf@vger.kernel.org>; Mon, 4 Apr 2022 16:42:12 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f6jhj6ahs-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 04 Apr 2022 16:42:11 -0700
Received: from twshared20084.04.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 4 Apr 2022 16:42:09 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 6E6E21661B500; Mon,  4 Apr 2022 16:42:03 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v3 bpf-next 0/7] Add libbpf support for USDTs
Date:   Mon, 4 Apr 2022 16:41:55 -0700
Message-ID: <20220404234202.331384-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: qLAMtOTZTrTzbhAqStTOGEQme52zLSVw
X-Proofpoint-ORIG-GUID: qLAMtOTZTrTzbhAqStTOGEQme52zLSVw
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_09,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add libbpf support for USDT (User Statically-Defined Tracing) probes.
USDTs is important part of tracing, and BPF, ecosystem, widely used in
mission-critical production applications for observability, performance
analysis, and debugging.

And while USDTs themselves are pretty complicated abstraction built on top of
uprobes, for end-users USDT is as natural a primitive as uprobes themselves.
And thus it's important for libbpf to provide best possible user experience
when it comes to build tracing applications relying on USDTs.

USDTs historically presented a lot of challenges for libbpf's no
compilation-on-the-fly general approach to BPF tracing. BCC utilizes power of
on-the-fly source code generation and compilation using its embedded Clang
toolchain, which was impractical for more lightweight and thus more rigid
libbpf-based approach. But still, with enough diligence and BPF cookies it's
possible to implement USDT support that feels as natural as tracing any
uprobe.

This patch set is the culmination of such effort to add libbpf USDT support
following the spirit and philosophy of BPF CO-RE (even though it's not
inherently relying on BPF CO-RE much, see patch #1 for some notes regarding
this). Each respective patch has enough details and explanations, so I won't
go into details here.

In the end, I think the overall usability of libbpf's USDT support *exceeds*
the status quo set by BCC due to the elimination of awkward runtime USDT
supporting code generation. It also exceeds BCC's capabilities due to the use
of BPF cookie. This eliminates the need to determine a USDT call site (and
thus specifics about how exactly to fetch arguments) based on its *absolute IP
address*, which is impossible with shared libraries if no PID is specified (as
we then just *can't* know absolute IP at which shared library is loaded,
because it might be different for each process). With BPF cookie this is not
a problem as we record "call site ID" directly in a BPF cookie value. This
makes it possible to do a system-wide tracing of a USDT defined in a shared
library. Think about tracing some USDT in libc across any process in the
system, both running at the time of attachment and all the new processes
started *afterwards*. This is a very powerful capability that allows more
efficient observability and tracing tooling.

Once this functionality lands, the plan is to extend libbpf-bootstrap ([0])
with an USDT example. It will also become possible to start converting BCC
tools that rely on USDTs to their libbpf-based counterparts ([1]).

It's worth noting that preliminary version of this code was currently used and
tested in production code running fleet-wide observability toolkit.

Libbpf functionality is broken down into 5 mostly logically independent parts,
for ease of reviewing:
  - patch #1 adds BPF-side implementation;
  - patch #2 adds user-space APIs and wires bpf_link for USDTs;
  - patch #3 adds the most mundate pieces: handling ELF, parsing USDT notes,
    dealing with memory segments, relative vs absolute addresses, etc;
  - patch #4 adds internal ID allocation and setting up/tearing down of
    BPF-side state (spec and IP-to-ID mapping);
  - patch #5 implements x86/x86-64-specific logic of parsing USDT argument
    specifications;
  - patch #6 adds testing of various basic aspects of handling of USDT;
  - patch #7 extends the set of tests with more combinations of semaphore,
    executable vs shared library, and PID filter options.

  [0] https://github.com/libbpf/libbpf-bootstrap
  [1] https://github.com/iovisor/bcc/tree/master/libbpf-tools

v2->v3:
  - fix typos, leave link to systemtap doc, acks, etc (Dave);
  - include sys/sdt.h to avoid extra system-wide package dependencies;
v1->v2:
  - huge high-level comment describing how all the moving parts fit together
    (Alan, Alexei);
  - switched from `__hidden __weak` to `static inline __noinline` for now, as
    there is a bug in BPF linker breaking final BPF object file due to invalid
    .BTF.ext data; I want to fix it separately at which point I'll switch back
    to __hidden __weak again. The fix isn't trivial, so I don't want to block
    on that. Same for __weak variable lookup bug that Henqi reported.
  - various fixes and improvements, addressing other feedback (Alan, Hengqi);

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Dave Marchevsky <davemarchevsky@fb.com>
Cc: Hengqi Chen <hengqi.chen@gmail.com>

Andrii Nakryiko (7):
  libbpf: add BPF-side of USDT support
  libbpf: wire up USDT API and bpf_link integration
  libbpf: add USDT notes parsing and resolution logic
  libbpf: wire up spec management and other arch-independent USDT logic
  libbpf: add x86-specific USDT arg spec parsing logic
  selftests/bpf: add basic USDT selftests
  selftests/bpf: add urandom_read shared lib and USDTs

 tools/lib/bpf/Build                           |    3 +-
 tools/lib/bpf/Makefile                        |    2 +-
 tools/lib/bpf/libbpf.c                        |  115 +-
 tools/lib/bpf/libbpf.h                        |   31 +
 tools/lib/bpf/libbpf.map                      |    1 +
 tools/lib/bpf/libbpf_internal.h               |   19 +
 tools/lib/bpf/usdt.bpf.h                      |  256 ++++
 tools/lib/bpf/usdt.c                          | 1280 +++++++++++++++++
 tools/testing/selftests/bpf/Makefile          |   25 +-
 tools/testing/selftests/bpf/prog_tests/usdt.c |  421 ++++++
 .../selftests/bpf/progs/test_urandom_usdt.c   |   70 +
 tools/testing/selftests/bpf/progs/test_usdt.c |   96 ++
 .../selftests/bpf/progs/test_usdt_multispec.c |   32 +
 tools/testing/selftests/bpf/sdt-config.h      |    6 +
 tools/testing/selftests/bpf/sdt.h             |  513 +++++++
 tools/testing/selftests/bpf/urandom_read.c    |   63 +-
 .../testing/selftests/bpf/urandom_read_aux.c  |    9 +
 .../testing/selftests/bpf/urandom_read_lib1.c |   13 +
 .../testing/selftests/bpf/urandom_read_lib2.c |    8 +
 19 files changed, 2938 insertions(+), 25 deletions(-)
 create mode 100644 tools/lib/bpf/usdt.bpf.h
 create mode 100644 tools/lib/bpf/usdt.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/usdt.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_urandom_usdt.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_usdt.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_usdt_multispec.c
 create mode 100644 tools/testing/selftests/bpf/sdt-config.h
 create mode 100644 tools/testing/selftests/bpf/sdt.h
 create mode 100644 tools/testing/selftests/bpf/urandom_read_aux.c
 create mode 100644 tools/testing/selftests/bpf/urandom_read_lib1.c
 create mode 100644 tools/testing/selftests/bpf/urandom_read_lib2.c

-- 
2.30.2

