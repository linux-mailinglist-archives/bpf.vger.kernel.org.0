Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB1C6F4D6E
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 01:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjEBXJV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 2 May 2023 19:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjEBXJU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 19:09:20 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CF035A8
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 16:09:19 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342JX09b015406
        for <bpf@vger.kernel.org>; Tue, 2 May 2023 16:09:18 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qaxg7p1xe-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 May 2023 16:09:18 -0700
Received: from twshared35445.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 2 May 2023 16:09:15 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5FE492FD4BDA3; Tue,  2 May 2023 16:06:37 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 07/10] bpf: record effective capabilities at BPF prog load time
Date:   Tue, 2 May 2023 16:06:16 -0700
Message-ID: <20230502230619.2592406-8-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230502230619.2592406-1-andrii@kernel.org>
References: <20230502230619.2592406-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: MmMv_DVSAY9NwxSSnbV_G10IwLj_lW_W
X-Proofpoint-ORIG-GUID: MmMv_DVSAY9NwxSSnbV_G10IwLj_lW_W
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

Determine and remember effective capabilities of the process at the
BPF_PROG_LOAD command time. We store those in prog->aux, so we can check
and use them throughout various places (like BPF verifier) that perform
various checks and enforce various extra conditions on BPF program based
on its effective capabilities. Currently we have explicit calls to
bpf_capable(), perfmon_capable() and capable() spread out throughout
code base, but we'll be refactoring this over next few patches to
consistently use prog->aux->{bpf,perfmon}_capable
fields to perform decisions. This ensures we have a consistent set of
restrictions checked and recorded in one consistent place.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h  |  5 +++++
 kernel/bpf/syscall.c | 23 +++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 479657bb113e..44ccfea0f73b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1370,6 +1370,11 @@ struct bpf_prog_aux {
 	u32 ctx_arg_info_size;
 	u32 max_rdonly_access;
 	u32 max_rdwr_access;
+
+	/* effective capabilities that were given to BPF program at load time */
+	bool bpf_capable;
+	bool perfmon_capable;
+
 	struct btf *attach_btf;
 	const struct bpf_ctx_arg_aux *ctx_arg_info;
 	struct mutex dst_mutex; /* protects dst_* pointers below, *after* prog becomes visible */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d960eb476754..839f69d75297 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2568,6 +2568,7 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 
 static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 {
+	bool bpf_cap, net_admin_cap, sys_admin_cap, perfmon_cap;
 	enum bpf_prog_type type = attr->prog_type;
 	struct bpf_prog *prog, *dst_prog = NULL;
 	struct btf *attach_btf = NULL;
@@ -2586,6 +2587,12 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 				 BPF_F_XDP_DEV_BOUND_ONLY))
 		return -EINVAL;
 
+	/* remember set of effective capabilities to be used throughout */
+	bpf_cap = bpf_capable();
+	perfmon_cap = perfmon_capable();
+	net_admin_cap = capable(CAP_NET_ADMIN);
+	sys_admin_cap = capable(CAP_SYS_ADMIN);
+
 	/* Intent here is for unprivileged_bpf_disabled to block key object
 	 * creation commands for unprivileged users; other actions depend
 	 * of fd availability and access to bpffs, so are dependent on
@@ -2594,25 +2601,25 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	 * BPF disabled, capability checks are still carried out for these
 	 * and other operations.
 	 */
-	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
+	if (sysctl_unprivileged_bpf_disabled && !bpf_cap)
 		return -EPERM;
 
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
 	    (attr->prog_flags & BPF_F_ANY_ALIGNMENT) &&
-	    !bpf_capable())
+	    !bpf_cap)
 		return -EPERM;
 
 	if (attr->insn_cnt == 0 ||
-	    attr->insn_cnt > (bpf_capable() ? BPF_COMPLEXITY_LIMIT_INSNS : BPF_MAXINSNS))
+	    attr->insn_cnt > (bpf_cap ? BPF_COMPLEXITY_LIMIT_INSNS : BPF_MAXINSNS))
 		return -E2BIG;
 	if (type != BPF_PROG_TYPE_SOCKET_FILTER &&
 	    type != BPF_PROG_TYPE_CGROUP_SKB &&
-	    !bpf_capable())
+	    !bpf_cap)
 		return -EPERM;
 
-	if (is_net_admin_prog_type(type) && !capable(CAP_NET_ADMIN) && !capable(CAP_SYS_ADMIN))
+	if (is_net_admin_prog_type(type) && !net_admin_cap && !sys_admin_cap)
 		return -EPERM;
-	if (is_perfmon_prog_type(type) && !perfmon_capable())
+	if (is_perfmon_prog_type(type) && !perfmon_cap)
 		return -EPERM;
 
 	/* attach_prog_fd/attach_btf_obj_fd can specify fd of either bpf_prog
@@ -2672,6 +2679,10 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	prog->aux->sleepable = attr->prog_flags & BPF_F_SLEEPABLE;
 	prog->aux->xdp_has_frags = attr->prog_flags & BPF_F_XDP_HAS_FRAGS;
 
+	/* remember effective capabilities prog was given */
+	prog->aux->bpf_capable = bpf_cap;
+	prog->aux->perfmon_capable = perfmon_cap;
+
 	err = security_bpf_prog_alloc(prog->aux);
 	if (err)
 		goto free_prog;
-- 
2.34.1

