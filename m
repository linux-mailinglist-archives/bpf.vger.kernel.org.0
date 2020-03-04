Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B81F4178E33
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 11:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387841AbgCDKOW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 05:14:22 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43964 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387842AbgCDKNw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 05:13:52 -0500
Received: by mail-lf1-f65.google.com with SMTP id s23so1005889lfs.10
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 02:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Movn+41WzemIACV44Fj+5GKGifBnp1jThwTXCnphEII=;
        b=TddC90GRsrDTwSE8vyf7+jsQhS3OBT3oNLdpUk85sRr9mKFEFN7fhgP8a8w8iJ7WrQ
         p8qx8T10ne1R9vl9EUskFrdk8t8FieWCnI3VJh9Ea9KwTLbXHPgeEBaaX72MNf1ASuLR
         U22psr85+3QqLwLj7W6MZQgBaHNky/Wz9Oklk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Movn+41WzemIACV44Fj+5GKGifBnp1jThwTXCnphEII=;
        b=VAWAtTLcwPimKJClcE1WlxkdW7i51al+7XrCqUrtCjSciz3ea2nbQwH3hvRkd6wjcV
         2ADqeYy+yb3JI0Z8mysN6t3f0489miSqUgCeiw1uTa825+klkAh1RCmsdRl9X46gImvM
         ZuNKO+Mwx8tzvnbUPTPNB3YeY0cJPTQivNixBSo3STYtkCI5U8Me/nTEfJLUSaAKt99B
         M3cRr416xd5XJ6XcmMa7mYg3AZqjc3HdOiauhU2OrY4T3F3CeCl2UcWPJ9XV3Ha/VPcP
         EtmjQke/khprzVgv60mIrokheKuW8dKEw0nVhtJUOiQNQiN0zFzsDDIUDony4ZLtXOqc
         LPSg==
X-Gm-Message-State: ANhLgQ0S4UIbOdi8xRp01reCsAD9/RwhzEw3/oih4f82jF/eJ/QjbBCu
        56QojugAsUfdBM+72vRsaWKsRA==
X-Google-Smtp-Source: ADFU+vsvVlRIf6CFlh+LzZRNmFJ1lIq+SfyC3CWjWypXJsqv11dvTSDvmc/RZ7grTaxoWXLbkA4R5Q==
X-Received: by 2002:ac2:4948:: with SMTP id o8mr1584139lfi.201.1583316830033;
        Wed, 04 Mar 2020 02:13:50 -0800 (PST)
Received: from localhost.localdomain ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id l7sm341777lfk.65.2020.03.04.02.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 02:13:49 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     john.fastabend@gmail.com, Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 08/12] bpf: sockmap: add UDP support
Date:   Wed,  4 Mar 2020 11:13:13 +0100
Message-Id: <20200304101318.5225-9-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304101318.5225-1-lmb@cloudflare.com>
References: <20200304101318.5225-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow adding hashed UDP sockets to sockmaps.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/sock_map.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 83c5082cefd3..1485a8fd571c 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/jhash.h>
 #include <linux/sock_diag.h>
+#include <net/udp.h>
 
 struct bpf_stab {
 	struct bpf_map map;
@@ -147,7 +148,19 @@ static int sock_map_init_proto(struct sock *sk, struct sk_psock *psock)
 
 	sock_owned_by_me(sk);
 
-	prot = tcp_bpf_get_proto(sk, psock);
+	switch (sk->sk_type) {
+	case SOCK_STREAM:
+		prot = tcp_bpf_get_proto(sk, psock);
+		break;
+
+	case SOCK_DGRAM:
+		prot = udp_bpf_get_proto(sk, psock);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
 	if (IS_ERR(prot))
 		return PTR_ERR(prot);
 
@@ -162,7 +175,7 @@ static struct sk_psock *sock_map_psock_get_checked(struct sock *sk)
 	rcu_read_lock();
 	psock = sk_psock(sk);
 	if (psock) {
-		if (sk->sk_prot->recvmsg != tcp_bpf_recvmsg) {
+		if (sk->sk_prot->close != sock_map_close) {
 			psock = ERR_PTR(-EBUSY);
 			goto out;
 		}
@@ -474,15 +487,31 @@ static bool sock_map_op_okay(const struct bpf_sock_ops_kern *ops)
 	       ops->op == BPF_SOCK_OPS_TCP_LISTEN_CB;
 }
 
-static bool sock_map_sk_is_suitable(const struct sock *sk)
+static bool sk_is_tcp(const struct sock *sk)
 {
 	return sk->sk_type == SOCK_STREAM &&
 	       sk->sk_protocol == IPPROTO_TCP;
 }
 
+static bool sk_is_udp(const struct sock *sk)
+{
+	return sk->sk_type == SOCK_DGRAM &&
+	       sk->sk_protocol == IPPROTO_UDP;
+}
+
+static bool sock_map_sk_is_suitable(const struct sock *sk)
+{
+	return sk_is_tcp(sk) || sk_is_udp(sk);
+}
+
 static bool sock_map_sk_state_allowed(const struct sock *sk)
 {
-	return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);
+	if (sk_is_tcp(sk))
+		return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);
+	else if (sk_is_udp(sk))
+		return sk_hashed(sk);
+
+	return false;
 }
 
 static int sock_map_update_elem(struct bpf_map *map, void *key,
-- 
2.20.1

