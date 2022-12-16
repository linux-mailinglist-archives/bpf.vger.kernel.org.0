Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B532464F3FB
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 23:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiLPWVX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 17:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiLPWUw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 17:20:52 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984A55F409
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 14:19:11 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGJxON0003499
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 14:19:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=fOgO+g4oRxtkV12ArlsoxvZqSqXpCMPO61/37+tL0NE=;
 b=OHO8o3N8Oew8XLiDl4E9WxBzp/amk5830bFAox90N+oqDe5mVr+LZqeqHyYQ9+eSk049
 2yQO3vWbGsHusSDJGmZbJ9YhM33X3XaBnV2wInNpNredFENGhZrGjHxRB9PYj7zSjseS
 OXtVylYUGV7xSxSFDv/B6w43JUdN4QTVp2/qNcpJK2tSBHz+DZhI58kYzQd+p9SC7B7P
 k0zQID8R6BKy5c+q/5E3vn/2A6uGgzY5MzjJugX1G82mzYyKRUZswSu5MGpWbpqf6+oR
 5GL7KHJJwsQXXvPHNNrmA3GMLgufwmkuMOol1lbIi+59VMD7+waExpcENd3ueSwPg58B oA== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mgdt172gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 14:19:11 -0800
Received: from twshared26225.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 16 Dec 2022 14:19:10 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 519FBB2A515; Fri, 16 Dec 2022 14:19:02 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <kernel-team@meta.com>, <song@kernel.org>, <yhs@meta.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v2 0/2] bpf: fix the crash caused by task iterators over vma
Date:   Fri, 16 Dec 2022 14:18:53 -0800
Message-ID: <20221216221855.4122288-1-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 8bs-sQK3AKOBwruo17zmALwqsNZIE1fy
X-Proofpoint-ORIG-GUID: 8bs-sQK3AKOBwruo17zmALwqsNZIE1fy
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_14,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This issue is related to task iterators over vma. A system crash can
occur when a task iterator travels through vma of tasks as the death
of a task will clear the pointer to its mm, even though the
task_struct is still held. As a result, an unexpected crash happens
due to a null pointer. To address this problem, a reference to mm is
kept on the iterator to make sure that the pointer is always
valid. This patch set provides a solution for this crash by properly
referencing mm on task iterators over vma.

The major changes from v1 are:

 - Fix commit logs of the test case.

 - Use reverse Christmas tree coding style.

 - Remove unnecessary error handling for time().

v1: https://lore.kernel.org/bpf/20221216015912.991616-1-kuifeng@meta.com/

Kui-Feng Lee (2):
  bpf: keep a reference to the mm, in case the task is dead.
  selftests/bpf: add a test for iter/task_vma for short-lived processes

 kernel/bpf/task_iter.c                        | 39 +++++++---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 73 +++++++++++++++++++
 2 files changed, 100 insertions(+), 12 deletions(-)

--=20
2.30.2

