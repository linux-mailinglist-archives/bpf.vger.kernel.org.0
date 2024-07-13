Return-Path: <bpf+bounces-34720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBB5930325
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 03:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35DAB1F21115
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 01:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551A41B27D;
	Sat, 13 Jul 2024 01:53:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7F61757D;
	Sat, 13 Jul 2024 01:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720835581; cv=none; b=oQH7x+enXzLzcWXIPwts9hXl+xNWIbDgF8b8ayeUqvvSmBAGCf3zGLhc3SCPcdxbGWbvq55MeJGVcGLrjXwnV3oDEJXsal/77ffwdn2L6J4zzX9+DeCfXHzZaw5JgoYGX9//CGnWT5pvVv6LOb4Sf5i6vE62TwMsKsETi06SaWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720835581; c=relaxed/simple;
	bh=2MYsITw1u69xfvDgBFIQxOIYJU4MwpOcbCBYpE7pmkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2ttavuMgIEHyuxpzCjpkWUmplA1VdOd5nOpiNZ/OvZnqkadjC9xZoqlHnkUfJDrgU97j/iCchzVfkMWm7eVinAZOwgDoyTx2gCappMsyeLPgwe2272IFHyOo/JuEdOXE3Gozgdf9hZsr3s4Ei7r2W8V+z/f4goosPYNR52W2fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-78cc22902dcso356989a12.0;
        Fri, 12 Jul 2024 18:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720835578; x=1721440378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRtjrjzlkgIlFGKwNcPOBgqeh9nDlZWiuAgy2U4jLAk=;
        b=rCS8p/FZkR5Ba4crYTokw5W6OwVIG26Zfv0VOo6fQrpsAw5oqD1RY/69xbMYbi6wYJ
         Nt0x75Qj64BF7zArose1QpZReBlI41CzO8mSBq2dcUcxJbmlxtNnkPjcXvEHSQo1tr09
         nOXbyCyFYHzgOWJBYqVpUcKUl5fRahqT52QjraSiZP/l4FKnxEa8UkF+IQ2WhglrS7CB
         OJiJEF1UoLONvdljKNlGr8c6xCQmom6Ncxdxmg0m0inrtHjHfLLQyNaVmUvMW+2H1/IP
         Iy7l9VaHLGBoZ3F20IHzI2LG5fcKhX5TY2nTUSlVsVf5q4eqcNEnGUvSlZdMdhrOKOdQ
         eWsA==
X-Forwarded-Encrypted: i=1; AJvYcCUXNqNC+70RBanoNb2KttaoNa6AozCYUEmc16FiRjGqG/Jb8xeqqLSnX/yaMsOhJUYNnY4X8X7PiUzXZk5AgToc/KqhcO0X
X-Gm-Message-State: AOJu0Yw9PVQcaI1VnDRlnQJNOgi3VVHlEe9CCjevfkFi9KhtfGxJnj2P
	PKnfB3cJ6pvkwIKcVEhRHRBVCUaqZeTNYVpd8QWhLbqhw183K+NmqJtjeJs=
X-Google-Smtp-Source: AGHT+IG5Een4Ysfg9Sb/7acvox8tr7eqpLGj6vziwuR9RtkRd76wyrDFcusFAP72h/4gSKmJU/+Oyw==
X-Received: by 2002:a17:90a:6888:b0:2c4:ee14:94a2 with SMTP id 98e67ed59e1d1-2ca35c693afmr9686873a91.27.1720835578562;
        Fri, 12 Jul 2024 18:52:58 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2caedbdb6dfsm179205a91.2.2024.07.12.18.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 18:52:58 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	Julian Schindel <mail@arctic-alpaca.de>,
	Magnus Karlsson <magnus.karlsson@gmail.com>
Subject: [PATCH bpf 3/3] xsk: Try to make xdp_umem_reg extension a bit more future-proof
Date: Fri, 12 Jul 2024 18:52:53 -0700
Message-ID: <20240713015253.121248-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713015253.121248-1-sdf@fomichev.me>
References: <20240713015253.121248-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a couple of things:
1. Remove xdp_umem_reg_v2 since its sizeof is the same as xdp_umem_reg
2. Add BUILD_BUG_ON that checks that the size of xdp_umem_reg_v1 is less
   than xdp_umem_reg; presumably, when we get to v2, there is gonna
   be a similar line to enforce that sizeof(v2) > sizeof(v1)
3. Add BUILD_BUG_ON to make sure the last field plus its size matches
   the overall struct size. The intent is to demonstrate that we don't
   have any lingering padding.

Reported-by: Julian Schindel <mail@arctic-alpaca.de>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/xdp/xsk.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7d1c0986f9bb..1d951d7e3797 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1331,14 +1331,6 @@ struct xdp_umem_reg_v1 {
 	__u32 headroom;
 };
 
-struct xdp_umem_reg_v2 {
-	__u64 addr; /* Start of packet data area */
-	__u64 len; /* Length of packet data area */
-	__u32 chunk_size;
-	__u32 headroom;
-	__u32 flags;
-};
-
 static int xsk_setsockopt(struct socket *sock, int level, int optname,
 			  sockptr_t optval, unsigned int optlen)
 {
@@ -1382,10 +1374,19 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 
 		if (optlen < sizeof(struct xdp_umem_reg_v1))
 			return -EINVAL;
-		else if (optlen < sizeof(struct xdp_umem_reg_v2))
-			mr_size = sizeof(struct xdp_umem_reg_v1);
 		else if (optlen < sizeof(mr))
-			mr_size = sizeof(struct xdp_umem_reg_v2);
+			mr_size = sizeof(struct xdp_umem_reg_v1);
+
+		BUILD_BUG_ON(sizeof(struct xdp_umem_reg_v1) >= sizeof(struct xdp_umem_reg));
+
+		/* Make sure the last field of the struct doesn't have
+		 * uninitialized padding. All padding has to be explicit
+		 * and has to be set to zero by the userspace to make
+		 * struct xdp_umem_reg extensible in the future.
+		 */
+		BUILD_BUG_ON(offsetof(struct xdp_umem_reg, tx_metadata_len) +
+			     sizeof_field(struct xdp_umem_reg, tx_metadata_len) !=
+			     sizeof(struct xdp_umem_reg));
 
 		if (copy_from_sockptr(&mr, optval, mr_size))
 			return -EFAULT;
-- 
2.45.2


