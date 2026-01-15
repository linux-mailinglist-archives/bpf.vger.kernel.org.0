Return-Path: <bpf+bounces-79138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF822D28176
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 20:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADEC43080E66
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331F7302146;
	Thu, 15 Jan 2026 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNUNbSq1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EBA302767
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 19:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505279; cv=none; b=T7fpz3YillE7Z4gvTL3chrpXKuebch/zI+IUFWiD1aa/0ZCtTanCa0KiMtTjXhPSOCnaSX9HwY8cIsUZR79tXvzw+hoaX+EMY8Sg5ce4iU84XAPFP4enCo4/iY9yn30XNvymymw4UBV4H8XJ7WT6WfZQOqWpLoDo+iUo/E8TAQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505279; c=relaxed/simple;
	bh=/SKKvgsLGniObPBxFPopatBIfoDqwwrSrjjCxZm4YGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gY1XTUv4I4Ic99eIy2dsx6n3obJBuT4HjnkQzaopl/MCDgNN1mZ5TfiHroxdH7etxSxwrth9bZE5SKNvaz76hbGocnzO2ozoEjmPRuR/rd4TATqm/LSYSNP3ac6B0h0o6I8QU/c8j5xpj1FrV0AO4plDN0J+iWeMF2li5wrviDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNUNbSq1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a09d981507so8989445ad.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 11:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768505271; x=1769110071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYFmtcwmaCGVVXH0ahGN7yObA268AiZf0dtJQGnUA9A=;
        b=nNUNbSq1CJZqPwBEe/8QBa4qOKldeaJZ2+i/HABW09xIieHzTPSoDGbcQa/C+qIHYk
         V2qmuLycRPjK8kL2oZN7tdevVGt0T+kDvrbUXLSwj2pdgx+MXbOqabkwCO8EHzqAy55n
         o4o+SW+EIXx9AxjRUA6hLAD7h5VfLXr+Sw5U2jLIAH/FPRml/hmEx9eWXSTOwtT0ZxVN
         CRp2XSk1k11owLCUJZ8yQZQ3VqV+TZaU8csVeobHgHzb34iOfg0L83eyh30DInSp72LF
         c05zVeEXlZpzZWXKamyjGf+JvJHUZdMFSHTKneyxEQ7fJ8LoBtegOIzmhwwuIa2nU7Wm
         LSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768505271; x=1769110071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EYFmtcwmaCGVVXH0ahGN7yObA268AiZf0dtJQGnUA9A=;
        b=TT/lhJ8XHDtd3hJqH00Nl7VnwN+uKH0lQuhTY8+eQZ6ELIaA2b2GEgHlm1YntC4pfL
         WPSo++ROMo1wPM0TrTghYdaG5gyTEucZH4dDfOSvMhNZp/37GTH8Got1vUq4fZFZ1Bea
         HfRI9magytAWNTOjbXT9vGY2kqYPYaLd9NU8jFc4UlbaDRpecHRBRUhy1g/AKYd51oeA
         oz9XyDUFyZjbFySqDH7GwmHP/sNGVd6kgZcRemQJAyRe8DqwbWrzNWPr/1zMai5C+lqL
         dmiQPIpRSyzfdpZcMPcvWczgR7VxTpG5/BsFT591K3zZElS5iCwu7T3ZuwDthqqWjv+p
         /NfA==
X-Forwarded-Encrypted: i=1; AJvYcCV2KPhV61sTiMfly6QjzBrPGQIwqHtg/dfrgvTBAtgF3jr3rGg9yHZ6VFhHV2pbKuo7Nmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+kMuTgKDIjYWZ7V+Skq444NA4lFkuKjHBkZflE0dcrw49hIZF
	9gkYUrKbhESZ0aC+4uqm8KRKTOy0DySudQ7xBEhJUoVmIBN52K3jiGK7
X-Gm-Gg: AY/fxX5/dWamFEH9ERQcs50UOIDVv+ZiSGBw2cRctWLMzzOC3ey9N+Nr3QFCXvQKVJX
	gtIqzoemizN4+CtVeE9lmWshQmmKzOd79Br0+nsX5mmjljHs3RBNzoTCGBy0pUaCy/hIaAw69h1
	09qCL4vffGsnaWSXpe21XKrhpXGs3dx5uOUyspxyg/JT6CnS7f77NUrYsYmvF3z1BLVi5Wa5qAX
	bCQIguiSrAKQnzjI+kwQUrJKRMIkb/LFlTboojiQhrb0H6w6UxiPjWOV1n7tzIOB5fEnSwBIQsP
	6vPyo84MTJ+GNJ+rs9EHpiur5xDauoeNL/U/H4RN+I7lda4u7HmpwslabwHp5Ur41sczG5ZtXOx
	uSfFNerCki3Im+B8YnMK9oUONc9IucqTlag4OINIrYanlHREYAI50ZCpiHSGrCsb69oMDfJFiw5
	LTBHUtOFqMW6Urmvfo
X-Received: by 2002:a17:903:15c3:b0:2a0:d454:5372 with SMTP id d9443c01a7336-2a717809d61mr5308275ad.22.1768505271509;
        Thu, 15 Jan 2026 11:27:51 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:3874:1cf7:603f:ecef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce692sm876115ad.36.2026.01.15.11.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 11:27:50 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: hemanthmalla@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	zijianzhang@bytedance.com,
	bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next v6 1/4] skmsg: rename sk_msg_alloc() to sk_msg_expand()
Date: Thu, 15 Jan 2026 11:27:34 -0800
Message-Id: <20260115192737.743857-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115192737.743857-1-xiyou.wangcong@gmail.com>
References: <20260115192737.743857-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

The name sk_msg_alloc is misleading, that function does not allocate
sk_msg at all, it simply refills sock page frags. Rename it to
sk_msg_expand() to better reflect what it actually does.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 include/linux/skmsg.h | 4 ++--
 net/core/skmsg.c      | 6 +++---
 net/ipv4/tcp_bpf.c    | 2 +-
 net/tls/tls_sw.c      | 6 +++---
 net/xfrm/espintcp.c   | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 49847888c287..84ec69568bb7 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -121,8 +121,8 @@ struct sk_psock {
 	struct rcu_work			rwork;
 };
 
-int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
-		 int elem_first_coalesce);
+int sk_msg_expand(struct sock *sk, struct sk_msg *msg, int len,
+		  int elem_first_coalesce);
 int sk_msg_clone(struct sock *sk, struct sk_msg *dst, struct sk_msg *src,
 		 u32 off, u32 len);
 void sk_msg_trim(struct sock *sk, struct sk_msg *msg, int len);
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 2ac7731e1e0a..0812e01e3171 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -24,8 +24,8 @@ static bool sk_msg_try_coalesce_ok(struct sk_msg *msg, int elem_first_coalesce)
 	return false;
 }
 
-int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
-		 int elem_first_coalesce)
+int sk_msg_expand(struct sock *sk, struct sk_msg *msg, int len,
+		  int elem_first_coalesce)
 {
 	struct page_frag *pfrag = sk_page_frag(sk);
 	u32 osize = msg->sg.size;
@@ -82,7 +82,7 @@ int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
 	sk_msg_trim(sk, msg, osize);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(sk_msg_alloc);
+EXPORT_SYMBOL_GPL(sk_msg_expand);
 
 int sk_msg_clone(struct sock *sk, struct sk_msg *dst, struct sk_msg *src,
 		 u32 off, u32 len)
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index a268e1595b22..a0a385e07094 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -533,7 +533,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		}
 
 		osize = msg_tx->sg.size;
-		err = sk_msg_alloc(sk, msg_tx, msg_tx->sg.size + copy, msg_tx->sg.end - 1);
+		err = sk_msg_expand(sk, msg_tx, msg_tx->sg.size + copy, msg_tx->sg.end - 1);
 		if (err) {
 			if (err != -ENOSPC)
 				goto wait_for_memory;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9937d4c810f2..451d620d5888 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -324,7 +324,7 @@ static int tls_alloc_encrypted_msg(struct sock *sk, int len)
 	struct tls_rec *rec = ctx->open_rec;
 	struct sk_msg *msg_en = &rec->msg_encrypted;
 
-	return sk_msg_alloc(sk, msg_en, len, 0);
+	return sk_msg_expand(sk, msg_en, len, 0);
 }
 
 static int tls_clone_plaintext_msg(struct sock *sk, int required)
@@ -619,8 +619,8 @@ static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
 	new = tls_get_rec(sk);
 	if (!new)
 		return -ENOMEM;
-	ret = sk_msg_alloc(sk, &new->msg_encrypted, msg_opl->sg.size +
-			   tx_overhead_size, 0);
+	ret = sk_msg_expand(sk, &new->msg_encrypted, msg_opl->sg.size +
+			    tx_overhead_size, 0);
 	if (ret < 0) {
 		tls_free_rec(sk, new);
 		return ret;
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index bf744ac9d5a7..06287bae8f9f 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -353,7 +353,7 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	sk_msg_init(&emsg->skmsg);
 	while (1) {
 		/* only -ENOMEM is possible since we don't coalesce */
-		err = sk_msg_alloc(sk, &emsg->skmsg, msglen, 0);
+		err = sk_msg_expand(sk, &emsg->skmsg, msglen, 0);
 		if (!err)
 			break;
 
-- 
2.34.1


