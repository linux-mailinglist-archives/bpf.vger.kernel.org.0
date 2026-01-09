Return-Path: <bpf+bounces-78301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B36D08D16
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 12:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09AD23045F5A
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 11:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8179A335BC6;
	Fri,  9 Jan 2026 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e6u/lY3j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A539D338931
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767956860; cv=none; b=CK6D+Vf/q+ouMurxAG4/A0+GmAbA7WQCxKXQ8/L2qW6HV82WsYXaUGoRV74f09ujBMF1fzYcKwnLsEP5DWSFpelEjMkX5Iu5Gm9QPBtH4JOP84zAEJZ9ASh2O4xPZLjxYauMD+O3hhqk8lAdfOTzVsRMcchLfA4sG8es9SXiz6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767956860; c=relaxed/simple;
	bh=bClo26dKQKfmtH6wmORSjwie/4l4DK0i8SN38XFShIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RbPhx7VPQoV9AuAg9f2iZ5TFnLuKSD5Yh7uC4wGG3XJBeMdNy1O6wbAgAeFObzrWrRgRNpK9H86y4Sogo6Urv82W/MSwJzKqNbYcGfOhFqxT3EXd6FYESbkV8uqqkO/hcyeNz/tngFrkPq8LHnK4OME+hN4rCat694tze1FZLEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e6u/lY3j; arc=none smtp.client-ip=209.85.160.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-4ffbc2b861eso26146141cf.1
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 03:07:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767956857; x=1768561657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eD5pHYGilsMyb5v5eXOJGZgBHsDewfP3AwzPbcKcT5s=;
        b=vJeHU7DJhc+6/+0p5u/tZEgKXAnqVrXIGx0csqEvjY/XUNGLnw2hFVpV/dh60x7wcf
         zCTExugQKAC5cfmySZ3hxEr8n1knFA9QApyESdejqGdzH4oDx3uju0/1+ya81to+hL48
         /1CVsOPb+KLfMiMsqYbxsZQI9oRZ+QjmUXrZcc49vPpOlRLN0abDLdvhYcNiPdU6kpMm
         NHobYKhiZOvFWWQXl0V3pEv59LMggpFT95hAKkE3a4nUUrF2dfDvgMy43DXDW7YW/aWu
         BrTq9j8HlcSRW58WUkBKlkrhUEnWRg2cSE0OZdGyCNAXn+OxcAjL28ZiXLT0z1BN/CqZ
         Pqog==
X-Forwarded-Encrypted: i=1; AJvYcCUz6yadQiJ4e+Cq2tsjYZ98I+gWlXE8lM0VJ/WQot1I555hkUxtmHHNll+Nlrr+n/Dhzdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6KK4RO4tzy8xgvVgiYQ+QtnVVrf9wEsiA5sclOuq+Y7vTFHxL
	dRQjM7T3ACggzdIhxBQuMHuojFy0HkduxcrkhX0XuRdmvc3RNMKLUsEv0eknGTfjlIUBEiV0wx/
	gzEhvaeO7tmsiTukJYJkD/j95s3vsIkM175syO+m0D7e2aUXFPvRcReoOz/nqjxaFQOK/qx60ky
	Rzg4IxLK0fttHmkzbE+3mK6b3n+iJ7bdaqqrY8e2EM4eIS0Ahl24dBd2KCKHu4aGpZfXSxm9HTC
	hvH/PGdt796y2Al8w==
X-Gm-Gg: AY/fxX5aW/Kj3APfkC7F9yDqkJTxdVlP3DV9pDvlbFHFgN0ejHZiY/+QX7aQxX+5Ttu
	6oyNbTPTXQx8iSBMa1ZFgfZevWkdVfnBaIzTHDIO5SHrgjXEkiAdJ5YY1wt381Au4K36V1U0rib
	2xyNshFTGwW5Ck4hhfoqDATjCpycccpgVuyfBvyGcWcDPaEouaA3VtmpidJsU+2T73PL2VI/yuT
	xWIXe+MSoJbjpWVhafBBmwg/XErlSnhisM1qFbaXGPll0Dx4exdaXWp0Aq79SInI86WUHw8MtqM
	5G5iQqgQUP06lWralXQ2J478TK5Gr5bv4spNM6QNKQzBZTf7ml8Drjijaw9qPkJx/X4IznSxPAz
	wp+AWQTNV59ttPcDc0xrzVJas12cmKR++jcIdh7aCAkY4kIfkWfyT8leI4QWEZ+rjVVYtw0fzyY
	QPzDtZwv+chVxehKz6/xDUImwhAjbZL24TCDWtxuBmUUMTaWlgdlcLaBw=
X-Google-Smtp-Source: AGHT+IGwe01oPDNKG3IPPqxJppSqE14nDWVA40U6Gt61sgnS2MHbTqZQIhtGqn0VvVOu2Z4ox2o5IUeOnSwx
X-Received: by 2002:ac8:7fce:0:b0:4ee:1800:615 with SMTP id d75a77b69052e-4ffb48b77bdmr124056901cf.14.1767956857338;
        Fri, 09 Jan 2026 03:07:37 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8907715cdc9sm12662066d6.28.2026.01.09.03.07.37
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jan 2026 03:07:37 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ac363a9465so3245990eec.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 03:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767956856; x=1768561656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eD5pHYGilsMyb5v5eXOJGZgBHsDewfP3AwzPbcKcT5s=;
        b=e6u/lY3jiyHaefD2gMMsIPSsetyln1ny1Vsbu96XaS/t3uXU5mJx/Y3BE/Iky4nuAY
         UtQyGqLngUqAUmrqwPviYJrWPfxzG2YA5XCDj7DdZu9T+ws1CXYSjs5NA7spnr+eOXYY
         09Q2GES7lXRiWZPf8YNJLcQqaE1fWiXgsVRbc=
X-Forwarded-Encrypted: i=1; AJvYcCWrgQdBZ96frF10CmkbwXFCHoZCq52yvO49PLyd/8VUgUaObyJ9QB1Dd1quc962Lx3NHPw=@vger.kernel.org
X-Received: by 2002:a05:7301:7214:b0:2ae:5d7d:4f1d with SMTP id 5a478bee46e88-2b17d238b33mr8081331eec.1.1767956856161;
        Fri, 09 Jan 2026 03:07:36 -0800 (PST)
X-Received: by 2002:a05:7301:7214:b0:2ae:5d7d:4f1d with SMTP id 5a478bee46e88-2b17d238b33mr8081297eec.1.1767956855605;
        Fri, 09 Jan 2026 03:07:35 -0800 (PST)
Received: from photon-big-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1775fe27dsm8783818eec.29.2026.01.09.03.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 03:07:35 -0800 (PST)
From: HarinadhD <harinadh.dommaraju@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: john.fastabend@gmail.com,
	daniel@iogearbox.net,
	jakub@cloudflare.com,
	lmb@cloudflare.com,
	davem@davemloft.net,
	kuba@kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	kpsingh@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Eric Dumazet <edumazet@google.com>,
	Sasha Levin <sashal@kernel.org>,
	Harinadh Dommaraju <Harinadh.Dommaraju@broadcom.com>
Subject: [PATCH v2 v5.10.y] bpf, sockmap: Don't let sock_map_{close,destroy,unhash} call itself
Date: Fri,  9 Jan 2026 10:20:11 +0000
Message-ID: <20260109102011.3904861-1-harinadh.dommaraju@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Jakub Sitnicki <jakub@cloudflare.com>

[ Upstream commit 5b4a79ba65a1ab479903fff2e604865d229b70a9 ]

sock_map proto callbacks should never call themselves by design. Protect
against bugs like [1] and break out of the recursive loop to avoid a stack
overflow in favor of a resource leak.

[1] https://lore.kernel.org/all/00000000000073b14905ef2e7401@google.com/

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/r/20230113-sockmap-fix-v2-1-1e0ee7ac2f90@cloudflare.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Harinadh: Modified to apply on v5.10.y ]
Signed-off-by: Harinadh Dommaraju <Harinadh.Dommaraju@broadcom.com>
---
 net/core/sock_map.c | 53 +++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 3a9e0046a780..438bbef5ff75 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1558,15 +1558,16 @@ void sock_map_unhash(struct sock *sk)
 	psock = sk_psock(sk);
 	if (unlikely(!psock)) {
 		rcu_read_unlock();
-		if (sk->sk_prot->unhash)
-			sk->sk_prot->unhash(sk);
-		return;
+		saved_unhash = READ_ONCE(sk->sk_prot)->unhash;
+	} else {
+		saved_unhash = psock->saved_unhash;
+		sock_map_remove_links(sk, psock);
+		rcu_read_unlock();
 	}
-
-	saved_unhash = psock->saved_unhash;
-	sock_map_remove_links(sk, psock);
-	rcu_read_unlock();
-	saved_unhash(sk);
+	if (WARN_ON_ONCE(saved_unhash == sock_map_unhash))
+		return;
+	if (saved_unhash)
+		saved_unhash(sk);
 }
 
 void sock_map_destroy(struct sock *sk)
@@ -1578,16 +1579,17 @@ void sock_map_destroy(struct sock *sk)
 	psock = sk_psock_get(sk);
 	if (unlikely(!psock)) {
 		rcu_read_unlock();
-		if (sk->sk_prot->destroy)
-			sk->sk_prot->destroy(sk);
-		return;
+		saved_destroy = READ_ONCE(sk->sk_prot)->destroy;
+	} else {
+		saved_destroy = psock->saved_destroy;
+		sock_map_remove_links(sk, psock);
+		rcu_read_unlock();
+		sk_psock_put(sk, psock);
 	}
-
-	saved_destroy = psock->saved_destroy;
-	sock_map_remove_links(sk, psock);
-	rcu_read_unlock();
-	sk_psock_put(sk, psock);
-	saved_destroy(sk);
+	if (WARN_ON_ONCE(saved_destroy == sock_map_destroy))
+		return;
+	if (saved_destroy)
+		saved_destroy(sk);
 }
 EXPORT_SYMBOL_GPL(sock_map_destroy);
 
@@ -1602,13 +1604,18 @@ void sock_map_close(struct sock *sk, long timeout)
 	if (unlikely(!psock)) {
 		rcu_read_unlock();
 		release_sock(sk);
-		return sk->sk_prot->close(sk, timeout);
+		saved_close = READ_ONCE(sk->sk_prot)->close;
+	} else {
+		saved_close = psock->saved_close;
+		sock_map_remove_links(sk, psock);
+		rcu_read_unlock();
+		release_sock(sk);
 	}
-
-	saved_close = psock->saved_close;
-	sock_map_remove_links(sk, psock);
-	rcu_read_unlock();
-	release_sock(sk);
+	/* Make sure we do not recurse. This is a bug.
+	 * Leak the socket instead of crashing on a stack overflow.
+	 */
+	if (WARN_ON_ONCE(saved_close == sock_map_close))
+		return;
 	saved_close(sk, timeout);
 }
 
-- 
2.43.7


