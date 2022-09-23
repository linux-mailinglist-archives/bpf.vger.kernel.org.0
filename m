Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F48F5E84C1
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 23:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiIWVS5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 23 Sep 2022 17:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIWVS4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 17:18:56 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B52912206C
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 14:18:55 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NIGEhs001985
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 14:18:54 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jsf8t2qwq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 14:18:54 -0700
Received: from twshared10425.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 14:18:52 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id D5384D4BF973; Fri, 23 Sep 2022 14:18:47 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        <kernel-team@fb.com>, <haoluo@google.com>, <jlayton@kernel.org>,
        Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 0/2] enforce W^X for trampoline and dispatcher
Date:   Fri, 23 Sep 2022 14:18:35 -0700
Message-ID: <20220923211837.3044723-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 17X8NOxr_SMBu_Bb8pURjPbgWw9nuwk6
X-Proofpoint-GUID: 17X8NOxr_SMBu_Bb8pURjPbgWw9nuwk6
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_10,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jeff Layton reported CPA W^X warning linux-next [1]. It turns out to be
W^X issue with bpf trampoline and bpf dispatcher. Fix these by:

1. Use bpf_prog_pack for bpf_dispatcher;
2. Set memory permission properly with bpf trampoline.

[1] https://lore.kernel.org/lkml/c84cc27c1a5031a003039748c3c099732a718aec.camel@kernel.org/

Song Liu (2):
  bpf: use bpf_prog_pack for bpf_dispatcher
  bpf: Enforce W^X for bpf trampoline

 include/linux/bpf.h     |  2 +-
 include/linux/filter.h  |  5 +++++
 kernel/bpf/core.c       |  9 +++++++--
 kernel/bpf/dispatcher.c | 21 ++++++++++++++++++---
 kernel/bpf/trampoline.c | 22 +++++-----------------
 5 files changed, 36 insertions(+), 23 deletions(-)

--
2.30.2
