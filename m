Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3910E6BD82E
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 19:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCPSal convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 16 Mar 2023 14:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCPSal (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 14:30:41 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078F752928
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 11:30:38 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GI6klZ032522
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 11:30:37 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pbpxsp9qy-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 11:30:37 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Mar 2023 11:30:34 -0700
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Mar 2023 11:30:34 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 77EBF2AC19577; Thu, 16 Mar 2023 11:30:21 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 0/6] BPF verifier rotating log
Date:   Thu, 16 Mar 2023 11:30:07 -0700
Message-ID: <20230316183013.2882810-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7u6e60sHC-b8zZWuODoSyDD3lG-4agju
X-Proofpoint-GUID: 7u6e60sHC-b8zZWuODoSyDD3lG-4agju
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_12,2023-03-16_01,2023-02-09_01
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

Andrii Nakryiko (6):
  bpf: split off basic BPF verifier log into separate file
  bpf: remove minimum size restrictions on verifier log buffer
  bpf: switch BPF verifier log to be a rotating log by default
  libbpf: don't enfore verifier log levels on libbpf side
  selftests/bpf: add more veristat control over verifier log options
  selftests/bpf: add fixed vs rotating verifier log tests

 include/linux/bpf_verifier.h                  |  47 ++--
 kernel/bpf/Makefile                           |   3 +-
 kernel/bpf/log.c                              | 251 ++++++++++++++++++
 kernel/bpf/verifier.c                         |  86 +-----
 tools/lib/bpf/bpf.c                           |   2 -
 .../selftests/bpf/prog_tests/log_fixup.c      |   1 +
 .../selftests/bpf/prog_tests/verifier_log.c   |  89 +++++++
 tools/testing/selftests/bpf/veristat.c        |  42 ++-
 8 files changed, 416 insertions(+), 105 deletions(-)
 create mode 100644 kernel/bpf/log.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/verifier_log.c

-- 
2.34.1

