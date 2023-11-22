Return-Path: <bpf+bounces-15700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8C97F5081
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 20:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C213B20DD4
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 19:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5789A5E0C4;
	Wed, 22 Nov 2023 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2niTGx6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD3D100;
	Wed, 22 Nov 2023 11:24:57 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cbc8199a2aso156622b3a.1;
        Wed, 22 Nov 2023 11:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700681097; x=1701285897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7pld5hq8qQ3ubCW9Fgj8sawBzjweVKc0+vs2ZD20iQ=;
        b=k2niTGx6zftziBB4z35VcGT4uXVfcK+51LXid6G6pyH5YQqtZgJ68mWmUrt8z9tV/9
         qpB60EEy4URwjTHXWjGBQ6ersGnn5AfqykclKFQ2V17ovSPtZAX0hlEiNm7nOBd57QvT
         228m2kOYqMT1Xr+PhSIIDTJowjbjc5ZLygq9E88eKWLBvBaRLDI2XhVkCUi6x5EyrrYZ
         f61+Mn95duKneR2U8svD4UPq5/nv/VMI2OOeouiQAkMjXS8HHNc/lq9iqwMQNW9tZiMC
         N6YoZLmhdvlMTPkY3yds2+zjnPkwrPyDNAT4Bn+fmCzRy5hcSzVVd7tdEhmYuo3lIogg
         1F3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700681097; x=1701285897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7pld5hq8qQ3ubCW9Fgj8sawBzjweVKc0+vs2ZD20iQ=;
        b=R8SAPCbL5Sn9LgSGViW3jFpVguoaIS7yKyul0x9pSoChxZ8RE/skTFvTTO2fFSxbo/
         pz3CWb0N1t3WcXHhHDuP/uJoYZotE6vfPZjKvTvmYH+vUWPjapMlmYnZzw96kp97lobC
         Nf5hsUh9ZzPkhJpHebu9DPtkRwnnm40bdnsfbLK+Na7AiOoHv84XTyF/qWxeUjBp7gVh
         fLkVTjWCVG5pjoeAUSfDDfUfeD4Uklu1FP9JySgQ5f/926rvcL5w6I9ak5qLK72hGtxY
         /1wWPUOPFfIgztVsbM+AGe0kfDrlENAwsO/25S4WrTYC220EOncNoZL8qBdE+k4d2ATp
         pNQQ==
X-Gm-Message-State: AOJu0YxvonYxhViCnUNP6uT19FPI12Hqu+gkrCMply/xXHtBe0IXkDTa
	H9LZpEtaRC906AigY+zyqwo=
X-Google-Smtp-Source: AGHT+IHtqEfnDZQVvrcpmFdzf2IK1vw7nQADpUNrR8IKjamakgrHNAcvlj0Qf+G5SQZnbTBRrwXX/Q==
X-Received: by 2002:a05:6a20:1590:b0:18b:27ec:fbe5 with SMTP id h16-20020a056a20159000b0018b27ecfbe5mr3547021pzj.10.1700681097046;
        Wed, 22 Nov 2023 11:24:57 -0800 (PST)
Received: from john.lan ([98.97.116.126])
        by smtp.gmail.com with ESMTPSA id r7-20020a056a00216700b006c052bb7da5sm89240pff.7.2023.11.22.11.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 11:24:55 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: martin.lau@kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf v2 1/2] bpf: sockmap, af_unix stream sockets need to hold ref for pair sock
Date: Wed, 22 Nov 2023 11:24:51 -0800
Message-Id: <20231122192452.335312-2-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231122192452.335312-1-john.fastabend@gmail.com>
References: <20231122192452.335312-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_UNIX stream sockets are a paired socket. So sending on one of the pairs
will lookup the paired socket as part of the send operation. It is possible
however to put just one of the pairs in a BPF map. This currently
increments the refcnt on the sock in the sockmap to ensure it is not
free'd by the stack before sockmap cleans up its state and stops any
skbs being sent/recv'd to that socket.

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

Notice dgram sockets are OK because they handle locking already.

Fixes: 94531cfcbe79 ("af_unix: Add unix_stream_proto for sockmap")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 include/linux/skmsg.h | 1 +
 include/net/af_unix.h | 1 +
 net/core/skmsg.c      | 2 ++
 net/unix/af_unix.c    | 2 --
 net/unix/unix_bpf.c   | 5 +++++
 5 files changed, 9 insertions(+), 2 deletions(-)

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
index 2f9d8271c6ec..7e7791029198 100644
--- a/net/unix/unix_bpf.c
+++ b/net/unix/unix_bpf.c
@@ -159,12 +159,17 @@ int unix_dgram_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool re
 
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


