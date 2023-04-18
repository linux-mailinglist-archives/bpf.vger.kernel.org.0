Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52F56E55B4
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 02:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjDRAWK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 17 Apr 2023 20:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjDRAWI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 20:22:08 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675EF4C1C
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:22:05 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HLIMRw014879
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:22:05 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q19hn2qxf-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:22:05 -0700
Received: from twshared13785.14.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 17 Apr 2023 17:22:04 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 595812E4F35A4; Mon, 17 Apr 2023 17:22:02 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 6/6] libbpf: mark bpf_iter_num_{new,next,destroy} as __weak
Date:   Mon, 17 Apr 2023 17:21:48 -0700
Message-ID: <20230418002148.3255690-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418002148.3255690-1-andrii@kernel.org>
References: <20230418002148.3255690-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 65IRy_uGnvvocgsIm8Q4_4BwoZxNIqeE
X-Proofpoint-ORIG-GUID: 65IRy_uGnvvocgsIm8Q4_4BwoZxNIqeE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Mark bpf_iter_num_{new,next,destroy}() kfuncs declared for
bpf_for()/bpf_repeat() macros as __weak to allow users to feature-detect
their presence and guard bpf_for()/bpf_repeat() loops accordingly for
backwards compatibility with old kernels.

Now that libbpf supports kfunc calls poisoning and better reporting of
unresolved (but called) kfuncs, declaring number iterator kfuncs in
bpf_helpers.h won't degrade user experience and won't cause unnecessary
kernel feature dependencies.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 525dec66c129..929a3baca8ef 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -293,9 +293,9 @@ enum libbpf_tristate {
 
 struct bpf_iter_num;
 
-extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end) __ksym;
-extern int *bpf_iter_num_next(struct bpf_iter_num *it) __ksym;
-extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __ksym;
+extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end) __weak __ksym;
+extern int *bpf_iter_num_next(struct bpf_iter_num *it) __weak __ksym;
+extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __weak __ksym;
 
 #ifndef bpf_for_each
 /* bpf_for_each(iter_type, cur_elem, args...) provides generic construct for
-- 
2.34.1

