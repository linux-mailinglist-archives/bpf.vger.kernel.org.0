Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED80F55EB3D
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 19:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiF1Rni (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 13:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbiF1Rna (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 13:43:30 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744F2A45D
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 10:43:27 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id d66-20020a636845000000b0040a88edd9c1so6980694pgc.13
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 10:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oKd8fyQJpNfPVDCb0PJbs4XAB+7b+jUjsf0mKAcfMUA=;
        b=Q3sCHC4KTyOtjTyNHm4T1Sfz7HRVgzZ8z4SYr+d0OjHMxZh5i7H+NV9pJiJJs19d48
         6FbBvwiVuFjLPWZKhhr629vh01QOQRmDLh4GcMhDPhSCV6Au0Y2HUimIH/Q3rbzCOtlX
         +e8ekCp7kU8G8/FLmIgfvjoby/qh2sEQx2kWBZ5SsVyGbiW3c6hpP45EzaPtlnolWHmS
         IsXeHyz5w8AfNF8OZFBnC8HHjDPVPXIvPZFQbUTNgFdxEq1QeZa0dJHVLIclsdoD5ji0
         YuF0L0BZFep07bnf/z3qETjb4H+lRTxkPLQMGnmo27E3br+BslXEFFl1QfWjCzm0TpLy
         Irtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oKd8fyQJpNfPVDCb0PJbs4XAB+7b+jUjsf0mKAcfMUA=;
        b=1KVupAaenIS4Oyaj2eWG15mbDHb6KrkHaZnqJYXnkrlhDNoibEyJRzWvIiJFUfCnvX
         4a0Itd/G+TDRoNIYawhO3C1qYyM2oPigkahExjdhcbMMOMfYUDxSaI0xOkVKgoGuo2tq
         QZnY7sHyRmbIbMxfbUpFW28Ura7CPhLtDV+ajCVwLrUwmz2a5O18q3i9UIkvKsEqclL6
         kqVWZji7f/CyrQKM5Zt+ayHu4HhUFIHHu93KhZYGHf+ZsnFdWuREuv3w+vae+agtseA7
         IYt4sdj7h15qW5U5G+SLKPPAIfXWEtDiI00cSKMNtwyVbKQVaFxdXV2KhQpMg0MaFU0w
         uegA==
X-Gm-Message-State: AJIora+ApEstdFaOojMuoxvdZuZbjRgTkrjFpV43yMPtKhZAPJG/CMUA
        mBjwo9IqDwEpNALIIZOjTJpJaFS0EvmmsxvB9qoxwuXPxvidWNBLzHTg/qnTSzIXyBdgxiHg7E6
        5PSbg3Oqh1vTkIW1rlqF7myHYxgR1+bG3eRuePDMX5Qeny8UadA==
X-Google-Smtp-Source: AGRyM1tvQVmAfCsYHHhVHZG5FgrgSBEt5mwbQaFxh1XhmKkbeM64vJnDQJoxn17GW+FdB5iVx7n9uzM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:1c02:b0:1ed:4bfb:7772 with SMTP id
 oc2-20020a17090b1c0200b001ed4bfb7772mr832160pjb.139.1656438206329; Tue, 28
 Jun 2022 10:43:26 -0700 (PDT)
Date:   Tue, 28 Jun 2022 10:43:09 -0700
In-Reply-To: <20220628174314.1216643-1-sdf@google.com>
Message-Id: <20220628174314.1216643-7-sdf@google.com>
Mime-Version: 1.0
References: <20220628174314.1216643-1-sdf@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH bpf-next v11 06/11] bpf: expose bpf_{g,s}etsockopt to lsm cgroup
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <kafai@fb.com>
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

I don't see how to make it nice without introducing btf id lists
for the hooks where these helpers are allowed. Some LSM hooks
work on the locked sockets, some are triggering early and
don't grab any locks, so have two lists for now:

1. LSM hooks which trigger under socket lock - minority of the hooks,
   but ideal case for us, we can expose existing BTF-based helpers
2. LSM hooks which trigger without socket lock, but they trigger
   early in the socket creation path where it should be safe to
   do setsockopt without any locks
3. The rest are prohibited. I'm thinking that this use-case might
   be a good gateway to sleeping lsm cgroup hooks in the future.
   We can either expose lock/unlock operations (and add tracking
   to the verifier) or have another set of bpf_setsockopt
   wrapper that grab the locks and might sleep.

Reviewed-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf.h  |  2 ++
 kernel/bpf/bpf_lsm.c | 38 ++++++++++++++++++++++++++++
 net/core/filter.c    | 60 ++++++++++++++++++++++++++++++++++++++------
 3 files changed, 93 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5d2afa55c7c3..2b21f2a3452f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2386,6 +2386,8 @@ extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
 extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
 extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
 extern const struct bpf_func_proto bpf_sk_getsockopt_proto;
+extern const struct bpf_func_proto bpf_unlocked_sk_setsockopt_proto;
+extern const struct bpf_func_proto bpf_unlocked_sk_getsockopt_proto;
 extern const struct bpf_func_proto bpf_find_vma_proto;
 extern const struct bpf_func_proto bpf_loop_proto;
 extern const struct bpf_func_proto bpf_copy_from_user_task_proto;
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 83aa431dd52e..d469b7f3deef 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -45,6 +45,24 @@ BTF_ID(func, bpf_lsm_sk_alloc_security)
 BTF_ID(func, bpf_lsm_sk_free_security)
 BTF_SET_END(bpf_lsm_current_hooks)
 
+/* List of LSM hooks that trigger while the socket is properly locked.
+ */
+BTF_SET_START(bpf_lsm_locked_sockopt_hooks)
+BTF_ID(func, bpf_lsm_socket_sock_rcv_skb)
+BTF_ID(func, bpf_lsm_sock_graft)
+BTF_ID(func, bpf_lsm_inet_csk_clone)
+BTF_ID(func, bpf_lsm_inet_conn_established)
+BTF_SET_END(bpf_lsm_locked_sockopt_hooks)
+
+/* List of LSM hooks that trigger while the socket is _not_ locked,
+ * but it's ok to call bpf_{g,s}etsockopt because the socket is still
+ * in the early init phase.
+ */
+BTF_SET_START(bpf_lsm_unlocked_sockopt_hooks)
+BTF_ID(func, bpf_lsm_socket_post_create)
+BTF_ID(func, bpf_lsm_socket_socketpair)
+BTF_SET_END(bpf_lsm_unlocked_sockopt_hooks)
+
 void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
 			     bpf_func_t *bpf_func)
 {
@@ -201,6 +219,26 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_retval:
 		return prog->expected_attach_type == BPF_LSM_CGROUP ?
 			&bpf_get_retval_proto : NULL;
+	case BPF_FUNC_setsockopt:
+		if (prog->expected_attach_type != BPF_LSM_CGROUP)
+			return NULL;
+		if (btf_id_set_contains(&bpf_lsm_locked_sockopt_hooks,
+					prog->aux->attach_btf_id))
+			return &bpf_sk_setsockopt_proto;
+		if (btf_id_set_contains(&bpf_lsm_unlocked_sockopt_hooks,
+					prog->aux->attach_btf_id))
+			return &bpf_unlocked_sk_setsockopt_proto;
+		return NULL;
+	case BPF_FUNC_getsockopt:
+		if (prog->expected_attach_type != BPF_LSM_CGROUP)
+			return NULL;
+		if (btf_id_set_contains(&bpf_lsm_locked_sockopt_hooks,
+					prog->aux->attach_btf_id))
+			return &bpf_sk_getsockopt_proto;
+		if (btf_id_set_contains(&bpf_lsm_unlocked_sockopt_hooks,
+					prog->aux->attach_btf_id))
+			return &bpf_unlocked_sk_getsockopt_proto;
+		return NULL;
 	default:
 		return tracing_prog_func_proto(func_id, prog);
 	}
diff --git a/net/core/filter.c b/net/core/filter.c
index 151aa4756bd6..c6941ab0eb52 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5012,8 +5012,8 @@ static const struct bpf_func_proto bpf_get_socket_uid_proto = {
 	.arg1_type      = ARG_PTR_TO_CTX,
 };
 
-static int _bpf_setsockopt(struct sock *sk, int level, int optname,
-			   char *optval, int optlen)
+static int __bpf_setsockopt(struct sock *sk, int level, int optname,
+			    char *optval, int optlen)
 {
 	char devname[IFNAMSIZ];
 	int val, valbool;
@@ -5024,8 +5024,6 @@ static int _bpf_setsockopt(struct sock *sk, int level, int optname,
 	if (!sk_fullsock(sk))
 		return -EINVAL;
 
-	sock_owned_by_me(sk);
-
 	if (level == SOL_SOCKET) {
 		if (optlen != sizeof(int) && optname != SO_BINDTODEVICE)
 			return -EINVAL;
@@ -5258,14 +5256,20 @@ static int _bpf_setsockopt(struct sock *sk, int level, int optname,
 	return ret;
 }
 
-static int _bpf_getsockopt(struct sock *sk, int level, int optname,
+static int _bpf_setsockopt(struct sock *sk, int level, int optname,
 			   char *optval, int optlen)
+{
+	if (sk_fullsock(sk))
+		sock_owned_by_me(sk);
+	return __bpf_setsockopt(sk, level, optname, optval, optlen);
+}
+
+static int __bpf_getsockopt(struct sock *sk, int level, int optname,
+			    char *optval, int optlen)
 {
 	if (!sk_fullsock(sk))
 		goto err_clear;
 
-	sock_owned_by_me(sk);
-
 	if (level == SOL_SOCKET) {
 		if (optlen != sizeof(int))
 			goto err_clear;
@@ -5360,6 +5364,14 @@ static int _bpf_getsockopt(struct sock *sk, int level, int optname,
 	return -EINVAL;
 }
 
+static int _bpf_getsockopt(struct sock *sk, int level, int optname,
+			   char *optval, int optlen)
+{
+	if (sk_fullsock(sk))
+		sock_owned_by_me(sk);
+	return __bpf_getsockopt(sk, level, optname, optval, optlen);
+}
+
 BPF_CALL_5(bpf_sk_setsockopt, struct sock *, sk, int, level,
 	   int, optname, char *, optval, int, optlen)
 {
@@ -5400,6 +5412,40 @@ const struct bpf_func_proto bpf_sk_getsockopt_proto = {
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
+BPF_CALL_5(bpf_unlocked_sk_setsockopt, struct sock *, sk, int, level,
+	   int, optname, char *, optval, int, optlen)
+{
+	return __bpf_setsockopt(sk, level, optname, optval, optlen);
+}
+
+const struct bpf_func_proto bpf_unlocked_sk_setsockopt_proto = {
+	.func		= bpf_unlocked_sk_setsockopt,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg5_type	= ARG_CONST_SIZE,
+};
+
+BPF_CALL_5(bpf_unlocked_sk_getsockopt, struct sock *, sk, int, level,
+	   int, optname, char *, optval, int, optlen)
+{
+	return __bpf_getsockopt(sk, level, optname, optval, optlen);
+}
+
+const struct bpf_func_proto bpf_unlocked_sk_getsockopt_proto = {
+	.func		= bpf_unlocked_sk_getsockopt,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg5_type	= ARG_CONST_SIZE,
+};
+
 BPF_CALL_5(bpf_sock_addr_setsockopt, struct bpf_sock_addr_kern *, ctx,
 	   int, level, int, optname, char *, optval, int, optlen)
 {
-- 
2.37.0.rc0.161.g10f37bed90-goog

