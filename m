Return-Path: <bpf+bounces-9921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B41E79ECED
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 17:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D041C20E15
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 15:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FE71F92E;
	Wed, 13 Sep 2023 15:28:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2074A934;
	Wed, 13 Sep 2023 15:28:20 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E47CCD;
	Wed, 13 Sep 2023 08:28:20 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-99c1d03e124so867744766b.2;
        Wed, 13 Sep 2023 08:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694618898; x=1695223698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T63D+iseOM6feL2ViRPYbx+xbxxkgrRy6waBaJFXQkc=;
        b=r0JDYjI2cbC89op4ypM56Lucvd/o0QrOrjFCoOnwuqf8paPw/YaaiOg8jA2FapF+if
         fj3In3b+UnWOv8v7TV+aBpzoTp1fJpqV2QHyzlNlG2WKF7aH1d6VSkWVmemIQ8DacD9m
         hTQu0q392R1rMW/9VdsjcHBz6sit7O3KiqZ/pnWWIbG8SNWB+lhKOjE67FXZlHaZhlQi
         6YmM4ZJuz//WH3I5bi8TZU2BAnlfyZGOFSIYK8NlJUfVHnowMBoLUDXnJ1GfaoADrzzt
         lVsLLRM9NhAbvamcKoRlgwSUo3j5vo2yfwIP/JJ0nKYPC4gTfog/rzNls1AhhpNw6K43
         JVQw==
X-Gm-Message-State: AOJu0YyFS9csFcf4pGBzrEtRzuU6y2SXU5qlpsw5Wub/vn5ZXULjkwgG
	nzY0IURLNW4KzrtAhizhITGiTCHK0zM=
X-Google-Smtp-Source: AGHT+IEMs9Boxfcw7qVlzVFEDeHVNXCAKXZD3Rz3ajV1O+cGsEythgRouzjpDE/rwGV0COfj4t+aeg==
X-Received: by 2002:a17:906:18aa:b0:9a5:d83a:65be with SMTP id c10-20020a17090618aa00b009a5d83a65bemr2303502ejf.27.1694618898511;
        Wed, 13 Sep 2023 08:28:18 -0700 (PDT)
Received: from localhost (fwdproxy-cln-005.fbsv.net. [2a03:2880:31ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709064f0e00b0099e05fb8f95sm8647352eju.137.2023.09.13.08.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 08:28:18 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: sdf@google.com,
	axboe@kernel.dk,
	asml.silence@gmail.com,
	willemdebruijn.kernel@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	martin.lau@linux.dev,
	krisman@suse.de,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	io-uring@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH v6 1/8] net/socket: Break down __sys_setsockopt
Date: Wed, 13 Sep 2023 08:27:37 -0700
Message-Id: <20230913152744.2333228-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913152744.2333228-1-leitao@debian.org>
References: <20230913152744.2333228-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split __sys_setsockopt() into two functions by removing the core
logic into a sub-function (do_sock_setsockopt()). This will avoid
code duplication when doing the same operation in other callers, for
instance.

do_sock_setsockopt() will be called by io_uring setsockopt() command
operation in the following patch.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/net/sock.h |  2 ++
 net/socket.c       | 38 +++++++++++++++++++++++++-------------
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 11d503417591..aa8fb54ad0af 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1861,6 +1861,8 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		  sockptr_t optval, unsigned int optlen);
 int sock_setsockopt(struct socket *sock, int level, int op,
 		    sockptr_t optval, unsigned int optlen);
+int do_sock_setsockopt(struct socket *sock, bool compat, int level,
+		       int optname, char __user *user_optval, int optlen);
 
 int sk_getsockopt(struct sock *sk, int level, int optname,
 		  sockptr_t optval, sockptr_t optlen);
diff --git a/net/socket.c b/net/socket.c
index 77f28328e387..360332e098d4 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2261,31 +2261,22 @@ static bool sock_use_custom_sol_socket(const struct socket *sock)
 	return test_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
 }
 
-/*
- *	Set a socket option. Because we don't know the option lengths we have
- *	to pass the user mode parameter for the protocols to sort out.
- */
-int __sys_setsockopt(int fd, int level, int optname, char __user *user_optval,
-		int optlen)
+int do_sock_setsockopt(struct socket *sock, bool compat, int level,
+		       int optname, char __user *user_optval, int optlen)
 {
 	sockptr_t optval = USER_SOCKPTR(user_optval);
 	const struct proto_ops *ops;
 	char *kernel_optval = NULL;
-	int err, fput_needed;
-	struct socket *sock;
+	int err;
 
 	if (optlen < 0)
 		return -EINVAL;
 
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (!sock)
-		return err;
-
 	err = security_socket_setsockopt(sock, level, optname);
 	if (err)
 		goto out_put;
 
-	if (!in_compat_syscall())
+	if (!compat)
 		err = BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock->sk, &level, &optname,
 						     user_optval, &optlen,
 						     &kernel_optval);
@@ -2308,6 +2299,27 @@ int __sys_setsockopt(int fd, int level, int optname, char __user *user_optval,
 					    optlen);
 	kfree(kernel_optval);
 out_put:
+	return err;
+}
+EXPORT_SYMBOL(do_sock_setsockopt);
+
+/* Set a socket option. Because we don't know the option lengths we have
+ * to pass the user mode parameter for the protocols to sort out.
+ */
+int __sys_setsockopt(int fd, int level, int optname, char __user *user_optval,
+		     int optlen)
+{
+	bool compat = in_compat_syscall();
+	int err, fput_needed;
+	struct socket *sock;
+
+	sock = sockfd_lookup_light(fd, &err, &fput_needed);
+	if (!sock)
+		return err;
+
+	err = do_sock_setsockopt(sock, compat, level, optname, user_optval,
+				 optlen);
+
 	fput_light(sock->file, fput_needed);
 	return err;
 }
-- 
2.34.1


