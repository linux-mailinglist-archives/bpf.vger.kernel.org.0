Return-Path: <bpf+bounces-1638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6654471F85C
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 04:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D415A1C211A3
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 02:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3446015B0;
	Fri,  2 Jun 2023 02:27:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D5E15A3
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 02:27:00 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2551192
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 19:26:58 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351NtYEm003992
	for <bpf@vger.kernel.org>; Thu, 1 Jun 2023 19:26:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=UKFC/MvQhBgh3MEqffvJY5B97DVR8hSvVpl0Fg2fhIs=;
 b=hU5o1V386+YVnt+P1KQLiUO3RxNstefs+Z2zV1w6JBvMSmBip5IkudlKz1V81gEHyC2x
 LWE+4Tne/eDvMC4RAKCq9MOHIDz61QgZZIVuTRqT75i02O4iAoEIj+RzFTWzTD2ccwRA
 gSQQrveH0yAv19gOSpVjJFWhsk79Dh9k3wk= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qxw0bd5uf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 19:26:58 -0700
Received: from twshared8528.02.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 19:26:57 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id CEA7A1EF7C822; Thu,  1 Jun 2023 19:26:48 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 0/9] bpf_refcount followups (part 1)
Date: Thu, 1 Jun 2023 19:26:38 -0700
Message-ID: <20230602022647.1571784-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: KgZCtbSJYAWnnvZcWXc4OGkoWbRjid9C
X-Proofpoint-ORIG-GUID: KgZCtbSJYAWnnvZcWXc4OGkoWbRjid9C
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
  * Patch 4 fixes the bpf_refcount_acquire issue by making it fallible for
    non-owning references
  * Patch 5 allows KF_DESTRUCTIVE kfuncs to be called when spinlock is held
    * This patch, and all patches further in the series, should not be
    applied
  * Patch 6 introduces some destructive bpf_testmod kfuncs which the selfte=
st
    added later in the series needs
  * Patch 7 adds a selftest which uses the kfuncs introduced in patch 5 to
    replicate the exact scenario raised by Kumar
  * Patch 8 disables the test added in patch 7
    * This is so the series (aside from DONOTAPPLY patches) can be applied
      without re-enabling bpf_refcount_acquire yet.
  * Patch 9 reverts patch 8 so that CI can run the newly-added test

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

Changelog:

v1 -> v2: lore.kernel.org/bpf/20230504053338.1778690-1-davemarchevsky@fb.com

Patch #s used below refer to the patch's position in v1 unless otherwise
specified.

  * General
    * Rebase onto latest bpf-next

    * All bpf_testmod-related changes (destructive kfuncs, etc) have been
      marked [DONOTAPPLY] in response to Alexei's comments in v1 and follow=
up
      conversations offline. They're still included as part of the series so
      that CI can exercise the fixed functionality.
      * v1's Patch 5 - "selftests/bpf: Add unsafe lock/unlock and refcount_=
read
        kfuncs to bpf_testmod" - was moved after the patches which are mean=
t to
        be applied to make it more obvious that it shouldn't be applied.

    * 4d585f48ee6b ("bpf: Remove anonymous union in bpf_kfunc_call_arg_meta=
")
      was shipped separately from this series in response to Alexei's comme=
nts
      about the anonymous union in kfunc_call_arg_meta. That patch removes =
the
      anonymous union and its members (arg_obj_drop, etc) in favor of the
      simpler approach suggested by Alexei in v1. This series'
      kfunc_call_arg_meta changes are modified to follow the new pattern.

Dave Marchevsky (9):
  [DONOTAPPLY] Revert "bpf: Disable bpf_refcount_acquire kfunc calls
    until race conditions are fixed"
  bpf: Set kptr_struct_meta for node param to list and rbtree insert
    funcs
  bpf: Fix __bpf_{list,rbtree}_add's beginning-of-node calculation
  bpf: Make bpf_refcount_acquire fallible for non-owning refs
  [DONOTAPPLY] bpf: Allow KF_DESTRUCTIVE-flagged kfuncs to be called
    under spinlock
  [DONOTAPPLY] selftests/bpf: Add unsafe lock/unlock and refcount_read
    kfuncs to bpf_testmod
  [DONOTAPPLY] selftests/bpf: Add test exercising bpf_refcount_acquire
    race condition
  [DONOTAPPLY] selftests/bpf: Disable newly-added refcounted_kptr_races
    test
  [DONOTAPPLY] Revert "selftests/bpf: Disable newly-added
    refcounted_kptr_races test"

 kernel/bpf/helpers.c                          |  12 +-
 kernel/bpf/verifier.c                         |  55 ++++--
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  61 +++++++
 .../bpf/prog_tests/refcounted_kptr.c          | 106 +++++++++++-
 .../selftests/bpf/progs/refcounted_kptr.c     | 160 ++++++++++++++++++
 .../bpf/progs/refcounted_kptr_fail.c          |   4 +-
 6 files changed, 379 insertions(+), 19 deletions(-)

--=20
2.34.1

