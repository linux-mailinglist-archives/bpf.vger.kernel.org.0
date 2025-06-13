Return-Path: <bpf+bounces-60636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AABA1AD9828
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 00:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB091BC50BE
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 22:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC8928ECC9;
	Fri, 13 Jun 2025 22:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yyt9k+30"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E4B223DD1;
	Fri, 13 Jun 2025 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749853460; cv=none; b=EG/ZVnqjPlpQ//MXvMavUH1cW3SzN5BueGqJk5ZnI/IDFUzVyfYz+tq3LeN8u9jgV4fEUtaeHFU8P6z1QbuaooLp4N/pVxrm3sgnSQ6qRrP1HV+EBE232hnNmCPUG8lvmUszM8+HNZP8qHV1vVEIByfBzrcPWhzKkYbWkC05Bc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749853460; c=relaxed/simple;
	bh=vCekYmKbboXYYnDA3XWN6IbmaX67Jm5+mk8s2IhWihw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1AIvkc/f3hl9+cuRjysoNb7YGmQugtFPHdlH7A5SjfDxCbO+SUPHRrn4CYI0ZPr7LNUUGnY3gNXsBZa4rZkcUCSDRIkjPoU5r4u40wSfNS4axJU5zQns0Em+eG6ss7onA8j/dPfktmUZIL1rF17Mp8B1GCikjZPKDlVtVOGogU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yyt9k+30; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2363616a1a6so22442105ad.3;
        Fri, 13 Jun 2025 15:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749853458; x=1750458258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4lOcCW/3ZSTnVpymt6kVNYy5z9Xg/3STzZpIACgX2k=;
        b=Yyt9k+30Qpxf1uatz5i48Nnk3w6Bh1Tji0AGLnO6i5xS7LU/I33p1SGDwu+1pGGjQS
         keqRfSR0U2iXf07h71wRd0jXKqsLQObb2uD05wN9tu1J+kdl6vB/XllJaWvNg/Txmwxb
         3NmqhlmfkNbeCkJlVwE+lO5etPHgzWarwsKfQ1Zd6DUPVOvwUqyqvOK2ft152eRHqmmL
         bBtVrxHSeTLCzh0UOhe9HlIfXU0x4mWq5iSvWlEosQOYYYJW+4qSb+EWwU2u5hJI1QNV
         SHDMHTQWd6Pd6SNm2RhT+ncf4wHEwYBAS9e5n5Pz1IZlmSrzAZIsF6ak5UuULnjN4KjQ
         plOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749853458; x=1750458258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4lOcCW/3ZSTnVpymt6kVNYy5z9Xg/3STzZpIACgX2k=;
        b=sF7pfL5PNDw3MM9FxW0LioAAcZeYPYEt0cMYq+KD6SDpcQvlxSHf/SRok2t27EN8tp
         BXCOAiA/4T3Qgyy251kaZuXNQjcOK8Q+6QqxrPggpRuw+4p7aD7xNtKoReRGrnEBV9dx
         Rxcw472Lb70sRaT6dl0lAU/2ansUtRuv/6ksRUcz4HrdmOpcAIp0UOVuKMOKifHq4AZa
         /X1nGMj+I0BBYPt4nYRHtvEMSRkwSo71mTczwCRj82BMAd8sCnsiiTkoEK16qvXGoZjU
         2MFiS7UJYeP1wPvF9KLsA+/pI0N7u+eGm+h48seAyuAICiefXYeXb2m4yVpwS65Ftxgy
         yrNg==
X-Forwarded-Encrypted: i=1; AJvYcCUSbVN1T37EcchCPUzTWn/iJ2kwRuoIlXMtZZoCxuFBn6gfCKFOSWFFti6zSYcf7b+6ucw=@vger.kernel.org, AJvYcCUol50X5nLld9uDxZDz0t5W8o6BOczKcwsdHS+SEucQoTEWifC6aD5C1TYZJRxr9Jr7YrZio833@vger.kernel.org, AJvYcCVjOo2Ma7Idc2Twyj6e8f8tWlfqtgCkPW/lWC9I7QHERshEcdYy9xT0C3ZyShaYguSlV2Q9ySR9GA==@vger.kernel.org, AJvYcCVwl6XfFLO+IzqQF8XnWpxRmYlqWkR7S6mx/56Oua7DYHpsAIfYsLr1RvEeN1ncDInIapB/y4YQX2FZcWf9Q9pk298lUtP5@vger.kernel.org
X-Gm-Message-State: AOJu0YyU6LdCM11VrcYYv3Nq3soYro7fw/ZNTZEQlIXv0fxZ4g86mj7D
	uIofMNrUD3joBeralw0DH3qMiDJgkWhxQ9L8I480RZNhqbOKtH/qes4H0Qllk73erB9R
X-Gm-Gg: ASbGnctC2dz5VOUlpm6nSJZbe1vcPZ8naEU72r7sRYpdkhqdYWdpRmgIIuq0DqxmsQu
	OvUpxeH2n0ABtJV5BwuI5l5g+psXnK3afWaLeoKiBB+MoKI0ZURptFHBGtm/JlEVxtdpompA/7d
	d2kkqr6LnMY6t3RXA7SmpXb3T5BmiFe6MWHEJ/2ZoijJwEGReo77d8SkBGh165+vWr9y8Qw5ZzO
	LFH5ZTvIR6SiVzcyODjFZ95ZwOjVW1ZwkoPgwB83C3CS9QICwbMejIVQYxtZjedko9ffxCi2Gnt
	8zz4wrKU0oZGSdwEwxKwhAOyMCT2TZObHoBWBn0=
X-Google-Smtp-Source: AGHT+IEkk4hilzvUKOli20JueKv5ZkZctTkLRP9mQQNEO1FgOQzyPlc9Sh3gmM7PwODKUd2RZfaLrQ==
X-Received: by 2002:a17:902:c94e:b0:234:ed31:fc98 with SMTP id d9443c01a7336-2366b14e566mr15242685ad.37.1749853458336;
        Fri, 13 Jun 2025 15:24:18 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dfdb9a0sm19840615ad.239.2025.06.13.15.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 15:24:17 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 2/4] af_unix: Call security_unix_may_send() in sendmsg() for all socket types
Date: Fri, 13 Jun 2025 15:22:14 -0700
Message-ID: <20250613222411.1216170-3-kuni1840@gmail.com>
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

Currently, security_unix_may_send() is invoked only for SOCK_DGRAM
sockets during connect() and sendmsg().

For SOCK_STREAM and SOCK_SEQPACKET sockets, an equivalent check
already occurs during connect(), making an additional hook in
sendmsg() unnecessary.

However, we want to leverage BPF LSM to inspect UNIXCB(skb) during
sendmsg().

As a preparation, let's call security_unix_may_send() for SOCK_STREAM
and SOCK_SEQPACKET in sendmsg().

Note that SELinux, SMACK, and Landlock use security_unix_may_send().
To avoid unintentionally triggering the hook for SOCK_STREAM and
SOCK_SEQPACKET, the socket type check is added in each LSM hooks.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/af_unix.c         | 30 +++++++++++++++++++++---------
 security/landlock/task.c   |  3 +++
 security/selinux/hooks.c   |  3 +++
 security/smack/smack_lsm.c |  3 +++
 4 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 6865da79ad1c..bcbe0c86e001 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2170,11 +2170,9 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto out_unlock;
 	}
 
-	if (sk->sk_type != SOCK_SEQPACKET) {
-		err = security_unix_may_send(sk, other);
-		if (err)
-			goto out_unlock;
-	}
+	err = security_unix_may_send(sk, other);
+	if (err)
+		goto out_unlock;
 
 	/* other == sk && unix_peer(other) != sk if
 	 * - unix_peer(sk) == NULL, destination address bound to sk
@@ -2280,6 +2278,12 @@ static int queue_oob(struct sock *sk, struct msghdr *msg, struct sock *other,
 		goto out_unlock;
 	}
 
+	if (!fds_sent) {
+		err = security_unix_may_send(sk, other);
+		if (err)
+			goto out_unlock;
+	}
+
 	unix_maybe_add_creds(skb, sk, other);
 	scm_stat_add(other, skb);
 
@@ -2372,8 +2376,6 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		if (err < 0)
 			goto out_free;
 
-		fds_sent = true;
-
 		if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES)) {
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 			err = skb_splice_from_iter(skb, &msg->msg_iter, size,
@@ -2399,9 +2401,16 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 			goto out_pipe_unlock;
 
 		if (UNIXCB(skb).fp && !other->sk_scm_rights) {
-			unix_state_unlock(other);
 			err = -EPERM;
-			goto out_free;
+			goto out_unlock;
+		}
+
+		if (!fds_sent) {
+			err = security_unix_may_send(sk, other);
+			if (err)
+				goto out_unlock;
+
+			fds_sent = true;
 		}
 
 		unix_maybe_add_creds(skb, sk, other);
@@ -2425,6 +2434,9 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	return sent;
 
+out_unlock:
+	unix_state_unlock(other);
+	goto out_free;
 out_pipe_unlock:
 	unix_state_unlock(other);
 out_pipe:
diff --git a/security/landlock/task.c b/security/landlock/task.c
index d7db70790a33..6bc6f3027790 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -305,6 +305,9 @@ static int hook_unix_may_send(struct sock *const sk,
 	if (!subject)
 		return 0;
 
+	if (sk->sk_type != SOCK_DGRAM)
+		return 0;
+
 	/*
 	 * Checks if this datagram socket was already allowed to be connected
 	 * to other.
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 07101a2bf942..904926ef9ee8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5184,6 +5184,9 @@ static int selinux_socket_unix_may_send(struct sock *sk,
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 
+	if (sk->sk_type != SOCK_DGRAM)
+		return 0;
+
 	ad_net_init_from_sk(&ad, &net, other);
 
 	return avc_has_perm(ssec->sid, osec->sid, osec->sclass, SOCKET__SENDTO,
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 9bb00c0df373..20fe1d22210e 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3903,6 +3903,9 @@ static int smack_unix_may_send(struct sock *sk, struct sock *other)
 	smk_ad_setfield_u_net_sk(&ad, other);
 #endif
 
+	if (sk->sk_type != SOCK_DGRAM)
+		return 0;
+
 	if (smack_privileged(CAP_MAC_OVERRIDE))
 		return 0;
 
-- 
2.49.0


