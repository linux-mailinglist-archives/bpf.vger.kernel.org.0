Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925FD5915BF
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 21:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbiHLTCu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Aug 2022 15:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiHLTCu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Aug 2022 15:02:50 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5952658
        for <bpf@vger.kernel.org>; Fri, 12 Aug 2022 12:02:46 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id r13-20020aa7988d000000b0052ed235197bso822217pfl.20
        for <bpf@vger.kernel.org>; Fri, 12 Aug 2022 12:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=eK2sk95Mpfp6OAliRjR3Lsz7oYwFG+lMQbuUSeDpq7U=;
        b=LOCL65iT28hyEDz0J9POZFN1hojzEg4vIWOjOu1dn9RNiJbGTPZyUQpAeVowSRPFSM
         uTuhm0sW8Bwj5Xuo8xZ4qvBZdk13Dbtqi9XVXiX95ESx7Eta2nPmaVr9Co62y6GI6uSw
         HM5q4rJjuIwacB9UkZZrbU9trYAUu9QzW+aG/o2Okl6SMoHN9UFkKqvIKAtCNVMP7r2P
         4rOdEr4vVj71z19o89YZ0ecfqY1CCnVoZRcWTccD8qTXBhV3US8ynE0y/z1D/ccZWYYM
         nTfnaCGjsZpHYAxEUQzI7cfbyLEILdOaDcevMkmGy9E0h4VP+rfxwldQKUjId4ossPeC
         hptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=eK2sk95Mpfp6OAliRjR3Lsz7oYwFG+lMQbuUSeDpq7U=;
        b=btR1Qu2cIQJvLv64bO8zIIbFKey4L/wat16+M14CO0DS7Qt6BocT4nyGSnJ8gWzgKT
         lDZ6PTVh6To+gdLacN46RhQ+cFDQxCqLLw6j9I/qSaIUSoZHDtb3gs5747sL4+cG4qHL
         FOdXwhSG2eg2H/Jjo0wYUMbQ+EzUibpB+DTs/IkJvF3smc4/hD6H8xeB82vfxCEywNcf
         +g37LrHp9MjFyf/k9mt9IkOebrQLaGaDgBs7dABEgOggr2u919yJSUe52cj503fI+bdl
         zgxBfnTV7GiRGW2/VLAyPOnxN5U7UoE/3m9JPScXs1uISKlk0iVAISAeq5tmi3/BvaAF
         sJBQ==
X-Gm-Message-State: ACgBeo3fE5IMSWsq4hYqAzp6eKglW8trNjLEE0UiFnqVw8pOoS7eflHm
        SAY/xdlw8j0HPX+871/gPNZCtcrpcL3ApQGhVOn/o+LjAmduxxJ177P6aLfi7zBz332t8qVl72e
        xLsX02uR2ZMFxvEZoca36NiP3Y4dPtUCjUUuTwhwp30S5bQBklA==
X-Google-Smtp-Source: AA6agR74klTN/OQmdQ76f9TCKL5Boyb/X0ItFPufcoGuvuFhDHXUg5hcDdoik8v3BjjeQVZUmQNfjX0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:3e8b:b0:1f5:8706:18a1 with SMTP id
 rj11-20020a17090b3e8b00b001f5870618a1mr15538426pjb.112.1660330966238; Fri, 12
 Aug 2022 12:02:46 -0700 (PDT)
Date:   Fri, 12 Aug 2022 12:02:40 -0700
In-Reply-To: <20220812190241.3544528-1-sdf@google.com>
Message-Id: <20220812190241.3544528-3-sdf@google.com>
Mime-Version: 1.0
References: <20220812190241.3544528-1-sdf@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next 2/3] bpf: use cgroup_{common,current}_func_proto in
 more hooks
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

Also:

* move common func_proto's into cgroup func_proto handlers
* make sure bpf_{g,s}et_retval are not accessible from recvmsg,
  getpeername and getsockname (return/errno is ignore in these
  places)
* as a side effect, expose get_current_pid_tgid, get_current_comm_proto,
  get_current_ancestor_cgroup_id, get_cgroup_classid to more cgroup
  hooks

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/helpers.c | 36 ++++++++++++++++++--
 net/core/filter.c    | 78 ++++++++++++++++++--------------------------
 2 files changed, 66 insertions(+), 48 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index de7d2fabb06d..87ce47b13b22 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1764,9 +1764,31 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
 #endif
 	default:
 		return NULL;
@@ -1781,8 +1803,18 @@ cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 #ifdef CONFIG_CGROUPS
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
+#endif
+#ifdef CONFIG_CGROUP_NET_CLASSID
+	case BPF_FUNC_get_cgroup_classid:
+		return &bpf_get_cgroup_classid_curr_proto;
 #endif
 	default:
 		return NULL;
diff --git a/net/core/filter.c b/net/core/filter.c
index 5669248aff25..6731e60621e9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7663,34 +7663,23 @@ const struct bpf_func_proto bpf_sk_storage_get_cg_sock_proto __weak;
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
@@ -7703,12 +7692,17 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -7721,24 +7715,8 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -7819,9 +7797,13 @@ const struct bpf_func_proto bpf_sk_storage_delete_proto __weak;
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
@@ -8061,6 +8043,12 @@ const struct bpf_func_proto bpf_sock_hash_update_proto __weak;
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
@@ -8074,8 +8062,6 @@ sock_ops_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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

