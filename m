Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F114A52C2E2
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 21:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241849AbiERS7y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 18 May 2022 14:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241859AbiERS7w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 14:59:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B653CA5B
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 11:59:48 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IHDaRK021979
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 11:59:48 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g4d8227uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 11:59:48 -0700
Received: from twshared13579.04.prn5.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 18 May 2022 11:59:26 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 79F411A12C551; Wed, 18 May 2022 11:59:20 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/3] libbpf: start 1.0 development cycle
Date:   Wed, 18 May 2022 11:59:14 -0700
Message-ID: <20220518185915.3529475-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220518185915.3529475-1-andrii@kernel.org>
References: <20220518185915.3529475-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 32fTuAElj4XznDPi5Llezf6QRR_Vgr0-
X-Proofpoint-ORIG-GUID: 32fTuAElj4XznDPi5Llezf6QRR_Vgr0-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_06,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Start libbpf 1.0 development cycle by adding LIBBPF_1.0.0 section to
libbpf.map file and marking all current symbols as local. As we remove
all the deprecated APIs we'll populate global list before the final 1.0
release.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.map       | 4 ++++
 tools/lib/bpf/libbpf_version.h | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 6b36f46ab5d8..52973cffc20c 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -459,3 +459,7 @@ LIBBPF_0.8.0 {
 		libbpf_register_prog_handler;
 		libbpf_unregister_prog_handler;
 } LIBBPF_0.7.0;
+
+LIBBPF_1.0.0 {
+	local: *;
+};
diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_version.h
index 61f2039404b6..2fb2f4290080 100644
--- a/tools/lib/bpf/libbpf_version.h
+++ b/tools/lib/bpf/libbpf_version.h
@@ -3,7 +3,7 @@
 #ifndef __LIBBPF_VERSION_H
 #define __LIBBPF_VERSION_H
 
-#define LIBBPF_MAJOR_VERSION 0
-#define LIBBPF_MINOR_VERSION 8
+#define LIBBPF_MAJOR_VERSION 1
+#define LIBBPF_MINOR_VERSION 0
 
 #endif /* __LIBBPF_VERSION_H */
-- 
2.30.2

