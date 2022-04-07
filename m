Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E274F880D
	for <lists+bpf@lfdr.de>; Thu,  7 Apr 2022 21:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiDGT2h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Apr 2022 15:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiDGT23 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 15:28:29 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D5D281833
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 12:26:19 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 237IB3ah002156
        for <bpf@vger.kernel.org>; Thu, 7 Apr 2022 12:26:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=t/tGovwgtQ6Qr7tVYNR3SRcPe5u6bWX8xsW5g9mEpTQ=;
 b=bHH3twr9IW0o6ekQb2uNeeVQeRN8u4gF5JTzAOKQemA6oM4xlb1yHKz41hSSYkyJay14
 UfP16/imfGczsXpLv6JsMycPHTHKaWr22ZopUmtfQOeqryni87SdRWEfPmCCmR56Wiaz
 l+JcYV0r7lCZwPArebyf0HYAd9KtvGa6nqs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fa4pggpnr-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 07 Apr 2022 12:26:19 -0700
Received: from twshared13345.18.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 12:26:17 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 5D5EF200EE3F; Thu,  7 Apr 2022 12:26:10 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v3 0/5] Attach a cookie to a tracing program.
Date:   Thu, 7 Apr 2022 12:25:47 -0700
Message-ID: <20220407192552.2343076-1-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: hgwxXdgwUNA0s3tXnHidi1bf8L1EF0Fa
X-Proofpoint-ORIG-GUID: hgwxXdgwUNA0s3tXnHidi1bf8L1EF0Fa
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-07_04,2022-04-07_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

