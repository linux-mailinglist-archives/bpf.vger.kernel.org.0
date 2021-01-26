Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B57304CB6
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 23:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbhAZWxt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 17:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390750AbhAZSj5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jan 2021 13:39:57 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEC8C061355
        for <bpf@vger.kernel.org>; Tue, 26 Jan 2021 10:36:11 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l12so17558114wry.2
        for <bpf@vger.kernel.org>; Tue, 26 Jan 2021 10:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yw3RM/yk9wzBes8csZwbs5/wVqbQMigeWCray2zWeak=;
        b=ie2rsto3zADnlUTfWtARNuIyll2roERNJspYxOrwMT/xghOeCNGeovsPo1kCxY40ZH
         rIByKI3Vfv6AmHSKqVdSIXwGv9w0J2YZXsvdFGRvGLdcw5dh+XA/R0vCyAxEfvJAhJtq
         46bqPKpqu3pXVDjojhTThjzM/5b+9Ux6GqDcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yw3RM/yk9wzBes8csZwbs5/wVqbQMigeWCray2zWeak=;
        b=VNjwF6bnhzEL3LYxtEuR0Y2rMWXMMm7jDwrJxea75IGS30Gz9MsiGoPlThssWxNCZ0
         dHjxJCKNR0XtvPd+4PmVZbZwGA5DDY9j64NN8R9VqKnzIDB6bM/aTsCXKhucBgYPn8wT
         PVP8NAgEa6q5jvh3p40E3mO+4lZfmRszxwP/GM8KZqLZPrHh7EtnSGT/toUWv33CWdeF
         ZlO5AM6fWfnNdGJwYyYuWlXyLk0oSxwRsir4lf1jBvIPpz1P/IQIMJ3Zu2EdITcvj1Y3
         FfqoGsZalWjpITBmxUcR5eOXpu6H4OpAonceei6C8ItFTiWFKEfS7vYvpeQKcp3ns4xn
         r/ug==
X-Gm-Message-State: AOAM530lP32TcqgkITUtilT0VndVuxEZoVPJc765xL1TrR9U90UPM0z+
        IOFu5US9of5+m8UyXOEr4+7Xc8tETNyj8g==
X-Google-Smtp-Source: ABdhPJxstY9iqwYrPWlri/zeLYeb1fuAmLaClTHd9h+nlUtHSMnOmK7VdpQ3UeS9xuhA+5qKdY31iA==
X-Received: by 2002:a5d:554e:: with SMTP id g14mr7586403wrw.305.1611686169726;
        Tue, 26 Jan 2021 10:36:09 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:deb:d0ec:3143:2380])
        by smtp.gmail.com with ESMTPSA id d13sm28339354wrx.93.2021.01.26.10.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:36:09 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next v6 4/5] selftests/bpf: Use vmlinux.h in socket_cookie_prog.c
Date:   Tue, 26 Jan 2021 19:35:58 +0100
Message-Id: <20210126183559.1302406-4-revest@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210126183559.1302406-1-revest@chromium.org>
References: <20210126183559.1302406-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When migrating from the bpf.h's to the vmlinux.h's definition of struct
bps_sock, an interesting LLVM behavior happened. LLVM started producing
two fetches of ctx->sk in the sockops program this means that the
verifier could not keep track of the NULL-check on ctx->sk. Therefore,
we need to extract ctx->sk in a variable before checking and
dereferencing it.

Acked-by: KP Singh <kpsingh@kernel.org>
Signed-off-by: Florent Revest <revest@chromium.org>
---
 .../testing/selftests/bpf/progs/socket_cookie_prog.c  | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/socket_cookie_prog.c b/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
index 81e84be6f86d..fbd5eaf39720 100644
--- a/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
+++ b/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
@@ -1,12 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018 Facebook
 
-#include <linux/bpf.h>
-#include <sys/socket.h>
+#include "vmlinux.h"
 
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+#define AF_INET6 10
+
 struct socket_cookie {
 	__u64 cookie_key;
 	__u32 cookie_value;
@@ -41,7 +42,7 @@ int set_cookie(struct bpf_sock_addr *ctx)
 SEC("sockops")
 int update_cookie(struct bpf_sock_ops *ctx)
 {
-	struct bpf_sock *sk;
+	struct bpf_sock *sk = ctx->sk;
 	struct socket_cookie *p;
 
 	if (ctx->family != AF_INET6)
@@ -50,10 +51,10 @@ int update_cookie(struct bpf_sock_ops *ctx)
 	if (ctx->op != BPF_SOCK_OPS_TCP_CONNECT_CB)
 		return 1;
 
-	if (!ctx->sk)
+	if (!sk)
 		return 1;
 
-	p = bpf_sk_storage_get(&socket_cookies, ctx->sk, 0, 0);
+	p = bpf_sk_storage_get(&socket_cookies, sk, 0, 0);
 	if (!p)
 		return 1;
 
-- 
2.30.0.280.ga3ce27912f-goog

