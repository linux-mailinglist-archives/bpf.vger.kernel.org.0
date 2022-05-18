Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027D452C2DD
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 21:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241822AbiERS73 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 18 May 2022 14:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241820AbiERS73 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 14:59:29 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B80718DAD2
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 11:59:27 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24IHDXA1031040
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 11:59:27 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3g4836v7ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 11:59:27 -0700
Received: from twshared0725.22.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 18 May 2022 11:59:25 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 6FBA51A12C541; Wed, 18 May 2022 11:59:18 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/3] libbpf: fix up global symbol counting logic
Date:   Wed, 18 May 2022 11:59:13 -0700
Message-ID: <20220518185915.3529475-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220518185915.3529475-1-andrii@kernel.org>
References: <20220518185915.3529475-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 1MK4Ij8LVtAj1-GWyoP0RS4KZRdDNGr8
X-Proofpoint-ORIG-GUID: 1MK4Ij8LVtAj1-GWyoP0RS4KZRdDNGr8
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

Add the same negative ABS filter that we use in VERSIONED_SYM_COUNT to
filter out ABS symbols like LIBBPF_0.8.0.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 64741c55b8e3..a1265b152027 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -127,7 +127,7 @@ TAGS_PROG := $(if $(shell which etags 2>/dev/null),etags,ctags)
 GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN_SHARED) | \
 			   cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' | \
 			   sed 's/\[.*\]//' | \
-			   awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}' | \
+			   awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}' | \
 			   sort -u | wc -l)
 VERSIONED_SYM_COUNT = $(shell readelf --dyn-syms --wide $(OUTPUT)libbpf.so | \
 			      sed 's/\[.*\]//' | \
-- 
2.30.2

