Return-Path: <bpf+bounces-10501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCF77A8FDA
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 01:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3BD1F20EFD
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 23:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB2E41231;
	Wed, 20 Sep 2023 23:27:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0679F3F4DC;
	Wed, 20 Sep 2023 23:27:14 +0000 (UTC)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8584BC9;
	Wed, 20 Sep 2023 16:27:13 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-274dacb5d18so189570a91.1;
        Wed, 20 Sep 2023 16:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695252433; x=1695857233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtmXpIji2GdJDD3PGIdnsvoKl7h7PoK7NMP5lX5SbYc=;
        b=QKdP8Pd+NGqg+n/m5cIWN2Tx/Dj8vvqPPCLO70dHwIU7hjoXl+c5bY/8Wa6GLgV1te
         qyV6HJ4x3Qu+24RMz8LLaLf5IWQ8CCLpXQUWx6/ozUnEIwEgFzIJ3G07+meTFMTlFhqs
         VeUgd8FBOfy13TwvJzU0w8h18yFR0AI9+QXWWU6XDWv9L+NrlqBjC8CnMvuXI3jze6FH
         nU3BvsY67uE+gReGFt549HrwAWou3a+exaxHfixCGbb3ePDkXmhPEXDB8TlaE/efgut2
         RXS2C9eUJPkIdCnrgWnAGBSqaR9DFeE8LCOSf49B7GMWsLDTdKauv8OFqh/lp0RVzoUV
         nyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695252433; x=1695857233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtmXpIji2GdJDD3PGIdnsvoKl7h7PoK7NMP5lX5SbYc=;
        b=e/Ks7PomBKZMBENDr0d4XyNDzt9eY/9/XynnQt5LgTSizovilzi5ORldPndpagIYMW
         uR6rj3h1MZU0b55foQhP/J1xzePqFQb4VA9keUuO8yKb5O3WtemZtmoEdj+MglrvqKB/
         TxmQ15ijJMFGRhYfmu4GCrdeAmsajEF9siaohSw5NwHnIbH9cawVBSkFPGRBQFSqPP0B
         wDiQRLiLunUJBdujM2xsp5gIF2V9UwYayrwFf+PEQ8TaHqrrqXOoshC0ehinqbw0fhf8
         g5hbPGN+DE3LCo08eK4V7T9toBr7ohgexPFiQA1/R7a3dpFvyEVflqHjG8FxDeOYD330
         C0LQ==
X-Gm-Message-State: AOJu0Ywgz262iZdzniRjieXH34A6eIDXHMevSHBb/rG2ybLvUr3GoJTU
	6xWYXGrQ7xn5c/7n2O4H3RI=
X-Google-Smtp-Source: AGHT+IHXOqeHA7kpk6pB48m3pjFZHF1H6cAOx7xU1NN57Gu7P2EdiE3OrF50g7ZlP97ZlEXN5p3Hbg==
X-Received: by 2002:a17:90a:7848:b0:274:98aa:72d8 with SMTP id y8-20020a17090a784800b0027498aa72d8mr5442427pjl.3.1695252432937;
        Wed, 20 Sep 2023 16:27:12 -0700 (PDT)
Received: from john.lan ([98.97.37.198])
        by smtp.gmail.com with ESMTPSA id mz6-20020a17090b378600b0026b12768e46sm115362pjb.42.2023.09.20.16.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 16:27:12 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf 2/3] bpf: sockmap, do not inc copied_seq when PEEK flag set
Date: Wed, 20 Sep 2023 16:27:05 -0700
Message-Id: <20230920232706.498747-3-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230920232706.498747-1-john.fastabend@gmail.com>
References: <20230920232706.498747-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When data is peek'd off the receive queue we shouldn't considered it
copied from tcp_sock side. When we increment copied_seq this will confuse
tcp_data_ready() because copied_seq can be arbitrarily increased. From]
application side it results in poll() operations not waking up when
expected.

Notice tcp stack without BPF recvmsg programs also does not increment
copied_seq.

We broke this when we moved copied_seq into recvmsg to only update when
actual copy was happening. But, it wasn't working correctly either before
because the tcp_data_ready() tried to use the copied_seq value to see
if data was read by user yet. See fixes tags.

Fixes: e5c6de5fa0258 ("bpf, sockmap: Incorrectly handling copied_seq")
Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 net/ipv4/tcp_bpf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 81f0dff69e0b..327268203001 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -222,6 +222,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 				  int *addr_len)
 {
 	struct tcp_sock *tcp = tcp_sk(sk);
+	int peek = flags & MSG_PEEK;
 	u32 seq = tcp->copied_seq;
 	struct sk_psock *psock;
 	int copied = 0;
@@ -311,7 +312,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 		copied = -EAGAIN;
 	}
 out:
-	WRITE_ONCE(tcp->copied_seq, seq);
+	if (!peek)
+		WRITE_ONCE(tcp->copied_seq, seq);
 	tcp_rcv_space_adjust(sk);
 	if (copied > 0)
 		__tcp_cleanup_rbuf(sk, copied);
-- 
2.33.0


