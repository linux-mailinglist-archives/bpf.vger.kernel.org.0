Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F0F524733
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 09:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351135AbiELHnf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 03:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351130AbiELHnc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 03:43:32 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4B71A15D7
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 00:43:30 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BMwcta022978
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 00:43:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=ByhkPJGjWMq6hRR0r0Icia/wFqttu4XpSB87h9gi23Q=;
 b=PuP+5kSPSeljDRhMSwGFyDqaXDuI79xBPbgDMooc2totfBgihzV+yyttP+Oug6Gm3vzi
 mnUZbMx9+ckrMZlfBAcYl7LRETBtT4/6jwulL/61OJDpl4rTiSDWBLk3l7MLCJcFe/KX
 OJguRhTQ2/E5us5fbT2g1UgGF5VRdUgw+Vk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g055hrmdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 00:43:30 -0700
Received: from twshared4937.07.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 00:43:29 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 778E378F7CC2; Thu, 12 May 2022 00:43:26 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rik van Riel <riel@surriel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFC PATCH bpf-next 0/5] bpf: add get_reg_val helper
Date:   Thu, 12 May 2022 00:43:16 -0700
Message-ID: <20220512074321.2090073-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: IAmh_MS7EB_JBojWGUJY1vZVj8ROQAK1
X-Proofpoint-GUID: IAmh_MS7EB_JBojWGUJY1vZVj8ROQAK1
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_01,2022-05-12_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, BPF programs can access register values from struct pt_regs.
Fetching other registers is not supported. For some usecases this limits
the usefulness of BPF programs. This series adds a helper meant to
fetch any register value for the architecture the program is running on.

Concrete motivating usecase: Tracing programs often attach to User
Statically-Defined Tracing (USDT) probes, which can pass arguments using
registers. The registers used to pass arguments for a specific probe are
determined at compile-time.=20

Although general-purpose registers which can be accessed via pt_regs are=20
usually chosen, register pressure can cause others to be used. Recently
we saw this happening in a Fedora libpthread library [0], where a xmm
register was used. Similarly, floating-point arguments in USDTs will
result in use of xmm register [1]. Since there is no way to access the
registers used to pass these arguments, BPF programs can't use them.

Another usecase: rdtsc access.

Initially the helper was meant to narrowly address the USDT xmm usecase
but conversation with Andrii highlighted the usefulness of a more
general helper. Although only x86 SSE reg fetching is added in this
patchset, the path forward for adding other register sets and
architectures should be clear.

Feedback from someone familiar with s390 or other arch regarding whether
the helper would be usable for other archs in current form would be
appreciated.


Summary of patches:

Patch 1 moves a header so fpregs_state_valid helper can be used.

Patches 2 and 3 contain the meat of the kernel- and libbpf-side
changes, respectively. Libbpf-side changes add use of the helper to usdt
lib in order to address USDT xmm issue that originally prompted this
work.

Patches 4 and 5 add tests.

Submitted as RFC for early feedback while failing usdt12 prog
verification is addressed (see patch 3).

  [0] - https://github.com/iovisor/bcc/pull/3880
	[1] - https://github.com/iovisor/bcc/issues/3875

Dave Marchevsky (5):
  x86/fpu: Move context.h to include/asm
  bpf: add get_reg_val helper
  libbpf: usdt lib wiring of xmm reads
  selftests/bpf: Add test for USDT parse of xmm reg
  selftests/bpf: get_reg_val test exercising fxsave fetch

 .../x86/{kernel =3D> include/asm}/fpu/context.h |   2 +
 arch/x86/kernel/fpu/core.c                    |   2 +-
 arch/x86/kernel/fpu/regset.c                  |   2 +-
 arch/x86/kernel/fpu/signal.c                  |   2 +-
 arch/x86/kernel/fpu/xstate.c                  |   2 +-
 include/linux/bpf.h                           |   1 +
 include/uapi/linux/bpf.h                      |  40 +++++
 kernel/trace/bpf_trace.c                      | 148 ++++++++++++++++++
 kernel/trace/bpf_trace.h                      |   1 +
 net/bpf/bpf_dummy_struct_ops.c                |  13 ++
 tools/include/uapi/linux/bpf.h                |  40 +++++
 tools/lib/bpf/usdt.bpf.h                      |  36 +++--
 tools/lib/bpf/usdt.c                          |  51 +++++-
 tools/testing/selftests/bpf/Makefile          |   8 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  13 ++
 tools/testing/selftests/bpf/prog_tests/usdt.c |  49 ++++++
 .../selftests/bpf/progs/test_urandom_usdt.c   |  37 +++++
 tools/testing/selftests/bpf/test_progs.c      |   7 +
 tools/testing/selftests/bpf/urandom_read.c    |   3 +
 .../selftests/bpf/urandom_read_lib_xmm.c      |  62 ++++++++
 20 files changed, 499 insertions(+), 20 deletions(-)
 rename arch/x86/{kernel =3D> include/asm}/fpu/context.h (96%)
 create mode 100644 tools/testing/selftests/bpf/urandom_read_lib_xmm.c

--=20
2.30.2

