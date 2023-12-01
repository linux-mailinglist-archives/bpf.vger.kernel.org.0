Return-Path: <bpf+bounces-16344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E81180020D
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 04:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074AE2814BB
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 03:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C26522B;
	Fri,  1 Dec 2023 03:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex3+ZZ7O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE74103;
	Thu, 30 Nov 2023 19:23:28 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cde14ff73bso1408275b3a.0;
        Thu, 30 Nov 2023 19:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701401008; x=1702005808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRVjatiApQRrpcxKKckhnUIWHuxs82y/kVuHlgmpuCA=;
        b=Ex3+ZZ7OOjEgS/IKZdeh1yPdxFiEW3DqMHaELkOD44jkxN9vk1qMokI1vcjqqWucJs
         Vq/+aNLnbWupHkUpFv5XVW1uUgssq7Plqr1PV9CdgpG4ryuoozeXDNmlx/LG8SfJ+9sy
         M9PxCzsFXQi/q6Brvvb9ZBPlttZk2z2Ntms8CdrY/xmKgnHmw3DOYR2Y3PQ6+FfSGrFW
         DdEQwIiY7SUjlAu6HAOF8jgAQ8U/gJqYNOCjw/4UZ1452TPKKHOHcOyniK8xklF8mkh8
         Kt8V0IhPOEEXuYGMGwpjSm9BwtYePI66nIdjUkBwdMcRWXJvsRrfBxhHMzif4EngXjJu
         kOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701401008; x=1702005808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRVjatiApQRrpcxKKckhnUIWHuxs82y/kVuHlgmpuCA=;
        b=TPMs0YQP9zDUdZtRbdOatHcbkM+vGURIU5LwmMkxEkeSzaYIcIySGKsPMz88zjwm0A
         tWo8y8PYivcVSsXf8jF06r/5ZRoF64hzxy2hb57qv/GrxFjXOMIV7mftVTtT6A0xCZSA
         n0C9B4uNqIEI8QVAOntkmY6jjFZ52COFwsKOjsx5jkUl0UN7CfwIHJ/65dUU4uUVnnbr
         xv4qUC6IeFbP2LUEoz5glfFQYjSiBC/Jy2NY8yXlpEYN1a8pFE9ZduMasntkFlEDsSci
         R2NchFk9l1ktgHP4853XfoX1ackDgiUEnWkjxKEo6viEJ5ATSB/iAcMTvqdiWuw65hIF
         4OTw==
X-Gm-Message-State: AOJu0Yx8bXTlUzc2ReL1kRbpzeENysbVkMcwIivx5UHK3Ja9SvRpIn+d
	+v6NVzSxwFcO/MFQgFyXLrOeemtnWUYozg==
X-Google-Smtp-Source: AGHT+IETSBZrFPk6hR3wxWpWnawIVoSqDrTqhPvgIRL93OzJC+CNJqvOXN6yOZDCGf8LamBH41z06g==
X-Received: by 2002:a05:6a00:1803:b0:6cd:d312:b767 with SMTP id y3-20020a056a00180300b006cdd312b767mr10233791pfa.6.1701401007819;
        Thu, 30 Nov 2023 19:23:27 -0800 (PST)
Received: from john.lan ([2605:59c8:148:ba10:1053:7b0:e3cc:7b48])
        by smtp.gmail.com with ESMTPSA id a13-20020a65640d000000b005c60cdb08f0sm1768136pgv.0.2023.11.30.19.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 19:23:27 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: kuniyu@amazon.com,
	edumazet@google.com,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf 1/2] bpf: syzkaller found null ptr deref in unix_bpf proto add
Date: Thu, 30 Nov 2023 19:23:15 -0800
Message-Id: <20231201032316.183845-2-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231201032316.183845-1-john.fastabend@gmail.com>
References: <20231201032316.183845-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I added logic to track the sock pair for stream_unix sockets so that we
ensure lifetime of the sock matches the time a sockmap could reference
the sock (see fixes tag). I forgot though that we allow af_unix unconnected
sockets into a sock{map|hash} map.

This is problematic because previous fixed expected sk_pair() to exist
and did not NULL check it. Because unconnected sockets have a NULL
sk_pair this resulted in the NULL ptr dereference found by syzkaller.

BUG: KASAN: null-ptr-deref in unix_stream_bpf_update_proto+0x72/0x430 net/unix/unix_bpf.c:171
Write of size 4 at addr 0000000000000080 by task syz-executor360/5073
Call Trace:
 <TASK>
 ...
 sock_hold include/net/sock.h:777 [inline]
 unix_stream_bpf_update_proto+0x72/0x430 net/unix/unix_bpf.c:171
 sock_map_init_proto net/core/sock_map.c:190 [inline]
 sock_map_link+0xb87/0x1100 net/core/sock_map.c:294
 sock_map_update_common+0xf6/0x870 net/core/sock_map.c:483
 sock_map_update_elem_sys+0x5b6/0x640 net/core/sock_map.c:577
 bpf_map_update_value+0x3af/0x820 kernel/bpf/syscall.c:167

We considered just checking for the null ptr and skipping taking a ref
on the NULL peer sock. But, if the socket is then connected() after
being added to the sockmap we can cause the original issue again. So
instead this patch blocks adding af_unix sockets that are not in the
ESTABLISHED state.

Reported-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot+e8030702aefd3444fb9e@syzkaller.appspotmail.com
Fixes: 8866730aed51 ("bpf, sockmap: af_unix stream sockets need to hold ref for pair sock")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 include/net/sock.h  | 5 +++++
 net/core/sock_map.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 1d6931caf0c3..ea1155d68f0b 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2799,6 +2799,11 @@ static inline bool sk_is_tcp(const struct sock *sk)
 	return sk->sk_type == SOCK_STREAM && sk->sk_protocol == IPPROTO_TCP;
 }
 
+static inline bool sk_is_unix(const struct sock *sk)
+{
+	return sk->sk_family == AF_UNIX && sk->sk_type == SOCK_STREAM;
+}
+
 /**
  * sk_eat_skb - Release a skb if it is no longer needed
  * @sk: socket to eat this skb from
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 4292c2ed1828..448aea066942 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -536,6 +536,8 @@ static bool sock_map_sk_state_allowed(const struct sock *sk)
 {
 	if (sk_is_tcp(sk))
 		return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);
+	if (sk_is_unix(sk))
+		return (1 << sk->sk_state) & TCPF_ESTABLISHED;
 	return true;
 }
 
-- 
2.33.0


