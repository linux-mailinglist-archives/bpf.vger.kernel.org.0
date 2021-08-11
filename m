Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E613E9AEA
	for <lists+bpf@lfdr.de>; Thu, 12 Aug 2021 00:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhHKW2R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Aug 2021 18:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbhHKW2Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Aug 2021 18:28:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC341C061765
        for <bpf@vger.kernel.org>; Wed, 11 Aug 2021 15:27:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p71-20020a25424a0000b029056092741626so4075349yba.19
        for <bpf@vger.kernel.org>; Wed, 11 Aug 2021 15:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DMaGpGpDFx/eWPsONiwHAvxlw8b7WueF5ejMV9lg1IM=;
        b=ZBT5+l7+B+sMrD2HXZvD+UcepjaegcwbhX2Lw3WhWH0cl2zi23vhLymzAPhvgGUrHw
         DSANX9OeG6knW1PfUcUFuEYirerCwA3vuYsO6K0gIkvsjlTSW+jY41I9SRc+2XAlYYZL
         eXy8dCUDC+u/18GOPychVljK8R/4/4WYC5QasTDpEh1pcCnnzQ8vMAzhjmoFavhkTS5u
         CjfpB1khlZeVbCjQ/Yg/wW4p/2f1pLxbc9F+NWxWZT+T4IFzcItHHIQ0ybmScgiDIIVx
         J0u03cQAt2nrgpqn4j72hhxnqodGjg1jFjm1v/SmbwUN7bRdRQRH14sYMu3AdWTRTSct
         DVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DMaGpGpDFx/eWPsONiwHAvxlw8b7WueF5ejMV9lg1IM=;
        b=c1/riPtlwmpfFWGzWQYWVOJuCb8x3gfyQDiHFG2E6b7mjhYUkw+Zd4UyCYBUdTvGAS
         +gCbiZyaAE9HcbtUMIZWg2jTJJtEPNqMwmzZOWhrcVNTo2/Yg1sPnnAfsv9CCbIGBVTF
         NIJlX+cMuO2IeyudoWXoN2avBllfCNS7dpgCMUEtqDxTqji7nO7DcIb+JDGU/CqHxQMu
         dnAu7h89PTlCswHCbfo+EVVsF6GAxrRPxe1+YOh+0lrLZv/sAzqGlpUys4Atbdh6kFFW
         Neef5tpD+BCXYHtP+oEmdKQncMpkwpYqpTGE/CuWBsE8zKwwL7O4vLKyH+I28vjzdbu9
         Tkhg==
X-Gm-Message-State: AOAM533WdEYk55wzhDSY6XvSdtZV7D+dWg13mi7FCkQgpGIvL0ibdREQ
        ZBJ37aFimVLjgNcrvWRyHLiK1Xo=
X-Google-Smtp-Source: ABdhPJy3uM21txOa70ZVyG2UWlDoqXk4C9HFKyFD9Y6MACW2+oN3ZE9eAFxD+alNJ9UAhqFmkqhOESI=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:c78e:f5dc:8780:ed29])
 (user=sdf job=sendgmr) by 2002:a25:ce01:: with SMTP id x1mr338537ybe.360.1628720871965;
 Wed, 11 Aug 2021 15:27:51 -0700 (PDT)
Date:   Wed, 11 Aug 2021 15:27:46 -0700
In-Reply-To: <20210811222747.3041445-1-sdf@google.com>
Message-Id: <20210811222747.3041445-2-sdf@google.com>
Mime-Version: 1.0
References: <20210811222747.3041445-1-sdf@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH bpf-next 1/2] bpf: Allow bpf_get_netns_cookie in BPF_PROG_TYPE_CGROUP_SOCKOPT
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is similar to existing BPF_PROG_TYPE_CGROUP_SOCK
and BPF_PROG_TYPE_CGROUP_SOCK_ADDR.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/cgroup.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index b567ca46555c..2428ecf2b2cf 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1846,10 +1846,27 @@ const struct bpf_verifier_ops cg_sysctl_verifier_ops = {
 const struct bpf_prog_ops cg_sysctl_prog_ops = {
 };
 
+BPF_CALL_1(bpf_get_netns_cookie_sockopt, struct bpf_sockopt_kern *, ctx)
+{
+	struct sock *sk = ctx ? ctx->sk : NULL;
+	const struct net *net = sk ? sock_net(sk) : &init_net;
+
+	return net->net_cookie;
+}
+
+static const struct bpf_func_proto bpf_get_netns_cookie_sockopt_proto = {
+	.func		= bpf_get_netns_cookie_sockopt,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX_OR_NULL,
+};
+
 static const struct bpf_func_proto *
 cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
 	switch (func_id) {
+	case BPF_FUNC_get_netns_cookie:
+		return &bpf_get_netns_cookie_sockopt_proto;
 #ifdef CONFIG_NET
 	case BPF_FUNC_sk_storage_get:
 		return &bpf_sk_storage_get_proto;
-- 
2.33.0.rc1.237.g0d66db33f3-goog

