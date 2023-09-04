Return-Path: <bpf+bounces-9206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56426791B82
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 18:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC6D1C2087C
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 16:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FFAC8D5;
	Mon,  4 Sep 2023 16:25:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F97C2F2;
	Mon,  4 Sep 2023 16:25:24 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60E1184;
	Mon,  4 Sep 2023 09:25:22 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9a1de3417acso542923866b.0;
        Mon, 04 Sep 2023 09:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693844721; x=1694449521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqiuOvcv1MccJsjW00UyaCQ3aIlm0yVUcGJFzbQK0k8=;
        b=j0Zc2yWMEWuQVAF8/c7sbXl0R+QsdqnFLu0YC+NUOxhRwlVwfM+D2DMksAaGOt7W/D
         tE1y0dZapcCj5QpxYZ0vcygtCeDI90erIdoN6E5QmtWrB+AbZILzi/g0ecL8FOSTjo+p
         9HoqCSmu/lffm9ezgoZQns0M4VQHVgTIkm2EYjkQHkYm6vADfL/dsAIYZKeNgUOwfTQG
         q/z771EibTJ6R4/A+jJXV/PnmqFOJq5jm9qnqjQIVIt+pgLgIvyGMw0U3JZMC+1QGmiL
         RrMKn3CoUVQcudq1Rfm5qL7kuYIr8hcGhDILSAxLxtXU/E9hkfwKq1/MS1+GkJSjRwTG
         JLrg==
X-Gm-Message-State: AOJu0YxVO9Pjz6oSrqeslR9ofLA4ILPVZl63fsZ9/ATVczWOU24HVG4W
	UALkQWV60ipLzueOpNO1plU=
X-Google-Smtp-Source: AGHT+IE0zM3MHfyNsy+4bdBdNbhQGTTsTad6iANbAQA59NTlTt3uDAD/ahrt4Yvh54VN9iK5ejR7ug==
X-Received: by 2002:a17:907:72c9:b0:9a5:b247:3ab with SMTP id du9-20020a17090772c900b009a5b24703abmr15234852ejc.19.1693844721093;
        Mon, 04 Sep 2023 09:25:21 -0700 (PDT)
Received: from localhost (fwdproxy-cln-023.fbsv.net. [2a03:2880:31ff:17::face:b00c])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906248700b009920a690cd9sm6356382ejb.59.2023.09.04.09.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 09:25:20 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: sdf@google.com,
	axboe@kernel.dk,
	asml.silence@gmail.com,
	willemdebruijn.kernel@gmail.com,
	martin.lau@linux.dev,
	krisman@suse.de,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH v4 01/10] bpf: Leverage sockptr_t in BPF getsockopt hook
Date: Mon,  4 Sep 2023 09:24:54 -0700
Message-Id: <20230904162504.1356068-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230904162504.1356068-1-leitao@debian.org>
References: <20230904162504.1356068-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Leverage sockptr_t structure to pass universal pointer as argument, that
holds either a userspace pointer, or, a kernel pointer.

This makes this function flexible, so, we can mix and match user and
kernel space pointers. The main motivation for this change is to use it
in the io_uring {g,s}etsockopt(), which will use a userspace pointer for
*optval, but, a kernel value for optlen.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/bpf-cgroup.h |  5 +++--
 kernel/bpf/cgroup.c        | 20 +++++++++++---------
 net/socket.c               |  5 +++--
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 8506690dbb9c..f5b4fb6ed8c6 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -139,9 +139,10 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 int __cgroup_bpf_run_filter_setsockopt(struct sock *sock, int *level,
 				       int *optname, char __user *optval,
 				       int *optlen, char **kernel_optval);
+
 int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
-				       int optname, char __user *optval,
-				       int __user *optlen, int max_optlen,
+				       int optname, sockptr_t optval,
+				       sockptr_t optlen, int max_optlen,
 				       int retval);
 
 int __cgroup_bpf_run_filter_getsockopt_kern(struct sock *sk, int level,
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 5b2741aa0d9b..ebc8c58f7e46 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1875,8 +1875,8 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 }
 
 int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
-				       int optname, char __user *optval,
-				       int __user *optlen, int max_optlen,
+				       int optname, sockptr_t optval,
+				       sockptr_t optlen, int max_optlen,
 				       int retval)
 {
 	struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
@@ -1903,8 +1903,8 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 		 * one that kernel returned as well to let
 		 * BPF programs inspect the value.
 		 */
-
-		if (get_user(ctx.optlen, optlen)) {
+		if (copy_from_sockptr(&ctx.optlen, optlen,
+				      sizeof(ctx.optlen))) {
 			ret = -EFAULT;
 			goto out;
 		}
@@ -1915,8 +1915,8 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 		}
 		orig_optlen = ctx.optlen;
 
-		if (copy_from_user(ctx.optval, optval,
-				   min(ctx.optlen, max_optlen)) != 0) {
+		if (copy_from_sockptr(ctx.optval, optval,
+				      min(ctx.optlen, max_optlen))) {
 			ret = -EFAULT;
 			goto out;
 		}
@@ -1930,7 +1930,8 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 	if (ret < 0)
 		goto out;
 
-	if (optval && (ctx.optlen > max_optlen || ctx.optlen < 0)) {
+	if (!sockptr_is_null(optval) &&
+	    (ctx.optlen > max_optlen || ctx.optlen < 0)) {
 		if (orig_optlen > PAGE_SIZE && ctx.optlen >= 0) {
 			pr_info_once("bpf getsockopt: ignoring program buffer with optlen=%d (max_optlen=%d)\n",
 				     ctx.optlen, max_optlen);
@@ -1942,11 +1943,12 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 	}
 
 	if (ctx.optlen != 0) {
-		if (optval && copy_to_user(optval, ctx.optval, ctx.optlen)) {
+		if (!sockptr_is_null(optval) &&
+		    copy_to_sockptr(optval, ctx.optval, ctx.optlen)) {
 			ret = -EFAULT;
 			goto out;
 		}
-		if (put_user(ctx.optlen, optlen)) {
+		if (copy_to_sockptr(optlen, &ctx.optlen, sizeof(ctx.optlen))) {
 			ret = -EFAULT;
 			goto out;
 		}
diff --git a/net/socket.c b/net/socket.c
index 77f28328e387..6fda5d011521 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2355,8 +2355,9 @@ int __sys_getsockopt(int fd, int level, int optname, char __user *optval,
 
 	if (!in_compat_syscall())
 		err = BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level, optname,
-						     optval, optlen, max_optlen,
-						     err);
+						     USER_SOCKPTR(optval),
+						     USER_SOCKPTR(optlen),
+						     max_optlen, err);
 out_put:
 	fput_light(sock->file, fput_needed);
 	return err;
-- 
2.34.1


