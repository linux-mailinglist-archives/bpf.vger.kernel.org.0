Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2EB5A3272
	for <lists+bpf@lfdr.de>; Sat, 27 Aug 2022 01:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345467AbiHZXPt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 26 Aug 2022 19:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiHZXPq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 19:15:46 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DDBD51C2
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 16:15:44 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QIP8Ii017895
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 16:15:44 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j6g8e09n7-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 16:15:43 -0700
Received: from twshared13579.04.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 26 Aug 2022 16:15:42 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 1AB851E283E38; Fri, 26 Aug 2022 16:15:35 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/3] selftests/bpf: fix test_verif_scale{1,3} SEC() annotations
Date:   Fri, 26 Aug 2022 16:15:29 -0700
Message-ID: <20220826231531.1031943-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220826231531.1031943-1-andrii@kernel.org>
References: <20220826231531.1031943-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: whIr4lTdJyloomaDxD0VyGiIdN9GDU0d
X-Proofpoint-ORIG-GUID: whIr4lTdJyloomaDxD0VyGiIdN9GDU0d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_12,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use proper SEC("tc") for test_verif_scale{1,3} programs. It's not
a problem for selftests right now because we manually set type
programmatically, but not having correct SEC() definitions makes it
harded to generically load BPF object files.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_verif_scale1.c | 2 +-
 tools/testing/selftests/bpf/progs/test_verif_scale3.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_verif_scale1.c b/tools/testing/selftests/bpf/progs/test_verif_scale1.c
index d38153dab3dd..ac6135d9374c 100644
--- a/tools/testing/selftests/bpf/progs/test_verif_scale1.c
+++ b/tools/testing/selftests/bpf/progs/test_verif_scale1.c
@@ -5,7 +5,7 @@
 #define ATTR __attribute__((noinline))
 #include "test_jhash.h"
 
-SEC("scale90_noinline")
+SEC("tc")
 int balancer_ingress(struct __sk_buff *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
diff --git a/tools/testing/selftests/bpf/progs/test_verif_scale3.c b/tools/testing/selftests/bpf/progs/test_verif_scale3.c
index 9beb5bf80373..ca33a9b711c4 100644
--- a/tools/testing/selftests/bpf/progs/test_verif_scale3.c
+++ b/tools/testing/selftests/bpf/progs/test_verif_scale3.c
@@ -5,7 +5,7 @@
 #define ATTR __attribute__((noinline))
 #include "test_jhash.h"
 
-SEC("scale90_noinline32")
+SEC("tc")
 int balancer_ingress(struct __sk_buff *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
-- 
2.30.2

