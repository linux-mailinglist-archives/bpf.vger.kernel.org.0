Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55291F6CBB
	for <lists+bpf@lfdr.de>; Thu, 11 Jun 2020 19:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgFKRZt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Jun 2020 13:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgFKRZs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Jun 2020 13:25:48 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA716C03E96F
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2020 10:25:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so7024871wru.0
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2020 10:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GmHmPvjIL/uoQZEqL49hjtjHKbcvKuEnA1LiIhhiiv4=;
        b=CMzvm+imQ9cB23Eiy1rEwYePeux7mfPlyD6M/FEjx5Hh6kdKtBGC6QkIrZj0C6FwWi
         OffW2wZLvIpgYLzJFod41sU26hINgE+Otu9+lSQ8mdn+YYNLSd8m6rYUn7Zy0wqDRIlR
         YrS2tofgEqd1VY32pehLP0/GCkbMu/RdT3GHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GmHmPvjIL/uoQZEqL49hjtjHKbcvKuEnA1LiIhhiiv4=;
        b=iS9pyxTBvTLwhImXBdBo3oCywSnouBCFpXGrb8WAxOapEfks7C644P/1hI3x/7T4Au
         VU854+38bF6mUUp1IM5SN4WomScXHFT1BDcSWUcOZEBRhy8Y6kH61Z/uKcu2LAA6BdN6
         5SRPM1XGpV0CtAxdmI3fpaF2oneFtWin2XuKBLx3nHn3ypN+ZMTJBp1JmQdoklYkTRry
         A8TOcUVupN27hyHUJmTWU1iVmRGOR7L4p3XHNT357FGojgziB/74AdlkekMuL98uWSZ4
         q3axeaTwX8eaCu4BQv2x5rPBo1XyoN6t3mG0UvNjQaLTS5z4sKvVo6kvz6VygLPQeIpn
         SOLg==
X-Gm-Message-State: AOAM532+Of7bC/DNADAsxZnRmx7ItqzZJNCAKInPkHQSEkNiHy8zh2MU
        RO5El2pPdASekDA+snElHzWINg==
X-Google-Smtp-Source: ABdhPJzfvbquWMv3SW72gKgtUedJACAfw0cuil7ok4HdoKUCgxg9YSjE0tpPciptHEDo7nJ9xggemw==
X-Received: by 2002:adf:d852:: with SMTP id k18mr10714394wrl.177.1591896345683;
        Thu, 11 Jun 2020 10:25:45 -0700 (PDT)
Received: from antares.lan (4.1.2.f.7.2.f.a.4.b.9.9.a.8.4.a.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:a48a:99b4:af27:f214])
        by smtp.gmail.com with ESMTPSA id v7sm5971907wro.76.2020.06.11.10.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 10:25:45 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: sockmap: don't attach programs to UDP sockets
Date:   Thu, 11 Jun 2020 18:25:20 +0100
Message-Id: <20200611172520.327602-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The stream parser infrastructure isn't set up to deal with UDP
sockets, so we mustn't try to attach programs to them.

I remember making this change at some point, but I must have lost
it while rebasing or something similar.

Fixes: 7b98cd42b049 ("bpf: sockmap: Add UDP support")
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 net/core/sock_map.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 00a26cf2cfe9..35cea36f3892 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -424,10 +424,7 @@ static int sock_map_get_next_key(struct bpf_map *map, void *key, void *next)
 	return 0;
 }
 
-static bool sock_map_redirect_allowed(const struct sock *sk)
-{
-	return sk->sk_state != TCP_LISTEN;
-}
+static bool sock_map_redirect_allowed(const struct sock *sk);
 
 static int sock_map_update_common(struct bpf_map *map, u32 idx,
 				  struct sock *sk, u64 flags)
@@ -508,6 +505,11 @@ static bool sk_is_udp(const struct sock *sk)
 	       sk->sk_protocol == IPPROTO_UDP;
 }
 
+static bool sock_map_redirect_allowed(const struct sock *sk)
+{
+	return sk_is_tcp(sk) && sk->sk_state != TCP_LISTEN;
+}
+
 static bool sock_map_sk_is_suitable(const struct sock *sk)
 {
 	return sk_is_tcp(sk) || sk_is_udp(sk);
-- 
2.25.1

