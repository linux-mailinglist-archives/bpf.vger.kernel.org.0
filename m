Return-Path: <bpf+bounces-41015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 633E99910B6
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 22:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72360283DD7
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EAA231CBE;
	Fri,  4 Oct 2024 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Hn8WQY12"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460441E51D;
	Fri,  4 Oct 2024 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728074255; cv=none; b=B+ASwD6eQpYLNytGAr938U6haq/vvToUkm1goiiZY/yTJcptW5kxGm54NuUZOGYoqt5QbmIGHd2vzT6ih817g1pqQQwBE9kyqZ3OHMQCOFRk2W2rGy7+cV6jY0jtKLbGQwLZwF3DbVh5I9swQL1NjIMVCX0sK/9KWgPcs60M3L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728074255; c=relaxed/simple;
	bh=5+5lkVZunnViCy42rdQBckFfT0Mmc1pSUyUpplhsRJM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OgNBlt+oJjuaHx1mol38GkDLrhJYtuHL1J4HYn/PJAu55bFWsSn0BDexqapIZtaQEh4dKjYIhXMX3WP/TfbnzwHWbIAzOPMaIT2bCbfoiUKyWZaGTeMRQN97ePttLAmTw5ZcgfR67wHm/vaocl53+XjhRIxaPqtTkheebOGqwig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Hn8WQY12; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728074253; x=1759610253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ky88xZ3OcqJJ6A1O5eX7bIGljIi3n9TyNluz00xw3OQ=;
  b=Hn8WQY12hCJ0O019+IB1fjvVKEQQ8RkZpAGDB2Mq9xS5/pJmp+4iRNxx
   fKepO3dow8JIo9dWwhSlzOMrNbYuWuFHquwCUOoon7+/ypIYm122gu0Fl
   /iSVHWK0tXTpc8zt22GDueqb0vgQ7rcRG5BEFTJboXf+Op7kG91ooAWV0
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,178,1725321600"; 
   d="scan'208";a="432684100"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 20:37:30 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:20663]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.41:2525] with esmtp (Farcaster)
 id 385f030d-cb8a-4235-aab8-99cbfa32b8e3; Fri, 4 Oct 2024 20:37:29 +0000 (UTC)
X-Farcaster-Flow-ID: 385f030d-cb8a-4235-aab8-99cbfa32b8e3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 20:37:29 +0000
Received: from 88665a182662.ant.amazon.com (10.88.184.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 20:37:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <martin.lau@linux.dev>
CC: <bpf@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [Question]: A non NULL req->sk in tcp_rtx_synack. Not a fastopen connection.
Date: Fri, 4 Oct 2024 13:37:18 -0700
Message-ID: <20241004203718.67792-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <341af7e1-7817-4aca-97dc-8f2813a086df@linux.dev>
References: <341af7e1-7817-4aca-97dc-8f2813a086df@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Thu, 3 Oct 2024 21:00:20 -0700
> On 10/3/24 7:02 PM, Kuniyuki Iwashima wrote:
> > From: Martin KaFai Lau <martin.lau@linux.dev>
> > Date: Thu, 3 Oct 2024 18:14:09 -0700
> >> Hi,
> >>
> >> We are seeing a use-after-free from a bpf prog attached to
> >> trace_tcp_retransmit_synack. The program passes the req->sk to the
> >> bpf_sk_storage_get_tracing kernel helper which does check for null before using it.
> >>
> >> fastopen is not used.
> >>
> >> We got a kfence report on use-after-free (pasted at the end). It is running with
> >> an older 6.4 kernel and we hardly hit this in production.
> >>
> >>   From the upstream code, del_timer_sync() should have been done by
> >> inet_csk_reqsk_queue_drop() before "req->sk = child;" is assigned in
> >> inet_csk_reqsk_queue_add(). My understanding is the req->rsk_timer should have
> >> been stopped before the "req->sk = child;" assignment.
> > 
> > There seems to be a small race window in reqsk_queue_unlink().
> > 
> > expire_timers() first calls detach_timer(, true), which marks the timer
> > as not pending, and then calls reqsk_timer_handler().
> > 
> > If reqsk_queue_unlink() calls timer_pending() just before expire_timers()
> > calls reqsk_timer_handler(), reqsk_queue_unlink() could miss
> > del_timer_sync() ?
> 
> This seems to explain it. :)
> 
> Does it mean there is a chance that the reqsk_timer_handler() may rearm the 
> timer again and I guess only a few more synack will be sent in this case and 
> should be no harm?

Ah, it seems possible.  I was wondering how the timer can be delayed
until sk is freed.  In such a case, the timer will just let the peer
generate some challenge ACKs.


> 
> > 
> > ---8<---
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> > index 2c5632d4fddb..4ba47ee6c9da 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -1045,7 +1045,7 @@ static bool reqsk_queue_unlink(struct request_sock *req)
> >   		found = __sk_nulls_del_node_init_rcu(sk);
> >   		spin_unlock(lock);
> >   	}
> > -	if (timer_pending(&req->rsk_timer) && del_timer_sync(&req->rsk_timer))
> > +	if (del_timer_sync(&req->rsk_timer))
> 
> It seems the reqsk_timer_handler() will also call reqsk_queue_unlink() through 
> inet_csk_reqsk_queue_drop_and_put(). Not sure if the reqsk_timer_handler() can 
> del_timer_sync() itself.

Exactly, it seems illegal to call it from the timer.
Then, we need a variant of inet_csk_reqsk_queue_drop() to see if
the caller is tiemr or not. (compile-test only)

---8<---
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 2c5632d4fddb..2623964d8817 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1045,21 +1045,31 @@ static bool reqsk_queue_unlink(struct request_sock *req)
 		found = __sk_nulls_del_node_init_rcu(sk);
 		spin_unlock(lock);
 	}
-	if (timer_pending(&req->rsk_timer) && del_timer_sync(&req->rsk_timer))
-		reqsk_put(req);
+
 	return found;
 }
 
-bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
+static bool __inet_csk_reqsk_queue_drop(struct sock *sk,
+					struct request_sock *req,
+					bool from_timer)
 {
 	bool unlinked = reqsk_queue_unlink(req);
 
+	if (!from_timer && del_timer_sync(&req->rsk_timer))
+		reqsk_put(req);
+
 	if (unlinked) {
 		reqsk_queue_removed(&inet_csk(sk)->icsk_accept_queue, req);
 		reqsk_put(req);
 	}
+
 	return unlinked;
 }
+
+bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
+{
+	return __inet_csk_reqsk_queue_drop(sk, req, false);
+}
 EXPORT_SYMBOL(inet_csk_reqsk_queue_drop);
 
 void inet_csk_reqsk_queue_drop_and_put(struct sock *sk, struct request_sock *req)
@@ -1152,7 +1162,7 @@ static void reqsk_timer_handler(struct timer_list *t)
 
 		if (!inet_ehash_insert(req_to_sk(nreq), req_to_sk(oreq), NULL)) {
 			/* delete timer */
-			inet_csk_reqsk_queue_drop(sk_listener, nreq);
+			__inet_csk_reqsk_queue_drop(sk_listener, nreq, true);
 			goto no_ownership;
 		}
 
@@ -1178,7 +1188,8 @@ static void reqsk_timer_handler(struct timer_list *t)
 	}
 
 drop:
-	inet_csk_reqsk_queue_drop_and_put(oreq->rsk_listener, oreq);
+	__inet_csk_reqsk_queue_drop(sk_listener, nreq, true);
+	reqsk_put(req);
 }
 
 static bool reqsk_queue_hash_req(struct request_sock *req,
---8<---

