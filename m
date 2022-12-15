Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D6764E10C
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 19:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiLOSiI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 15 Dec 2022 13:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiLOSho (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 13:37:44 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C3449B56
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 10:36:19 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFIJRrq012691
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 10:36:19 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mg8rk852w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 10:36:18 -0800
Received: from twshared18509.43.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 15 Dec 2022 10:36:17 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id B597B237D8774; Thu, 15 Dec 2022 10:36:11 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] libbpf: fix btf_dump's packed struct determination
Date:   Thu, 15 Dec 2022 10:36:05 -0800
Message-ID: <20221215183605.4149488-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: N8OsFIgC4Zi6a_EKEjBlEw0hKvMGFEW5
X-Proofpoint-ORIG-GUID: N8OsFIgC4Zi6a_EKEjBlEw0hKvMGFEW5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_11,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix bug in btf_dump's logic of determining if a given struct type is
packed or not. The notion of "natural alignment" is not needed and is
even harmful in this case, so drop it altogether. The biggest difference
in btf_is_struct_packed() compared to its original implementation is
that we don't really use btf__align_of() to determine overall alignment
of a struct type (because it could be 1 for both packed and non-packed
struct, depending on specifci field definitions), and just use field's
actual alignment to calculate whether any field is requiring packing or
struct's size overall necessitates packing.

Add two simple test cases that demonstrate the difference this change
would make.

Fixes: ea2ce1ba99aa ("libbpf: Fix BTF-to-C converter's padding logic")
Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf_dump.c                      | 33 ++++---------------
 .../bpf/progs/btf_dump_test_case_packing.c    | 19 +++++++++++
 2 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index d6fd93a57f11..580985ee5545 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -830,47 +830,26 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
 	}
 }
 
-static int btf_natural_align_of(const struct btf *btf, __u32 id)
-{
-	const struct btf_type *t = btf__type_by_id(btf, id);
-	int i, align, vlen;
-	const struct btf_member *m;
-
-	if (!btf_is_composite(t))
-		return btf__align_of(btf, id);
-
-	align = 1;
-	m = btf_members(t);
-	vlen = btf_vlen(t);
-	for (i = 0; i < vlen; i++, m++) {
-		align = max(align, btf__align_of(btf, m->type));
-	}
-
-	return align;
-}
-
 static bool btf_is_struct_packed(const struct btf *btf, __u32 id,
 				 const struct btf_type *t)
 {
 	const struct btf_member *m;
-	int align, i, bit_sz;
+	int max_align = 1, align, i, bit_sz;
 	__u16 vlen;
 
-	align = btf_natural_align_of(btf, id);
-	/* size of a non-packed struct has to be a multiple of its alignment */
-	if (align && (t->size % align) != 0)
-		return true;
-
 	m = btf_members(t);
 	vlen = btf_vlen(t);
 	/* all non-bitfield fields have to be naturally aligned */
 	for (i = 0; i < vlen; i++, m++) {
-		align = btf_natural_align_of(btf, m->type);
+		align = btf__align_of(btf, m->type);
 		bit_sz = btf_member_bitfield_size(t, i);
 		if (align && bit_sz == 0 && m->offset % (8 * align) != 0)
 			return true;
+		max_align = max(align, max_align);
 	}
-
+	/* size of a non-packed struct has to be a multiple of its alignment */
+	if (t->size % max_align != 0)
+		return true;
 	/*
 	 * if original struct was marked as packed, but its layout is
 	 * naturally aligned, we'll detect that it's not packed
diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c
index 5c6c62f7ed32..7998f27df7dd 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c
@@ -116,6 +116,23 @@ struct usb_host_endpoint {
 	long: 0;
 };
 
+/* ----- START-EXPECTED-OUTPUT ----- */
+struct nested_packed_struct {
+	int a;
+	char b;
+} __attribute__((packed));
+
+struct outer_nonpacked_struct {
+	short a;
+	struct nested_packed_struct b;
+};
+
+struct outer_packed_struct {
+	short a;
+	struct nested_packed_struct b;
+} __attribute__((packed));
+
+/* ------ END-EXPECTED-OUTPUT ------ */
 
 int f(struct {
 	struct packed_trailing_space _1;
@@ -128,6 +145,8 @@ int f(struct {
 	union jump_code_union _8;
 	struct outer_implicitly_packed_struct _9;
 	struct usb_host_endpoint _10;
+	struct outer_nonpacked_struct _11;
+	struct outer_packed_struct _12;
 } *_)
 {
 	return 0;
-- 
2.30.2

