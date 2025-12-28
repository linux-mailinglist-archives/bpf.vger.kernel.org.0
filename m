Return-Path: <bpf+bounces-77455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 491D9CE036E
	for <lists+bpf@lfdr.de>; Sun, 28 Dec 2025 01:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A6E0300A372
	for <lists+bpf@lfdr.de>; Sun, 28 Dec 2025 00:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E97D188735;
	Sun, 28 Dec 2025 00:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6CjO9ps"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F30125B2
	for <bpf@vger.kernel.org>; Sun, 28 Dec 2025 00:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766881361; cv=none; b=bv073fFGnuYvlf0RbwZQ8/EOWpzWo1rErJuWQHGi3X51ifpFZ7J81eSumb+LlG4j85oPI82akrDlKiQerpN6sZ0ena+RxUZyXc7OYjrhwjdJn4vXCqjRnbu5KqXgxWub0MTwNjn0kZK+pEEg52/PL4lGvbQe31MTkUPKnWoBmOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766881361; c=relaxed/simple;
	bh=/SKKvgsLGniObPBxFPopatBIfoDqwwrSrjjCxZm4YGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iDyynydK2Vxv5Qjno4E5SFOxKKjxTvkg9OlvQb+e2UihWULMRxirtNEWqMFR4iPDjSo1PRqJMO2IrhYPLsmwtdsCg0X7LFmbjKzTjJPG8tYitzid3PXgiumNb5r+pmIbi8iuFba2v+hpMozFw2zYn09AvL3rSoA32vbW4mGFTfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6CjO9ps; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0d52768ccso100263365ad.1
        for <bpf@vger.kernel.org>; Sat, 27 Dec 2025 16:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766881359; x=1767486159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYFmtcwmaCGVVXH0ahGN7yObA268AiZf0dtJQGnUA9A=;
        b=h6CjO9psXMbdO/pvswD2o1U6++jYc47JNxyWrwmCP6/RJ4J//c+Rl5NYsGfLzAuZUM
         CE1QQrNDTHsViNSHpT7PYO1E691OAAF/Gv9dMb5hyIJYMVo0OmXXXsUohNn2epigkNSH
         j8qoNxCfdGK7vJA4A4gQIG6fqeAJ7usnVxyoQ4BLlCjTs3BwRQiRXx5nP3egJ0IMGyEN
         qluTE12HdmNo4GUsB0FRdPmhKCrkeGrSCH4DFpgY9UORQzdaYSkQ8hotBNPyf2kzLeXJ
         4JnYXS1KTqDoucPVraJchYvsJkg8oW6LXoU6nohECRS9GSUweq7nDk6hpL3RRYqm1AUd
         8IsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766881359; x=1767486159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EYFmtcwmaCGVVXH0ahGN7yObA268AiZf0dtJQGnUA9A=;
        b=r3lUYBI9baXVgXQo8BdiYXSdRyHnhu3ALk1IiQzjfqRlqvN+cPEDlmnd4rpsn9t6/n
         jBDa10CwPfbbKYPnPH6Eax7pPO4+qzGt8TZdk8x1kUwVme44wocN9dlfP2uouyqdDkrw
         3CI/4kmWqIyy4BoIPhT7VKJE4CIFAl1VxCB3d5mkajeKKGw8OG72adCNzkv3GH3EW8qM
         l/LNsboi0rIWxqiinRPLjNmZrIB9h8Go+PI59V2QaZ6bRTOA3nbAyxl3iNn6Zyj94I/y
         h+1Ia7Fnyt5sXj8p0Xldup1gil/R/dPy98fKHtlfu7AoG7NbQcNWjc4mUgNsRlk2TbPq
         LTPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRyvPBF7QP1oarx7/P/3clWnFy8x88LnmR3mz7dvcICK0OR04LO5zt9zZ6zJr04bZgeMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt1tqap4LIYleNa/5yWhSJmydp59iS6NbdxBgNIfxfLvGYDZIv
	1rwewxm6KYHVw9w3I4cUZ0AMzwHqmMdui+NrMrGFyMd6dociYS4XhyTT
X-Gm-Gg: AY/fxX4zj38GntdXYZ6r9zEyrt1Q+1SYbq3w/hY1pdl367ZfqIHeKIVr9rFZpC48uP7
	YvkhjCv5ok7vSGYy4/+88c950zKGgVJujSwDwTaNfUykXvMmitWvWQRYNsl4ZTqs/HzTBhWgpyi
	7yyU53xaKsBfuf7SY8xcF23HDJ6ZG2nhVYRdzQuBff9xeO0Nez8edDTtsZZ+d21L0LSE8DtB3Vd
	DxQvgnxi3OfFwU3XNbeYe3vWPGuVLe72CTDrY/29Tufd62udhzdgoE36E53YqHiv4CULNtg1ra6
	+Qv0oC5CePghPWsC2gXIjzDsWgCear9Z4vzHpfWe4oIBJ/DOFFYMC+aVs2svCVxVRogy7kE5cpN
	HRQ1OpQKeggnhf7tnUAsv9hZwxrdiFDfVpcyTpQmto2v1QeOkPaBkZ49XqphHOK0naHBbp1WpIs
	JAQ27TFYVHnRV1aC3t
X-Google-Smtp-Source: AGHT+IEabNDQ1jAtV42QIGgfCGa/E7vYNR4IeTg911qnY+ht3AZp8OXR0jF9A3A0OYifKUGPpVJ2cw==
X-Received: by 2002:a17:902:e884:b0:298:1288:e873 with SMTP id d9443c01a7336-2a2f2a3eb0fmr250994455ad.56.1766881359451;
        Sat, 27 Dec 2025 16:22:39 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:70f5:5037:d004:a56e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d7754asm236533535ad.100.2025.12.27.16.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 16:22:38 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: hemanthmalla@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next v5 1/4] skmsg: rename sk_msg_alloc() to sk_msg_expand()
Date: Sat, 27 Dec 2025 16:22:16 -0800
Message-Id: <20251228002219.1183459-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251228002219.1183459-1-xiyou.wangcong@gmail.com>
References: <20251228002219.1183459-1-xiyou.wangcong@gmail.com>
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


