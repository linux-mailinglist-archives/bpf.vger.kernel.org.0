Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C356F0CD1
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 22:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245540AbjD0UET (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 16:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344077AbjD0UES (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 16:04:18 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE51F3A99
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 13:04:16 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-64115ef7234so5811142b3a.1
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 13:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682625856; x=1685217856;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=58JiO1X9FSfj/irRqUMpeVrE7gOAAc85t/q77kIFj6U=;
        b=JuVlRDlV1oscwGtIcdCcgOJFxQl+Hm0AenzDXc8QgUFO2/+F0W0vackVK1tFdQGz71
         z5vjNHavuIxrtR8EcjkLs6qGUM33Hj+GrYmWjLGrApQAaiont1/1PU/2PPlYRUorOlGe
         Hk7mBcsCAs1M9seBt1zZhwcPXIIVbj+XODEJGzJhZbY+EbxS5H7/vW9M3z7qwLg7PwdG
         bF8mlJpiA3U4Y3VWkUJ3qTqlqdlfYy/ba6fTkwHUOTStgyPvrq/eInuC5Sgbk/jG57av
         YHwf5ux0bILDVLree0ytO0lY+Xrf5NuGSw491g0cGxENdTlP9axTKkFOOQTbjfPqiAKW
         3tkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682625856; x=1685217856;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58JiO1X9FSfj/irRqUMpeVrE7gOAAc85t/q77kIFj6U=;
        b=Hazj/GT2sSRisDed7gDcp9LzrVlu/Y4EZc37qOmvfw63Y+4vfWDdXkZ2mwRR/RkdR6
         /+Mqu8j0leYD0eFTMqJdMxc+z5nifcoeTKY4OobcjzU20I4N43VBTIx1fci+3BR1odiw
         NFE6Ag41slQE6yX2PbMleIH8kFmEp3EW2SEx0DmXgK/Z7iwYptdkatjxTAl2ZWU3Moz+
         UGMMNO3oKlKtcI3mNE6RUR13CBdXZj7wIrmcGDyCGTOTIB1VFi5nuo2J31qjDpppsTzM
         qkGVPYivfdBITOAGZLMCkedcUNWm29LUrZRmqdAlOvxeF/FZU9yXLkZFFgsva35frNuo
         jGng==
X-Gm-Message-State: AC+VfDyzZZ6/pzHaGAk/HMf3VYyGe1Heb6NO9iRAX3xPlrl1MXdpVbt1
        vDHLErgQ8+dybQV3uVLTptp/fxOxD/7LVoBMWMlP1m62NP8iN6YLOcof3a4bMBAHSgN41vqNnKG
        lTcs+Vh9n8rEXdE5MTG3KEMpUzj+jEaR2+jiKItYNHhDlpkv2nw==
X-Google-Smtp-Source: ACHHUZ7XbdYavyU8EUL+tE+dthwmP8k1uzDxM295jMWk0dB2K8PaF6tN+RGrV6Xc1hNLs9ygmDoLEVM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:f98b:b0:1a5:22f3:220e with SMTP id
 ky11-20020a170902f98b00b001a522f3220emr2415669plb.3.1682625856152; Thu, 27
 Apr 2023 13:04:16 -0700 (PDT)
Date:   Thu, 27 Apr 2023 13:04:08 -0700
In-Reply-To: <20230427200409.1785263-1-sdf@google.com>
Mime-Version: 1.0
References: <20230427200409.1785263-1-sdf@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230427200409.1785263-4-sdf@google.com>
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Correctly handle optlen > 4096
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
2.40.1.495.gc816e09b53d-goog

