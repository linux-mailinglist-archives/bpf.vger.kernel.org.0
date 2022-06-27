Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3076B55D852
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241071AbiF0VP4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 27 Jun 2022 17:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241067AbiF0VPz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 17:15:55 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620C818381
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:15:54 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RJ1Uva011063
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:15:53 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gwyvyppth-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:15:53 -0700
Received: from twshared34609.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 27 Jun 2022 14:15:51 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 6BD031BAC27E3; Mon, 27 Jun 2022 14:15:50 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 10/15] libbpf: cleanup LIBBPF_DEPRECATED_SINCE supporting macros for v0.x
Date:   Mon, 27 Jun 2022 14:15:22 -0700
Message-ID: <20220627211527.2245459-11-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220627211527.2245459-1-andrii@kernel.org>
References: <20220627211527.2245459-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GbgfclEoloRx_zHcEx1t933lupT8Ai93
X-Proofpoint-GUID: GbgfclEoloRx_zHcEx1t933lupT8Ai93
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Keep the LIBBPF_DEPRECATED_SINCE macro "framework" for future
deprecations, but clean up 0.x related helper macros.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf_common.h | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.h
index 000e37798ff2..9a7937f339df 100644
--- a/tools/lib/bpf/libbpf_common.h
+++ b/tools/lib/bpf/libbpf_common.h
@@ -30,20 +30,10 @@
 /* Add checks for other versions below when planning deprecation of API symbols
  * with the LIBBPF_DEPRECATED_SINCE macro.
  */
-#if __LIBBPF_CURRENT_VERSION_GEQ(0, 6)
-#define __LIBBPF_MARK_DEPRECATED_0_6(X) X
+#if __LIBBPF_CURRENT_VERSION_GEQ(1, 0)
+#define __LIBBPF_MARK_DEPRECATED_1_0(X) X
 #else
-#define __LIBBPF_MARK_DEPRECATED_0_6(X)
-#endif
-#if __LIBBPF_CURRENT_VERSION_GEQ(0, 7)
-#define __LIBBPF_MARK_DEPRECATED_0_7(X) X
-#else
-#define __LIBBPF_MARK_DEPRECATED_0_7(X)
-#endif
-#if __LIBBPF_CURRENT_VERSION_GEQ(0, 8)
-#define __LIBBPF_MARK_DEPRECATED_0_8(X) X
-#else
-#define __LIBBPF_MARK_DEPRECATED_0_8(X)
+#define __LIBBPF_MARK_DEPRECATED_1_0(X)
 #endif
 
 /* This set of internal macros allows to do "function overloading" based on
-- 
2.30.2

