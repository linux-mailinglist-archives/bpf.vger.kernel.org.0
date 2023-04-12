Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2D46DEA8E
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 06:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDLEdZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 12 Apr 2023 00:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjDLEdX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 00:33:23 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D77468D
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 21:33:21 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 33BNTFU6027744
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 21:33:20 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3pwf9whtgu-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 21:33:20 -0700
Received: from twshared21760.39.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 11 Apr 2023 21:33:15 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id EBD032DCF43FF; Tue, 11 Apr 2023 21:33:12 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kpsingh@kernel.org>, <keescook@chromium.org>,
        <paul@paul-moore.com>
CC:     <linux-security-module@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 0/8] New BPF map and BTF security LSM hooks
Date:   Tue, 11 Apr 2023 21:32:52 -0700
Message-ID: <20230412043300.360803-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0q7qkGu5nxb7cW8-XDgO3wWQT4ABY-8l
X-Proofpoint-GUID: 0q7qkGu5nxb7cW8-XDgO3wWQT4ABY-8l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add new LSM hooks, bpf_map_create_security and bpf_btf_load_security, which
are meant to allow highly-granular LSM-based control over the usage of BPF
subsytem. Specifically, to control the creation of BPF maps and BTF data
objects, which are fundamental building blocks of any modern BPF application.

These new hooks are able to override default kernel-side CAP_BPF-based (and
sometimes CAP_NET_ADMIN-based) permission checks. It is now possible to
implement LSM policies that could granularly enforce more restrictions on
a per-BPF map basis (beyond checking coarse CAP_BPF/CAP_NET_ADMIN
capabilities), but also, importantly, allow to *bypass kernel-side
enforcement* of CAP_BPF/CAP_NET_ADMIN checks for trusted applications and use
cases. The decision about trust for a particular process is delegated to
custom LSM policy implementation. Such setup allows to implement safe and
highly-granular trust-based unprivileged BPF map creation, which is a first
step and a prerequisite towards implementing full-fledged trusted unprivileged
BPF application workflow. Similar approach seems to be implemented by some
other existing LSM hooks, e.g., vm_enough_memory().

Such LSM hook semantics gives ability to have safer-by-default policy of not
giving applications any of the CAP_BPF/CAP_PERFMON/CAP_NET_ADMIN capabilities,
normally required to be able to use BPF subsystem in the kernel. Instead, all
the BPF processes could be left completely unprivileged, and only allowlisted
exceptions for trusted and verified production use cases would be granted
permission to work with bpf() syscall, as if those application had root-like
capabilities. 

This patch set implements and demonstrates an overall approach starting with
BPF map and BTF object creation, first two steps in the lifetime of a typical
BPF applications. Next step would be to do similar changes for BPF_PROG_LOAD
command to allow BPF program loading and verificatlion. This will be
implemented in a follow up patch set and will follow the same approach as
implemented in this patch set.

Patches #1-#3 are refactorings that allow to add new LSM hook in one
centralized place. Patch #4 is where we add and implement LSM hook for
BPF_MAP_CREATE command. Patch #5 adds tests that validates that LSM hook works
as expected: we implement a trivial BPF LSM policy allowing unprivileged BPF
map creation for test_prog's process only. Patch #6 drops unnecessary CAP_BPF
restriction for BPF_MAP_FREEZE command, which seems to slip through the craack
during refactoring to remove extra capability restrictions for commands that
accept FDs of BPF objects. Patches #7 add bpf_btf_load_security LSM hook to
control BTF object load, and patch #8 adds extra tests for that hook.

Andrii Nakryiko (8):
  bpf: move unprivileged checks into map_create() and bpf_prog_load()
  bpf: inline map creation logic in map_create() function
  bpf: centralize permissions checks for all BPF map types
  bpf, lsm: implement bpf_map_create_security LSM hook
  selftests/bpf: validate new bpf_map_create_security LSM hook
  bpf: drop unnecessary bpf_capable() check in BPF_MAP_FREEZE command
  bpf, lsm: implement bpf_btf_load_security LSM hook
  selftests/bpf: enhance lsm_map_create test with BTF LSM control

 include/linux/lsm_hook_defs.h                 |   2 +
 include/linux/lsm_hooks.h                     |  25 +++
 include/linux/security.h                      |  12 +
 kernel/bpf/bloom_filter.c                     |   3 -
 kernel/bpf/bpf_local_storage.c                |   3 -
 kernel/bpf/bpf_lsm.c                          |   2 +
 kernel/bpf/bpf_struct_ops.c                   |   3 -
 kernel/bpf/cpumap.c                           |   4 -
 kernel/bpf/devmap.c                           |   3 -
 kernel/bpf/hashtab.c                          |   6 -
 kernel/bpf/lpm_trie.c                         |   3 -
 kernel/bpf/queue_stack_maps.c                 |   4 -
 kernel/bpf/reuseport_array.c                  |   3 -
 kernel/bpf/stackmap.c                         |   3 -
 kernel/bpf/syscall.c                          | 177 ++++++++++-----
 net/core/sock_map.c                           |   4 -
 net/xdp/xskmap.c                              |   4 -
 security/security.c                           |   8 +
 .../selftests/bpf/prog_tests/lsm_map_create.c | 208 ++++++++++++++++++
 .../bpf/prog_tests/unpriv_bpf_disabled.c      |   6 +-
 tools/testing/selftests/bpf/progs/just_maps.c |  56 +++++
 .../selftests/bpf/progs/lsm_map_create.c      |  47 ++++
 tools/testing/selftests/bpf/test_progs.h      |   6 +
 23 files changed, 494 insertions(+), 98 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_map_create.c
 create mode 100644 tools/testing/selftests/bpf/progs/just_maps.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_map_create.c

-- 
2.34.1

