Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33E022DEDA
	for <lists+bpf@lfdr.de>; Sun, 26 Jul 2020 14:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgGZMDA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Jul 2020 08:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgGZMC5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Jul 2020 08:02:57 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D99C0619D4
        for <bpf@vger.kernel.org>; Sun, 26 Jul 2020 05:02:55 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b11so7495184lfe.10
        for <bpf@vger.kernel.org>; Sun, 26 Jul 2020 05:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/WFTpEv2YkfSsuVHpM6IlfzcgmJFvanmTKP/laL22Es=;
        b=xBsRoeMlepACQ60DMmUhiobMeBYc4v7SbV4yNoYfDhTOJnsR8PedtvfKvxP3sjC7v/
         iDfuRr8Df3L5fZZW4PXA+2hFjPxMvHyJd1jt8hJ2xRvXGUT+JFFyylc9LWqT9NBZJ9Zk
         JvQHIcOz7zq0S+JAwIlx31Fc8M3QRcuIgX3QQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/WFTpEv2YkfSsuVHpM6IlfzcgmJFvanmTKP/laL22Es=;
        b=o8hpbEhoDQjslVYKYH9nzkfT7Er5JkePjhEqYUFjOwTHNndh+j3CoKB48aqME7Qqcg
         L+Waj4SHlJHuSSsTizr3zwdhym4CEuvokEbufs8rszOx6YsfjZRxG7vRVIRzDfZdoq3S
         YqdikXEr8ltk4RpFG5M4LJlWKycsAilHb9FC81StSVrU1f5bK0LQjUNdyqSrL3TvsYte
         7ilWm+CpfIM0QlfcslO859PdvrVMkBv46WqqZOQY3/cK2RFEtW5zvwu2Ak4trW+Ja26W
         yWX/J/3bIDFTlZYslms0RwgjZoOKc3l6qj2g/GetV1OhJdRm14Ilz/7M4KLd89FPZuXD
         T42g==
X-Gm-Message-State: AOAM532gZqkXWj5iJ921ff8l7YECmlI70bHND3WQRv6oEdXI0WTUWF3s
        XeeaUhKVlzm9VNFNY9M9FxjdDVYEbPnSoQ==
X-Google-Smtp-Source: ABdhPJzD+4enXXgAoaaCqLTHRKdTiHCt1Ot/xYF2ElIY1DXzcHqmB8eGAQ06bedti736lt/PRkCyWg==
X-Received: by 2002:ac2:568b:: with SMTP id 11mr9337125lfr.87.1595764973711;
        Sun, 26 Jul 2020 05:02:53 -0700 (PDT)
Received: from cloudflare.com (user-5-173-242-59.play-internet.pl. [5.173.242.59])
        by smtp.gmail.com with ESMTPSA id r13sm1768608ljg.101.2020.07.26.05.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 05:02:53 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next] udp, bpf: Ignore connections in reuseport group after BPF sk lookup
Date:   Sun, 26 Jul 2020 14:02:28 +0200
Message-Id: <20200726120228.1414348-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When BPF sk lookup invokes reuseport handling for the selected socket, it
should ignore the fact that reuseport group can contain connected UDP
sockets. With BPF sk lookup this is not relevant as we are not scoring
sockets to find the best match, which might be a connected UDP socket.

Fix it by unconditionally accepting the socket selected by reuseport.

This fixes the following two failures reported by test_progs.

  # ./test_progs -t sk_lookup
  ...
  #73/14 UDP IPv4 redir and reuseport with conns:FAIL
  ...
  #73/20 UDP IPv6 redir and reuseport with conns:FAIL
  ...

Fixes: a57066b1a019 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
Cc: David S. Miller <davem@davemloft.net>
Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/ipv4/udp.c | 2 +-
 net/ipv6/udp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 7ce31beccfc2..e88efba07551 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -473,7 +473,7 @@ static struct sock *udp4_lookup_run_bpf(struct net *net,
 		return sk;
 
 	reuse_sk = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
-	if (reuse_sk && !reuseport_has_conns(sk, false))
+	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
 }
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index c394e674f486..29d9691359b9 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -208,7 +208,7 @@ static inline struct sock *udp6_lookup_run_bpf(struct net *net,
 		return sk;
 
 	reuse_sk = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
-	if (reuse_sk && !reuseport_has_conns(sk, false))
+	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
 }
-- 
2.25.4

