Return-Path: <bpf+bounces-68050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ECBB520D4
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 21:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260B23A0883
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 19:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E98E2D6E52;
	Wed, 10 Sep 2025 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B3Hz7mOP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3BA2D592E
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532065; cv=none; b=G7DFC1z1eC/ddFRxcn0eDChW25XA80kScUeJcRvHSehrfF2nVVm1UI6jy6qZm/WMVVvOntuu1eavBFGV6qFXsYXMDqcdCxWNfxcIvLAd38JvLjKSrmihvcsUlHH/CIFZzPllTTWbxd7gqOd9I9QyYQLPiqNiARg2418xgihlNPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532065; c=relaxed/simple;
	bh=v3w2SS7Kkrv52T8FXm7oOh2uz/3H5kSOug5YVI7wCT8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c8PkfCCe6k/9lSHYd4reH7hLcO3ojqGb5psEf64j7+6xR19teG9ihxN1LUa1Pkm/CL7DJ1JFRSdGoa5JgJhJStnKWWMaDIFrmzdcZF05E4pWUv6hlzfsFgTOM0QPoOSu98UiC351KkV1xNUH9TlxbbgzlKl3yRxatBXC9D1v/+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B3Hz7mOP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-329c76f70cbso6975033a91.0
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 12:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757532063; x=1758136863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9BeVPATa3pZCn8jXo+/vosY7DTRyTcrn7DL+ZXvQULA=;
        b=B3Hz7mOProSZagSt8jrhLR0hVBEWlC4tx/iKgeyhSJJL594NLKpLf5BhHsQn50wAFZ
         CkJ+8OOCTACkDk9mKQnKtgMobYPP8yDvWAvpuItS1eg2wqD7SpLmvx+F83ZfTBptWm20
         alMgxbstbXumayn74FGdGH0bGfaFt6N8CAq5QaNOg0fVivix0Uk2NFQHHQH7a8H4USym
         vrQUHzD0l9J7MmcazqV/tbS78VJSt9CdFXp7UUCGHAo8/peNIZ18uLr8Ayo7ZdM47ePq
         LOxvWPHyHwSMjnSNsR0Mh69Qu04Wd2kUiPaCqV18iF/8sskyceMogrlYBn5jwBC22T7o
         k6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757532063; x=1758136863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BeVPATa3pZCn8jXo+/vosY7DTRyTcrn7DL+ZXvQULA=;
        b=n7OzdutVV7XLUh19I2TV3glCK/ZmAvvCUcO271z5DcHB8JHuw2/0CKAXt59i59Yzhm
         HMsxxPfg15bwGCN6+XAj1HqUucurmvAe32fCghN6BVGLkpRSY+lakyQvKmknmxGOoEhG
         PVENk4AXqFfD2kLBcQ3yaJUcDgSjSogvq/Un5GWQPvxYEsUdefYsq8Fj+ZsjbXxD5atF
         onFX18eXKCr2aRWnNr15dpsYiZx2XDP/yWFmxIV5JDpC3MYjuFdVuRBwZrYO4JmJ63XT
         Lv4kNxHyxV9PdXupXKRE7vz0KsX9AGgSAsckLWcoyodTqSx/RVsx0R17LqfhT/UT7p5g
         UmVw==
X-Forwarded-Encrypted: i=1; AJvYcCWuSYPtD8d2tz2pyaryfhcY1Tt5CWmtfZz7rP8G/x2wCOxagcuS/BfRFsF3Hgl1A3CaFz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG/Fiyia0rnlPqJ2/OquMFLXiEbYy/OKuSIipPg44OW1b2tev0
	dTRIAxFNTzKRni/xd9I+/pmHigsHVgXvRwc9KU0dEO8mlSP6SwU9e1B9iqWqpEmU4FZg1XVyyOc
	Pby8xeQ==
X-Google-Smtp-Source: AGHT+IEmdBpzxU3WojpaskD2/ZwSSvaHPOxSFAZiWaQBw/fTIUa/CJTIqVsRYUzTyyIrPadhEkbU6TGW9GE=
X-Received: from pjv13.prod.google.com ([2002:a17:90b:564d:b0:32b:5ea2:778])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b4d:b0:32b:7d03:96c5
 with SMTP id 98e67ed59e1d1-32d43f81ae9mr17891879a91.28.1757532063508; Wed, 10
 Sep 2025 12:21:03 -0700 (PDT)
Date: Wed, 10 Sep 2025 19:19:28 +0000
In-Reply-To: <20250910192057.1045711-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250910192057.1045711-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250910192057.1045711-2-kuniyu@google.com>
Subject: [PATCH v8 bpf-next/net 1/6] tcp: Save lock_sock() for memcg in inet_csk_accept().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If memcg is enabled, accept() acquires lock_sock() twice for each new
TCP/MPTCP socket in inet_csk_accept() and __inet_accept().

Let's move memcg operations from inet_csk_accept() to __inet_accept().

Note that SCTP somehow allocates a new socket by sk_alloc() in
sk->sk_prot->accept() and clones fields manually, instead of using
sk_clone_lock().

mem_cgroup_sk_alloc() is called for SCTP before __inet_accept(),
so I added the protocol check in __inet_accept(), but this can be
removed once SCTP uses sk_clone_lock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
---
v3: Don't split if blocks
---
 net/ipv4/af_inet.c              | 23 +++++++++++++++++++++++
 net/ipv4/inet_connection_sock.c | 25 -------------------------
 2 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 76e38092cd8a..d42757f74c6e 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -753,6 +753,29 @@ EXPORT_SYMBOL(inet_stream_connect);
 
 void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *newsk)
 {
+	/* TODO: use sk_clone_lock() in SCTP and remove protocol checks */
+	if (mem_cgroup_sockets_enabled &&
+	    (!IS_ENABLED(CONFIG_IP_SCTP) ||
+	     sk_is_tcp(newsk) || sk_is_mptcp(newsk))) {
+		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
+
+		mem_cgroup_sk_alloc(newsk);
+
+		if (mem_cgroup_from_sk(newsk)) {
+			int amt;
+
+			/* The socket has not been accepted yet, no need
+			 * to look at newsk->sk_wmem_queued.
+			 */
+			amt = sk_mem_pages(newsk->sk_forward_alloc +
+					   atomic_read(&newsk->sk_rmem_alloc));
+			if (amt)
+				mem_cgroup_sk_charge(newsk, amt, gfp);
+		}
+
+		kmem_cache_charge(newsk, gfp);
+	}
+
 	sock_rps_record_flow(newsk);
 	WARN_ON(!((1 << newsk->sk_state) &
 		  (TCPF_ESTABLISHED | TCPF_SYN_RECV |
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 0ef1eacd539d..ed10b959a906 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -708,31 +708,6 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 
 	release_sock(sk);
 
-	if (mem_cgroup_sockets_enabled) {
-		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
-		int amt = 0;
-
-		/* atomically get the memory usage, set and charge the
-		 * newsk->sk_memcg.
-		 */
-		lock_sock(newsk);
-
-		mem_cgroup_sk_alloc(newsk);
-		if (mem_cgroup_from_sk(newsk)) {
-			/* The socket has not been accepted yet, no need
-			 * to look at newsk->sk_wmem_queued.
-			 */
-			amt = sk_mem_pages(newsk->sk_forward_alloc +
-					   atomic_read(&newsk->sk_rmem_alloc));
-		}
-
-		if (amt)
-			mem_cgroup_sk_charge(newsk, amt, gfp);
-		kmem_cache_charge(newsk, gfp);
-
-		release_sock(newsk);
-	}
-
 	if (req)
 		reqsk_put(req);
 
-- 
2.51.0.384.g4c02a37b29-goog


