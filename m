Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F386B1AE0
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 06:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjCIFk3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 9 Mar 2023 00:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCIFk1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 00:40:27 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF50E82353
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 21:40:25 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3294F0Rs023492
        for <bpf@vger.kernel.org>; Wed, 8 Mar 2023 21:40:25 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p75at1858-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 21:40:24 -0800
Received: from twshared21709.17.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 8 Mar 2023 21:40:24 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 8D35429AA2054; Wed,  8 Mar 2023 21:40:20 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 2/4] selftests/bpf: add __sink() macro to fake variable consumption
Date:   Wed, 8 Mar 2023 21:40:13 -0800
Message-ID: <20230309054015.4068562-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309054015.4068562-1-andrii@kernel.org>
References: <20230309054015.4068562-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jRRqbSje7VazbCgsB2Lt78_CcSPI-an5
X-Proofpoint-GUID: jRRqbSje7VazbCgsB2Lt78_CcSPI-an5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_02,2023-03-08_03,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add __sink(expr) macro that forces compiler to believe that passed in
expression is both read and written. It used a simple embedded asm for
this. This is useful in a lot of tests where we assign value to some variable
to trigger some action, but later don't read variable, causing compiler
to complain (if corresponding compiler warnings are turned on, which
we'll do in the next patch).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index c95eb603403c..3c03ec8056ce 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -76,6 +76,9 @@
 #define FUNC_REG_ARG_CNT 5
 #endif
 
+/* make it look to compiler like value is read and written */
+#define __sink(expr) asm volatile("" : "+g"(expr))
+
 struct bpf_iter_num;
 
 extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end) __ksym;
-- 
2.34.1

