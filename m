Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2476575AFE
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 07:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiGOFbx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 15 Jul 2022 01:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGOFbx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 01:31:53 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923EC79EE5
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 22:31:51 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26ENccnE010039
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 22:31:51 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hae0w6xdn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 22:31:51 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub204.TheFacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 14 Jul 2022 22:31:50 -0700
Received: from twshared13579.04.prn5.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 14 Jul 2022 22:31:50 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5762C1C5C58D5; Thu, 14 Jul 2022 22:31:47 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 0/4] BPF array map fixes and improvements
Date:   Thu, 14 Jul 2022 22:31:42 -0700
Message-ID: <20220715053146.1291891-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 3oPxZlPewSZBErbln8cLncyHFmro0OrR
X-Proofpoint-ORIG-GUID: 3oPxZlPewSZBErbln8cLncyHFmro0OrR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_02,2022-07-14_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix 32-bit overflow in value pointer calculations in BPF array map. And then
raise obsolete limit on array map value size. Add selftest making sure this is
working as intended.

v1->v2:
  - fix broken patch #1 (no mask_index use in helper, as stated in commit
    message; and add missing semicolon).

Andrii Nakryiko (4):
  bpf: fix potential 32-bit overflow when accessing ARRAY map element
  bpf: make uniform use of array->elem_size everywhere in arraymap.c
  bpf: remove obsolete KMALLOC_MAX_SIZE restriction on array map value
    size
  selftests/bpf: validate .bss section bigger than 8MB is possible now

 kernel/bpf/arraymap.c                         | 40 ++++++++++---------
 .../selftests/bpf/prog_tests/skeleton.c       |  2 +
 .../selftests/bpf/progs/test_skeleton.c       |  4 ++
 3 files changed, 28 insertions(+), 18 deletions(-)

-- 
2.30.2

