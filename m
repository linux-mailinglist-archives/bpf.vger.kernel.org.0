Return-Path: <bpf+bounces-28914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ECA8BEAC9
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 19:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46F86B22DDA
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 17:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E4316C873;
	Tue,  7 May 2024 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfpfA6a9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65FD1607A7;
	Tue,  7 May 2024 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715104082; cv=none; b=mrnzj+aIEoSW8HziNxQ5gVxse1vyU58dImm00thAj5FMatos3jKQjRZ+4qJrQPF2hvMxcBCeMdtsHl9GDPgJ2Vk+6FNr6D1BX+oEa68dQ3zbHnfuqIK4sOWsI+tpcpQTFhLJzbSdGV4BX97iBy9d4wk8IQImC7MWYg7pJ8R+BUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715104082; c=relaxed/simple;
	bh=JRzYTW1hbpACv/XArPGnNCXaVihUOrHzdm+ZCR9gGEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q5tCF9fXjy964X7PazRFYbUdPvd8DfrIjYQBcGXfqOtMdeMPMqaJFTLq7eEmGdgvJaBBl6JVIyoQbPsL5UjzIhIVVa+ITlZX/7fyRk1ovpmYgmmgUVgQD/WBenahVweJV+0Ae8MjOU4KFz7gmt+W0X9HArDPaxf+Rq6Bv4vji3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfpfA6a9; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b22f818a24so847024eaf.1;
        Tue, 07 May 2024 10:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715104080; x=1715708880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlKpfs+JEwOA0Qk2J2UEne/NBRJhiZf3MVtRU+wvPMc=;
        b=gfpfA6a9Fw1eNGMZf2BGs1j22ymrJLfZh3+w7iojHXH61BTeCu1xpxmpM1ymcVNPhW
         417rwS0oUKfa4cuwqSjgp/fN4itTxrDdRf/rUlEVoaApxLI3fZwvBQMHyMUiJQ524Hmf
         1ZLyJ67ctfoxPOPLxY4B00KCt/5fTV/2H7jkix66dWvtM1NTqB9zZDBhEglCmY76bhUo
         ywUwbP9pIncDb5MURJ8p40TTU+V0sXKXS0UTF9+DSEms3/APzcX9FnTlgopKFdc/Fb6q
         VYRvD1DAjdQnZIQKA0uV7WGYkt4gZSeAB7O9pbqwmWGdu+jMqMtYWzFJMmNlaVtrHYBT
         x47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715104080; x=1715708880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlKpfs+JEwOA0Qk2J2UEne/NBRJhiZf3MVtRU+wvPMc=;
        b=RwKixS9VGOw1tOHrcmoADN9m4geToMj3ptjhbcUt9BMA+LvPxkR4CxjFiMiJTNHpjp
         fdMgFM7vK+Mp0Qm/BNF+jAnhIHC+rLSYzyASzwNI7bqqzvZwevIx8rHmonpRvEbevyIc
         PX9M/dEwPDOhdyGgpzGemRYdPgnoye5icDtc9k+S1AlIfruRC74vgww4pZo25FIRNGqO
         G+dVxEdcJCQres/ornsMoNiW1DrghDSjJGk4hCOHbsl9qnkhcknn0KQLL4O+WWY0H23F
         7PxtWceuPeZkTMqNOOgc3N4iBrDHWGf9NJiyusEp2kjTIvu+aght6AMTZonhD1AIe2pY
         zXCw==
X-Forwarded-Encrypted: i=1; AJvYcCUSyacr6aXi4c4wymU8A4ophMDq9xa8HH/26ntC7zR7GIKu8QN0Fyshfqr8J3M40tWsw7qRAFePiqBips6JgaqFwYUP1G/V
X-Gm-Message-State: AOJu0YwlankeSVkjr3G3Daekww/MgN2lmBv/q0gPRh5RS+AcnTRVuoic
	1v6HnubTIzJ9WRBvyIAYvvE1KBYMtdAiufa0XDQSuUx+4WXfu0ChknhVoA==
X-Google-Smtp-Source: AGHT+IHKu1OuOwtcpRT6C6tx4T2zQps2i9LwIRGCyuxXr7NN9yR4rqKpvr4AB7WmSZ5jjacmfqV32g==
X-Received: by 2002:a05:6358:3114:b0:186:1abe:611e with SMTP id e5c5f4694b2df-192d367eba0mr44587155d.30.1715104079920;
        Tue, 07 May 2024 10:47:59 -0700 (PDT)
Received: from john.. ([98.97.42.227])
        by smtp.gmail.com with ESMTPSA id u34-20020a631422000000b00600d20da76esm9958611pgl.60.2024.05.07.10.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 10:47:59 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	dhowells@redhat.com,
	kuba@kernel.org
Subject: [PATCH stable, 6.1 1/2] tcp_bpf: Inline do_tcp_sendpages as it's now a wrapper around tcp_sendmsg
Date: Tue,  7 May 2024 10:47:56 -0700
Message-Id: <20240507174757.260478-2-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240507174757.260478-1-john.fastabend@gmail.com>
References: <20240507174757.260478-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit ebf2e8860eea66e2c4764316b80c6a5ee5f336ee ]

do_tcp_sendpages() is now just a small wrapper around tcp_sendmsg_locked(),
so inline it.  This is part of replacing ->sendpage() with a call to
sendmsg() with MSG_SPLICE_PAGES set.

Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: John Fastabend <john.fastabend@gmail.com>
cc: Jakub Sitnicki <jakub@cloudflare.com>
cc: David Ahern <dsahern@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ipv4/tcp_bpf.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index f8037d142bb7..f3def363b971 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -90,11 +90,13 @@ static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 {
 	bool apply = apply_bytes;
 	struct scatterlist *sge;
+	struct msghdr msghdr = { .msg_flags = flags | MSG_SPLICE_PAGES, };
 	struct page *page;
 	int size, ret = 0;
 	u32 off;
 
 	while (1) {
+		struct bio_vec bvec;
 		bool has_tx_ulp;
 
 		sge = sk_msg_elem(msg, msg->sg.start);
@@ -106,16 +108,18 @@ static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 		tcp_rate_check_app_limited(sk);
 retry:
 		has_tx_ulp = tls_sw_has_ctx_tx(sk);
-		if (has_tx_ulp) {
-			flags |= MSG_SENDPAGE_NOPOLICY;
-			ret = kernel_sendpage_locked(sk,
-						     page, off, size, flags);
-		} else {
-			ret = do_tcp_sendpages(sk, page, off, size, flags);
-		}
+		if (has_tx_ulp)
+			msghdr.msg_flags |= MSG_SENDPAGE_NOPOLICY;
 
+		if (flags & MSG_SENDPAGE_NOTLAST)
+			msghdr.msg_flags |= MSG_MORE;
+
+		bvec_set_page(&bvec, page, size, off);
+		iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, size);
+		ret = tcp_sendmsg_locked(sk, &msghdr, size);
 		if (ret <= 0)
 			return ret;
+
 		if (apply)
 			apply_bytes -= ret;
 		msg->sg.size -= ret;
@@ -495,7 +499,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	long timeo;
 	int flags;
 
-	/* Don't let internal do_tcp_sendpages() flags through */
+	/* Don't let internal sendpage flags through */
 	flags = (msg->msg_flags & ~MSG_SENDPAGE_DECRYPTED);
 	flags |= MSG_NO_SHARED_FRAGS;
 
-- 
2.33.0


