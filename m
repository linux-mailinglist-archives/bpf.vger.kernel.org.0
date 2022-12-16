Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8378664E5C7
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 03:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiLPB7b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 20:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLPB7b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 20:59:31 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46652A27A
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 17:59:29 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BG0ii98008080
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 17:59:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=cgLT18edKnGvU8GnYh4/ci359mEtQDADC6xKls2SgRk=;
 b=INflmaKBgFcmkGLqvZHYVVMZoCLIBX1QNlw62s/4BAj4AbVcOd9ycR/G+2b4m+ZIUSdn
 dCQscIwFjKt4IiyS9awA/i4VbRVT38FOxnit2Hz3R6fquFlvGFFKzftIwHGhqjJmW/D6
 7lg2XelhWHkKWxE0JTWAe24pMdgSq7Q4ZGIdnY/2vsSIaxX0YRRE/1hHZ2GaUbtHGJyI
 6aHqrNXmcinpjqHTiKysYsMI5uF8ehPxmrbWva6iyl/3XclCtMlKI4AcFp0ZPGMzIDtc
 +VthSk6KX+vlZoisD26vah3Tlx/NBtBzhbKft6zpHHvBLhWH5oFP/6+r/FLjt0+NrIdW hw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mfy5sykmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 17:59:29 -0800
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 15 Dec 2022 17:59:28 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 272F0A5F23F; Thu, 15 Dec 2022 17:59:26 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <kernel-team@meta.com>, <song@kernel.org>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next 0/2] bpf: fix the crash caused by task iterators over vma
Date:   Thu, 15 Dec 2022 17:59:10 -0800
Message-ID: <20221216015912.991616-1-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: jJ-6kApdgk_HDi2RGmoFoaouvCgkBrzO
X-Proofpoint-ORIG-GUID: jJ-6kApdgk_HDi2RGmoFoaouvCgkBrzO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_12,2022-12-15_02,2022-06-22_01
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

Kui-Feng Lee (2):
  bpf: keep a reference to the mm, in case the task is dead.
  selftests/bpf: create new processes repeatedly in the background.

 kernel/bpf/task_iter.c                        | 39 ++++++---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 79 +++++++++++++++++++
 2 files changed, 106 insertions(+), 12 deletions(-)

--=20
2.30.2

