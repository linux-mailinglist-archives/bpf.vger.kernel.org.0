Return-Path: <bpf+bounces-9628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237D279A744
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 12:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1161280E58
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 10:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5429CA50;
	Mon, 11 Sep 2023 10:34:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF23DC8EC;
	Mon, 11 Sep 2023 10:34:29 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756B2120;
	Mon, 11 Sep 2023 03:34:28 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so5488894a12.0;
        Mon, 11 Sep 2023 03:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694428467; x=1695033267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ujfJhkimEBB7gW4ff70lMG+yADCN0IfcVu3/Eyewto=;
        b=MMTvtf8YYQd5jGULJ1yBilRT5CHVXOvgKRfm4XTxCIRGkIryXUwq9a1Xb6LlBd74UZ
         jRmZRE+d+TB8tbz6VKVxiG/dJpGxMrSnvgKSyDJR+F4Z0nlKVA2ex7vz8+xxPStxoHWH
         /xvRiYwzPy/Ja96dCGsT0oimDCwdY9OGv59fHQFeHnEPtRta8AR+zSL/1LbmLX+4T2yY
         bur2BfUIZiJriOCgzMU5TAtoYH0A7R10zHzWDFuUSNpSAMlmRWrtdQEAd5MgKnRR3wR/
         Ws3kL6wCHR71hMetsUZUpMSk27N82y436sfmNAVTM+qty2U5vVI9iaxdCrg2YVJRVXiW
         JkPg==
X-Gm-Message-State: AOJu0YwYlowzcSMnrqDxn7tLD3OAQqPeoUWkx1olZrqZ04BFA3bHigz4
	pFPY1cOgncGQt8a9a75pSqQ=
X-Google-Smtp-Source: AGHT+IFgqvgl2kKf5wXnPlEooghToR0kbGjlDmUphoNIhjVsopE7IbhA/Lw/vCqqVTfyMvOzztk+tw==
X-Received: by 2002:a17:906:1044:b0:9a1:be5b:f499 with SMTP id j4-20020a170906104400b009a1be5bf499mr8518795ejj.24.1694428466671;
        Mon, 11 Sep 2023 03:34:26 -0700 (PDT)
Received: from localhost (fwdproxy-cln-012.fbsv.net. [2a03:2880:31ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id j1-20020a170906410100b0099bd1ce18fesm5200279ejk.10.2023.09.11.03.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 03:34:26 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: sdf@google.com,
	axboe@kernel.dk,
	asml.silence@gmail.com,
	willemdebruijn.kernel@gmail.com,
	kuba@kernel.org,
	martin.lau@linux.dev,
	krisman@suse.de,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH v5 2/8] net/socket: Break down __sys_getsockopt
Date: Mon, 11 Sep 2023 03:34:01 -0700
Message-Id: <20230911103407.1393149-3-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911103407.1393149-1-leitao@debian.org>
References: <20230911103407.1393149-1-leitao@debian.org>
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

Split __sys_getsockopt() into two functions by removing the core
logic into a sub-function (do_sock_getsockopt()). This will avoid
code duplication when executing the same operation in other callers, for
instance.

do_sock_getsockopt() will be called by io_uring getsockopt() command
operation in the following patch.

Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/net/sock.h |  3 +++
 net/socket.c       | 51 ++++++++++++++++++++++++++++------------------
 2 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index aa8fb54ad0af..fbd568a43d28 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1863,6 +1863,9 @@ int sock_setsockopt(struct socket *sock, int level, int op,
 		    sockptr_t optval, unsigned int optlen);
 int do_sock_setsockopt(struct socket *sock, bool compat, int level,
 		       int optname, char __user *user_optval, int optlen);
+int do_sock_getsockopt(struct socket *sock, bool compat, int level,
+		       int optname, char __user *user_optval,
+		       int __user *user_optlen);
 
 int sk_getsockopt(struct sock *sk, int level, int optname,
 		  sockptr_t optval, sockptr_t optlen);
diff --git a/net/socket.c b/net/socket.c
index 360332e098d4..3ec779a56f79 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2333,28 +2333,17 @@ SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
 INDIRECT_CALLABLE_DECLARE(bool tcp_bpf_bypass_getsockopt(int level,
 							 int optname));
 
-/*
- *	Get a socket option. Because we don't know the option lengths we have
- *	to pass a user mode parameter for the protocols to sort out.
- */
-int __sys_getsockopt(int fd, int level, int optname, char __user *optval,
-		int __user *optlen)
+int do_sock_getsockopt(struct socket *sock, bool compat, int level,
+		       int optname, char __user *optval,
+		       int __user *optlen)
 {
 	int max_optlen __maybe_unused;
 	const struct proto_ops *ops;
-	int err, fput_needed;
-	struct socket *sock;
-
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (!sock)
-		return err;
+	int err;
 
 	err = security_socket_getsockopt(sock, level, optname);
 	if (err)
-		goto out_put;
-
-	if (!in_compat_syscall())
-		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
+		return err;
 
 	ops = READ_ONCE(sock->ops);
 	if (level == SOL_SOCKET)
@@ -2362,14 +2351,36 @@ int __sys_getsockopt(int fd, int level, int optname, char __user *optval,
 	else if (unlikely(!ops->getsockopt))
 		err = -EOPNOTSUPP;
 	else
-		err = ops->getsockopt(sock, level, optname, optval,
-					    optlen);
+		err = ops->getsockopt(sock, level, optname, optval, optlen);
 
-	if (!in_compat_syscall())
+	if (!compat) {
+		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
 		err = BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level, optname,
 						     optval, optlen, max_optlen,
 						     err);
-out_put:
+	}
+
+	return err;
+}
+EXPORT_SYMBOL(do_sock_getsockopt);
+
+/*	Get a socket option. Because we don't know the option lengths we have
+ *	to pass a user mode parameter for the protocols to sort out.
+ */
+int __sys_getsockopt(int fd, int level, int optname, char __user *optval,
+		     int __user *optlen)
+{
+	int err, fput_needed;
+	bool compat = in_compat_syscall();
+	struct socket *sock;
+
+	sock = sockfd_lookup_light(fd, &err, &fput_needed);
+	if (!sock)
+		return err;
+
+	err = do_sock_getsockopt(sock, compat, level, optname, optval,
+				 optlen);
+
 	fput_light(sock->file, fput_needed);
 	return err;
 }
-- 
2.34.1


