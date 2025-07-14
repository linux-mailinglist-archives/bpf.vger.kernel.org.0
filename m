Return-Path: <bpf+bounces-63224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB5BB04722
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 20:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F9F4A08AD
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 18:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA7D26C3B9;
	Mon, 14 Jul 2025 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="z70Aqle/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7756126C398
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 18:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516570; cv=none; b=VpmShxUhbkmY+CzBl6xOSyAN8mvSkRcmzIJpBDv6cGKNNa+58EogJR9GBVcW8WQU/Zu7E2V7vM0Tyf7P1CZDtuYyQz/M0TrLGOZs44AqZH4UQMB5+1lJWy0ISsNwRG+p8OtzOsKIcb23fy+qFDL1ez/jGtYY0tFgc+AkxVgyJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516570; c=relaxed/simple;
	bh=P2TM48kjMxPSr7YwvwYsCNfh+euwlg0K2KRkqviR9cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ruL5UdM6d9sPAYPjg099ixaKxti4orb1GFy7XlpMa4+26HV35pesUDpslGlWwV1/wc6T5dorGxil7mRwb3C1pSTLDm/gNDAqT/SpSy9s7L8HB6TrQt4VJOPIDYHO2LfQfjeDkqFb0dI0DBC6e9yotfBCBcSHX/U114Uk3+X//NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=z70Aqle/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2355360ea88so5827955ad.2
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 11:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752516569; x=1753121369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=z70Aqle/3O7+PJwfMIvNPpoWy+yspKXbwojJ4/NwiEJcbPowtKYgMQBb6RgypGtUG5
         2vdzaygAD5PW8kYyBVGvhXouyihipW1IdNQ+Rz+voxk8vQ6/NFJy1vDicKGuVKdVj9vV
         UoueURcjvKXOlG+uxvYIp6FJ7jZQWVLjNhK47WNjyvTAqB/0hYMtKb9FpsE7s4sqGVFz
         /zoWuT90J3FWUMpIr+/Sz/8kImpO08b3yJ+M1BzUhpsDR2x8pN4zH6yfpMycl0hDGD1L
         rP97CbkGMUAf8A/xHUL4tOy6focqSQeaYvtlIh3OyxUgtJMsmkJ+elw0bkLTIyTTxUk5
         J6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516569; x=1753121369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=E0TJkDBHo0JWIc3VqAwV3Yx3lcAFAH1zr8pE6wFT3+i0cpSu8w+jdpY6/R2MOUQzgd
         8z8Ivm3oLWu6oUad/eO891Clngdov7280vPmQxQJjx21KssDsfHru8NeaK5ZP3Q65h6M
         HQnDeT9U6KH7i1NfpQIgZXkR64GUoL9bcSIBl6r3Kqouh9iUHaaOFdR4sOTA+RA538sK
         JsRzDZm5AexWtNhRV9W1aAD1QZyfPrqdYBLYDnmD9cUAe7bmkrJ7fbg3yI+N3fn83Lvn
         XrthQHMfrouVmEiT87lFDIuwM13HDGpahuH0RvLhXP3uJx9gqwAsQ4c6a9Yc2JXt6D9Q
         ItcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBmUNb51Jti/LARBqSzLN2euyVYZC5fBcArPF45EzpDDu8ih2p1ob9vsHNwUvQ2sBpDbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRapkGOX2WN8uNbh/YQaOTXA2WEG9WWy/R7OFSr+GommiwioxF
	zXKxWhpPUiiQiv+omp5sv4BspnEVnfEpxjVLmo+3kvNnSWS6cYzUPARCNRL9AMuwP2Y=
X-Gm-Gg: ASbGncuFo3AT626mgjNgCCdiZMPqEvrHJub1glKa3YnClzX3U6+ZFM6FlxK2O/5+oXq
	NrJkDUOp2+x1kzGoxlCmRinlO0zJtfboi47wxlUqpc1aIO90s9LikZDJ+A+XNwAg3skldpo6ZBr
	FivTTwHmM1VNxSMkFoTvafqD9ppqkK14KBbCoXKKR5S2RIAGvxtSMCKyHlfR7416waYJdufrtB3
	g+Bt0ugQzcM8UiALpBL9RVq6yUYj46WnHmtezMKJtmUb3eg7e5qM8DddAW7t2bbjytrpn6pJHCm
	oVISUA1/rEXYWKlkv8V+1mnWcY8xujQBmdMgESYY2xLNZghFcdZ3GoeCkNVKt8foRF4mwucdHXw
	ponCvksSmWQ==
X-Google-Smtp-Source: AGHT+IHGj1vCcS0CLgK3Kp/EBgZ+Da6Oruf//oEX98pjJ0JzI4SbBw1w9uGigeAP2k5IVwK5hzfGcw==
X-Received: by 2002:a17:902:e742:b0:234:bfe3:c4a3 with SMTP id d9443c01a7336-23def6f8af8mr75680625ad.0.1752516568491;
        Mon, 14 Jul 2025 11:09:28 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:84d3:3b84:b221:e691])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aeadcsm98126405ad.78.2025.07.14.11.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:09:28 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH v6 bpf-next 01/12] bpf: tcp: Make mem flags configurable through bpf_iter_tcp_realloc_batch
Date: Mon, 14 Jul 2025 11:09:05 -0700
Message-ID: <20250714180919.127192-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714180919.127192-1-jordan@jrife.io>
References: <20250714180919.127192-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the next patch which needs to be able to choose either
GFP_USER or GFP_NOWAIT for calls to bpf_iter_tcp_realloc_batch.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_ipv4.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6a14f9e6fef6..2e40af6aff37 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3048,12 +3048,12 @@ static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
 }
 
 static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
-				      unsigned int new_batch_sz)
+				      unsigned int new_batch_sz, gfp_t flags)
 {
 	struct sock **new_batch;
 
 	new_batch = kvmalloc(sizeof(*new_batch) * new_batch_sz,
-			     GFP_USER | __GFP_NOWARN);
+			     flags | __GFP_NOWARN);
 	if (!new_batch)
 		return -ENOMEM;
 
@@ -3165,7 +3165,8 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 		return sk;
 	}
 
-	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2)) {
+	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
+						    GFP_USER)) {
 		resized = true;
 		goto again;
 	}
@@ -3596,7 +3597,7 @@ static int bpf_iter_init_tcp(void *priv_data, struct bpf_iter_aux_info *aux)
 	if (err)
 		return err;
 
-	err = bpf_iter_tcp_realloc_batch(iter, INIT_BATCH_SZ);
+	err = bpf_iter_tcp_realloc_batch(iter, INIT_BATCH_SZ, GFP_USER);
 	if (err) {
 		bpf_iter_fini_seq_net(priv_data);
 		return err;
-- 
2.43.0


