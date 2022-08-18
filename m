Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0197C599127
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 01:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242561AbiHRX1h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 19:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242509AbiHRX1g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 19:27:36 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B47D7593
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 16:27:34 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id d1-20020a636801000000b0042225d15472so1375171pgc.13
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 16:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=aQVoez2rWjSYKMtzsRg05bqxy5FMiaOI2cxfv74RJG8=;
        b=Z8DvwDJXUnPyy4Nz18o+sO4GRaOgX3YFw2AISd2uWIppu8cuHcVCJmlItZnpioAxjh
         KjFT7BazS6fZca0KYIkZ+L3IF2Kfu3DqUEi6A94aWmBbKSxvm/1+sVm1c7yePJJRmQ3o
         jDB6wTtxcNK7KLfARVHFmPPmdoZnS8HynMNg4Rlp1QksAHrjlM6/LJSZIa92B8Uksgz7
         d0yu7XKYtMdAMVl0I6nGhLzbQ559GOGkFLFB8FUg4mkwGgwBVJu6DNK5kQO+qMreLD8A
         eMPwGH+CHLiYlO5/vAukkuPMsknY0B0QSf1GVBONcCCo1rtMpKjErPh8ekTG4ZjDhQIC
         WMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=aQVoez2rWjSYKMtzsRg05bqxy5FMiaOI2cxfv74RJG8=;
        b=mkSncijr/xnPZfVaeFW3vbG4Pa6nGxhlnsbjVpionDz28FDfhefHJVA0lv9UGzKbDK
         QRpCXO/CmVAYaI/tJsHTtnrfE5I6I/RVQv2HkmVYXhXPHiVFffn4JEDJSiuyzdB1v1Ei
         3qvFTXszec4sYD6RUPllQNR18Y+Om81lEivx7NJtFn7pa1Ho929EZmRhEO7eP27OFI5n
         oJlYEhWlk79I86QleEkR5F/M0Ptu6NHbbbleF3hD6mmj4cW8ineeecXEYoRBGGMrExUL
         6ByMvI497/y/nBeqyaL4H5JrCMnWfzk+FOLYp644VSSru19Z6uUepJaZzQd1rPH+764w
         GMkQ==
X-Gm-Message-State: ACgBeo1p1plsPnnViL/4g/nvgioun4giGx9mDC2NS2FT4fTMsADvrxRS
        xQ0Bz7b28zEWfsVdFjG5BweyeilSgD21YdWNp424b452JkUyqnJ/qs83l8fuSiQtqbkzPh6Ed+q
        Cz0KZmMdogCA5ubyZhghJMELsk58JMUrWl4JpKuDIr8qfPOfEPA==
X-Google-Smtp-Source: AA6agR7n9aXk60W34hJk72RIUjEJXiSoFwSmAMpiozKUxJFxN8J8YxFwbht++NrbxHI8JHnWsPGzrOk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr145635pje.0.1660865253822; Thu, 18 Aug
 2022 16:27:33 -0700 (PDT)
Date:   Thu, 18 Aug 2022 16:27:26 -0700
In-Reply-To: <20220818232729.2479330-1-sdf@google.com>
Message-Id: <20220818232729.2479330-3-sdf@google.com>
Mime-Version: 1.0
References: <20220818232729.2479330-1-sdf@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next v3 2/5] bpf: Use cgroup_{common,current}_func_proto
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
 kernel/bpf/cgroup.c  | 40 +++++++++++++++++++++--
 kernel/bpf/helpers.c |  1 +
 net/core/filter.c    | 78 ++++++++++++++++++--------------------------
 4 files changed, 81 insertions(+), 57 deletions(-)

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
index 74b5cc692a36..00988312279f 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2533,9 +2533,35 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -2548,8 +2574,18 @@ cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
index 71979d870646..53451ea6721c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1521,6 +1521,7 @@ const struct bpf_func_proto bpf_probe_read_user_str_proto __weak;
 const struct bpf_func_proto bpf_probe_read_kernel_proto __weak;
 const struct bpf_func_proto bpf_probe_read_kernel_str_proto __weak;
 const struct bpf_func_proto bpf_task_pt_regs_proto __weak;
+const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto __weak;
 
 const struct bpf_func_proto *
 bpf_base_func_proto(enum bpf_func_id func_id)
diff --git a/net/core/filter.c b/net/core/filter.c
index df6bae0f98a7..eb8560a7c674 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7655,34 +7655,23 @@ const struct bpf_func_proto bpf_sk_storage_get_cg_sock_proto __weak;
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
@@ -7695,12 +7684,17 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -7713,24 +7707,8 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -7811,9 +7789,13 @@ const struct bpf_func_proto bpf_sk_storage_delete_proto __weak;
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
@@ -8053,6 +8035,12 @@ const struct bpf_func_proto bpf_sock_hash_update_proto __weak;
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
@@ -8066,8 +8054,6 @@ sock_ops_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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

