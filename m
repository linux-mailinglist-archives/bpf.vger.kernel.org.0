Return-Path: <bpf+bounces-975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2563970A2EA
	for <lists+bpf@lfdr.de>; Sat, 20 May 2023 00:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A166281C23
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 22:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DADE5678;
	Fri, 19 May 2023 22:52:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329302117
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 22:52:07 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D96E42
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 15:52:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ae408f4d1aso30268415ad.0
        for <bpf@vger.kernel.org>; Fri, 19 May 2023 15:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684536723; x=1687128723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJM8QhKG/f3glJKTGPhCANIBEGsuWrMFo08EisNEWt0=;
        b=Pq0ZLvaUqaaU95+QD9cG/2KQpCgcYwcrW3RLe6sg0lwuYd/T6i8w07EapD2t2YYiC1
         UpNNMXFc8kzkO6wslwxNWAY3c+TcMU3nhPEW7BtztRhd0o4DJjiFWPYUYpWrK7YKotqQ
         QRh7Vo0VhAgEsYj4o+A86WKX22+j3sj1Oaz5qVR3aPCywG5yi8Sf7XZQJE/e6tUKT42f
         P+ppOkwIUNfoH/xqvkypmtNZpOf/3Ai3EwE5r9PZLINQ/5faoUup5b9xzGxEb2m05Czb
         StJUAU7DEYz60DTU3OKZaIWyWLd88ncwuqkgnvNvYeRvAa/G0dhYUOrpG5AMdwEXjRut
         3meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684536723; x=1687128723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJM8QhKG/f3glJKTGPhCANIBEGsuWrMFo08EisNEWt0=;
        b=TCHCwPEyEAHqZ6q4UnO7LgciixhdFfoz+nCqItiiEi0vxJ6KWBYMZOXeWl60a1gkhn
         gmGKq9g9kASChwbZc0DvkZzvZfytWd5etkOaNJ7p6+OCwO2XJmHvW3VpO3AmQj4c9nAi
         xlMt4Vw9nxyHrwSySoeh+00767p1Hf8TkPzXitHaJI2jHcK3I0LTZwJl2NRFje3bMwZM
         RB0R82/gH1Ncr0OTfkr06Q8ts/MYjcie8GE7jq3r13TPoxH/wPcjer4CuvQ4oHQOKA/N
         h16v72nRc7h7Yet+HKxq2C7onlZ+DRAuTuHQFhjq/OFmRwPNJJ/yCNUOCn0fsyR2QqmW
         D6qQ==
X-Gm-Message-State: AC+VfDzplC2GVeBXRHRc38D8Py2L8elkMo8+SXPpFQyjyN75u3ZoBPEC
	QTHd3YLsCcVYnUE/hOXLfuWWqc7RDbScJhr9Dn4=
X-Google-Smtp-Source: ACHHUZ55DXzq5Ju4hRHYP8irkIbCyBaz2OscasQvMSiF6lG4ZKGNmBNBbOzI0Dpc8ixfY709Ei2Q0g==
X-Received: by 2002:a17:902:e889:b0:1aa:e30e:29d3 with SMTP id w9-20020a170902e88900b001aae30e29d3mr5224152plg.29.1684536723568;
        Fri, 19 May 2023 15:52:03 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c08400b001a6ed2d0ef8sm117880pld.273.2023.05.19.15.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 15:52:03 -0700 (PDT)
From: Aditi Ghag <aditi.ghag@isovalent.com>
To: bpf@vger.kernel.org
Cc: kafai@fb.com,
	sdf@google.com,
	aditi.ghag@isovalent.com,
	Yonghong Song <yhs@meta.com>
Subject: [PATCH v9 bpf-next 1/9] bpf: tcp: Avoid taking fast sock lock in iterator
Date: Fri, 19 May 2023 22:51:49 +0000
Message-Id: <20230519225157.760788-2-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519225157.760788-1-aditi.ghag@isovalent.com>
References: <20230519225157.760788-1-aditi.ghag@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a preparatory commit to replace `lock_sock_fast` with
`lock_sock`,and facilitate BPF programs executed from the TCP sockets
iterator to be able to destroy TCP sockets using the bpf_sock_destroy
kfunc (implemented in follow-up commits).

Previously, BPF TCP iterator was acquiring the sock lock with BH
disabled. This led to scenarios where the sockets hash table bucket lock
can be acquired with BH enabled in some path versus disabled in other.
In such situation, kernel issued a warning since it thinks that in the
BH enabled path the same bucket lock *might* be acquired again in the
softirq context (BH disabled), which will lead to a potential dead lock.
Since bpf_sock_destroy also happens in a process context, the potential
deadlock warning is likely a false alarm.

Here is a snippet of annotated stack trace that motivated this change:

```

Possible interrupt unsafe locking scenario:

      CPU0                    CPU1
      ----                    ----
 lock(&h->lhash2[i].lock);
                              local_bh_disable();
                              lock(&h->lhash2[i].lock);
kernel imagined possible scenario:
  local_bh_disable();  /* Possible softirq */
  lock(&h->lhash2[i].lock);
*** Potential Deadlock ***

process context:

lock_acquire+0xcd/0x330
_raw_spin_lock+0x33/0x40
------> Acquire (bucket) lhash2.lock with BH enabled
__inet_hash+0x4b/0x210
inet_csk_listen_start+0xe6/0x100
inet_listen+0x95/0x1d0
__sys_listen+0x69/0xb0
__x64_sys_listen+0x14/0x20
do_syscall_64+0x3c/0x90
entry_SYSCALL_64_after_hwframe+0x72/0xdc


bpf_sock_destroy run from iterator:

lock_acquire+0xcd/0x330
_raw_spin_lock+0x33/0x40
------> Acquire (bucket) lhash2.lock with BH disabled
inet_unhash+0x9a/0x110
tcp_set_state+0x6a/0x210
tcp_abort+0x10d/0x200
bpf_prog_6793c5ca50c43c0d_iter_tcp6_server+0xa4/0xa9
bpf_iter_run_prog+0x1ff/0x340
------> lock_sock_fast that acquires sock lock with BH disabled
bpf_iter_tcp_seq_show+0xca/0x190
bpf_seq_read+0x177/0x450

```

Also, Yonghong reported a deadlock for non-listening TCP sockets that
this change resolves. Previously, `lock_sock_fast` held the sock spin
lock with BH which was again being acquired in `tcp_abort`:

```
watchdog: BUG: soft lockup - CPU#0 stuck for 86s! [test_progs:2331]
RIP: 0010:queued_spin_lock_slowpath+0xd8/0x500
Call Trace:
 <TASK>
 _raw_spin_lock+0x84/0x90
 tcp_abort+0x13c/0x1f0
 bpf_prog_88539c5453a9dd47_iter_tcp6_client+0x82/0x89
 bpf_iter_run_prog+0x1aa/0x2c0
 ? preempt_count_sub+0x1c/0xd0
 ? from_kuid_munged+0x1c8/0x210
 bpf_iter_tcp_seq_show+0x14e/0x1b0
 bpf_seq_read+0x36c/0x6a0


bpf_iter_tcp_seq_show
   lock_sock_fast
     __lock_sock_fast
       spin_lock_bh(&sk->sk_lock.slock);
	/* * Fast path return with bottom halves disabled and * sock::sk_lock.slock held.* */

 ...
 tcp_abort
   local_bh_disable();
   spin_lock(&((sk)->sk_lock.slock)); // from bh_lock_sock(sk)

```

With the switch to `lock_sock`, it calls `spin_unlock_bh` before returning:

```
lock_sock
    lock_sock_nested
       spin_lock_bh(&sk->sk_lock.slock);
       :
       spin_unlock_bh(&sk->sk_lock.slock);
```

Acked-by: Yonghong Song <yhs@meta.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 net/ipv4/tcp_ipv4.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index ea370afa70ed..f2d370a9450f 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2962,7 +2962,6 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
 	struct bpf_iter_meta meta;
 	struct bpf_prog *prog;
 	struct sock *sk = v;
-	bool slow;
 	uid_t uid;
 	int ret;
 
@@ -2970,7 +2969,7 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
 		return 0;
 
 	if (sk_fullsock(sk))
-		slow = lock_sock_fast(sk);
+		lock_sock(sk);
 
 	if (unlikely(sk_unhashed(sk))) {
 		ret = SEQ_SKIP;
@@ -2994,7 +2993,7 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
 
 unlock:
 	if (sk_fullsock(sk))
-		unlock_sock_fast(sk, slow);
+		release_sock(sk);
 	return ret;
 
 }
-- 
2.34.1


