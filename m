Return-Path: <bpf+bounces-79139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4A7D28144
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 20:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDBF1300FD66
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DC33090E5;
	Thu, 15 Jan 2026 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Epxfrbfi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AB63054EF
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 19:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505279; cv=none; b=bMtJHTlxAP1Zs8N35w9sYN38ojMJv/xjpPeEAyz7Mt1dWDlO034UisbiMb+ngrsCtwiGs9qMhidVAZrXFjPIrdYBNNMSK+B6KzHFtPSlkwvssuTs4gRgiTxlTPIU0FkaDRmbzHEjJBI+liUEh4mxH2JiQ1SsbBhengBxkUNdb10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505279; c=relaxed/simple;
	bh=2wOz1jmxe3gclkNFKG17IsegMz4ldtSkofiZhvuhpoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=efWilvlok95CK8YscgNrs5vhAblUZBPzpKjpIPwE6JbrIgLeiDFUVjodCgRltJO+VYLw3gx08eMgsJ7nflXgTAfEknp4PG3azXDUhxUN4Ggj8xz9/QSzG2MFWhHo4xd8FMOQHV18S5N1m1aqsbLIlOx2rzZ1LRoCiaJkQsFJUmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Epxfrbfi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a3e89aa5d0so11462765ad.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 11:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768505274; x=1769110074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0rsVq6S3tYTAsMDgzEeo4MBYiMCZ3B1UFCC6QhJhM4=;
        b=Epxfrbfi8llkPSNXBCJoFB4AgumXkY5axaM6H5cqDkZVkAftqn+fGy1dhf6Jy8wgod
         r812kRBOoClck17Ckhr77cAJsXtVUHqyv5vBUixzpvKwmH0JHaPKl9PtVdEgBtpSOW9H
         j23qF2X31PbaAOExRF5VcoK3TX/hq62SWMziJg8kBj1A4tV1MAlQFY438vp1OjVMPus0
         j966QBONOwgmtGA6hiGmR2Wb+GfEQ5OGfVljbshtDurVx/50VnpvkSfL9Gqi1D79eGhk
         3ibQ+WKNwl7RVJ8L+4EYZcmdK+eWYh66q48F4wTutaoDpz1Noc7OrApCEzgeYGRQV0xI
         gX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768505274; x=1769110074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b0rsVq6S3tYTAsMDgzEeo4MBYiMCZ3B1UFCC6QhJhM4=;
        b=GWt2SCSx4bauSqorhBLuRzO3FRW5vmrhdijhXjVJLpWn/4WuUpoeuuV3C4w+KAX38x
         tcvHelfpyM0D3ts1wvQY+r8f3qnxIaa8iBkOJ0RQjQngRiYPG1lmq/O474MB+2BU1me/
         vv20ps+jmt0swQETxj+Iqttbx6Koxkj+7vCJ43MXnnriH22NBaHUFjE774jS7PAPk91Z
         Lbpa5IMLkXDpvpa94uaP2zAvr4lQ1EZBDWIyZ6GAstdr2XY4cn0JHA9F0X/nFpBkn/Ws
         LDWGh3Ycb+JmgyxgL3HE8i2lpaDO47hYwXguP9FjLkrmydPKJWq+zzndQs9lsI1kCulf
         geWA==
X-Forwarded-Encrypted: i=1; AJvYcCX0V9HMbtw5WXFM7ssiLPV+jn1bhhdvFcF+k6YRuxCPErgHwdLIjWVtLLGv588ywKrCeG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXQTheZryH3OXc73gUAZRj/YFFIy088XFBOgQU76eWGISUUYcO
	XhbeFHcKDNzUOY7jvvDfKBWAX831DVMlFUJU7Q7C4iBZ1oxm6YHMvoS9
X-Gm-Gg: AY/fxX7/2iZD0IsREppAsYf/o0rbKNW3jOGgM+/EDKI6+Q6s80wr+DpFY0TFJyIsJFD
	G25YJTM2XhI9YvNMyLPKnrM0pYEcvXfoTIqrMygxdXW1VOXECOu2S7e/RPjPvWHtCnY/xLJeQT+
	Hcroi369FhZZOTdPnrpTZdOBMyF62nBrcObI6Xg9Cv9G4HEk56rWespDynbG3Gl24QNoBfbzLKj
	0Fzy0pAE7mTsY2hP5c7UG3aXsMG39f4hNwxbbSDhdQi4eqysu5v7+EqNGe37NWLDPAivqncCqFX
	JoLC9WfgsNQpRtEUeQYyWwgVA4KjJwsp4vj/gkbLw5IYpEy4I6O+/5DCJXHudDAjzWCvyUCCq8T
	9KGiHeaX8mBNApa22+v9WMzVhmw8MsnLxM7kh8d+3vkgmgge0S3XaTAQVKjWCBn+yqLFgkKlzm4
	113TT3sFaLNnLMvbEl
X-Received: by 2002:a17:902:f788:b0:2a1:3cd9:a734 with SMTP id d9443c01a7336-2a7175be2b6mr5197005ad.43.1768505274035;
        Thu, 15 Jan 2026 11:27:54 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:3874:1cf7:603f:ecef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce692sm876115ad.36.2026.01.15.11.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 11:27:53 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: hemanthmalla@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	zijianzhang@bytedance.com,
	bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next v6 3/4] skmsg: optimize struct sk_psock layout
Date: Thu, 15 Jan 2026 11:27:36 -0800
Message-Id: <20260115192737.743857-4-xiyou.wangcong@gmail.com>
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

Reduce memory waste in struct sk_psock by:

1. Change psock->eval from u32 to u8. The eval field only holds values
   from enum sk_psock_verdict (4 possible values), so 8 bits is
   sufficient.

2. Move refcnt up in the struct to pack with other small fields,
   improving cache locality for psock reference counting operations.
   refcnt is frequently accessed during sk_psock_get/put, and placing
   it near the socket pointers (sk, sk_redir) keeps them in the same
   cache line.

These changes reduce holes in the struct and prepare for subsequent
patches that will add new fields.

Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 include/linux/skmsg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 61e2c2e6840b..84657327b0ea 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -85,8 +85,9 @@ struct sk_psock {
 	struct sock			*sk_redir;
 	u32				apply_bytes;
 	u32				cork_bytes;
-	u32				eval;
+	u8				eval;
 	bool				redir_ingress; /* undefined if sk_redir is null */
+	refcount_t			refcnt;
 	struct sk_msg			*cork;
 	struct sk_psock_progs		progs;
 #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
@@ -100,7 +101,6 @@ struct sk_psock {
 	unsigned long			state;
 	struct list_head		link;
 	spinlock_t			link_lock;
-	refcount_t			refcnt;
 	void (*saved_unhash)(struct sock *sk);
 	void (*saved_destroy)(struct sock *sk);
 	void (*saved_close)(struct sock *sk, long timeout);
-- 
2.34.1


