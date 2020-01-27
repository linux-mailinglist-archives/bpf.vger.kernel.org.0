Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5D2414A44A
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2020 13:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgA0M4H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jan 2020 07:56:07 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42190 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgA0Mzs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jan 2020 07:55:48 -0500
Received: by mail-lf1-f65.google.com with SMTP id y19so6101468lfl.9
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2020 04:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3sMKCOVjXYbspFAszwvSlLxiNsGoib87qyH6av20+QQ=;
        b=LPrXsq/gDsZPERfhhHV9UJIizOoomeiJQyzgjGlabihoAK9X3HpY3912dXkL8xV5+T
         SnTJaM9vO9zWuXvj4dAKD37f/vD2LRitY2DSfFc+RPw1Jg3icNfkWcTkyVWuNeh1BRNX
         2ox7tibOmWo3wlGH3FXB9/k+GP41gNx0BU7ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3sMKCOVjXYbspFAszwvSlLxiNsGoib87qyH6av20+QQ=;
        b=Hxx6WtMXhg48Vh766bmNwG5dXOGwIzmZfLN7osVBW3SF0tGwgi//dXif/e/PGCA86l
         xIAZEjblDuUwBFOsFWw5mt0+eFvLrU/MENBKyLUnVpUDYqQjK7tif0QatNzWzAJ5aLe/
         7uATamqHW9LJ96hxbQMptUtHim30e7+aqRzo9Ff72rluqC2ol48A18T15wRWfFZ/fqjZ
         /z8Vg/Pwr7yiZuapepRcDrCmUo1hbUrn+i1Yjsh6iymYh6/m0KlMeID7dm7MVeaI8UON
         PySJkvpVdrI9LJ3Wuuoane3Hl8u/Hs9Nhk083Rk+rqDJ4jfCm6rd+W/6ZqQLNl0jYBnj
         tRwg==
X-Gm-Message-State: APjAAAXE6asbuGJwXmD77ukXRrxipWAdC/a72ubNvZNX+8pITi4H6UbY
        U0Pe1taznuJ24SklG7UhynS4T+8RhNnc3g==
X-Google-Smtp-Source: APXvYqzJwJIyMQ5+RfRH06+3L4yzlYuSivEo3BF0OTh3WS41QR3bGmemCBQvjTyYeYuqWRNu8yE2vg==
X-Received: by 2002:ac2:5979:: with SMTP id h25mr8401900lfp.203.1580129745713;
        Mon, 27 Jan 2020 04:55:45 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id 144sm8203098lfi.67.2020.01.27.04.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 04:55:45 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v5 06/12] bpf, sockmap: Don't set up sockmap progs for listening sockets
Date:   Mon, 27 Jan 2020 13:55:28 +0100
Message-Id: <20200127125534.137492-7-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127125534.137492-1-jakub@cloudflare.com>
References: <20200127125534.137492-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that sockmap can hold listening sockets, when setting up the psock we
will (i) grab references to verdict/parser progs, and (2) override socket
upcalls sk_data_ready and sk_write_space.

We cannot redirect to listening sockets so we don't need to link the socket
to the BPF progs, but more importantly we don't want the listening socket
to have overridden upcalls because they would get inherited by child
sockets cloned from it.

Introduce a separate initialization path for listening sockets that does
not change the upcalls and ignores the BPF progs.

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/sock_map.c | 45 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 954c4d23bc01..cadae12bb3d4 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -228,6 +228,30 @@ static int sock_map_link(struct bpf_map *map, struct sk_psock_progs *progs,
 	return ret;
 }
 
+static int sock_map_link_no_progs(struct bpf_map *map, struct sock *sk)
+{
+	struct sk_psock *psock;
+	int ret;
+
+	psock = sk_psock_get_checked(sk);
+	if (IS_ERR(psock))
+		return PTR_ERR(psock);
+
+	if (psock) {
+		tcp_bpf_reinit(sk);
+		return 0;
+	}
+
+	psock = sk_psock_init(sk, map->numa_node);
+	if (!psock)
+		return -ENOMEM;
+
+	ret = tcp_bpf_init(sk);
+	if (ret < 0)
+		sk_psock_put(sk, psock);
+	return ret;
+}
+
 static void sock_map_free(struct bpf_map *map)
 {
 	struct bpf_stab *stab = container_of(map, struct bpf_stab, map);
@@ -333,6 +357,12 @@ static int sock_map_get_next_key(struct bpf_map *map, void *key, void *next)
 	return 0;
 }
 
+/* Is sock in a state that allows redirecting from/into it? */
+static bool sock_map_redirect_okay(const struct sock *sk)
+{
+	return sk->sk_state != TCP_LISTEN;
+}
+
 static int sock_map_update_common(struct bpf_map *map, u32 idx,
 				  struct sock *sk, u64 flags)
 {
@@ -355,7 +385,14 @@ static int sock_map_update_common(struct bpf_map *map, u32 idx,
 	if (!link)
 		return -ENOMEM;
 
-	ret = sock_map_link(map, &stab->progs, sk);
+	/* Only sockets we can redirect into/from in BPF need to hold
+	 * refs to parser/verdict progs and have their sk_data_ready
+	 * and sk_write_space callbacks overridden.
+	 */
+	if (sock_map_redirect_okay(sk))
+		ret = sock_map_link(map, &stab->progs, sk);
+	else
+		ret = sock_map_link_no_progs(map, sk);
 	if (ret < 0)
 		goto out_free;
 
@@ -422,12 +459,6 @@ static bool sock_hash_sk_is_suitable(const struct sock *sk)
 				      TCPF_SYN_RECV);
 }
 
-/* Is sock in a state that allows redirecting into it? */
-static bool sock_map_redirect_okay(const struct sock *sk)
-{
-	return sk->sk_state != TCP_LISTEN;
-}
-
 static int sock_map_update_elem(struct bpf_map *map, void *key,
 				void *value, u64 flags)
 {
-- 
2.24.1

