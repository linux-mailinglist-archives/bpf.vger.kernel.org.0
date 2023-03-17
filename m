Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E2A6BF4D6
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 23:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjCQWEM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 17 Mar 2023 18:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjCQWEM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 18:04:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6C535EF1
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 15:04:02 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HKFTnQ016599
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 15:04:01 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pccf56qcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 15:04:01 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 17 Mar 2023 15:04:00 -0700
Received: from twshared13785.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 17 Mar 2023 15:04:00 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D18A42AEB7473; Fri, 17 Mar 2023 15:03:52 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 0/6] BPF verifier rotating log
Date:   Fri, 17 Mar 2023 15:03:45 -0700
Message-ID: <20230317220351.2970665-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: vd0XKmMZGOYqIPg8zzlCS8YRGPPOScmz
X-Proofpoint-ORIG-GUID: vd0XKmMZGOYqIPg8zzlCS8YRGPPOScmz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_17,2023-03-16_02,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
get ending part of verifier log filling up user-supplied log buffer.

Which is, in absolute majority of cases, is exactly what's useful, relevant,
and what users want and need, as the ending of the verifier log is containing
details of verifier failure and relevant state that got us to that failure. So
this rotating mode is made a default, but for some niche advanced debugging
scenarios it's possible to request old behavior by specifying additional
BPF_LOG_FIXED (8) flag.

This patch set adjusts libbpf to allow specifying flags beyond 1 | 2 | 4. We
also add --log-size and --log-fixed options to veristat to be able to both
test this functionality manually, but also to be used in various debugging
scenarios. We also add selftests that tries many variants of log buffer size
to stress-test correctness of internal verifier log bookkeeping code.

v1->v2:
  - fixed using logical end_pos, which could get out of buffer bounds, in
    bpf_vlog_reset() (Alexei);
  - added more strict testing of log buffer beyond allowed size, tested that
    this caugh the above bug (before fixing it in kernel); also added
    log_level 1 testing for program that fails to load (it stress tests
    bpf_vlog_reset() some more);
  - switched to div_u64_rem() for u64 modulo, reported by kernel test robot;
    considered switching to u32 and handle overflows/underflows, but decided
    against that because log->end_pos is used in some additional logic around
    formatting verifier state next to each instruction and it was getting too
    tricky to cleanly reason about underflows/overflows. Keeping it simple
    with u64 (which are now always incresing and non-overflowing) and
    div_u64_rem().

Andrii Nakryiko (6):
  bpf: split off basic BPF verifier log into separate file
  bpf: remove minimum size restrictions on verifier log buffer
  bpf: switch BPF verifier log to be a rotating log by default
  libbpf: don't enfore verifier log levels on libbpf side
  selftests/bpf: add more veristat control over verifier log options
  selftests/bpf: add fixed vs rotating verifier log tests

 include/linux/bpf_verifier.h                  |  47 ++--
 kernel/bpf/Makefile                           |   3 +-
 kernel/bpf/log.c                              | 254 ++++++++++++++++++
 kernel/bpf/verifier.c                         |  86 +-----
 tools/lib/bpf/bpf.c                           |   2 -
 .../selftests/bpf/prog_tests/log_fixup.c      |   1 +
 .../selftests/bpf/prog_tests/verifier_log.c   | 156 +++++++++++
 tools/testing/selftests/bpf/veristat.c        |  42 ++-
 8 files changed, 486 insertions(+), 105 deletions(-)
 create mode 100644 kernel/bpf/log.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/verifier_log.c

-- 
2.34.1

