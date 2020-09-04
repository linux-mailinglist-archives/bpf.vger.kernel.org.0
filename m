Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE35925D586
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 11:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgIDJ72 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 05:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbgIDJ71 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 05:59:27 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9846AC061245
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 02:59:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k15so6090149wrn.10
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 02:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vfp8n6DVc0oODsUGu6ZVYaW1CH61INrkZIfFkv2gVnw=;
        b=th5l1919OgRHC+JxUJOzJnyvvQDQFzoGvEXB09lQEKZtTxkp88rTFKnmPhwbMTsqEp
         Cw4buu1x5CUc84CFW0yNwXnmjN5GyWDe2rs/Ga2yGgZhRc3ChTN6tELmwQEXTPR/hCs8
         YlrwfXnwXwVVZky26gLiqOxrvuwWH0JGWZg+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vfp8n6DVc0oODsUGu6ZVYaW1CH61INrkZIfFkv2gVnw=;
        b=RB9ub+1fvLjPEK0tj4U4uBER7WLnKIWRgsNgyh44T1imi8WCIuD9Q2N0legxGdB5pn
         6gXcF1rd5InXPeXwK89u9NyP7mlvBauY4lQ6hHhZBSj4t6ElKTXQT4SjlXyUQz2iDxoc
         FLOLSNu3kadUjtqBHawoUWivsSGs0iQAOKLb/HG+JbV988If7tdr5DlmBNlnPcsah5wP
         bUqIGriX479VvfkqzP+UOkJ/Mv6udczDos3d/CEKkfx5OsxrPgQ1iD7e3Hlh1AhrYDbG
         1ZvWkPOkKRyu8jwvFHxleLJ29Hv8gLXW37V4r5Ya49il8fURUKOZ7mY6ktl08fTlFq1A
         lNhQ==
X-Gm-Message-State: AOAM532bXnW1RGVSy9CqePFktOa0PHSGibTZG/ykgvdj/8ntMR9fHi7z
        wfIh6sPn4/dbShgf4EVR11+f/Q==
X-Google-Smtp-Source: ABdhPJxlItZeczSiQtOfSRXGZnokXkrGpfkF6q8HUocg7qlmZ+jSS4E4wGhNgChH0FyzNcn/6cpMvw==
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr6895690wrw.34.1599213565288;
        Fri, 04 Sep 2020 02:59:25 -0700 (PDT)
Received: from antares.lan (a.6.f.d.9.5.a.d.2.b.c.0.f.d.4.2.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:24df:cb2:da59:df6a])
        by smtp.gmail.com with ESMTPSA id c18sm11648088wrx.63.2020.09.04.02.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 02:59:24 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 2/6] net: sockmap: Remove unnecessary sk_fullsock checks
Date:   Fri,  4 Sep 2020 10:59:00 +0100
Message-Id: <20200904095904.612390-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904095904.612390-1-lmb@cloudflare.com>
References: <20200904095904.612390-1-lmb@cloudflare.com>
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

