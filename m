Return-Path: <bpf+bounces-7291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C8C77559F
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 10:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22582281582
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 08:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF4C17FE3;
	Wed,  9 Aug 2023 08:34:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E93DF44
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 08:34:08 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D30A1986
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 01:34:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3175f17a7baso4921606f8f.0
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 01:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1691570045; x=1692174845;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ijl35yrvHWnvdny00wRBt92qHHEETnO1JDAe0OV9Zc=;
        b=QvpE0x2vl2KZ+J77E6ZL7iKIhDYwoMzehXAqmhr23czml3bymEGg9WyG1kMOT6amED
         0aYrBzccOgXGG7EGEbsPTxoH4n7yHDZJrysioSiQHyqU2UwcBFJ9XNLm3ZEn8xLIQU/D
         4/Chc7o7jZ2M2pBfOTzkEvLQgTB5vFoNc5CPPl4DIo5ztyPMVlK7lSIvw9wTjPkYTs7V
         DVN72sKlrNP1qG/CacssU7hOrOD6OB0O0YHAJwTGpy0s9Bt1YbzQNh0QdTdkJjGi5oAt
         JQJ+53nHnUDXX8XdCwDoIwnCGHiR88SCnWAjuZfz0HPmHU0v66Gy4aCT8tMoVAqw0BHQ
         C84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691570045; x=1692174845;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ijl35yrvHWnvdny00wRBt92qHHEETnO1JDAe0OV9Zc=;
        b=UvLtKpxPRY4Olw/h3+rFriVTWWJNS7aNYcDb1m5n/Bf6RgoacK7NSdoEjnrGm+/L9B
         slOMxeH/g5ldFyRUZLwDwf237VWMDlDT3H1VselovJBO0niqJnzPx/qZP0iQAUfH3j8k
         gnfag9DYtEyqKe/5EnrZpxcCIb7W7HquVE3YIerYRo/g+6eDyI8UWGLb3gP5ndNyo0Rp
         gtpv814y7ZQds/C1qHXnjxx+NASOXM7CuIFnyVKDguEWIv6dn2/bY0egA0WNbPBA5Kuv
         QA9kMS+iUgkNU9pRmUn3CdPqtrrT8ndtIUvX1L0XCoYi5aMXddPuDlGgvOOI6imGiRtA
         Flxg==
X-Gm-Message-State: AOJu0YxKhotqU3wRN4I/P0HkzpErKdwagS7SVpljIHMwKLORnKnJ65xD
	NoB4zZpvdmdmfUL6LSmPu2ThhVcYo48Cns2QJ055Cg==
X-Google-Smtp-Source: AGHT+IEX8b+FaTW/xo6PDQ7HnhpJyaPs9/eQmthsjoiDN0/xgiRvlbSwvTVE5u3wGRnD5Ywx1k9iPQ==
X-Received: by 2002:a5d:4c87:0:b0:30f:bb83:e6f4 with SMTP id z7-20020a5d4c87000000b0030fbb83e6f4mr1254847wrs.0.1691570045535;
        Wed, 09 Aug 2023 01:34:05 -0700 (PDT)
Received: from [192.168.1.193] (f.c.7.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::7cf])
        by smtp.gmail.com with ESMTPSA id a14-20020a056000100e00b00317f29ad113sm6387613wrx.32.2023.08.09.01.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 01:34:05 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Wed, 09 Aug 2023 09:33:53 +0100
Subject: [PATCH bpf-next] net: Fix slab-out-of-bounds in inet[6]_steal_sock
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-bpf-next-v1-1-c1b80712e83b@isovalent.com>
X-B4-Tracking: v=1; b=H4sIAHBP02QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCwML3aSCNN281IoS3UQTE6NEA0tTUzOjJCWg8oKi1LTMCrBR0UowVUq
 xtbUA4YTnsGQAAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Lorenz Bauer <lmb@isovalent.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Kumar reported a KASAN splat in tcp_v6_rcv:

  bash-5.2# ./test_progs -t btf_skc_cls_ingress
  ...
  [   51.810085] BUG: KASAN: slab-out-of-bounds in tcp_v6_rcv+0x2d7d/0x3440
  [   51.810458] Read of size 2 at addr ffff8881053f038c by task test_progs/226

The problem is that inet[6]_steal_sock accesses sk->sk_protocol without
accounting for request sockets. I added the check to ensure that we only
every try to perform a reuseport lookup on a supported socket.

It turns out that this isn't necessary at all. struct sock_common contains
a skc_reuseport flag which indicates whether a socket is part of a
reuseport group. inet[6]_lookup_reuseport already check this flag,
so we can't execute an erroneous reuseport lookup by definition.

Remove the unnecessary assertions to fix the out of bounds access.

Fixes: 9c02bec95954 ("bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign")
Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 include/net/inet6_hashtables.h | 10 ----------
 include/net/inet_hashtables.h  | 10 ----------
 2 files changed, 20 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 284b5ce7205d..f9907ed36d54 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -119,16 +119,6 @@ struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 	if (!prefetched)
 		return sk;
 
-	if (sk->sk_protocol == IPPROTO_TCP) {
-		if (sk->sk_state != TCP_LISTEN)
-			return sk;
-	} else if (sk->sk_protocol == IPPROTO_UDP) {
-		if (sk->sk_state != TCP_CLOSE)
-			return sk;
-	} else {
-		return sk;
-	}
-
 	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff,
 					  saddr, sport, daddr, ntohs(dport),
 					  ehashfn);
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 1177effabed3..57a46993383a 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -465,16 +465,6 @@ struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 	if (!prefetched)
 		return sk;
 
-	if (sk->sk_protocol == IPPROTO_TCP) {
-		if (sk->sk_state != TCP_LISTEN)
-			return sk;
-	} else if (sk->sk_protocol == IPPROTO_UDP) {
-		if (sk->sk_state != TCP_CLOSE)
-			return sk;
-	} else {
-		return sk;
-	}
-
 	reuse_sk = inet_lookup_reuseport(net, sk, skb, doff,
 					 saddr, sport, daddr, ntohs(dport),
 					 ehashfn);

---
base-commit: eb62e6aef940fcb1879100130068369d4638088f
change-id: 20230808-bpf-next-a442a095562b

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>


