Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1415EB073
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 20:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiIZSsD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 26 Sep 2022 14:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiIZSsC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 14:48:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1331B804AF
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 11:48:02 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QI9OaT008241
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 11:48:01 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jsy0tnerm-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 11:48:01 -0700
Received: from twshared12430.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 11:47:55 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id B374AD6AB46B; Mon, 26 Sep 2022 11:47:42 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        <kernel-team@fb.com>, <haoluo@google.com>, <jlayton@kernel.org>,
        <bjorn@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 0/2] enforce W^X for trampoline and dispatcher
Date:   Mon, 26 Sep 2022 11:47:37 -0700
Message-ID: <20220926184739.3512547-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: uJOOFZ5UtyRecnk9GVik1LJgATru5kpa
X-Proofpoint-ORIG-GUID: uJOOFZ5UtyRecnk9GVik1LJgATru5kpa
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Changes v1 => v2:
1. Update arch_prepare_bpf_dispatcher to use a RO image and a RW buffer.
   (Alexei) Note: I haven't found an existing test to cover this part, so
   this part was tested manually (comparing the generated dispatcher is
   the same).

Jeff Layton reported CPA W^X warning linux-next [1]. It turns out to be
W^X issue with bpf trampoline and bpf dispatcher. Fix these by:

1. Use bpf_prog_pack for bpf_dispatcher;
2. Set memory permission properly with bpf trampoline.

[1] https://lore.kernel.org/lkml/c84cc27c1a5031a003039748c3c099732a718aec.camel@kernel.org/

Song Liu (2):
  bpf: use bpf_prog_pack for bpf_dispatcher
  bpf: Enforce W^X for bpf trampoline

 arch/x86/net/bpf_jit_comp.c | 16 ++++++++--------
 include/linux/bpf.h         |  4 ++--
 include/linux/filter.h      |  5 +++++
 kernel/bpf/core.c           |  9 +++++++--
 kernel/bpf/dispatcher.c     | 27 +++++++++++++++++++++------
 kernel/bpf/trampoline.c     | 22 +++++-----------------
 6 files changed, 48 insertions(+), 35 deletions(-)

--
2.30.2
