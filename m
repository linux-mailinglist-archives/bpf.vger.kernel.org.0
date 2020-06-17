Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0D21FC32B
	for <lists+bpf@lfdr.de>; Wed, 17 Jun 2020 03:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgFQBE3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Jun 2020 21:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgFQBEX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Jun 2020 21:04:23 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1FFC06174E
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2020 18:04:20 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id l6so578794qkk.14
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2020 18:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ElhOma4gQ0OPfIjSUT22cb9hvoULnOkjRgU5fDqO5Dg=;
        b=a3QcOkj2WOe4iE4Y/U7Cs/HGVVwKjy4nSdV8+/SWygE7198rR4NXMQkqfh4WWk9lX6
         MtfRiBvWNrsRNTSwBuPuhUSPNy8IdibcRUwxPE9dHhZzdTuHXI4aX9fLJG9YHiTVEWna
         +KlSyK0jkVckAXXzPPe39JafLdZS1N58vUGnSUtZKupBndmrfJUbdbjrHyc4LxkkDH11
         j4hvH6Bmo3UYB4nJ25j5b0ayaOY/ZkXUF1aKURGcHh3dsKquiZq6lvCy2+qRDhLCI5yy
         lK3rtCBRG2QynjOJBvHTEhknqciSzUXr/wrbNG4WFexawyEknPOvq1cVGcn1yrti+yDB
         X2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ElhOma4gQ0OPfIjSUT22cb9hvoULnOkjRgU5fDqO5Dg=;
        b=emkrKPbV/nJRMmcmDRRGGrT/638f1s2b7UquXYjJgmbqItmVoioCZHZXUCjAC/1vss
         NdMe+ILNj/SQJO2RZojmJbw27I73Ync55SBoqEWhswN0AVWGcdcYlFFXqNCZMqbdaIfF
         3MiJaE79CDWpTsgsY8DU6kQmA/7P2K9WQljw4YXVhaqe44l+RDNHrV2qmCjGzczvhMUm
         krt+wO8LA9hWyd34BgOV1kaovPXj+ZM/2f0cwqXzkD9WwKGwY9zedepi9R1VqZj3v3lD
         bZA7ZcpRqwxR0dw0pYhm6Lv9pnuCd1bV8XKkbvWkDwvOFxH4jq+h5xm57J0qy4TNTy9h
         Rtjg==
X-Gm-Message-State: AOAM530IBWce5e9bG+mq0Hl3vh/7LyrnBwXj2yqbmf/Btw4gvmkqqJu7
        k3mY+DoWmKJcCcflyiVdKgPW/lw=
X-Google-Smtp-Source: ABdhPJy85YW8JFPMFPvtrXCPq1/krJyL+LUXfqnfj0YU0WjOLN687+DjQbt70rUNaEOIfnzSFib2T6o=
X-Received: by 2002:a0c:ecc6:: with SMTP id o6mr5106743qvq.243.1592355858412;
 Tue, 16 Jun 2020 18:04:18 -0700 (PDT)
Date:   Tue, 16 Jun 2020 18:04:14 -0700
Message-Id: <20200617010416.93086-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH bpf v5 1/3] bpf: don't return EINVAL from {get,set}sockopt
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

For such optvals we expose only the first PAGE_SIZE bytes to
the BPF program. BPF program has two options:
1. Set ctx->optlen to 0 to indicate that the BPF's optval
   should be ignored and the kernel should use original userspace
   value.
2. Set ctx->optlen to something that's smaller than the PAGE_SIZE.

v5:
* use ctx->optlen == 0 with trimmed buffer (Alexei Starovoitov)
* update the docs accordingly

v4:
* use temporary buffer to avoid optval == optval_end == NULL;
  this removes the corner case in the verifier that might assume
  non-zero PTR_TO_PACKET/PTR_TO_PACKET_END.

v3:
* don't increase the limit, bypass the argument

v2:
* proper comments formatting (Jakub Kicinski)

Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
Cc: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/cgroup.c | 53 ++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 4d76f16524cc..ac53102e244a 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1276,16 +1276,23 @@ static bool __cgroup_bpf_prog_array_is_empty(struct cgroup *cgrp,
 
 static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen)
 {
-	if (unlikely(max_optlen > PAGE_SIZE) || max_optlen < 0)
+	if (unlikely(max_optlen < 0))
 		return -EINVAL;
 
+	if (unlikely(max_optlen > PAGE_SIZE)) {
+		/* We don't expose optvals that are greater than PAGE_SIZE
+		 * to the BPF program.
+		 */
+		max_optlen = PAGE_SIZE;
+	}
+
 	ctx->optval = kzalloc(max_optlen, GFP_USER);
 	if (!ctx->optval)
 		return -ENOMEM;
 
 	ctx->optval_end = ctx->optval + max_optlen;
 
-	return 0;
+	return max_optlen;
 }
 
 static void sockopt_free_buf(struct bpf_sockopt_kern *ctx)
@@ -1319,13 +1326,13 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 	 */
 	max_optlen = max_t(int, 16, *optlen);
 
-	ret = sockopt_alloc_buf(&ctx, max_optlen);
-	if (ret)
-		return ret;
+	max_optlen = sockopt_alloc_buf(&ctx, max_optlen);
+	if (max_optlen < 0)
+		return max_optlen;
 
 	ctx.optlen = *optlen;
 
-	if (copy_from_user(ctx.optval, optval, *optlen) != 0) {
+	if (copy_from_user(ctx.optval, optval, min(*optlen, max_optlen)) != 0) {
 		ret = -EFAULT;
 		goto out;
 	}
@@ -1353,8 +1360,14 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 		/* export any potential modifications */
 		*level = ctx.level;
 		*optname = ctx.optname;
-		*optlen = ctx.optlen;
-		*kernel_optval = ctx.optval;
+
+		/* optlen == 0 from BPF indicates that we should
+		 * use original userspace data.
+		 */
+		if (ctx.optlen != 0) {
+			*optlen = ctx.optlen;
+			*kernel_optval = ctx.optval;
+		}
 	}
 
 out:
@@ -1385,12 +1398,12 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 	    __cgroup_bpf_prog_array_is_empty(cgrp, BPF_CGROUP_GETSOCKOPT))
 		return retval;
 
-	ret = sockopt_alloc_buf(&ctx, max_optlen);
-	if (ret)
-		return ret;
-
 	ctx.optlen = max_optlen;
 
+	max_optlen = sockopt_alloc_buf(&ctx, max_optlen);
+	if (max_optlen < 0)
+		return max_optlen;
+
 	if (!retval) {
 		/* If kernel getsockopt finished successfully,
 		 * copy whatever was returned to the user back
@@ -1404,10 +1417,8 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 			goto out;
 		}
 
-		if (ctx.optlen > max_optlen)
-			ctx.optlen = max_optlen;
-
-		if (copy_from_user(ctx.optval, optval, ctx.optlen) != 0) {
+		if (copy_from_user(ctx.optval, optval,
+				   min(ctx.optlen, max_optlen)) != 0) {
 			ret = -EFAULT;
 			goto out;
 		}
@@ -1436,10 +1447,12 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 		goto out;
 	}
 
-	if (copy_to_user(optval, ctx.optval, ctx.optlen) ||
-	    put_user(ctx.optlen, optlen)) {
-		ret = -EFAULT;
-		goto out;
+	if (ctx.optlen != 0) {
+		if (copy_to_user(optval, ctx.optval, ctx.optlen) ||
+		    put_user(ctx.optlen, optlen)) {
+			ret = -EFAULT;
+			goto out;
+		}
 	}
 
 	ret = ctx.retval;
-- 
2.27.0.290.gba653c62da-goog

