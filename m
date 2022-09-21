Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4243F5C0498
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 18:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiIUQtw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 21 Sep 2022 12:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiIUQt1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 12:49:27 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01E891D13
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 09:43:09 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 28LFUegP007838
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 09:43:08 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3jqbd2b4j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 09:43:08 -0700
Received: from twshared22593.02.prn5.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 09:43:07 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id EA8A61F2B4F90; Wed, 21 Sep 2022 09:42:54 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 0/4] veristat: CSV output, comparison mode, filtering
Date:   Wed, 21 Sep 2022 09:42:50 -0700
Message-ID: <20220921164254.3630690-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ONOPi0supnPDvsa8K39CT-RW2L4_Ay19
X-Proofpoint-GUID: ONOPi0supnPDvsa8K39CT-RW2L4_Ay19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_09,2022-09-20_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add three more critical features to veristat tool, which make it sufficient
for a practical work on BPF verifier:

  - CSV output, which allows easier programmatic post-processing of stats;

  - building upon CSV output, veristat now supports comparison mode, in which
    two previously captured CSV outputs from veristat are compared with each
    other in a convenient form;

  - flexible allow/deny filtering using globs for BPF object files and
    programs, allowing to narrow down target BPF programs to be verified.

See individual patches for more details and examples.

v1->v2:
- split out double-free fix into patch #1 (Yonghong);
- fixed typo in verbose flag (Quentin);
- baseline and comparison stats were reversed in output table, fixed that.

Andrii Nakryiko (4):
  selftests/bpf: fix double bpf_object__close() in veristate
  selftests/bpf: add CSV output mode for veristat
  selftests/bpf: add comparison mode to veristat
  selftests/bpf: add ability to filter programs in veristat

 tools/testing/selftests/bpf/veristat.c   | 853 ++++++++++++++++++++---
 tools/testing/selftests/bpf/veristat.cfg |  17 +
 2 files changed, 787 insertions(+), 83 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/veristat.cfg

-- 
2.30.2

