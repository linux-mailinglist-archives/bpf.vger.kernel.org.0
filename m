Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7793A6A7ACA
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 06:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjCBFcg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 2 Mar 2023 00:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBFcf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 00:32:35 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CD34AFF1
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 21:32:29 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3220ofM4005035
        for <bpf@vger.kernel.org>; Wed, 1 Mar 2023 21:32:29 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p1junw6q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Mar 2023 21:32:29 -0800
Received: from twshared13785.14.prn3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 1 Mar 2023 21:32:28 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A0F4A290D0E81; Wed,  1 Mar 2023 21:32:19 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/8] Misc fixes and preliminaries for iterators
Date:   Wed, 1 Mar 2023 21:32:08 -0800
Message-ID: <20230302053216.1426015-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: EqgY7YoWlNXNcdFv0YSxFUWBmXCzfvTz
X-Proofpoint-ORIG-GUID: EqgY7YoWlNXNcdFv0YSxFUWBmXCzfvTz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_02,2023-03-01_03,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A bunch of small fixes and improvements done as preliminaries for upcoming
open-coded iterators. Sending them out a bit earlier to avoid dragging along
and rebasing a bunch of smallish changes.

Andrii Nakryiko (8):
  bpf: improve stack slot state printing
  bpf: improve regsafe() checks for PTR_TO_{MEM,BUF,TP_BUFFER}
  selftests/bpf: enhance align selftest's expected log matching
  bpf: honor env->test_state_freq flag in is_state_visited()
  selftests/bpf: adjust log_fixup's buffer size for proper truncation
  bpf: clean up visit_insn()'s instruction processing
  bpf: fix visit_insn()'s detection of BPF_FUNC_timer_set_callback
    helper
  bpf: ensure that r0 is marked scratched after any function call

 kernel/bpf/verifier.c                         | 111 +++++++++++-------
 .../testing/selftests/bpf/prog_tests/align.c  |  18 ++-
 .../selftests/bpf/prog_tests/log_fixup.c      |   2 +-
 3 files changed, 83 insertions(+), 48 deletions(-)

-- 
2.30.2

