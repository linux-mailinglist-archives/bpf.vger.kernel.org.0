Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1204FC388
	for <lists+bpf@lfdr.de>; Mon, 11 Apr 2022 19:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348890AbiDKRiF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Apr 2022 13:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348951AbiDKRhk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Apr 2022 13:37:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BCC1A38F
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 10:35:25 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23BGdZ0k013163
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 10:35:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=oVOKZSbmkw23k8CaO6YPtXs5ihxF9BfGXBDrL2qMq7A=;
 b=nGdF4QvxPsXmzJKKzcKcOqCVANguQqY9r1UtJUmR/m5PPwWvp11XE7L7LuyyLJIzot2A
 IoZKjilo6A9eNMrMeHw6pIOwTPX4VKLjJ7zADxmHreDq2+6hbE9qwIi3u3PrnlQ4COza
 RJce9+2hC+E3YzPiqp3tDKAU8TKavnVr1Nw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fb5fr33ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 10:35:25 -0700
Received: from twshared19572.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 11 Apr 2022 10:35:24 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id D0ADD225EE1C; Mon, 11 Apr 2022 10:35:11 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v4 0/5] Attach a cookie to a tracing program.
Date:   Mon, 11 Apr 2022 10:34:24 -0700
Message-ID: <20220411173429.4139609-1-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 95xeYinkqOAC8uUGkL5Bsqd6e0UbpS2y
X-Proofpoint-ORIG-GUID: 95xeYinkqOAC8uUGkL5Bsqd6e0UbpS2y
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-11_07,2022-04-11_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow users to attach a 64-bits cookie to a bpf_link of fentry, fexit,
or fmod_ret.

This patchset includes several major changes.

 - Define struct bpf_tramp_links to replace bpf_tramp_prog.
   struct bpf_tramp_links collects bpf_links of a trampoline

 - Generate a trampoline to call bpf_progs of given bpf_links.

 - Trampolines always set/reset bpf_run_ctx before/after
   calling/leaving a tracing program.

 - Attach a cookie to a bpf_link of fentry/fexit/fmod_ret.  The value
   will be available when running the associated bpf_prog.

The major differences from v3:

 - rebase v3 to latest tip.

The major differences from v2:

 - Move the allocations of run_ctx (struct bpf_tramp_run_ctx) out of
   invoke_bpf_prog().

 - Move hlist_node out of bpf_link and introduce struct bpf_tramp_link
   to own hlist_node.

 - Store cookies at struct bpf_tracing_link.

 - Use SIB byte to reduce the number of instructions to set cookie
   values. (Use RSP directly)

v1: https://lore.kernel.org/all/20220126214809.3868787-1-kuifeng@fb.com/
v2: https://lore.kernel.org/bpf/20220316004231.1103318-1-kuifeng@fb.com/
v3: https://lore.kernel.org/bpf/20220407192552.2343076-1-kuifeng@fb.com/

Kui-Feng Lee (5):
  bpf, x86: Generate trampolines from bpf_tramp_links
  bpf, x86: Create bpf_tramp_run_ctx on the caller thread's stack
  bpf, x86: Attach a cookie to fentry/fexit/fmod_ret.
  lib/bpf: Assign cookies to links in libbpf.
  selftest/bpf: The test cses of BPF cookie for fentry/fexit/fmod_ret.

 arch/x86/net/bpf_jit_comp.c                   | 98 +++++++++++++++----
 include/linux/bpf.h                           | 56 ++++++++---
 include/linux/bpf_types.h                     |  1 +
 include/uapi/linux/bpf.h                      |  9 ++
 kernel/bpf/bpf_struct_ops.c                   | 69 ++++++++-----
 kernel/bpf/syscall.c                          | 54 ++++++----
 kernel/bpf/trampoline.c                       | 96 +++++++++++-------
 kernel/trace/bpf_trace.c                      | 17 ++++
 net/bpf/bpf_dummy_struct_ops.c                | 35 ++++++-
 tools/bpf/bpftool/link.c                      |  1 +
 tools/include/uapi/linux/bpf.h                |  8 ++
 tools/lib/bpf/bpf.c                           |  7 ++
 tools/lib/bpf/bpf.h                           |  3 +
 tools/lib/bpf/libbpf.c                        | 33 +++++++
 tools/lib/bpf/libbpf.h                        | 12 +++
 tools/lib/bpf/libbpf.map                      |  1 +
 .../selftests/bpf/prog_tests/bpf_cookie.c     | 52 ++++++++++
 .../selftests/bpf/progs/test_bpf_cookie.c     | 24 +++++
 18 files changed, 459 insertions(+), 117 deletions(-)

--=20
2.30.2

