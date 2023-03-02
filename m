Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25E26A8D40
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 00:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCBXug convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 2 Mar 2023 18:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjCBXud (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 18:50:33 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87063403D
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 15:50:23 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322KVNe6021139
        for <bpf@vger.kernel.org>; Thu, 2 Mar 2023 15:50:23 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p2xg6knak-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 15:50:23 -0800
Received: from twshared16996.15.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Mar 2023 15:50:22 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 62A43291B7E8F; Thu,  2 Mar 2023 15:50:18 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next 00/17] BPF open-coded iterators
Date:   Thu, 2 Mar 2023 15:49:58 -0800
Message-ID: <20230302235015.2044271-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: fjmBvnQYhGxX2Y-gSesrHOOyxpMV5VQC
X-Proofpoint-ORIG-GUID: fjmBvnQYhGxX2Y-gSesrHOOyxpMV5VQC
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
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
(see patch #15). We also add bpf_for_each(), which is a generic foreach-like
construct that will work with any kind of open-coded iterator implementation,
as long as we stick with bpf_iter_<type>_{new,next,destroy}() naming pattern.

Patches #1 through #12 are various preparatory patches, first eitht of them
are from preliminaries patch set ([0]) which haven't landed yet, so I just
merged them together to let CI do end-to-end testing of everything properly.
Few new patches further adds some necessary functionality in verifier (like
fixed-size read-only memory access for `int *`-returning kfuncs).

The meat of verifier-side logic is in lucky patch #13. Patch #14 implements
numbers iterator. I kept them separate to have clean reference for how to
integrate new iterator types. And it makes verifier core logic changes
abstracted from any particularities of numbers iterator. Patch #15 adds
bpf_for(), bpf_for_each(), and bpf_repeat() macros to bpf_misc.h, and also
adds yet another pyperf test variant, now with bpf_for() loop. Patch #16 is
verification tests, based on numbers iterator (as the only available right
now). Patch #17 actually tests runtime behavior of numbers iterator.

Most of the relevant details are in corresponding commit messages or code
comments.

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=725996&state=*

Cc: Tejun Heo <tj@kernel.org>

Andrii Nakryiko (17):
  bpf: improve stack slot state printing
  bpf: improve regsafe() checks for PTR_TO_{MEM,BUF,TP_BUFFER}
  selftests/bpf: enhance align selftest's expected log matching
  bpf: honor env->test_state_freq flag in is_state_visited()
  selftests/bpf: adjust log_fixup's buffer size for proper truncation
  bpf: clean up visit_insn()'s instruction processing
  bpf: fix visit_insn()'s detection of BPF_FUNC_timer_set_callback
    helper
  bpf: ensure that r0 is marked scratched after any function call
  bpf: move kfunc_call_arg_meta higher in the file
  bpf: mark PTR_TO_MEM as non-null register type
  bpf: generalize dynptr_get_spi to be usable for iters
  bpf: add support for fixed-size memory pointer returns for kfuncs
  bpf: add support for open-coded iterator loops
  bpf: implement number iterator
  selftests/bpf: add bpf_for_each(), bpf_for(), and bpf_repeat() macros
  selftests/bpf: add iterators tests
  selftests/bpf: add number iterator tests

 include/linux/bpf.h                           |  19 +-
 include/linux/bpf_verifier.h                  |  22 +-
 include/uapi/linux/bpf.h                      |   6 +
 kernel/bpf/bpf_iter.c                         |  71 ++
 kernel/bpf/helpers.c                          |   3 +
 kernel/bpf/verifier.c                         | 851 ++++++++++++++++--
 tools/include/uapi/linux/bpf.h                |   6 +
 .../testing/selftests/bpf/prog_tests/align.c  |  18 +-
 .../bpf/prog_tests/bpf_verif_scale.c          |   6 +
 .../testing/selftests/bpf/prog_tests/iters.c  |  62 ++
 .../selftests/bpf/prog_tests/log_fixup.c      |   2 +-
 .../bpf/prog_tests/uprobe_autoattach.c        |   1 -
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  77 ++
 tools/testing/selftests/bpf/progs/iters.c     | 720 +++++++++++++++
 .../selftests/bpf/progs/iters_looping.c       | 163 ++++
 tools/testing/selftests/bpf/progs/iters_num.c | 242 +++++
 .../selftests/bpf/progs/iters_state_safety.c  | 455 ++++++++++
 tools/testing/selftests/bpf/progs/lsm.c       |   4 +-
 tools/testing/selftests/bpf/progs/pyperf.h    |  14 +-
 .../selftests/bpf/progs/pyperf600_iter.c      |   7 +
 .../selftests/bpf/progs/pyperf600_nounroll.c  |   3 -
 21 files changed, 2641 insertions(+), 111 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/iters.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_looping.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_num.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_state_safety.c
 create mode 100644 tools/testing/selftests/bpf/progs/pyperf600_iter.c

-- 
2.30.2

