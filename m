Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A8F6E55AF
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 02:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjDRAWD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 17 Apr 2023 20:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjDRAWD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 20:22:03 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889A13AB3
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:21:57 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HLHshj012387
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:21:56 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q1c681f5v-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:21:56 -0700
Received: from twshared35445.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 17:21:56 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 535CA2E4F355A; Mon, 17 Apr 2023 17:21:49 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 0/6] Provide bpf_for() and bpf_for_each() by libbpf
Date:   Mon, 17 Apr 2023 17:21:42 -0700
Message-ID: <20230418002148.3255690-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bYyDrOB2fPZr5p0xd_xBz_ZsG48P81yE
X-Proofpoint-GUID: bYyDrOB2fPZr5p0xd_xBz_ZsG48P81yE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set moves bpf_for(), bpf_for_each(), and bpf_repeat() macros from
selftests-internal bpf_misc.h header to libbpf-provided bpf_helpers.h header.
To do this in a way to allow users to feature-detect and guard such
bpf_for()/bpf_for_each() uses on old kernels we also extend libbpf to improve
unresolved kfunc calls handling and reporting. This lets us mark
bpf_iter_num_{new,next,destroy}() declarations as __weak, and thus not fail
program loading outright if such kfuncs are missing on the host kernel.

Patches #1 and #2 do some simple clean ups and logging improvements. Patch #3
adds kfunc call poisoning and log fixup logic and is the hear of this patch
set, effectively. Patch #4 adds selftest for this logic. Patches #4 and #5
move bpf_for()/bpf_for_each()/bpf_repeat() into bpf_helpers.h header and mark
kfuncs as __weak to allow users to feature-detect and guard their uses.

Andrii Nakryiko (6):
  libbpf: misc internal libbpf clean ups around log fixup
  libbpf: report vmlinux vs module name when dealing with ksyms
  libbpf: improve handling of unresolved kfuncs
  selftests/bpf: add missing __weak kfunc log fixup test
  libbpf: move bpf_for(), bpf_for_each(), and bpf_repeat() into
    bpf_helpers.h
  libbpf: mark bpf_iter_num_{new,next,destroy} as __weak

 tools/lib/bpf/bpf_helpers.h                   | 103 +++++++++++++++++
 tools/lib/bpf/libbpf.c                        | 107 ++++++++++++++----
 .../selftests/bpf/prog_tests/log_fixup.c      |  31 +++++
 tools/testing/selftests/bpf/progs/bpf_misc.h  | 103 -----------------
 .../selftests/bpf/progs/test_log_fixup.c      |  10 ++
 5 files changed, 232 insertions(+), 122 deletions(-)

-- 
2.34.1

