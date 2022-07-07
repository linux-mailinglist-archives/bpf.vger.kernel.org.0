Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629985696FB
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 02:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbiGGAla convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 6 Jul 2022 20:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiGGAl3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 20:41:29 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8F72BB1E
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 17:41:29 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266L6ki8018409
        for <bpf@vger.kernel.org>; Wed, 6 Jul 2022 17:41:28 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h4uaqj7bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 17:41:28 -0700
Received: from twshared3657.05.prn5.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 6 Jul 2022 17:41:28 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 1436B1BFE35E0; Wed,  6 Jul 2022 17:41:19 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Kenta Tada <kenta.tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH RFC bpf-next 0/3] libbpf: add better syscall kprobing support
Date:   Wed, 6 Jul 2022 17:41:15 -0700
Message-ID: <20220707004118.298323-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: n_sILXnCOdEYpSxZxOkYJi8eIsALPHlJ
X-Proofpoint-ORIG-GUID: n_sILXnCOdEYpSxZxOkYJi8eIsALPHlJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_14,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This RFC patch set is to gather feedback about new
SEC("ksyscall") and SEC("kretsyscall") section definitions meant to simplify
life of BPF users that want to trace Linux syscalls without having to know or
care about things like CONFIG_ARCH_HAS_SYSCALL_WRAPPER and related arch-specific
vs arch-agnostic __<arch>_sys_xxx vs __se_sys_xxx function names, calling
convention woes ("nested" pt_regs), etc. All this is quite annoying to
remember and care about as BPF user, especially if the goal is to write
achitecture- and kernel version-agnostic BPF code (e.g., things like
libbpf-tools, etc).

By using SEC("ksyscall/xxx")/SEC("kretsyscall/xxx") user clearly communicates
the desire to kprobe/kretprobe kernel function that corresponds to the
specified syscall. Libbpf will take care of all the details of determining
correct function name and calling conventions.

This patch set also improves BPF_KPROBE_SYSCALL (and renames it to
BPF_KSYSCALL to match SEC("ksyscall")) macro to take into account
CONFIG_ARCH_HAS_SYSCALL_WRAPPER instead of hard-coding whether host
architecture is expected to use syscall wrapper or not (which is less reliable
and can change over time).

It would be great to get feedback about the overall feature, but also I'd
appreciate help with testing this, especially for non-x86_64 architectures.

Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Kenta Tada <kenta.tada@sony.com>
Cc: Hengqi Chen <hengqi.chen@gmail.com>

Andrii Nakryiko (3):
  libbpf: improve and rename BPF_KPROBE_SYSCALL
  libbpf: add ksyscall/kretsyscall sections support for syscall kprobes
  selftests/bpf: use BPF_KSYSCALL and SEC("ksyscall") in selftests

 tools/lib/bpf/bpf_tracing.h                   |  44 +++++--
 tools/lib/bpf/libbpf.c                        | 109 ++++++++++++++++++
 tools/lib/bpf/libbpf.h                        |  16 +++
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/lib/bpf/libbpf_internal.h               |   2 +
 .../selftests/bpf/progs/bpf_syscall_macro.c   |   6 +-
 .../selftests/bpf/progs/test_attach_probe.c   |   6 +-
 .../selftests/bpf/progs/test_probe_user.c     |  27 +----
 8 files changed, 172 insertions(+), 39 deletions(-)

-- 
2.30.2

