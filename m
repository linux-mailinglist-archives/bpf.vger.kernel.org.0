Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F25614A4AE
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2020 14:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgA0NLZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jan 2020 08:11:25 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43298 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgA0NLK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jan 2020 08:11:10 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so10565566ljm.10
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2020 05:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3sMKCOVjXYbspFAszwvSlLxiNsGoib87qyH6av20+QQ=;
        b=aApIoXFJGku+dxvGfQK1O0et4CGkGEblQcjQO//pXCyB/b4WOoPxMkmAglYX7GybGy
         RPl6NlSelpJwGYz18Lh2ALEt/eciHNAJYWuXN8ldrXbjXAHCwBtWsEHC8x8aV73WT/RK
         mKforSAx/LHCjYXpOqimJfQXhcaevA0QO0GDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3sMKCOVjXYbspFAszwvSlLxiNsGoib87qyH6av20+QQ=;
        b=h+Rs+kghHD2Hl3CKWdGDn9gJgGPbBiyL2r7ff9su0MLO/lQB79vYm8v/5DP99dqghO
         GFCj4Z0YJHFV85JzYPO0Gkk5Jux1G+sVm4xFV5zljnwhHfkECIpCU607NFNF+L7xuhbx
         8oPuntDrc7g2A5B7LnNL3dlrX/kQflrMaqpw3t7GK5DMNSqyFYwdf3D5IUKtaXNrwnFN
         TsGCdEQU1U3b5xjxx5I66tYAO3u1Vwi3n2HD9R2F3fnWsNA0o022tQBeMNvCGTy8F98U
         lBUU0335q3I2XXr6eNYgVvyhZnRA7BK1+qZn2NtF2P2mbMAqcfOtypFXeQiE0SPUyb8C
         rD1A==
X-Gm-Message-State: APjAAAVKyV7rRzwYwgeEaEyrtbq9BuG8sqrnwBk2wcOV3680MlYzvvy5
        8067XXzxTKn5A2jk8zV5GxYF7kaY52bf/Q==
X-Google-Smtp-Source: APXvYqwhay3xN9Rbr2LFpiDXTU7pGKGfT3kE5ep2/rzhw7O3Vha+0P3kzfhNgkrW2kwvrZvGUb/udw==
X-Received: by 2002:a2e:96c4:: with SMTP id d4mr10377120ljj.225.1580130668046;
        Mon, 27 Jan 2020 05:11:08 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id n1sm8017909lfq.16.2020.01.27.05.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 05:11:07 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v6 06/12] bpf, sockmap: Don't set up sockmap progs for listening sockets
Date:   Mon, 27 Jan 2020 14:10:51 +0100
Message-Id: <20200127131057.150941-7-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127131057.150941-1-jakub@cloudflare.com>
References: <20200127131057.150941-1-jakub@cloudflare.com>
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

