Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2A75BDB25
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 06:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiITEID convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 20 Sep 2022 00:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiITEIC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 00:08:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65FF4B496
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 21:08:01 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JMsr3b007782
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 21:08:01 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jpmfxqtxh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 21:08:01 -0700
Received: from twshared22593.02.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 21:07:58 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 794F71F1BEBF2; Mon, 19 Sep 2022 21:07:44 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/3] veristat: CSV output, comparison mode, filtering
Date:   Mon, 19 Sep 2022 21:07:33 -0700
Message-ID: <20220920040736.342025-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 4DO8TVzc8S0KFhc7hh4GzRk1xGyFByCT
X-Proofpoint-ORIG-GUID: 4DO8TVzc8S0KFhc7hh4GzRk1xGyFByCT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_13,2022-09-16_01,2022-06-22_01
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

Andrii Nakryiko (3):
  selftests/bpf: add CSV output mode for veristat
  selftests/bpf: add comparison mode to veristat
  selftests/bpf: add ability to filter programs in veristat

 tools/testing/selftests/bpf/veristat.c   | 853 ++++++++++++++++++++---
 tools/testing/selftests/bpf/veristat.cfg |  16 +
 2 files changed, 786 insertions(+), 83 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/veristat.cfg

-- 
2.30.2

