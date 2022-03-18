Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB334DD405
	for <lists+bpf@lfdr.de>; Fri, 18 Mar 2022 05:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiCRE6E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Mar 2022 00:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiCRE6D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Mar 2022 00:58:03 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FE5268C03
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 21:56:45 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22I14mZR024714
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 21:56:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=o93ZB+i8GjIQrJaHPc8kE5LG4gGapbhEHIBxDpKsMKU=;
 b=rOvp5g3DCF+I57tAicd5wXiEDhoT9ltnMKk+CW0S31+zlfDYCbYgTxjPkktdn/9LmgTG
 ZuEGIGi7uRsPtMVd8ggoXvX7FzzTy1kSWybdCqPli6utfH/6d3KuJ4G+ScUSK+MwYuBb
 X1OZfFMv1WXTOm9KdpgTcxEnbMiv+dR86LI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3evg3kgt37-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 21:56:45 -0700
Received: from twshared5730.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 21:56:43 -0700
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 9C5659C8E634; Thu, 17 Mar 2022 21:56:35 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <kafai@fb.com>, <kpsingh@kernel.org>, <memxor@gmail.com>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <tj@kernel.org>, <davemarchevsky@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v3 0/2] Enable non-atomic allocations in local storage
Date:   Thu, 17 Mar 2022 21:55:51 -0700
Message-ID: <20220318045553.3091807-1-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: xkiPTAmwHXxxhMViTkDYM6wguKAr4-q6
X-Proofpoint-ORIG-GUID: xkiPTAmwHXxxhMViTkDYM6wguKAr4-q6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-18_05,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Joanne Koong <joannelkoong@gmail.com>

Currently, local storage memory can only be allocated atomically
(GFP_ATOMIC). This restriction is too strict for sleepable bpf
programs.

In this patchset, sleepable programs can allocate memory in local
storage using GFP_KERNEL, while non-sleepable programs always default to
GFP_ATOMIC.

v3 <- v2:
* Add extra case to local_storage.c selftest to test associating multiple
elements with the local storage, which triggers a GFP_KERNEL allocation i=
n
local_storage_update().
* Cast gfp_t to __s32 in verifier to fix the sparse warnings

v2 <- v1:
* Allocate the memory before/after the raw_spin_lock_irqsave, depending
on the gfp flags
* Rename mem_flags to gfp_flags
* Reword the comment "*mem_flags* is set by the bpf verifier" to
"*gfp_flags* is a hidden argument provided by the verifier"
* Add a sentence to the commit message about existing local storage
selftests covering both the GFP_ATOMIC and GFP_KERNEL paths in
bpf_local_storage_update.

Joanne Koong (2):
  bpf: Enable non-atomic allocations in local storage
  selftests/bpf: Test for associating multiple elements with the local
    storage

 include/linux/bpf_local_storage.h             |  7 ++-
 kernel/bpf/bpf_inode_storage.c                |  9 +--
 kernel/bpf/bpf_local_storage.c                | 58 ++++++++++++-------
 kernel/bpf/bpf_task_storage.c                 | 10 ++--
 kernel/bpf/verifier.c                         | 20 +++++++
 net/core/bpf_sk_storage.c                     | 21 ++++---
 .../selftests/bpf/progs/local_storage.c       | 19 ++++++
 7 files changed, 103 insertions(+), 41 deletions(-)

--=20
2.30.2

