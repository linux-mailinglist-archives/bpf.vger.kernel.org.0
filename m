Return-Path: <bpf+bounces-16056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361BE7FBEB6
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 16:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95AA2820A1
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 15:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2945435298;
	Tue, 28 Nov 2023 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SE8VD5LB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF5FA3;
	Tue, 28 Nov 2023 07:55:19 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6c431b91b2aso4484211b3a.1;
        Tue, 28 Nov 2023 07:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701186919; x=1701791719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GT6mSDV+NdeJ/FpSSchkcdTZdswOexVq0uvo5Kro5z8=;
        b=SE8VD5LBl2aVVI5kWvcdBkCLv5cPO2MOBOA6JFkLZd1f3HruCCmeVCdN3sOZ9w9paP
         3TR2desyb1ycX4OIyF41Y9RwQC5oflwdt8k1YmFf/A4TfHWBgQ+swUtjp9AxqcUfSXXb
         wEjuGaLQsnHL9VmwTqZ0zJMeuvvA+cVMEuVQMeTIWje0ybPbKhqtbrj9Hz/Y21w77kGh
         irnPZcnwU9b2DFxcqlN+bLprlSGEEaZZ7UkZN4N+/2nMYspeDZ8d5v7hHSZQXv/vgruf
         WJBl+KHAxv9k5BepwM16aXWL+Hzxgy/2sWt24h4SrjlC754wQ6rMCWUsUYh+uf++5BRw
         9Jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701186919; x=1701791719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GT6mSDV+NdeJ/FpSSchkcdTZdswOexVq0uvo5Kro5z8=;
        b=eHpAG2DZlnLnALZX5reseFUgjsZjQ+vLrmNlu4ruTEeLiSN7sYWaIhJBgd6M1H2I62
         vFSF7U5ni51c3SxV0DmxFP2d0GUvqpa20p7gyZkH159wonWNi25VXc1IAxu9zmzXnzdz
         Fc5eIMAlDtxFHXT5hzIgJDes1GUe8HPFR/AchTXYYME3EGnmJixGhD5QgG1L0S9fTRiz
         h2ykLDJKjsdTG8eYVX6ZpsvBKnn/1GTfWkphfY/jdETljGWTyw9dj9NLX2EK8LN6t95z
         DNNzYHlqJWxxwurlLSodFLUcOhPK7P107jSdvVeFoSJVBnoTUd0q4b3kzN/jr6jUsTc4
         nZyw==
X-Gm-Message-State: AOJu0YycMvj0tqapOioPflCxRGqiav2WfKI7e+riowAw+KCycwkX1FyI
	+9TD5mnovWQwuWSklwjRVconz6jzfWibXw==
X-Google-Smtp-Source: AGHT+IE6WE951aJVE0XRds52tdVxwZ/58LjU7AvtXXnnY10EhUyxisLVnkGjbw4gDzWFjazdmicG5A==
X-Received: by 2002:a05:6a20:daa7:b0:18b:a2a9:9158 with SMTP id iy39-20020a056a20daa700b0018ba2a99158mr15610135pzb.25.1701186918938;
        Tue, 28 Nov 2023 07:55:18 -0800 (PST)
Received: from john.lan ([2605:59c8:148:ba10:1a40:ebd8:363b:757e])
        by smtp.gmail.com with ESMTPSA id w12-20020aa7858c000000b006cd8c9ae7adsm3695378pfn.25.2023.11.28.07.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 07:55:18 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: martin.lau@kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf v3 1/2] bpf: sockmap, af_unix stream sockets need to hold ref for pair sock
Date: Tue, 28 Nov 2023 07:55:14 -0800
Message-Id: <20231128155515.9302-2-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231128155515.9302-1-john.fastabend@gmail.com>
References: <20231128155515.9302-1-john.fastabend@gmail.com>
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
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
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
index a357dc5f2404..ac1f2bc18fc9 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -213,8 +213,6 @@ static inline bool unix_secdata_eq(struct scm_cookie *scm, struct sk_buff *skb)
 }
 #endif /* CONFIG_SECURITY_NETWORK */
 
-#define unix_peer(sk) (unix_sk(sk)->peer)
-
 static inline int unix_our_peer(struct sock *sk, struct sock *osk)
 {
 	return unix_peer(osk) == sk;
diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
index 2f9d8271c6ec..074ab91485f1 100644
--- a/net/unix/unix_bpf.c
+++ b/net/unix/unix_bpf.c
@@ -159,12 +159,17 @@ int unix_dgram_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool re
 
 int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 {
+	struct sock *skpair;
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


