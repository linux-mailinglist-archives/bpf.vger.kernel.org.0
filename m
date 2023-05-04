Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88E36F6467
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 07:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjEDFeA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 01:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjEDFd7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 01:33:59 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BAF1BF6
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 22:33:57 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3440qUDC025492
        for <bpf@vger.kernel.org>; Wed, 3 May 2023 22:33:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=LrX91rbgr29FilnIogrKh+0zLOTp8S+RSduGsnzERxg=;
 b=LK6DWaAcslZ/mMfdCajmIM3kU/1mG+kQAHtZjb5Pwhl4kK/8quChFARgNLbmpJm8vbzY
 /G3uMl9laQAUOhp7jAi/3dhVy4OXLnuvyLQP/5Lo1temKG+NIl/A5uiqB6mc5G065/sd
 ki2RU8pk20blC/+ORZqkewo8QYG9aF+lpMw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qbjd080kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 22:33:56 -0700
Received: from twshared17808.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 3 May 2023 22:33:56 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id C9D631D7BFC2A; Wed,  3 May 2023 22:33:44 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 0/9] bpf_refcount followups (part 1)
Date:   Wed, 3 May 2023 22:33:29 -0700
Message-ID: <20230504053338.1778690-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 8_csR3plKbGY47wIgxw-gt2azwHnsUy7
X-Proofpoint-ORIG-GUID: 8_csR3plKbGY47wIgxw-gt2azwHnsUy7
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_02,2023-05-03_01,2023-02-09_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series is the first of two (or more) followups to address issues in the
bpf_refcount shared ownership implementation discovered by Kumar.
Specifically, this series addresses the "bpf_refcount_acquire on non-owning=
 ref
in another tree" scenario described in [0], and does _not_ address issues
raised in [1]. Further followups will address the other issues.

The series can be applied without re-enabling bpf_refcount_acquire calls, w=
hich
were disabled in commit 7deca5eae833 ("bpf: Disable bpf_refcount_acquire kf=
unc
calls until race conditions are fixed") until all issues are addressed. Some
extra patches are included so that BPF CI tests will exercise test changes =
in
the series.

Patch contents:
  * Patch 1 reverts earlier disabling of bpf_refcount_acquire calls
    * Selftest added later in the series need to call bpf_refcount_acquire
    * This patch should not be applied and is included to allow CI to run t=
he
      newly-added test and exercise test changes in patch 6
  * Patches 2 and 3 fix other bugs introduced in bpf_refcount series which =
were
    discovered while reproducing the main issue this series addresses
  * Patch 4 allows KF_DESTRUCTIVE kfuncs to be called when spinlock is held
  * Patch 5 introduces some destructive bpf_testmod kfuncs which the selfte=
st
    added later in the series needs
    * Marked [RFC] as there's some copying of internal implementation that
      probably isn't correct. Suggestions needed for how to proceed.
  * Patch 6 fixes the bpf_refcount_acquire issue by making it fallible for
    non-owning references
  * Patch 7 adds a selftest which uses the kfuncs introduced in patch 5 to
    replicate the exact scenario raised by Kumar
  * Patch 8 disables the test added in patch 7
    * This is so the series (aside from DONOTAPPLY patches) can be applied
      without re-enabling bpf_refcount_acquire yet.
  * Patch 9 reverts patch 8 so that CI can run the newly-added test
    * This patch should not be applied

The first and last patches in the series are included to allow the CI to run
newly-added tests and should not be applied. First patch reverts earlier
disabling of bpf_refcount_acquire calls as the test reproducing
"bpf_refcount_acquire on non-owning ref in another tree" scenario obviously
needs to be able to call bpf_refcount_acquire.

While reproducing the scenario Kumar described in [0], which should cause a
refcount use-after-free, two unrelated bugs were found and are fixed by this
series.

  [0]: https://lore.kernel.org/bpf/atfviesiidev4hu53hzravmtlau3wdodm2vqs7rd=
7tnwft34e3@xktodqeqevir/
  [1]: https://lore.kernel.org/bpf/d7hyspcow5wtjcmw4fugdgyp3fwhljwuscp3xyut=
5qnwivyeru@ysdq543otzv2/

Dave Marchevsky (9):
  [DONOTAPPLY] Revert "bpf: Disable bpf_refcount_acquire kfunc calls
    until race conditions are fixed"
  bpf: Set kptr_struct_meta for node param to list and rbtree insert
    funcs
  bpf: Fix __bpf_{list,rbtree}_add's beginning-of-node calculation
  bpf: Allow KF_DESTRUCTIVE-flagged kfuncs to be called under spinlock
  [RFC] selftests/bpf: Add unsafe lock/unlock and refcount_read kfuncs
    to bpf_testmod
  bpf: Make bpf_refcount_acquire fallible for non-owning refs
  selftests/bpf: Add test exercising bpf_refcount_acquire race condition
  selftests/bpf: Disable newly-added refcounted_kptr_races test
  [DONOTAPPLY] Revert "selftests/bpf: Disable newly-added
    refcounted_kptr_races test"

 kernel/bpf/helpers.c                          |  12 +-
 kernel/bpf/verifier.c                         |  70 +++++---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  61 +++++++
 .../bpf/prog_tests/refcounted_kptr.c          | 106 +++++++++++-
 .../selftests/bpf/progs/refcounted_kptr.c     | 160 ++++++++++++++++++
 .../bpf/progs/refcounted_kptr_fail.c          |   4 +-
 6 files changed, 388 insertions(+), 25 deletions(-)

--=20
2.34.1


