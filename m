Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABD5596389
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 22:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbiHPUMW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 16:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiHPUMV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 16:12:21 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E0E7E83A
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 13:12:19 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id q7-20020a63e947000000b004297f1e1f86so2187709pgj.12
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 13:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=xnUgmRI1xyF+WsAZFuy9RXntqIcOD1GU6h/7wDFIWwI=;
        b=Y0KRrRpfhWxJRbRmKJ4Z1hAiMat/5ncYaDGSF5ZnhXwt/ZF9VzIkw4+pGLlhEI66tN
         roXAtFRuIW14XuUrKf63zeCQt0GrDn3YZKO6W46zIFZWsalVYSZJNDOd0Asmr4SeuKQb
         gBA3o9c5a0mlYhmcG9fm20A9QGBZppCPto1bSivmFJaDp40fJpr3X2n34/thsRdJ9evf
         88ZvuVDjdBaEW0pkGum1yvVYBOpJrcBsCXMsUXa9c3AXpLkKHAUWo2LOvqAFIuHXQFh2
         mejZz+0nJqkyasyqBixrqOsskq71X8RSBmFX7AhUblDoY7WNDj2obI/KWmDO45evBVEV
         JOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=xnUgmRI1xyF+WsAZFuy9RXntqIcOD1GU6h/7wDFIWwI=;
        b=tGluADPM3whkrSfptv+eIe+7FMUPW3vamnqtAPnSZmylUz6Pq1XPGhHg65m956ibEy
         vzi0QIBFlorPvFDrEyhmM7bO42r8iSMiY8xhTswN3BxrstauVVwOZEQsvpZTqQ5klEjA
         tSFSt9XN5s3MNGrYE1G2/OFz2SFWdGKJWrYMsW3aoaHl3p+IfZ3c5E2hHTwovNoUJ7k+
         1Fr5wqYlr5eDoinF6pCC+wJS0I+C4+ezwCVP6ygzETKYMtbrl078twBuKiJTwzm6cvaV
         MJkltz5ppULtG0rppqz5oVyWkbgrzVzz95JoMBKMOznFpgC7vnbVFOusRIk5ZUHQWotE
         qv7g==
X-Gm-Message-State: ACgBeo2pltO1u8cg6SxW6t6RcH798voaIjTaTCWm4Cb9QNBVpSXxsm7S
        tIWaWQt1Chs9De5MVzo6b61c4R8T8FM8ykaY69cG5ULgm2IvbW2ErYhkztEFlhblsiDv/bmQIZ3
        7NzUp86lqVCBfCf/yHKH0L3n8UMZvEru+7S+bDlOSdTcUR0hdaA==
X-Google-Smtp-Source: AA6agR6mAAALPo2RM7Rf1ro3NsKvcxexKoqZdbB2j/x4GDoYLTZaLKYnJYasY7GPQ+yrJ15tsqkEZI8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a62:ab01:0:b0:52d:ca30:f362 with SMTP id
 p1-20020a62ab01000000b0052dca30f362mr22420817pff.85.1660680739291; Tue, 16
 Aug 2022 13:12:19 -0700 (PDT)
Date:   Tue, 16 Aug 2022 13:12:13 -0700
In-Reply-To: <20220816201214.2489910-1-sdf@google.com>
Message-Id: <20220816201214.2489910-3-sdf@google.com>
Mime-Version: 1.0
References: <20220816201214.2489910-1-sdf@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next v2 2/3] bpf: Use cgroup_{common,current}_func_proto
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
 kernel/bpf/bpf_lsm.c | 19 ++++++-----
 kernel/bpf/cgroup.c  | 36 ++++++++++++++++++--
 kernel/bpf/helpers.c |  1 +
 net/core/filter.c    | 78 ++++++++++++++++++--------------------------
 4 files changed, 77 insertions(+), 57 deletions(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index fa71d58b7ded..6eba60248e20 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -189,6 +189,16 @@ static const struct bpf_func_proto bpf_get_attach_cookie_proto = {
 static const struct bpf_func_proto *
 bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
+#ifdef CONFIG_CGROUP_BPF
+	const struct bpf_func_proto *func_proto;
+
+	if (prog->expected_attach_type == BPF_LSM_CGROUP) {
+		func_proto = cgroup_common_func_proto(func_id, prog);
+		if (func_proto)
+			return func_proto;
+	}
+#endif
+
 	switch (func_id) {
 	case BPF_FUNC_inode_storage_get:
 		return &bpf_inode_storage_get_proto;
@@ -212,15 +222,6 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
index 8ead5df3fafb..7c73b334244a 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2662,9 +2662,31 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_local_storage:
 		return &bpf_get_local_storage_proto;
 	case BPF_FUNC_get_retval:
-		return &bpf_get_retval_proto;
+		switch (prog->expected_attach_type) {
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
@@ -2677,8 +2699,18 @@ cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e20a4657cb55..45ce7a26a147 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1394,6 +1394,7 @@ const struct bpf_func_proto bpf_probe_read_user_str_proto __weak;
 const struct bpf_func_proto bpf_probe_read_kernel_proto __weak;
 const struct bpf_func_proto bpf_probe_read_kernel_str_proto __weak;
 const struct bpf_func_proto bpf_task_pt_regs_proto __weak;
+const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto __weak;
 
 const struct bpf_func_proto *
 bpf_base_func_proto(enum bpf_func_id func_id)
diff --git a/net/core/filter.c b/net/core/filter.c
index 737bef7ff831..699a10949bc2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7652,34 +7652,23 @@ const struct bpf_func_proto bpf_sk_storage_get_cg_sock_proto __weak;
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
@@ -7692,12 +7681,17 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -7710,24 +7704,8 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -7808,9 +7786,13 @@ const struct bpf_func_proto bpf_sk_storage_delete_proto __weak;
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
@@ -8050,6 +8032,12 @@ const struct bpf_func_proto bpf_sock_hash_update_proto __weak;
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
@@ -8063,8 +8051,6 @@ sock_ops_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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

