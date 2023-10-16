Return-Path: <bpf+bounces-12342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804857CB32D
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 21:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 561D6B20F83
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 19:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35062347DD;
	Mon, 16 Oct 2023 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGnpjppi"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC21E341BB;
	Mon, 16 Oct 2023 19:08:25 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A026B4;
	Mon, 16 Oct 2023 12:08:24 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c888b3a25aso29778535ad.0;
        Mon, 16 Oct 2023 12:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697483303; x=1698088103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWB6xBpB8iz2g/ddQkboysdVJMwKU6SMiAo7WEpEgIY=;
        b=hGnpjppihuDPntlBmshEJGjouTgYYHZsrUv8p8jnx0WgF7affKApVBECMpoEpuejI1
         54MqNYP7X5IylwLQM/hBQPq7AeXKe/03AX4X2APW0wA9agmGHcjtKMONlbfOg9w7EbA4
         vgWJ2TxNKNKzh2k8bpc66q1GkR2Ws0B6jk+hU5Gc57ZU8o9Rfnw6L4wKL4ZNmKimryZy
         LlJH1IjKkt0w+5orRdo5V6iCkfjKdS84CnOP4tx23xd9lcPw2fCTBpgv7/ObEDoh0XOD
         JExII0sqe5+jTuB8b8HRfcVEALjRkM5VMibzAuURYziaeerOf2GqPoz/wIE+0HX5eozM
         zQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697483303; x=1698088103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWB6xBpB8iz2g/ddQkboysdVJMwKU6SMiAo7WEpEgIY=;
        b=ZnCUvfezfedtQbL6dnKn00rOi8lXlCSQwd2lsrHpXPf0ltTpDELoAnIflPr20skitY
         xolDogGFCRtgjh3hfVi+fCVH6eVRkQUcq0gZ7LvSQ9JTYaPAn8K66dVPI72g7c0b1Cgw
         hqhfZXPx5GyV5pJXZmh4hGylJE+PbOh4xNH9j98Dtp3VejmfGTM4LFGpHCaWT4BqlpjZ
         FzArysx/yx5u7qLf62yqK2OsgpK6qBQqS5nZ7MjeCbNjxDrtp+vFTULSincYSE5KiV10
         qJzt+wGadrf6wOB4f7joU50dPC0I5j0Hj05xIqObaoKN6elQnuprl+yk71axE40bKiia
         ChGQ==
X-Gm-Message-State: AOJu0Yw7UeoYcDmNVlXH7jycDzIkvcIEHFiOqQJvDmyXdcVh3AWfI2Rf
	YEeAbWZcBYEmOaM1nIwQpPTrN4qxxxI=
X-Google-Smtp-Source: AGHT+IGFF77TQWA/luq/4Dm5xIle5RztGTwvEC+5NZ0CuAeGLjx7DHLoTzsSrh6eU/Y1GbM2wTStYA==
X-Received: by 2002:a17:903:23c3:b0:1c7:398c:a437 with SMTP id o3-20020a17090323c300b001c7398ca437mr159866plh.69.1697483303307;
        Mon, 16 Oct 2023 12:08:23 -0700 (PDT)
Received: from john.lan ([98.97.116.126])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902c94200b001c9bc811d4dsm8803473pla.295.2023.10.16.12.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 12:08:22 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: yangyingliang@huawei.com,
	jakub@cloudflare.com,
	martin.lau@kernel.org,
	john.fastabend@gmail.com
Subject: [PATCH bpf 1/2] bpf: sockmap, af_unix sockets need to hold ref for pair sock
Date: Mon, 16 Oct 2023 12:08:18 -0700
Message-Id: <20231016190819.81307-2-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231016190819.81307-1-john.fastabend@gmail.com>
References: <20231016190819.81307-1-john.fastabend@gmail.com>
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

AF_UNIX sockets are a paired socket. So sending on one of the pairs
will lookup the paired socket as part of the send operation. It is
possible however to put just one of the pairs in a BPF map. This
currently increments the refcnt on the sock in the sockmap to
ensure it is not free'd by the stack before sockmap cleans up its
state and stops any skbs being sent/recv'd to that socket.

But we missed a case. If the peer socket is closed it will be
free'd by the stack. However, the paired socket can still be
referenced from BPF sockmap side because we hold a reference
there. Then if we are sending traffic through BPF sockmap to
that socket it will try to dereference the free'd pair in its
send logic creating a use after free.  And following splat,

   [59.900375] BUG: KASAN: slab-use-after-free in sk_wake_async+0x31/0x1b0
   [59.901211] Read of size 8 at addr ffff88811acbf060 by task kworker/1:2/954
   [...]
   [59.905468] Call Trace:
   [59.905787]  <TASK>
   [59.906066]  dump_stack_lvl+0x130/0x1d0
   [59.908877]  print_report+0x16f/0x740
   [59.910629]  kasan_report+0x118/0x160
   [59.912576]  sk_wake_async+0x31/0x1b0
   [59.913554]  sock_def_readable+0x156/0x2a0
   [59.914060]  unix_stream_sendmsg+0x3f9/0x12a0
   [59.916398]  sock_sendmsg+0x20e/0x250
   [59.916854]  skb_send_sock+0x236/0xac0
   [59.920527]  sk_psock_backlog+0x287/0xaa0

To fix let BPF sockmap hold a refcnt on both the socket in the
sockmap and its paired socket.  It wasn't obvious how to contain
the fix to bpf_unix logic. The primarily problem with keeping this
logic in bpf_unix was: In the sock close() we could handle the
deref by having a close handler. But, when we are destroying the
psock through a map delete operation we wouldn't have gotten any
signal thorugh the proto struct other than it being replaced.
If we do the deref from the proto replace its too early because
we need to deref the skpair after the backlog worker has been
stopped.

Given all this it seems best to just cache it at the end of the
psock and eat 8B for the af_unix and vsock users.

Fixes: 94531cfcbe79 ("af_unix: Add unix_stream_proto for sockmap")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 include/linux/skmsg.h |  1 +
 include/net/af_unix.h |  1 +
 net/core/skmsg.c      |  2 ++
 net/unix/af_unix.c    |  2 --
 net/unix/unix_bpf.c   | 10 ++++++++++
 5 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index c1637515a8a4..fbe628961cf8 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -106,6 +106,7 @@ struct sk_psock {
 	struct mutex			work_mutex;
 	struct sk_psock_work_state	work_state;
 	struct delayed_work		work;
+	struct sock			*skpair;
 	struct rcu_work			rwork;
 };
 
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 824c258143a3..49c4640027d8 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -75,6 +75,7 @@ struct unix_sock {
 };
 
 #define unix_sk(ptr) container_of_const(ptr, struct unix_sock, sk)
+#define unix_peer(sk) (unix_sk(sk)->peer)
 
 #define peer_wait peer_wq.wait
 
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 6c31eefbd777..6236164b9bce 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -826,6 +826,8 @@ static void sk_psock_destroy(struct work_struct *work)
 
 	if (psock->sk_redir)
 		sock_put(psock->sk_redir);
+	if (psock->skpair)
+		sock_put(psock->skpair);
 	sock_put(psock->sk);
 	kfree(psock);
 }
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3e8a04a13668..87dd723aacf9 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -212,8 +212,6 @@ static inline bool unix_secdata_eq(struct scm_cookie *scm, struct sk_buff *skb)
 }
 #endif /* CONFIG_SECURITY_NETWORK */
 
-#define unix_peer(sk) (unix_sk(sk)->peer)
-
 static inline int unix_our_peer(struct sock *sk, struct sock *osk)
 {
 	return unix_peer(osk) == sk;
diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
index 2f9d8271c6ec..705eeed10be3 100644
--- a/net/unix/unix_bpf.c
+++ b/net/unix/unix_bpf.c
@@ -143,6 +143,8 @@ static void unix_stream_bpf_check_needs_rebuild(struct proto *ops)
 
 int unix_dgram_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 {
+	struct sock *skpair;
+
 	if (sk->sk_type != SOCK_DGRAM)
 		return -EOPNOTSUPP;
 
@@ -152,6 +154,9 @@ int unix_dgram_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool re
 		return 0;
 	}
 
+	skpair = unix_peer(sk);
+	sock_hold(skpair);
+	psock->skpair = skpair;
 	unix_dgram_bpf_check_needs_rebuild(psock->sk_proto);
 	sock_replace_proto(sk, &unix_dgram_bpf_prot);
 	return 0;
@@ -159,12 +164,17 @@ int unix_dgram_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool re
 
 int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 {
+	struct sock *skpair = unix_peer(sk);
+
 	if (restore) {
 		sk->sk_write_space = psock->saved_write_space;
 		sock_replace_proto(sk, psock->sk_proto);
 		return 0;
 	}
 
+	skpair = unix_peer(sk);
+	sock_hold(skpair);
+	psock->skpair = skpair;
 	unix_stream_bpf_check_needs_rebuild(psock->sk_proto);
 	sock_replace_proto(sk, &unix_stream_bpf_prot);
 	return 0;
-- 
2.33.0


