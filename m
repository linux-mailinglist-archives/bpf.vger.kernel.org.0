Return-Path: <bpf+bounces-10770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ED47AE049
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 22:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BA164281F10
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 20:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82F6241F9;
	Mon, 25 Sep 2023 20:24:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFA9241E5;
	Mon, 25 Sep 2023 20:24:55 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4477F111;
	Mon, 25 Sep 2023 13:24:54 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c465d59719so49587475ad.1;
        Mon, 25 Sep 2023 13:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695673494; x=1696278294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGlO7iXA08+oNOe13C8SGeJOdlscizAQcKnMOa1d/SM=;
        b=C+xaOiZlttCEA8jpW4QQUeoteVurHWgSyMPoZoTNnuRSVYQ8VdZnzEf+cO1UdNzAHD
         lmJ8fdmgK53yjzwohGB+LPLQoV6rC9I58uHVNwuB5L/sigSgi+/YWiMwDbbsAMHS+oc5
         sgxR4q/1ehAlHUzqHaVd8JQeeCTh9TFjt0Jrh7hfVGHgbdT612dV/t+FX7NeSKjtY9mz
         rOvxyHB793peOQ2hjAccdmtXSqp8nPt/IyP3K3Gebi67ED/A3FC8vMjyBg4RBBMS0dTq
         vmQHPmBDcq7wfkwzTCIYlAVKwYQSBRQIC8FRS9dir+N2Hz+0Qx8HXjO9HPi9n79SxVj+
         Sv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695673494; x=1696278294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGlO7iXA08+oNOe13C8SGeJOdlscizAQcKnMOa1d/SM=;
        b=bcm6smisATvdg86E9bThM3k079q9GAGW4FM16oFNf2EwBLY3lXcUnnz/3igxi0HPzr
         0V2vHwbxJiBw6g55EA/VGxTWNKyF1INkOtOlxbmBb5C35M587X4Q4PM+HvtKOig/9BW9
         swQjLHEUeQEnbUejQhX9/WrhH/b4FEu+Qmwp5zxcDBDxnEpT7erwYsb5Da8jciz8QzqN
         bpqdudS2lTqBrxfHH64Zw4IEgEjqX1Q6x+ypQByE8eGil46YE3dt6IxE+BVRApVswFUy
         85mVdZn5QFsPYwidcQFLRG9pCjorqP1NrjiD8WNrUnvQfsFGjoXZ1uG3qqOpqEYny9x8
         pD1w==
X-Gm-Message-State: AOJu0YyQkDdE3HcNN1dScLNe65ayQ+VBjeNG5PQeOen78BAhHgD2DVJn
	yEdU0OVAffAmBoaxxQ8JQ2Y=
X-Google-Smtp-Source: AGHT+IEf8lUeCHRUj3sx1mFKrcBRGaHkQxxAL6kyzNzA+uNr6o+AMaKp5hl1SYpXOe4iSlYOPxENDQ==
X-Received: by 2002:a17:902:a714:b0:1c0:d5c6:748f with SMTP id w20-20020a170902a71400b001c0d5c6748fmr4896290plq.67.1695673493707;
        Mon, 25 Sep 2023 13:24:53 -0700 (PDT)
Received: from john.lan ([2605:59c8:148:ba00:51e:699c:e63:c15a])
        by smtp.gmail.com with ESMTPSA id jg6-20020a17090326c600b001c61df93afdsm2254040plb.59.2023.09.25.13.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 13:24:53 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com
Subject: [PATCH bpf v2 2/3] bpf: sockmap, do not inc copied_seq when PEEK flag set
Date: Mon, 25 Sep 2023 13:24:47 -0700
Message-Id: <20230925202448.100920-3-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230925202448.100920-1-john.fastabend@gmail.com>
References: <20230925202448.100920-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
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


