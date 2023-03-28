Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD706CCE52
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 01:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjC1X47 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 28 Mar 2023 19:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjC1X4z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 19:56:55 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AD840C6
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 16:56:34 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SJUKD5026913
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 16:56:29 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pkxwuw9cd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 16:56:29 -0700
Received: from twshared29091.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 28 Mar 2023 16:56:27 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 8D9B12C400368; Tue, 28 Mar 2023 16:56:16 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 2/6] bpf: remove minimum size restrictions on verifier log buffer
Date:   Tue, 28 Mar 2023 16:56:05 -0700
Message-ID: <20230328235610.3159943-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328235610.3159943-1-andrii@kernel.org>
References: <20230328235610.3159943-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: B7EynntQlgJxe19SvwGBjs1P7wy-e2Oh
X-Proofpoint-GUID: B7EynntQlgJxe19SvwGBjs1P7wy-e2Oh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
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

