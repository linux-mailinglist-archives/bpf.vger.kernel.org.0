Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EE663FFBC
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 06:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiLBFLL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 2 Dec 2022 00:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiLBFLJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 00:11:09 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8DCD15AF
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 21:10:52 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B21wW8w004446
        for <bpf@vger.kernel.org>; Thu, 1 Dec 2022 21:10:52 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m6qec1mkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 01 Dec 2022 21:10:51 -0800
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub101.TheFacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 21:10:51 -0800
Received: from twshared13940.35.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 21:10:51 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A1AF722C31A5A; Thu,  1 Dec 2022 21:10:44 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/3] Refactor verifier prune and jump point handling
Date:   Thu, 1 Dec 2022 21:10:27 -0800
Message-ID: <20221202051030.3100390-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: aCMmabq_3kAZ6gJ_7Z0YmPmNfFLrlmYC
X-Proofpoint-ORIG-GUID: aCMmabq_3kAZ6gJ_7Z0YmPmNfFLrlmYC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_02,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Disentangle prune and jump points in BPF verifier code. They are conceptually
independent but currently coupled together. This small patch set refactors
related code and make it possible to have some instruction marked as pruning
or jump point independently.

Besides just conceptual cleanliness, this allows to remove unnecessary jump
points (saving a tiny bit of performance and memory usage, potentially), and
even more importantly it allows for clean extension of special pruning points,
similarly to how it's done for BPF_FUNC_timer_set_callback. This will be used
by future patches implementing open-coded BPF iterators.

Andrii Nakryiko (3):
  bpf: decouple prune and jump points
  bpf: mostly decouple jump history management from is_state_visited()
  bpf: remove unnecessary prune and jump points

 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 98 +++++++++++++++++++++---------------
 2 files changed, 58 insertions(+), 41 deletions(-)

-- 
2.30.2

