Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58D450957E
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 05:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiDUDmu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 20 Apr 2022 23:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383980AbiDUDml (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 23:42:41 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C3810B2
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 20:39:53 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23KILRkA022566
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 20:39:52 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fjhgxwxv6-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 20:39:52 -0700
Received: from twshared13315.14.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 20:39:51 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D0E7B186F53CE; Wed, 20 Apr 2022 20:39:48 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next 1/3] bpf: allow attach TRACING programs through LINK_CREATE command
Date:   Wed, 20 Apr 2022 20:39:43 -0700
Message-ID: <20220421033945.3602803-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220421033945.3602803-1-andrii@kernel.org>
References: <20220421033945.3602803-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: U-focOPKnMVgslUL2w4ygJu66xK04EbK
X-Proofpoint-GUID: U-focOPKnMVgslUL2w4ygJu66xK04EbK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_06,2022-04-20_01,2022-02-23_01
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow attaching BTF-aware TRACING programs, previously attachable only
through BPF_RAW_TRACEPOINT_OPEN command, through LINK_CREATE command:
  - BTF-aware raw tracepoints (tp_btf in libbpf lingo);
  - fentry/fexit/fmod_ret programs;
  - BPF LSM programs.

This change converges all bpf_link-based attachments under LINK_CREATE
command allowing to further extend the API with features like BPF cookie
under "multiplexed" link_create section of bpf_attr.

Non-BTF-aware raw tracepoints are left under BPF_RAW_TRACEPOINT_OPEN,
but there is nothing preventing opening them up to LINK_CREATE as well.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 110 ++++++++++++++++++++++---------------------
 1 file changed, 56 insertions(+), 54 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e9621cfa09f2..e9e3e49c0eb7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3030,66 +3030,45 @@ static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *pro
 }
 #endif /* CONFIG_PERF_EVENTS */
 
-#define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.prog_fd
-
-static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
+static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
+				  const char __user *user_tp_name)
 {
 	struct bpf_link_primer link_primer;
 	struct bpf_raw_tp_link *link;
 	struct bpf_raw_event_map *btp;
-	struct bpf_prog *prog;
 	const char *tp_name;
 	char buf[128];
 	int err;
 
-	if (CHECK_ATTR(BPF_RAW_TRACEPOINT_OPEN))
-		return -EINVAL;
-
-	prog = bpf_prog_get(attr->raw_tracepoint.prog_fd);
-	if (IS_ERR(prog))
-		return PTR_ERR(prog);
-
 	switch (prog->type) {
 	case BPF_PROG_TYPE_TRACING:
 	case BPF_PROG_TYPE_EXT:
 	case BPF_PROG_TYPE_LSM:
-		if (attr->raw_tracepoint.name) {
+		if (user_tp_name)
 			/* The attach point for this category of programs
 			 * should be specified via btf_id during program load.
 			 */
-			err = -EINVAL;
-			goto out_put_prog;
-		}
+			return -EINVAL;
 		if (prog->type == BPF_PROG_TYPE_TRACING &&
 		    prog->expected_attach_type == BPF_TRACE_RAW_TP) {
 			tp_name = prog->aux->attach_func_name;
 			break;
 		}
-		err = bpf_tracing_prog_attach(prog, 0, 0);
-		if (err >= 0)
-			return err;
-		goto out_put_prog;
+		return bpf_tracing_prog_attach(prog, 0, 0);
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
-		if (strncpy_from_user(buf,
-				      u64_to_user_ptr(attr->raw_tracepoint.name),
-				      sizeof(buf) - 1) < 0) {
-			err = -EFAULT;
-			goto out_put_prog;
-		}
+		if (strncpy_from_user(buf, user_tp_name, sizeof(buf) - 1) < 0)
+			return -EFAULT;
 		buf[sizeof(buf) - 1] = 0;
 		tp_name = buf;
 		break;
 	default:
-		err = -EINVAL;
-		goto out_put_prog;
+		return -EINVAL;
 	}
 
 	btp = bpf_get_raw_tracepoint(tp_name);
-	if (!btp) {
-		err = -ENOENT;
-		goto out_put_prog;
-	}
+	if (!btp)
+		return -ENOENT;
 
 	link = kzalloc(sizeof(*link), GFP_USER);
 	if (!link) {
@@ -3116,11 +3095,29 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 
 out_put_btp:
 	bpf_put_raw_tracepoint(btp);
-out_put_prog:
-	bpf_prog_put(prog);
 	return err;
 }
 
+#define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.prog_fd
+
+static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
+{
+	struct bpf_prog *prog;
+	int fd;
+
+	if (CHECK_ATTR(BPF_RAW_TRACEPOINT_OPEN))
+		return -EINVAL;
+
+	prog = bpf_prog_get(attr->raw_tracepoint.prog_fd);
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
+
+	fd = bpf_raw_tp_link_attach(prog, u64_to_user_ptr(attr->raw_tracepoint.name));
+	if (fd < 0)
+		bpf_prog_put(prog);
+	return fd;
+}
+
 static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 					     enum bpf_attach_type attach_type)
 {
@@ -3189,7 +3186,13 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_CGROUP_SETSOCKOPT:
 		return BPF_PROG_TYPE_CGROUP_SOCKOPT;
 	case BPF_TRACE_ITER:
+	case BPF_TRACE_RAW_TP:
+	case BPF_TRACE_FENTRY:
+	case BPF_TRACE_FEXIT:
+	case BPF_MODIFY_RETURN:
 		return BPF_PROG_TYPE_TRACING;
+	case BPF_LSM_MAC:
+		return BPF_PROG_TYPE_LSM;
 	case BPF_SK_LOOKUP:
 		return BPF_PROG_TYPE_SK_LOOKUP;
 	case BPF_XDP:
@@ -4246,21 +4249,6 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 	return err;
 }
 
-static int tracing_bpf_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
-				   struct bpf_prog *prog)
-{
-	if (attr->link_create.attach_type != prog->expected_attach_type)
-		return -EINVAL;
-
-	if (prog->expected_attach_type == BPF_TRACE_ITER)
-		return bpf_iter_link_attach(attr, uattr, prog);
-	else if (prog->type == BPF_PROG_TYPE_EXT)
-		return bpf_tracing_prog_attach(prog,
-					       attr->link_create.target_fd,
-					       attr->link_create.target_btf_id);
-	return -EINVAL;
-}
-
 #define BPF_LINK_CREATE_LAST_FIELD link_create.kprobe_multi.cookies
 static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 {
@@ -4282,15 +4270,13 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 
 	switch (prog->type) {
 	case BPF_PROG_TYPE_EXT:
-		ret = tracing_bpf_link_attach(attr, uattr, prog);
-		goto out;
+		break;
 	case BPF_PROG_TYPE_PERF_EVENT:
 	case BPF_PROG_TYPE_TRACEPOINT:
 		if (attr->link_create.attach_type != BPF_PERF_EVENT) {
 			ret = -EINVAL;
 			goto out;
 		}
-		ptype = prog->type;
 		break;
 	case BPF_PROG_TYPE_KPROBE:
 		if (attr->link_create.attach_type != BPF_PERF_EVENT &&
@@ -4298,7 +4284,6 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 			ret = -EINVAL;
 			goto out;
 		}
-		ptype = prog->type;
 		break;
 	default:
 		ptype = attach_type_to_prog_type(attr->link_create.attach_type);
@@ -4309,7 +4294,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 		break;
 	}
 
-	switch (ptype) {
+	switch (prog->type) {
 	case BPF_PROG_TYPE_CGROUP_SKB:
 	case BPF_PROG_TYPE_CGROUP_SOCK:
 	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
@@ -4319,8 +4304,25 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
 		ret = cgroup_bpf_link_attach(attr, prog);
 		break;
+	case BPF_PROG_TYPE_EXT:
+		ret = bpf_tracing_prog_attach(prog,
+					      attr->link_create.target_fd,
+					      attr->link_create.target_btf_id);
+		break;
+	case BPF_PROG_TYPE_LSM:
 	case BPF_PROG_TYPE_TRACING:
-		ret = tracing_bpf_link_attach(attr, uattr, prog);
+		if (attr->link_create.attach_type != prog->expected_attach_type) {
+			ret = -EINVAL;
+			goto out;
+		}
+		if (prog->expected_attach_type == BPF_TRACE_RAW_TP)
+			ret = bpf_raw_tp_link_attach(prog, NULL);
+		else if (prog->expected_attach_type == BPF_TRACE_ITER)
+			ret = bpf_iter_link_attach(attr, uattr, prog);
+		else
+			ret = bpf_tracing_prog_attach(prog,
+						      attr->link_create.target_fd,
+						      attr->link_create.target_btf_id);
 		break;
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_SK_LOOKUP:
-- 
2.30.2

