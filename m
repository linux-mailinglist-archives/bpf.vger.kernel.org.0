Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6883F1F1EF3
	for <lists+bpf@lfdr.de>; Mon,  8 Jun 2020 20:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgFHS1v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jun 2020 14:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgFHS1v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 14:27:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC01C08C5C2
        for <bpf@vger.kernel.org>; Mon,  8 Jun 2020 11:27:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e20so22109834ybc.23
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2020 11:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RdJCl8x2cn1s1aootrsy4QHc+RgUFPAK4hpzuQdFc08=;
        b=EuaFcc2O46p1byQh/ypjMUzNAjFb/VaLwb07YuE0P0DPxNN6C1kHG8mXoKRS5G8Izc
         R2CAOCIjBUkGfPFKJdlkzAzcRMyTDiwnGHRkzRXXlqO1SfsSr7Q3BxHzd31K/14NUwbs
         3jYAMt2sPLqUKDey2y8bENVMJg7CbPqIkk4HbSrqC4TxnaNa1iZ6Rwx3tm9srMKVUXpe
         BV7jYjhe1+3mKtPZiPc8lxv9x62E9MsteLQFLDYTcyonMGhUCTY4hQc7eRFxYXKcx2g9
         ap5/IhZu/YddWStfERMO7mhotcAR244pckI0XV8i288vybm3MIiTwou/mRSRduz5LyvR
         DDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RdJCl8x2cn1s1aootrsy4QHc+RgUFPAK4hpzuQdFc08=;
        b=TBjSgOivpZsOtAc1TQVeB0aPDIrdhtDThezjScYkJ6PEW3Js3cuJMjRSfQW6ssYlMj
         Fmsb+HvZp3X0ezvqGH73ZIf39mRovRCby1Ls+1ZR4i5e/peNl/C9f6Mwq+fwrDsX/goR
         SRAl47mBLnINx0eQX8f1TTggJZ6DI6OZF3Q8cDEffQb/B2N8IXMKuhffqi14LCGRFugK
         CZfi8uLbiB3RnObECdyIth+h9q8zOG98wKv02OzA1kfdYnmzQuGikZ4P1uYt2Nr7oPUa
         steVlXjj6ruyFzOPEC98iNisPXhCY1/kV1teN1DgGrsY3g5IrXeLCXqhM+CCCq7Lejgh
         wsHg==
X-Gm-Message-State: AOAM531yhR7gVjYaOykf3C8WrlOWrGYurxoHlnNGqKCIEsdYTcb2J7j+
        Ce1z4hgV02NxJ0hBfeDHOU2N6Ug=
X-Google-Smtp-Source: ABdhPJzGHNGa9azN+0uc2AlNeitNho1WobWz99qIz+2qbXJ61R7J+xL7CRP8TWFjM677z6msSQC6IoQ=
X-Received: by 2002:a25:4d44:: with SMTP id a65mr85560ybb.422.1591640870344;
 Mon, 08 Jun 2020 11:27:50 -0700 (PDT)
Date:   Mon,  8 Jun 2020 11:27:47 -0700
Message-Id: <20200608182748.6998-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH bpf v3 1/2] bpf: don't return EINVAL from {get,set}sockopt
 when optlen > PAGE_SIZE
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        David Laight <David.Laight@ACULAB.COM>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Attaching to these hooks can break iptables because its optval is
usually quite big, or at least bigger than the current PAGE_SIZE limit.
David also mentioned some SCTP options can be big (around 256k).

There are two possible ways to fix it:
1. Increase the limit to match iptables max optval. There is, however,
   no clear upper limit. Technically, iptables can accept up to
   512M of data (not sure how practical it is though).

2. Bypass the value (don't expose to BPF) if it's too big and trigger
   BPF only with level/optname so BPF can still decide whether
   to allow/deny big sockopts.

The initial attempt was implemented using strategy #1. Due to
listed shortcomings, let's switch to strategy #2. When there is
legitimate a real use-case for iptables/SCTP, we can consider increasing
the PAGE_SIZE limit.

v3:
* don't increase the limit, bypass the argument

v2:
* proper comments formatting (Jakub Kicinski)

Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
Cc: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/cgroup.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index fdf7836750a3..758082853086 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1276,9 +1276,18 @@ static bool __cgroup_bpf_prog_array_is_empty(struct cgroup *cgrp,
 
 static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen)
 {
-	if (unlikely(max_optlen > PAGE_SIZE) || max_optlen < 0)
+	if (unlikely(max_optlen < 0))
 		return -EINVAL;
 
+	if (unlikely(max_optlen > PAGE_SIZE)) {
+		/* We don't expose optvals that are greater than PAGE_SIZE
+		 * to the BPF program.
+		 */
+		ctx->optval = NULL;
+		ctx->optval_end = NULL;
+		return 0;
+	}
+
 	ctx->optval = kzalloc(max_optlen, GFP_USER);
 	if (!ctx->optval)
 		return -ENOMEM;
@@ -1325,7 +1334,7 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 
 	ctx.optlen = *optlen;
 
-	if (copy_from_user(ctx.optval, optval, *optlen) != 0) {
+	if (ctx.optval && copy_from_user(ctx.optval, optval, *optlen) != 0) {
 		ret = -EFAULT;
 		goto out;
 	}
@@ -1407,7 +1416,8 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 		if (ctx.optlen > max_optlen)
 			ctx.optlen = max_optlen;
 
-		if (copy_from_user(ctx.optval, optval, ctx.optlen) != 0) {
+		if (ctx.optval &&
+		    copy_from_user(ctx.optval, optval, ctx.optlen) != 0) {
 			ret = -EFAULT;
 			goto out;
 		}
@@ -1436,7 +1446,7 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 		goto out;
 	}
 
-	if (copy_to_user(optval, ctx.optval, ctx.optlen) ||
+	if ((ctx.optval && copy_to_user(optval, ctx.optval, ctx.optlen)) ||
 	    put_user(ctx.optlen, optlen)) {
 		ret = -EFAULT;
 		goto out;
-- 
2.27.0.278.ge193c7cf3a9-goog

