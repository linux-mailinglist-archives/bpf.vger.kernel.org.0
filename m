Return-Path: <bpf+bounces-36856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FD894E4CB
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 04:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40FEAB21C0E
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 02:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFB37A13A;
	Mon, 12 Aug 2024 02:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8qZyYhp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090506A357;
	Mon, 12 Aug 2024 02:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723429320; cv=none; b=rqr4KYFTFh8zNLquh12B1ebrxedFzw1WDPt1lyAjZHSOTicK5AH6hPbiKi66QkE8gbfX9TC2A/NVz3OJ8LRNvz79WLb3ZDZQ6Aa/eZEAWzmH284BEsNtzNzWwMCJ+YBAP2joCG0I0Z+JOEobueqbrEw1kS3ZMYN+RafyNgng7tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723429320; c=relaxed/simple;
	bh=n3p0tuhrVuEO0HZEC2VskuaUEmPtIATZDMB46oHt+n0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ldjzqmHsSca5pMlbTlAAzj8oa9OeIMWBffuIMSD6GLIsAHTL60B1Y5N8R7AFx6z3PqdCEoogLnbXaAH/qx0xMIMmhdkbAq9wVJkgRXrkzaZE6QkapauAC/4q6z064g2uF8WgroXK0K67NFJt8jy5ZdgRPrXIzC5YaA8dPNFoXVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8qZyYhp; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3db1270da60so3123461b6e.2;
        Sun, 11 Aug 2024 19:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723429318; x=1724034118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sewabr3MpJSfchWwTMTar1YoFN3xg/aYGBHrbRyqUfw=;
        b=K8qZyYhpFCwoRHELnCjEp6qT5zgsA/ENfWv1l2Qw4PrJz1jXGmbmlELtRUDgu3Y85i
         srQAk+A617MtlKYyVOWYM67Yr2AJYSDoJaXy4dcs3KiPzId8Fr0ghRBxV4k5MepY0Rl9
         GV0ZBlmh7SQ57ePGCvC3Nu8FznRgJk0loe4PizhAbvCVlD4Lc5FyJ/1vh9nJwTocJTTB
         wlKeyk4Hm9aKnjJrIAlPBjWMGjnga5gkwkbHbk3hTAHPbnREzAUDFb3/bpBY7Pz6H28c
         5WMVu+qZKJDEqL1F5SD6GM4nNVYCd8HAkMQxxyurVEkHRd5+ie95WBG71OyGEcWlHROX
         hRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723429318; x=1724034118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sewabr3MpJSfchWwTMTar1YoFN3xg/aYGBHrbRyqUfw=;
        b=nD+9tiKWeWcj+gSB4RuNKysb96xFuPVt/V4tgbc2DPgqHgOAJLJp7qIykbCxcBK7TK
         Abj1Ot63jNPy0xNhlhfGddKAH+dOSeuvsx0OWGD+bOfARKxBLP+D/gduFOLVWaYVq0ba
         LBnjenplLCbrMZaQqhm0qnLyBY0PJCTNWE5+tcRzcsjQM6Z25JJOTqXtz4HJ/vJsJGWM
         7YMVCKs412+zKBgYp3CvoUTtjiuMJi+wQNt5iwgL67LdeHq9MZ6fAkEnSygd2Vx2c1rS
         BhdT/oQDmZpt9wKTLqduQ7GcfC1Ai4B3MOgrdyzEoK+AYcGfRcv7luEJs+NetvYMtKpw
         GwGA==
X-Gm-Message-State: AOJu0Yyx/cITYJuATHdEy6tLdoKTOce7o1iQBH9uth4lFzbmVxwkjf49
	Rb4K8nMgl8AqR0nSBg3ctvD69tmVnMh2HzRATEe2jM5MQp4YaveKcmqdwA==
X-Google-Smtp-Source: AGHT+IHWVV8AEdmj4WzcpQYUKy3idMziav26GV8b+3mEYIuRPW2jCZVKfIdTE3cV4Px3xKSQIalmHw==
X-Received: by 2002:a05:6358:339a:b0:1ad:14ec:9ff7 with SMTP id e5c5f4694b2df-1b176f7d558mr1103603255d.16.1723429317679;
        Sun, 11 Aug 2024 19:21:57 -0700 (PDT)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:9b56:1ae5:e6f2:b80e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58a1429sm2958156b3a.64.2024.08.11.19.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 19:21:57 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	virtualization@lists.linux.dev,
	Cong Wang <cong.wang@bytedance.com>,
	syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [Patch net] vsock: fix recursive ->recvmsg calls
Date: Sun, 11 Aug 2024 19:21:53 -0700
Message-Id: <20240812022153.86512-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

After a vsock socket has been added to a BPF sockmap, its prot->recvmsg
has been replaced with vsock_bpf_recvmsg(). Thus the following
recursiion could happen:

vsock_bpf_recvmsg()
 -> __vsock_recvmsg()
  -> vsock_connectible_recvmsg()
   -> prot->recvmsg()
    -> vsock_bpf_recvmsg() again

We need to fix it by calling the original ->recvmsg() without any BPF
sockmap logic in __vsock_recvmsg().

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Reported-by: syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com
Tested-by: syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 include/net/af_vsock.h    |  4 ++++
 net/vmw_vsock/af_vsock.c  | 50 +++++++++++++++++++++++----------------
 net/vmw_vsock/vsock_bpf.c |  4 ++--
 3 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 535701efc1e5..24d970f7a4fa 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -230,8 +230,12 @@ struct vsock_tap {
 int vsock_add_tap(struct vsock_tap *vt);
 int vsock_remove_tap(struct vsock_tap *vt);
 void vsock_deliver_tap(struct sk_buff *build_skb(void *opaque), void *opaque);
+int __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
+				int flags);
 int vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 			      int flags);
+int __vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
+			  size_t len, int flags);
 int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
 			size_t len, int flags);
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 4b040285aa78..0ff9b2dd86ba 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1270,25 +1270,28 @@ static int vsock_dgram_connect(struct socket *sock,
 	return err;
 }
 
+int __vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
+			  size_t len, int flags)
+{
+	struct sock *sk = sock->sk;
+	struct vsock_sock *vsk = vsock_sk(sk);
+
+	return vsk->transport->dgram_dequeue(vsk, msg, len, flags);
+}
+
 int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
 			size_t len, int flags)
 {
 #ifdef CONFIG_BPF_SYSCALL
+	struct sock *sk = sock->sk;
 	const struct proto *prot;
-#endif
-	struct vsock_sock *vsk;
-	struct sock *sk;
 
-	sk = sock->sk;
-	vsk = vsock_sk(sk);
-
-#ifdef CONFIG_BPF_SYSCALL
 	prot = READ_ONCE(sk->sk_prot);
 	if (prot != &vsock_proto)
 		return prot->recvmsg(sk, msg, len, flags, NULL);
 #endif
 
-	return vsk->transport->dgram_dequeue(vsk, msg, len, flags);
+	return __vsock_dgram_recvmsg(sock, msg, len, flags);
 }
 EXPORT_SYMBOL_GPL(vsock_dgram_recvmsg);
 
@@ -2174,15 +2177,12 @@ static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
 }
 
 int
-vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
-			  int flags)
+__vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
+			    int flags)
 {
 	struct sock *sk;
 	struct vsock_sock *vsk;
 	const struct vsock_transport *transport;
-#ifdef CONFIG_BPF_SYSCALL
-	const struct proto *prot;
-#endif
 	int err;
 
 	sk = sock->sk;
@@ -2233,14 +2233,6 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		goto out;
 	}
 
-#ifdef CONFIG_BPF_SYSCALL
-	prot = READ_ONCE(sk->sk_prot);
-	if (prot != &vsock_proto) {
-		release_sock(sk);
-		return prot->recvmsg(sk, msg, len, flags, NULL);
-	}
-#endif
-
 	if (sk->sk_type == SOCK_STREAM)
 		err = __vsock_stream_recvmsg(sk, msg, len, flags);
 	else
@@ -2250,6 +2242,22 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	release_sock(sk);
 	return err;
 }
+
+int
+vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
+			  int flags)
+{
+#ifdef CONFIG_BPF_SYSCALL
+	struct sock *sk = sock->sk;
+	const struct proto *prot;
+
+	prot = READ_ONCE(sk->sk_prot);
+	if (prot != &vsock_proto)
+		return prot->recvmsg(sk, msg, len, flags, NULL);
+#endif
+
+	return __vsock_connectible_recvmsg(sock, msg, len, flags);
+}
 EXPORT_SYMBOL_GPL(vsock_connectible_recvmsg);
 
 static int vsock_set_rcvlowat(struct sock *sk, int val)
diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index a3c97546ab84..c42c5cc18f32 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -64,9 +64,9 @@ static int __vsock_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int
 	int err;
 
 	if (sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET)
-		err = vsock_connectible_recvmsg(sock, msg, len, flags);
+		err = __vsock_connectible_recvmsg(sock, msg, len, flags);
 	else if (sk->sk_type == SOCK_DGRAM)
-		err = vsock_dgram_recvmsg(sock, msg, len, flags);
+		err = __vsock_dgram_recvmsg(sock, msg, len, flags);
 	else
 		err = -EPROTOTYPE;
 
-- 
2.34.1


