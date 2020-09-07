Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD9025FDF8
	for <lists+bpf@lfdr.de>; Mon,  7 Sep 2020 18:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbgIGP76 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Sep 2020 11:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729998AbgIGOsb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Sep 2020 10:48:31 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD830C061757
        for <bpf@vger.kernel.org>; Mon,  7 Sep 2020 07:48:30 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l9so14464775wme.3
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2020 07:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vfp8n6DVc0oODsUGu6ZVYaW1CH61INrkZIfFkv2gVnw=;
        b=BHf/AKJz1829Lg83WzSwfGXrEifbEg5SkqK29SEqyBsM5Srjhu2Qr2LlgkAE8LIR69
         s2EJvfw4c9dytNVFjs3qGABTKo59V214wYl/v/+rzcb14fVirkF55wY2xTZZVXN3J1/0
         ilJVzNQD3LTU+4SNdZLmM94zCKQr/RrJWh7uE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vfp8n6DVc0oODsUGu6ZVYaW1CH61INrkZIfFkv2gVnw=;
        b=jHOMox0t+qK5UkJkrG0/H2Yk6QDFAKVZD/ZqoCFryEjQCzHjjEXyRhi6YbQ2tQ4CUP
         aWE+DD493G4BkS+AL7OCwq9XaUqYuUu/V4IaLFnK7aDiHOCzuDhclEw3CgzcJnPgGKsb
         Iw/Dbohx5CaOuQtwV2R70/dhOoRVHniHzXWmt4NFaX3KJCLhVotbzc2DejxkhdfLVhOM
         yQGkcvUHtqUUYq20LS7ebAQX8Tc/SbLXfF1LT/1zsgyCNP8EnwvurRL0LAptTb8x+vzc
         Li+eYo9F6tUhTXXJbgxD/1BparesoUhk+goDJO9NHWIfNlKUw97O3DCitRbxiMpdy97n
         zwKA==
X-Gm-Message-State: AOAM530KXOPOG2Yj66nnPjODwwrVxBJ3orYEnf2e13Vo81xBbyz3gW98
        AXCK25xWIF53yQleHQOKrNamQsjk1H+4SQ==
X-Google-Smtp-Source: ABdhPJwre4LBfpd379RDlo7a3r1LMQ6ygrSI4EHa7LhG7VQXhF3YxWzMUWSUp7eSA1+71JwZprszuQ==
X-Received: by 2002:a7b:c2aa:: with SMTP id c10mr20937949wmk.86.1599490109486;
        Mon, 07 Sep 2020 07:48:29 -0700 (PDT)
Received: from antares.lan (2.e.3.8.e.0.6.b.6.2.5.e.8.e.4.b.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:b4e8:e526:b60e:83e2])
        by smtp.gmail.com with ESMTPSA id 59sm8816834wro.82.2020.09.07.07.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 07:48:28 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v4 2/7] net: sockmap: Remove unnecessary sk_fullsock checks
Date:   Mon,  7 Sep 2020 15:46:56 +0100
Message-Id: <20200907144701.44867-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907144701.44867-1-lmb@cloudflare.com>
References: <20200907144701.44867-1-lmb@cloudflare.com>
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

