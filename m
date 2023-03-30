Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122AE6CFA0B
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 06:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjC3ESL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 30 Mar 2023 00:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjC3ESI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 00:18:08 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82F11723
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 21:18:04 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TJTv95006282
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 21:18:03 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pmr5349t5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 21:18:03 -0700
Received: from twshared32017.39.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 29 Mar 2023 21:18:01 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C7A272C676650; Wed, 29 Mar 2023 21:17:51 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 0/8] Teach verifier to determine necessary log buffer size
Date:   Wed, 29 Mar 2023 21:16:34 -0700
Message-ID: <20230330041642.1118787-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: mQYzDuyr3yDEKpHUbS39X2HiyGcxykFa
X-Proofpoint-ORIG-GUID: mQYzDuyr3yDEKpHUbS39X2HiyGcxykFa
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_16,2023-03-28_02,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

My imagination is failing me on how to succinctly name this feature and patch
set, but the point here is to perform internal accounting of what should be
the necessary size of user-supplied log buffer such as to fit entire log
contents without truncation, thus avoiding -ENOSPC.

This is a long-standing limitation, which causes users and BPF loader library
writers to guess and pre-size log buffer, often allocating unnecessary extra
memory for this or doing extra program verifications just to size logs better,
ultimately wasting resources. This was requested most recently by Go BPF
library maintainers ([0]). 

Note, this patch set is based on top of not yet landed BPF verifier rotating
mode patch set ([1]), as those changes make it easier to implement this for
both fixed and rotating mode. This patch set is split from [1], as [1] is
pretty much ready to go in, and this one is more centered around UAPI aspects
and would probably require few iterations to finalize the UAPI. Regardless,
getting this out early to get feedback and see if this is useful for users.

Patches #1-#4 are some preliminary clean ups, fixed, improvements. Patch #5
implements internal logic and changes how fixed log mode operates, see that
patch for details. Patch #6 exposes log->len_max through UAPI. Patch #7 wires
this feature in libbpf API. Patch #8 adds selftests for this feature, both for
BPF_LOG_FIXED and default rotating log modes.

  [0] https://lore.kernel.org/bpf/CAN+4W8iNoEbQzQVbB_o1W0MWBDV4xCJAq7K3f6psVE-kkCfMqg@mail.gmail.com/
  [1] https://patchwork.kernel.org/project/netdevbpf/list/?series=734791&state=*

Andrii Nakryiko (8):
  bpf: ignore verifier log reset in BPF_LOG_KERNEL mode
  bpf: fix missing -EFAULT return on user log buf error in btf_parse()
  bpf: avoid incorrect -EFAULT error in BPF_LOG_KERNEL mode
  bpf: simplify logging related error conditions handling
  bpf: keep track of total log content size in both fixed and rolling
    modes
  bpf: add log_size_actual output field to return log contents size
  libbpf: wire through log_size_actual value returned from kernel
  selftests/bpf: add tests to validate log_size_actual feature

 include/linux/bpf.h                           |  2 +-
 include/linux/bpf_verifier.h                  | 12 +--
 include/linux/btf.h                           |  2 +-
 include/uapi/linux/bpf.h                      | 10 ++
 kernel/bpf/btf.c                              | 38 +++++---
 kernel/bpf/log.c                              | 68 ++++++++++----
 kernel/bpf/syscall.c                          | 16 ++--
 kernel/bpf/verifier.c                         | 12 ++-
 tools/include/uapi/linux/bpf.h                | 12 ++-
 tools/lib/bpf/bpf.c                           |  7 +-
 tools/lib/bpf/bpf.h                           | 11 ++-
 .../selftests/bpf/prog_tests/verifier_log.c   | 92 +++++++++++++++----
 12 files changed, 203 insertions(+), 79 deletions(-)

-- 
2.34.1

