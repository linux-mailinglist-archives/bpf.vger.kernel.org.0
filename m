Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA0D6DA63D
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 01:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbjDFXn0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 6 Apr 2023 19:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbjDFXms (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 19:42:48 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FD2A27D
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 16:42:35 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336MWDnG013503
        for <bpf@vger.kernel.org>; Thu, 6 Apr 2023 16:42:34 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pt6y20aay-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 16:42:34 -0700
Received: from twshared38955.16.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 6 Apr 2023 16:42:30 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7171D2D5BE2F0; Thu,  6 Apr 2023 16:42:21 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v4 bpf-next 07/19] bpf: ignore verifier log reset in BPF_LOG_KERNEL mode
Date:   Thu, 6 Apr 2023 16:41:53 -0700
Message-ID: <20230406234205.323208-8-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406234205.323208-1-andrii@kernel.org>
References: <20230406234205.323208-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bu7P12pUSxWAWzY2nSDwSSyMT_4P4DDM
X-Proofpoint-GUID: bu7P12pUSxWAWzY2nSDwSSyMT_4P4DDM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_13,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
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

Acked-by: Lorenz Bauer <lmb@isovalent.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 92b1c8ad6601..d99a50f07187 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -106,7 +106,7 @@ void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos)
 	if (WARN_ON_ONCE(new_pos > log->end_pos))
 		return;
 
-	if (!bpf_verifier_log_needed(log))
+	if (!bpf_verifier_log_needed(log) || log->level == BPF_LOG_KERNEL)
 		return;
 
 	/* if position to which we reset is beyond current log window,
-- 
2.34.1

