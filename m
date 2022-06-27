Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A29B55C8BD
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 14:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241060AbiF0VPm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 27 Jun 2022 17:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241052AbiF0VPl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 17:15:41 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FCE167C7
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:15:41 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RJ1RSF028851
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:15:40 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gwwpqe32w-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:15:40 -0700
Received: from twshared16308.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 27 Jun 2022 14:15:37 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 69EB91BAC2728; Mon, 27 Jun 2022 14:15:29 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 00/15] libbpf: remove deprecated APIs
Date:   Mon, 27 Jun 2022 14:15:12 -0700
Message-ID: <20220627211527.2245459-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SuGVN1FD_oXod2rgTwrOGjEarMumFq6o
X-Proofpoint-GUID: SuGVN1FD_oXod2rgTwrOGjEarMumFq6o
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set removes all the deprecated APIs in preparation for 1.0 release.
It also makes libbpf_set_strict_mode() a no-op (but keeps it to let per-1.0
applications buildable and dynamically linkable against libbpf 1.0 if they
were already libbpf-1.0 ready) and starts enforcing all the
behaviors that were previously opt-in through libbpf_set_strict_mode().

xsk.{c,h} parts that are now properly provided by libxdp ([0]) are still used
by xdpxceiver.c in selftest/bpf, so I've moved xsk.{c,h} with barely any
changes to under selftests/bpf.

Other than that, apart from removing all the LIBBPF_DEPRECATED-marked APIs,
there is a bunch of internal clean ups allowed by that. I've also "restored"
libbpf.map inheritance chain while removing all the deprecated APIs. I think
that's the right way to do this, as applications using libbpf as shared
library but not relying on any deprecated APIs (i.e., "good citizens" that
prepared for libbpf 1.0 release ahead of time to minimize disruption) should
be able to link both against 0.x and 1.x versions. Either way, it doesn't seem
to break anything and preserve a history on when each "surviving" API was
added.

  [0] https://github.com/xdp-project/xdp-tools/tree/master/lib/libxdp

v1->v2:
  - rebase on latest bpf-next now that Jiri's perf patches landed;
  - fix xsk.o dependency in Makefile to ensure libbpf headers are installed
    reliably.

Andrii Nakryiko (15):
  libbpf: move xsk.{c,h} into selftests/bpf
  libbpf: remove deprecated low-level APIs
  libbpf: remove deprecated XDP APIs
  libbpf: remove deprecated probing APIs
  libbpf: remove deprecated BTF APIs
  libbpf: clean up perfbuf APIs
  libbpf: remove prog_info_linear APIs
  libbpf: remove most other deprecated high-level APIs
  libbpf: remove multi-instance and custom private data APIs
  libbpf: cleanup LIBBPF_DEPRECATED_SINCE supporting macros for v0.x
  libbpf: remove internal multi-instance prog support
  libbpf: clean up SEC() handling
  selftests/bpf: remove last tests with legacy BPF map definitions
  libbpf: enforce strict libbpf 1.0 behaviors
  libbpf: fix up few libbpf.map problems

 tools/lib/bpf/Build                           |    2 +-
 tools/lib/bpf/Makefile                        |    2 +-
 tools/lib/bpf/bpf.c                           |  178 +-
 tools/lib/bpf/bpf.h                           |   83 -
 tools/lib/bpf/btf.c                           |  183 +--
 tools/lib/bpf/btf.h                           |   86 +-
 tools/lib/bpf/btf_dump.c                      |   23 +-
 tools/lib/bpf/libbpf.c                        | 1429 ++---------------
 tools/lib/bpf/libbpf.h                        |  469 +-----
 tools/lib/bpf/libbpf.map                      |  113 +-
 tools/lib/bpf/libbpf_common.h                 |   16 +-
 tools/lib/bpf/libbpf_internal.h               |   24 +-
 tools/lib/bpf/libbpf_legacy.h                 |   28 +-
 tools/lib/bpf/libbpf_probes.c                 |  125 +-
 tools/lib/bpf/netlink.c                       |   62 +-
 tools/testing/selftests/bpf/Makefile          |    2 +
 tools/testing/selftests/bpf/bpf_legacy.h      |    9 -
 tools/testing/selftests/bpf/prog_tests/btf.c  |    1 -
 .../selftests/bpf/progs/test_btf_haskv.c      |   51 -
 .../selftests/bpf/progs/test_btf_newkv.c      |   18 -
 tools/testing/selftests/bpf/xdpxceiver.c      |    2 +-
 tools/{lib => testing/selftests}/bpf/xsk.c    |   76 +-
 tools/{lib => testing/selftests}/bpf/xsk.h    |   29 +-
 23 files changed, 261 insertions(+), 2750 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/test_btf_haskv.c
 rename tools/{lib => testing/selftests}/bpf/xsk.c (95%)
 rename tools/{lib => testing/selftests}/bpf/xsk.h (84%)

-- 
2.30.2

