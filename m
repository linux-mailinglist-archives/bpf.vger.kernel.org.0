Return-Path: <bpf+bounces-52254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C511A40AF8
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 19:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B432177B37
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 18:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8EC20B81E;
	Sat, 22 Feb 2025 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrLtDS02"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E252770E2;
	Sat, 22 Feb 2025 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740249069; cv=none; b=sYJMRBZ/E5aTFOfehslEr3t+IFXtHA7oMviLlTvjy9SSKsVjs2nRST3GX61kvDfSG17YAAW2/Ti2bHKt6K9AI1iweNyJs7lB9vUKePIq1A9zkaKYXf/3iI2cOe7naMntz9EX1S4nHuK5HDaFenttpC3M1kvTfDBvyOftUw/bKsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740249069; c=relaxed/simple;
	bh=38CB9debAPDMQ8RDwySRO3SUuWp+lyyWDRiWwde74vg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OtFClFpTWxNZSjcFGNTA9eORY/nYT/9id3vfiOpbsYGmt3GLaAJxfR2kKGqvvjP1equHZhnhjsMU9xLf9R5xnWPaK9YBQSnW4qZKgh76BIJjWXboVCG0Q+0kQLpt7x9oGzbQTfHv8/QW0U0Hj7aJczD3JR10hUegYD2fPSuRyqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrLtDS02; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21c2f1b610dso91368975ad.0;
        Sat, 22 Feb 2025 10:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740249067; x=1740853867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onrvRy8A9CruBPz6kTY9C62B6nelGllJawVsW5K9X8c=;
        b=jrLtDS02NYnMrrr2mxF8pMfqZQJW2jtCEdrxXWMJ8WawIJ5+0rF1u31t0xDpTJmn4w
         s6ewkMMnJYxgBzoyXFtiHbqp6kar8FFHAKXBW6fL6C9beeafwALgR803/qlWXWQ4tGgL
         YW/FAHIc0CZ/Kxn8IrhU38AVewowzdIo9XgTRb4998nkeXmJGJmL0a1FPUy6uNyyq/SH
         2oGoS4xV4NRdTsdOBmiqted0ast+iJLg20Mm9P9A4fzQMTqManu5yLa6tTTOZK1XBhXh
         bvY/PBGbe0Nc5pWZN/le2JPsvaVV7DWQ9wy/oY4LEgl1KFv4r3XxEBs9fN2ICTZVAhjS
         cfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740249067; x=1740853867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onrvRy8A9CruBPz6kTY9C62B6nelGllJawVsW5K9X8c=;
        b=eqXXMbWA+QJ8FUfY6ukRlptrVLEe2e7eUPdvjg28Y2sSri8pz5Zh0J/3hbTDtjy1Hp
         4R8Fju3dVRk8VD56Z2E09ny8AqholxR4/qDuSvp9lQmnx2+KYi8KYrinIzOg4bgHUKHf
         8Kh411ylPoOJ4I1NgGTpmwM2Uc0oPDcDI3MEpwdJ/IDB5CnvVhVNWToRJJXLNKNTiQ3Y
         rkeFgYomxcdP7g+e5yLxtEU/jYs1CemVqoCm4+z8Dm+DsChO4P03SX1ZrFEBHajVevMN
         Kr9AUtEG9h1Gwo9bnyjXPb8n6eaRI1XRq7D2TmdDVQ1Xic6oaC7aqIrEpcbGfoXmdnSM
         G62g==
X-Gm-Message-State: AOJu0YzSLjYOR9WWpYwA4d+m3Y0awdIMsolQfrjnOu9uWGl/44r03ugo
	QghS2JF+U8wEqP0dRlbgbySzriuFNhPuUPKcrzmMsGhFytZck1RjFDUJkQ==
X-Gm-Gg: ASbGncubtvX1SxGHkk+pFinEYDlBhado8mVrJ7hNpzAPLsIgL16niL7mEvkVOb86Zd5
	2MmUsnD1p/o+l67oSnu9LsLnCGJhbK2SNGmT+BUdafwTzVDXuQo7I9i/mU2W38V+DW/LIvnzeAn
	InL4axDZv9R5Bw5q5VJqeUpYq1lzsKJTMfCKM3KpGLWbp25lLjpsfIJdSCZJUCsXipHtJ+z9/O7
	GzS8/lOaZNNfhGy9KPFcwgR/Uw4yct8Dr3+PzWDkHsLH4ajfzeY8B5tXv6PKemsS6GpmhG9sjeY
	FCyQbmdC99PFpNqAs+y3uqzcdMJRfWsllBFsf1ZCrdtSu1FJyn4sn4I=
X-Google-Smtp-Source: AGHT+IF4gPyQpGKGTxrJexorYqQEqUew/Tga5Xx7dnnIRcN2cxD5qAUAmisU+M/bXeJ1eMsBuWdxPw==
X-Received: by 2002:a05:6a20:1593:b0:1ee:efb2:f68c with SMTP id adf61e73a8af0-1eef3c9ae11mr13042831637.12.1740249067009;
        Sat, 22 Feb 2025 10:31:07 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:2714:159c:631a:37c0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73250dd701bsm16442959b3a.131.2025.02.22.10.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 10:31:06 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	zhoufeng.zf@bytedance.com,
	zijianzhang@bytedance.com,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next 1/4] skmsg: rename sk_msg_alloc() to sk_msg_expand()
Date: Sat, 22 Feb 2025 10:30:54 -0800
Message-Id: <20250222183057.800800-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250222183057.800800-1-xiyou.wangcong@gmail.com>
References: <20250222183057.800800-1-xiyou.wangcong@gmail.com>
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


