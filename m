Return-Path: <bpf+bounces-76507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96293CB7E07
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 05:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC12830389A7
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 04:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D055630DD3A;
	Fri, 12 Dec 2025 04:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Uzj/D/Hb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309D530B538
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 04:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765514471; cv=none; b=M6T4dCXko+58WpFC4DxQhPd1BXCmp4u2X1eo/oCi9eiLiGag3Vf/n9RaM3M84PZkC8NcdnH/zX6X4RZr8PEnMzNOAfjS3d6cjDxXQYnf40YLJiMUJ5kBUZflSNlpVvaEAgmVAMdvXjnJ7V/1hYRA3WbRLd5EGx9a7pOOq22Zk6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765514471; c=relaxed/simple;
	bh=tKseG5gYSJeCAWspW2ZESEYmrC1AP47UvmldaZPNzNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NMWn6dKWjEbRKVt6yxuskyr9xESKcRaWcLFwWJcwdkgqmRqy8lPdMkvXE5ENgV7TsFoTHdc4nMjl2y5dBZunZiGs9jIMPPVhRq01culT4tiXrqyL+BWD0e4knL2elB1JxT3ARXdiMoQRexehKqC9SbRq9ZOUJaUeB3LVzktKbyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Uzj/D/Hb; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2984dfae0acso12969625ad.0
        for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 20:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765514467; x=1766119267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZSzbAqILqIc0sgDWu53ygkH2B1txzwb9FnKFs2Xg3k=;
        b=NLpnaIG63ih6fbnZQSFneQsjPOLDbuj/grsdKgpg9ibhTZyozaTRCwTsdT8df/9jCt
         evYxlcDrfxQQ4bddZhPb1IeLUey+qYd7U/jp3Ah7+5XZcgpZYdKOTy50skEh98ofNm01
         TjBEoDQJTxTsCEly+qO2r2Hl2fWUJyLOJliY+G3Sij/hKTmEH8Pg683CRzboNwijs4L5
         u+MrrDU6QZEHx550xdz5xfcPE6x1Gl0/AOJLc7rinXLO34hbkg7iOLmM9v2/F1yHQq6I
         /dzA+DDhTS7L9W0xoUlpY7t6DumFGPW74oklyZjktSEHfV1B9q2ecj7hV7+kAzFLZxu+
         FztA==
X-Forwarded-Encrypted: i=1; AJvYcCWUdW3FS9SdPHCHPun6XxmwREM3HtFXjjqFmT5axZTEINAXZi+mSZ4Eikf8EmpmvfUe/Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8spqfggflqwHeKuP+6Q4t81E69cuEFXRFCaFyoiLwc21oUtjR
	22fGM5BCL8y8MmDJTk+HaUzw+m6zY8NRX3Dy5HpvRu+P6T2n06JdtJ0s//TDTKKZYXISoUa3tM3
	G663Yk8Fw9dXQs1zDY6kWc0cYYbzgBQlVL1owbvcOzNO2SpFlOyp3vFsJQKRONgn1AYY1ZzYnd3
	eloKTflCzLWMlizivlGvEWkE1j+j3sMdj9l6cljJKN7K1vSl3EZupQV5+UKT/otBayjdtJyslSK
	YcYt1aee6+HFrh7CQ==
X-Gm-Gg: AY/fxX6Y8ppZxyOivSUd1I/F1QvdOJMB8AJzVv2WUAQ2o26ZGZ17mnsRp/Nj/YGhj9m
	ZnPpH5THnBNO1UItepoAA7tvQPK+XIXjS8iqKiX6lGyVfm7cyMx6QgTBSVf/uKxs9ePuqCQ8kQk
	HBlBZIzWzv3UiHV6XQdM5V4Wbe13p74uo4ExvYCPmc1Yd+xsRc4ENtPYCNzrTWV15UNVghzbgxC
	agkfvCRtvh3nIoukLrY8OGCWVUNeQpgU0Jj0zY5dqE1NS6S8GPRGrPMvC//8X/BYgCII3CtTRAF
	lQDeaKylLBXGAmK2CRhFmwtIikk06q7Qalt6BbS82KEV4pccXN0JCwierCshUagdRqn14x+iDB2
	Dw9PUCySmqADKBGK0TmC8D1/rCVIL/MgKr3UAjBr0k1Syy4Ud1IJcW9opPwmjZ3nMyfphz56b+X
	uHyT4bal/VPh4048c+OzDABcdG+OBpc2z9YJPx8TxccvnK1wnadw==
X-Google-Smtp-Source: AGHT+IGsWoRoHMc1T0yrBjQBibsTXyiBVgyareY0coLjzmcPqNIDXdBhLh4XlTNNm98yYCvsDRcvlhlcnCcw
X-Received: by 2002:a17:902:ec91:b0:295:7806:1d7b with SMTP id d9443c01a7336-29f23cc5446mr10290295ad.45.1765514467221;
        Thu, 11 Dec 2025 20:41:07 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29ee98cc339sm6535545ad.20.2025.12.11.20.41.06
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Dec 2025 20:41:07 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8bb0ae16a63so103895785a.3
        for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 20:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1765514466; x=1766119266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZSzbAqILqIc0sgDWu53ygkH2B1txzwb9FnKFs2Xg3k=;
        b=Uzj/D/HbJWi2EkH5T6/dgPumnDZDSsyIvSkgPtLb6vPge0pINJKG4i/6dShEJ24Bd5
         wdrYKk037nxUZfheRSgLhknTcRUb07uZOXv5+EM2JsmSQvkAjzUHtCWUscz+y9UHdUhb
         4JgaTz4QKpKNO+VTJftI9lTyXJCfS27H/Ue2Q=
X-Forwarded-Encrypted: i=1; AJvYcCWzPeN1lLto8UB0PxHvqj13BWxrkAYyYsklGlpDMZNAKds4tW6ZFvmka4XHOAAOLiGdsa4=@vger.kernel.org
X-Received: by 2002:a05:622a:106:b0:4ee:4a3a:bd08 with SMTP id d75a77b69052e-4f1d066fe70mr9249721cf.80.1765514465913;
        Thu, 11 Dec 2025 20:41:05 -0800 (PST)
X-Received: by 2002:a05:622a:106:b0:4ee:4a3a:bd08 with SMTP id d75a77b69052e-4f1d066fe70mr9249471cf.80.1765514465413;
        Thu, 11 Dec 2025 20:41:05 -0800 (PST)
Received: from photon-big-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5d3da25sm380483285a.44.2025.12.11.20.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 20:41:04 -0800 (PST)
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
	HarinadhD <Harinadh.Dommaraju@broadcom.com>
Subject: [PATCH v5.10.y] bpf, sockmap: Don't let sock_map_{close,destroy,unhash} call itself
Date: Fri, 12 Dec 2025 03:54:58 +0000
Message-ID: <20251212035458.1794979-1-harinadh.dommaraju@broadcom.com>
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
[ Harinadh: Modified to apply on v5.10.y ]
Signed-off-by: HarinadhD <Harinadh.Dommaraju@broadcom.com>
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


