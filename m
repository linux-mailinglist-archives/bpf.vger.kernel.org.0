Return-Path: <bpf+bounces-10840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106177AE451
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 05:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C35BF281B20
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 03:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A85C1FB5;
	Tue, 26 Sep 2023 03:53:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E9F1871;
	Tue, 26 Sep 2023 03:53:08 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CF4BF;
	Mon, 25 Sep 2023 20:53:07 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c5ff5f858dso28181785ad.2;
        Mon, 25 Sep 2023 20:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695700387; x=1696305187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtmXpIji2GdJDD3PGIdnsvoKl7h7PoK7NMP5lX5SbYc=;
        b=aExA4ZHUBgoluxLAmvV3nVWrOYmLclFWMkTlbWLzByFOBP1myI3HBkw17Z3LImnCd7
         VZFwoPW3aw8fQs8CWxjlLeQHu/UqlXcZ0/SQiqZzX02OJTz9nONwcco8AVP9OPxyxg3z
         id0LeWA/1mOSI67+G7EXU7HvAN+cednXcQBih48O0Ag1JgWM4MXD20r9dacHKf8UpCZc
         Wl/qPeDEQCmlZv4QtIHfBcpy/rUgABVhl7/6v/zm3rAeywyHRKTP1XsfmqdrFiv5mEPZ
         a6gaP0SSl1UQ73nym+/KFKLPz592J3lDP4YuwR9rYBhTHCbss1m9bVLx9KkC0Jf0yu2M
         l3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695700387; x=1696305187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtmXpIji2GdJDD3PGIdnsvoKl7h7PoK7NMP5lX5SbYc=;
        b=X8s/tNophbg/wbhlmjBZoDI5eL1UZqOimYg+igHDir4usUSHIzWDjiAhixqucMwebx
         CaUV+t948RipAiHER+BSxqgHrvDthnty7beq6vR/E3FGnV2ltNasL8dndLz/w8LnKgNL
         VfU+h/8KKl+DDk6oKGVJauVqarHFYdWX//sauAwzuDr6yhq2NFoUFwYkRay9LUGZ8itH
         X6nYmqiUR4gyUlCQTUFUTdKdIacRy7IkQce2wMxzrgH2CvtRn0T//kzxLmj9+Gs49/39
         B8SXzmiH29TY/BJi+VHITAE8dqKc0J9iZCA/ddD5PogxL2afzdyeDLMi+Kde6R7h1C6/
         vylA==
X-Gm-Message-State: AOJu0YzN8CRav0g96kqVx2WpT+Sfl1k9OB6hzP3pBBMgBMYyMohtE82L
	s7AJStDY8ADv/sRsZzqnDgQ=
X-Google-Smtp-Source: AGHT+IE9TRSHjLYIyHx0EfjiOL8BU6UNvPZPbCRHud2Hb6ZWS5iww1Fr/B+dsv/wCYO2IKUYWm3rvg==
X-Received: by 2002:a17:902:be06:b0:1c1:e4f8:a5a9 with SMTP id r6-20020a170902be0600b001c1e4f8a5a9mr6188578pls.34.1695700387068;
        Mon, 25 Sep 2023 20:53:07 -0700 (PDT)
Received: from john.lan ([2605:59c8:148:ba00:650a:2e28:f286:c10b])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b001c3e732b8dbsm9755723plg.168.2023.09.25.20.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 20:53:06 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com
Subject: [PATCH bpf v3 2/3] bpf: sockmap, do not inc copied_seq when PEEK flag set
Date: Mon, 25 Sep 2023 20:52:59 -0700
Message-Id: <20230926035300.135096-3-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230926035300.135096-1-john.fastabend@gmail.com>
References: <20230926035300.135096-1-john.fastabend@gmail.com>
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


