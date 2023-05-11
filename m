Return-Path: <bpf+bounces-356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E896FF80B
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 19:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34FB31C20FB7
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 17:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A2E6FD3;
	Thu, 11 May 2023 17:05:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA806D18
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 17:05:10 +0000 (UTC)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594315FE9
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 10:05:00 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-24deb9c5f8dso4742129a91.0
        for <bpf@vger.kernel.org>; Thu, 11 May 2023 10:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683824700; x=1686416700;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U9qI0nq5QzBcYkUt0DhCTgiaghbG11tcfglp9KLW4s0=;
        b=zNVy0KqPzsX2OKiHgwZk0irELk30K8d4qWgUgvXx232s0FF+4ZgvKlZHpgI07bZxaz
         piGJFoFiYui/Oi1ERZCguSUQdPePjl/fH+JCeCwMHrN783qOX2l+zR6ZsVpkKl2TY6/K
         nruz8Y1f1e0du8yY/q6PdmwQS8R2XtosMuCZEi24ITWF35l+/gKycwMQ4+gOcy+LQTmt
         hLtMbd0QZAMUXYf5mwDEaeD02nd2FMjz9Y+4gvNxzJ6vQa/4G4fuBllVjTo43mymA4gV
         92XNL9bPgRIXsF89JNMBxgIZITDczZf7/oyQexoWe/EgWFvK1OsyOMNOXgI7dS4UitQf
         6mUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683824700; x=1686416700;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9qI0nq5QzBcYkUt0DhCTgiaghbG11tcfglp9KLW4s0=;
        b=NH4sJfD/0XVeHYfVHGBm2lRu6LwknFMFpekS4h+zotSMPCpgFxNxzbWGKjpvRHHFu+
         mEqPUXpJ7FcutmLkjN5xpV5sMXWgx2uppWra1pwSeKHqoX6PFmS2jF3xMuTPcD8LMQuB
         JlFa/tdsML0yFT6j+NFCsQue+wLDCZ4VkvZ2A+e2matW5AycKvCHA8YXI1+xsL8b8ob/
         CIgpzsJylIvy680HdNcFZHbzfgU8pnIQrb2j8QGir4pt68K5vPC6ArFZhMHNEjFpDXeM
         AdYwebAYqZ9aewaNHGKqFcPY7lT2UPoHAesiWqAMxTQYGOtLl5Chc7MPEUaQgiVjSbJk
         JsCw==
X-Gm-Message-State: AC+VfDx3ioGOjynAeCGwoNGIPrH2VkKEkNlXkWoTLhq5q0PCQs54icJ4
	BGxea9Gq012bsOlkxCjv7Y3l+T+ziUFfrBA/nhd0BycOrp6iR/Jb7MBCSm8qtcCU0elPi2x31ek
	pfYHfPGuugreFK+Q1C5uQSfYlf6QVUuC9cFFJRUCdpU6fyfXuCg==
X-Google-Smtp-Source: ACHHUZ5jJGwDSNfUnKgGmzAAYeYrU+SfNpsVQXPj3HFWPNjbxwQJPfPPeKjwUBpcBvWoG5LjDc5acBU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:120a:b0:24d:efc3:38d2 with SMTP id
 gl10-20020a17090b120a00b0024defc338d2mr6788850pjb.8.1683824699749; Thu, 11
 May 2023 10:04:59 -0700 (PDT)
Date: Thu, 11 May 2023 10:04:53 -0700
In-Reply-To: <20230511170456.1759459-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230511170456.1759459-1-sdf@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230511170456.1759459-2-sdf@google.com>
Subject: [PATCH bpf-next v6 1/4] bpf: Don't EFAULT for {g,s}setsockopt with
 wrong optlen
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

With the way the hooks implemented right now, we have a special
condition: optval larger than PAGE_SIZE will expose only first 4k into
BPF; any modifications to the optval are ignored. If the BPF program
doesn't handle this condition by resetting optlen to 0,
the userspace will get EFAULT.

The intention of the EFAULT was to make it apparent to the
developers that the program is doing something wrong.
However, this inadvertently might affect production workloads
with the BPF programs that are not too careful (i.e., returning EFAULT
for perfectly valid setsockopt/getsockopt calls).

Let's try to minimize the chance of BPF program screwing up userspace
by ignoring the output of those BPF programs (instead of returning
EFAULT to the userspace). pr_info_once those cases to
the dmesg to help with figuring out what's going wrong.

Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/cgroup.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index a06e118a9be5..14c870595428 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1826,6 +1826,12 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 		ret = 1;
 	} else if (ctx.optlen > max_optlen || ctx.optlen < -1) {
 		/* optlen is out of bounds */
+		if (*optlen > PAGE_SIZE && ctx.optlen >= 0) {
+			pr_info_once("bpf setsockopt: ignoring program buffer with optlen=%d (max_optlen=%d)\n",
+				     ctx.optlen, max_optlen);
+			ret = 0;
+			goto out;
+		}
 		ret = -EFAULT;
 	} else {
 		/* optlen within bounds, run kernel handler */
@@ -1881,8 +1887,10 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 		.optname = optname,
 		.current_task = current,
 	};
+	int orig_optlen;
 	int ret;
 
+	orig_optlen = max_optlen;
 	ctx.optlen = max_optlen;
 	max_optlen = sockopt_alloc_buf(&ctx, max_optlen, &buf);
 	if (max_optlen < 0)
@@ -1905,6 +1913,7 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 			ret = -EFAULT;
 			goto out;
 		}
+		orig_optlen = ctx.optlen;
 
 		if (copy_from_user(ctx.optval, optval,
 				   min(ctx.optlen, max_optlen)) != 0) {
@@ -1922,6 +1931,12 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 		goto out;
 
 	if (optval && (ctx.optlen > max_optlen || ctx.optlen < 0)) {
+		if (orig_optlen > PAGE_SIZE && ctx.optlen >= 0) {
+			pr_info_once("bpf getsockopt: ignoring program buffer with optlen=%d (max_optlen=%d)\n",
+				     ctx.optlen, max_optlen);
+			ret = retval;
+			goto out;
+		}
 		ret = -EFAULT;
 		goto out;
 	}
-- 
2.40.1.521.gf1e218fcd8-goog


