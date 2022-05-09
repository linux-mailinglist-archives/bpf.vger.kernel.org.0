Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4573B51F260
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 03:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbiEIBbH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 8 May 2022 21:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbiEIApz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 May 2022 20:45:55 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4085B6573
        for <bpf@vger.kernel.org>; Sun,  8 May 2022 17:42:04 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 248NkWrg011571
        for <bpf@vger.kernel.org>; Sun, 8 May 2022 17:42:03 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fwpgw5pm3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 08 May 2022 17:42:03 -0700
Received: from twshared0725.22.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 8 May 2022 17:42:02 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 6364C19A4ACD1; Sun,  8 May 2022 17:41:57 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 4/9] selftests/bpf: use both syntaxes for field-based CO-RE helpers
Date:   Sun, 8 May 2022 17:41:43 -0700
Message-ID: <20220509004148.1801791-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220509004148.1801791-1-andrii@kernel.org>
References: <20220509004148.1801791-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: uV4kIRDNfTdg5ctRcqUWmjYsjDbyZltw
X-Proofpoint-GUID: uV4kIRDNfTdg5ctRcqUWmjYsjDbyZltw
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

Excercise both supported forms of bpf_core_field_exists() and
bpf_core_field_size() helpers: variable-based field reference and
type/field name-based one.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/progs/test_core_reloc_existence.c   | 11 +++++------
 .../selftests/bpf/progs/test_core_reloc_size.c        |  8 ++++----
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_existence.c b/tools/testing/selftests/bpf/progs/test_core_reloc_existence.c
index 7e45e2bdf6cd..5b8a75097ea3 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_existence.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_existence.c
@@ -45,35 +45,34 @@ int test_core_existence(void *ctx)
 	struct core_reloc_existence_output *out = (void *)&data.out;
 
 	out->a_exists = bpf_core_field_exists(in->a);
-	if (bpf_core_field_exists(in->a))
+	if (bpf_core_field_exists(struct core_reloc_existence, a))
 		out->a_value = BPF_CORE_READ(in, a);
 	else
 		out->a_value = 0xff000001u;
 
 	out->b_exists = bpf_core_field_exists(in->b);
-	if (bpf_core_field_exists(in->b))
+	if (bpf_core_field_exists(struct core_reloc_existence, b))
 		out->b_value = BPF_CORE_READ(in, b);
 	else
 		out->b_value = 0xff000002u;
 
 	out->c_exists = bpf_core_field_exists(in->c);
-	if (bpf_core_field_exists(in->c))
+	if (bpf_core_field_exists(struct core_reloc_existence, c))
 		out->c_value = BPF_CORE_READ(in, c);
 	else
 		out->c_value = 0xff000003u;
 
 	out->arr_exists = bpf_core_field_exists(in->arr);
-	if (bpf_core_field_exists(in->arr))
+	if (bpf_core_field_exists(struct core_reloc_existence, arr))
 		out->arr_value = BPF_CORE_READ(in, arr[0]);
 	else
 		out->arr_value = 0xff000004u;
 
 	out->s_exists = bpf_core_field_exists(in->s);
-	if (bpf_core_field_exists(in->s))
+	if (bpf_core_field_exists(struct core_reloc_existence, s))
 		out->s_value = BPF_CORE_READ(in, s.x);
 	else
 		out->s_value = 0xff000005u;
 
 	return 0;
 }
-
diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_size.c b/tools/testing/selftests/bpf/progs/test_core_reloc_size.c
index 7b2d576aeea1..6766addd2583 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_size.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_size.c
@@ -44,10 +44,10 @@ int test_core_size(void *ctx)
 	out->struct_sz = bpf_core_field_size(in->struct_field);
 	out->union_sz = bpf_core_field_size(in->union_field);
 	out->arr_sz = bpf_core_field_size(in->arr_field);
-	out->arr_elem_sz = bpf_core_field_size(in->arr_field[0]);
-	out->ptr_sz = bpf_core_field_size(in->ptr_field);
-	out->enum_sz = bpf_core_field_size(in->enum_field);
-	out->float_sz = bpf_core_field_size(in->float_field);
+	out->arr_elem_sz = bpf_core_field_size(struct core_reloc_size, arr_field[0]);
+	out->ptr_sz = bpf_core_field_size(struct core_reloc_size, ptr_field);
+	out->enum_sz = bpf_core_field_size(struct core_reloc_size, enum_field);
+	out->float_sz = bpf_core_field_size(struct core_reloc_size, float_field);
 
 	return 0;
 }
-- 
2.30.2

