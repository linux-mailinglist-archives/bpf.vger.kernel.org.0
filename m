Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0961C4DA70A
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 01:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352836AbiCPApb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 20:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352841AbiCPApa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 20:45:30 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21F95DE5C
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 17:44:15 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22FNkasU028684
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 17:44:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=Eoa2k9SFC57gA74v6mw7lzJCn9/4umhgaAMoOf8BaNo=;
 b=RKiVcUK7LTEhCQjryeYhkIpWPb1hxL2s7nJaJhhq+ghAY97ZEkWlimdbLHXWxmrgSnSY
 6zJAZSLerOmvtN1Izd4MfUfQqLaeKkGFt900Y8tGJxNJCORiIDyHS5MtMfCOpMTvobyb
 O1KIdwvi8Re0ob77r6Xjra/lCSFEhkOl+5k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3et9d0bw1e-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 17:44:15 -0700
Received: from twshared13345.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 17:44:13 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 403C91269E1B; Tue, 15 Mar 2022 17:44:01 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v2 0/4] Attach a cookie to a tracing program.
Date:   Tue, 15 Mar 2022 17:42:27 -0700
Message-ID: <20220316004231.1103318-1-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: deVSeTFYURMAex2CNLYC85P7qx9PKqSi
X-Proofpoint-GUID: deVSeTFYURMAex2CNLYC85P7qx9PKqSi
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_11,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow users to attach a 64-bits cookie to a BPF program when linking
it to fentry, fexit, or fmod_ret of a function.

This patchset includes several major changes.

 - Define struct bpf_tramp_links to replace bpf_tramp_prog.
   struct bpf_tramp_links collects bpf_links of a trampoline

 - Generate a trampoline to call bpf_progs of given bpf_links.

 - Trampolines always set/reset bpf_run_ctx before/after
   calling/leaving a BPF program.

 - Attach a cookie to a bpf_link of fentry/fexit/fmod_ret.  The value
   will be available when running the associated bpf_prog.

The major differences from v1:

 - Remove program ID and flags from stacks.

 - Create bpf_trace_run_ctx on stacks.

 - Attach a cookie to a bpf_link.

 - Store the cookie of the running BPF program/link in bpf_trace_run_ctx.

v1: https://lore.kernel.org/all/20220126214809.3868787-1-kuifeng@fb.com/

Kui-Feng Lee (4):
  bpf, x86: Generate trampolines from bpf_links
  bpf, x86: Create bpf_trace_run_ctx on the caller thread's stack
  bpf, x86: Support BPF cookie for fentry/fexit/fmod_ret.
  selftest/bpf: The test cses of BPF cookie for fentry/fexit/fmod_ret.

 arch/x86/net/bpf_jit_comp.c                   | 68 ++++++++++----
 include/linux/bpf.h                           | 40 ++++----
 include/linux/bpf_types.h                     |  1 +
 include/uapi/linux/bpf.h                      |  2 +
 kernel/bpf/bpf_struct_ops.c                   | 68 +++++++++-----
 kernel/bpf/syscall.c                          | 19 ++--
 kernel/bpf/trampoline.c                       | 94 ++++++++++++-------
 kernel/trace/bpf_trace.c                      | 17 ++++
 net/bpf/bpf_dummy_struct_ops.c                | 35 ++++++-
 tools/bpf/bpftool/link.c                      |  1 +
 tools/include/uapi/linux/bpf.h                |  2 +
 tools/lib/bpf/bpf.c                           | 14 +++
 tools/lib/bpf/bpf.h                           |  1 +
 tools/lib/bpf/libbpf.map                      |  1 +
 .../selftests/bpf/prog_tests/bpf_cookie.c     | 61 ++++++++++++
 .../selftests/bpf/progs/test_bpf_cookie.c     | 24 +++++
 16 files changed, 344 insertions(+), 104 deletions(-)

--=20
2.30.2

