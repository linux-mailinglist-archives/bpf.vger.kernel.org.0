Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C21351F259
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 03:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiEIBaz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 8 May 2022 21:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbiEIApz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 May 2022 20:45:55 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055346430
        for <bpf@vger.kernel.org>; Sun,  8 May 2022 17:42:03 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 248MkLDa014234
        for <bpf@vger.kernel.org>; Sun, 8 May 2022 17:42:03 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3fxhwws2ba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 08 May 2022 17:42:03 -0700
Received: from twshared0725.22.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 8 May 2022 17:42:02 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4490919A4AC81; Sun,  8 May 2022 17:41:53 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/9] libbpf: make __kptr and __kptr_ref unconditionally use btf_type_tag() attr
Date:   Sun, 8 May 2022 17:41:41 -0700
Message-ID: <20220509004148.1801791-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220509004148.1801791-1-andrii@kernel.org>
References: <20220509004148.1801791-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 5enNK-LVFOoqhQvsgF-S12zXH_OL0e5W
X-Proofpoint-ORIG-GUID: 5enNK-LVFOoqhQvsgF-S12zXH_OL0e5W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-08_09,2022-05-06_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It will be annoying and surprising for users of __kptr and __kptr_ref if
libbpf silently ignores them just because Clang used for compilation
didn't support btf_type_tag(). It's much better to get clear compiler
error than debug BPF verifier failures later on.

Fixes: ef89654f2bc7 ("libbpf: Add kptr type tag macros to bpf_helpers.h")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 5de3eb267125..bbae9a057bc8 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -149,13 +149,8 @@ enum libbpf_tristate {
 
 #define __kconfig __attribute__((section(".kconfig")))
 #define __ksym __attribute__((section(".ksyms")))
-#if __has_attribute(btf_type_tag)
 #define __kptr __attribute__((btf_type_tag("kptr")))
 #define __kptr_ref __attribute__((btf_type_tag("kptr_ref")))
-#else
-#define __kptr
-#define __kptr_ref
-#endif
 
 #ifndef ___bpf_concat
 #define ___bpf_concat(a, b) a ## b
-- 
2.30.2

