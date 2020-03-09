Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84BD017DE6A
	for <lists+bpf@lfdr.de>; Mon,  9 Mar 2020 12:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgCILNZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Mar 2020 07:13:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38134 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgCILNW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Mar 2020 07:13:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id t11so10533434wrw.5
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2020 04:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jEnbcYRycw/hWL6MmlTxPPCQ5M+9RM4SKFDd/p6Kui8=;
        b=BDENuu6uoi/mCHeSx362pjV5lZjtQhqeSsU7wqFwDAG9rDcuzl61Ha1VT1PYCaCQ47
         fX1iBqzU00cFrjHruPmc9hQ+G+VwWKVg9+ZlQi5puFSVAfI7qvqgXWm5Mzhq/hgWh4CI
         W7SSWGP6kgV+10dPSwf+j1dI0uifwFQQ0YqjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jEnbcYRycw/hWL6MmlTxPPCQ5M+9RM4SKFDd/p6Kui8=;
        b=dtMkqVHCcgxrI+63root/VfKQZUWLr46/fJbHVD/V1Dt2/KASvs2dqnpQ3Bo283fpm
         IuYT+aZup3G3aVXNWOKWMDd4z1Uif2ENobcTqQY38blmWxufIvxrG4dd/o69nAUQsjN7
         P0nfrcfy+lSztRXO7umh6TCE97TdOuoiQQO6s02IIeHOupnm/1TOz1OB1St1O4IKbGE6
         h3UmfOj9a3QEZHf/im1T8Kc322Jfymb3/YNQf7+U4tpM7l6m5kD6OUUugpHddzGIDiQW
         c5ZyEEnEocngWO+vEqZKlTIuM+8KlP6Xn5wZ4l2dHoXByhYsPJqwQ2VrOHvagXfckwnZ
         qAvA==
X-Gm-Message-State: ANhLgQ0zVHB6NOqCjLn67w7mNXJKPvg/t/vjrgTfwABYc/J9Bmw0NOB3
        tGhVXY0FBm8BbvZHhriv0oDVYQ==
X-Google-Smtp-Source: ADFU+vvnkMI87sOHtUHrLDQD/Gcj0uROILN3wH1ZOtJMgAtbceLXGB+n8nkj1y1KnzZ39NozXrw8uw==
X-Received: by 2002:a05:6000:2:: with SMTP id h2mr21136844wrx.182.1583752399624;
        Mon, 09 Mar 2020 04:13:19 -0700 (PDT)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:3dcc:c1d:7f05:4873])
        by smtp.gmail.com with ESMTPSA id a5sm25732846wmb.37.2020.03.09.04.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 04:13:19 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 06/12] bpf: sockmap: simplify sock_map_init_proto
Date:   Mon,  9 Mar 2020 11:12:37 +0000
Message-Id: <20200309111243.6982-7-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309111243.6982-1-lmb@cloudflare.com>
References: <20200309111243.6982-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We can take advantage of the fact that both callers of
sock_map_init_proto are holding a RCU read lock, and
have verified that psock is valid.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 net/core/sock_map.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index cb240d87e068..edfdce17b951 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -141,28 +141,17 @@ static void sock_map_unref(struct sock *sk, void *link_raw)
 	}
 }
 
-static int sock_map_init_proto(struct sock *sk)
+static int sock_map_init_proto(struct sock *sk, struct sk_psock *psock)
 {
-	struct sk_psock *psock;
 	struct proto *prot;
 
 	sock_owned_by_me(sk);
 
-	rcu_read_lock();
-	psock = sk_psock(sk);
-	if (unlikely(!psock)) {
-		rcu_read_unlock();
-		return -EINVAL;
-	}
-
 	prot = tcp_bpf_get_proto(sk, psock);
-	if (IS_ERR(prot)) {
-		rcu_read_unlock();
+	if (IS_ERR(prot))
 		return PTR_ERR(prot);
-	}
 
 	sk_psock_update_proto(sk, psock, prot);
-	rcu_read_unlock();
 	return 0;
 }
 
@@ -241,7 +230,7 @@ static int sock_map_link(struct bpf_map *map, struct sk_psock_progs *progs,
 	if (msg_parser)
 		psock_set_prog(&psock->progs.msg_parser, msg_parser);
 
-	ret = sock_map_init_proto(sk);
+	ret = sock_map_init_proto(sk, psock);
 	if (ret < 0)
 		goto out_drop;
 
@@ -286,7 +275,7 @@ static int sock_map_link_no_progs(struct bpf_map *map, struct sock *sk)
 			return -ENOMEM;
 	}
 
-	ret = sock_map_init_proto(sk);
+	ret = sock_map_init_proto(sk, psock);
 	if (ret < 0)
 		sk_psock_put(sk, psock);
 	return ret;
-- 
2.20.1

