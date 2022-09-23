Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CD05E8136
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 19:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiIWR71 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 23 Sep 2022 13:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbiIWR70 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 13:59:26 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6733B13A944
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 10:59:25 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NH22gM012369
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 10:59:24 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3js7mxc3kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 10:59:24 -0700
Received: from twshared12430.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 10:59:23 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 677901F41C915; Fri, 23 Sep 2022 10:59:14 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 0/5] veristat: further usability improvements
Date:   Fri, 23 Sep 2022 10:59:08 -0700
Message-ID: <20220923175913.3272430-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Sjx1-YELheHk5qhKiKA5vKyc43hfp8HU
X-Proofpoint-GUID: Sjx1-YELheHk5qhKiKA5vKyc43hfp8HU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_06,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A small patch set adding few usability improvements and features making
veristat a more convenient tool to be used for work on BPF verifier:

  - patch #2 speeds up and makes stats parsing from BPF verifier log more
    robust;

  - patch #3 makes veristat less strict about input object files; veristat
    will ignore non-BPF ELF files;

  - patch #4 adds progress log, by default, so that user doing
    mass-verification is aware that veristat is not stuck;

  - patch #5 allows to tune requested BPF verifier log level, which makes
    veristat a simplest way to get BPF verifier log, especially successfully
    verified ones.

v1->v2:
  - don't emit progress in non-table mode, as it breaks CSV output.

Andrii Nakryiko (5):
  selftests/bpf: add sign-file to .gitignore
  selftests/bpf: make veristat's verifier log parsing faster and more
    robust
  selftests/bpf: make veristat skip non-BPF and failing-to-open BPF
    objects
  selftests/bpf: emit processing progress and add quiet mode to veristat
  selftests/bpf: allow to adjust BPF verifier log level in veristat

 tools/testing/selftests/bpf/.gitignore |   1 +
 tools/testing/selftests/bpf/veristat.c | 136 +++++++++++++++++++++----
 2 files changed, 118 insertions(+), 19 deletions(-)

-- 
2.30.2

