Return-Path: <bpf+bounces-74825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85847C66A73
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 01:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 86C54298DB
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 00:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BC5277017;
	Tue, 18 Nov 2025 00:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDYnXp23"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E6272816
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 00:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763425510; cv=none; b=jpwwtHbdqzDXN9qIR0qZ1XcxxBMCe18EYdKIxX/R5ndsjI+8+y5VQy2Edl1lDUkXGV6J8a47+7vuX1ryj5Q79MucXy3dmmthp7bLHRe+jCSEMmW3MJGShONj0UhWg/o/crbJLXHqOWhFa4dV1UC7K2vqazLrwqYEJyBINivZdFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763425510; c=relaxed/simple;
	bh=4mzWxm0FExzAVQfP+Nggm4NdLPQI9ceVCiBNtj72gag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYEERnhsdYloIb2SerN4afYiV7Iw5iOVd1hCdPf+EmIkY65CEBhahNa/x9xbOC/lyi9qXzBobBkNvyEy76aE2iSnAxzVEkSPsuiMBqiJJIYZyPryawjxyWK3iPzB0Gja6Le1HWh3xVFuS6/eUo/LuaJv5IAuGpvhaEGoxpNttCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDYnXp23; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6420c0cf4abso1089285d50.1
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 16:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763425507; x=1764030307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXfCa+oVsDITgwK8E28o89vmmOunafNUqzYLlmnNM/U=;
        b=ZDYnXp23Qe5lguiuBJvK3Svm7I3EnDmSpwh4WEPt19man5kNf+eNE026RKR7NXB46N
         8nWQyfM9QMTJMQvI4B2+ijaQWmawyFtavUpmKkw0Z0D2j2TrFQhGuOAiKnkQl9Fqa2sC
         xqrfNn+QaaDFFAuroy1ncAhRqe5kTXKU2OrecFvsJk4JY61jOVdd3Ymq4GDJ+uxa4pq1
         p02SpiBON5WjjAny6AneA4Sqj7jd9IePYJkI+DVmYbPxaBNoos/ODikTEgwRDrfmV2pk
         6kSNNzcnW3ACl2sWf1fvpzrW0+yQM0DiBnAiFULG9miE+bDkRWDiWKmc8nw6iKjUOUgQ
         Zbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763425507; x=1764030307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cXfCa+oVsDITgwK8E28o89vmmOunafNUqzYLlmnNM/U=;
        b=FxsoNJzNEeNfN32hhRrvIXJ7qHwPi+S0kt1Mqn9M959R8FspUHeDwyzLp2K/YuSUcK
         dInG8krUyRtQRINu6MHxIaeqL2+V411cc1qydv3xrSvY8Pb+LXe0+MjmeWYeJ+jIDG95
         /r30E+23SUpCflLSOUIbF/Oh65zlwjSWAlvHcjyZDXoT8VMi9XTu8cCRfSr8JZGsWMBr
         fxMbjyZMxpz4x01xYju4//vL/iD7+pA9sBfzGi6X/LGp8FtV1VQEvcX2uf+FoNbKc/Wa
         av/QDp8UzldNHJT4d70gNWeLIX8V7IE3UPNFn1Uh47QAg1Jbw082jNbPmWTS0Qyc879B
         t0YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoaXGDHOGN+iV67Z6naiKtTG4IRn/p61XELjNsSZvjrXPE7Q6MYTsyfFox6yffoeqee2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSF7zuOgnJFEDSOzHuy7GJxP2G81i6xTWbG6jGQxn/YxChzfNj
	iLJouzEQXaH+eEee9DR6fXThLqnbYwMfeWU3zyEZSmVGK8gxDQD+lJBTJ3glAzq5rZZoCNGgapO
	Zl9YUCj/pBZKJKfmK4HCkPxGk466u6D4=
X-Gm-Gg: ASbGncvggaHZ90SsqUk2oyptagtXIBbiHPZubi7fA6rj1jmMt3WROaY90vea6olXs3x
	/XfF2UGqgj6OBhAPxDJo1HpJviAkLf6ewjqMHJGSLr9Giy42MuusIXqSCsI274XSy1wTY2RskV3
	Q84+rXZFpWWNAfqz/77xfYKR1w+vrBTQ/LDmwNKaZf6IguO0UzW3U61eyvoUcQlL9ZQyAI6hnDB
	IQINQcVueTGWUaNG49SEMt+wuL7rizRoLkiJSo9phP8nJwsfFbdVklPrE/ZoNwewm9Fm0wkfSyh
	k4P8UUhVuoUM3jEw
X-Google-Smtp-Source: AGHT+IHAbfGoyHsYKH3jzHgG0RQdTWgI5Lr057GSg4HE7cHSIAb0B6av2FDxAkjEWfHyMd+mdAfguAzO/NjFZpbRp+4=
X-Received: by 2002:a05:690e:4101:b0:642:84a:7bdc with SMTP id
 956f58d0204a3-642084a7ee2mr3479239d50.83.1763425507022; Mon, 17 Nov 2025
 16:25:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114201329.3275875-1-ameryhung@gmail.com> <20251114201329.3275875-5-ameryhung@gmail.com>
 <CAADnVQJD0xLa=bWUerdYsRg8R4S54yqnPnuwkHWL1R663U3Xcg@mail.gmail.com>
 <CAMB2axPEmykdt2Wcvb49j1iG8b+ZTxvDoRgRYKmJAnTvbLsN9g@mail.gmail.com>
 <CAADnVQ+FC5dscjW0MQbG2qYP7KSQ2Ld6LCt5uK8+M2xreyeU7w@mail.gmail.com> <450751b2-5bc4-4c76-b9ca-019b87b96074@paulmck-laptop>
In-Reply-To: <450751b2-5bc4-4c76-b9ca-019b87b96074@paulmck-laptop>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 17 Nov 2025 16:24:56 -0800
X-Gm-Features: AWmQ_blKF7jNU3eJ3H4uPhlx_7GuSkI4zHWsuVPdxNFvoNJJVys8ZBeiZMnjxas
Message-ID: <CAMB2axM==X6+WJFenbuwTn82=2iRL-5_GCmj5RmK_fsGf07x7w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/4] bpf: Replace bpf memory allocator with
 kmalloc_nolock() in local storage
To: paulmck@kernel.org
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 3:46=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Mon, Nov 17, 2025 at 03:36:08PM -0800, Alexei Starovoitov wrote:
> > On Mon, Nov 17, 2025 at 12:37=E2=80=AFPM Amery Hung <ameryhung@gmail.co=
m> wrote:
> > >
> > > On Fri, Nov 14, 2025 at 6:01=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Fri, Nov 14, 2025 at 12:13=E2=80=AFPM Amery Hung <ameryhung@gmai=
l.com> wrote:
> > > > >
> > > > >
> > > > > -       if (smap->bpf_ma) {
> > > > > +       if (smap->use_kmalloc_nolock) {
> > > > >                 rcu_barrier_tasks_trace();
> > > > > -               if (!rcu_trace_implies_rcu_gp())
> > > > > -                       rcu_barrier();
> > > > > -               bpf_mem_alloc_destroy(&smap->selem_ma);
> > > > > -               bpf_mem_alloc_destroy(&smap->storage_ma);
> > > > > +               rcu_barrier();
> > > >
> > > > Why unconditional rcu_barrier() ?
> > > > It's implied in rcu_barrier_tasks_trace().
> > >
> > > Hmm, I am not sure.
> > >
> > > > What am I missing?
> > >
> > > I hit a UAF in v1 in bpf_selem_free_rcu() when running selftests and
> > > making rcu_barrier() unconditional addressed it. I think the bug was
> > > due to map_free() not waiting for bpf_selem_free_rcu() (an RCU
> > > callback) to finish.
> > >
> > > Looking at rcu_barrier() and rcu_barrier_tasks_trace(), they pass
> > > different rtp to rcu_barrier_tasks_generic() so I think both are
> > > needed to make sure in-flight RCU and RCU tasks trace callbacks are
> > > done.
> > >
> > > Not an expert in RCU so I might be wrong and it was something else.
> >
> > Paul,
> >
> > Please help us here.
> > Does rcu_barrier_tasks_trace() imply rcu_barrier() ?
>
> I am sorry, but no, it does not.

Thanks for the clarification, Paul!

>
> If latency proves to be an issue, one approach is to invoke rcu_barrier()
> and rcu_barrier_tasks_trace() each in its own workqueue handler.  But as
> always, I suggest invoking them one after the other to see if a latency
> problem really exists before adding complexity.
>
> Except that rcu_barrier_tasks_trace() is never invoked by rcu_barrier(),
> only rcu_barrier_tasks() and rcu_barrier_tasks_trace().  So do you really
> mean rcu_barrier()?  Or rcu_barrier_tasks()?

Sorry for the confusion. I misread the code. I was trying to say that
rcu_barrier() and rcu_barrier_tasks_trace() seem to wait on different
callacks but then referring to rcu_barrier_tasks() implementation
wrongly.

>
> Either way, rcu_barrier_tasks() and rcu_barrier_tasks_trace() are also
> independent of each other in the sense that if you need tw wait on
> callbacks from both call_rcu_tasks() and call_rcu_tasks_trace(), you
> need both rcu_barrier_tasks() and rcu_barrier_tasks_trace() to be invoked=
.
>
>                                                         Thanx, Paul

