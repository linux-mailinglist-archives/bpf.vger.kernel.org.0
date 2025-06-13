Return-Path: <bpf+bounces-60637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3660AD9829
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 00:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530334A1611
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 22:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3631F28F508;
	Fri, 13 Jun 2025 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hsy1/O29"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3E628ECC4;
	Fri, 13 Jun 2025 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749853462; cv=none; b=NmY+kXT0cWQSzyuCwXhOu5+COnKq1IDy7m1Id3HXoYozMuOnDFqnxv64MRh2zOPalyOdl1xqlghvYhP3WPIzMUiK51jYvQQibDxhLRPABh1k0UEZdohNH2m2PJ9ddsWtf0yhHN3a6W2rSCgCRSzvCc+cQjRnpEVSHFc8lKHGlp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749853462; c=relaxed/simple;
	bh=nBZvv9YjD99jE24PM8GYGHOSPan+H6HVWMLG3CdlAA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cw5QuNkpMmSziGQyw77YnNoBjT6LwdshXwrEcodaslKRZ2dmO7+N10ppMEIlJ+a/GPnlizX3VRErXKW8aG9C/7vx6JGt7MJ9fD/wjMlrgjvzNiSESZXYwKi0JEULBEiNKfAkrQ7+wK4jHyPemsWALBCviGeVnQZg0w4nk7D6vsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hsy1/O29; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23633a6ac50so36170455ad.2;
        Fri, 13 Jun 2025 15:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749853460; x=1750458260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKNpjyc1xE0nzBze2xYabJz4HvmtYV1r0HJZZihZbsA=;
        b=Hsy1/O29pQ8B/QgdSs5VjQFMjnBboUwzBTDsy6S5xqtUMHEDHqUZ9mNJYRS6+QwPHv
         uyQMKEUXfDG79Wumfttq+9pOZcrzOQilYJQ8zoClhQ4YDLNv5NxbRlV1S2c++POUO0j2
         +CJrHqN1HtYF+EHQjJlA4qIonlnD6JTPxtykB9pUq3j0U9Y9DpyvtFwmNaqmIdlF9kgU
         RRygB6MvQgTV1KL2fI3p7EyAt5uZFUxxOudx4vFd3vhiWrb0KY53Wl2v9EYrOabgYzkp
         OJXVnoR6TsDGmMbbgI/vPZsMd0ccUPYob7M516DSCtRTighfe0z/QkrchuZoAhHJ+TvJ
         pLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749853460; x=1750458260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKNpjyc1xE0nzBze2xYabJz4HvmtYV1r0HJZZihZbsA=;
        b=v7P8nu1syBLiDx/6lKoXS+hlbYVVAaVO+beu3iar9DBnYzairP9fNP/NiybrfyYWCC
         lwZ9Tb52eEhPwok+p6I0BotU/ryExPuLjcE0REUllj+TGlA5WxgmdppDuTGHSCgYiz+p
         kJIBKh0EbP6sPBeBjWT4KeEGdQyMX9d963Gsigz+oWu8GPtQF+Sgh45QINcsuSCoH/+F
         a22sbe7e7xenSv/+mx0ZzDght24yb9lTGe1luka6V2Um8GDURpUZZcP4LoXiMiNI0LkX
         ESJCvQDDJgmW7L87j4cmlYoo8WB6IpJgtIgriiXhJYFOpGNBcvjPqlCQWCpm8wW3qs/6
         k5nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWEnQXJ9a98U9A1+QS8JBK690ccr2PiOGh2Nsm1973hF9N2aAF2aAPrmT97WZtGvKyiug=@vger.kernel.org, AJvYcCUzQy3/odLXtOc9M2iO0t7GmfpUef0JEtu3GaNpLPQeD08tqlg+P8idxMcqkquw9CHwtiVozPmf@vger.kernel.org, AJvYcCV2QgRxX46t/qJHI/5gt+EvsqPfpxt6HsXEyLs7hc5RPY7fhMt5k8UDMegLMe2ScOs4/IoygI/5Njv8pdmfPy/cVbSvWqb7@vger.kernel.org, AJvYcCXTsm6dS0h0hoyEnwEP28pPq/Fqg0eXlKEv6waW83jfB3pcxR9Xzi3/gDnKqTJPvUrube7syBDqFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRDnuOiVoCCtD3DunszNQ3ZZ+O0vj3CFnTBt0DFAFPn/qZyBaR
	oYiTkAsFI9T+JV3jGCfdWkQufxVQxdBgdbGg/Sy6CooR/QI0jjSkFf4=
X-Gm-Gg: ASbGncsW0mb6KgjbvCnGDhtbNDaihrseWJmMySsE9QjPy/+WgPEAICGAh/H/q3drq7c
	l8Vm6k6gGOARx7v7RoBTXxffjwMAfv0EtkHqtjSkWbQm7BLTNL/WhPcbeWP35Y6VnIaPGFawKOT
	iq7mRi4VxFaMP+xIfFvS8xw2WG+sZXRtKapP6gGQUrMiI4uTMz4uccskpndFjBaZFg81FCuSICi
	CxHvEc/BrQVWv0/I5eeC9B1XZdfNoiJ7P3P0j/7qQ1Uk7a14MBvknPWdnuPy161XoD/g7fqZnqo
	kEAYm8jstWUVwill/FaD6p1NwkPMGYtvLUA7N3w=
X-Google-Smtp-Source: AGHT+IE3Wykmcd/LBXZW7UaNL9WVbiKjt6XYIXWjLxJ0oby5hugeyp+Q/8jI9M9BeTsPR1vcKjj/Pw==
X-Received: by 2002:a17:902:fc4c:b0:234:d7b2:2ab2 with SMTP id d9443c01a7336-2366b337ec0mr12414315ad.8.1749853460237;
        Fri, 13 Jun 2025 15:24:20 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dfdb9a0sm19840615ad.239.2025.06.13.15.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 15:24:19 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 bpf-next 3/4] af_unix: Pass skb to security_unix_may_send().
Date: Fri, 13 Jun 2025 15:22:15 -0700
Message-ID: <20250613222411.1216170-4-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613222411.1216170-1-kuni1840@gmail.com>
References: <20250613222411.1216170-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

SO_PASSRIGHTS is not flexible as it cannot control what types
of file descriptors are allowed to be passed.

Let's pass skb to security_unix_may_send() so that we can
implement more fine-grained filtering logic with BPF LSM.

Note that only the LSM_HOOK() macro uses the __nullable suffix
for skb to inform the verifier that the skb could be NULL at
connect().  Without it, I was able to load a bpf prog without
NULL check against skb.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/lsm_hook_defs.h | 3 ++-
 include/linux/security.h      | 5 +++--
 net/unix/af_unix.c            | 8 ++++----
 security/landlock/task.c      | 3 ++-
 security/security.c           | 5 +++--
 security/selinux/hooks.c      | 3 ++-
 security/smack/smack_lsm.c    | 3 ++-
 7 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 9be001922e0b..80edfe85214e 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -318,7 +318,8 @@ LSM_HOOK(int, 0, watch_key, struct key *key)
 #ifdef CONFIG_SECURITY_NETWORK
 LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
 	 struct sock *newsk)
-LSM_HOOK(int, 0, unix_may_send, struct sock *sock, struct sock *other)
+LSM_HOOK(int, 0, unix_may_send, struct sock *sock, struct sock *other,
+	 struct sk_buff *skb__nullable)
 LSM_HOOK(int, 0, socket_create, int family, int type, int protocol, int kern)
 LSM_HOOK(int, 0, socket_post_create, struct socket *sock, int family, int type,
 	 int protocol, int kern)
diff --git a/include/linux/security.h b/include/linux/security.h
index 36aa7030e16d..922618a98f15 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1625,7 +1625,7 @@ static inline int security_watch_key(struct key *key)
 
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk);
-int security_unix_may_send(struct sock *sk,  struct sock *other);
+int security_unix_may_send(struct sock *sk,  struct sock *other, struct sk_buff *skb);
 int security_socket_create(int family, int type, int protocol, int kern);
 int security_socket_post_create(struct socket *sock, int family,
 				int type, int protocol, int kern);
@@ -1692,7 +1692,8 @@ static inline int security_unix_stream_connect(struct sock *sock,
 }
 
 static inline int security_unix_may_send(struct sock *sk,
-					 struct sock *other)
+					 struct sock *other,
+					 struct sk_buff *skb)
 {
 	return 0;
 }
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index bcbe0c86e001..fd6b5e17f6c4 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1516,7 +1516,7 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 		if (!unix_may_send(sk, other))
 			goto out_unlock;
 
-		err = security_unix_may_send(sk, other);
+		err = security_unix_may_send(sk, other, NULL);
 		if (err)
 			goto out_unlock;
 
@@ -2170,7 +2170,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto out_unlock;
 	}
 
-	err = security_unix_may_send(sk, other);
+	err = security_unix_may_send(sk, other, skb);
 	if (err)
 		goto out_unlock;
 
@@ -2279,7 +2279,7 @@ static int queue_oob(struct sock *sk, struct msghdr *msg, struct sock *other,
 	}
 
 	if (!fds_sent) {
-		err = security_unix_may_send(sk, other);
+		err = security_unix_may_send(sk, other, skb);
 		if (err)
 			goto out_unlock;
 	}
@@ -2406,7 +2406,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		}
 
 		if (!fds_sent) {
-			err = security_unix_may_send(sk, other);
+			err = security_unix_may_send(sk, other, skb);
 			if (err)
 				goto out_unlock;
 
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 6bc6f3027790..f243edb036a7 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -295,7 +295,8 @@ static int hook_unix_stream_connect(struct sock *const sock,
 }
 
 static int hook_unix_may_send(struct sock *const sk,
-			      struct sock *const other)
+			      struct sock *const other,
+			      struct sk_buff *skb)
 {
 	size_t handle_layer;
 	const struct landlock_cred_security *const subject =
diff --git a/security/security.c b/security/security.c
index 3bd8eec01d05..3362e5b6764f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4531,9 +4531,10 @@ EXPORT_SYMBOL(security_unix_stream_connect);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_unix_may_send(struct sock *sk,  struct sock *other)
+int security_unix_may_send(struct sock *sk,  struct sock *other,
+			   struct sk_buff *skb)
 {
-	return call_int_hook(unix_may_send, sk, other);
+	return call_int_hook(unix_may_send, sk, other, skb);
 }
 EXPORT_SYMBOL(security_unix_may_send);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 904926ef9ee8..dec0abbc60d5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5177,7 +5177,8 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 }
 
 static int selinux_socket_unix_may_send(struct sock *sk,
-					struct sock *other)
+					struct sock *other,
+					struct sk_buff *skb)
 {
 	struct sk_security_struct *ssec = selinux_sock(sk);
 	struct sk_security_struct *osec = selinux_sock(other);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 20fe1d22210e..2fd2c1be5bbb 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3889,7 +3889,8 @@ static int smack_unix_stream_connect(struct sock *sock,
  * Return 0 if a subject with the smack of sock could access
  * an object with the smack of other, otherwise an error code
  */
-static int smack_unix_may_send(struct sock *sk, struct sock *other)
+static int smack_unix_may_send(struct sock *sk, struct sock *other,
+			       struct sk_buff *skb)
 {
 	struct socket_smack *ssp = smack_sock(sk);
 	struct socket_smack *osp = smack_sock(other);
-- 
2.49.0


