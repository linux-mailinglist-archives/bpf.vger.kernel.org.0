Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE416B112D
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 19:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCHSlf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 8 Mar 2023 13:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjCHSle (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 13:41:34 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38F5AF69E
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 10:41:31 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 328I0evD024458
        for <bpf@vger.kernel.org>; Wed, 8 Mar 2023 10:41:31 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3p6ffudvy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 10:41:30 -0800
Received: from twshared38955.16.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 8 Mar 2023 10:41:29 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 486E3299B74FF; Wed,  8 Mar 2023 10:41:22 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH v5 bpf-next 0/8] BPF open-coded iterators
Date:   Wed, 8 Mar 2023 10:41:13 -0800
Message-ID: <20230308184121.1165081-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: JF4Yp45ZNfj1wJgmC24htsHKNhdPgzDj
X-Proofpoint-ORIG-GUID: JF4Yp45ZNfj1wJgmC24htsHKNhdPgzDj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_12,2023-03-08_03,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support for open-coded (aka inline) iterators in BPF world. This is a next
evolution of gradually allowing more powerful and less restrictive looping and
iteration capabilities to BPF programs.

We set up a framework for implementing all kinds of iterators (e.g., cgroup,
task, file, etc, iterators), but this patch set only implements numbers
iterator, which is used to implement ergonomic bpf_for() for-like construct
(see patches #4-#5). We also add bpf_for_each(), which is a generic
foreach-like construct that will work with any kind of open-coded iterator
implementation, as long as we stick with bpf_iter_<type>_{new,next,destroy}()
naming pattern (which we now enforce on the kernel side).

Patch #1 is preparatory refactoring for easier way to check for special kfunc
calls. Patch #2 is adding iterator kfunc registration and validation logic,
which is mostly independent from the rest of open-coded iterator logic, so is
separated out for easier reviewing.

The meat of verifier-side logic is in patch #3. Patch #4 implements numbers
iterator. I kept them separate to have clean reference for how to integrate
new iterator types (now even simpler to do than in v1 of this patch set).
Patch #5 adds bpf_for(), bpf_for_each(), and bpf_repeat() macros to
bpf_misc.h, and also adds yet another pyperf test variant, now with bpf_for()
loop. Patch #6 is verification tests, based on numbers iterator (as the only
available right now). Patch #7 actually tests runtime behavior of numbers
iterator.

Finally, with changes in v2, it's possible and trivial to implement custom
iterators completely in kernel modules, which we showcase and test by adding
a simple iterator returning same number a given number of times to
bpf_testmod. Patch #8 is where all this happens and is tested.

Most of the relevant details are in corresponding commit messages or code
comments.

v4->v5:
  - fixing missed inner for() in is_iter_reg_valid_uninit, and fixed return
    false (kernel test robot);
  - typo fixes and comment/commit description improvements throughout the
    patch set;
v3->v4:
  - remove unused variable from is_iter_reg_valid_init (kernel test robot);
v2->v3:
  - remove special kfunc leftovers for bpf_iter_num_{new,next,destroy};
  - add iters/testmod_seq* to DENYLIST.s390x, it doesn't support kfuncs in
    modules yet (CI);
v1->v2:
  - rebased on latest, dropping previously landed preparatory patches;
  - each iterator type now have its own `struct bpf_iter_<type>` which allows
    each iterator implementation to use exactly as much stack space as
    necessary, allowing to avoid runtime allocations (Alexei);
  - reworked how iterator kfuncs are defined, no verifier changes are required
    when adding new iterator type;
  - added bpf_testmod-based iterator implementation;
  - address the rest of feedback, comments, commit message adjustment, etc.

Cc: Tejun Heo <tj@kernel.org>

Andrii Nakryiko (8):
  bpf: factor out fetching basic kfunc metadata
  bpf: add iterator kfuncs registration and validation logic
  bpf: add support for open-coded iterator loops
  bpf: implement numbers iterator
  selftests/bpf: add bpf_for_each(), bpf_for(), and bpf_repeat() macros
  selftests/bpf: add iterators tests
  selftests/bpf: add number iterator tests
  selftests/bpf: implement and test custom testmod_seq iterator

 include/linux/bpf.h                           |   8 +-
 include/linux/bpf_verifier.h                  |  25 +
 include/linux/btf.h                           |   4 +
 include/uapi/linux/bpf.h                      |   8 +
 kernel/bpf/bpf_iter.c                         |  70 ++
 kernel/bpf/btf.c                              | 112 ++-
 kernel/bpf/helpers.c                          |   3 +
 kernel/bpf/verifier.c                         | 687 ++++++++++++++++-
 tools/include/uapi/linux/bpf.h                |   8 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  42 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   6 +
 .../bpf/prog_tests/bpf_verif_scale.c          |   6 +
 .../testing/selftests/bpf/prog_tests/iters.c  | 106 +++
 .../bpf/prog_tests/uprobe_autoattach.c        |   1 -
 tools/testing/selftests/bpf/progs/bpf_misc.h  | 100 +++
 tools/testing/selftests/bpf/progs/iters.c     | 720 ++++++++++++++++++
 .../selftests/bpf/progs/iters_looping.c       | 163 ++++
 tools/testing/selftests/bpf/progs/iters_num.c | 242 ++++++
 .../selftests/bpf/progs/iters_state_safety.c  | 426 +++++++++++
 .../selftests/bpf/progs/iters_testmod_seq.c   |  79 ++
 tools/testing/selftests/bpf/progs/lsm.c       |   4 +-
 tools/testing/selftests/bpf/progs/pyperf.h    |  14 +-
 .../selftests/bpf/progs/pyperf600_iter.c      |   7 +
 .../selftests/bpf/progs/pyperf600_nounroll.c  |   3 -
 25 files changed, 2790 insertions(+), 55 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/iters.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_looping.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_num.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_state_safety.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_testmod_seq.c
 create mode 100644 tools/testing/selftests/bpf/progs/pyperf600_iter.c

-- 
2.34.1

