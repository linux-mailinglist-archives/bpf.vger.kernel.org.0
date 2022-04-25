Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D194F50EAC2
	for <lists+bpf@lfdr.de>; Mon, 25 Apr 2022 22:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245621AbiDYUqX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 25 Apr 2022 16:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbiDYUqX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 16:46:23 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A84762BB
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 13:43:17 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PHP77h016848
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 13:43:17 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fmcsgwjgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 13:43:17 -0700
Received: from twshared19572.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 13:43:15 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 4AE8B652E79B; Mon, 25 Apr 2022 13:40:33 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <hch@infradead.org>, <peterz@infradead.org>,
        <torvalds@linux-foundation.org>, Song Liu <song@kernel.org>
Subject: [PATCH bpf v2 0/3] bpf: invalidate unused part of bpf_prog_pack
Date:   Mon, 25 Apr 2022 13:39:44 -0700
Message-ID: <20220425203947.3311308-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: s9PUIVs7SLQJvHytjQiIrkCfd__r9AAN
X-Proofpoint-ORIG-GUID: s9PUIVs7SLQJvHytjQiIrkCfd__r9AAN
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Note: while prefixed with "bpf", this set is based on Linus' master branch.

This is v2 of [1]. It is revised based on Peter's feedback. The patch is
also split into 3.

[1] https://lore.kernel.org/linux-mm/20220421072212.608884-1-song@kernel.org/

Song Liu (3):
  bpf: fill new bpf_prog_pack with illegal instructions
  x86/alternative: introduce text_poke_set
  bpf: introduce bpf_arch_text_invalidate for bpf_prog_pack

 arch/x86/include/asm/text-patching.h |  1 +
 arch/x86/kernel/alternative.c        | 70 ++++++++++++++++++++++++----
 arch/x86/net/bpf_jit_comp.c          |  5 ++
 include/linux/bpf.h                  |  1 +
 kernel/bpf/core.c                    | 18 +++++--
 5 files changed, 81 insertions(+), 14 deletions(-)

--
2.30.2
