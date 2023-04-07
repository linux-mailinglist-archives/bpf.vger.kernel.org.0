Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797816DB15E
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 19:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjDGRRC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Apr 2023 13:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjDGRRB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Apr 2023 13:17:01 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EDEAD25;
        Fri,  7 Apr 2023 10:16:59 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso43825774pjb.2;
        Fri, 07 Apr 2023 10:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680887819; x=1683479819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huaGQx94IhqjlpBZz9Dh/6dEAcqnZNQFnDotU/ZG3V0=;
        b=XItwcjN9tY7uXMhZq42v0dHybrXAkwdjVBLeBo+RApOoKVBei1vH+gniS+juRanM68
         dOsm/dhf1qw2Yg1BuhddvhVFLt95QN1LzS+OYnRBhma8pjVI7Y3Pj0BC53M/J/RQ2HVO
         +vMSV0aignwE8k3OddqzVQHqIxyw9K959caSvl4rdC4vqL0KOCuTqdUp3fvrTjNJ78H0
         z/BdfkSPcqDwGAMM0TeQBK42+uSRBvKcSeyBQ35eT5p4JGxZLwa87Q5fmwq/EdERHdii
         +81Djn4/nb60Qs7eaEij0Tqaw4Y1/qBqQfOVvRPWKCY0wt0FlvWiiWqE7bfEuq2RagCv
         ft7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680887819; x=1683479819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huaGQx94IhqjlpBZz9Dh/6dEAcqnZNQFnDotU/ZG3V0=;
        b=IQRvP3yHcWpUvqIu/Or0mb3zCN0makpJ2WfoAG7yi8lueGAAvcBg671b8G+IuIpsYU
         fet84YoTNwTM6g4YZWzboCe8iUN63B6+PAZSzPhfj2JtODN4V/MfMNLhy5HHfwZqmUIq
         0mj81WMG+ngpUe0Dw3OPXI/tvDWWcEwgK/se9ha2KwQAECIGb9BCMH6GkyUfnixHhzri
         JuuG14Qav4yx7qtBgfxaaIWNfk2FqjpCwBsYijZHa6Yos5oG3rWIvaL1d6UiIdLhtXU2
         88iWHZOprUw3RIWJGvSUQ7I6zFuYYQaK3yMtHJeHJroi/LHu9o9BAPce/2fUnNeH+d+3
         CnvQ==
X-Gm-Message-State: AAQBX9cvb3Hxj7hrU3xUf3y7/3xZR0f0Uvf+Dkpqcj43gM9nNu97xliC
        qVQoGYEsnQ0LIWMxrBSUqGE=
X-Google-Smtp-Source: AKy350ZsA6qp+WrZkiTsKy+NILwpRmbvQhfK1QdPSBZjrGnvkcvc7s8jHLGWBUfLKzwlOxcSdz5RDg==
X-Received: by 2002:a17:902:d486:b0:1a1:9020:f9d5 with SMTP id c6-20020a170902d48600b001a19020f9d5mr3797034plg.64.1680887819197;
        Fri, 07 Apr 2023 10:16:59 -0700 (PDT)
Received: from john.lan ([98.97.116.126])
        by smtp.gmail.com with ESMTPSA id p1-20020a1709028a8100b0019b0937003esm3185425plo.150.2023.04.07.10.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:16:58 -0700 (PDT)
From:   John Fastabend <john.fastabend@gmail.com>
To:     jakub@cloudflare.com, daniel@iogearbox.net, lmb@isovalent.com,
        edumazet@google.com
Cc:     john.fastabend@gmail.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        will@isovalent.com
Subject: [PATCH bpf v6 01/12] bpf: sockmap, pass skb ownership through read_skb
Date:   Fri,  7 Apr 2023 10:16:43 -0700
Message-Id: <20230407171654.107311-2-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230407171654.107311-1-john.fastabend@gmail.com>
References: <20230407171654.107311-1-john.fastabend@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The read_skb hook calls consume_skb() now, but this means that if the
recv_actor program wants to use the skb it needs to inc the ref cnt
so that the consume_skb() doesn't kfree the sk_buff.

This is problematic because in some error cases under memory pressure
we may need to linearize the sk_buff from sk_psock_skb_ingress_enqueue().
Then we get this,

 skb_linearize()
   __pskb_pull_tail()
     pskb_expand_head()
       BUG_ON(skb_shared(skb))

Because we incremented users refcnt from sk_psock_verdict_recv() we
hit the bug on with refcnt > 1 and trip it.

To fix lets simply pass ownership of the sk_buff through the skb_read
call. Then we can drop the consume from read_skb handlers and assume
the verdict recv does any required kfree.

Bug found while testing in our CI which runs in VMs that hit memory
constraints rather regularly. William tested TCP read_skb handlers.

[  106.536188] ------------[ cut here ]------------
[  106.536197] kernel BUG at net/core/skbuff.c:1693!
[  106.536479] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[  106.536726] CPU: 3 PID: 1495 Comm: curl Not tainted 5.19.0-rc5 #1
[  106.537023] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ArchLinux 1.16.0-1 04/01/2014
[  106.537467] RIP: 0010:pskb_expand_head+0x269/0x330
[  106.538585] RSP: 0018:ffffc90000138b68 EFLAGS: 00010202
[  106.538839] RAX: 000000000000003f RBX: ffff8881048940e8 RCX: 0000000000000a20
[  106.539186] RDX: 0000000000000002 RSI: 0000000000000000 RDI: ffff8881048940e8
[  106.539529] RBP: ffffc90000138be8 R08: 00000000e161fd1a R09: 0000000000000000
[  106.539877] R10: 0000000000000018 R11: 0000000000000000 R12: ffff8881048940e8
[  106.540222] R13: 0000000000000003 R14: 0000000000000000 R15: ffff8881048940e8
[  106.540568] FS:  00007f277dde9f00(0000) GS:ffff88813bd80000(0000) knlGS:0000000000000000
[  106.540954] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  106.541227] CR2: 00007f277eeede64 CR3: 000000000ad3e000 CR4: 00000000000006e0
[  106.541569] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  106.541915] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  106.542255] Call Trace:
[  106.542383]  <IRQ>
[  106.542487]  __pskb_pull_tail+0x4b/0x3e0
[  106.542681]  skb_ensure_writable+0x85/0xa0
[  106.542882]  sk_skb_pull_data+0x18/0x20
[  106.543084]  bpf_prog_b517a65a242018b0_bpf_skskb_http_verdict+0x3a9/0x4aa9
[  106.543536]  ? migrate_disable+0x66/0x80
[  106.543871]  sk_psock_verdict_recv+0xe2/0x310
[  106.544258]  ? sk_psock_write_space+0x1f0/0x1f0
[  106.544561]  tcp_read_skb+0x7b/0x120
[  106.544740]  tcp_data_queue+0x904/0xee0
[  106.544931]  tcp_rcv_established+0x212/0x7c0
[  106.545142]  tcp_v4_do_rcv+0x174/0x2a0
[  106.545326]  tcp_v4_rcv+0xe70/0xf60
[  106.545500]  ip_protocol_deliver_rcu+0x48/0x290
[  106.545744]  ip_local_deliver_finish+0xa7/0x150

Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
Reported-by: William Findlay <will@isovalent.com>
Tested-by: William Findlay <will@isovalent.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 net/core/skmsg.c   | 2 --
 net/ipv4/tcp.c     | 1 -
 net/ipv4/udp.c     | 7 ++-----
 net/unix/af_unix.c | 7 ++-----
 4 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index f81883759d38..4a3dc8d27295 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1183,8 +1183,6 @@ static int sk_psock_verdict_recv(struct sock *sk, struct sk_buff *skb)
 	int ret = __SK_DROP;
 	int len = skb->len;
 
-	skb_get(skb);
-
 	rcu_read_lock();
 	psock = sk_psock(sk);
 	if (unlikely(!psock)) {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 288693981b00..1be305e3d3c7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1770,7 +1770,6 @@ int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
 		tcp_flags = TCP_SKB_CB(skb)->tcp_flags;
 		used = recv_actor(sk, skb);
-		consume_skb(skb);
 		if (used < 0) {
 			if (!copied)
 				copied = used;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c605d171eb2d..8aaae82e78ae 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1813,7 +1813,7 @@ EXPORT_SYMBOL(__skb_recv_udp);
 int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
 	struct sk_buff *skb;
-	int err, copied;
+	int err;
 
 try_again:
 	skb = skb_recv_udp(sk, MSG_DONTWAIT, &err);
@@ -1832,10 +1832,7 @@ int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	}
 
 	WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
-	copied = recv_actor(sk, skb);
-	kfree_skb(skb);
-
-	return copied;
+	return recv_actor(sk, skb);
 }
 EXPORT_SYMBOL(udp_read_skb);
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 0b0f18ecce44..bb34852bf947 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2553,7 +2553,7 @@ static int unix_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
 	struct unix_sock *u = unix_sk(sk);
 	struct sk_buff *skb;
-	int err, copied;
+	int err;
 
 	mutex_lock(&u->iolock);
 	skb = skb_recv_datagram(sk, MSG_DONTWAIT, &err);
@@ -2561,10 +2561,7 @@ static int unix_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	if (!skb)
 		return err;
 
-	copied = recv_actor(sk, skb);
-	kfree_skb(skb);
-
-	return copied;
+	return recv_actor(sk, skb);
 }
 
 /*
-- 
2.33.0

