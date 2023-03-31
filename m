Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499026D2860
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 20:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjCaS6w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 31 Mar 2023 14:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCaS6v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 14:58:51 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFC523FD0
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 11:58:32 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32VIiUDM022151
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 11:57:31 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pnr3fvscq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 11:57:31 -0700
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 31 Mar 2023 11:57:29 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 170A32C9C17D2; Fri, 31 Mar 2023 11:56:38 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 1/2] veristat: relicense veristat.c as dual GPL-2.0-only or BSD-2-Clause licensed
Date:   Fri, 31 Mar 2023 11:56:36 -0700
Message-ID: <20230331185637.2026519-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Lyyxxy04qYJh-q8SNmV3O7jA1MXZhKf4
X-Proofpoint-ORIG-GUID: Lyyxxy04qYJh-q8SNmV3O7jA1MXZhKf4
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

Dual-license veristat.c to dual GPL-2.0-only or BSD-2-Clause license.
This is needed to mirror it to Github to make it convenient for distro
packagers to package veristat as a separate package.

Veristat grew into a useful tool by itself, and there are already
a bunch of users relying on veristat as generic BPF loading and
verification helper tool. So making it easy to packagers by providing
Github mirror just like we do for bpftool and libbpf is the next step to
get veristat into the hands of users.

Apart from few typo fixes, I'm the sole contributor to veristat.c so
far, so no extra Acks should be needed for relicensing.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 7888c03ba631..612ca52c6fba 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
 #define _GNU_SOURCE
 #include <argp.h>
-- 
2.34.1

