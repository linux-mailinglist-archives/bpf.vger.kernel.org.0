Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF75214A497
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2020 14:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgA0NLD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jan 2020 08:11:03 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40922 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgA0NLC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jan 2020 08:11:02 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18so10587811ljo.7
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2020 05:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oGEzFFujPwWuIw3gQtLufJeQphlCGYv9Oxfo+ByH1nw=;
        b=Yv7D6EvZiQty/obe4fvkmNfyKdZOYrQX2e1LGFuf/X7lFW11e2o+WEw5rJ9tGcxhbg
         6CwUkSuJEcGjQPRRwtxxhnpdIu722wI4Cze07jk7g6w0wMYBw/+Ni2mAggN/wXZvcyRG
         zWIiY09RVZ2Cue8IhnBfJt3NcySwj+Zb2gRfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oGEzFFujPwWuIw3gQtLufJeQphlCGYv9Oxfo+ByH1nw=;
        b=TjfvCoDfj6XcfGRyPPIRBDzM4W/HkUKc6laKlAkVsu6Gk1klHVA3ZKe+L6hQhmFE29
         kCtDjxurQoNt3PdZisUeA5JhRi+/zhlbQKug8MAADqvn4hJ1AmA9sYH3BLpbtjeIaNjs
         PdlD+qQRjQ/IdEmt/FHnjcI6gkPLSdA3IYkse9TgOUQPctnS8ZH0kGmjQrUUHNY5FNrd
         nQCTg9mkBx+JpmNvaoGpOzdkUeoalKiNc4bv6tGeyn3gn6XgXKzHR13oIz/8ysZaL1f/
         gwU82gC4wPcF5D8Nj4PuPHjRVzZOjB2a7+Zbf00NxtOdCVwi/7qKyTY4rQ8U6e9oxJLG
         R7hQ==
X-Gm-Message-State: APjAAAXEJ1/wpMeZcchqSa66FF/Qm6I8nD0lvPUnagz/CBvQoTrz8dPZ
        hrZJfEC2INOKjzEzPaW7Hj2Xj/YpmJo14Q==
X-Google-Smtp-Source: APXvYqy+oAUebTRtGco+zIxlpQsLiGdUmPPnP8sGWlLjV9waufhtiP7pk9VqIuB4z/F/GAe/3ZnPww==
X-Received: by 2002:a2e:b80e:: with SMTP id u14mr10529928ljo.17.1580130660463;
        Mon, 27 Jan 2020 05:11:00 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id t1sm8214248lji.98.2020.01.27.05.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 05:11:00 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com
Subject: [PATCH bpf-next v6 01/12] bpf, sk_msg: Don't clear saved sock proto on restore
Date:   Mon, 27 Jan 2020 14:10:46 +0100
Message-Id: <20200127131057.150941-2-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127131057.150941-1-jakub@cloudflare.com>
References: <20200127131057.150941-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There is no need to clear psock->sk_proto when restoring socket protocol
callbacks in sk->sk_prot. The psock is about to get detached from the sock
and eventually destroyed. At worst we will restore the protocol callbacks
and the write callback twice.

This makes reasoning about psock state easier. Once psock is initialized,
we can count on psock->sk_proto always being set.

Also, we don't need a fallback for when socket is not using ULP.
tcp_update_ulp already does this for us.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/skmsg.h | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 14d61bba0b79..6311838e7df8 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -358,23 +358,7 @@ static inline void sk_psock_update_proto(struct sock *sk,
 static inline void sk_psock_restore_proto(struct sock *sk,
 					  struct sk_psock *psock)
 {
-	sk->sk_prot->unhash = psock->saved_unhash;
-
-	if (psock->sk_proto) {
-		struct inet_connection_sock *icsk = inet_csk(sk);
-		bool has_ulp = !!icsk->icsk_ulp_data;
-
-		if (has_ulp) {
-			tcp_update_ulp(sk, psock->sk_proto,
-				       psock->saved_write_space);
-		} else {
-			sk->sk_prot = psock->sk_proto;
-			sk->sk_write_space = psock->saved_write_space;
-		}
-		psock->sk_proto = NULL;
-	} else {
-		sk->sk_write_space = psock->saved_write_space;
-	}
+	tcp_update_ulp(sk, psock->sk_proto, psock->saved_write_space);
 }
 
 static inline void sk_psock_set_state(struct sk_psock *psock,
-- 
2.24.1

