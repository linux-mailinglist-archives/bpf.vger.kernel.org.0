Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A646CACF6
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 20:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjC0SXv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 27 Mar 2023 14:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjC0SXo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 14:23:44 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573683C15
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:23:29 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RFTk2k006273
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:23:28 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pkdtws9dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:23:28 -0700
Received: from twshared38955.16.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 27 Mar 2023 11:23:27 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 131692C1CAFCB; Mon, 27 Mar 2023 11:23:18 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v3 bpf-next 1/3] libbpf: disassociate section handler on explicit bpf_program__set_type() call
Date:   Mon, 27 Mar 2023 11:20:17 -0700
Message-ID: <20230327182019.1671432-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327182019.1671432-1-andrii@kernel.org>
References: <20230327182019.1671432-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fvGerQ2UaQz6L7QmHIEYQ8agir_GkeJu
X-Proofpoint-GUID: fvGerQ2UaQz6L7QmHIEYQ8agir_GkeJu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
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

Also, fix up bpf_prog_test_load() helper in selftests/bpf, which is
force-setting program type (even if that's completely unnecessary; this
is quite a legacy piece of code), and thus should expect auto-attach to
not work, yet one of the tests explicitly relies on auto-attach for
testing.

Instead, force-set program type only if it differs from the desired one.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c                        | 1 +
 tools/testing/selftests/bpf/testing_helpers.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

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
 
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 6c44153755e6..ecfea13f938b 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -195,7 +195,7 @@ int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
 		goto err_out;
 	}
 
-	if (type != BPF_PROG_TYPE_UNSPEC)
+	if (type != BPF_PROG_TYPE_UNSPEC && bpf_program__type(prog) != type)
 		bpf_program__set_type(prog, type);
 
 	flags = bpf_program__flags(prog) | BPF_F_TEST_RND_HI32;
-- 
2.34.1

