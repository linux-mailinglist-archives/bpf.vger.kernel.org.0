Return-Path: <bpf+bounces-31496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864DA8FE6CA
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 14:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48E8287957
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 12:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963FC195B2E;
	Thu,  6 Jun 2024 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKDAigZF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2ED4DA14;
	Thu,  6 Jun 2024 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717678049; cv=none; b=gt1G+Ejt+2fkljo9PjWgz+7fuyCsL8FWcnGC9H806JiG6Zo5dwOECkibJx+7K4eELQmKs/UKNVHt3yEBl18ouAdMbJEfATB/QD21DuE5Sc6yYVK9gc85Np2sc4xD3S3O/oeNB5j/qnd54mYWkjIsm/bC8iyv2VZOjy2SG9/UtFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717678049; c=relaxed/simple;
	bh=fSk/ljlzHn1foPsH+rrjOpGgLZG7oGfhsN6GWAdnAQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rI1iX8UIBKxBc+wIP9GflI+tWlxZ75YCs++OwR49AgnqBSTuwIgjAlpzW6Gxv4h9qrIrHOxbJx+2w1WMaQMa4vhVRlH5sjHWXdQwwORFTGxW+l0jbfmQasUZ70kh/d7MTiI8iwWQBGUMl9X+9PxJzlvh4tkKBCv+p6qeX3lBzxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKDAigZF; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52b8e0e98adso1396572e87.0;
        Thu, 06 Jun 2024 05:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717678045; x=1718282845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hlmSScBkyOgE/ClUMUHzvXRvwtKju8trRrqct5BWMw=;
        b=UKDAigZFV4rlfifefli0x75Dcl+JMy4h+pgX3PwBEouZKAlyYRMNUAlwXgg2EhNrhp
         /eD4RYw/T+UXS0ZFvpam7Tv10Usfj9G+PsTwxEJaXp+mgt91myz4/rp6K67pHH//1GN1
         Era50WSxn4CY3o/U/q4qCA632s8MBCQq7ad5kQS/vQoK+sHvgsjaDpsh3Fu3kEWBs+E5
         YK6OV6x19Y79sTiO70VFh3oGtgX3xFVvPZGkkz4HoXyLqXXgCrobM4nxYYBl4kvjWBfq
         YT30AFNV5MPxsM2hAOUl966yfNGncY/IuJHd9ju+oHwV8UdEXz8bkAEYnKM/EAIqn1KZ
         Bw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717678045; x=1718282845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hlmSScBkyOgE/ClUMUHzvXRvwtKju8trRrqct5BWMw=;
        b=Ns+5I/oBvINoCqJXJ9yVGUw9EngVb7hQSVdHijK0fQSBeyiqLfpHQwXCJcjmt45d8K
         ow5sE4eFk35zeBHW3V5aT65hKsKevqJ1YVMfHSL+t5Wo4lc8SFdQ/9lwv7UMd/pInUs3
         olxIbUCdvwWiVgbKcPdX/HwyQiEPF7L+WtRR1/3AYbcRcwSeV4jJ16EgBby969v84A8l
         GbTNYhKcbF31AMT/mjD0PSeYbeAfeqeu1ZPmVFUq7klTaqstdf0e3oXWph6KqPbOyIU/
         t8tWMwmlnuSpve3qHCooqAaz7hWNNv46FzVpB+XKuvP0Ik31xfyn1tXjSBvGvdshVeif
         5iaw==
X-Forwarded-Encrypted: i=1; AJvYcCW4jciRnDQq1FqH9/Mak1UuBNvMr7vEnb+9iEqcWdGkwuG/JKw+dO4M9fh/5kn0k9zXg7wza14ySH1EZ8DJi9sqIbhAIXJCKUf7UBPNuU+/XQCUWdjcW9LshMQ/
X-Gm-Message-State: AOJu0Ywe3nhJ4cuE+e4YxHhulKSCATfuvAdi6G8JbjIsUYVO+Kwr2vOm
	p9Hzeey3nSoMPjQWHNGTHnJzZbtO/FjJsQhxEXwCsoDPS/KBrUVSLeOeLmdHl67yPqY2CA5rOSD
	tjvJJNsGL9ZuZSxsAlp3ivConCmk=
X-Google-Smtp-Source: AGHT+IHLrP3iPF3jF5KbodPvanLJEtKVj3VEmCHbG8rUnFuAmmkg/bO1WBde1k3nn8TEiGStt3CiNlm0nB5trzSFyjw=
X-Received: by 2002:a05:6512:1110:b0:51e:f7de:d8eb with SMTP id
 2adb3069b0e04-52bab4c8e1bmr3980181e87.10.1717678044791; Thu, 06 Jun 2024
 05:47:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALye=_-HrFUF_Eq7SfpWZQUvBOVHx0rmsT2-O6TWgyMF-GFQ8w@mail.gmail.com>
In-Reply-To: <CALye=_-HrFUF_Eq7SfpWZQUvBOVHx0rmsT2-O6TWgyMF-GFQ8w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Jun 2024 20:46:47 +0800
Message-ID: <CAL+tcoBByAuBj-3XK2QL5Hir_xyfKt5AFzYkjb41mreVdS2=7Q@mail.gmail.com>
Subject: Re: Recursive locking in sockmap
To: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jason Xing <kernelxing@tencent.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Vincent,

On Thu, Jun 6, 2024 at 6:00=E2=80=AFPM Vincent Whitchurch
<vincent.whitchurch@datadoghq.com> wrote:
>
> With a socket in the sockmap, if there's a parser callback installed
> and the verdict callback returns SK_PASS, the kernel deadlocks
> immediately after the verdict callback is run. This started at commit
> 6648e613226e18897231ab5e42ffc29e63fa3365 ("bpf, skmsg: Fix NULL
> pointer dereference in sk_psock_skb_ingress_enqueue").
>
> It can be reproduced by running ./test_sockmap -t ping
> --txmsg_pass_skb.  The --txmsg_pass_skb command to test_sockmap is
> available in this series:
> https://lore.kernel.org/netdev/20240606-sockmap-splice-v1-0-4820a2ab14b5@=
datadoghq.com/.

Thanks for your report.

I don't have time right now to look into this issue carefully until
this weekend. BTW, did you mean the patch [2/5] in the link that can
solve the problem?

Thanks,
Jason

>
> Lockdep splat below (also attached in case it gets damaged). This is
> from an unmodified 6.10.0-rc2, but the problem also exists on latest
> mainline and net-next.
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  WARNING: possible recursive locking detected
>  6.10.0-rc2 #59 Not tainted
>  --------------------------------------------
>  test_sockmap/342 is trying to acquire lock:
>  ffff888007a87228 (clock-AF_INET){++--}-{2:2}, at:
> sk_psock_skb_ingress_enqueue (./include/linux/skmsg.h:467
> net/core/skmsg.c:555)
>
>  but task is already holding lock:
>  ffff888007a87228 (clock-AF_INET){++--}-{2:2}, at:
> sk_psock_strp_data_ready (net/core/skmsg.c:1120)
>
>  other info that might help us debug this:
>   Possible unsafe locking scenario:
>
>         CPU0
>         ----
>    lock(clock-AF_INET);
>    lock(clock-AF_INET);
>
>   *** DEADLOCK ***
>
>   May be due to missing lock nesting notation
>
>  9 locks held by test_sockmap/342:
>  #0: ffff888007a85818 (sk_lock-AF_INET){+.+.}-{0:0}, at: tcp_sendmsg
> (net/ipv4/tcp.c:1348)
>  #1: ffffffffb8849c00 (rcu_read_lock){....}-{1:2}, at: __ip_queue_xmit
> (./include/linux/rcupdate.h:329 ./include/linux/rcupdate.h:781
> net/ipv4/ip_output.c:470)
>  #2: ffffffffb8849c00 (rcu_read_lock){....}-{1:2}, at:
> ip_finish_output2 (./include/linux/rcupdate.h:329
> ./include/linux/rcupdate.h:781 net/ipv4/ip_output.c:228)
>  #3: ffffffffb8849c00 (rcu_read_lock){....}-{1:2}, at: process_backlog
> (./include/linux/rcupdate.h:329 ./include/linux/rcupdate.h:781
> net/core/dev.c:6066)
>  #4: ffffffffb8849c00 (rcu_read_lock){....}-{1:2}, at:
> ip_local_deliver_finish (./include/linux/rcupdate.h:329
> ./include/linux/rcupdate.h:781 net/ipv4/ip_input.c:232)
>  #5: ffff888007a87018 (slock-AF_INET/1){+.-.}-{2:2}, at: tcp_v4_rcv
> (./include/linux/skbuff.h:1640 ./include/net/tcp.h:2510
> net/ipv4/tcp_ipv4.c:2342)
>  #6: ffffffffb8849c00 (rcu_read_lock){....}-{1:2}, at:
> sk_psock_strp_data_ready (./include/linux/rcupdate.h:329
> ./include/linux/rcupdate.h:781 net/core/skmsg.c:1113)
>  #7: ffff888007a87228 (clock-AF_INET){++--}-{2:2}, at:
> sk_psock_strp_data_ready (net/core/skmsg.c:1120)
>  #8: ffffffffb8849c00 (rcu_read_lock){....}-{1:2}, at:
> sk_psock_strp_read (./include/linux/rcupdate.h:329
> ./include/linux/rcupdate.h:781 net/core/skmsg.c:1062)
>
>  stack backtrace:
>  CPU: 0 PID: 342 Comm: test_sockmap Not tainted 6.10.0-rc2 #59
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/=
01/2014
>  Call Trace:
>    <IRQ>
>   dump_stack_lvl (lib/dump_stack.c:118)
>   __lock_acquire (kernel/locking/lockdep.c:3858 kernel/locking/lockdep.c:=
5137)
>   ? __pfx___lock_acquire (kernel/locking/lockdep.c:4993)
>   ? tcp_rcv_established (./include/linux/skbuff.h:2097
> ./include/net/tcp.h:2026 ./include/net/tcp.h:2099
> net/ipv4/tcp_input.c:5660 net/ipv4/tcp_input.c:6179)
>   ? tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2345)
>   ? ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207 (discriminator 8))
>   ? ip_local_deliver_finish (./include/linux/rcupdate.h:810
> net/ipv4/ip_input.c:234)
>   ? __pfx_mark_lock (kernel/locking/lockdep.c:4639)
>   lock_acquire (kernel/locking/lockdep.c:467
> kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719)
>   ? sk_psock_skb_ingress_enqueue (./include/linux/skmsg.h:467
> net/core/skmsg.c:555)
>   ? __pfx_lock_acquire (kernel/locking/lockdep.c:5722)
>   ? __pfx_lock_release (kernel/locking/lockdep.c:5762)
>   ? mark_held_locks (kernel/locking/lockdep.c:4274)
>   ? sk_psock_skb_ingress_enqueue (./include/linux/skmsg.h:466
> net/core/skmsg.c:555)
>   _raw_read_lock_bh (./include/linux/rwlock_api_smp.h:177
> kernel/locking/spinlock.c:252)
>   ? sk_psock_skb_ingress_enqueue (./include/linux/skmsg.h:467
> net/core/skmsg.c:555)
>   sk_psock_skb_ingress_enqueue (./include/linux/skmsg.h:467
> net/core/skmsg.c:555)
>   sk_psock_skb_ingress_self (net/core/skmsg.c:607)
>   sk_psock_verdict_apply (net/core/skmsg.c:1008)
>   sk_psock_strp_read (./include/linux/rcupdate.h:810 net/core/skmsg.c:108=
1)
>   ? sk_psock_strp_parse (net/core/skmsg.c:1104)
>   __strp_recv (net/strparser/strparser.c:301 (discriminator 3))
>   tcp_read_sock (net/ipv4/tcp.c:1583)
>   ? __pfx_strp_recv (net/strparser/strparser.c:332)
>   ? __pfx_tcp_read_sock (net/ipv4/tcp.c:1560)
>   ? lock_acquire (kernel/locking/lockdep.c:467
> kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719)
>   strp_read_sock (net/strparser/strparser.c:358)
>   ? __pfx_strp_read_sock (net/strparser/strparser.c:346)
>   ? __pfx_do_raw_write_lock (kernel/locking/spinlock_debug.c:209)
>   ? lock_is_held_type (kernel/locking/lockdep.c:467
> kernel/locking/lockdep.c:5826)
>   strp_data_ready (net/strparser/strparser.c:388 net/strparser/strparser.=
c:366)
>   sk_psock_strp_data_ready (net/core/skmsg.c:1121)
>   tcp_data_queue (net/ipv4/tcp_input.c:5234)
>   ? lock_release (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5=
776)
>   ? __pfx_tcp_data_queue (net/ipv4/tcp_input.c:5148)
>   ? __pfx_tcp_urg (net/ipv4/tcp_input.c:5820)
>   ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421)
>   ? kvm_clock_get_cycles (./arch/x86/include/asm/preempt.h:94
> arch/x86/kernel/kvmclock.c:80 arch/x86/kernel/kvmclock.c:86)
>   ? ktime_get (kernel/time/timekeeping.c:195 (discriminator 4)
> kernel/time/timekeeping.c:395 (discriminator 4)
> kernel/time/timekeeping.c:403 (discriminator 4)
> kernel/time/timekeeping.c:850 (discriminator 4))
>   tcp_rcv_established (./include/linux/skbuff.h:2097
> ./include/net/tcp.h:2026 ./include/net/tcp.h:2099
> net/ipv4/tcp_input.c:5660 net/ipv4/tcp_input.c:6179)
>   ? __pfx_lock_acquire (kernel/locking/lockdep.c:5722)
>   ? __pfx_tcp_inbound_hash.constprop.0 (./include/net/tcp.h:2800)
>   ? __pfx_tcp_rcv_established (net/ipv4/tcp_input.c:6006)
>   ? do_raw_spin_lock (./arch/x86/include/asm/atomic.h:107
> ./include/linux/atomic/atomic-arch-fallback.h:2170
> ./include/linux/atomic/atomic-instrumented.h:1302
> ./include/asm-generic/qspinlock.h:111
> kernel/locking/spinlock_debug.c:116)
>   tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1956)
>   tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2345)
>   ? __pfx_tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2172)
>   ? __pfx_raw_local_deliver (net/ipv4/raw.c:201)
>   ? __pfx_mark_lock (kernel/locking/lockdep.c:4639)
>   ? __pfx_lock_release (kernel/locking/lockdep.c:5762)
>   ? lock_is_held_type (kernel/locking/lockdep.c:467
> kernel/locking/lockdep.c:5826)
>   ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207 (discriminator 8))
>   ip_local_deliver_finish (./include/linux/rcupdate.h:810
> net/ipv4/ip_input.c:234)
>   ip_local_deliver (./include/linux/netfilter.h:314
> ./include/linux/netfilter.h:308 net/ipv4/ip_input.c:254)
>   ? __pfx_ip_local_deliver (net/ipv4/ip_input.c:243)
>   ? lock_is_held_type (kernel/locking/lockdep.c:467
> kernel/locking/lockdep.c:5826)
>   ? ip_rcv_finish_core.constprop.0 (./include/net/net_namespace.h:383
> ./include/linux/netdevice.h:2577 net/ipv4/ip_input.c:372)
>   ip_rcv (./include/net/dst.h:460 net/ipv4/ip_input.c:449
> ./include/linux/netfilter.h:314 ./include/linux/netfilter.h:308
> net/ipv4/ip_input.c:569)
>   ? __pfx_ip_rcv (net/ipv4/ip_input.c:562)
>   ? lock_acquire (kernel/locking/lockdep.c:467
> kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719)
>   ? lock_acquire (kernel/locking/lockdep.c:467
> kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719)
>   ? __pfx_ip_rcv (net/ipv4/ip_input.c:562)
>   __netif_receive_skb_one_core (net/core/dev.c:5624 (discriminator 4))
>   ? __pfx___netif_receive_skb_one_core (net/core/dev.c:5617)
>   ? mark_held_locks (kernel/locking/lockdep.c:4274)
>   process_backlog (./include/linux/rcupdate.h:810 net/core/dev.c:6068)
>   __napi_poll.constprop.0 (net/core/dev.c:6721)
>   net_rx_action (net/core/dev.c:6792 net/core/dev.c:6906)
>   ? __pfx_net_rx_action (net/core/dev.c:6870)
>   ? __pfx_rcu_core (kernel/rcu/tree.c:2756)
>   ? mark_held_locks (kernel/locking/lockdep.c:4274)
>   ? __dev_queue_xmit (./include/linux/rcupdate.h:339
> ./include/linux/rcupdate.h:849 net/core/dev.c:4420)
>   handle_softirqs (kernel/softirq.c:554)
>   ? __dev_queue_xmit (./include/linux/rcupdate.h:339
> ./include/linux/rcupdate.h:849 net/core/dev.c:4420)
>   do_softirq (kernel/softirq.c:455 kernel/softirq.c:442)
>    </IRQ>
>    <TASK>
>   __local_bh_enable_ip (kernel/softirq.c:382)
>   ? __dev_queue_xmit (./include/linux/rcupdate.h:339
> ./include/linux/rcupdate.h:849 net/core/dev.c:4420)
>   __dev_queue_xmit (net/core/dev.c:4421)
>   ? __pfx___lock_acquire (kernel/locking/lockdep.c:4993)
>   ? __pfx_mark_lock (kernel/locking/lockdep.c:4639)
>   ? __pfx___dev_queue_xmit (net/core/dev.c:4302)
>   ? find_held_lock (kernel/locking/lockdep.c:5244)
>   ? lock_release (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5=
776)
>   ? __pfx_lock_release (kernel/locking/lockdep.c:5762)
>   ? __pfx___lock_acquire (kernel/locking/lockdep.c:4993)
>   ? mark_held_locks (kernel/locking/lockdep.c:4274)
>   ip_finish_output2 (./include/linux/netdevice.h:3095
> ./include/net/neighbour.h:526 ./include/net/neighbour.h:540
> net/ipv4/ip_output.c:235)
>   ? __pfx_nf_hook (./include/linux/netfilter.h:227)
>   ? lock_acquire (kernel/locking/lockdep.c:467
> kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719)
>   ? __pfx_ip_finish_output2 (net/ipv4/ip_output.c:199)
>   ? ip_skb_dst_mtu (./include/net/net_namespace.h:383
> ./include/linux/netdevice.h:2577 ./include/net/ip.h:465
> ./include/net/ip.h:502)
>   ? __ip_queue_xmit (net/ipv4/ip_output.c:535 (discriminator 4))
>   __ip_queue_xmit (net/ipv4/ip_output.c:535 (discriminator 4))
>   ? __skb_clone (./arch/x86/include/asm/atomic.h:53 (discriminator 4)
> ./include/linux/atomic/atomic-arch-fallback.h:992 (discriminator 4)
> ./include/linux/atomic/atomic-instrumented.h:436 (discriminator 4)
> net/core/skbuff.c:1576 (discriminator 4))
>   __tcp_transmit_skb (net/ipv4/tcp_output.c:1466 (discriminator 4))
>   ? __pfx___tcp_transmit_skb (net/ipv4/tcp_output.c:1287)
>   ? lock_release (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5=
776)
>   ? __pfx_lock_release (kernel/locking/lockdep.c:5762)
>   ? ktime_get (./arch/x86/include/asm/irqflags.h:42
> ./arch/x86/include/asm/irqflags.h:77
> ./arch/x86/include/asm/irqflags.h:135 ./include/linux/seqlock.h:74
> kernel/time/timekeeping.c:848)
>   ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421)
>   tcp_write_xmit (net/ipv4/tcp_output.c:2829)
>   ? __pfx_mem_cgroup_charge_skmem (mm/memcontrol.c:7886)
>   ? skb_page_frag_refill (net/core/sock.c:2920 net/core/sock.c:2904)
>   __tcp_push_pending_frames (net/ipv4/tcp_output.c:3014)
>   tcp_sendmsg_locked (net/ipv4/tcp.c:1316)
>   ? print_usage_bug.part.0 (kernel/locking/lockdep.c:3980)
>   ? __pfx_tcp_sendmsg_locked (net/ipv4/tcp.c:1046)
>   ? lock_release (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5=
776)
>   ? __local_bh_enable_ip (./arch/x86/include/asm/irqflags.h:42
> ./arch/x86/include/asm/irqflags.h:77 kernel/softirq.c:387)
>   tcp_sendmsg (net/ipv4/tcp.c:1349)
>   __sys_sendto (net/socket.c:730 net/socket.c:745 net/socket.c:2192)
>   ? __pfx___sys_sendto (net/socket.c:2162)
>   ? lock_is_held_type (kernel/locking/lockdep.c:467
> kernel/locking/lockdep.c:5826)
>   ? fd_install (./arch/x86/include/asm/preempt.h:103
> ./include/linux/rcupdate.h:896 fs/file.c:631)
>   ? __sys_accept4 (./include/linux/file.h:47 net/socket.c:2002)
>   ? __pfx___sys_accept4 (net/socket.c:1994)
>   ? handle_mm_fault (./include/linux/memcontrol.h:1078
> ./include/linux/memcontrol.h:1066 mm/memory.c:5557 mm/memory.c:5704)
>   __x64_sys_sendto (net/socket.c:2200)
>   ? do_syscall_64 (./arch/x86/include/asm/irqflags.h:42
> ./arch/x86/include/asm/irqflags.h:77
> ./include/linux/entry-common.h:197 arch/x86/entry/common.c:79)
>   ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421)
>   do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
>   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

