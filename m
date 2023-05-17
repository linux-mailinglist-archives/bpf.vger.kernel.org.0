Return-Path: <bpf+bounces-804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D5A70700E
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 19:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC601C20E78
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 17:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062C131EF0;
	Wed, 17 May 2023 17:55:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C9E10966
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 17:55:17 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07C71A7
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:55:15 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ae52ce3250so9350755ad.2
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684346115; x=1686938115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8WvC9+CwsWYyMunEtQcJi3ps8MGLdx6dieRQPHo9XmA=;
        b=MQPO2PvezUKh7aSM92mvjfiA0iynR2J3NJ4Zm8Dbc9ep6jjJU8RGx72Ls1HXfNuymg
         JO/8nRHev3smf7wMSOvo6Sn/owXLwpecR61ur+6Ty+RQfnsbZwAeR4lDrc3Drb1UTbfY
         7YXbpXJ+uJYGZC0vH8HODKHYzGYXW7OlCsuWICB0RJLvR/ZYj2VgCDBrpNpOaGYI2v4h
         mXrB8sPsHxtTiwvaaWBmVEpwKr8K+1VqTl3XzHyJ1XJR83LgzNY6VJ22DqTxjWy97EcF
         GMOTckgCOEOcpYOMBbS8iZb7D09SJCr/pNaQdYJSn6vpVCmcnCeDnrlf8mJsvblRY+be
         kUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684346115; x=1686938115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WvC9+CwsWYyMunEtQcJi3ps8MGLdx6dieRQPHo9XmA=;
        b=AM3b20ns9VNYo5vIJZ73escBG8dVCQh/ns/ujWtmJyL0ru6Krw7KNfGFILhtCQ3Tou
         moD/tSLK+lzPkhaCmKyhm3jCTJNFTB63XXse6Z8ykY7PDNpfkw7+t5VOnZ3G/L/93M/j
         /FaDf6bPA6aljT0BjhTLq4FN3iVk6sA9+Ou6gY9tGIfEdYVGsZZh4fAtSnM7Z0WAQKbT
         P1Uc/87LgkEfZWGvN9yHEXBNYJRq6jii0YXClw5W0GRz2IQB+XwlsRBqs1LVum+Qzxvy
         jllwdfI2CWJK6zdk7JKWL6zcgtpe9fy2u7bZ9suTETr0sQWJpmKaM/o/s1SJf6yNv1hp
         A4mQ==
X-Gm-Message-State: AC+VfDwH8gCNxq13QMOobYs4f1P/Bw0vReSU7LwXBz6knhZ+OsaIMu0W
	vSKSeJvGvTfZeT3tkiaSDMuiWUqLVgn35r0wU+4=
X-Google-Smtp-Source: ACHHUZ7JF85/bthysegngN2uB62u0BLnePIsFBQsLzPOzWadnC9S6cGhEF/0tW6ktJnZeNESugTArw==
X-Received: by 2002:a17:902:d507:b0:1ac:310d:872d with SMTP id b7-20020a170902d50700b001ac310d872dmr54785365plg.52.1684346114852;
        Wed, 17 May 2023 10:55:14 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id b17-20020a170903229100b001ab39cd885esm17828882plh.212.2023.05.17.10.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:55:14 -0700 (PDT)
From: Aditi Ghag <aditi.ghag@isovalent.com>
To: bpf@vger.kernel.org
Cc: kafai@fb.com,
	sdf@google.com,
	yhs@meta.com,
	aditi.ghag@isovalent.com
Subject: [PATCH v8 bpf-next 01/10] bpf: tcp: Avoid taking fast sock lock in iterator
Date: Wed, 17 May 2023 17:54:58 +0000
Message-Id: <20230517175458.527970-1-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
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
`lock_sock`, and faciliate BPF programs executed from the iterator to be
able to destroy TCP listening sockets using the bpf_sock_destroy kfunc
(implemened in follow-up commits).  Previously, BPF TCP iterator was
acquiring the sock lock with BH disabled. This led to scenarios where
the sockets hash table bucket lock can be acquired with BH enabled in
some context versus disabled in other, and  caused a
<softirq-safe> -> <softirq-unsafe> dependency with the sock lock.

Here is a snippet of annotated stack trace that motivated this change:

```

Possible interrupt unsafe locking scenario:

      CPU0                    CPU1
      ----                    ----
 lock(&h->lhash2[i].lock);
                              local_irq_disable();
                              lock(slock-AF_INET6);
                              lock(&h->lhash2[i].lock);
 <Interrupt>
   lock(slock-AF_INET6);
*** DEADLOCK ***

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


bpf_sock_destroy run from iterator in interrupt context:

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


