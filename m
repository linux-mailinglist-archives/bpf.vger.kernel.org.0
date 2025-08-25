Return-Path: <bpf+bounces-66449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F45B34C2E
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 22:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866BD3A6F16
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 20:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D998E28F935;
	Mon, 25 Aug 2025 20:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BGN0I/DL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0602E28688E
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154524; cv=none; b=CswZ3d30Ejw/0Rur/SXFnSeN0y1oMqpHlzD2E0cnZUhnSUG/Ltngq70kZJ+dhL0dC+OMyDJpUtYh+2knaHZUSY8sua221DM2K/Eiokv/XBFB3O+GEqep5T/s5xXS8RfrDl2L6zTv06Ukbem24C0+39b78Wd9VVLQGIc1eI/XZbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154524; c=relaxed/simple;
	bh=t2uXTk1pLS4Luy02/pc3SHMEGWcheHdWampW0KCSalc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LiYxQILFm3opWR17nRACQbkpUqSfGzHjug7ojwmVCi/d26P6EsqpNtNPKdVJ4o1kl37wQfdX3+aEiitUJ5ZP5/q3LFepmApjZGGxIBRjjOluIddqrkWAgX8JmMmkKUQOMdfpZv9IWhEE3n8YYifehTT9Yygla9wthq1a04AUt1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BGN0I/DL; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3235e45b815so5539864a91.0
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 13:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756154522; x=1756759322; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8s/Fp0h6Ws4XXS2Nev/K+fGf/GQcJRH3EpbZihsvQOw=;
        b=BGN0I/DLO7PY0DX3toGVM65UG8HD8QCtGV2WlVrU1vfIDpPa0TwbUKVD+Z4xwRwynZ
         CQUxGouwbIAaLdRrAXpnJb0SuU8FShPt/rjtRxuBVeWo8Atp4+238ElWU9vLqMD2DflP
         eppkjaQ+4gFN9KoQvMZGPm3Xr28Miw6iATjJElqrO8TPXXuNKiHZ3PW7uV3lKz/rXa1B
         NniQ9f/Vq6+WkMfoL6asxlblM3SwhacAREPwVloL63KQED+pq0Kz/KMEGTEFYgKpcAct
         blKob2+vDC26EqQ+PdOqQl3HPOTk/aQ1Y643I384keHqAv2AustvVWmtA3kWJhtFG4br
         3r3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756154522; x=1756759322;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8s/Fp0h6Ws4XXS2Nev/K+fGf/GQcJRH3EpbZihsvQOw=;
        b=dnUAjcv2WUq1Bk9kaz00f9xwsed5xcP5DPFL4eXUkvmkJtaa4SEZjKhDUYuq5nCwHP
         vOhdPJgysSzV6i2H9EDiQGdQig1Oqcr7m9lgZeCf65GmB4Jjh6A2jERX9rvUUeIZadA8
         01ayBgjFlRjbecKSIoAsghqDqpc88DOo6sbs/+nvDCdoprBw/qUpFjgGmSsZqG+5Ogk+
         r6JI87lua1p3L9CBQSPDdMATRzS50TsKOtTnPtV/cp1nxu4zNx1wVWmuNm2UZZOsMQAX
         ihyWK4KfC0o51WvGCVxst2wA8pgVbkJM4lQy7zpAV8pYwGClX+/lJwSNNRrL9HumqgOv
         fnYA==
X-Forwarded-Encrypted: i=1; AJvYcCXHJksgY+ek94AjbRo0DOF+UeUMlXVE47WTCmojp4/zMY1HttERpyO+iuJ0Qs0fJcshZSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo3bRAPSkAowB1e1ceHJIep9v7Ta0BF/eydGAUnFayJKClVyjR
	fq34PuqBYgU1AT96Zrh62kpa3/2ZbPWOVB2D1az8XG9+FlzjC3LtiHnZUBCH1g9yHEHDqXjz8Q+
	3ywt4Tg==
X-Google-Smtp-Source: AGHT+IGKPOJ1kPotMBKzomItY0iv6NMql78VPepoyC7NHrIwNmN5RQa9Lb5rcEzUheY9DbdxBCgLEDSouHM=
X-Received: from pjzz12.prod.google.com ([2002:a17:90b:58ec:b0:324:eb0d:70e8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3905:b0:323:7e80:881a
 with SMTP id 98e67ed59e1d1-32518b82606mr19378190a91.37.1756154522239; Mon, 25
 Aug 2025 13:42:02 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:41:24 +0000
In-Reply-To: <20250825204158.2414402-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825204158.2414402-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825204158.2414402-2-kuniyu@google.com>
Subject: [PATCH v2 bpf-next/net 1/8] tcp: Save lock_sock() for memcg in inet_csk_accept().
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

This makes easier to add a BPF hook that covers sk_prot.memory_allocated
users (TCP, MPTCP, SCTP) in a single place.

Two notes:

1)
SCTP somehow allocates a new socket by sk_alloc() in sk->sk_prot->accept()
and clones fields manually, instead of using sk_clone_lock().

For SCTP, mem_cgroup_sk_alloc() has been called before __inet_accept(),
so I added the protocol tests in __inet_accept(), but this can be removed
once SCTP uses sk_clone_lock().

2)
The single if block is separated into two because we will add a new bpf
hook between the blocks, where a bpf prog can add a flag in sk->sk_memcg.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/af_inet.c              | 22 ++++++++++++++++++++++
 net/ipv4/inet_connection_sock.c | 25 -------------------------
 2 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 76e38092cd8a..ae83ecda3983 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -753,6 +753,28 @@ EXPORT_SYMBOL(inet_stream_connect);
 
 void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *newsk)
 {
+	gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
+
+	/* TODO: use sk_clone_lock() in SCTP and remove protocol checks */
+	if (mem_cgroup_sockets_enabled &&
+	    (!IS_ENABLED(CONFIG_IP_SCTP) ||
+	     sk_is_tcp(newsk) || sk_is_mptcp(newsk))) {
+		mem_cgroup_sk_alloc(newsk);
+		kmem_cache_charge(newsk, gfp);
+	}
+
+	if (mem_cgroup_sk_enabled(newsk)) {
+		int amt;
+
+		/* The socket has not been accepted yet, no need
+		 * to look at newsk->sk_wmem_queued.
+		 */
+		amt = sk_mem_pages(newsk->sk_forward_alloc +
+				   atomic_read(&newsk->sk_rmem_alloc));
+		if (amt)
+			mem_cgroup_sk_charge(newsk, amt, gfp);
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
2.51.0.261.g7ce5a0a67e-goog


