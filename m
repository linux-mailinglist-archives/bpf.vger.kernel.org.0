Return-Path: <bpf+bounces-30290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8834C8CC050
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 13:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281341F22E6E
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 11:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F248248C;
	Wed, 22 May 2024 11:34:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4587E776
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716377649; cv=none; b=fOAs8FYpaR4fOPlATaXY3p/SICoKENJgZoVLGWbRQSlrbv5jKcJrjyOMd7wN/bxOxljuNUjaDv9StRSAA1fK0xCg2VX0CVFUwb+wmAdMKYX8+RSl4UPmChJJWB1GoKF4cQcuweJqiRboPyG+XbdyYH+Nmij131+QbeU/Xd6Q8KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716377649; c=relaxed/simple;
	bh=lH6KbgxQ/zhQaHHB/tshrEoyjiCr4O+1LfFZ/Ly2bCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RxKEKMlzlXviaj/OLm3vUq1aXzYSyx6fGAAwvBfOdkVI96YT6LbMxMqaXUs3/AAo9Qvfkz9ZvMAu21neuWdBqFlPm3Evm0T93N5ZEzWe89idinf6xAMHbJ+3BxngWBflhoGrEbrWajB9+gfroJDawtY4FR/9LiCWm6RvmpAO/2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.62])
	by sina.com (172.16.235.25) with ESMTP
	id 664DD8260000282A; Wed, 22 May 2024 19:34:00 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 70485834210399
X-SMAIL-UIID: FADD444D6EE443508E86F8EBE03CEA13-20240522-193400-1
From: Hillf Danton <hdanton@sina.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Eric Dumazet <edumazet@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf, sockmap: defer sk_psock_free_link() using RCU
Date: Wed, 22 May 2024 19:33:49 +0800
Message-Id: <20240522113349.2202-1-hdanton@sina.com>
In-Reply-To: <877cfmxjie.fsf@cloudflare.com>
References: <838e7959-a360-4ac1-b36a-a3469236129b@I-love.SAKURA.ne.jp> <20240521225918.2147-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 22 May 2024 11:50:49 +0200 Jakub Sitnicki <jakub@cloudflare.com>
On Wed, May 22, 2024 at 06:59 AM +08, Hillf Danton wrote:
> > On Tue, 21 May 2024 08:38:52 -0700 Alexei Starovoitov <alexei.starovoitov@gmail.com>
> >> On Sun, May 12, 2024 at 12:22=E2=80=AFAM Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >> > --- a/net/core/sock_map.c
> >> > +++ b/net/core/sock_map.c
> >> > @@ -142,6 +142,7 @@ static void sock_map_del_link(struct sock *sk,
> >> >         bool strp_stop =3D false, verdict_stop =3D false;
> >> >         struct sk_psock_link *link, *tmp;
> >> >
> >> > +       rcu_read_lock();
> >> >         spin_lock_bh(&psock->link_lock);
> >> 
> >> I think this is incorrect.
> >> spin_lock_bh may sleep in RT and it won't be safe to do in rcu cs.
> >
> > Could you specify why it won't be safe in rcu cs if you are right?
> > What does rcu look like in RT if not nothing?
> 
> RCU readers can't block, while spinlock RT doesn't disable preemption.
> 
> https://docs.kernel.org/RCU/rcu.html
> https://docs.kernel.org/locking/locktypes.html#spinlock-t-and-preempt-rt
> 
> I've finally gotten around to testing proposed fix that just disallows
> map_delete_elem on sockmap/sockhash from BPF tracing progs
> completely. This should put an end to this saga of syzkaller reports.
> 
> https://lore.kernel.org/all/87jzjnxaqf.fsf@cloudflare.com/
> 
The locking info syzbot reported [2] suggests a known issue that like Alexei
you hit the send button earlier than expected.

4 locks held by syz-executor361/5090:
 #0: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: map_delete_elem+0x388/0x5e0 kernel/bpf/syscall.c:1695
 #1: ffff88807b2af8f8 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #1: ffff88807b2af8f8 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_delete_elem+0x17c/0x400 net/core/sock_map.c:945
 #2: ffff88801c2a4290 (&psock->link_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #2: ffff88801c2a4290 (&psock->link_lock){+...}-{2:2}, at: sock_map_del_link net/core/sock_map.c:145 [inline]
 #2: ffff88801c2a4290 (&psock->link_lock){+...}-{2:2}, at: sock_map_unref+0xcc/0x5e0 net/core/sock_map.c:180
 #3: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #3: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #3: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #3: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420

[2] https://lore.kernel.org/all/000000000000d0b87206170dd88f@google.com/


If CONFIG_PREEMPT_RCU=y rcu_read_lock() does not disable
preemption. This is even true for !RT kernels with CONFIG_PREEMPT=y

[3] Subject: Re: [patch 30/63] locking/spinlock: Provide RT variant
https://lore.kernel.org/all/874kc6rizr.ffs@tglx/

