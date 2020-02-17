Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E430D1611D4
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2020 13:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgBQMPi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Feb 2020 07:15:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39487 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729271AbgBQMPi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Feb 2020 07:15:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so19439400wrt.6
        for <bpf@vger.kernel.org>; Mon, 17 Feb 2020 04:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jCHoKcCMPHVHYZkdA6WAbFzeHe8Ds4D3bQUsVArTMzc=;
        b=TZ7lSFXOIS/7Hl8jHuJP1lrbWqk19KQjnq3CNSaOEpdO5iufBOMqnlzGI/0J0oXo24
         hLXuwfg9O+0ESot+usSHfZvrl4ezIRWF3dtKH9FWT/tDJ2u9+pdev6n7btFzd3WKCsgA
         hg1BjP4N2CwQ0vrW7nCPFjf3ISo/gtuRX64P4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jCHoKcCMPHVHYZkdA6WAbFzeHe8Ds4D3bQUsVArTMzc=;
        b=kRrEUPXkdNGvRRpfOjNho3cnLpOhr5lzyCJOdYXcwIu2YDF9bAi2Q4lAvOUYPEyLmE
         psDT+5WKh2Jvt4LYp7GNumXmT9QLV1W1FYNaU9gRyUNoYY87BSTr5ycJQJ4QqF/a10BI
         pTLsCJ0xxHW7i2R3LvZg/h4dBuzYJrxJwH9wUZ2zsfT4uMroTrGobTrAMjgRAUqojmsN
         BcqFc80s0cpBitjodHUbmc5969FpBMa+gwKVeiwpVZOqHkhWNoM4uNhQ0DSdR487iL3P
         T9bp5a4TwlyjA8priQ3KzE6IEE8K00TwwyxYxCpoxvxMbEkor+HzP8bqU260ELrh0ZYu
         3D9w==
X-Gm-Message-State: APjAAAXNh3xapyzQzmUSW8LYiLBET/HlFaKUOvzLbp1t/k1RMOfYZK1l
        hXODm1Hb87f7e8sR6iNY2Ae1oF1PDiwf22ux
X-Google-Smtp-Source: APXvYqztfvE+e6i/bQ1sSwxD92a8SngZHOnYSeOveqVbIp7kiv2Cs1GgeSxSs6g+p27XEZFNsjqnzg==
X-Received: by 2002:adf:df83:: with SMTP id z3mr21822909wrl.389.1581941735881;
        Mon, 17 Feb 2020 04:15:35 -0800 (PST)
Received: from cloudflare.com ([88.157.168.82])
        by smtp.gmail.com with ESMTPSA id n1sm758325wrw.52.2020.02.17.04.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 04:15:35 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH bpf-next 2/3] bpf, sk_msg: Don't clear saved sock proto on restore
Date:   Mon, 17 Feb 2020 12:15:29 +0000
Message-Id: <20200217121530.754315-3-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217121530.754315-1-jakub@cloudflare.com>
References: <20200217121530.754315-1-jakub@cloudflare.com>
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

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/skmsg.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 8605947d6c08..d90ef61712a1 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -359,13 +359,7 @@ static inline void sk_psock_restore_proto(struct sock *sk,
 					  struct sk_psock *psock)
 {
 	sk->sk_prot->unhash = psock->saved_unhash;
-
-	if (psock->sk_proto) {
-		tcp_update_ulp(sk, psock->sk_proto, psock->saved_write_space);
-		psock->sk_proto = NULL;
-	} else {
-		sk->sk_write_space = psock->saved_write_space;
-	}
+	tcp_update_ulp(sk, psock->sk_proto, psock->saved_write_space);
 }
 
 static inline void sk_psock_set_state(struct sk_psock *psock,
-- 
2.24.1

