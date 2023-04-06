Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861636DA62B
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 01:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbjDFXme convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 6 Apr 2023 19:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238444AbjDFXmb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 19:42:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14577A5E3
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 16:42:28 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336Kvf01006653
        for <bpf@vger.kernel.org>; Thu, 6 Apr 2023 16:42:27 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3psv2fmu1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 16:42:27 -0700
Received: from twshared52232.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 6 Apr 2023 16:42:26 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 2775C2D5BE244; Thu,  6 Apr 2023 16:42:11 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v4 bpf-next 02/19] bpf: remove minimum size restrictions on verifier log buffer
Date:   Thu, 6 Apr 2023 16:41:48 -0700
Message-ID: <20230406234205.323208-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406234205.323208-1-andrii@kernel.org>
References: <20230406234205.323208-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ffItUGAynRIDGdkxz83EFSnjYxQii-yy
X-Proofpoint-ORIG-GUID: ffItUGAynRIDGdkxz83EFSnjYxQii-yy
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

It's not clear why we have 128 as minimum size, but it makes testing
harder and seems unnecessary, as we carefully handle truncation
scenarios and use proper snprintf variants. So remove this limitation
and just enforce positive length for log buffer.

Acked-by: Lorenz Bauer <lmb@isovalent.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 920061e38d2e..1974891fc324 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -11,7 +11,7 @@
 
 bool bpf_verifier_log_attr_valid(const struct bpf_verifier_log *log)
 {
-	return log->len_total >= 128 && log->len_total <= UINT_MAX >> 2 &&
+	return log->len_total > 0 && log->len_total <= UINT_MAX >> 2 &&
 	       log->level && log->ubuf && !(log->level & ~BPF_LOG_MASK);
 }
 
-- 
2.34.1

