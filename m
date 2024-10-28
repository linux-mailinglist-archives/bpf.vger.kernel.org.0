Return-Path: <bpf+bounces-43286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0039B2E70
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 12:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B55F1C21E7A
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 11:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D381DF274;
	Mon, 28 Oct 2024 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYue9x+M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE431DF26F;
	Mon, 28 Oct 2024 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113589; cv=none; b=uEPRoZZ/RBMVfP90S2OV2VZZRx4QSuigGQG/zrrB0ublGirg0Jl7G8VP9jDSyijLdqeMyVMc7EWR0LIf/FXdO2KhmzTbXzaCAR2piNoA5NXwAHQ7j/uhTC9d73OO3VvghmF9ycRAhKeYo0REROg6WoveWHkaT6nHD+uSpP84IMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113589; c=relaxed/simple;
	bh=k9HmVYeawBX2SpeoxCKJ+InFGLGRTQOaV1sixDaj740=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fQ4C33otGlVBuE5nq3BbqWRVqfppwDT68fUAYfz64dQRQMjpLxqOYFFehSFr8qnAdva5ihMOwrtuzE0UmIpLUf1QKAS7OLeGG6wktcRe1KLM9C5rHbkfcC1VExObAIYkUSYx2ngrWdKDw6KBdO0gv5Th5bwCWThiy3ceqZWvCtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYue9x+M; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cdb889222so38151905ad.3;
        Mon, 28 Oct 2024 04:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730113587; x=1730718387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20KkNWOP/RO5bujtzpUiEeBLs9+BSyXwQMtz9AwS0TQ=;
        b=dYue9x+MWOM/65gFhtyaBpa9nIjF+rT7e1IC+wbrCgYbKZ6eXrqDUbuciXYE7SPEwq
         9rMof2pdFq5/tZ7amWBMm/FvVIeA4Yj0oDoXPb5bzjaA4RnwO77OEG3cGsa9Q0aPHxtF
         hq5XtYbFqlcdxczOZBMQd4CzXnAZsHVBN0qL8P9hw0tFaLvD+Y7PU7WN6032OXd98IiK
         +EJKupIehekdOrh7UCJfbq83cUDDNOFGS2jU9kcIq1UE1wXoOCnBVTRSq4LVhjK+4cyb
         X0vcA0dg0logvQCoCwM45P8seuviduhifmGufIp3x7XphMRd6e1UL/9ukHrjEyz0HAqd
         WhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730113587; x=1730718387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20KkNWOP/RO5bujtzpUiEeBLs9+BSyXwQMtz9AwS0TQ=;
        b=K+RXeyUI4dxb5xZvFA9cDtXfeRFgb+AdQPp+wSIqoeWLHtQvcOAW1Cp/fsJBAHdICp
         oMPSlIw1JHtf3GtnJeQu2rgvVNqKa72QEUYpfCHYmXmrnwVOx4qybIO1LfyyNQ7c1338
         8E8tdAazp8BVOt7lt8PvbT1a9UY0a+sJIhqYcVh8Yl/fGpXtOMTzZQIUXJ/6Z2/LmMqn
         KV3zlxVHl8aQrybwkaUbpOagmVtD/z8K/47OoebGrIJGRwbwHjZv3v4+JywGp0vE/Vdk
         r5HEDoNEEFpGPLIB5XiBH3yWbzJeyofpzfZ224twptl65B14E7X/+x4kEIOwRMPla97o
         0QjA==
X-Forwarded-Encrypted: i=1; AJvYcCX28F2i8QLAv4o11/Fhbs85t5y9x5LGoOrLATYFnlhTFN9e19y0z2O9mkhOEwlMYqrxbLJpPUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqKPejUMpyw3aRWAX/23/m2DiC2UFZZo3S7tNiTqojk3ugzSpm
	QdCgpS1/O4qW2G8nk8p1pUcyzU2Ke/sHiQik2gkCP2xtFcMeWJNp
X-Google-Smtp-Source: AGHT+IFgKZm+dERnFZZKprmu12eDj4bD6GHUf8cRczBLzTYPbF1J/YPhYMMtsPtV70x7RrHEbcFWFw==
X-Received: by 2002:a17:902:f54e:b0:20b:5439:f194 with SMTP id d9443c01a7336-210c6898707mr98507135ad.16.1730113585157;
        Mon, 28 Oct 2024 04:06:25 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc04bdb6sm48130905ad.255.2024.10.28.04.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 04:06:24 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	ykolal@fb.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 03/14] net-timestamp: open gate for bpf_setsockopt/_getsockopt
Date: Mon, 28 Oct 2024 19:05:24 +0800
Message-Id: <20241028110535.82999-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241028110535.82999-1-kerneljasonxing@gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

For now, we support bpf_setsockopt to set or clear timestamps flags.

Users can use something like this in bpf program to turn on the feature:
flags = SOF_TIMESTAMPING_TX_SCHED;
bpf_setsockopt(skops, SOL_SOCKET, SO_TIMESTAMPING, &flags, sizeof(flags));
The specific use cases can be seen in the bpf selftest in this series.

Later, I will support each flags one by one based on this.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/sock.h              |  4 ++--
 include/uapi/linux/net_tstamp.h |  7 +++++++
 net/core/filter.c               |  7 +++++--
 net/core/sock.c                 | 34 ++++++++++++++++++++++++++-------
 net/ipv4/udp.c                  |  2 +-
 net/mptcp/sockopt.c             |  2 +-
 net/socket.c                    |  2 +-
 7 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 5384f1e49f5c..062f405c744e 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1775,7 +1775,7 @@ static inline void skb_set_owner_edemux(struct sk_buff *skb, struct sock *sk)
 #endif
 
 int sk_setsockopt(struct sock *sk, int level, int optname,
-		  sockptr_t optval, unsigned int optlen);
+		  sockptr_t optval, unsigned int optlen, bool bpf_timetamping);
 int sock_setsockopt(struct socket *sock, int level, int op,
 		    sockptr_t optval, unsigned int optlen);
 int do_sock_setsockopt(struct socket *sock, bool compat, int level,
@@ -1784,7 +1784,7 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 		       int optname, sockptr_t optval, sockptr_t optlen);
 
 int sk_getsockopt(struct sock *sk, int level, int optname,
-		  sockptr_t optval, sockptr_t optlen);
+		  sockptr_t optval, sockptr_t optlen, bool bpf_timetamping);
 int sock_gettstamp(struct socket *sock, void __user *userstamp,
 		   bool timeval, bool time32);
 struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long header_len,
diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
index 858339d1c1c4..0696699cf964 100644
--- a/include/uapi/linux/net_tstamp.h
+++ b/include/uapi/linux/net_tstamp.h
@@ -49,6 +49,13 @@ enum {
 					 SOF_TIMESTAMPING_TX_SCHED | \
 					 SOF_TIMESTAMPING_TX_ACK)
 
+#define SOF_TIMESTAMPING_BPF_SUPPPORTED_MASK (SOF_TIMESTAMPING_SOFTWARE | \
+					      SOF_TIMESTAMPING_TX_SCHED | \
+					      SOF_TIMESTAMPING_TX_SOFTWARE | \
+					      SOF_TIMESTAMPING_TX_ACK | \
+					      SOF_TIMESTAMPING_OPT_ID | \
+					      SOF_TIMESTAMPING_OPT_ID_TCP)
+
 /**
  * struct so_timestamping - SO_TIMESTAMPING parameter
  *
diff --git a/net/core/filter.c b/net/core/filter.c
index 58761263176c..dc8ecf899ced 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5238,6 +5238,9 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
 		break;
 	case SO_BINDTODEVICE:
 		break;
+	case SO_TIMESTAMPING_NEW:
+	case SO_TIMESTAMPING_OLD:
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -5247,11 +5250,11 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
 			return -EINVAL;
 		return sk_getsockopt(sk, SOL_SOCKET, optname,
 				     KERNEL_SOCKPTR(optval),
-				     KERNEL_SOCKPTR(optlen));
+				     KERNEL_SOCKPTR(optlen), true);
 	}
 
 	return sk_setsockopt(sk, SOL_SOCKET, optname,
-			     KERNEL_SOCKPTR(optval), *optlen);
+			     KERNEL_SOCKPTR(optval), *optlen, true);
 }
 
 static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
diff --git a/net/core/sock.c b/net/core/sock.c
index 7f398bd07fb7..7e05748b1a06 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -941,6 +941,19 @@ int sock_set_timestamping(struct sock *sk, int optname,
 	return 0;
 }
 
+static int sock_set_timestamping_bpf(struct sock *sk,
+				     struct so_timestamping timestamping)
+{
+	u32 flags = timestamping.flags;
+
+	if (flags & ~SOF_TIMESTAMPING_BPF_SUPPPORTED_MASK)
+		return -EINVAL;
+
+	WRITE_ONCE(sk->sk_tsflags_bpf, flags);
+
+	return 0;
+}
+
 void sock_set_keepalive(struct sock *sk)
 {
 	lock_sock(sk);
@@ -1159,7 +1172,7 @@ static int sockopt_validate_clockid(__kernel_clockid_t value)
  */
 
 int sk_setsockopt(struct sock *sk, int level, int optname,
-		  sockptr_t optval, unsigned int optlen)
+		  sockptr_t optval, unsigned int optlen, bool bpf_timetamping)
 {
 	struct so_timestamping timestamping;
 	struct socket *sock = sk->sk_socket;
@@ -1409,7 +1422,10 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 			memset(&timestamping, 0, sizeof(timestamping));
 			timestamping.flags = val;
 		}
-		ret = sock_set_timestamping(sk, optname, timestamping);
+		if (!bpf_timetamping)
+			ret = sock_set_timestamping(sk, optname, timestamping);
+		else
+			ret = sock_set_timestamping_bpf(sk, timestamping);
 		break;
 
 	case SO_RCVLOWAT:
@@ -1626,7 +1642,7 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 		    sockptr_t optval, unsigned int optlen)
 {
 	return sk_setsockopt(sock->sk, level, optname,
-			     optval, optlen);
+			     optval, optlen, false);
 }
 EXPORT_SYMBOL(sock_setsockopt);
 
@@ -1670,7 +1686,7 @@ static int groups_to_user(sockptr_t dst, const struct group_info *src)
 }
 
 int sk_getsockopt(struct sock *sk, int level, int optname,
-		  sockptr_t optval, sockptr_t optlen)
+		  sockptr_t optval, sockptr_t optlen, bool bpf_timetamping)
 {
 	struct socket *sock = sk->sk_socket;
 
@@ -1793,9 +1809,13 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		 * returning the flags when they were set through the same option.
 		 * Don't change the beviour for the old case SO_TIMESTAMPING_OLD.
 		 */
-		if (optname == SO_TIMESTAMPING_OLD || sock_flag(sk, SOCK_TSTAMP_NEW)) {
-			v.timestamping.flags = READ_ONCE(sk->sk_tsflags);
-			v.timestamping.bind_phc = READ_ONCE(sk->sk_bind_phc);
+		if (!bpf_timetamping) {
+			if (optname == SO_TIMESTAMPING_OLD || sock_flag(sk, SOCK_TSTAMP_NEW)) {
+				v.timestamping.flags = READ_ONCE(sk->sk_tsflags);
+				v.timestamping.bind_phc = READ_ONCE(sk->sk_bind_phc);
+			}
+		} else {
+			v.timestamping.flags = READ_ONCE(sk->sk_tsflags_bpf);
 		}
 		break;
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0e24916b39d4..9a20af41e272 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2679,7 +2679,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 	int is_udplite = IS_UDPLITE(sk);
 
 	if (level == SOL_SOCKET) {
-		err = sk_setsockopt(sk, level, optname, optval, optlen);
+		err = sk_setsockopt(sk, level, optname, optval, optlen, false);
 
 		if (optname == SO_RCVBUF || optname == SO_RCVBUFFORCE) {
 			sockopt_lock_sock(sk);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 505445a9598f..7b12cc2db136 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -306,7 +306,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 			return PTR_ERR(ssk);
 		}
 
-		ret = sk_setsockopt(ssk, SOL_SOCKET, optname, optval, optlen);
+		ret = sk_setsockopt(ssk, SOL_SOCKET, optname, optval, optlen, false);
 		if (ret == 0) {
 			if (optname == SO_REUSEPORT)
 				sk->sk_reuseport = ssk->sk_reuseport;
diff --git a/net/socket.c b/net/socket.c
index 9a8e4452b9b2..4bdca39685a6 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2385,7 +2385,7 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 
 	ops = READ_ONCE(sock->ops);
 	if (level == SOL_SOCKET) {
-		err = sk_getsockopt(sock->sk, level, optname, optval, optlen);
+		err = sk_getsockopt(sock->sk, level, optname, optval, optlen, false);
 	} else if (unlikely(!ops->getsockopt)) {
 		err = -EOPNOTSUPP;
 	} else {
-- 
2.37.3


