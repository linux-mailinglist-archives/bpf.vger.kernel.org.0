Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620CA45CD43
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 20:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244170AbhKXTf7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 24 Nov 2021 14:35:59 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63426 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235882AbhKXTf6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Nov 2021 14:35:58 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO94EpS006522
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 11:32:48 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3chje5uus6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 11:32:48 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 11:32:46 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 8D8D2A81F9FF; Wed, 24 Nov 2021 11:32:41 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 3/4] libbpf: prevent deprecation warnings in xsk.c
Date:   Wed, 24 Nov 2021 11:32:32 -0800
Message-ID: <20211124193233.3115996-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124193233.3115996-1-andrii@kernel.org>
References: <20211124193233.3115996-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 9uGV_KJc5nyuAA_RY66jmoygLwUiHucw
X-Proofpoint-GUID: 9uGV_KJc5nyuAA_RY66jmoygLwUiHucw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_06,2021-11-24_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=654 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

xsk.c is using own APIs that are marked for deprecation internally.
Given xsk.c and xsk.h will be gone in libbpf 1.0, there is no reason to
do public vs internal function split just to avoid deprecation warnings.
So just add a pragma to silence deprecation warnings (until the code is
removed completely).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/xsk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index f1c29074d527..e8d94c6dd3bc 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -35,6 +35,11 @@
 #include "libbpf_internal.h"
 #include "xsk.h"
 
+/* entire xsk.h and xsk.c is going away in libbpf 1.0, so ignore all internal
+ * uses of deprecated APIs
+ */
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+
 #ifndef SOL_XDP
  #define SOL_XDP 283
 #endif
-- 
2.30.2

