Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607A14F9C4D
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 20:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiDHSQn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 8 Apr 2022 14:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiDHSQl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 14:16:41 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B76E33
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 11:14:37 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 238ELPc2009617
        for <bpf@vger.kernel.org>; Fri, 8 Apr 2022 11:14:37 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fa4pgr34b-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 11:14:37 -0700
Received: from twshared27284.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 8 Apr 2022 11:14:33 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 0622A16F87368; Fri,  8 Apr 2022 11:14:30 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/3] libbpf: use weak hidden modifier for USDT BPF-side API functions
Date:   Fri, 8 Apr 2022 11:14:24 -0700
Message-ID: <20220408181425.2287230-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408181425.2287230-1-andrii@kernel.org>
References: <20220408181425.2287230-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: R9L4fTrj4OhJ19nJ90QfWUNtszilqVwn
X-Proofpoint-ORIG-GUID: R9L4fTrj4OhJ19nJ90QfWUNtszilqVwn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_05,2022-04-08_01,2022-02-23_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use __weak __hidden for bpf_usdt_xxx() APIs instead of much more
confusing `static inline __noinline`. This was previously impossible due
to libbpf erroring out on CO-RE relocations pointing to eliminated weak
subprogs. Now that previous patch fixed this issue, switch back to
__weak __hidden as it's a more direct way of specifying the desired
behavior.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/usdt.bpf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
index 881a2422a8ef..4181fddb3687 100644
--- a/tools/lib/bpf/usdt.bpf.h
+++ b/tools/lib/bpf/usdt.bpf.h
@@ -103,7 +103,7 @@ int __bpf_usdt_spec_id(struct pt_regs *ctx)
 }
 
 /* Return number of USDT arguments defined for currently traced USDT. */
-static inline __noinline
+__weak __hidden
 int bpf_usdt_arg_cnt(struct pt_regs *ctx)
 {
 	struct __bpf_usdt_spec *spec;
@@ -124,7 +124,7 @@ int bpf_usdt_arg_cnt(struct pt_regs *ctx)
  * Returns 0 on success; negative error, otherwise.
  * On error *res is guaranteed to be set to zero.
  */
-static inline __noinline
+__weak __hidden
 int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
 {
 	struct __bpf_usdt_spec *spec;
@@ -204,7 +204,7 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
  * utilizing BPF cookies internally, so user can't use BPF cookie directly
  * for USDT programs and has to use bpf_usdt_cookie() API instead.
  */
-static inline __noinline
+__weak __hidden
 long bpf_usdt_cookie(struct pt_regs *ctx)
 {
 	struct __bpf_usdt_spec *spec;
-- 
2.30.2

