Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B3D258CD8
	for <lists+bpf@lfdr.de>; Tue,  1 Sep 2020 12:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgIAKch (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Sep 2020 06:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgIAKcf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Sep 2020 06:32:35 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EC5C061247
        for <bpf@vger.kernel.org>; Tue,  1 Sep 2020 03:32:32 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a17so921399wrn.6
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2020 03:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VEGASO9P1HdpQxP2iPbGFQR83fZx/f3uWrCgAHvQKas=;
        b=ErZ/I+ax/Gpvj4IAUCn3DhJlig6zZUU2EIbGdkB88ujoX6i6aqXJMXRfiK69V5V6MR
         rARz9AE6fMvwtMYliV+MOzyAqBsLWvK1XNN8P07I+3x9eGLaWUq9APJLY279EwIW5uEu
         wQFscACFIvCcB/EsCHI8oQFFZplGiTKSnC9RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VEGASO9P1HdpQxP2iPbGFQR83fZx/f3uWrCgAHvQKas=;
        b=qbw7RbkcYxNxqzF4Mzb6zBRBjh2IcGL7cMrnqT0faqE+/kfNVfFti1HwYb3lN61V2V
         AtMi9rAQQSNFKnXIel/D+dW1H5OD5YtxQ0Ug3Kyi+2gjj5f4aGbKUdkoGsqUAPbr8qm0
         aUrxqeCz0elTSQn7iXg0/pyHfHkXSo8wBck6UYIaY4D5onY4cJ8+XkZXCXgsNBdwzk5H
         jtFUI1SgzMquuPe2qM5EKzD8U8EuMnVc8lB6itO+nWr0ShwwaT6C5f9DLRPvyrGqGeQ1
         2oMRe/Hz5x7D4h0rhScv/Zq+3sWXPVPSoJbCX0YXIWaMqsc6H5O8T1MIaYd5PLdPhnmX
         j1qw==
X-Gm-Message-State: AOAM5339MmOntsHvjCg7vqvWg53yGC7odDsNzN95z9znSm9w9eOIF7L8
        5i/zI+hjmQOQlQ9d2fi2JqEsjf3pdvzteQ==
X-Google-Smtp-Source: ABdhPJylGVg9ysAm19dHh3+yWCaUY71aWUewaJs0MR/Uv+KosZS9uaU+xbIvWu3fWhmTc7B7+GlBHw==
X-Received: by 2002:adf:f382:: with SMTP id m2mr1071783wro.327.1598956345612;
        Tue, 01 Sep 2020 03:32:25 -0700 (PDT)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id l10sm1653070wru.59.2020.09.01.03.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 03:32:24 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v2 1/4] net: sockmap: Remove unnecessary sk_fullsock checks
Date:   Tue,  1 Sep 2020 11:32:07 +0100
Message-Id: <20200901103210.54607-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200901103210.54607-1-lmb@cloudflare.com>
References: <20200901103210.54607-1-lmb@cloudflare.com>
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
index d6c6e1e312fc..ffdf94a30c87 100644
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
@@ -1109,7 +1109,7 @@ static void *sock_hash_lookup(struct bpf_map *map, void *key)
 	struct sock *sk;
 
 	sk = __sock_hash_lookup_elem(map, key);
-	if (!sk || !sk_fullsock(sk))
+	if (!sk)
 		return NULL;
 	if (sk_is_refcounted(sk) && !refcount_inc_not_zero(&sk->sk_refcnt))
 		return NULL;
-- 
2.25.1

