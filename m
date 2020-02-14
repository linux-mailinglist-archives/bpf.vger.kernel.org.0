Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97EF615EE3F
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2020 18:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389542AbgBNQEZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Feb 2020 11:04:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:52452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389929AbgBNQEY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Feb 2020 11:04:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD62724654;
        Fri, 14 Feb 2020 16:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696263;
        bh=SsqKa/ZjaIyluXId/sG0bPe98/YPUtYaCn6TggH3Gso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JGZL7LpDgitee61e6CBVQ99SbbR/iyoCuht0TAuQ8pmA9McYrarY2OBU9cmosCUYk
         snQQWt/UrCQ39ZCZF+soN/K1LUl8ukXo2sUevlXC9f/2ZSk1jJnVtCoQ5ripgkk2u4
         ILDKTSuhWGUUJK5kF85TQpbnIt74+CkfAg/nfvP4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lorenz Bauer <lmb@cloudflare.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 116/459] bpf, sockmap: Check update requirements after locking
Date:   Fri, 14 Feb 2020 10:56:06 -0500
Message-Id: <20200214160149.11681-116-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Lorenz Bauer <lmb@cloudflare.com>

[ Upstream commit 85b8ac01a421791d66c3a458a7f83cfd173fe3fa ]

It's currently possible to insert sockets in unexpected states into
a sockmap, due to a TOCTTOU when updating the map from a syscall.
sock_map_update_elem checks that sk->sk_state == TCP_ESTABLISHED,
locks the socket and then calls sock_map_update_common. At this
point, the socket may have transitioned into another state, and
the earlier assumptions don't hold anymore. Crucially, it's
conceivable (though very unlikely) that a socket has become unhashed.
This breaks the sockmap's assumption that it will get a callback
via sk->sk_prot->unhash.

Fix this by checking the (fixed) sk_type and sk_protocol without the
lock, followed by a locked check of sk_state.

Unfortunately it's not possible to push the check down into
sock_(map|hash)_update_common, since BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB
run before the socket has transitioned from TCP_SYN_RECV into
TCP_ESTABLISHED.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Link: https://lore.kernel.org/bpf/20200207103713.28175-1-lmb@cloudflare.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock_map.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 058422b932607..b16ff3b8c6503 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -417,14 +417,16 @@ static int sock_map_update_elem(struct bpf_map *map, void *key,
 		ret = -EINVAL;
 		goto out;
 	}
-	if (!sock_map_sk_is_suitable(sk) ||
-	    sk->sk_state != TCP_ESTABLISHED) {
+	if (!sock_map_sk_is_suitable(sk)) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
 
 	sock_map_sk_acquire(sk);
-	ret = sock_map_update_common(map, idx, sk, flags);
+	if (sk->sk_state != TCP_ESTABLISHED)
+		ret = -EOPNOTSUPP;
+	else
+		ret = sock_map_update_common(map, idx, sk, flags);
 	sock_map_sk_release(sk);
 out:
 	fput(sock->file);
@@ -740,14 +742,16 @@ static int sock_hash_update_elem(struct bpf_map *map, void *key,
 		ret = -EINVAL;
 		goto out;
 	}
-	if (!sock_map_sk_is_suitable(sk) ||
-	    sk->sk_state != TCP_ESTABLISHED) {
+	if (!sock_map_sk_is_suitable(sk)) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
 
 	sock_map_sk_acquire(sk);
-	ret = sock_hash_update_common(map, key, sk, flags);
+	if (sk->sk_state != TCP_ESTABLISHED)
+		ret = -EOPNOTSUPP;
+	else
+		ret = sock_hash_update_common(map, key, sk, flags);
 	sock_map_sk_release(sk);
 out:
 	fput(sock->file);
-- 
2.20.1

