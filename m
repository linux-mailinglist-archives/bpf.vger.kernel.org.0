Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 615A679B85
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2019 23:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388898AbfG2VvS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Jul 2019 17:51:18 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:37906 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388890AbfG2VvR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Jul 2019 17:51:17 -0400
Received: by mail-pf1-f201.google.com with SMTP id e25so39360625pfn.5
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2019 14:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kBhb0smtLVURD2BBgCfZlpeNqb/3JQfxJqN7MROUQRA=;
        b=hl8xMzZ6ToLMJfpw4O1KGxQFHfHFvvJ/u9S7aHuViuIoUvUvP7ITYfCPIAGUKRBJWX
         EEqZ6FeqreQXt2/+LMXNXqH1RGNMwUUrR47Qur1d2NnOLYcVcg1bzfH8R7r++0dzPurZ
         sGRhBjL0Pr0RphEbvl1FLBSZidHCs1d9jaV7Y1wI6SRU6FY5JHZMRFSKLquP/HBVnaE2
         3oK7wq4bRSVaiFIwfEYmgxwcMLCiheJgwTek6uEtuz9nOXzQE1Ui78uIDnrv0pafTkhe
         5Znt4TQNLnfI5OkZrEhD+oDq9E0pQ/ZIekdq5sGqNLq/yLA3C8vMc0Ii4dWwfiPQNnty
         cRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kBhb0smtLVURD2BBgCfZlpeNqb/3JQfxJqN7MROUQRA=;
        b=coq1r5pyhCZM3ndiUQXTxoiOO1cgCrcDNnS22i/OjKGP37VH8BfcCJgN2THJ2Gs75z
         4MYdPgfMYTzDyNguDo5gFMc4U0F0vt7WhzCITn8UXdztlRzo+Vk8/7q9zlVWsc5iz4/J
         vhqBWNiv4GDibysrRfxJ2izmlz0zdc2xXwRz72XoTPbLWxPkWgOaDhR/kLi0Ed8pbuUj
         I3anDuIt7FkU3IZasSXJuDZADj+4R4Swd6a3N8wC+JVEiYEFECKBwhzaAvVUYNkRqQod
         LhIxOmkwYAr3Iq1UANKp8ZS0A1QwCEC2XRoZqnpEvZeD1Ci3+GXVEN5jUQ3+gqdJOW2O
         3JSA==
X-Gm-Message-State: APjAAAV56COfX64y3Ddj61Jrw5NxgbREkN1WhIsS67ULAjuQKlEfBgpU
        7POb/b+eavIEbftpSyZW2T8oSjs=
X-Google-Smtp-Source: APXvYqzOCoB3RhL/aGtJLgOCdcyWpnmkHSq3WV5WrLAx+O1Rkon6J0XFjZ1N2peLo+Y6WRlPnQl6W2s=
X-Received: by 2002:a63:505a:: with SMTP id q26mr103339803pgl.18.1564437076749;
 Mon, 29 Jul 2019 14:51:16 -0700 (PDT)
Date:   Mon, 29 Jul 2019 14:51:10 -0700
In-Reply-To: <20190729215111.209219-1-sdf@google.com>
Message-Id: <20190729215111.209219-2-sdf@google.com>
Mime-Version: 1.0
References: <20190729215111.209219-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH bpf-next 1/2] bpf: always allocate at least 16 bytes for
 setsockopt hook
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since we always allocate memory, allocate just a little bit more
for the BPF program in case it need to override user input with
bigger value. The canonical example is TCP_CONGESTION where
input string might be too small to override (nv -> bbr or cubic).

16 bytes are chosen to match the size of TCP_CA_NAME_MAX and can
be extended in the future if needed.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/cgroup.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 0a00eaca6fae..6a6a154cfa7b 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -964,7 +964,6 @@ static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen)
 		return -ENOMEM;
 
 	ctx->optval_end = ctx->optval + max_optlen;
-	ctx->optlen = max_optlen;
 
 	return 0;
 }
@@ -984,7 +983,7 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 		.level = *level,
 		.optname = *optname,
 	};
-	int ret;
+	int ret, max_optlen;
 
 	/* Opportunistic check to see whether we have any BPF program
 	 * attached to the hook so we don't waste time allocating
@@ -994,10 +993,18 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 	    __cgroup_bpf_prog_array_is_empty(cgrp, BPF_CGROUP_SETSOCKOPT))
 		return 0;
 
-	ret = sockopt_alloc_buf(&ctx, *optlen);
+	/* Allocate a bit more than the initial user buffer for
+	 * BPF program. The canonical use case is overriding
+	 * TCP_CONGESTION(nv) to TCP_CONGESTION(cubic).
+	 */
+	max_optlen = max_t(int, 16, *optlen);
+
+	ret = sockopt_alloc_buf(&ctx, max_optlen);
 	if (ret)
 		return ret;
 
+	ctx.optlen = *optlen;
+
 	if (copy_from_user(ctx.optval, optval, *optlen) != 0) {
 		ret = -EFAULT;
 		goto out;
@@ -1016,7 +1023,7 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 	if (ctx.optlen == -1) {
 		/* optlen set to -1, bypass kernel */
 		ret = 1;
-	} else if (ctx.optlen > *optlen || ctx.optlen < -1) {
+	} else if (ctx.optlen > max_optlen || ctx.optlen < -1) {
 		/* optlen is out of bounds */
 		ret = -EFAULT;
 	} else {
@@ -1063,6 +1070,8 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 	if (ret)
 		return ret;
 
+	ctx.optlen = max_optlen;
+
 	if (!retval) {
 		/* If kernel getsockopt finished successfully,
 		 * copy whatever was returned to the user back
-- 
2.22.0.709.g102302147b-goog

