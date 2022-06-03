Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB87B53D215
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 21:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348692AbiFCTDk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 3 Jun 2022 15:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348691AbiFCTDh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 15:03:37 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742FE30F7E
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 12:03:36 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 253GmI6Z020078
        for <bpf@vger.kernel.org>; Fri, 3 Jun 2022 12:03:35 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3gevu51g7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 12:03:35 -0700
Received: from twshared13315.14.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 3 Jun 2022 12:03:34 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id BCF8B1AC9C370; Fri,  3 Jun 2022 12:03:29 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 00/15] libbpf: remove deprecated APIs
Date:   Fri, 3 Jun 2022 12:01:40 -0700
Message-ID: <20220603190155.3924899-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: njDkcZySgeEfc4PkIY51xcDDD_8dkcEG
X-Proofpoint-GUID: njDkcZySgeEfc4PkIY51xcDDD_8dkcEG
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_06,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

NOTE. This shouldn't be yet landed until Jiri's changes ([1]) removing last
deprecated API usage in perf lands. But I thought to post it now to get the
ball rolling.

  [0] https://github.com/xdp-project/xdp-tools/tree/master/lib/libxdp
  [1] https://patchwork.kernel.org/project/netdevbpf/list/?series=647121&state=*

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
 tools/testing/selftests/bpf/Makefile          |    1 +
 tools/testing/selftests/bpf/bpf_legacy.h      |    9 -
 tools/testing/selftests/bpf/prog_tests/btf.c  |    1 -
 .../selftests/bpf/progs/test_btf_haskv.c      |   51 -
 .../selftests/bpf/progs/test_btf_newkv.c      |   18 -
 tools/testing/selftests/bpf/xdpxceiver.c      |    2 +-
 tools/{lib => testing/selftests}/bpf/xsk.c    |   76 +-
 tools/{lib => testing/selftests}/bpf/xsk.h    |   29 +-
 23 files changed, 260 insertions(+), 2750 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/test_btf_haskv.c
 rename tools/{lib => testing/selftests}/bpf/xsk.c (95%)
 rename tools/{lib => testing/selftests}/bpf/xsk.h (84%)

-- 
2.30.2

