Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB91654C44
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 06:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLWFtd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 23 Dec 2022 00:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLWFtc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Dec 2022 00:49:32 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919192657E
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:31 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BN13eOq013381
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:31 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mm4p9a6qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:31 -0800
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 22 Dec 2022 21:49:30 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A732023EA7537; Thu, 22 Dec 2022 21:49:23 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/7] BPF verifier state equivalence checks improvements
Date:   Thu, 22 Dec 2022 21:49:14 -0800
Message-ID: <20221223054921.958283-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ssUyTwqH7SLwH6H92cnIN3etlJUMkejK
X-Proofpoint-ORIG-GUID: ssUyTwqH7SLwH6H92cnIN3etlJUMkejK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-23_02,2022-12-22_03,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set fixes, improves, and refactors parts of BPF verifier's state
equivalence checks.

Patch #1 fixes refsafe(), making it take into account ID map when comparing
reference IDs. See patch for details.

Patches #2-#7 refactor regsafe() function which compares two register states
across old and current states. regsafe() is critical piece of logic, so to
make it easier to review and validate refactorings and logic fixes and
improvements, each patch makes a small change, explaining why the change is
correct and makes sense. Please see individual patches for details.

This patch set is one of the preliminaries required for upcoming BPF
open-coded iterators, as with open-coded iterators verifier's loop safety and
completion proof is critically dependent on correct state equivalence logic.

Andrii Nakryiko (7):
  bpf: teach refsafe() to take into account ID remapping
  bpf: reorganize struct bpf_reg_state fields
  bpf: generalize MAYBE_NULL vs non-MAYBE_NULL rule
  bpf: reject non-exact register type matches in regsafe()
  bpf: perform byte-by-byte comparison only when necessary in regsafe()
  bpf: fix regs_exact() logic in regsafe() to remap IDs correctly
  bpf: unify PTR_TO_MAP_{KEY,VALUE} with default case in regsafe()

 include/linux/bpf_verifier.h |  40 +++++-----
 kernel/bpf/verifier.c        | 151 +++++++++++++++++++----------------
 2 files changed, 101 insertions(+), 90 deletions(-)

-- 
2.30.2

