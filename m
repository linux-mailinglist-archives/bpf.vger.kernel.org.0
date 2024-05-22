Return-Path: <bpf+bounces-30304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 564308CC39E
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 16:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A553C1F22E46
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 14:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D2120DF4;
	Wed, 22 May 2024 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RR8qWjsc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AFC1CD16;
	Wed, 22 May 2024 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389884; cv=none; b=MnogDyaDJl/WtcdK0RM4DI0/HQ2REjd3rL2lY4ENcDUTE04B/+FCvScejk109Z0SOOflk+O12EG7sqNobYaLKSujp1Ekmkuz/zmGE8jvuhgSGZiCBtfcEM5nBkMzgwXT2k07xQiDBKLVtGlzm/oH6pH5BYUnk9K2JF0WrP1vLzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389884; c=relaxed/simple;
	bh=sNIJpRfP4ZNAO3JZryCVD2MT1kP8J4iERxQvnvO9sG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kINKROJsWxcK6W+snX/vNQI/SlU3JwDai1V8WNYhIo7P/T46N/PBQS1lORA3TjKSxKBfhQrlZgzzviSu49HCs56AK8AJ68TwBZ7hsgpsbkBdVWPb2ssvL9I33dRauNrF5CWwsAPi12SKLyrtlFdF+fn+lAvVP1iOiegyBvA11Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RR8qWjsc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4202cea9a2fso8572845e9.3;
        Wed, 22 May 2024 07:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716389880; x=1716994680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+dDeIIv4/uhDcs1sA4p7D8qsofH0JyJ1gi8ixGWHQQ=;
        b=RR8qWjscOEWGd/zTC5iGf++mSoOvtRsqndoZ6wLecoxwOVIyHZ4K4j0D7O0frsM8nz
         kpuyDZgdkgA1Iru2N4vsxBw7CrdwKA1khsM5wd2Z9G6JyQi/qpbGjdmIehZpSB0hHnav
         tWVxa5l43mEFMiW9wu9Mo7yXwPNhMRokFcX+VoWhMd1BY1ixXJRtfCdF52loSXg5t4jX
         sdXv/h9fphYVwmBel+n0GOU+UZh4yrwkbmoLbtDl3/kIxzAtGrTskD8UK+9Ronfen3j5
         N+0lANn00UCF/SQfzX5N5Tq9bucUiegSrOmZtDBIUhycgXVPwAT+8mzK2expX7YnLq+L
         bLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716389880; x=1716994680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+dDeIIv4/uhDcs1sA4p7D8qsofH0JyJ1gi8ixGWHQQ=;
        b=bdQmGXZ4gqYbMG6ZEIdv09IFzKy8DHyvCvvJRbtCkkE3zAZRQqACsbQVxFN9EBbsvF
         t8WPcxTy10IWY8gTyuzbzctZj+ocLx+R+LsR9dZVvTeoT1wgUPsIbgEq1L8DJak39xK8
         /UeIPq2c82iGiZ3mOppZ8rEmMwei/eEW4H+MTWVJR4ji2BJpjvaE9t6wCm8FAlhqc3vS
         ot/B+s2PgRmkfbBMs6bNoe4vr57xP2xLaVaelwtO7J459leQzbPEBaA/g4jmPu77optO
         8DjsQ9Z2zb/IHqFJTKq/skxInSptI/zoEotceFfaIPKAJT8IFyI1jiF5lLtiTQqWCJ+W
         SXAg==
X-Forwarded-Encrypted: i=1; AJvYcCVbdpOlD3knYJIVtWuIOuvTE+zGtWyUmtF0390NPyu8FgqBwhoVe2ZBxeUc+XP2TH0zrLp0OeF+G7hfkRZVWFIp0lJtpAaFp2WcIQ4TpqJW0+Ap8vLiRNIh7ZTiMp05iuk1
X-Gm-Message-State: AOJu0YwVU7ktygAtLEEJLfCUQEkD43Q9UDnsxrTKDQ+01diplJhfVQeH
	KyI8MTVwiosVFlXWk025xQw+4fme4UVB/pTwUkY3x157lrozCz3ppI/xiywES0Exvpcz0aL17oO
	JOHlPEvkx9KDt1LxG9TKAaZZ3nXHauA==
X-Google-Smtp-Source: AGHT+IG3r58WVQJ64mCHF4QO8x24ODELD9v3yHURR/2VERPceKZUjEwp6WIgfT5kbQEBQ5zTYq4VaAFNPdoQ4g7iNbc=
X-Received: by 2002:a05:600c:2311:b0:420:ee24:9b26 with SMTP id
 5b1f17b1804b1-420fd31a43emr16094795e9.24.1716389880339; Wed, 22 May 2024
 07:58:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <838e7959-a360-4ac1-b36a-a3469236129b@I-love.SAKURA.ne.jp>
 <20240521225918.2147-1-hdanton@sina.com> <20240522113349.2202-1-hdanton@sina.com>
 <87o78yvydx.fsf@cloudflare.com>
In-Reply-To: <87o78yvydx.fsf@cloudflare.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 May 2024 07:57:48 -0700
Message-ID: <CAADnVQKfbaY-pm2H-6U_c=-XyvocSAkNqXg4+Kj7cXGtmajaAA@mail.gmail.com>
Subject: Re: [PATCH] bpf, sockmap: defer sk_psock_free_link() using RCU
To: Jakub Sitnicki <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Hillf Danton <hdanton@sina.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Eric Dumazet <edumazet@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 5:12=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Wed, May 22, 2024 at 07:33 PM +08, Hillf Danton wrote:
> > On Wed, 22 May 2024 11:50:49 +0200 Jakub Sitnicki <jakub@cloudflare.com=
>
> > On Wed, May 22, 2024 at 06:59 AM +08, Hillf Danton wrote:
> >> > On Tue, 21 May 2024 08:38:52 -0700 Alexei Starovoitov <alexei.starov=
oitov@gmail.com>
> >> >> On Sun, May 12, 2024 at 12:22=3DE2=3D80=3DAFAM Tetsuo Handa <pengui=
n-kernel@i-love.sakura.ne.jp> wrote:
> >> >> > --- a/net/core/sock_map.c
> >> >> > +++ b/net/core/sock_map.c
> >> >> > @@ -142,6 +142,7 @@ static void sock_map_del_link(struct sock *sk=
,
> >> >> >         bool strp_stop =3D3D false, verdict_stop =3D3D false;
> >> >> >         struct sk_psock_link *link, *tmp;
> >> >> >
> >> >> > +       rcu_read_lock();
> >> >> >         spin_lock_bh(&psock->link_lock);
> >> >>
> >> >> I think this is incorrect.
> >> >> spin_lock_bh may sleep in RT and it won't be safe to do in rcu cs.
> >> >
> >> > Could you specify why it won't be safe in rcu cs if you are right?
> >> > What does rcu look like in RT if not nothing?
> >>
> >> RCU readers can't block, while spinlock RT doesn't disable preemption.
> >>
> >> https://docs.kernel.org/RCU/rcu.html
> >> https://docs.kernel.org/locking/locktypes.html#spinlock-t-and-preempt-=
rt
> >>
> >> I've finally gotten around to testing proposed fix that just disallows
> >> map_delete_elem on sockmap/sockhash from BPF tracing progs
> >> completely. This should put an end to this saga of syzkaller reports.
> >>
> >> https://lore.kernel.org/all/87jzjnxaqf.fsf@cloudflare.com/

Agree. Let's do that. According to John the delete path is not something
that is used in production. It's only a source of trouble with syzbot.


> >>
> > The locking info syzbot reported [2] suggests a known issue that like A=
lexei
> > you hit the send button earlier than expected.
> >
> > 4 locks held by syz-executor361/5090:
> >  #0: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire=
 include/linux/rcupdate.h:329 [inline]
> >  #0: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock in=
clude/linux/rcupdate.h:781 [inline]
> >  #0: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: map_delete_elem+=
0x388/0x5e0 kernel/bpf/syscall.c:1695
> >  #1: ffff88807b2af8f8 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lo=
ck_bh include/linux/spinlock.h:356 [inline]
> >  #1: ffff88807b2af8f8 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_ha=
sh_delete_elem+0x17c/0x400 net/core/sock_map.c:945
> >  #2: ffff88801c2a4290 (&psock->link_lock){+...}-{2:2}, at: spin_lock_bh=
 include/linux/spinlock.h:356 [inline]
> >  #2: ffff88801c2a4290 (&psock->link_lock){+...}-{2:2}, at: sock_map_del=
_link net/core/sock_map.c:145 [inline]
> >  #2: ffff88801c2a4290 (&psock->link_lock){+...}-{2:2}, at: sock_map_unr=
ef+0xcc/0x5e0 net/core/sock_map.c:180
> >  #3: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire=
 include/linux/rcupdate.h:329 [inline]
> >  #3: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock in=
clude/linux/rcupdate.h:781 [inline]
> >  #3: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run =
kernel/trace/bpf_trace.c:2380 [inline]
> >  #3: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0=
x114/0x420 kernel/trace/bpf_trace.c:2420
> >
> > [2] https://lore.kernel.org/all/000000000000d0b87206170dd88f@google.com=
/
> >
> >
> > If CONFIG_PREEMPT_RCU=3Dy rcu_read_lock() does not disable
> > preemption. This is even true for !RT kernels with CONFIG_PREEMPT=3Dy
> >
> > [3] Subject: Re: [patch 30/63] locking/spinlock: Provide RT variant
> > https://lore.kernel.org/all/874kc6rizr.ffs@tglx/
>
> That locking issue is related to my earlier, as it turned out -
> incomplete, fix:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dff91059932401894e6c86341915615c5eb0eca48
>
> We don't expect map_delete_elem to be called from map_update_elem for
> sockmap/sockhash, but that is what syzkaller started doing by attaching
> BPF tracing progs which call map_delete_elem.

