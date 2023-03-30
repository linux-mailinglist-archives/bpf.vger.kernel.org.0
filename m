Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72E56CFA09
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 06:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjC3ESJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 30 Mar 2023 00:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjC3ESI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 00:18:08 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD7F1BD
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 21:18:06 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TKrMuT031604
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 21:18:06 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pmvrhj44f-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 21:18:06 -0700
Received: from twshared52344.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 29 Mar 2023 21:18:04 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 2A4362C676698; Wed, 29 Mar 2023 21:17:53 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 1/8] bpf: ignore verifier log reset in BPF_LOG_KERNEL mode
Date:   Wed, 29 Mar 2023 21:16:35 -0700
Message-ID: <20230330041642.1118787-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330041642.1118787-1-andrii@kernel.org>
References: <20230330041642.1118787-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fevsh6pRtRrCOs14mclenqnV0CNZIIO6
X-Proofpoint-GUID: fevsh6pRtRrCOs14mclenqnV0CNZIIO6
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

Verifier log position reset is meaningless in BPF_LOG_KERNEL mode, so
just exit early in bpf_vlog_reset() if log->level is BPF_LOG_KERNEL.

This avoid meaningless put_user() into NULL log->ubuf.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index beab7c7f52a7..0bcc0c5ce697 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -104,7 +104,7 @@ void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos)
 	char zero = 0;
 	u32 pos;
 
-	if (!bpf_verifier_log_needed(log))
+	if (!bpf_verifier_log_needed(log) || log->level == BPF_LOG_KERNEL)
 		return;
 
 	/* if position to which we reset is beyond current log window,
-- 
2.34.1

