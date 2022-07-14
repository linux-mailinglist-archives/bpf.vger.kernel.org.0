Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11EF574576
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 09:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbiGNHIC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 14 Jul 2022 03:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiGNHIB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 03:08:01 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17A82CDDA
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 00:08:00 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26E6xB5r003570
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 00:08:00 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h9h5c99xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 00:08:00 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 14 Jul 2022 00:07:59 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 6BC181C50A18F; Thu, 14 Jul 2022 00:07:56 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 0/5] Add SEC("ksyscall") support
Date:   Thu, 14 Jul 2022 00:07:50 -0700
Message-ID: <20220714070755.3235561-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: cdD8hYTzyVDqSKpEkMwIdFRAYF38SJP0
X-Proofpoint-ORIG-GUID: cdD8hYTzyVDqSKpEkMwIdFRAYF38SJP0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_04,2022-07-13_03,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add SEC("ksyscall")/SEC("kretsyscall") sections and corresponding
bpf_program__attach_ksyscall() API that simplifies tracing kernel syscalls
through kprobe mechanism. Kprobing syscalls isn't trivial due to varying
syscall handler names in the kernel and various ways syscall argument are
passed, depending on kernel architecture and configuration. SEC("ksyscall")
allows user to not care about such details and just get access to syscall
input arguments, while libbpf takes care of necessary feature detection logic.

There are still more quirks that are not straightforward to hide completely
(see comments about mmap(), clone() and compat syscalls), so in such more
advanced scenarios user might need to fall back to plain SEC("kprobe")
approach, but for absolute majority of users SEC("ksyscall") is a big
improvement.

As part of this patch set libbpf adds two more virtual __kconfig externs, in
addition to existing LINUX_KERNEL_VERSION: LINUX_HAS_BPF_COOKIE and
LINUX_HAS_SYSCALL_WRAPPER, which let's libbpf-provided BPF-side code minimize
external dependencies and assumptions and let's user-space part of libbpf to
perform all the feature detection logic. This benefits USDT support code,
which now doesn't depend on BPF CO-RE for its functionality.

v1->v2:
  - normalize extern variable-related warn and debug message formats (Alan);
rfc->v1:
  - drop dependency on kallsyms and speed up SYSCALL_WRAPPER detection (Alexei);
  - drop dependency on /proc/config.gz in bpf_tracing.h (Yaniv);
  - add doc comment and ephasize mmap(), clone() and compat quirks that are
    not supported (Ilya);
  - use mechanism similar to LINUX_KERNEL_VERSION to also improve USDT code.

Andrii Nakryiko (5):
  libbpf: generalize virtual __kconfig externs and use it for USDT
  selftests/bpf: add test of __weak unknown virtual __kconfig extern
  libbpf: improve BPF_KPROBE_SYSCALL macro and rename it to BPF_KSYSCALL
  libbpf: add ksyscall/kretsyscall sections support for syscall kprobes
  selftests/bpf: use BPF_KSYSCALL and SEC("ksyscall") in selftests

 tools/lib/bpf/bpf_tracing.h                   |  51 +++--
 tools/lib/bpf/libbpf.c                        | 214 ++++++++++++++----
 tools/lib/bpf/libbpf.h                        |  46 ++++
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/lib/bpf/libbpf_internal.h               |   2 +
 tools/lib/bpf/usdt.bpf.h                      |  16 +-
 .../selftests/bpf/prog_tests/core_extern.c    |  17 +-
 .../selftests/bpf/progs/bpf_syscall_macro.c   |   6 +-
 .../selftests/bpf/progs/test_attach_probe.c   |  15 +-
 .../selftests/bpf/progs/test_core_extern.c    |   3 +
 .../selftests/bpf/progs/test_probe_user.c     |  27 +--
 11 files changed, 289 insertions(+), 109 deletions(-)

-- 
2.30.2

