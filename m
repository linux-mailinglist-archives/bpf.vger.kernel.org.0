Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18BC59C931
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 21:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbiHVTpX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 15:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238844AbiHVTpV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 15:45:21 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EFA501A9
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 12:45:18 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id g10-20020a63564a000000b0042aa3915494so1767325pgm.18
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 12:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=3YcnZq27nBDcf0q5y83xo1d0J0QorO+58AvnGzlnnGU=;
        b=qvUqhgl7/0qIvwFkf4KwiV8JCbBH7EWS8f562cPsF7Xw6I5uUDyhSbPO22k0G4GE1m
         Nca24FtPYBkFkRD2kodpvAFbn9EBvqZCTzkNUFfJXpg/bWktBJo68JrAex8oQvL9xl3h
         +v9EvoF4iaHBwveNWI6Ac93/Qho+E10N4Z5tMkJDkUC4heq1vigKR2EupQwqcElttaFi
         uv38SImn10SbAvzzYEULFQCuToVfAjDjDkWrngPbuDz2x2dLnitidevnUn0KnLgsGWH5
         POy/SNR2E9R43ooKz4hlKcItApsAMTDFy4FVYw4lFr6cb9/bmCf2EeTd28OHRTzWloif
         tphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=3YcnZq27nBDcf0q5y83xo1d0J0QorO+58AvnGzlnnGU=;
        b=ttv1u3tFLGyp5BkGlQa0UhwmQV2ELPTJihIr3Ilz168vEIQgzh8f5/0zY8nM8j4jVI
         WdIIs5B6lRf+8DJ6qdj5Uys2QFpj+4DTo7jfTOd/y63Oe1sW8J9cJr7mF8R1wDG/FX/T
         6dlesl35u4fI17r4Q/gc8Vh2r2+NzpNd46GbATWSaWabHAtSfo7/jBNMgc4+rcR/eY/Z
         TIcWI3Dax9utCvacXbf1x32D1as05av2M0yYqf6dzEDgaCLPvbEOJMPwaFV1YfNmOQGF
         box8wuYRgTRBN8TtEMHP6BzPJYzcFxmQN0DnWTw0h1yZlpeVaEYP9+bKpylEP1xgH1iI
         H7UQ==
X-Gm-Message-State: ACgBeo0U6ABY53QHYldWDNlVI0T9Nah8JqLFjIteDxUniadUg3+JNaJY
        JrJ+T4Zu+fJO8O/a2W/qg3XiFBgFpaLl2CpR8t06sHky3sdDlvyWgo/cKSbJGXNjX+uuU6t/0RD
        k8f00T244EhrycRFyKJpBqPzGMMDPaPJmTE+7I9nSggZ6K/ep5w==
X-Google-Smtp-Source: AA6agR69c8YEBPtvCD8cQ64Xwn9Tv4CmKN6CVhsrBglGdBWy5krR0eURFZZm0qS4W8JDXijSSHF2Z6g=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:f70d:b0:172:d1d1:9b8c with SMTP id
 h13-20020a170902f70d00b00172d1d19b8cmr12378406plo.129.1661197518371; Mon, 22
 Aug 2022 12:45:18 -0700 (PDT)
Date:   Mon, 22 Aug 2022 12:45:10 -0700
In-Reply-To: <20220822194513.2655481-1-sdf@google.com>
Message-Id: <20220822194513.2655481-3-sdf@google.com>
Mime-Version: 1.0
References: <20220822194513.2655481-1-sdf@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next v4 2/5] bpf: Use cgroup_{common,current}_func_proto
 in more hooks
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The following hooks are per-cgroup hooks but they are not
using cgroup_{common,current}_func_proto, fix it:

* BPF_PROG_TYPE_CGROUP_SKB (cg_skb)
* BPF_PROG_TYPE_CGROUP_SOCK_ADDR (cg_sock_addr)
* BPF_PROG_TYPE_CGROUP_SOCK (cg_sock)
* BPF_PROG_TYPE_LSM+BPF_LSM_CGROUP

Also:

* move common func_proto's into cgroup func_proto handlers
* make sure bpf_{g,s}et_retval are not accessible from recvmsg,
  getpeername and getsockname (return/errno is ignored in these
  places)
* as a side effect, expose get_current_pid_tgid, get_current_comm_proto,
  get_current_ancestor_cgroup_id, get_cgroup_classid to more cgroup
  hooks

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/bpf_lsm.c | 17 +++++-----
 kernel/bpf/cgroup.c  | 42 +++++++++++++++++++++--
 net/core/filter.c    | 80 ++++++++++++++++++--------------------------
 3 files changed, 81 insertions(+), 58 deletions(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index fa71d58b7ded..5a9743001ceb 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -189,6 +189,14 @@ static const struct bpf_func_proto bpf_get_attach_cookie_proto = {
 static const struct bpf_func_proto *
 bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
+	const struct bpf_func_proto *func_proto;
+
+	if (prog->expected_attach_type == BPF_LSM_CGROUP) {
+		func_proto = cgroup_common_func_proto(func_id, prog);
+		if (func_proto)
+			return func_proto;
+	}
+
 	switch (func_id) {
 	case BPF_FUNC_inode_storage_get:
 		return &bpf_inode_storage_get_proto;
@@ -212,15 +220,6 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return prog->aux->sleepable ? &bpf_ima_file_hash_proto : NULL;
 	case BPF_FUNC_get_attach_cookie:
 		return bpf_prog_has_trampoline(prog) ? &bpf_get_attach_cookie_proto : NULL;
-	case BPF_FUNC_get_local_storage:
-		return prog->expected_attach_type == BPF_LSM_CGROUP ?
-			&bpf_get_local_storage_proto : NULL;
-	case BPF_FUNC_set_retval:
-		return prog->expected_attach_type == BPF_LSM_CGROUP ?
-			&bpf_set_retval_proto : NULL;
-	case BPF_FUNC_get_retval:
-		return prog->expected_attach_type == BPF_LSM_CGROUP ?
-			&bpf_get_retval_proto : NULL;
 #ifdef CONFIG_NET
 	case BPF_FUNC_setsockopt:
 		if (prog->expected_attach_type != BPF_LSM_CGROUP)
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 1c8ac13fe208..7561688cf42a 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2479,15 +2479,43 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_local_storage:
 		return &bpf_get_local_storage_proto;
 	case BPF_FUNC_get_retval:
-		return &bpf_get_retval_proto;
+		switch (prog->expected_attach_type) {
+		case BPF_CGROUP_INET_INGRESS:
+		case BPF_CGROUP_INET_EGRESS:
+		case BPF_CGROUP_SOCK_OPS:
+		case BPF_CGROUP_UDP4_RECVMSG:
+		case BPF_CGROUP_UDP6_RECVMSG:
+		case BPF_CGROUP_INET4_GETPEERNAME:
+		case BPF_CGROUP_INET6_GETPEERNAME:
+		case BPF_CGROUP_INET4_GETSOCKNAME:
+		case BPF_CGROUP_INET6_GETSOCKNAME:
+			return NULL;
+		default:
+			return &bpf_get_retval_proto;
+		}
 	case BPF_FUNC_set_retval:
-		return &bpf_set_retval_proto;
+		switch (prog->expected_attach_type) {
+		case BPF_CGROUP_INET_INGRESS:
+		case BPF_CGROUP_INET_EGRESS:
+		case BPF_CGROUP_SOCK_OPS:
+		case BPF_CGROUP_UDP4_RECVMSG:
+		case BPF_CGROUP_UDP6_RECVMSG:
+		case BPF_CGROUP_INET4_GETPEERNAME:
+		case BPF_CGROUP_INET6_GETPEERNAME:
+		case BPF_CGROUP_INET4_GETSOCKNAME:
+		case BPF_CGROUP_INET6_GETSOCKNAME:
+			return NULL;
+		default:
+			return &bpf_set_retval_proto;
+		}
 	default:
 		return NULL;
 	}
 }
 
+const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto __weak;
 const struct bpf_func_proto bpf_get_current_cgroup_id_proto __weak;
+const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto __weak;
 
 /* Common helpers for cgroup hooks with valid process context. */
 const struct bpf_func_proto *
@@ -2496,8 +2524,18 @@ cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	switch (func_id) {
 	case BPF_FUNC_get_current_uid_gid:
 		return &bpf_get_current_uid_gid_proto;
+	case BPF_FUNC_get_current_pid_tgid:
+		return &bpf_get_current_pid_tgid_proto;
+	case BPF_FUNC_get_current_comm:
+		return &bpf_get_current_comm_proto;
 	case BPF_FUNC_get_current_cgroup_id:
 		return &bpf_get_current_cgroup_id_proto;
+	case BPF_FUNC_get_current_ancestor_cgroup_id:
+		return &bpf_get_current_ancestor_cgroup_id_proto;
+#ifdef CONFIG_CGROUP_NET_CLASSID
+	case BPF_FUNC_get_cgroup_classid:
+		return &bpf_get_cgroup_classid_curr_proto;
+#endif
 	default:
 		return NULL;
 	}
diff --git a/net/core/filter.c b/net/core/filter.c
index 1acfaffeaf32..63e25d8ce501 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3009,7 +3009,7 @@ BPF_CALL_0(bpf_get_cgroup_classid_curr)
 	return __task_get_classid(current);
 }
 
-static const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto = {
+const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto = {
 	.func		= bpf_get_cgroup_classid_curr,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
@@ -7581,34 +7581,23 @@ const struct bpf_func_proto bpf_sk_storage_get_cg_sock_proto __weak;
 static const struct bpf_func_proto *
 sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
+	const struct bpf_func_proto *func_proto;
+
+	func_proto = cgroup_common_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
+	func_proto = cgroup_current_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
 	switch (func_id) {
-	/* inet and inet6 sockets are created in a process
-	 * context so there is always a valid uid/gid
-	 */
-	case BPF_FUNC_get_current_uid_gid:
-		return &bpf_get_current_uid_gid_proto;
-	case BPF_FUNC_get_local_storage:
-		return &bpf_get_local_storage_proto;
 	case BPF_FUNC_get_socket_cookie:
 		return &bpf_get_socket_cookie_sock_proto;
 	case BPF_FUNC_get_netns_cookie:
 		return &bpf_get_netns_cookie_sock_proto;
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
-	case BPF_FUNC_get_current_pid_tgid:
-		return &bpf_get_current_pid_tgid_proto;
-	case BPF_FUNC_get_current_comm:
-		return &bpf_get_current_comm_proto;
-#ifdef CONFIG_CGROUPS
-	case BPF_FUNC_get_current_cgroup_id:
-		return &bpf_get_current_cgroup_id_proto;
-	case BPF_FUNC_get_current_ancestor_cgroup_id:
-		return &bpf_get_current_ancestor_cgroup_id_proto;
-#endif
-#ifdef CONFIG_CGROUP_NET_CLASSID
-	case BPF_FUNC_get_cgroup_classid:
-		return &bpf_get_cgroup_classid_curr_proto;
-#endif
 	case BPF_FUNC_sk_storage_get:
 		return &bpf_sk_storage_get_cg_sock_proto;
 	case BPF_FUNC_ktime_get_coarse_ns:
@@ -7621,12 +7610,17 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 static const struct bpf_func_proto *
 sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
+	const struct bpf_func_proto *func_proto;
+
+	func_proto = cgroup_common_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
+	func_proto = cgroup_current_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
 	switch (func_id) {
-	/* inet and inet6 sockets are created in a process
-	 * context so there is always a valid uid/gid
-	 */
-	case BPF_FUNC_get_current_uid_gid:
-		return &bpf_get_current_uid_gid_proto;
 	case BPF_FUNC_bind:
 		switch (prog->expected_attach_type) {
 		case BPF_CGROUP_INET4_CONNECT:
@@ -7639,24 +7633,8 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_socket_cookie_sock_addr_proto;
 	case BPF_FUNC_get_netns_cookie:
 		return &bpf_get_netns_cookie_sock_addr_proto;
-	case BPF_FUNC_get_local_storage:
-		return &bpf_get_local_storage_proto;
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
-	case BPF_FUNC_get_current_pid_tgid:
-		return &bpf_get_current_pid_tgid_proto;
-	case BPF_FUNC_get_current_comm:
-		return &bpf_get_current_comm_proto;
-#ifdef CONFIG_CGROUPS
-	case BPF_FUNC_get_current_cgroup_id:
-		return &bpf_get_current_cgroup_id_proto;
-	case BPF_FUNC_get_current_ancestor_cgroup_id:
-		return &bpf_get_current_ancestor_cgroup_id_proto;
-#endif
-#ifdef CONFIG_CGROUP_NET_CLASSID
-	case BPF_FUNC_get_cgroup_classid:
-		return &bpf_get_cgroup_classid_curr_proto;
-#endif
 #ifdef CONFIG_INET
 	case BPF_FUNC_sk_lookup_tcp:
 		return &bpf_sock_addr_sk_lookup_tcp_proto;
@@ -7737,9 +7715,13 @@ const struct bpf_func_proto bpf_sk_storage_delete_proto __weak;
 static const struct bpf_func_proto *
 cg_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
+	const struct bpf_func_proto *func_proto;
+
+	func_proto = cgroup_common_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
 	switch (func_id) {
-	case BPF_FUNC_get_local_storage:
-		return &bpf_get_local_storage_proto;
 	case BPF_FUNC_sk_fullsock:
 		return &bpf_sk_fullsock_proto;
 	case BPF_FUNC_sk_storage_get:
@@ -7979,6 +7961,12 @@ const struct bpf_func_proto bpf_sock_hash_update_proto __weak;
 static const struct bpf_func_proto *
 sock_ops_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
+	const struct bpf_func_proto *func_proto;
+
+	func_proto = cgroup_common_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
 	switch (func_id) {
 	case BPF_FUNC_setsockopt:
 		return &bpf_sock_ops_setsockopt_proto;
@@ -7992,8 +7980,6 @@ sock_ops_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sock_hash_update_proto;
 	case BPF_FUNC_get_socket_cookie:
 		return &bpf_get_socket_cookie_sock_ops_proto;
-	case BPF_FUNC_get_local_storage:
-		return &bpf_get_local_storage_proto;
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
 	case BPF_FUNC_sk_storage_get:
-- 
2.37.1.595.g718a3a8f04-goog

