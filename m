Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFD66A8D49
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 00:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjCBXus convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 2 Mar 2023 18:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjCBXur (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 18:50:47 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1EB34007
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 15:50:46 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 322KUx7c013205
        for <bpf@vger.kernel.org>; Thu, 2 Mar 2023 15:50:46 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3p2uad4s0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 15:50:46 -0800
Received: from twshared18553.27.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Mar 2023 15:50:45 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D84DC291B7F01; Thu,  2 Mar 2023 15:50:36 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next 09/17] bpf: move kfunc_call_arg_meta higher in the file
Date:   Thu, 2 Mar 2023 15:50:07 -0800
Message-ID: <20230302235015.2044271-10-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230302235015.2044271-1-andrii@kernel.org>
References: <20230302235015.2044271-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4pIoXRkfUtTlC3cz_DjutidqEUgTWBNw
X-Proofpoint-GUID: 4pIoXRkfUtTlC3cz_DjutidqEUgTWBNw
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

Move struct bpf_kfunc_call_arg_meta higher in the file and put it next
to struct bpf_call_arg_meta, so it can be used from more functions.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 70 +++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0004c9f3737f..a75d909f4a59 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -270,6 +270,41 @@ struct bpf_call_arg_meta {
 	struct btf_field *kptr_field;
 };
 
+struct bpf_kfunc_call_arg_meta {
+	/* In parameters */
+	struct btf *btf;
+	u32 func_id;
+	u32 kfunc_flags;
+	const struct btf_type *func_proto;
+	const char *func_name;
+	/* Out parameters */
+	u32 ref_obj_id;
+	u8 release_regno;
+	bool r0_rdonly;
+	u32 ret_btf_id;
+	u64 r0_size;
+	u32 subprogno;
+	struct {
+		u64 value;
+		bool found;
+	} arg_constant;
+	struct {
+		struct btf *btf;
+		u32 btf_id;
+	} arg_obj_drop;
+	struct {
+		struct btf_field *field;
+	} arg_list_head;
+	struct {
+		struct btf_field *field;
+	} arg_rbtree_root;
+	struct {
+		enum bpf_dynptr_type type;
+		u32 id;
+	} initialized_dynptr;
+	u64 mem_size;
+};
+
 struct btf *btf_vmlinux;
 
 static DEFINE_MUTEX(bpf_verifier_lock);
@@ -8712,41 +8747,6 @@ static void mark_btf_func_reg_size(struct bpf_verifier_env *env, u32 regno,
 	}
 }
 
-struct bpf_kfunc_call_arg_meta {
-	/* In parameters */
-	struct btf *btf;
-	u32 func_id;
-	u32 kfunc_flags;
-	const struct btf_type *func_proto;
-	const char *func_name;
-	/* Out parameters */
-	u32 ref_obj_id;
-	u8 release_regno;
-	bool r0_rdonly;
-	u32 ret_btf_id;
-	u64 r0_size;
-	u32 subprogno;
-	struct {
-		u64 value;
-		bool found;
-	} arg_constant;
-	struct {
-		struct btf *btf;
-		u32 btf_id;
-	} arg_obj_drop;
-	struct {
-		struct btf_field *field;
-	} arg_list_head;
-	struct {
-		struct btf_field *field;
-	} arg_rbtree_root;
-	struct {
-		enum bpf_dynptr_type type;
-		u32 id;
-	} initialized_dynptr;
-	u64 mem_size;
-};
-
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_ACQUIRE;
-- 
2.30.2

