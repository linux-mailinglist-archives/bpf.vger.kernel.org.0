Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743BC6F4D67
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 01:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjEBXGc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 2 May 2023 19:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjEBXGb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 19:06:31 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651FEC3
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 16:06:30 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342JX2Ic031629
        for <bpf@vger.kernel.org>; Tue, 2 May 2023 16:06:29 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qatf9fb4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 May 2023 16:06:29 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 2 May 2023 16:06:28 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 212FD2FD4BC86; Tue,  2 May 2023 16:06:21 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 00/10] Centralize BPF permission checks
Date:   Tue, 2 May 2023 16:06:09 -0700
Message-ID: <20230502230619.2592406-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 6Vi5Z1f7LBuEpBjGD0S-B-zHdWUKbWaC
X-Proofpoint-ORIG-GUID: 6Vi5Z1f7LBuEpBjGD0S-B-zHdWUKbWaC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_12,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set refactors BPF subsystem permission checks for BPF maps and
programs, localizes them in one place, and ensures all parts of BPF ecosystem
(BPF verifier and JITs, and their supporting infra) use recorded effective
capabilities, stored in respective bpf_map or bpf_prog structs, for further
decision making.

This allows for more explicit and centralized handling of BPF-related
capabilities and makes for simpler further BPF permission model evolution, to
be proposed and discussed in follow up patch sets.

Andrii Nakryiko (10):
  bpf: move unprivileged checks into map_create() and bpf_prog_load()
  bpf: inline map creation logic in map_create() function
  bpf: centralize permissions checks for all BPF map types
  bpf: remember if bpf_map was unprivileged and use that consistently
  bpf: drop unnecessary bpf_capable() check in BPF_MAP_FREEZE command
  bpf: keep BPF_PROG_LOAD permission checks clear of validations
  bpf: record effective capabilities at BPF prog load time
  bpf: use recorded BPF prog effective caps when fetching helper protos
  bpf: use recorded bpf_capable flag in JIT code
  bpf: consistenly use program's recorded capabilities in BPF verifier

 arch/arm/net/bpf_jit_32.c                     |   2 +-
 arch/arm64/net/bpf_jit_comp.c                 |   2 +-
 arch/loongarch/net/bpf_jit.c                  |   2 +-
 arch/mips/net/bpf_jit_comp.c                  |   2 +-
 arch/powerpc/net/bpf_jit_comp.c               |   2 +-
 arch/riscv/net/bpf_jit_core.c                 |   3 +-
 arch/s390/net/bpf_jit_comp.c                  |   3 +-
 arch/sparc/net/bpf_jit_comp_64.c              |   2 +-
 arch/x86/net/bpf_jit_comp.c                   |   3 +-
 arch/x86/net/bpf_jit_comp32.c                 |   2 +-
 drivers/media/rc/bpf-lirc.c                   |   2 +-
 include/linux/bpf.h                           |  32 ++-
 include/linux/filter.h                        |   8 +-
 kernel/bpf/arraymap.c                         |  59 +++--
 kernel/bpf/bloom_filter.c                     |   3 -
 kernel/bpf/bpf_local_storage.c                |   3 -
 kernel/bpf/bpf_struct_ops.c                   |   3 -
 kernel/bpf/cgroup.c                           |   6 +-
 kernel/bpf/core.c                             |  22 +-
 kernel/bpf/cpumap.c                           |   4 -
 kernel/bpf/devmap.c                           |   3 -
 kernel/bpf/hashtab.c                          |   6 -
 kernel/bpf/helpers.c                          |   6 +-
 kernel/bpf/lpm_trie.c                         |   3 -
 kernel/bpf/map_in_map.c                       |   3 +-
 kernel/bpf/queue_stack_maps.c                 |   4 -
 kernel/bpf/reuseport_array.c                  |   3 -
 kernel/bpf/stackmap.c                         |   3 -
 kernel/bpf/syscall.c                          | 218 ++++++++++++------
 kernel/bpf/trampoline.c                       |   2 +-
 kernel/bpf/verifier.c                         |  23 +-
 kernel/trace/bpf_trace.c                      |   2 +-
 net/core/filter.c                             |  36 +--
 net/core/sock_map.c                           |   4 -
 net/ipv4/bpf_tcp_ca.c                         |   2 +-
 net/netfilter/nf_bpf_link.c                   |   2 +-
 net/xdp/xskmap.c                              |   4 -
 .../bpf/prog_tests/unpriv_bpf_disabled.c      |   6 +-
 38 files changed, 280 insertions(+), 215 deletions(-)

-- 
2.34.1

