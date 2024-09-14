Return-Path: <bpf+bounces-39910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D27979301
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 20:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0871C2074D
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 18:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE941D222F;
	Sat, 14 Sep 2024 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fA18uvwv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437941D094C
	for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726339592; cv=none; b=UjARfDGKC8TI7u7Hi7v/HW7sZhiWim4XvebEEoXiGi1WgQPl62mBC18uS1QIMmFIkcINogIPf4Wnxg1e5ZJNpMcIAdicQnVTMBuRlzWg5zkkwRqrp1HYWp16o1BcG9Rg6xYTME9eJjFzN7aK9dZnE0MXEGkQaE9/Ez3rw8ni7pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726339592; c=relaxed/simple;
	bh=3TrYZmah0tVKjvlUyufFLlqbwVLn2rqABbtR8U/v3K4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uREtrgKOYFdhKdBkij/N8QN/bf72VeuU3ZWu+cBwsz5ym5SBvw9g69KuGzYJ3so5wuf+YFaPp2yzNg5WikUj18zatZW4noq7IVrQE07tG9ltRAdmchQ9fUSHtauQZP5J6h9qV2IbVI9YPNgKXKiLdZfDf7lTE6Gu2xOh1hyIEJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fA18uvwv; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7163489149fso4570231a12.3
        for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 11:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726339589; x=1726944389; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4pwxOtdBqPNpG3ycs4skY+O3QKM4phnpDkbqjbyYSMQ=;
        b=fA18uvwvFXmQA8HC58uZpWOnRhDzrYpRVeI32gqTToquUhDYGACLhahTj321qdHj6t
         vBmM+ufR8RnsFyxfHGDPuVlpP1AaESJKlliP6HGoa4gIb4WswhRWgSW8qRnv4AEYR5qK
         BSSBq1p0aXeBlIonoFozlQ4mP1omw6zR5FA/1d8gU9Aoe3SOpiuAtBcTmu9AWFbRcRWo
         rt5agrF3iCB24hViJyXGsFllwFtRZ0Zl+Auv6EGNAoJqrQp7vh2TGsVB3Qn3SlLmFurw
         k0LGMWco0B1ZSgmPrYenmjMJGktlOS9VygZDm1zbth0vIApdzLo025MNptf1bK2vd0b5
         x+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726339589; x=1726944389;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4pwxOtdBqPNpG3ycs4skY+O3QKM4phnpDkbqjbyYSMQ=;
        b=sNEOJHr3zXVxhLQwBK48Qhg7tESDpKxl6Ry09vfbkXNNoFOYZCyjWQfCxL/a/19CTe
         7Bg+/hNe/RY+9rAMtLb057FNRUxLWE2tT61DnbQA+DLYXpO3MphBt4P5TV+pWuhUs6Ds
         k4nF+sE93GAoio4Ya5Zndu30tGd6A+0fxIvDFXrg3y9PEyQgFv1J2eq5Gj6tNHmt44NV
         nD82uSPF+TNKByu4/AnZsP/myqVM8HPxsc+RqthswKESjC/DVniUS02UrxclE7QzaTm1
         U6ddWCkALIorjnSEGkShQrR0y3CwLRJJQVAoE+9Uvxx/Nudb65NX2Q7vXBMhRIJaqGjl
         pc8g==
X-Forwarded-Encrypted: i=1; AJvYcCVQh5nujmIgUQRvqqf9kOmF21oLg5WZYBB6awIubqdb0Mag90nHqf+8PHIjMLSy0e8yEnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi67V/hhHxhI1a5Jn+SNrdrAWpuYgSVYloQO2IooZBMwArUBO8
	dGxzg65YJiV86XENG2IRMAKP7ttFi869P9Lmrq9wbMJ3YIV6iNphfP0HoalUE+uXxi1dD99deA=
	=
X-Google-Smtp-Source: AGHT+IGnH57+W2+X+BBOfkHlZCjThkeqQccuVRG5rt9hJj6St8tpjhNLCddTVRg7vyg7OiPeQzTwrPJa0w==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:a17:90a:9283:b0:2d8:92c9:70d with SMTP id
 98e67ed59e1d1-2dba0014c07mr21163a91.5.1726339589291; Sat, 14 Sep 2024
 11:46:29 -0700 (PDT)
Date: Sat, 14 Sep 2024 18:46:12 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240914184616.2916445-1-jrife@google.com>
Subject: [PATCH net] netkit: Ensure current->bpf_net_context is set in netkit_xmit()
From: Jordan Rife <jrife@google.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When operating Cilium in netkit mode with BPF-based host routing, calls
to bpf_redirect() cause a kernel panic.

[   52.247646] BUG: kernel NULL pointer dereference, address: 0000000000000038
...
[   52.247727] RIP: 0010:bpf_redirect+0x18/0x80
...
[   52.247986] Call Trace:
[   52.247990]  <TASK>
[   52.248002]  ? show_regs+0x6c/0x80
[   52.248024]  ? __die+0x24/0x80
[   52.248029]  ? page_fault_oops+0x155/0x570
[   52.248047]  ? fib_rules_lookup+0x112/0x270
[   52.248056]  ? do_user_addr_fault+0x4b2/0x870
[   52.248063]  ? exc_page_fault+0x82/0x1b0
[   52.248090]  ? asm_exc_page_fault+0x27/0x30
[   52.248103]  ? bpf_redirect+0x18/0x80
[   52.248109]  bpf_prog_f0698aabaf44c832_tail_handle_ipv4+0x173f/0x2707
[   52.248119]  ? sbitmap_find_bit+0xe3/0x270
[   52.248129]  netkit_xmit+0x177/0x3c0
[   52.248139]  dev_hard_start_xmit+0x62/0x1d0
[   52.248149]  __dev_queue_xmit+0x241/0xf30
[   52.248155]  ? alloc_skb_with_frags+0x60/0x280
[   52.248164]  ? __check_object_size+0x2a2/0x310
[   52.248173]  ? ip_generic_getfrag+0x63/0x110
[   52.248181]  ip_finish_output2+0x2cf/0x560
[   52.248187]  __ip_finish_output+0xb6/0x180
[   52.248193]  ip_finish_output+0x29/0x120
[   52.248198]  ip_output+0x5f/0x100
[   52.248204]  ? __pfx_ip_finish_output+0x10/0x10
[   52.248210]  ip_send_skb+0x98/0xb0
[   52.248215]  udp_send_skb+0x146/0x370

Setting a breakpoint inside bpf_net_ctx_get_ri() confirms that
current->bpf_net_context is NULL right before the panic.

(gdb) p $lx_current().bpf_net_context
$4 = (struct bpf_net_context *) 0x0 <fixed_percpu_data>
(gdb) disassemble bpf_redirect
Dump of assembler code for function bpf_redirect:
   0xffffffff81f085e0 <+0>:	nopl   0x0(%rax,%rax,1)
   0xffffffff81f085e5 <+5>:	mov    %gs:0x7e12d593(%rip),%rax
   0xffffffff81f085ed <+13>:	push   %rbp
   0xffffffff81f085ee <+14>:	mov    0x23d0(%rax),%rax
=> 0xffffffff81f085f5 <+21>:	mov    %rsp,%rbp
   0xffffffff81f085f8 <+24>:	mov    0x38(%rax),%edx
...
(gdb) continue
Continuing.

Thread 1 hit Breakpoint 1, panic ...
288	{
(gdb)

commit 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct
on PREEMPT_RT.") recently moved bpf_redirect_info into bpf_net_context,
a new member of task_struct. Currently, current->bpf_net_context is set
and then cleared inside sch_handle_egress() where tcx_run() and tc_run()
execute, but it looks like netkit_xmit() was missed leaving
current->bpf_net_context uninitialized when it runs. This patch ensures
that current->bpf_net_context is initialized while running
netkit_xmit().

Signed-off-by: Jordan Rife <jrife@google.com>
Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
Cc: stable@vger.kernel.org
---
 drivers/net/netkit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index d0036a856039..92ac0cb5a327 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -65,6 +65,7 @@ static struct netkit *netkit_priv(const struct net_device *dev)
 
 static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct netkit *nk = netkit_priv(dev);
 	enum netkit_action ret = READ_ONCE(nk->policy);
 	netdev_tx_t ret_dev = NET_XMIT_SUCCESS;
@@ -73,6 +74,7 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
 	int len = skb->len;
 
 	rcu_read_lock();
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 	peer = rcu_dereference(nk->peer);
 	if (unlikely(!peer || !(peer->flags & IFF_UP) ||
 		     !pskb_may_pull(skb, ETH_HLEN) ||
@@ -109,6 +111,7 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
 		ret_dev = NET_XMIT_DROP;
 		break;
 	}
+	bpf_net_ctx_clear(bpf_net_ctx);
 	rcu_read_unlock();
 	return ret_dev;
 }
-- 
2.46.0.662.g92d0881bb0-goog


