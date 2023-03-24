Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B97A6C8870
	for <lists+bpf@lfdr.de>; Fri, 24 Mar 2023 23:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjCXWev convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 24 Mar 2023 18:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjCXWej (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 18:34:39 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E0B1F4A7
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 15:34:18 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OGCk7W022866
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 15:33:30 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pgxmpxv3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 15:33:30 -0700
Received: from twshared38955.16.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 24 Mar 2023 15:33:29 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 6F1982BC804EA; Fri, 24 Mar 2023 15:33:17 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 1/3] libbpf: disassociate section handler on explicit bpf_program__set_type() call
Date:   Fri, 24 Mar 2023 15:33:11 -0700
Message-ID: <20230324223314.3294345-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324223314.3294345-1-andrii@kernel.org>
References: <20230324223314.3294345-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 957a3FMNAWLrxY-VN1LgVJWFvf6jDiPo
X-Proofpoint-ORIG-GUID: 957a3FMNAWLrxY-VN1LgVJWFvf6jDiPo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If user explicitly overrides programs's type with
bpf_program__set_type() API call, we need to disassociate whatever
SEC_DEF handler libbpf determined initially based on program's SEC()
definition, as it's not goind to be valid anymore and could lead to
crashes and/or confusing failures.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f6a071db5c6e..a34ebb6b8508 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8465,6 +8465,7 @@ int bpf_program__set_type(struct bpf_program *prog, enum bpf_prog_type type)
 		return libbpf_err(-EBUSY);
 
 	prog->type = type;
+	prog->sec_def = NULL;
 	return 0;
 }
 
-- 
2.34.1

