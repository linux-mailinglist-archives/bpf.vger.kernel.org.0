Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4F76F4D71
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 01:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjEBXJg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 2 May 2023 19:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjEBXJf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 19:09:35 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256FE359C
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 16:09:30 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342JX1Xg031619
        for <bpf@vger.kernel.org>; Tue, 2 May 2023 16:09:29 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qatf9fbmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 May 2023 16:09:29 -0700
Received: from twshared13785.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 2 May 2023 16:09:01 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 517E12FD4BD60; Tue,  2 May 2023 16:06:34 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 06/10] bpf: keep BPF_PROG_LOAD permission checks clear of validations
Date:   Tue, 2 May 2023 16:06:15 -0700
Message-ID: <20230502230619.2592406-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230502230619.2592406-1-andrii@kernel.org>
References: <20230502230619.2592406-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Ucd4NogkVk3Mv5e2v6nRf0t6yGSCcn5R
X-Proofpoint-ORIG-GUID: Ucd4NogkVk3Mv5e2v6nRf0t6yGSCcn5R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_12,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move out flags validation and license checks out of the permission
checks. They were intermingled, which makes subsequent changes harder.
Clean this up: perform straightforward flag validation upfront, and
fetch and check license later, right where we use it. Also consolidate
capabilities check in one block, right after basic attribute sanity
checks.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2e5ca52c45c4..d960eb476754 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2573,18 +2573,6 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	struct btf *attach_btf = NULL;
 	int err;
 	char license[128];
-	bool is_gpl;
-
-	/* Intent here is for unprivileged_bpf_disabled to block key object
-	 * creation commands for unprivileged users; other actions depend
-	 * of fd availability and access to bpffs, so are dependent on
-	 * object creation success.  Capabilities are later verified for
-	 * operations such as load and map create, so even with unprivileged
-	 * BPF disabled, capability checks are still carried out for these
-	 * and other operations.
-	 */
-	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
-		return -EPERM;
 
 	if (CHECK_ATTR(BPF_PROG_LOAD))
 		return -EINVAL;
@@ -2598,21 +2586,22 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 				 BPF_F_XDP_DEV_BOUND_ONLY))
 		return -EINVAL;
 
+	/* Intent here is for unprivileged_bpf_disabled to block key object
+	 * creation commands for unprivileged users; other actions depend
+	 * of fd availability and access to bpffs, so are dependent on
+	 * object creation success.  Capabilities are later verified for
+	 * operations such as load and map create, so even with unprivileged
+	 * BPF disabled, capability checks are still carried out for these
+	 * and other operations.
+	 */
+	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
+		return -EPERM;
+
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
 	    (attr->prog_flags & BPF_F_ANY_ALIGNMENT) &&
 	    !bpf_capable())
 		return -EPERM;
 
-	/* copy eBPF program license from user space */
-	if (strncpy_from_bpfptr(license,
-				make_bpfptr(attr->license, uattr.is_kernel),
-				sizeof(license) - 1) < 0)
-		return -EFAULT;
-	license[sizeof(license) - 1] = 0;
-
-	/* eBPF programs must be GPL compatible to use GPL-ed functions */
-	is_gpl = license_is_gpl_compatible(license);
-
 	if (attr->insn_cnt == 0 ||
 	    attr->insn_cnt > (bpf_capable() ? BPF_COMPLEXITY_LIMIT_INSNS : BPF_MAXINSNS))
 		return -E2BIG;
@@ -2700,7 +2689,16 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	prog->jited = 0;
 
 	atomic64_set(&prog->aux->refcnt, 1);
-	prog->gpl_compatible = is_gpl ? 1 : 0;
+
+	/* copy eBPF program license from user space */
+	if (strncpy_from_bpfptr(license,
+				make_bpfptr(attr->license, uattr.is_kernel),
+				sizeof(license) - 1) < 0)
+		return -EFAULT;
+	license[sizeof(license) - 1] = 0;
+
+	/* eBPF programs must be GPL compatible to use GPL-ed functions */
+	prog->gpl_compatible = license_is_gpl_compatible(license) ? 1 : 0;
 
 	if (bpf_prog_is_dev_bound(prog->aux)) {
 		err = bpf_prog_dev_bound_init(prog, attr);
-- 
2.34.1

