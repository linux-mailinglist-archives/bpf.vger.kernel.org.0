Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5160B58F26C
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 20:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbiHJSew convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 10 Aug 2022 14:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbiHJSeh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 14:34:37 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0C08C47A
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 11:34:33 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AGuS1A003179
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 11:34:32 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hvdb6asup-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 11:34:32 -0700
Received: from twshared16308.14.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 10 Aug 2022 11:34:31 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A742B1D76C87D; Wed, 10 Aug 2022 11:34:26 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] libbpf: preserve errno across pr_warn/pr_info/pr_debug
Date:   Wed, 10 Aug 2022 11:34:25 -0700
Message-ID: <20220810183425.1998735-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: D0zpFhCGFjpa2t_qnDHPb1RPsrMwklba
X-Proofpoint-GUID: D0zpFhCGFjpa2t_qnDHPb1RPsrMwklba
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_12,2022-08-10_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As suggested in [0], make sure that libbpf_print saves and restored
errno and as such guaranteed that no matter what actual print callback
user installs, macros like pr_warn/pr_info/pr_debug are completely
transparent as far as errno goes.

While libbpf code is pretty careful about not clobbering important errno
values accidentally with pr_warn(), it's a trivial change to make sure
that pr_warn can be used anywhere without a risk of clobbering errno.

No functional changes, just future proofing.

  [0] https://github.com/libbpf/libbpf/pull/536

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f7364ea82ac1..917d975bd4c6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -223,13 +223,18 @@ __printf(2, 3)
 void libbpf_print(enum libbpf_print_level level, const char *format, ...)
 {
 	va_list args;
+	int old_errno;
 
 	if (!__libbpf_pr)
 		return;
 
+	old_errno = errno;
+
 	va_start(args, format);
 	__libbpf_pr(level, format, args);
 	va_end(args);
+
+	errno = old_errno;
 }
 
 static void pr_perm_msg(int err)
-- 
2.30.2

