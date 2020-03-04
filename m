Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8757178E38
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 11:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387761AbgCDKO2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 05:14:28 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40538 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387751AbgCDKNp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 05:13:45 -0500
Received: by mail-lf1-f66.google.com with SMTP id p5so1018964lfc.7
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 02:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U0wl1OJM6IH+sDqygSxTDk69keKKulf2E2ZitkodWc0=;
        b=pF4iF5TXR55/ShmYFyj64mtfIECTPwHUFTRMmBpG4v9K1a4oRko1LAc47oTrbPEZ7V
         ekTdV8Ugwvyah43WBZWKl1+avVwtF8AIuMjrRV6b2afdDIoZxSz1yBF9KJRkNnxbca6w
         kRb89JQ0VGHf6ttX+xKFebk61MJf1B0dFLtd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U0wl1OJM6IH+sDqygSxTDk69keKKulf2E2ZitkodWc0=;
        b=I6wLciYfJSZuuuchB0rZx6nSCF4HqttwRuzA32QVTgjIRfYP+OpgUmC1vW9DIJ/Qre
         dUB02r6hDmJCJD78BNvXi2+HWaabh6X6n7rFmLMdLuXi7qZ1uROma8IAlRh77GnI9NL5
         ZAs8b6VG5sH4dPkJLYt+FQ47ylnwZXojcxJI0GJBPHrw+Q21pDm0HnVhjJ5Gw4X9SOdC
         c5BpHv9my3bJHXa/cVuqW5YqejbRsgAnbV6XwkSjB3EyLpYwIFUGYZ4SwXMarC/8S+UQ
         p1U46WE3N9BD4afNQxo/A3oR0A7qoG72SHHwsDZlbL7uKvdB+Fh5xowNNkm8oFvmI+mG
         u84Q==
X-Gm-Message-State: ANhLgQ1sxf6rn37SF96O6I1St/7TY6Hc3EqVkmaw087BH+IIR8LrMP9g
        i8LM6873ekXO1f6407FcXxFz4A==
X-Google-Smtp-Source: ADFU+vuatKbNiLy7NuHZEEf/SpW/MBWvMF9amGOA+G+XIAlpSOS9i5x3LuuVPh8QK7qMDAuLd4pnbw==
X-Received: by 2002:ac2:4d41:: with SMTP id 1mr1553046lfp.171.1583316822741;
        Wed, 04 Mar 2020 02:13:42 -0800 (PST)
Received: from localhost.localdomain ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id l7sm341777lfk.65.2020.03.04.02.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 02:13:42 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     john.fastabend@gmail.com, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 04/12] bpf: tcp: guard declarations with CONFIG_NET_SOCK_MSG
Date:   Wed,  4 Mar 2020 11:13:09 +0100
Message-Id: <20200304101318.5225-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304101318.5225-1-lmb@cloudflare.com>
References: <20200304101318.5225-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

tcp_bpf.c is only included in the build if CONFIG_NET_SOCK_MSG is
selected. The declaration should therefore be guarded as such.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 include/net/tcp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ccf39d80b695..ad3abeaa703e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2195,6 +2195,7 @@ void tcp_update_ulp(struct sock *sk, struct proto *p,
 struct sk_msg;
 struct sk_psock;
 
+#ifdef CONFIG_NET_SOCK_MSG
 int tcp_bpf_init(struct sock *sk);
 int tcp_bpf_sendmsg_redir(struct sock *sk, struct sk_msg *msg, u32 bytes,
 			  int flags);
@@ -2202,13 +2203,12 @@ int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		    int nonblock, int flags, int *addr_len);
 int __tcp_bpf_recvmsg(struct sock *sk, struct sk_psock *psock,
 		      struct msghdr *msg, int len, int flags);
-#ifdef CONFIG_NET_SOCK_MSG
 void tcp_bpf_clone(const struct sock *sk, struct sock *newsk);
 #else
 static inline void tcp_bpf_clone(const struct sock *sk, struct sock *newsk)
 {
 }
-#endif
+#endif /* CONFIG_NET_SOCK_MSG */
 
 /* Call BPF_SOCK_OPS program that returns an int. If the return value
  * is < 0, then the BPF op failed (for example if the loaded BPF
-- 
2.20.1

