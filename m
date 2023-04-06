Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C5E6DA63E
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 01:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjDFXoZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 6 Apr 2023 19:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238845AbjDFXng (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 19:43:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762A8B750
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 16:42:59 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336NYTTp007860
        for <bpf@vger.kernel.org>; Thu, 6 Apr 2023 16:42:59 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3psyun3mwb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 16:42:59 -0700
Received: from twshared7331.15.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 6 Apr 2023 16:42:40 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7DD4E2D5BE330; Thu,  6 Apr 2023 16:42:23 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v4 bpf-next 08/19] bpf: fix missing -EFAULT return on user log buf error in btf_parse()
Date:   Thu, 6 Apr 2023 16:41:54 -0700
Message-ID: <20230406234205.323208-9-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406234205.323208-1-andrii@kernel.org>
References: <20230406234205.323208-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: biOekwW8a0LUDH59D_vKLsYtMAI685pc
X-Proofpoint-ORIG-GUID: biOekwW8a0LUDH59D_vKLsYtMAI685pc
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

btf_parse() is missing -EFAULT error return if log->ubuf was NULL-ed out
due to error while copying data into user-provided buffer. Add it, but
handle a special case of BPF_LOG_KERNEL in which log->ubuf is always NULL.

Acked-by: Lorenz Bauer <lmb@isovalent.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/btf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 20a05b8932db..6372c144a294 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5598,6 +5598,10 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 		err = -ENOSPC;
 		goto errout_meta;
 	}
+	if (log->level && log->level != BPF_LOG_KERNEL && !log->ubuf) {
+		err = -EFAULT;
+		goto errout_meta;
+	}
 
 	btf_verifier_env_free(env);
 	refcount_set(&btf->refcnt, 1);
-- 
2.34.1

