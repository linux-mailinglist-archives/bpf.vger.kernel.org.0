Return-Path: <bpf+bounces-41828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1840399BA56
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 18:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D16B20F50
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 16:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0041482F6;
	Sun, 13 Oct 2024 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="JTuiPL34"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A573D2F42;
	Sun, 13 Oct 2024 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728836843; cv=none; b=gNh22/1OeZzYfPK/9XQTkf4aKasWXvDExPLG7KhGn9PU7gUWRY15IntmxHa7Yo+GvDBriTu7PT48dm6hAjvh0DDosYd9O2bVymIHWLcR9pWgukp6q4xDvH1PG3SyMX3QKwoytHpwKv6YVco+wFYP4GEVuEwEC9+cdzOaMK9D70o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728836843; c=relaxed/simple;
	bh=ATz0ke/Gyqfq12BWInrt1+S0gvlwRss8NN0cvFIE+XI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xw3xLb2+H18toFb57KTmmU3oG8DgeH3Xxeyp9g8ABdLimqgp0lWXou6b+9AW+LqYAq+mGy55+uJUzNKV4nULgB4Rrh2yZaJBn7UY9493lXHFQmVmzYBWGJ7EW390f4GXurPuHpqBXQgX7K0KtpwoX6RLUVMghE74tGyN2CCwhgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=JTuiPL34; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1t01R0-00Cycu-CN; Sun, 13 Oct 2024 18:27:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=L1Tce96RUTs2pMiFj61EXXUMJFuuEoy26u+9hdzmS0A=; b=JTuiPL34z2zWnLWD4vcIWJ9nlp
	sz8V25aXSC1omfOy4Glv1XkSH+XXuNoZwav8Mfqd+6fkuZG6xilSOsUekQcEnMftoXPszNDGh3HgN
	J5+nthL4MM7ZvN1S5HA4PMnBSf1x7jcXiHG9uz0fOST33dwaOlPDn+6G3Mb8SNry27aal+hVHjuxM
	6wcKnHuU2BhxIb4KDr70wsXP0cJ9k6UNlRhMJwT6zo2UrjOu8HDGt2nEsO8wCl20FvONkyvLN6c3A
	y7vm14K2h2cyzVoWMix99IgQUYYZpr47G6RClICiVoefNf/usZL8kFYlAMAbz4bJfYdwIlbzj/X3v
	ccqJmR7Q==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1t01Qz-0007ii-PK; Sun, 13 Oct 2024 18:27:10 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1t01Qg-00GV5b-3f; Sun, 13 Oct 2024 18:26:50 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Sun, 13 Oct 2024 18:26:39 +0200
Subject: [PATCH bpf v2 1/4] bpf, sockmap: SK_DROP on attempted redirects of
 unsupported af_vsock
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241013-vsock-fixes-for-redir-v2-1-d6577bbfe742@rbox.co>
References: <20241013-vsock-fixes-for-redir-v2-0-d6577bbfe742@rbox.co>
In-Reply-To: <20241013-vsock-fixes-for-redir-v2-0-d6577bbfe742@rbox.co>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Don't mislead the callers of bpf_{sk,msg}_redirect_{map,hash}(): make sure
to immediately and visibly fail the forwarding of unsupported af_vsock
packets.

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 include/net/sock.h  | 5 +++++
 net/core/sock_map.c | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index c58ca8dd561b7312ffc0836585c04d9fe917a124..c87295f3476db23934d4fcbeabc7851c61ad2bc4 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2715,6 +2715,11 @@ static inline bool sk_is_stream_unix(const struct sock *sk)
 	return sk->sk_family == AF_UNIX && sk->sk_type == SOCK_STREAM;
 }
 
+static inline bool sk_is_vsock(const struct sock *sk)
+{
+	return sk->sk_family == AF_VSOCK;
+}
+
 /**
  * sk_eat_skb - Release a skb if it is no longer needed
  * @sk: socket to eat this skb from
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 242c91a6e3d3870ec6da6fa095d180a933d1d3d4..07d6aa4e39ef606aab33bd0d95711ecf156596b9 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -647,6 +647,8 @@ BPF_CALL_4(bpf_sk_redirect_map, struct sk_buff *, skb,
 	sk = __sock_map_lookup_elem(map, key);
 	if (unlikely(!sk || !sock_map_redirect_allowed(sk)))
 		return SK_DROP;
+	if ((flags & BPF_F_INGRESS) && sk_is_vsock(sk))
+		return SK_DROP;
 
 	skb_bpf_set_redir(skb, sk, flags & BPF_F_INGRESS);
 	return SK_PASS;
@@ -675,6 +677,8 @@ BPF_CALL_4(bpf_msg_redirect_map, struct sk_msg *, msg,
 		return SK_DROP;
 	if (!(flags & BPF_F_INGRESS) && !sk_is_tcp(sk))
 		return SK_DROP;
+	if (sk_is_vsock(sk))
+		return SK_DROP;
 
 	msg->flags = flags;
 	msg->sk_redir = sk;
@@ -1249,6 +1253,8 @@ BPF_CALL_4(bpf_sk_redirect_hash, struct sk_buff *, skb,
 	sk = __sock_hash_lookup_elem(map, key);
 	if (unlikely(!sk || !sock_map_redirect_allowed(sk)))
 		return SK_DROP;
+	if ((flags & BPF_F_INGRESS) && sk_is_vsock(sk))
+		return SK_DROP;
 
 	skb_bpf_set_redir(skb, sk, flags & BPF_F_INGRESS);
 	return SK_PASS;
@@ -1277,6 +1283,8 @@ BPF_CALL_4(bpf_msg_redirect_hash, struct sk_msg *, msg,
 		return SK_DROP;
 	if (!(flags & BPF_F_INGRESS) && !sk_is_tcp(sk))
 		return SK_DROP;
+	if (sk_is_vsock(sk))
+		return SK_DROP;
 
 	msg->flags = flags;
 	msg->sk_redir = sk;

-- 
2.46.2


