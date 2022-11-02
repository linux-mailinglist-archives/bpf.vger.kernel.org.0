Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C32F615C37
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 07:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKBGWn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 2 Nov 2022 02:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiKBGWk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 02:22:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8442D25E86
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 23:22:37 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2A25BQsL007258
        for <bpf@vger.kernel.org>; Tue, 1 Nov 2022 23:22:36 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3kjvgscc53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 01 Nov 2022 23:22:36 -0700
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 23:22:35 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 62C3A20F58A14; Tue,  1 Nov 2022 23:22:23 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/6] BPF verifier precision tracking improvements
Date:   Tue, 1 Nov 2022 23:22:15 -0700
Message-ID: <20221102062221.2019833-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZKer9n_9JA1YO1DjLm-LAbrz6XlMFzYH
X-Proofpoint-GUID: ZKer9n_9JA1YO1DjLm-LAbrz6XlMFzYH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_02,2022-11-01_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set fixes and improves BPF verifier's precision tracking logic for
SCALAR registers.

Patches #1 and #2 are bug fixes discovered while working on these changes.

Patch #3 enables precision tracking for BPF programs that contain subprograms.
This was disabled before and prevent any modern BPF programs that use
subprograms from enjoying the benefits of SCALAR (im)precise logic.

Patch #4 is few lines of code changes and many lines of explaining why those
changes are correct. We establish why ignoring precise markings in current
state is OK.

Patch #5 build on explanation in patch #4 and pushes it to the limit by
forcefully forgetting inherited precise markins. Patch #4 by itself doesn't
prevent current state from having precise=true SCALARs, so patch #5 is
necessary to prevent such stray precise=true registers from creeping in.

Patch #6 adjusts test_align selftests to work around BPF verifier log's
limitations when it comes to interactions between state output and precision
backtracking output.

Overall, the goal of this patch set is to make BPF verifier's state tracking
a bit more efficient by trying to preserve as much generality in checkpointed
states as possible.

Andrii Nakryiko (6):
  bpf: propagate precision in ALU/ALU64 operations
  bpf: propagate precision across all frames, not just the last one
  bpf: allow precision tracking for programs with subprogs
  bpf: stop setting precise in current state
  bpf: aggressively forget precise markings during state checkpointing
  selftests/bpf: make test_align selftest more robust

 kernel/bpf/verifier.c                         | 277 +++++++++++++++---
 .../testing/selftests/bpf/prog_tests/align.c  |  38 ++-
 2 files changed, 256 insertions(+), 59 deletions(-)

-- 
2.30.2

