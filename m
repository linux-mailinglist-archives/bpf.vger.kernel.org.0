Return-Path: <bpf+bounces-61924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 505B5AEEBD4
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 03:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA1F17D96D
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 01:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919B919ABAC;
	Tue,  1 Jul 2025 01:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jjo7Cef1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCF9155322;
	Tue,  1 Jul 2025 01:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332348; cv=none; b=QCjn9FjLjzx8T/52Xi04zLqBULQKtI64Gu1NwJ6PC0XOyhQlaj9XeqFO42Kq9FsrDJG4JTiJ/ZlUlYPxjiRvQlaOpgqEEbgnDS0aywb55fq2/ePtZxiY7YTv7JELnGiXcxfwcz2CWg8zkdSQWJ85CBURHEMidEMWQd8MV1s4KGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332348; c=relaxed/simple;
	bh=2lcDTKZHkNB1Y9IVx32Lb948hrio26ptoSFg1i3G+m0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TKY6GIg3g6wKfAcrwqOU2mOROPlKaOkFtsMQFBKFhR765GzOL5wfO4sl/OWDGQVymwChNKC9ZE1+OIb4x2gNLYw7YI6IKPGVUQn3Fol/05OTtCf9cKve2KiJWEhrvVI3giHIxhd4TnrH0RAcWUtU5EO8EWc9Xxmlhh9hbHGxhMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jjo7Cef1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-236470b2dceso21810555ad.0;
        Mon, 30 Jun 2025 18:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751332345; x=1751937145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKA/HEhfegJanA7fMDlhNI9W4/qSzXt5E+OwgAVMAm0=;
        b=Jjo7Cef1ThnZS/bpxdd+SsgYYcXvsW/1v1i6+8iUa2K9IchrcfmlwcVp711d+H7Sn+
         V75uiFcL98Mtjkpt9zPeAWwrZkkKseFAheGlROnRFMzruCnVEJHE2wWadSx2lDjlyvRm
         OIlXnrTquueByTtcUAdPIl7F7M4qaC+UfpbspLVzn6GetxYHm7qCykXCjuxE2/3DNrj8
         GAr3eZb/vTcKFITZrfEJXNJF2SCWg8+nlDqT/zC6c3F+4Wgi8VsOXznQRbWOu8ZpUXMD
         5vnVVYNtto/mYD+bAdewnXz0u5R/JsUilFZ+2QBqweWpEX/C7ElVcWcNkiWvqHVfZqrp
         rKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751332345; x=1751937145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKA/HEhfegJanA7fMDlhNI9W4/qSzXt5E+OwgAVMAm0=;
        b=tjS39jYhEHHyLhA9Ky9N/CiNH9fVLYAkvXJGkl5rEhSmDPp5IYRVjNcALsl+jaU4BF
         A2sv7pInRbePIuH9x+MvJmlzWjM4+J3j7z1qmnVVZdT7q1wi0tIKwBhBJ38xcy5y9/Pz
         1N+mCb0wGYdsNrFx1CMVVPR3i5muoLaqUCZLBAdOdgN4KOGeXmuJblIfs4wAa7ne0a/w
         wsIimjIx+h7dcv7L7ecPz0ujtv/JoKksva7X4hyvIY6pGWlPEOmZQWHkWRighsUyJ6NX
         iJvEpMDwlhYByTcFwIXmz7RAmWhbik2JwZnqhsh4a9/6jN3XmHQ0gXh1wFumhEo32pV5
         C3sQ==
X-Gm-Message-State: AOJu0YyuACHmnQj7LI51h6JJluKMd7y5YommxBK/pZ46jhZixzF4B8ps
	FHw+vtuyLusxFNHL+FFPouU0OSkO8BopDmjyGv0BAqN25b39it/AUXav30nEsA==
X-Gm-Gg: ASbGncsWXE/r/obJzCb/qNXR0QfzSZlp0F5R/hQ8+KFfG4eZFRMOH7fjraiH1Fnjvai
	BicGoWyy2WpoZx4A1xgXu4+ZQUfUtJqFk7iwsZ+52RjwMsNOSEqOLCXg95nmCFtjhS+zK/m6q8T
	I3Fo8VcaLyA3H8Q4Sunz79Fno0veRhxQoHjAS4nZB3C4fMNLppYyV9sd/szaZcsFbi9Xr2nfMx9
	qBa3igfnxxnYvbhRPhz3OWIbYdVwpsbwYdQO+CkPDrLKNiRjq9CbwBtOCx1iBQ9r5N9i0Sq+C12
	Pui3y/P+ghlB+xcOVMClFUrr5p/j8m42KPxGL6SFAg3sIOr7LI5mvWO0Id6WCjPQ5hbMV4XK
X-Google-Smtp-Source: AGHT+IGJUF/tbKGvEzRqaswG1j1XAmvREjXJ5j3L2vOxonmU+NB7UkvgtD2fBMW3Ia56dQb3d6Yciw==
X-Received: by 2002:a17:903:1aec:b0:234:c86d:4572 with SMTP id d9443c01a7336-23ac45e248cmr199762295ad.30.1751332345141;
        Mon, 30 Jun 2025 18:12:25 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39bfbesm100007455ad.109.2025.06.30.18.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 18:12:24 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	zijianzhang@bytedance.com,
	zhoufeng.zf@bytedance.com,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next v4 1/4] skmsg: rename sk_msg_alloc() to sk_msg_expand()
Date: Mon, 30 Jun 2025 18:11:58 -0700
Message-Id: <20250701011201.235392-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
References: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
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
index 34c51eb1a14f..0939356828a4 100644
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
index fc88e34b7f33..1e8d7fc179a8 100644
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
index fc7a603b04f1..db7585ec7610 100644
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


