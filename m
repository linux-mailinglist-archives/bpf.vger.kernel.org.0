Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933982631D5
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 18:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbgIIQ20 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 12:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731143AbgIIQ1r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 12:27:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DFDC061755
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 09:27:46 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l9so3009849wme.3
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 09:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vfp8n6DVc0oODsUGu6ZVYaW1CH61INrkZIfFkv2gVnw=;
        b=blR/9N5aTbFj75Qu9pZrcDR/YXXVuUPupaVQgn2UXj2sVCIXRsTJlbTpzoz/+IkaDb
         vv5lnyEdR8qkZo6XhFlIMkH/LiholY4OSURWRUQvG/1pEpyB4EfxUSUyMIQxRKyE3+8t
         1dECuFzbKfLYRGIl28vkMvdk2RscgQaGQU1L8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vfp8n6DVc0oODsUGu6ZVYaW1CH61INrkZIfFkv2gVnw=;
        b=HbyGmAEHHQ48HGPSTcsLPi0mEwyyFrELr5q8B+fuRtfBZHxaH9dNdKpZhDI0QLCYQ7
         d8i28P4Uq5JSsUmeGy0VHv8Bi+n8kDPvgOHGmKAcAuSOxBijDtDzW/DJ+GVn41b1iSij
         syXwAgQXE2fW1A6ckalCQ9+kmL7/gJ2gXNjxZunoNlmUr0eD7gnw8Otq4fd5YyJEr8vb
         pHvrepQ9usloLGB3ZoTn4h6N6UjDt4TWoIerIrX0ZgLf3R50mvGbqrAzgY+0p1+czR22
         9IN6tG/GqqO1j4v1/XI6WtFaGxLiaAnCPm+DXp+199L1Z84lJc9RsyCpz2DOfyy6W9oC
         MQ8A==
X-Gm-Message-State: AOAM530eOxcoW3onz1cV9FJh5ZGeVT0beMsU4zN/8ZkYAjKax57+h+Lp
        YiU24v5zZSrqH4vosXbXrYIZBg==
X-Google-Smtp-Source: ABdhPJwbKjGQJNYkZwZBjrHcnRjvib93EiwBGGkFtugwMc4t593KqP7smrRA0iAq7hO8jOqgn8smJg==
X-Received: by 2002:a1c:5f46:: with SMTP id t67mr4259734wmb.71.1599668864361;
        Wed, 09 Sep 2020 09:27:44 -0700 (PDT)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id l16sm5644276wrb.70.2020.09.09.09.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:27:43 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v5 1/3] net: sockmap: Remove unnecessary sk_fullsock checks
Date:   Wed,  9 Sep 2020 17:27:10 +0100
Message-Id: <20200909162712.221874-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909162712.221874-1-lmb@cloudflare.com>
References: <20200909162712.221874-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The lookup paths for sockmap and sockhash currently include a check
that returns NULL if the socket we just found is not a full socket.
However, this check is not necessary. On insertion we ensure that
we have a full socket (caveat around sock_ops), so request sockets
are not a problem. Time-wait sockets are allocated separate from
the original socket and then fed into the hashdance. They don't
affect the sockets already stored in the sockmap.

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 net/core/sock_map.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 078386d7d9a2..82494810d0ee 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -382,7 +382,7 @@ static void *sock_map_lookup(struct bpf_map *map, void *key)
 	struct sock *sk;
 
 	sk = __sock_map_lookup_elem(map, *(u32 *)key);
-	if (!sk || !sk_fullsock(sk))
+	if (!sk)
 		return NULL;
 	if (sk_is_refcounted(sk) && !refcount_inc_not_zero(&sk->sk_refcnt))
 		return NULL;
@@ -1110,7 +1110,7 @@ static void *sock_hash_lookup(struct bpf_map *map, void *key)
 	struct sock *sk;
 
 	sk = __sock_hash_lookup_elem(map, key);
-	if (!sk || !sk_fullsock(sk))
+	if (!sk)
 		return NULL;
 	if (sk_is_refcounted(sk) && !refcount_inc_not_zero(&sk->sk_refcnt))
 		return NULL;
-- 
2.25.1

