Return-Path: <bpf+bounces-53511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BEEA55939
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 23:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897CA189A1AC
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 22:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE05327C178;
	Thu,  6 Mar 2025 22:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLmjb60s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE43A206F38;
	Thu,  6 Mar 2025 22:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298564; cv=none; b=oFNF+FPnK9QhYKDh3LD3VQ5veHvB5+V3D+eWn04CRLtUZrLBfxP991BR2UyFgJbDob41ftInlq3JfuoGsh0+ivXeVHYZvIDKrREdQr5yw3r87oa7vfrg88knXWpy9J4CCRNkb05N1hX1NYnHGS9ZEH5mbg6aKx975Q1wrZ5dKPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298564; c=relaxed/simple;
	bh=38CB9debAPDMQ8RDwySRO3SUuWp+lyyWDRiWwde74vg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GzgaqyOgSf5NwHG++vXev9FOg1XqruK0q7lRVpwWsyYHoUim3oft4JBe1xGBpcxxf4SHYwoiHXaQ86vDwDL5DIaCCklsu/oklhjJHWtRwgpXJzshBFX8bun6mLevUzTeTG19aezEo1mnUzoPz6etUdWeWm68PjOvuSJ2EyiCqSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLmjb60s; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223f4c06e9fso23129135ad.1;
        Thu, 06 Mar 2025 14:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741298562; x=1741903362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onrvRy8A9CruBPz6kTY9C62B6nelGllJawVsW5K9X8c=;
        b=CLmjb60senMz0BT6GJIlNTZ2tR2eL0PoCMFi/InNXPGp+f0BsOYi/8A1bHyzb90yS/
         Lpg+npQBBbJSJ7TrUcGuMY3V8DLUejImrj7VM19eWIdBctVbq/K7M7YVs1lM4WWoiW6t
         N5Zj4ZwTdJ61U7fmalcnNFEcOMr5AOmhXaEpVLMFXcdx8JYtl+pJbO7fvGhkjp7I8FrT
         YzgUFa/WgpiOOet24W5ye4+ZsIjgErYfEFFmC5DJ9sjeeC6eTp39+MkJlZZYurtDjwZs
         xRNS0AwZxzEQToe4I9NjAuo3yYGa1EFU6Yc5SjkaiXv88uTauGy8ZDr/9wb3viPNhx1g
         Ir9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741298562; x=1741903362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onrvRy8A9CruBPz6kTY9C62B6nelGllJawVsW5K9X8c=;
        b=gpTEPBfvwKYKVQxQ2lou8MkG3FEHJYz2kHx3tEFp+h0Zy0hQPg6xQu6zSiUdSMrUhy
         SOYwzTuoMy+BXTy2cRUQzKMEguIVAsqc+YKX11spZ+OyWA/Eg5MIZhgET+8SRLKUwrBK
         BPxrGE3Ygp3lJSwq39tMmoVg63DZY4eUj3aWbDRGz7MAARgiueRrxjKGEOTKC6uNQjKh
         VuMTMz3OS9oaiGjUl9SLcmJLdWpmth0dwFk7p9hEtfPEvZAJVQu4/et68lpoZteJizIA
         hmCe4Vvstok1CruYhSoSgmOXyPfFBPgxttvoTOL5uq4o4axb0zphbAn1zuH+rxeqUkIh
         xgKA==
X-Gm-Message-State: AOJu0YxGFagsPAtckNxUjQqEmxWOPlXp+1UKfJc0n/vwMS2UHxcApSPI
	2gQHFG+A4ock9bBA12JEYzYrPrzdDSAz9er9R8uYS1IWWNRYOQLdawL79w==
X-Gm-Gg: ASbGnctUbufUMeF5jg8ueVejgJbqSWC+dOCgtPJb7sIkWTftpoq0hWyxzMSVp6OD4TT
	WceLFp2QmOoY+VClGFlt0NBx1NJrMOEE472TJl6v1eZNAXKEkWQZQ8lbbjuv7AvmkYNERxpBC6H
	guLM51wVnCQbdFoLAoSU8Gvfd3u7WuqCwZ88q/e07lsSzHX3x/d9mhaT7Rvk7qMj0abE+IufBRz
	U/CqIHa9dbCffOGjApds3wzAEQGGfV/hcddv7cbVKle9X1LqWrK+/ry19tGxofuNc5t7r4kM2Cr
	uoJHeg9PVQQ9DHrms+arT95fZXCb+9M++oRDESMe4h3Ffz8Hjw6e390=
X-Google-Smtp-Source: AGHT+IHjuMgqGSD1VP9dZt8z7KT/lfkxUK/fG71Yenlep20O3WnTOZObr83dYIJIESzVIclMhUm7xA==
X-Received: by 2002:a17:902:cf12:b0:223:fbbe:599c with SMTP id d9443c01a7336-22409476ec5mr87402055ad.19.1741298561536;
        Thu, 06 Mar 2025 14:02:41 -0800 (PST)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddfa6sm17478775ad.33.2025.03.06.14.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 14:02:40 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	jakub@cloudflare.com,
	john.fastabend@gmail.com,
	zhoufeng.zf@bytedance.com,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next v2 1/4] skmsg: rename sk_msg_alloc() to sk_msg_expand()
Date: Thu,  6 Mar 2025 14:02:02 -0800
Message-Id: <20250306220205.53753-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306220205.53753-1-xiyou.wangcong@gmail.com>
References: <20250306220205.53753-1-xiyou.wangcong@gmail.com>
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

Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 include/linux/skmsg.h | 4 ++--
 net/core/skmsg.c      | 6 +++---
 net/ipv4/tcp_bpf.c    | 2 +-
 net/tls/tls_sw.c      | 6 +++---
 net/xfrm/espintcp.c   | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 0b9095a281b8..d6f0a8cd73c4 100644
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
index 0ddc4c718833..4695cbd9c16f 100644
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
index ba581785adb4..85b64ffc20c6 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -530,7 +530,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		}
 
 		osize = msg_tx->sg.size;
-		err = sk_msg_alloc(sk, msg_tx, msg_tx->sg.size + copy, msg_tx->sg.end - 1);
+		err = sk_msg_expand(sk, msg_tx, msg_tx->sg.size + copy, msg_tx->sg.end - 1);
 		if (err) {
 			if (err != -ENOSPC)
 				goto wait_for_memory;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 914d4e1516a3..338b373c8fc5 100644
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
index fe82e2d07300..4fd03edb4497 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -351,7 +351,7 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	sk_msg_init(&emsg->skmsg);
 	while (1) {
 		/* only -ENOMEM is possible since we don't coalesce */
-		err = sk_msg_alloc(sk, &emsg->skmsg, msglen, 0);
+		err = sk_msg_expand(sk, &emsg->skmsg, msglen, 0);
 		if (!err)
 			break;
 
-- 
2.34.1


