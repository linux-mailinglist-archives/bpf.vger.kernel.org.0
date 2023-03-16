Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5EB6BD82F
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 19:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjCPSdR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 16 Mar 2023 14:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjCPSdQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 14:33:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83CF7DB6
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 11:33:12 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GI6lRK032576
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 11:33:12 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pbpxspadg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 11:33:12 -0700
Received: from twshared30317.05.prn5.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Mar 2023 11:33:11 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 8D2742AC195B9; Thu, 16 Mar 2023 11:30:25 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 2/6] bpf: remove minimum size restrictions on verifier log buffer
Date:   Thu, 16 Mar 2023 11:30:09 -0700
Message-ID: <20230316183013.2882810-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230316183013.2882810-1-andrii@kernel.org>
References: <20230316183013.2882810-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TxV4aupOZpu-oDcn2nraBxeeODavR_5L
X-Proofpoint-GUID: TxV4aupOZpu-oDcn2nraBxeeODavR_5L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_12,2023-03-16_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's not clear why we have 128 as minimum size, but it makes testing
harder and seems unnecessary, as we carefully handle truncation
scenarios and use proper snprintf variants. So remove this limitation
and just enfore positive length for log buffer.

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

