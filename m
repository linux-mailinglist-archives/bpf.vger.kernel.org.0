Return-Path: <bpf+bounces-60635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270D5AD9823
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 00:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35964A1408
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 22:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0F828E61C;
	Fri, 13 Jun 2025 22:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1dJ4JVX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E10D28DB4F;
	Fri, 13 Jun 2025 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749853459; cv=none; b=bUiZ+8KjTpmawlK/npOI53ADfbFX1tQpas5LZX5B9/e9W9DQVqs+mTwBIiu+e4K2u7izL+AmyNILaSF/tDZQP8Y7/1xy0idgzzv8DAMKEGlUCxXxLd1rHGW+TMja8eUVkh26VkVkSK9VEzXk2fNILueTFZgzkwfyRpqLJi8Qc1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749853459; c=relaxed/simple;
	bh=NE9FaMI/MESCQ+aUI6syrq2V3zWqZe+2rZGUFXmtmKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2oWIMtoEtMWhpSdRpDnqQ/nbZ81NhEr5yVkjzst6Jrd8ITl4MO7i4Sz1gg/4GBG2AHVb6SE9KAFgETwG33pz3a2uEGnBKhburiHrxWp55KrLiCZcFM7vniGvN4NcFCT50D9baE/scU5qMrONt+wdT7fk7n4wnja13ZomrpQ45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1dJ4JVX; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b1396171fb1so1809217a12.2;
        Fri, 13 Jun 2025 15:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749853457; x=1750458257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GigmPgwk2hqWdyACkuSuqj/yYA9tIEyRiBeNjIrOew=;
        b=T1dJ4JVX+D2rta7YEfq61Zm1TXadTpcMmJmkVWQiRrmRy4rvL/vOgdJbLvGT8EOBpT
         MknMa7yaBHTHgWNP6DSimiBKYncIJqtxiP7vJ/Cl5JefpqbBCr/2aC8yemxFbifH3mx0
         zLs7kSRt40IXV0pbTswnIjGQhd7B5I5fYJb9Ni0imI//wU8DQteQmgBkDaQZttKAKyo8
         0V/QimKUiIjqW0ltHTFsXmooIQPSG28BODWoNSjStBlxfjdI2761HPyoST5Uo0vvJB1p
         KgsUJPnKGB60cFsPjuqGuWHwncijZIPPP5Cu4NECTi/ubFUk3AVHfLQy5s3N7+Ae2arW
         K9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749853457; x=1750458257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GigmPgwk2hqWdyACkuSuqj/yYA9tIEyRiBeNjIrOew=;
        b=vGjqth3f9xzveFdgqDN4IZwDK2fCdxqBHOiT+kM7L1DW0cevz03t8D4xyW09y3Nn1B
         Tt1ZArANOWDrqYQS3JH1vaerxwNkJKlnCmqMyskEril/2gPmG6NEiEzzrx4VUI7ZqGj1
         bFMxaTw3KcIw+Br8aqcPGP+stcA6LsxoaiJSwMbgJB28OU6tXBxFlLiNGUOLZtu+2j1R
         LdGPWIZzWHcY0ewAXQvsVzX+EMqGMBZtZyWKmeSUuXb6zNqSD4Ke/NiQKu99urNE7in9
         z8lckd2F9nyY8mShyQ77blAs1hAjXvCXNcDkAdjxdhW5xb1orda9ZaYZFp4RDWoBSWiq
         7g2A==
X-Forwarded-Encrypted: i=1; AJvYcCUFn1moQjA9HaM5+bSxEUiBtG0M0wS6daN7jiwFfaAN0jmC/4NMGcQU8jLoxZbn7dHCd5KL5ElA@vger.kernel.org, AJvYcCXOHyZFa7kRN3RvWQRYkgto21cta7x7a2fPFCZ9yupmovWQOtc7ZUhAwToY9YEaiTxx/64=@vger.kernel.org, AJvYcCXcG1g9us8Hg48NB6rTvz+rQRMdKGYSjWFCmTP6y/xoevMSy/V7t2fze4w5jtIpLNW/Oj+cXFQAnenuSUu1Cq+NaxSrK73p@vger.kernel.org, AJvYcCXdPeo6+gmXAiOSarTkZ/qSy3cK1I+5IsSvA+N7QVazxXL9rcFCqw4GB9xnP8yqUgDL842jWlUFwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgGhSH37dDMKPxsOF+VBHDhzgcjHuiVd3hsaC+2p3wgnClQQJe
	hQUr18SSkZyhm7IxnDmyeeTN7AcvqDHtQOyBbGHg6ddVKCAZwYi/H9Q=
X-Gm-Gg: ASbGncsMlJagO219j/tNd/0jsYmldTRGafCNtLaZU+dMTb56pCTbESB/eXUFYeu/6XL
	RUOwJIaEEMU9oa5qMYVFVUY6stI9Kna5IcCA2j3mqKW4utwCkdYyqfXAMjSERuGHMxusicfAb6Z
	nzFPKmEUq57xhr9Z5cgEQHCZRS/cxgUT4TSB2Icc0vjS3R+lqCTX+Rz5FbXBDtf0mGVN97xJfvH
	NWfKEZw3epa12S6AvG37eR87mXgUPRL0oU/cnVnJCkBobaN0MD3A5QiVlnbLFd2nnemV5TdOetp
	wKYkJSA69YwrX2V53axgCZZt2fBNnBrdw+H09cI=
X-Google-Smtp-Source: AGHT+IGdMpEzAJibWfsygtz9ViDh1BeEBD+4LGWw5NRRvWqBYStqu5VmwJEmBraxrk0jW6CnKGWZsA==
X-Received: by 2002:a17:90b:3d88:b0:311:ea13:2e63 with SMTP id 98e67ed59e1d1-313f1ca12e2mr1661481a91.13.1749853456672;
        Fri, 13 Jun 2025 15:24:16 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dfdb9a0sm19840615ad.239.2025.06.13.15.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 15:24:16 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 1/4] af_unix: Don't pass struct socket to security_unix_may_send().
Date: Fri, 13 Jun 2025 15:22:13 -0700
Message-ID: <20250613222411.1216170-2-kuni1840@gmail.com>
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

The next patch will invoke security_unix_may_send() in
unix_stream_sendmsg().

At that point, the peer socket may not have sk->sk_socket
if it has not been accept()ed yet, which would cause
null-ptr-deref.

Currently, all security_unix_may_send() hooks fetch struct
sock from struct socket but do not use struct socket itself.

Let's pass struct sock directly to security_unix_may_send().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/lsm_hook_defs.h |  2 +-
 include/linux/security.h      |  6 +++---
 net/unix/af_unix.c            |  4 ++--
 security/landlock/task.c      | 12 ++++++------
 security/security.c           |  4 ++--
 security/selinux/hooks.c      | 10 +++++-----
 security/smack/smack_lsm.c    |  8 ++++----
 7 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index bf3bbac4e02a..9be001922e0b 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -318,7 +318,7 @@ LSM_HOOK(int, 0, watch_key, struct key *key)
 #ifdef CONFIG_SECURITY_NETWORK
 LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
 	 struct sock *newsk)
-LSM_HOOK(int, 0, unix_may_send, struct socket *sock, struct socket *other)
+LSM_HOOK(int, 0, unix_may_send, struct sock *sock, struct sock *other)
 LSM_HOOK(int, 0, socket_create, int family, int type, int protocol, int kern)
 LSM_HOOK(int, 0, socket_post_create, struct socket *sock, int family, int type,
 	 int protocol, int kern)
diff --git a/include/linux/security.h b/include/linux/security.h
index dba349629229..36aa7030e16d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1625,7 +1625,7 @@ static inline int security_watch_key(struct key *key)
 
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk);
-int security_unix_may_send(struct socket *sock,  struct socket *other);
+int security_unix_may_send(struct sock *sk,  struct sock *other);
 int security_socket_create(int family, int type, int protocol, int kern);
 int security_socket_post_create(struct socket *sock, int family,
 				int type, int protocol, int kern);
@@ -1691,8 +1691,8 @@ static inline int security_unix_stream_connect(struct sock *sock,
 	return 0;
 }
 
-static inline int security_unix_may_send(struct socket *sock,
-					 struct socket *other)
+static inline int security_unix_may_send(struct sock *sk,
+					 struct sock *other)
 {
 	return 0;
 }
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 2e2e9997a68e..6865da79ad1c 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1516,7 +1516,7 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 		if (!unix_may_send(sk, other))
 			goto out_unlock;
 
-		err = security_unix_may_send(sk->sk_socket, other->sk_socket);
+		err = security_unix_may_send(sk, other);
 		if (err)
 			goto out_unlock;
 
@@ -2171,7 +2171,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	}
 
 	if (sk->sk_type != SOCK_SEQPACKET) {
-		err = security_unix_may_send(sk->sk_socket, other->sk_socket);
+		err = security_unix_may_send(sk, other);
 		if (err)
 			goto out_unlock;
 	}
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 2385017418ca..d7db70790a33 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -294,8 +294,8 @@ static int hook_unix_stream_connect(struct sock *const sock,
 	return -EPERM;
 }
 
-static int hook_unix_may_send(struct socket *const sock,
-			      struct socket *const other)
+static int hook_unix_may_send(struct sock *const sk,
+			      struct sock *const other)
 {
 	size_t handle_layer;
 	const struct landlock_cred_security *const subject =
@@ -309,13 +309,13 @@ static int hook_unix_may_send(struct socket *const sock,
 	 * Checks if this datagram socket was already allowed to be connected
 	 * to other.
 	 */
-	if (unix_peer(sock->sk) == other->sk)
+	if (unix_peer(sk) == other)
 		return 0;
 
-	if (!is_abstract_socket(other->sk))
+	if (!is_abstract_socket(other))
 		return 0;
 
-	if (!sock_is_scoped(other->sk, subject->domain))
+	if (!sock_is_scoped(other, subject->domain))
 		return 0;
 
 	landlock_log_denial(subject, &(struct landlock_request) {
@@ -323,7 +323,7 @@ static int hook_unix_may_send(struct socket *const sock,
 		.audit = {
 			.type = LSM_AUDIT_DATA_NET,
 			.u.net = &(struct lsm_network_audit) {
-				.sk = other->sk,
+				.sk = other,
 			},
 		},
 		.layer_plus_one = handle_layer + 1,
diff --git a/security/security.c b/security/security.c
index 596d41818577..3bd8eec01d05 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4531,9 +4531,9 @@ EXPORT_SYMBOL(security_unix_stream_connect);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_unix_may_send(struct socket *sock,  struct socket *other)
+int security_unix_may_send(struct sock *sk,  struct sock *other)
 {
-	return call_int_hook(unix_may_send, sock, other);
+	return call_int_hook(unix_may_send, sk, other);
 }
 EXPORT_SYMBOL(security_unix_may_send);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 595ceb314aeb..07101a2bf942 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5176,15 +5176,15 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 	return 0;
 }
 
-static int selinux_socket_unix_may_send(struct socket *sock,
-					struct socket *other)
+static int selinux_socket_unix_may_send(struct sock *sk,
+					struct sock *other)
 {
-	struct sk_security_struct *ssec = selinux_sock(sock->sk);
-	struct sk_security_struct *osec = selinux_sock(other->sk);
+	struct sk_security_struct *ssec = selinux_sock(sk);
+	struct sk_security_struct *osec = selinux_sock(other);
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 
-	ad_net_init_from_sk(&ad, &net, other->sk);
+	ad_net_init_from_sk(&ad, &net, other);
 
 	return avc_has_perm(ssec->sid, osec->sid, osec->sclass, SOCKET__SENDTO,
 			    &ad);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index fc340a6f0dde..9bb00c0df373 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3889,10 +3889,10 @@ static int smack_unix_stream_connect(struct sock *sock,
  * Return 0 if a subject with the smack of sock could access
  * an object with the smack of other, otherwise an error code
  */
-static int smack_unix_may_send(struct socket *sock, struct socket *other)
+static int smack_unix_may_send(struct sock *sk, struct sock *other)
 {
-	struct socket_smack *ssp = smack_sock(sock->sk);
-	struct socket_smack *osp = smack_sock(other->sk);
+	struct socket_smack *ssp = smack_sock(sk);
+	struct socket_smack *osp = smack_sock(other);
 	struct smk_audit_info ad;
 	int rc;
 
@@ -3900,7 +3900,7 @@ static int smack_unix_may_send(struct socket *sock, struct socket *other)
 	struct lsm_network_audit net;
 
 	smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
-	smk_ad_setfield_u_net_sk(&ad, other->sk);
+	smk_ad_setfield_u_net_sk(&ad, other);
 #endif
 
 	if (smack_privileged(CAP_MAC_OVERRIDE))
-- 
2.49.0


