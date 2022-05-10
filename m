Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757645225F8
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 22:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiEJU7w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 16:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiEJU7w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 16:59:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEB5267091
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 13:59:49 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AFM5jY002594
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 13:59:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=dhZbyATImo8ncvRkrNaMek1HVF9urvQAiOoigkL9z10=;
 b=qRL/lBSmG9fg+IQjD5iYFBv09p03OG8f92wvDvZLQ7e5Ntn7CQsJefQ2qVnDd3r5kdDC
 WuSBLkWkXJ1So9mSkDdJA9B374vmbEjCbEgfP/emOqHp7sd2C9HLS4UV6xlOlcOqPxcc
 Lfl/1viq/V6Si9AkUZcCPd90WBB9t2xZCns= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fygdk68et-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 13:59:49 -0700
Received: from twshared19572.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 13:59:46 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id B1ADA32F202D; Tue, 10 May 2022 13:59:43 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>, <xukuohai@huawei.com>
Subject: [PATCH bpf-next v8 0/5] Attach a cookie to a tracing program.
Date:   Tue, 10 May 2022 13:59:18 -0700
Message-ID: <20220510205923.3206889-1-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XjmaDaM3kOfdFvzWOu-fZRCjpEakdB2V
X-Proofpoint-GUID: XjmaDaM3kOfdFvzWOu-fZRCjpEakdB2V
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_07,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

 - Attach a cookie to a bpf_link of fentry/fexit/fmod_ret/lsm.  The
   value will be available when running the associated bpf_prog.

Th major differences from v6:

 - bpf_link_create() can create links of BPF_LSM_MAC attach type.

 - Add a test for lsm.

 - Add function proto of bpf_get_attach_cookie() for lsm.

 - Check BPF_LSM_MAC in bpf_prog_has_trampoline().

 - Adapt to the changes of LINK_CREATE made by Andrii.

The major differences from v7:

 - Change stack_size instead of pushing/popping run_ctx.

 - Move cookie to bpf_tramp_link from bpf_tracing_link..

v1: https://lore.kernel.org/all/20220126214809.3868787-1-kuifeng@fb.com/
v2: https://lore.kernel.org/bpf/20220316004231.1103318-1-kuifeng@fb.com/
v3: https://lore.kernel.org/bpf/20220407192552.2343076-1-kuifeng@fb.com/
v4: https://lore.kernel.org/bpf/20220411173429.4139609-1-kuifeng@fb.com/
v5: https://lore.kernel.org/bpf/20220412165555.4146407-1-kuifeng@fb.com/
v6: https://lore.kernel.org/bpf/20220416042940.656344-1-kuifeng@fb.com/
v7: https://lore.kernel.org/bpf/20220508032117.2783209-1-kuifeng@fb.com/

Kui-Feng Lee (5):
  bpf, x86: Generate trampolines from bpf_tramp_links
  bpf, x86: Create bpf_tramp_run_ctx on the caller thread's stack
  bpf, x86: Attach a cookie to fentry/fexit/fmod_ret/lsm.
  libbpf: Assign cookies to links in libbpf.
  selftest/bpf: The test cses of BPF cookie for
    fentry/fexit/fmod_ret/lsm.

 arch/x86/net/bpf_jit_comp.c                   |  76 ++++++++-----
 include/linux/bpf.h                           |  54 +++++++---
 include/linux/bpf_types.h                     |   1 +
 include/uapi/linux/bpf.h                      |  10 ++
 kernel/bpf/bpf_lsm.c                          |  17 +++
 kernel/bpf/bpf_struct_ops.c                   |  71 +++++++++----
 kernel/bpf/syscall.c                          |  42 ++++----
 kernel/bpf/trampoline.c                       | 100 +++++++++++-------
 kernel/trace/bpf_trace.c                      |  17 +++
 net/bpf/bpf_dummy_struct_ops.c                |  24 ++++-
 tools/bpf/bpftool/link.c                      |   1 +
 tools/include/uapi/linux/bpf.h                |  10 ++
 tools/lib/bpf/bpf.c                           |   8 ++
 tools/lib/bpf/bpf.h                           |   3 +
 tools/lib/bpf/libbpf.c                        |  19 +++-
 tools/lib/bpf/libbpf.h                        |  12 +++
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/bpf_cookie.c     |  89 ++++++++++++++++
 .../selftests/bpf/progs/test_bpf_cookie.c     |  52 +++++++--
 19 files changed, 469 insertions(+), 138 deletions(-)

--=20
2.30.2

