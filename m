Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA8853BF1C
	for <lists+bpf@lfdr.de>; Thu,  2 Jun 2022 21:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238943AbiFBTtD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 2 Jun 2022 15:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238967AbiFBTs5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jun 2022 15:48:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D5C35DD2
        for <bpf@vger.kernel.org>; Thu,  2 Jun 2022 12:48:47 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2529sgXA008870
        for <bpf@vger.kernel.org>; Thu, 2 Jun 2022 12:48:47 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3geu05bgdc-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Jun 2022 12:48:47 -0700
Received: from twshared14818.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 2 Jun 2022 12:48:43 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 531D786C006A; Thu,  2 Jun 2022 12:37:12 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <rostedt@goodmis.org>, <jolsa@kernel.org>,
        <mhiramat@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 0/5] ftrace: host klp and bpf trampoline together
Date:   Thu, 2 Jun 2022 12:37:01 -0700
Message-ID: <20220602193706.2607681-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: IN7z0R5WgFm31ggJEFLYfYjiIX4OVFRQ
X-Proofpoint-ORIG-GUID: IN7z0R5WgFm31ggJEFLYfYjiIX4OVFRQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-02_05,2022-06-02_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Changes v1 => v2:
1. Fix build errors for different config. (kernel test robot)

Kernel Live Patch (livepatch, or klp) and bpf trampoline are important
features for modern systems. This set allows the two to work on the same
kernel function as the same time.

live patch uses ftrace with IPMODIFY, while bpf trampoline use direct
ftrace. Existing policy does not allow the two to attach to the same kernel
function. This is changed by fine tuning ftrace IPMODIFY policy, and allows
one non-DIRECT IPMODIFY ftrace_ops and one non-IPMODIFY DIRECT ftrace_ops
on the same kernel function at the same time. Please see 3/5 for more
details on this.

Note that, one of the constraint here is to let bpf trampoline use direct
call when it is not working on the same function as live patch. This is
achieved by allowing ftrace code to ask bpf trampoline to make changes.

Jiri Olsa (1):
  bpf, x64: Allow to use caller address from stack

Song Liu (4):
  ftrace: allow customized flags for ftrace_direct_multi ftrace_ops
  ftrace: add modify_ftrace_direct_multi_nolock
  ftrace: introduce FTRACE_OPS_FL_SHARE_IPMODIFY
  bpf: trampoline: support FTRACE_OPS_FL_SHARE_IPMODIFY

 arch/x86/net/bpf_jit_comp.c |  13 +-
 include/linux/bpf.h         |   8 ++
 include/linux/ftrace.h      |  79 +++++++++++
 kernel/bpf/trampoline.c     | 109 +++++++++++++--
 kernel/trace/ftrace.c       | 269 +++++++++++++++++++++++++++++++-----
 5 files changed, 424 insertions(+), 54 deletions(-)

--
2.30.2
