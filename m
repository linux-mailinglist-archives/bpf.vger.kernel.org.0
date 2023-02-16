Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6CA698B80
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 06:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjBPFAC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 16 Feb 2023 00:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBPFAB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 00:00:01 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C1E234E3
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 21:00:00 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G4YOPl031339
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 20:59:59 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nrc19m4ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 20:59:59 -0800
Received: from twshared43869.37.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 15 Feb 2023 20:59:58 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 6FC1527990B90; Wed, 15 Feb 2023 20:59:55 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 0/3] Fix BPF verifier global subprog context argument logic
Date:   Wed, 15 Feb 2023 20:59:51 -0800
Message-ID: <20230216045954.3002473-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VZ2fO7NS4zQvKRyrd1CFFozLLnDW7TLS
X-Proofpoint-GUID: VZ2fO7NS4zQvKRyrd1CFFozLLnDW7TLS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_02,2023-02-15_01,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix kernel bug in determining whether global subprog's argument is PTR_TO_CTX,
which is done based on type names. Currently KPROBE programs are broken.

Add few tests validating that KPROBE context can be passed to global subprog.
For that also refactor test_global_funcs test to use test_loader framework.

v1->v2:
  - fix compilation warning on arm64 and s390x by force-casting ctx to
    `void *`, to discard const from `const struct user_pt_regs *`, when
    passing it to bpf_get_stack().

Andrii Nakryiko (3):
  bpf: fix global subprog context argument resolution logic
  selftests/bpf: convert test_global_funcs test to test_loader framework
  selftests/bpf: add global subprog context passing tests

 kernel/bpf/btf.c                              |  13 +-
 .../bpf/prog_tests/test_global_funcs.c        | 133 +++++-------------
 .../selftests/bpf/progs/test_global_func1.c   |   6 +-
 .../selftests/bpf/progs/test_global_func10.c  |   4 +-
 .../selftests/bpf/progs/test_global_func11.c  |   4 +-
 .../selftests/bpf/progs/test_global_func12.c  |   4 +-
 .../selftests/bpf/progs/test_global_func13.c  |   4 +-
 .../selftests/bpf/progs/test_global_func14.c  |   4 +-
 .../selftests/bpf/progs/test_global_func15.c  |   4 +-
 .../selftests/bpf/progs/test_global_func16.c  |   4 +-
 .../selftests/bpf/progs/test_global_func17.c  |   4 +-
 .../selftests/bpf/progs/test_global_func2.c   |  43 +++++-
 .../selftests/bpf/progs/test_global_func3.c   |  10 +-
 .../selftests/bpf/progs/test_global_func4.c   |  55 +++++++-
 .../selftests/bpf/progs/test_global_func5.c   |   4 +-
 .../selftests/bpf/progs/test_global_func6.c   |   4 +-
 .../selftests/bpf/progs/test_global_func7.c   |   4 +-
 .../selftests/bpf/progs/test_global_func8.c   |   4 +-
 .../selftests/bpf/progs/test_global_func9.c   |   4 +-
 .../bpf/progs/test_global_func_ctx_args.c     | 105 ++++++++++++++
 20 files changed, 292 insertions(+), 125 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c

-- 
2.30.2

