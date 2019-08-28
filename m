Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67BDB9FB7B
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2019 09:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfH1HXC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Aug 2019 03:23:02 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:47030 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH1HXC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Aug 2019 03:23:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id n19so1201695lfe.13
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2019 00:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j4WMQ/3Dx+AZa1aWjnEi6wMNf236pVFxqbAD38HBIaU=;
        b=X3zqJkk9bVbUNvBcOVggAhq71xZW6pCY5nGe92Y4SECXF+ODAm08s0ACT15Ryhc8/v
         Qzm04MJl2YcI/3WORlZa/UBW+XbkkzbIWvAAeaUTG6KR7LE+t2ZWQYZnQpzwv6OdrIH9
         9q/k7cK+Fjf8QeZgKqw0EbKcKQ8XIhH91p6jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j4WMQ/3Dx+AZa1aWjnEi6wMNf236pVFxqbAD38HBIaU=;
        b=NCHZp/AtBqq/WuxEJ2sHZGPH4a/kbesrW86Qvm6toeZRqYA1Vj3fW+xO7LdGpgMKY/
         K04sCwbrP6UyeIwio5Nfi66Z0WjIrRoUzdLj+9C1u7FZ3ouSE2sgwCw+OiNWeHqhdZqH
         PJDGWKofLqIMtYelNqrXj4Y762PQKYY9s/tiEaf9iHbt8d2RbPuhb2hcDXGiNJkIW38o
         Bsnt2kgQ+Len5bd3owuzchAez5FfGNdquN6CFsXBF9H6aI+pqFINEwRrgmm/MP2JLNID
         KLFImY7OqDk4GVN2Kpde5KEX22MVbqaUPtPO3eqYCElsDBrgj/T7wwygMxoBV63rYehS
         +Rcg==
X-Gm-Message-State: APjAAAUAe/0Y02i8xJFh3iZLppcn1bwhXaVxLWLBDFZY+4OtvPI0US37
        9jLjRmyB04Zz7Vgiy1RK3dH0z3GxtZvixQ==
X-Google-Smtp-Source: APXvYqxdL58XhnoUnv+xgMrhdzuuhzUNqijgwZuY1/IWgJgDpSbYxa+t5nUbmAsWHaPD3J5NPCgaKg==
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr756128lfp.61.1566976979793;
        Wed, 28 Aug 2019 00:22:59 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id t8sm441315ljg.70.2019.08.28.00.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 00:22:59 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        Marek Majkowski <marek@cloudflare.com>
Subject: [RFCv2 bpf-next 04/12] inet: Store layer 4 protocol in inet_hashinfo
Date:   Wed, 28 Aug 2019 09:22:42 +0200
Message-Id: <20190828072250.29828-5-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828072250.29828-1-jakub@cloudflare.com>
References: <20190828072250.29828-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make it possible to identify the protocol of the sockets stored in hashinfo
without looking up one.

Subsequent patches make use the new field at the socket lookup time to
enforce that the BPF program selects only sockets with matching protocol.

Reviewed-by: Lorenz Bauer <lmb@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/net/inet_hashtables.h | 3 +++
 net/dccp/proto.c              | 2 +-
 net/ipv4/tcp_ipv4.c           | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index af2b4c065a04..b2d43ee72dc1 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -138,6 +138,9 @@ struct inet_hashinfo {
 	unsigned int			lhash2_mask;
 	struct inet_listen_hashbucket	*lhash2;
 
+	/* Layer 4 protocol of the stored sockets */
+	int				protocol;
+
 	/* All the above members are written once at bootup and
 	 * never written again _or_ are predominantly read-access.
 	 *
diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index 5bad08dc4316..805eee1b4fb0 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -45,7 +45,7 @@ EXPORT_SYMBOL_GPL(dccp_statistics);
 struct percpu_counter dccp_orphan_count;
 EXPORT_SYMBOL_GPL(dccp_orphan_count);
 
-struct inet_hashinfo dccp_hashinfo;
+struct inet_hashinfo dccp_hashinfo = { .protocol = IPPROTO_DCCP };
 EXPORT_SYMBOL_GPL(dccp_hashinfo);
 
 /* the maximum queue length for tx in packets. 0 is no limit */
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index fd394ad179a0..5d2afbcc45cc 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -87,7 +87,7 @@ static int tcp_v4_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig_key *key,
 			       __be32 daddr, __be32 saddr, const struct tcphdr *th);
 #endif
 
-struct inet_hashinfo tcp_hashinfo;
+struct inet_hashinfo tcp_hashinfo = { .protocol = IPPROTO_TCP };
 EXPORT_SYMBOL(tcp_hashinfo);
 
 static u32 tcp_v4_init_seq(const struct sk_buff *skb)
-- 
2.20.1

