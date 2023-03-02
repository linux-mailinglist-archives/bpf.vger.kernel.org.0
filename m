Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296246A8D4A
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 00:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjCBXus convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 2 Mar 2023 18:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjCBXur (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 18:50:47 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2202931E1A
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 15:50:47 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322N7Bgb022501
        for <bpf@vger.kernel.org>; Thu, 2 Mar 2023 15:50:47 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p2xg6kncd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 15:50:46 -0800
Received: from twshared37576.17.prn3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Mar 2023 15:50:46 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 178A3291B7F0F; Thu,  2 Mar 2023 15:50:43 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next 12/17] bpf: add support for fixed-size memory pointer returns for kfuncs
Date:   Thu, 2 Mar 2023 15:50:10 -0800
Message-ID: <20230302235015.2044271-13-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230302235015.2044271-1-andrii@kernel.org>
References: <20230302235015.2044271-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: exlutigjBeive7D-cVZw-zCgCvz_bbaW
X-Proofpoint-ORIG-GUID: exlutigjBeive7D-cVZw-zCgCvz_bbaW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Support direct fixed-size (and for now, read-only) memory access when
kfunc's return type is a pointer to non-struct type. Calculate type size
and let BPF program access that many bytes directly. This is crucial for
numbers iterator.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 641a36204493..0ff9dd9170ef 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10241,6 +10241,14 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				return -EFAULT;
 			}
 		} else if (!__btf_type_is_struct(ptr_type)) {
+			if (!meta.r0_size) {
+				__u32 sz;
+
+				if (!IS_ERR(btf_resolve_size(desc_btf, ptr_type, &sz))) {
+					meta.r0_size = sz;
+					meta.r0_rdonly = true;
+				}
+			}
 			if (!meta.r0_size) {
 				ptr_type_name = btf_name_by_offset(desc_btf,
 								   ptr_type->name_off);
-- 
2.30.2

