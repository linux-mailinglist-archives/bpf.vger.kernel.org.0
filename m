Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418116CADF6
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 20:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjC0SwW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 27 Mar 2023 14:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjC0SwT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 14:52:19 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A141722
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:52:16 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RC0ZES025557
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:52:16 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3phxg33a5s-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:52:15 -0700
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 27 Mar 2023 11:52:12 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5B72B2C1D3DBA; Mon, 27 Mar 2023 11:52:05 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v4 bpf-next 1/3] libbpf: disassociate section handler on explicit bpf_program__set_type() call
Date:   Mon, 27 Mar 2023 11:52:00 -0700
Message-ID: <20230327185202.1929145-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327185202.1929145-1-andrii@kernel.org>
References: <20230327185202.1929145-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: A2grp6dK2DtIsK5j050wRElGCRlTi9vE
X-Proofpoint-ORIG-GUID: A2grp6dK2DtIsK5j050wRElGCRlTi9vE
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
index 15737d7b5a28..49cd304ae3bc 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8468,6 +8468,7 @@ int bpf_program__set_type(struct bpf_program *prog, enum bpf_prog_type type)
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

