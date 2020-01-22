Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6809F1454B9
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2020 14:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgAVNF6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jan 2020 08:05:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36444 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbgAVNFz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jan 2020 08:05:55 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so6728306ljg.3
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2020 05:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1WPgC+WzLyR0JTgO+VoeJbEDZ15TC0NlN7bHnmyGW2I=;
        b=guUnHF+b2XBtTH80NV9Ugt2prah8RfD9ICvqdTf6wYRCuFDHcqP241kWxkjWqlXKBy
         Gfk/P3WFa9x/4ComwvOktW1SbE9E/GkbEC0L8yPM7TmXmXS/9pBGdydfSQkqjty7D1we
         yCA3YGL4Xxr+HtnJiErSR8EyzgSgPM2K43yHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1WPgC+WzLyR0JTgO+VoeJbEDZ15TC0NlN7bHnmyGW2I=;
        b=FBMKL803n4BUIbejem8seU9e0+iusMjxZSh7Gh/N3n+/KxC5zICCsn4p+eLjHPJhTS
         h5NN2uW6NJWwy/e5tDbRLz7HPJhdvzPGp+B+l+HFj5euMf8qaErzrZ6kCgs/3to6t9US
         dQaAe7eqp2fu4O82GCz0yXqL+MX/AdQ8j/tQoO/IXGuwtIqTIgX0E6dEEGvKhRpCPYme
         zIfGnkqUFiSVffW5JR10AGBdlckPc+5NOLEc1ncU2ek8oggP3gt/oul2nfZt43K/2Vj4
         sthH6Aai/zn+kbYn//DMtdiyEQTQd+DbDXB8XU01rxhAQWASA2FbHVfs6ug8XG4A/kjP
         LqpA==
X-Gm-Message-State: APjAAAVRYwd0HcOZR+KEOSzpRu4q4966OJsjV6+hzf7Wy2D4vwsihtyI
        J5iPK6CtAbIZuWX7TDCpgdclvWFQPN7IDA==
X-Google-Smtp-Source: APXvYqyM4b6klmHamWkPtjgtRzdMuQUoo5aDxQZglSZXnjldZxqa13QD2wdP7ZvSpwlOQrpdqlOzuA==
X-Received: by 2002:a2e:9e19:: with SMTP id e25mr3889597ljk.179.1579698352823;
        Wed, 22 Jan 2020 05:05:52 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id n30sm24529109lfi.54.2020.01.22.05.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 05:05:52 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, Martin Lau <kafai@fb.com>
Subject: [PATCH bpf-next v3 01/12] bpf, sk_msg: Don't clear saved sock proto on restore
Date:   Wed, 22 Jan 2020 14:05:38 +0100
Message-Id: <20200122130549.832236-2-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122130549.832236-1-jakub@cloudflare.com>
References: <20200122130549.832236-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There is no need to clear psock->sk_proto when restoring socket protocol
callbacks in sk->sk_prot. The psock is about to get detached from the sock
and eventually destroyed. At worst we will restore the protocol callbacks
twice.

This makes reasoning about psock state easier. Once psock is initialized,
we can count on psock->sk_proto always being set.

Also, we don't need a fallback for when socket is not using ULP.
tcp_update_ulp already does this for us.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/skmsg.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index ef7031f8a304..41ea1258d15e 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -359,17 +359,7 @@ static inline void sk_psock_restore_proto(struct sock *sk,
 					  struct sk_psock *psock)
 {
 	sk->sk_write_space = psock->saved_write_space;
-
-	if (psock->sk_proto) {
-		struct inet_connection_sock *icsk = inet_csk(sk);
-		bool has_ulp = !!icsk->icsk_ulp_data;
-
-		if (has_ulp)
-			tcp_update_ulp(sk, psock->sk_proto);
-		else
-			sk->sk_prot = psock->sk_proto;
-		psock->sk_proto = NULL;
-	}
+	tcp_update_ulp(sk, psock->sk_proto);
 }
 
 static inline void sk_psock_set_state(struct sk_psock *psock,
-- 
2.24.1

