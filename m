Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DE3567A56
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 00:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiGEWt6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 5 Jul 2022 18:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiGEWtn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jul 2022 18:49:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E7A1D0C0
        for <bpf@vger.kernel.org>; Tue,  5 Jul 2022 15:48:35 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265JHSmU006821
        for <bpf@vger.kernel.org>; Tue, 5 Jul 2022 15:48:35 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h4uaqs9jx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 05 Jul 2022 15:48:35 -0700
Received: from twshared13579.04.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 5 Jul 2022 15:48:33 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 55D831BF1EBF7; Tue,  5 Jul 2022 15:48:27 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/3] selftests/bpf: fix bogus uninitialized variable warning
Date:   Tue, 5 Jul 2022 15:48:16 -0700
Message-ID: <20220705224818.4026623-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220705224818.4026623-1-andrii@kernel.org>
References: <20220705224818.4026623-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: bEdpgYunCbG3AbeXG8wifS8uSCbiztYb
X-Proofpoint-GUID: bEdpgYunCbG3AbeXG8wifS8uSCbiztYb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-05_18,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When compiling selftests/bpf in optimized mode (-O2), GCC erroneously
complains about uninitialized token variable:

  In file included from network_helpers.c:22:
  network_helpers.c: In function ‘open_netns’:
  test_progs.h:355:22: error: ‘token’ may be used uninitialized [-Werror=maybe-uninitialized]
    355 |         int ___err = libbpf_get_error(___res);                          \
        |                      ^~~~~~~~~~~~~~~~~~~~~~~~
  network_helpers.c:440:14: note: in expansion of macro ‘ASSERT_OK_PTR’
    440 |         if (!ASSERT_OK_PTR(token, "malloc token"))
        |              ^~~~~~~~~~~~~
  In file included from /data/users/andriin/linux/tools/testing/selftests/bpf/tools/include/bpf/libbpf.h:21,
                   from bpf_util.h:9,
                   from network_helpers.c:20:
  /data/users/andriin/linux/tools/testing/selftests/bpf/tools/include/bpf/libbpf_legacy.h:113:17: note: by argument 1 of type ‘const void *’ to ‘libbpf_get_error’ declared here
    113 | LIBBPF_API long libbpf_get_error(const void *ptr);
        |                 ^~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors
  make: *** [Makefile:522: /data/users/andriin/linux/tools/testing/selftests/bpf/network_helpers.o] Error 1

This is completely bogus becuase libbpf_get_error() doesn't dereference
pointer, but the only easy way to silence this is to allocate initialized
memory with calloc().

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/network_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 59cf81ec55af..bec15558fd93 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -436,7 +436,7 @@ struct nstoken *open_netns(const char *name)
 	int err;
 	struct nstoken *token;
 
-	token = malloc(sizeof(struct nstoken));
+	token = calloc(1, sizeof(struct nstoken));
 	if (!ASSERT_OK_PTR(token, "malloc token"))
 		return NULL;
 
-- 
2.30.2

