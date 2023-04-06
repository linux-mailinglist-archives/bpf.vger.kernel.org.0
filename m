Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000906DA633
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 01:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238910AbjDFXms convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 6 Apr 2023 19:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237353AbjDFXmc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 19:42:32 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A7593C5
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 16:42:29 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336N4Hva031095
        for <bpf@vger.kernel.org>; Thu, 6 Apr 2023 16:42:29 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pt7e6g5eg-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 16:42:28 -0700
Received: from twshared29091.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 6 Apr 2023 16:42:26 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4C7282D5BE279; Thu,  6 Apr 2023 16:42:15 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v4 bpf-next 04/19] libbpf: don't enforce unnecessary verifier log restrictions on libbpf side
Date:   Thu, 6 Apr 2023 16:41:50 -0700
Message-ID: <20230406234205.323208-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406234205.323208-1-andrii@kernel.org>
References: <20230406234205.323208-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2TGY4Kve2OSV8Esf8Gu1wjUBw5P4qeF1
X-Proofpoint-GUID: 2TGY4Kve2OSV8Esf8Gu1wjUBw5P4qeF1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_13,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This basically prevents any forward compatibility. And we either way
just return -EINVAL, which would otherwise be returned from bpf()
syscall anyways.

Similarly, drop enforcement of non-NULL log_buf when log_level > 0. This
won't be true anymore soon.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 767035900354..f1d04ee14d83 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -290,10 +290,6 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 
 	if (!!log_buf != !!log_size)
 		return libbpf_err(-EINVAL);
-	if (log_level > (4 | 2 | 1))
-		return libbpf_err(-EINVAL);
-	if (log_level && !log_buf)
-		return libbpf_err(-EINVAL);
 
 	func_info_rec_size = OPTS_GET(opts, func_info_rec_size, 0);
 	func_info = OPTS_GET(opts, func_info, NULL);
-- 
2.34.1

