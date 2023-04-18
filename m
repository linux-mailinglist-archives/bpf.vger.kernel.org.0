Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0826E6FB1
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 00:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjDRWx6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 18:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjDRWx5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 18:53:57 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5C449C6
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 15:53:54 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-51b85b8ecc9so781020a12.2
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 15:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681858434; x=1684450434;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s9eyzg3DpGiEYVuzyNgxp7YetY0MDfxLPrCCNs2Zvvk=;
        b=Z6CUoi5qZZ7kS3kR9tqx0+E9I+mr8CraWqZ0aW71u8zTUx4NVa4OThwGhrjmlyezJh
         anhRzvLqqemdPnZNT3viFBFzSFx9Y0ga3Nj/oSv9Dsw/shb+mvPIOcM76B5F34PZs1aC
         dy96RzWm33YQdHw2LR7ijoKM9PyxCeYu+znZ9Zt+cuoFQnEWu69ka29i1KZ/6SSzVxBI
         oci7nK42HrU3EJVmNjsW1W3xiFQHoXwS8Jnid/+WfLRIHXSVEER5uyfyVplIp/ssq3rR
         4eUcjogjOxsRqqXJrO4ugpnYmO5gW8Q3lpspruQ6nA9U7irR+kSkZCpojzcAwjDZ6iGU
         fLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681858434; x=1684450434;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9eyzg3DpGiEYVuzyNgxp7YetY0MDfxLPrCCNs2Zvvk=;
        b=h8K61KJKMk3aYyMglyUlCDwd/aJcgzaUcF4odLStwPLvFqce4qH1Cq0atdrFuSQRGJ
         61dd18vuSvoaxMKUuMomyQKslfrc0PLRaiV8TSbGNTJLIH/L+MoH0HFloh6n0rVK4ye3
         DWq9WhqY8XlR6p9l/P7rmTkRVFoEinrspxyBqfNYOWdkPjCwLFbWC/G1yFFwR+Lz6V+3
         DwTclWgrxu7JrGbbPCjQj8aFLcnyZHictK+feljujZBeDVhm26edgbJMafuhx3pys5S8
         LSUdvXcNQtAVNRg8UfQ/UXa5hNBidPRefAGO5+npTlruESPnrPggi8le4AYahs5SLNwL
         qyNQ==
X-Gm-Message-State: AAQBX9clyWWyg36X2zfuoTjD2LAGesw2CIWJel6f7eXXxrdfAiq37T6D
        x+Gor7sN9LxL3qlhj8JIeL+nL3DmYAu93O6P8Z3xmNGuFYqoGYB370vvxzRf+0QuRcySI5gTbl6
        vp0iYrQNXBPNbqNhnWJU8qCWPloqHrBEkF0w0UGKcq01yau/GYQ==
X-Google-Smtp-Source: AKy350YSZIXg3WCqNu+Mou7AYjHLRs9KLSVAH54q7rckeGJ5SszK6nHGIpYvAhk1DzkSWLCW70UzpFo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a65:498b:0:b0:513:98d5:5ba with SMTP id
 r11-20020a65498b000000b0051398d505bamr1059099pgs.7.1681858434303; Tue, 18 Apr
 2023 15:53:54 -0700 (PDT)
Date:   Tue, 18 Apr 2023 15:53:42 -0700
In-Reply-To: <20230418225343.553806-1-sdf@google.com>
Mime-Version: 1.0
References: <20230418225343.553806-1-sdf@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418225343.553806-6-sdf@google.com>
Subject: [PATCH bpf-next 5/6] selftests/bpf: Correctly handle optlen > 4096
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

Even though it's not relevant in selftests, the people
might still copy-paste from them. So let's take care
of optlen > 4096 cases explicitly.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../progs/cgroup_getset_retval_getsockopt.c   | 12 +++++++++
 .../progs/cgroup_getset_retval_setsockopt.c   | 16 ++++++++++++
 .../selftests/bpf/progs/sockopt_inherit.c     | 16 ++++++++++--
 .../selftests/bpf/progs/sockopt_multi.c       | 24 +++++++++++++++---
 .../selftests/bpf/progs/sockopt_qos_to_cc.c   |  8 +++++-
 .../testing/selftests/bpf/progs/sockopt_sk.c  | 25 +++++++++++++------
 6 files changed, 88 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/cgroup_getset_retval_getsockopt.c b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_getsockopt.c
index b2a409e6382a..b66454886cc4 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_getset_retval_getsockopt.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_getsockopt.c
@@ -20,6 +20,10 @@ int get_retval(struct bpf_sockopt *ctx)
 	ctx_retval_value = ctx->retval;
 	__sync_fetch_and_add(&invocations, 1);
 
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > 4096)
+		ctx->optlen = 0;
+
 	return 1;
 }
 
@@ -31,6 +35,10 @@ int set_eisconn(struct bpf_sockopt *ctx)
 	if (bpf_set_retval(-EISCONN))
 		assertion_error = 1;
 
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > 4096)
+		ctx->optlen = 0;
+
 	return 1;
 }
 
@@ -41,5 +49,9 @@ int clear_retval(struct bpf_sockopt *ctx)
 
 	ctx->retval = 0;
 
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > 4096)
+		ctx->optlen = 0;
+
 	return 1;
 }
diff --git a/tools/testing/selftests/bpf/progs/cgroup_getset_retval_setsockopt.c b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_setsockopt.c
index d6e5903e06ba..68fce0311771 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_getset_retval_setsockopt.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_setsockopt.c
@@ -18,6 +18,10 @@ int get_retval(struct bpf_sockopt *ctx)
 	retval_value = bpf_get_retval();
 	__sync_fetch_and_add(&invocations, 1);
 
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > 4096)
+		ctx->optlen = 0;
+
 	return 1;
 }
 
@@ -29,6 +33,10 @@ int set_eunatch(struct bpf_sockopt *ctx)
 	if (bpf_set_retval(-EUNATCH))
 		assertion_error = 1;
 
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > 4096)
+		ctx->optlen = 0;
+
 	return 0;
 }
 
@@ -40,6 +48,10 @@ int set_eisconn(struct bpf_sockopt *ctx)
 	if (bpf_set_retval(-EISCONN))
 		assertion_error = 1;
 
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > 4096)
+		ctx->optlen = 0;
+
 	return 0;
 }
 
@@ -48,5 +60,9 @@ int legacy_eperm(struct bpf_sockopt *ctx)
 {
 	__sync_fetch_and_add(&invocations, 1);
 
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > 4096)
+		ctx->optlen = 0;
+
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/sockopt_inherit.c b/tools/testing/selftests/bpf/progs/sockopt_inherit.c
index 9fb241b97291..78e56070dbcf 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_inherit.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_inherit.c
@@ -55,7 +55,7 @@ int _getsockopt(struct bpf_sockopt *ctx)
 	__u8 *optval = ctx->optval;
 
 	if (ctx->level != SOL_CUSTOM)
-		return 1; /* only interested in SOL_CUSTOM */
+		goto out; /* only interested in SOL_CUSTOM */
 
 	if (optval + 1 > optval_end)
 		return 0; /* EPERM, bounds check */
@@ -70,6 +70,12 @@ int _getsockopt(struct bpf_sockopt *ctx)
 	ctx->optlen = 1;
 
 	return 1;
+
+out:
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > 4096)
+		ctx->optlen = 0;
+	return 1;
 }
 
 SEC("cgroup/setsockopt")
@@ -80,7 +86,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
 	__u8 *optval = ctx->optval;
 
 	if (ctx->level != SOL_CUSTOM)
-		return 1; /* only interested in SOL_CUSTOM */
+		goto out; /* only interested in SOL_CUSTOM */
 
 	if (optval + 1 > optval_end)
 		return 0; /* EPERM, bounds check */
@@ -93,4 +99,10 @@ int _setsockopt(struct bpf_sockopt *ctx)
 	ctx->optlen = -1;
 
 	return 1;
+
+out:
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > 4096)
+		ctx->optlen = 0;
+	return 1;
 }
diff --git a/tools/testing/selftests/bpf/progs/sockopt_multi.c b/tools/testing/selftests/bpf/progs/sockopt_multi.c
index 177a59069dae..f645eb253c6c 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_multi.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_multi.c
@@ -12,7 +12,7 @@ int _getsockopt_child(struct bpf_sockopt *ctx)
 	__u8 *optval = ctx->optval;
 
 	if (ctx->level != SOL_IP || ctx->optname != IP_TOS)
-		return 1;
+		goto out;
 
 	if (optval + 1 > optval_end)
 		return 0; /* EPERM, bounds check */
@@ -26,6 +26,12 @@ int _getsockopt_child(struct bpf_sockopt *ctx)
 	ctx->optlen = 1;
 
 	return 1;
+
+out:
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > 4096)
+		ctx->optlen = 0;
+	return 1;
 }
 
 SEC("cgroup/getsockopt")
@@ -35,7 +41,7 @@ int _getsockopt_parent(struct bpf_sockopt *ctx)
 	__u8 *optval = ctx->optval;
 
 	if (ctx->level != SOL_IP || ctx->optname != IP_TOS)
-		return 1;
+		goto out;
 
 	if (optval + 1 > optval_end)
 		return 0; /* EPERM, bounds check */
@@ -49,6 +55,12 @@ int _getsockopt_parent(struct bpf_sockopt *ctx)
 	ctx->optlen = 1;
 
 	return 1;
+
+out:
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > 4096)
+		ctx->optlen = 0;
+	return 1;
 }
 
 SEC("cgroup/setsockopt")
@@ -58,7 +70,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
 	__u8 *optval = ctx->optval;
 
 	if (ctx->level != SOL_IP || ctx->optname != IP_TOS)
-		return 1;
+		goto out;
 
 	if (optval + 1 > optval_end)
 		return 0; /* EPERM, bounds check */
@@ -67,4 +79,10 @@ int _setsockopt(struct bpf_sockopt *ctx)
 	ctx->optlen = 1;
 
 	return 1;
+
+out:
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > 4096)
+		ctx->optlen = 0;
+	return 1;
 }
diff --git a/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c b/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c
index 1bce83b6e3a7..597f3e276cf7 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c
@@ -19,7 +19,7 @@ int sockopt_qos_to_cc(struct bpf_sockopt *ctx)
 	char cc_cubic[TCP_CA_NAME_MAX] = "cubic";
 
 	if (ctx->level != SOL_IPV6 || ctx->optname != IPV6_TCLASS)
-		return 1;
+		goto out;
 
 	if (optval + 1 > optval_end)
 		return 0; /* EPERM, bounds check */
@@ -36,4 +36,10 @@ int sockopt_qos_to_cc(struct bpf_sockopt *ctx)
 			return 0;
 	}
 	return 1;
+
+out:
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > 4096)
+		ctx->optlen = 0;
+	return 1;
 }
diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
index fe1df4cd206e..e1aed858c208 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -37,7 +37,7 @@ int _getsockopt(struct bpf_sockopt *ctx)
 	/* Bypass AF_NETLINK. */
 	sk = ctx->sk;
 	if (sk && sk->family == AF_NETLINK)
-		return 1;
+		goto out;
 
 	/* Make sure bpf_get_netns_cookie is callable.
 	 */
@@ -52,8 +52,7 @@ int _getsockopt(struct bpf_sockopt *ctx)
 		 * let next BPF program in the cgroup chain or kernel
 		 * handle it.
 		 */
-		ctx->optlen = 0; /* bypass optval>PAGE_SIZE */
-		return 1;
+		goto out;
 	}
 
 	if (ctx->level == SOL_SOCKET && ctx->optname == SO_SNDBUF) {
@@ -61,7 +60,7 @@ int _getsockopt(struct bpf_sockopt *ctx)
 		 * let next BPF program in the cgroup chain or kernel
 		 * handle it.
 		 */
-		return 1;
+		goto out;
 	}
 
 	if (ctx->level == SOL_TCP && ctx->optname == TCP_CONGESTION) {
@@ -69,7 +68,7 @@ int _getsockopt(struct bpf_sockopt *ctx)
 		 * let next BPF program in the cgroup chain or kernel
 		 * handle it.
 		 */
-		return 1;
+		goto out;
 	}
 
 	if (ctx->level == SOL_TCP && ctx->optname == TCP_ZEROCOPY_RECEIVE) {
@@ -85,7 +84,7 @@ int _getsockopt(struct bpf_sockopt *ctx)
 		if (((struct tcp_zerocopy_receive *)optval)->address != 0)
 			return 0; /* unexpected data */
 
-		return 1;
+		goto out;
 	}
 
 	if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
@@ -129,6 +128,12 @@ int _getsockopt(struct bpf_sockopt *ctx)
 	ctx->optlen = 1;
 
 	return 1;
+
+out:
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > 4096)
+		ctx->optlen = 0;
+	return 1;
 }
 
 SEC("cgroup/setsockopt")
@@ -142,7 +147,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
 	/* Bypass AF_NETLINK. */
 	sk = ctx->sk;
 	if (sk && sk->family == AF_NETLINK)
-		return 1;
+		goto out;
 
 	/* Make sure bpf_get_netns_cookie is callable.
 	 */
@@ -224,4 +229,10 @@ int _setsockopt(struct bpf_sockopt *ctx)
 			   */
 
 	return 1;
+
+out:
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > 4096)
+		ctx->optlen = 0;
+	return 1;
 }
-- 
2.40.0.634.g4ca3ef3211-goog

