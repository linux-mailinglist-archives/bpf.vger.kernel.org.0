Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7836CACF5
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 20:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjC0SXu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 27 Mar 2023 14:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjC0SXo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 14:23:44 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649DF4203
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:23:29 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 32RClHte022893
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:23:28 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3pkbertc68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:23:28 -0700
Received: from twshared38955.16.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 27 Mar 2023 11:23:27 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 0C9F92C1CAF89; Mon, 27 Mar 2023 11:23:16 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v3 bpf-next 0/3] veristat: add better support of freplace programs
Date:   Mon, 27 Mar 2023 11:20:16 -0700
Message-ID: <20230327182019.1671432-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="UTF-8"
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: YSSVj4viA64U5n6Iu3rCyYFTS1UWgHSG
X-Proofpoint-GUID: YSSVj4viA64U5n6Iu3rCyYFTS1UWgHSG
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Teach veristat how to deal with freplace BPF programs. As they can't be
directly loaded by veristat without custom user-space part that sets correct
target program FD, veristat always fails freplace programs. This patch set
teaches veristat to guess target program type that will be inherited by
freplace program itself, and subtitute it for BPF_PROG_TYPE_EXT (freplace) one
for the purposes of BPF verification.

Patch #1 fixes bug in libbpf preventing overriding freplace with specific
program type.

Patch #2 adds convenient -d flag to request veristat to emit libbpf debug
logs. It help debugging why a specific BPF program fails to load, if the
problem is not due to BPF verification itself.

v2->v3:
  - fix bpf_obj_id selftest that uses legacy bpf_prog_test_load() helper,
    which always sets program type programmatically; teach the helper to do it
    only if actually necessary (Stanislav);
v1->v2:
  - fix compilation error reported by old GCC (my GCC v11 doesn't produce even
    a warning) and Clang (see CI failure at [0]):

GCC version:

  veristat.c: In function ‘fixup_obj’:
  veristat.c:908:1: error: label at end of compound statement
    908 | skip_freplace_fixup:
        | ^~~~~~~~~~~~~~~~~~~

Clang version:

  veristat.c:909:1: error: label at end of compound statement is a C2x extension [-Werror,-Wc2x-extensions]
  }
  ^
  1 error generated.

  [0] https://github.com/kernel-patches/bpf/actions/runs/4515972059/jobs/7953845335

Andrii Nakryiko (3):
  libbpf: disassociate section handler on explicit
    bpf_program__set_type() call
  veristat: add -d debug mode option to see debug libbpf log
  veristat: guess and substitue underlying program type for freplace
    (EXT) progs

 tools/lib/bpf/libbpf.c                        |   1 +
 tools/testing/selftests/bpf/testing_helpers.c |   2 +-
 tools/testing/selftests/bpf/veristat.c        | 126 +++++++++++++++++-
 3 files changed, 123 insertions(+), 6 deletions(-)

-- 
2.34.1

