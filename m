Return-Path: <bpf+bounces-7984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3C777F9F0
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 16:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111171C2141E
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 14:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDF415483;
	Thu, 17 Aug 2023 14:56:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B0B14F7A;
	Thu, 17 Aug 2023 14:56:33 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD252D7E;
	Thu, 17 Aug 2023 07:56:12 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so124572461fa.3;
        Thu, 17 Aug 2023 07:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692284170; x=1692888970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFl0K4oWgy7f8a4WXCtEXv199RlbPY7g5Pt61qAlA0w=;
        b=clnhMBMHs4F1Q/7DyAg+V97bO7bjVayc2QUyCve9zkuryEbXNssfan6aerpkiuFrjM
         n6/jao9OhExrIJUQI6Nh6epANWgmQoo0vHjCbs8bzSI3v0MOSsC+SAZ7Vy5hBbzz5sU1
         3TE3i31AoC5xx54YbX6SYRz1m6lrGZpwJnpmoRJilrU5aNKX6dx8LxVVG4thj/a1bXN9
         nDvuAB5Zy0uQ1bn1Zm1UiwrjvnM73n+VAfiut2C/64LnC0KfCMISGEib2pqdVDa3z2SN
         jBK1/842KAmx+E3jAH1k2lj3y5rJvIETS9+3nCHN0xmbZ/srLyNZ5LgwCJqszc9mfwBF
         29lA==
X-Gm-Message-State: AOJu0Yzu9qkcNguUom+mQWdjUlnPAVga5CFLB+xvI4hzFsd5kpFtOmly
	iP1HY3pex2yLquWuAn71Kwc=
X-Google-Smtp-Source: AGHT+IEStrqnxtqy79a9E7YYqT+ceFg5PifcaufTfDZmHhEIH8Vsz9l4pM67f5gocI4p4ngLu1Wa7g==
X-Received: by 2002:a2e:7a07:0:b0:2b6:cad9:75ba with SMTP id v7-20020a2e7a07000000b002b6cad975bamr4402075ljc.29.1692284170410;
        Thu, 17 Aug 2023 07:56:10 -0700 (PDT)
Received: from localhost (fwdproxy-cln-017.fbsv.net. [2a03:2880:31ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906b30d00b0099b4d86fbccsm10370998ejz.141.2023.08.17.07.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:56:10 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: sdf@google.com,
	axboe@kernel.dk,
	asml.silence@gmail.com,
	willemdebruijn.kernel@gmail.com,
	martin.lau@linux.dev,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
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
	io-uring@vger.kernel.org,
	krisman@suse.de
Subject: [PATCH v3 2/9] bpf: Leverage sockptr_t in BPF setsockopt hook
Date: Thu, 17 Aug 2023 07:55:47 -0700
Message-Id: <20230817145554.892543-3-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817145554.892543-1-leitao@debian.org>
References: <20230817145554.892543-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Change BPF setsockopt hook (__cgroup_bpf_run_filter_setsockopt()) to use
sockptr instead of user pointers. This brings flexibility to the
function, since it could be called with userspace or kernel pointers.

This change will allow the creation of a core sock_setsockopt, called
do_sock_setsockopt(), which will be called from both the system call path
and by io_uring command.

This also aligns with the getsockopt() counterpart, which is now using
sockptr_t types.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/bpf-cgroup.h | 2 +-
 kernel/bpf/cgroup.c        | 5 +++--
 net/socket.c               | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index d16cb99fd4f1..5e3419eb267a 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -137,7 +137,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 				   enum cgroup_bpf_attach_type atype);
 
 int __cgroup_bpf_run_filter_setsockopt(struct sock *sock, int *level,
-				       int *optname, char __user *optval,
+				       int *optname, sockptr_t optval,
 				       int *optlen, char **kernel_optval);
 
 int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index ebc8c58f7e46..f0dedd4f7f2e 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1785,7 +1785,7 @@ static bool sockopt_buf_allocated(struct bpf_sockopt_kern *ctx,
 }
 
 int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
-				       int *optname, char __user *optval,
+				       int *optname, sockptr_t optval,
 				       int *optlen, char **kernel_optval)
 {
 	struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
@@ -1808,7 +1808,8 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 
 	ctx.optlen = *optlen;
 
-	if (copy_from_user(ctx.optval, optval, min(*optlen, max_optlen)) != 0) {
+	if (copy_from_sockptr(ctx.optval, optval,
+			      min(*optlen, max_optlen))) {
 		ret = -EFAULT;
 		goto out;
 	}
diff --git a/net/socket.c b/net/socket.c
index 33ea5eb91ade..2c3ef8862b4f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2246,7 +2246,7 @@ int __sys_setsockopt(int fd, int level, int optname, char __user *user_optval,
 
 	if (!in_compat_syscall())
 		err = BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock->sk, &level, &optname,
-						     user_optval, &optlen,
+						     optval, &optlen,
 						     &kernel_optval);
 	if (err < 0)
 		goto out_put;
-- 
2.34.1


