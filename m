Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98166D578C
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 06:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjDDEhN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 4 Apr 2023 00:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjDDEhM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 00:37:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909801BEB
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 21:37:11 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333NLVxg024026
        for <bpf@vger.kernel.org>; Mon, 3 Apr 2023 21:37:11 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pqytan04y-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 21:37:11 -0700
Received: from twshared38955.16.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 3 Apr 2023 21:37:06 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id AD2A92D051870; Mon,  3 Apr 2023 21:37:00 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v3 bpf-next 00/19] BPF verifier rotating log
Date:   Mon, 3 Apr 2023 21:36:40 -0700
Message-ID: <20230404043659.2282536-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0H6iycfCovnbZ9P0s33YEVyMWipcjwSq
X-Proofpoint-GUID: 0H6iycfCovnbZ9P0s33YEVyMWipcjwSq
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_19,2023-04-03_03,2023-02-09_01
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set changes BPF verifier log behavior to behave as a rotating log,
by default. If user-supplied log buffer is big enough to contain entire
verifier log output, there is no effective difference. But where previously
user supplied too small log buffer and would get -ENOSPC error result and the
beginning part of the verifier log, now there will be no error and user will
get ending part of verifier log filling up user-supplied log buffer.  Which
is, in absolute majority of cases, is exactly what's useful, relevant, and
what users want and need, as the ending of the verifier log is containing
details of verifier failure and relevant state that got us to that failure. So
this rotating mode is made default, but for some niche advanced debugging
scenarios it's possible to request old behavior by specifying additional
BPF_LOG_FIXED (8) flag.

This patch set adjusts libbpf to allow specifying flags beyond 1 | 2 | 4. We
also add --log-size and --log-fixed options to veristat to be able to both
test this functionality manually, but also to be used in various debugging
scenarios. We also add selftests that tries many variants of log buffer size
to stress-test correctness of internal verifier log bookkeeping code.

Further, this patch set is merged with log_size_actual v1 patchset ([0]),
which adds ability to get required log buffer size to fit entire verifier log
output. 

This addresses a long-standing limitation, which causes users and BPF loader
library writers to guess and pre-size log buffer, often allocating unnecessary
extra memory for this or doing extra program verifications just to size logs
better, ultimately wasting resources. This was requested most recently by Go
BPF library maintainers ([1]). 

See respective patches for details. A bunch of them some drive-by fixes
detecting during working with the code. Some other further refactor and
compratmentalize verifier log handling code into kernel/bpf/log.c, which
should also make it simpler to integrate such verbose log for other
complicated bpf() syscall commands, if necessary. The rest are actual logic to
calculate maximum log buffer size needed and return it to user-space. Few
patches wire this on libbpf side, and the rest add selftests to test proper
log truncation and log_buf==NULL handling.

This turned into a pretty sizable patch set with lots of arithmetics, but
hopefully the set of features added to verifier log in this patch set are both
useful for BPF users and are self-contained and isolated enough to not cause
troubles going forward.

v2->v3:
  - typos and comment improvement (Lorenz);
  - merged with log_size_actual v1 ([0]) patch set (Alexei);
  - added log_buf==NULL condition allowed (Lorenz);
  - added BPF_BTF_LOAD logs tests (Lorenz);
  - more clean up and refactoring of internal verifier log API;
v1->v2:
  - return -ENOSPC even in rotating log mode for preserving backwards
    compatibility (Lorenz);

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=735213&state=*
  [1] https://lore.kernel.org/bpf/CAN+4W8iNoEbQzQVbB_o1W0MWBDV4xCJAq7K3f6psVE-kkCfMqg@mail.gmail.com/

Andrii Nakryiko (19):
  bpf: split off basic BPF verifier log into separate file
  bpf: remove minimum size restrictions on verifier log buffer
  bpf: switch BPF verifier log to be a rotating log by default
  libbpf: don't enforce unnecessary verifier log restrictions on libbpf
    side
  veristat: add more veristat control over verifier log options
  selftests/bpf: add fixed vs rotating verifier log tests
  bpf: ignore verifier log reset in BPF_LOG_KERNEL mode
  bpf: fix missing -EFAULT return on user log buf error in btf_parse()
  bpf: avoid incorrect -EFAULT error in BPF_LOG_KERNEL mode
  bpf: simplify logging-related error conditions handling
  bpf: keep track of total log content size in both fixed and rolling
    modes
  bpf: add log_size_actual output field to return log contents size
  bpf: simplify internal verifier log interface
  bpf: relax log_buf NULL conditions when log_level>0 is requested
  libbpf: wire through log_size_actual returned from kernel for
    BPF_PROG_LOAD
  libbpf: wire through log_size_actual for bpf_btf_load() API
  selftests/bpf: add tests to validate log_size_actual feature
  selftests/bpf: add testing of log_buf==NULL condition for
    BPF_PROG_LOAD
  selftests/bpf: add verifier log tests for BPF_BTF_LOAD command

 include/linux/bpf.h                           |   2 +-
 include/linux/bpf_verifier.h                  |  41 +-
 include/linux/btf.h                           |   2 +-
 include/uapi/linux/bpf.h                      |  10 +
 kernel/bpf/Makefile                           |   3 +-
 kernel/bpf/btf.c                              |  74 +--
 kernel/bpf/log.c                              | 332 +++++++++++++
 kernel/bpf/syscall.c                          |  16 +-
 kernel/bpf/verifier.c                         | 125 ++---
 tools/include/uapi/linux/bpf.h                |  12 +-
 tools/lib/bpf/bpf.c                           |  17 +-
 tools/lib/bpf/bpf.h                           |  22 +-
 .../selftests/bpf/prog_tests/log_fixup.c      |   1 +
 .../selftests/bpf/prog_tests/verifier_log.c   | 437 ++++++++++++++++++
 tools/testing/selftests/bpf/veristat.c        |  44 +-
 15 files changed, 954 insertions(+), 184 deletions(-)
 create mode 100644 kernel/bpf/log.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/verifier_log.c

-- 
2.34.1

