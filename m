Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813136E0072
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 23:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjDLVFa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 12 Apr 2023 17:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDLVF3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 17:05:29 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4CF7A82
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 14:05:19 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CI943w023694
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 14:04:39 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pwuqa3m3y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 14:04:39 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 12 Apr 2023 14:04:37 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 6FCA41B0AF02E; Wed, 12 Apr 2023 14:04:30 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@meta.com>, Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 0/3] Fix a few BPF selftests
Date:   Wed, 12 Apr 2023 14:04:20 -0700
Message-ID: <20230412210423.900851-1-song@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: GxlIY3Kjyniol53PgBlHnVtum_QSjUkk
X-Proofpoint-ORIG-GUID: GxlIY3Kjyniol53PgBlHnVtum_QSjUkk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_11,2023-04-12_01,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix a few BPF selftests. Please see each patch for details of these fixes.

Song Liu (3):
  selftests/bpf: Use read_perf_max_sample_freq() in perf_event_stackmap
  selftests/bpf: Fix leaked bpf_link in get_stackid_cannot_attach
  selftests/bpf: Keep the loop in bpf_testmod_loop_test

 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  6 +++++-
 .../prog_tests/get_stackid_cannot_attach.c    |  1 +
 .../bpf/prog_tests/perf_event_stackmap.c      |  3 ++-
 .../bpf/prog_tests/stacktrace_build_id_nmi.c  | 15 --------------
 tools/testing/selftests/bpf/testing_helpers.c | 20 +++++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h |  2 ++
 6 files changed, 30 insertions(+), 17 deletions(-)

--
2.34.1
