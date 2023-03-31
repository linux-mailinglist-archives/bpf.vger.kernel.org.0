Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461206D2B43
	for <lists+bpf@lfdr.de>; Sat,  1 Apr 2023 00:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjCaWYS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 31 Mar 2023 18:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjCaWYR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 18:24:17 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E5A1E730
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 15:24:16 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 32VIiq1M007843
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 15:24:15 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3pns0qwrw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 15:24:15 -0700
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 31 Mar 2023 15:24:14 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 84C342CA0A2EA; Fri, 31 Mar 2023 15:24:12 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v3 bpf-next 3/4] veristat: avoid using kernel-internal headers
Date:   Fri, 31 Mar 2023 15:24:04 -0700
Message-ID: <20230331222405.3468634-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230331222405.3468634-1-andrii@kernel.org>
References: <20230331222405.3468634-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 9dJTujK-nfIdAxtT3TQSVLc5b5p-18BN
X-Proofpoint-ORIG-GUID: 9dJTujK-nfIdAxtT3TQSVLc5b5p-18BN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Drop linux/compiler.h include, which seems to be needed for ARRAY_SIZE
macro only. Redefine own version of ARRAY_SIZE instead.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index daac72b76508..e592d05bccb2 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -4,7 +4,6 @@
 #include <argp.h>
 #include <string.h>
 #include <stdlib.h>
-#include <linux/compiler.h>
 #include <sched.h>
 #include <pthread.h>
 #include <dirent.h>
@@ -20,6 +19,10 @@
 #include <gelf.h>
 #include <float.h>
 
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+#endif
+
 enum stat_id {
 	VERDICT,
 	DURATION,
-- 
2.34.1

