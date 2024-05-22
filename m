Return-Path: <bpf+bounces-30300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC2F8CC104
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 14:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BB3285AA9
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 12:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D37D13D61A;
	Wed, 22 May 2024 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ElQAy4iY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3682A13D601
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716379952; cv=none; b=bs2lbRN+4hZBqCdE4Ft0hwNvJtqYwbqNaE2Qjbqut7Ow4loXXoqIWxNsw3t3UnqRLOoCc2hc6n6q1hrX3PdZw+lHV8IQISwkbAYES+L9p75QTVz8RyGABNWdvHnvQVfKg7gV3f1XUw67AOaf4nL+I6PcMqFwATHqnpTwLAGjdBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716379952; c=relaxed/simple;
	bh=BAof/JIscvcZciVQ5PJ0YJMLhfMx6ELaTY2iwZ39ljM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ObI3wLvEIuFV0bCW4UXTxzmeYRy9Bqptic9M4ImpY4/69drsfk+VzviIM0rG93clefF6BAy+ynHE0xQS3pMMxd0HgKsdiEG5Ej/Wp2FjPQvJv8CtTz7htaFIY7ih4S+kQLR8KToVHNQAXBin4HTMbi72RAKJ0yeB71186sqfkMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ElQAy4iY; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so13658166a12.2
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 05:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1716379948; x=1716984748; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m6v7R8Jn9mrQ1jFO6WJT02ZXqZgLEi4/5o5xTGHxv3M=;
        b=ElQAy4iY1/S73PMf/h42QJYpiGWta2zoymcoqag3dRdQ+ILO4SsNimJt0GIfpcUFCn
         450820enbCk7ybR/ycCyvh98RDjiTWRPnSi9WTabn/kXJpnjFC2+vn81EZrqRfGhe/4V
         FIcFRxcmBMJzZNXfMhHQdnq6/GvBEnyHtOaI6dVWK8R3jGVngpXw8A5i61NKz2Zxa/kJ
         YiMFjRdtj+W0v/pbnqVLaUxaIarkrfC4EKn+BajuuQv13rItjiu7q04oYdeZHB1PciaS
         5CXoCCPeOrM3DfOWJBsVmAYBmDpHNRxkCnYnF430jSaVbhuMJUMjNdoLn5hOkGo18Bi3
         PFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716379948; x=1716984748;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6v7R8Jn9mrQ1jFO6WJT02ZXqZgLEi4/5o5xTGHxv3M=;
        b=kQEMnlCM+4QR+bV8u+oGkgYCytPVLstUSYtFXeP3CnWsUMQ5JZ1CT5XGbll+RdsUTX
         xhHW3N66RLytMpgTb/ltcA5napCkNG4a/HiZ5QID83mQHY6WRH6vb4GvYXfg48PQ8+1Y
         MqRiWV7r6HO7q9RvTNUNDTaHpkz0ENuT1LcmLuBI5XrEw4cXhUPEkQCqpqTUSWW0KK4G
         a0TgAz1C+5N7quedn0TC2H7/nY8LP+JwLRPOJBbJql53OLrZ/lRFYZhURu0uLpc+Eyae
         jTQ6bMZI5QFUlz8vNTHQG81lZvG4k8NIc3lDfGFbTE2Qgck+PGU+sw9eLoqKLdqIEXKx
         wHjw==
X-Forwarded-Encrypted: i=1; AJvYcCWX48uDtssd358ykdaLhx0hiz8YFEAY1HVdr5yV13sGZv2R37tGEWYhbzSaOhkR2Uo+ZnvUM4FULs15uoLGWWr3kdgi
X-Gm-Message-State: AOJu0YwpUJCU2daCcGVF5BZP0Qr3PCa/kBF7K/OmLJ8DPYcnLKs9bEK+
	MnUaBavTdUo/cER9XrNw20AFFIgOwYCyeimfDVnvjYpFToZ76N58pc5x2hhD20g=
X-Google-Smtp-Source: AGHT+IHqMWNSPjdTuLfdDab2oJ2USR+dOiil+nWG5c+2IEvTLY6ujL/dfbfMxSzfrvvGaDq69eQqlw==
X-Received: by 2002:a50:ab4b:0:b0:574:ecc4:6b54 with SMTP id 4fb4d7f45d1cf-578329c7ca3mr1731751a12.9.1716379948503;
        Wed, 22 May 2024 05:12:28 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:b7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bed000esm18281624a12.54.2024.05.22.05.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 05:12:27 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,  Tetsuo Handa
 <penguin-kernel@i-love.sakura.ne.jp>,  Eric Dumazet <edumazet@google.com>,
  Linus Torvalds <torvalds@linux-foundation.org>,  bpf
 <bpf@vger.kernel.org>,  LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf, sockmap: defer sk_psock_free_link() using RCU
In-Reply-To: <20240522113349.2202-1-hdanton@sina.com> (Hillf Danton's message
	of "Wed, 22 May 2024 19:33:49 +0800")
References: <838e7959-a360-4ac1-b36a-a3469236129b@I-love.SAKURA.ne.jp>
	<20240521225918.2147-1-hdanton@sina.com>
	<20240522113349.2202-1-hdanton@sina.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Wed, 22 May 2024 14:12:26 +0200
Message-ID: <87o78yvydx.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, May 22, 2024 at 07:33 PM +08, Hillf Danton wrote:
> On Wed, 22 May 2024 11:50:49 +0200 Jakub Sitnicki <jakub@cloudflare.com>
> On Wed, May 22, 2024 at 06:59 AM +08, Hillf Danton wrote:
>> > On Tue, 21 May 2024 08:38:52 -0700 Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> >> On Sun, May 12, 2024 at 12:22=E2=80=AFAM Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> >> > --- a/net/core/sock_map.c
>> >> > +++ b/net/core/sock_map.c
>> >> > @@ -142,6 +142,7 @@ static void sock_map_del_link(struct sock *sk,
>> >> >         bool strp_stop =3D false, verdict_stop =3D false;
>> >> >         struct sk_psock_link *link, *tmp;
>> >> >
>> >> > +       rcu_read_lock();
>> >> >         spin_lock_bh(&psock->link_lock);
>> >> 
>> >> I think this is incorrect.
>> >> spin_lock_bh may sleep in RT and it won't be safe to do in rcu cs.
>> >
>> > Could you specify why it won't be safe in rcu cs if you are right?
>> > What does rcu look like in RT if not nothing?
>> 
>> RCU readers can't block, while spinlock RT doesn't disable preemption.
>> 
>> https://docs.kernel.org/RCU/rcu.html
>> https://docs.kernel.org/locking/locktypes.html#spinlock-t-and-preempt-rt
>> 
>> I've finally gotten around to testing proposed fix that just disallows
>> map_delete_elem on sockmap/sockhash from BPF tracing progs
>> completely. This should put an end to this saga of syzkaller reports.
>> 
>> https://lore.kernel.org/all/87jzjnxaqf.fsf@cloudflare.com/
>> 
> The locking info syzbot reported [2] suggests a known issue that like Alexei
> you hit the send button earlier than expected.
>
> 4 locks held by syz-executor361/5090:
>  #0: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
>  #0: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
>  #0: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: map_delete_elem+0x388/0x5e0 kernel/bpf/syscall.c:1695
>  #1: ffff88807b2af8f8 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
>  #1: ffff88807b2af8f8 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_delete_elem+0x17c/0x400 net/core/sock_map.c:945
>  #2: ffff88801c2a4290 (&psock->link_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
>  #2: ffff88801c2a4290 (&psock->link_lock){+...}-{2:2}, at: sock_map_del_link net/core/sock_map.c:145 [inline]
>  #2: ffff88801c2a4290 (&psock->link_lock){+...}-{2:2}, at: sock_map_unref+0xcc/0x5e0 net/core/sock_map.c:180
>  #3: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
>  #3: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
>  #3: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
>  #3: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420
>
> [2] https://lore.kernel.org/all/000000000000d0b87206170dd88f@google.com/
>
>
> If CONFIG_PREEMPT_RCU=y rcu_read_lock() does not disable
> preemption. This is even true for !RT kernels with CONFIG_PREEMPT=y
>
> [3] Subject: Re: [patch 30/63] locking/spinlock: Provide RT variant
> https://lore.kernel.org/all/874kc6rizr.ffs@tglx/

That locking issue is related to my earlier, as it turned out -
incomplete, fix:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ff91059932401894e6c86341915615c5eb0eca48

We don't expect map_delete_elem to be called from map_update_elem for
sockmap/sockhash, but that is what syzkaller started doing by attaching
BPF tracing progs which call map_delete_elem.

