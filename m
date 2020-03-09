Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA4A417DE73
	for <lists+bpf@lfdr.de>; Mon,  9 Mar 2020 12:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgCILOL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Mar 2020 07:14:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36609 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgCILNR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Mar 2020 07:13:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id g62so4601033wme.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2020 04:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VhnNh0FQpU0IXnemYuyXF82fe/AvYFMA5w4Rk3Zgjg8=;
        b=OPuFONLR+flmNj8q3OtmclC70Xv8ZSwnJ2b3unDxiP/H22qOrNB0U8O9evExpS2Pvh
         aANMarFYBxasC60dzb2/yI3+GoWDeoshz7mgTXsYd9GrRYkLoFPeUABNInnZ49oxNSrj
         Jd0ozRGwe7VkvtE/yTFobFyc9k1B4iEgb52uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VhnNh0FQpU0IXnemYuyXF82fe/AvYFMA5w4Rk3Zgjg8=;
        b=qwfsmqn7gPwkTI7WyrGePynKsj9OoVQkfbTNJ2j2CMp3WNeECB9rucYOHv7Gr2mxK4
         j4V2oVLJK4VY9G+sh2JOdkFlNySDRcY/l4IFvQfXmMUdBLvsYRSeFegrkccrCdlTNOjJ
         ddcEODWrdB/zazX6T7ICn1O77YcnAuAPOKYcq+sr9g8YlbZVn4nLtF+513xU+1uO/4ib
         NLx8FCloSfnwxSh5XEMrBEVLlopi02/cnsjhrWVys3f9y7t73Dg3h5Bc0+8NXTwIECkr
         E3S8ml91BKkCFZ173ZMp65cGQ3Ye5LKra2kr75uPW1Jw3jDUkI4SUnF9veSKVV/v87Ap
         ebPQ==
X-Gm-Message-State: ANhLgQ2LQOAnTrh+UQ6nIO+9oc1Zph+J0Mkqt1Byz1WPDspb0hCTEO8F
        ipAPDFK7eFxfG0zUP2I0HpuRNg==
X-Google-Smtp-Source: ADFU+vvw76jpjuBquu29c/ImGlyugCxB+gF1RrtRq0128jT1ZEa3yp+jKznj7UEb3KCDKavSApSTJw==
X-Received: by 2002:a1c:2b44:: with SMTP id r65mr19143120wmr.72.1583752395887;
        Mon, 09 Mar 2020 04:13:15 -0700 (PDT)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:3dcc:c1d:7f05:4873])
        by smtp.gmail.com with ESMTPSA id a5sm25732846wmb.37.2020.03.09.04.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 04:13:15 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v4 04/12] bpf: tcp: guard declarations with CONFIG_NET_SOCK_MSG
Date:   Mon,  9 Mar 2020 11:12:35 +0000
Message-Id: <20200309111243.6982-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309111243.6982-1-lmb@cloudflare.com>
References: <20200309111243.6982-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

tcp_bpf.c is only included in the build if CONFIG_NET_SOCK_MSG is
selected. The declaration should therefore be guarded as such.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
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

