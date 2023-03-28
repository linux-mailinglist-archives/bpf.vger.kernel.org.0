Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FDF6CCE6D
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 01:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjC1X7j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 28 Mar 2023 19:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC1X7i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 19:59:38 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9590830DD
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 16:59:14 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SJUKWJ026929
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 16:58:30 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pkxwuw9n5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 16:58:30 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 28 Mar 2023 16:58:29 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 74EDA2C40021B; Tue, 28 Mar 2023 16:56:12 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 0/6] BPF verifier rotating log
Date:   Tue, 28 Mar 2023 16:56:03 -0700
Message-ID: <20230328235610.3159943-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: k8R_V8IaIPao_eef5b0_bDsIpew56B2w
X-Proofpoint-GUID: k8R_V8IaIPao_eef5b0_bDsIpew56B2w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
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

v1->v2:
  - return -ENOSPC even in rotating log mode for preserving backwards
    compatibility (Lorenz);

Andrii Nakryiko (6):
  bpf: split off basic BPF verifier log into separate file
  bpf: remove minimum size restrictions on verifier log buffer
  bpf: switch BPF verifier log to be a rotating log by default
  libbpf: don't enforce verifier log levels on libbpf side
  selftests/bpf: add more veristat control over verifier log options
  selftests/bpf: add fixed vs rotating verifier log tests

 include/linux/bpf_verifier.h                  |  48 ++--
 kernel/bpf/Makefile                           |   3 +-
 kernel/bpf/btf.c                              |   3 +-
 kernel/bpf/log.c                              | 262 ++++++++++++++++++
 kernel/bpf/verifier.c                         |  88 +-----
 tools/lib/bpf/bpf.c                           |   2 -
 .../selftests/bpf/prog_tests/log_fixup.c      |   1 +
 .../selftests/bpf/prog_tests/verifier_log.c   | 164 +++++++++++
 tools/testing/selftests/bpf/veristat.c        |  42 ++-
 9 files changed, 506 insertions(+), 107 deletions(-)
 create mode 100644 kernel/bpf/log.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/verifier_log.c

-- 
2.34.1

