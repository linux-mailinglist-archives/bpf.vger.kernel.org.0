Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3B024D26A
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 12:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgHUKbU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 06:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbgHUKaP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Aug 2020 06:30:15 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C28C061345
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 03:30:13 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y3so1472381wrl.4
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 03:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hyLiFASi8DsO1cqDKTvl4MPa8Kg4E+nh7GZ2KQQvgEg=;
        b=sfIZywtmE8rhEz6dJSkAlUAwpSKXVK/6MLcVhqzP4yu+8AcdMVevYJgvC+jhXzZotG
         ZBNNlMBOF5t8k8EGE2Jb7+veJgisSudtZQEWdTucY5igdFfUdVxgM5MJ9gegAsnl9XHM
         tikR4Bl7cZMsVzK+XCAz9KcHiJ4gcNeYOZ02E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hyLiFASi8DsO1cqDKTvl4MPa8Kg4E+nh7GZ2KQQvgEg=;
        b=gqRq0p/frLwWnQ8SFBYBnf5iU+4FEPbe6/0Pi3GBE0KWSnZ1MhaTuqNF8oVCwXMdoS
         vIow3bWoZXUqiX6vOmxumPzULesizhWCRj66pxgudPozzbAWvi7aiR2CPNKzRxHz6icE
         rlP2wsrlrWcdUT0yUolSye1k8YcHzwnAa+E9b9H19xylJ8MQTucCG2l9OvlZ0lrF7mbh
         ZSklSDIB6ZSVekmPcgmWr5WJMLPrY1OFAD99nrxmqAf+cdc8PIpqie8zDAEs1Ior8O1u
         g5TOfjx73bgEzhc9NAZ2Cy06FQ9s2/bufgCchTrGEw9cV62rHLrpzN03C9OWWUg42QAU
         aDNA==
X-Gm-Message-State: AOAM530TyaC380xrSxetWTt/fimw903Y4P/APO/z5yVephTXZP4H3PrZ
        941UaYd8ZWMZXrzVyGpPM1p9Gw==
X-Google-Smtp-Source: ABdhPJz59cEb0I6SwGHhJcAOUJ+k+HVKqHE5spe33rdnwNWpmwPPuZabGbWArZBm01XZJvKdrWMq5w==
X-Received: by 2002:adf:f207:: with SMTP id p7mr2320372wro.292.1598005810779;
        Fri, 21 Aug 2020 03:30:10 -0700 (PDT)
Received: from antares.lan (2.2.9.a.d.9.4.f.6.1.8.9.f.9.8.5.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:589f:9816:f49d:a922])
        by smtp.gmail.com with ESMTPSA id o2sm3296885wrj.21.2020.08.21.03.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:30:10 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     jakub@cloudflare.com, john.fastabend@gmail.com, yhs@fb.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 2/6] bpf: sockmap: merge sockmap and sockhash update functions
Date:   Fri, 21 Aug 2020 11:29:44 +0100
Message-Id: <20200821102948.21918-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821102948.21918-1-lmb@cloudflare.com>
References: <20200821102948.21918-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Merge the two very similar functions sock_map_update_elem and
sock_hash_update_elem into one.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 net/core/sock_map.c | 49 +++++++--------------------------------------
 1 file changed, 7 insertions(+), 42 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index abe4bac40db9..905e2dd765aa 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -559,10 +559,12 @@ static bool sock_map_sk_state_allowed(const struct sock *sk)
 	return false;
 }
 
+static int sock_hash_update_common(struct bpf_map *map, void *key,
+				   struct sock *sk, u64 flags);
+
 static int sock_map_update_elem(struct bpf_map *map, void *key,
 				void *value, u64 flags)
 {
-	u32 idx = *(u32 *)key;
 	struct socket *sock;
 	struct sock *sk;
 	int ret;
@@ -591,8 +593,10 @@ static int sock_map_update_elem(struct bpf_map *map, void *key,
 	sock_map_sk_acquire(sk);
 	if (!sock_map_sk_state_allowed(sk))
 		ret = -EOPNOTSUPP;
+	else if (map->map_type == BPF_MAP_TYPE_SOCKMAP)
+		ret = sock_map_update_common(map, *(u32 *)key, sk, flags);
 	else
-		ret = sock_map_update_common(map, idx, sk, flags);
+		ret = sock_hash_update_common(map, key, sk, flags);
 	sock_map_sk_release(sk);
 out:
 	fput(sock->file);
@@ -909,45 +913,6 @@ static int sock_hash_update_common(struct bpf_map *map, void *key,
 	return ret;
 }
 
-static int sock_hash_update_elem(struct bpf_map *map, void *key,
-				 void *value, u64 flags)
-{
-	struct socket *sock;
-	struct sock *sk;
-	int ret;
-	u64 ufd;
-
-	if (map->value_size == sizeof(u64))
-		ufd = *(u64 *)value;
-	else
-		ufd = *(u32 *)value;
-	if (ufd > S32_MAX)
-		return -EINVAL;
-
-	sock = sockfd_lookup(ufd, &ret);
-	if (!sock)
-		return ret;
-	sk = sock->sk;
-	if (!sk) {
-		ret = -EINVAL;
-		goto out;
-	}
-	if (!sock_map_sk_is_suitable(sk)) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
-	sock_map_sk_acquire(sk);
-	if (!sock_map_sk_state_allowed(sk))
-		ret = -EOPNOTSUPP;
-	else
-		ret = sock_hash_update_common(map, key, sk, flags);
-	sock_map_sk_release(sk);
-out:
-	fput(sock->file);
-	return ret;
-}
-
 static int sock_hash_get_next_key(struct bpf_map *map, void *key,
 				  void *key_next)
 {
@@ -1216,7 +1181,7 @@ const struct bpf_map_ops sock_hash_ops = {
 	.map_alloc		= sock_hash_alloc,
 	.map_free		= sock_hash_free,
 	.map_get_next_key	= sock_hash_get_next_key,
-	.map_update_elem	= sock_hash_update_elem,
+	.map_update_elem	= sock_map_update_elem,
 	.map_delete_elem	= sock_hash_delete_elem,
 	.map_lookup_elem	= sock_hash_lookup,
 	.map_lookup_elem_sys_only = sock_hash_lookup_sys,
-- 
2.25.1

