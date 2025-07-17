Return-Path: <bpf+bounces-63671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DCBB09605
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 22:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4745A188BCDA
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 20:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989A4227EA8;
	Thu, 17 Jul 2025 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOQGoVu6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854B61A314E;
	Thu, 17 Jul 2025 20:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752785669; cv=none; b=URIJp/WmevKjg8F0UMxWz2nwCTI3aQg002rKxMOFN5XjSGZJbraZu8AwueEmbKbc4dy25j6EfeM4MEZYdsOHXY5Dk58w5mnu/ooDrs5Hg6SpFlKON+CdL7UhR56NLPZ0ZlwgRE6QW0n2wT/MSCvmw/9bnBkzAn5sK1k5loJ1aVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752785669; c=relaxed/simple;
	bh=JMh9im/KVTS8T/eZE8dQv0wzuTznjpmC3yQL0UwL+NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjUkJaCaf9c+F4F/JbpEgHHxHMvhg9b2oMM2ePZ5Me7tfWUyiGEFad6QSgB5jDN43SMYqzeIcYQT8yCzFDDYS+ZgedzwxbAFswstGKgIkLdzgMW5xskUCHGR0E8geHqMsEzpODOwE456MgvlHbztztnB1YX6kIWcjY7YSXZZOX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOQGoVu6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45611a6a706so7404595e9.1;
        Thu, 17 Jul 2025 13:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752785666; x=1753390466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Mf8QZtzSaPJqQaKbs/oV3ypqLS75pOLlLg3S8LzulY=;
        b=LOQGoVu6zevXZiu4F0tBCsKOCHWe5oHMVEi1WefHWGjyMNN+9ALBkrPgJvXdR07NV7
         5ttUDA25xM/kqJUopaYtxK4zOk7+2CVob4+YfwV1tp1wKSeaLh+CE0DeX2ROmogn9NMO
         cq5o3uwh1/GqUF0pLexbe0YfsHmPV5zvYmPexCkjWcy4LuSmudkD0SLSBFbJv9qn3H+i
         pO177ajIw0i3/Whv5CqZmPdoHb/PjlSFimBO1s9zZLgG8zShODqk15Q8/27IxAy2nkIr
         nKQG9xQVhosdSAk/n12iJBPohefvkeYdncv6NSs2IrXOA8g1PAL6Cjoi3PCoy6BUXC+m
         ouYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752785666; x=1753390466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Mf8QZtzSaPJqQaKbs/oV3ypqLS75pOLlLg3S8LzulY=;
        b=a3jo9+qcj0e7kLHjF5G2js18ybQSNNuN5G7K67VVLXWrUokv8/mLWjLPcq62aHeKR/
         vY3l04imDMaaYdjuq5tPn/8q7xG/cSMGo77Jwal4ZyWQh8X46InaGLhUvHVSrmaMU4x9
         9zVFkUc5tXFQbrUBd7SCtjC7r1WoYV8n0DMuWsf/RJPpWg449w4s1akc+h8+seQjBNgl
         tKvCTih/DwoEQ2xMgAmrtC1fosuX5pOqpNQZnS5XSIP/4CdHCuUovouPU5WkE6jkrFYU
         KGKFG+e+8gV0DK8kF3Yjf8a33ZPEwp2cCdaW9W/ZKhTpxFAj0UyYxGPxEW2qmoCr8dek
         rIqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFfvVjyKnIoHgdcKTEB41zuBhcMLQ30u4b0Dh18ce5LEJw2Kuj1+3N4d9c5jfAhaUlAv4LbnQZJ80LbMgxtK60@vger.kernel.org, AJvYcCVIfyteR39NRLazbu2aq4DYey+zrFacTq5w7cVLONvV90hSGGaMKo9oawAR7stIC8dR4aA=@vger.kernel.org, AJvYcCWlHJOahm/I4HbIcC3dApbR9zJ5KOe1AgL5YXIywO78YyJIiExFzWYpCnIMF0ls3eSUdtJq1wFW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1XvCgRhQeovXv8ViwMuoMt5PDuoTHfkteojW1z6JKw6eBbKNJ
	lckDgEFdLUMUDtxHhAc4kzgjm6Ha8UwRVWfVEJMQ8NQzDmUpPtS1rR+qpS9dTKKapefR/bivEdA
	re+LmI0OfjSNxSQQa7nQFGWxjw5bZd2m4hOXP
X-Gm-Gg: ASbGnctQZSLjD+Is7kS1FDzRplymstfan9yGXhqUIark7cbVs9aag3teFo/ALk20d9I
	29zQDOspVkOSylCvliuWFCFiykiRscIPkkuoJfifZT75MbdEu5oeK25M2Cdjr4wdkn/kZmcXGmH
	93o6RJsmiNSYIQVO2xJc76qaXa2OL/aq/XXNOIVhyrFrfgVISVkEL3IrdcrP3VPgdY8kHtRk/Fc
	+791K1ZMC1+ct+G06zzcWI=
X-Google-Smtp-Source: AGHT+IFejYOPGfvN6gq74fNykVCXRsKFiKKdbWkUeYfFL+bm+BFuxRIXPyIzxTLt1AwuwJt39LYhijbchMqnRGCf2ps=
X-Received: by 2002:a05:600c:35d0:b0:456:76c:84f2 with SMTP id
 5b1f17b1804b1-4562e38b13dmr81825875e9.30.1752785665637; Thu, 17 Jul 2025
 13:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717185837.1073456-1-kuniyu@google.com>
In-Reply-To: <20250717185837.1073456-1-kuniyu@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 17 Jul 2025 13:54:12 -0700
X-Gm-Features: Ac12FXxxz3u6ONU-gfsjoE0AvP3VD49sp2Vu2W8sPaIYSnbNqFj81PisEAFF3AY
Message-ID: <CAADnVQJdn5ERUBfmTHAdfmn0dLozcY6FHsHodNnvfOA40GZYWg@mail.gmail.com>
Subject: Re: [PATCH v1 bpf] bpf: Disable migration in nf_hook_run_bpf().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, netfilter-devel <netfilter-devel@vger.kernel.org>, 
	syzbot+40f772d37250b6d10efc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 11:58=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> syzbot reported that the IP defrag bpf prog can be called without
> migration disabled.
>
> Then the assertion in __bpf_prog_run() fails, triggering the splat
> below. [0]
>
> Let's call migrate_disable() before calling bpf_prog_run() in
> nf_hook_run_bpf().
>
> [0]:
> BUG: assuming non migratable context at ./include/linux/filter.h:703
> in_atomic(): 0, irqs_disabled(): 0, migration_disabled() 0 pid: 5829, nam=
e: sshd-session
> 3 locks held by sshd-session/5829:
>  #0: ffff88807b4e4218 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock includ=
e/net/sock.h:1667 [inline]
>  #0: ffff88807b4e4218 (sk_lock-AF_INET){+.+.}-{0:0}, at: tcp_sendmsg+0x20=
/0x50 net/ipv4/tcp.c:1395
>  #1: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire i=
nclude/linux/rcupdate.h:331 [inline]
>  #1: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock incl=
ude/linux/rcupdate.h:841 [inline]
>  #1: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: __ip_queue_xmit+0x=
69/0x26c0 net/ipv4/ip_output.c:470
>  #2: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire i=
nclude/linux/rcupdate.h:331 [inline]
>  #2: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock incl=
ude/linux/rcupdate.h:841 [inline]
>  #2: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: nf_hook+0xb2/0x680=
 include/linux/netfilter.h:241
> CPU: 0 UID: 0 PID: 5829 Comm: sshd-session Not tainted 6.16.0-rc6-syzkall=
er-00002-g155a3c003e55 #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 05/07/2025
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
>  __cant_migrate kernel/sched/core.c:8860 [inline]
>  __cant_migrate+0x1c7/0x250 kernel/sched/core.c:8834
>  __bpf_prog_run include/linux/filter.h:703 [inline]
>  bpf_prog_run include/linux/filter.h:725 [inline]
>  nf_hook_run_bpf+0x83/0x1e0 net/netfilter/nf_bpf_link.c:20
>  nf_hook_entry_hookfn include/linux/netfilter.h:157 [inline]
>  nf_hook_slow+0xbb/0x200 net/netfilter/core.c:623
>  nf_hook+0x370/0x680 include/linux/netfilter.h:272
>  NF_HOOK_COND include/linux/netfilter.h:305 [inline]
>  ip_output+0x1bc/0x2a0 net/ipv4/ip_output.c:433
>  dst_output include/net/dst.h:459 [inline]
>  ip_local_out net/ipv4/ip_output.c:129 [inline]
>  __ip_queue_xmit+0x1d7d/0x26c0 net/ipv4/ip_output.c:527
>  __tcp_transmit_skb+0x2686/0x3e90 net/ipv4/tcp_output.c:1479
>  tcp_transmit_skb net/ipv4/tcp_output.c:1497 [inline]
>  tcp_write_xmit+0x1274/0x84e0 net/ipv4/tcp_output.c:2838
>  __tcp_push_pending_frames+0xaf/0x390 net/ipv4/tcp_output.c:3021
>  tcp_push+0x225/0x700 net/ipv4/tcp.c:759
>  tcp_sendmsg_locked+0x1870/0x42b0 net/ipv4/tcp.c:1359
>  tcp_sendmsg+0x2e/0x50 net/ipv4/tcp.c:1396
>  inet_sendmsg+0xb9/0x140 net/ipv4/af_inet.c:851
>  sock_sendmsg_nosec net/socket.c:712 [inline]
>  __sock_sendmsg net/socket.c:727 [inline]
>  sock_write_iter+0x4aa/0x5b0 net/socket.c:1131
>  new_sync_write fs/read_write.c:593 [inline]
>  vfs_write+0x6c7/0x1150 fs/read_write.c:686
>  ksys_write+0x1f8/0x250 fs/read_write.c:738
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fe7d365d407
> Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 f=
c 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80=
 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
> RSP:
>
> Fixes: 91721c2d02d3 ("netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG i=
n netfilter link")

Fixes tag looks wrong.
I don't think it's Daniel's defrag series.
No idea why syzbot bisected it to this commit.

This is just a regular xmit path. Not related to defrag.

> Reported-by: syzbot+40f772d37250b6d10efc@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6879466d.a00a0220.3af5df.0022.GAE@goo=
gle.com/
> Tested-by: syzbot+40f772d37250b6d10efc@syzkaller.appspotmail.com
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/netfilter/nf_bpf_link.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
> index 06b0848447003..dffe4cd6f4b0b 100644
> --- a/net/netfilter/nf_bpf_link.c
> +++ b/net/netfilter/nf_bpf_link.c
> @@ -16,8 +16,13 @@ static unsigned int nf_hook_run_bpf(void *bpf_prog, st=
ruct sk_buff *skb,
>                 .state =3D s,
>                 .skb =3D skb,
>         };
> +       unsigned int ret;
>
> -       return bpf_prog_run(prog, &ctx);
> +       migrate_disable();
> +       ret =3D bpf_prog_run(prog, &ctx);
> +       migrate_enable();

The fix looks correct, but we need to root cause it better.
Why did it start now ?
BPF_F_NETFILTER_IP_DEFRAG was there for two years.

