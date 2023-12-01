Return-Path: <bpf+bounces-16409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC96801228
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B42BB21310
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 18:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BAC4EB59;
	Fri,  1 Dec 2023 18:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m822Kl/o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3AAD3;
	Fri,  1 Dec 2023 10:01:54 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-58db7d8f2ebso1373712eaf.0;
        Fri, 01 Dec 2023 10:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701453713; x=1702058513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehrEtxFf+SemmI6CFRUloMvjNjYMgW8x66/cVUtvsUA=;
        b=m822Kl/o+KhpmdDz0lsP7rPEeikYImBxbIyOzFtoa88D5mvhh/9KLFB9HpVzwXew66
         xts3OWVbahGBanf4wUUa1x/i4nkPLF9oEstUYXQlGqZssnlIRXJh9OLECcnlgo5kkonh
         KFNZ6cpkWZjJuZmfQj5hEx5+5gxO0wRvmIc9IRZdTfk8lL4Y1rGQ7r/SHdNWH+Qug740
         dYO9OYkiCIl5nU+F3vBBlFPHHiugRXugelgwwlmsvLP+1ptsMqL2ccAluRAkHXsdVtBE
         Y5eV2PQUvLMYI25jwdeJlP8HwEof6/hLk6e4SaTdmwFTsnjeqR79H4aaP5TZUQl0URiH
         GkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701453713; x=1702058513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehrEtxFf+SemmI6CFRUloMvjNjYMgW8x66/cVUtvsUA=;
        b=p0bFn+/LW2OBuF6CArFQhXi820iwJWlmsZcJKyJHUVXRlI29IWpTKIBJ/nTek4CXoh
         XnNp1JhY0SVUrH4nxftW/DibO4maRVyrQ2mni+TkcSMtObs+5Hr95uI3dT5xAm/1Gzfe
         v4SL+xdM702KvfNsmgyoo70zbUYGXk6UUW5bThTgBX7lXtU2X/hCdwHUCJlICmVWHak8
         mSlHcvcx0Nw+sVgi3d6iIf0bDpIRzM9q4V++jSjsP4/h9s7x+bdIr9DnPFxhoy0kiHqz
         t04fgxc0HWAgMKFSbTkwTchS82dMYueDGX0/a+p8gNwRW91VRNB2JMPJhx7HtDxpQnwt
         10Gg==
X-Gm-Message-State: AOJu0YxozOQUPtYOP8DDpLULeEEqVclKszgRvCXNJ/4wFOZFxHrWQ7QI
	cp9ikm+xl9U1d4X8fw/5i/o=
X-Google-Smtp-Source: AGHT+IECggYx5hZTqD3RUJqgG+ghQ6Dp7yCbaY4NCd27j9JSL86uGgSPc00c3VHtJIaf7Iq6RUdjmQ==
X-Received: by 2002:a05:6358:2917:b0:16d:de1a:50c7 with SMTP id y23-20020a056358291700b0016dde1a50c7mr26012719rwb.27.1701453713486;
        Fri, 01 Dec 2023 10:01:53 -0800 (PST)
Received: from john.lan ([2605:59c8:148:ba10:7a9a:8993:d50f:aaa4])
        by smtp.gmail.com with ESMTPSA id l11-20020a635b4b000000b005b6c1972c99sm3362493pgm.7.2023.12.01.10.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:01:51 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: martin.lau@kernel.org,
	edumazet@google.com,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf v2 1/2] bpf: syzkaller found null ptr deref in unix_bpf proto add
Date: Fri,  1 Dec 2023 10:01:38 -0800
Message-Id: <20231201180139.328529-2-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231201180139.328529-1-john.fastabend@gmail.com>
References: <20231201180139.328529-1-john.fastabend@gmail.com>
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
index 1d6931caf0c3..0201136b0b9c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2799,6 +2799,11 @@ static inline bool sk_is_tcp(const struct sock *sk)
 	return sk->sk_type == SOCK_STREAM && sk->sk_protocol == IPPROTO_TCP;
 }
 
+static inline bool sk_is_stream_unix(const struct sock *sk)
+{
+	return sk->sk_family == AF_UNIX && sk->sk_type == SOCK_STREAM;
+}
+
 /**
  * sk_eat_skb - Release a skb if it is no longer needed
  * @sk: socket to eat this skb from
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 4292c2ed1828..27d733c0f65e 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -536,6 +536,8 @@ static bool sock_map_sk_state_allowed(const struct sock *sk)
 {
 	if (sk_is_tcp(sk))
 		return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);
+	if (sk_is_stream_unix(sk))
+		return (1 << sk->sk_state) & TCPF_ESTABLISHED;
 	return true;
 }
 
-- 
2.33.0


