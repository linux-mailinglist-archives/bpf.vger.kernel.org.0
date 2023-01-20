Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D0D675E92
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 21:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjATUJ1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 20 Jan 2023 15:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjATUJ0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 15:09:26 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E1C1285A
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:25 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KI76wF011218
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:24 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n7gdede2h-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:24 -0800
Received: from twshared24130.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 12:09:22 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A4EE725B4AFB8; Fri, 20 Jan 2023 12:09:15 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 00/25] libbpf: extend [ku]probe and syscall argument tracing support
Date:   Fri, 20 Jan 2023 12:08:49 -0800
Message-ID: <20230120200914.3008030-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: DQ-Q_Zx41jcw-1XRVMJmuGL0vduXgRAp
X-Proofpoint-ORIG-GUID: DQ-Q_Zx41jcw-1XRVMJmuGL0vduXgRAp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_10,2023-01-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set fixes and extends libbpf's bpf_tracing.h support for tracing
arguments of kprobes/uprobes, and syscall as a special case.

Depending on the architecture, anywhere between 3 and 8 arguments can be
passed to a function in registers (so relevant to kprobes and uprobes), but
before this patch set libbpf's macros in bpf_tracing.h only supported up to
5 arguments, which is limiting in practice. This patch set extends
bpf_tracing.h to support up to 8 arguments, if architecture allows. This
includes explicit PT_REGS_PARMx() macro family, as well as BPF_KPROBE() macro.

Now, with tracing syscall arguments situation is sometimes quite different.
For a lot of architectures syscall argument passing through registers differs
from function call sequence at least a little. For i386 it differs *a lot*.
This patch set addresses this issue across all currently supported
architectures and hopefully fixes existing issues. syscall(2) manpage defines
that either 6 or 7 arguments can be supported, depending on architecture, so
libbpf defines 6 or 7 registers per architecture to be used to fetch syscall
arguments.

Also, BPF_UPROBE and BPF_URETPROBE are introduced as part of this patch set.
They are aliases for BPF_KPROBE and BPF_KRETPROBE (as mechanics of argument
fetching of kernel functions and user-space functions are identical), but it
allows BPF users to have less confusing BPF-side code when working with
uprobes.

For both sets of changes selftests are extended to test these new register
definitions to architecture-defined limits. Unfortunately I don't have ability
to test it on all architectures, and BPF CI only tests 3 architecture (x86-64,
arm64, and s390x), so it would be greatly appreciated if people with access to
architectures other than above 3 helped review and test changes.

v1->v2:
  - switched from mmap() to splice() syscall (Ilya);
  - updated ABI spec link for s390x (Ilya);
  - added a bunch of Tested-by and acks tags, thank you;
  - dropped direct CCs because vger/patchworks blocked v1 patches, probably
    due to too long CC list.


Andrii Nakryiko (25):
  libbpf: add support for fetching up to 8 arguments in kprobes
  libbpf: add 6th argument support for x86-64 in bpf_tracing.h
  libbpf: fix arm and arm64 specs in bpf_tracing.h
  libbpf: complete mips spec in bpf_tracing.h
  libbpf: complete powerpc spec in bpf_tracing.h
  libbpf: complete sparc spec in bpf_tracing.h
  libbpf: complete riscv arch spec in bpf_tracing.h
  libbpf: fix and complete ARC spec in bpf_tracing.h
  libbpf: complete LoongArch (loongarch) spec in bpf_tracing.h
  libbpf: add BPF_UPROBE and BPF_URETPROBE macro aliases
  selftests/bpf: validate arch-specific argument registers limits
  libbpf: improve syscall tracing support in bpf_tracing.h
  libbpf: define x86-64 syscall regs spec in bpf_tracing.h
  libbpf: define i386 syscall regs spec in bpf_tracing.h
  libbpf: define s390x syscall regs spec in bpf_tracing.h
  libbpf: define arm syscall regs spec in bpf_tracing.h
  libbpf: define arm64 syscall regs spec in bpf_tracing.h
  libbpf: define mips syscall regs spec in bpf_tracing.h
  libbpf: define powerpc syscall regs spec in bpf_tracing.h
  libbpf: define sparc syscall regs spec in bpf_tracing.h
  libbpf: define riscv syscall regs spec in bpf_tracing.h
  libbpf: define arc syscall regs spec in bpf_tracing.h
  libbpf: define loongarch syscall regs spec in bpf_tracing.h
  selftests/bpf: add 6-argument syscall tracing test
  libbpf: clean up now not needed __PT_PARM{1-6}_SYSCALL_REG defaults

 tools/lib/bpf/bpf_tracing.h                   | 303 +++++++++++++++---
 .../bpf/prog_tests/test_bpf_syscall_macro.c   |  17 +
 .../bpf/prog_tests/uprobe_autoattach.c        |  33 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  25 ++
 .../selftests/bpf/progs/bpf_syscall_macro.c   |  26 ++
 .../bpf/progs/test_uprobe_autoattach.c        |  48 ++-
 6 files changed, 407 insertions(+), 45 deletions(-)

-- 
2.30.2

