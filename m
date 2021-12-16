Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37FD4767B0
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 03:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhLPCE6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 21:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbhLPCEz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 21:04:55 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC51C06173E
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 18:04:55 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id p7-20020ac84087000000b002b60be80b27so31885127qtl.18
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 18:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SHQRpvxALgFJ5KDvUh7/4T3a3BFoLhOd9nT0Uk/uSZA=;
        b=Dy29Lq7vgvtHO3uHeQT6Jyn5yv5fL5Ym6bwVnHdd0RO/6hyxJ+tMB9/O6JQrA0wJDy
         BCgqDjeRcPRiLgLgmvV3HtvN0fJlcYc3RY8KfAkJcYu//SXk9Xe7rBtJVaLWCT0SpQ3V
         YxDHAbiERmnBuNBsUzy3Hvje8OatQAGm8aqH4BcbsQ5CzOMORq6ik9XhTR7ouQLh6sRk
         G+hdyCAcfgVWcM3E8oxlno3nnGq9VmyNX2FqlBSm3UArYegF3ac3cSXAA9lTibYIZ5zp
         cv/5t/V0L12qF//tSqYBV5nJn9EK9RklCKDgrD1eQdbfm33lzeb92u82MvTSfvoN0qxd
         dIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SHQRpvxALgFJ5KDvUh7/4T3a3BFoLhOd9nT0Uk/uSZA=;
        b=aRPM0lVZrfLXcDDiHzNi77iftInhsTo2IIX11iFbH2Be9IfziHShuVbiD+IJsA2rts
         m9Rp/tHDJ8zFuCq0tLf+Ns2maosp3oKn5raH53zqhQz/vvNEmHB8xqlA5nWY/v7NON1J
         CVzDnn0T8tzuuMunzNTSuJVKFchcuyWywGxvrCB7Ul9ugGOliV7w/3to87fglTvyqVM+
         BSRa71YN6xOl/YGhmvts9EeIp3ZCgMoco/FnEsuPbvjXF9nUt3q4w94qTVyCpIzgsKvO
         oV2ayxJjG3m0luS0+zKWSnTSaOW7/tXtjXlPQ9X1ZMzBy1Ikod4LR3g8k1G4Ebl7I3Ib
         /w0w==
X-Gm-Message-State: AOAM533I+SnK9Qczf4KREcunYxh56kZ8a9+47iVHjxVXs5FlicBKn45A
        eCx1J8+L4yCNS409o7tegdZz26uZdKKe1en0dECYyQczEBaNqH4ycSbhk5u5JoiZdligbKGVOsV
        +Lfu60M1maSmD9AvZeLi3koCg9tJ8ng6J538NOJBnPG/7nO1etVWaLJRkMFUB9EE=
X-Google-Smtp-Source: ABdhPJw0TR8UsnkqizV9tt2jguUSApslNDdOkuibNlhFPvAw+P1WySxZOAFP5fQu15Y8QnlHYbu1TNFZTyhmdg==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a05:622a:164b:: with SMTP id
 y11mr15011659qtj.87.1639620294268; Wed, 15 Dec 2021 18:04:54 -0800 (PST)
Date:   Thu, 16 Dec 2021 02:04:29 +0000
In-Reply-To: <cover.1639619851.git.zhuyifei@google.com>
Message-Id: <4f20b77cb46812dbc2bdcd7e3fa87c7573bde55e.1639619851.git.zhuyifei@google.com>
Mime-Version: 1.0
References: <cover.1639619851.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v2 bpf-next 5/5] selftests/bpf: Update sockopt_sk test to the
 use bpf_set_retval
From:   YiFei Zhu <zhuyifei@google.com>
To:     bpf@vger.kernel.org
Cc:     Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The tests would break without this patch, because at one point it calls
  getsockopt(fd, SOL_TCP, TCP_ZEROCOPY_RECEIVE, &buf, &optlen)
This getsockopt receives the kernel-set -EINVAL. Prior to this patch
series, the eBPF getsockopt hook's -EPERM would override kernel's
-EINVAL, however, after this patch series, return 0's automatic
-EPERM will not; the eBPF prog has to explicitly bpf_set_retval(-EPERM)
if that is wanted.

I also removed the explicit mentions of EPERM in the comments in the
prog.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Reviewed-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/sockopt_sk.c     |  2 +-
 .../testing/selftests/bpf/progs/sockopt_sk.c  | 32 +++++++++----------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
index 4b937e5dbaca..164aa5020bf1 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -177,7 +177,7 @@ static int getsetsockopt(void)
 	optlen = sizeof(buf.zc);
 	errno = 0;
 	err = getsockopt(fd, SOL_TCP, TCP_ZEROCOPY_RECEIVE, &buf, &optlen);
-	if (errno != EPERM) {
+	if (errno != EINVAL) {
 		log_err("Unexpected getsockopt(TCP_ZEROCOPY_RECEIVE) err=%d errno=%d",
 			err, errno);
 		goto err;
diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
index 79c8139b63b8..d0298dccedcd 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -73,17 +73,17 @@ int _getsockopt(struct bpf_sockopt *ctx)
 		 */
 
 		if (optval + sizeof(struct tcp_zerocopy_receive) > optval_end)
-			return 0; /* EPERM, bounds check */
+			return 0; /* bounds check */
 
 		if (((struct tcp_zerocopy_receive *)optval)->address != 0)
-			return 0; /* EPERM, unexpected data */
+			return 0; /* unexpected data */
 
 		return 1;
 	}
 
 	if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
 		if (optval + 1 > optval_end)
-			return 0; /* EPERM, bounds check */
+			return 0; /* bounds check */
 
 		ctx->retval = 0; /* Reset system call return value to zero */
 
@@ -96,24 +96,24 @@ int _getsockopt(struct bpf_sockopt *ctx)
 		 * bytes of data.
 		 */
 		if (optval_end - optval != page_size)
-			return 0; /* EPERM, unexpected data size */
+			return 0; /* unexpected data size */
 
 		return 1;
 	}
 
 	if (ctx->level != SOL_CUSTOM)
-		return 0; /* EPERM, deny everything except custom level */
+		return 0; /* deny everything except custom level */
 
 	if (optval + 1 > optval_end)
-		return 0; /* EPERM, bounds check */
+		return 0; /* bounds check */
 
 	storage = bpf_sk_storage_get(&socket_storage_map, ctx->sk, 0,
 				     BPF_SK_STORAGE_GET_F_CREATE);
 	if (!storage)
-		return 0; /* EPERM, couldn't get sk storage */
+		return 0; /* couldn't get sk storage */
 
 	if (!ctx->retval)
-		return 0; /* EPERM, kernel should not have handled
+		return 0; /* kernel should not have handled
 			   * SOL_CUSTOM, something is wrong!
 			   */
 	ctx->retval = 0; /* Reset system call return value to zero */
@@ -152,7 +152,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
 		/* Overwrite SO_SNDBUF value */
 
 		if (optval + sizeof(__u32) > optval_end)
-			return 0; /* EPERM, bounds check */
+			return 0; /* bounds check */
 
 		*(__u32 *)optval = 0x55AA;
 		ctx->optlen = 4;
@@ -164,7 +164,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
 		/* Always use cubic */
 
 		if (optval + 5 > optval_end)
-			return 0; /* EPERM, bounds check */
+			return 0; /* bounds check */
 
 		memcpy(optval, "cubic", 5);
 		ctx->optlen = 5;
@@ -175,10 +175,10 @@ int _setsockopt(struct bpf_sockopt *ctx)
 	if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
 		/* Original optlen is larger than PAGE_SIZE. */
 		if (ctx->optlen != page_size * 2)
-			return 0; /* EPERM, unexpected data size */
+			return 0; /* unexpected data size */
 
 		if (optval + 1 > optval_end)
-			return 0; /* EPERM, bounds check */
+			return 0; /* bounds check */
 
 		/* Make sure we can trim the buffer. */
 		optval[0] = 0;
@@ -189,21 +189,21 @@ int _setsockopt(struct bpf_sockopt *ctx)
 		 * bytes of data.
 		 */
 		if (optval_end - optval != page_size)
-			return 0; /* EPERM, unexpected data size */
+			return 0; /* unexpected data size */
 
 		return 1;
 	}
 
 	if (ctx->level != SOL_CUSTOM)
-		return 0; /* EPERM, deny everything except custom level */
+		return 0; /* deny everything except custom level */
 
 	if (optval + 1 > optval_end)
-		return 0; /* EPERM, bounds check */
+		return 0; /* bounds check */
 
 	storage = bpf_sk_storage_get(&socket_storage_map, ctx->sk, 0,
 				     BPF_SK_STORAGE_GET_F_CREATE);
 	if (!storage)
-		return 0; /* EPERM, couldn't get sk storage */
+		return 0; /* couldn't get sk storage */
 
 	storage->val = optval[0];
 	ctx->optlen = -1; /* BPF has consumed this option, don't call kernel
-- 
2.34.1.173.g76aa8bc2d0-goog

