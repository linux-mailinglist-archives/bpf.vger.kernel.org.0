Return-Path: <bpf+bounces-26208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B73D89CAA3
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 19:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313E51C22065
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 17:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2618A143C4A;
	Mon,  8 Apr 2024 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dm4OwNNh"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF96143860
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596843; cv=none; b=skQJC425MHGUOiuhp3Mrr1/dC5SA8UEL0uW8wxgSwrkQCP/c2srhq5/j8kWW6EMs0wMxkhtu4+HGFrN2RoE0ftZOr9tOd3aepIFsCMxLVXTW8E441Y/8je4aVmq6ulcSidkAASV4EqpcxUHE1uf5+LGXanZ0j5qnfrGZfFYF2ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596843; c=relaxed/simple;
	bh=LDjaWAvebvLx3MhYgg+6m/Onrp7EZMzfq2XnS1PyCHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/YUAB492CZpa9Gdbrl/83WhwTH3CL3skvOYMwnzZKZFlArKKZz/uX7nuuU7ZDpLvAvhrJ/2M2g4lvOIQyNSPwFwwSaj+4fTuwRxMUe/LRvWSOgWD1kcJVLgF4MOtC7dLmPDh/onsEtQeiF4eD2IsC9A29rF/yXPeRgYPRjMAy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dm4OwNNh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712596840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=50vujPDoJgDaPu8/wFGRO5CAScsruXRwyphlNNmfr0k=;
	b=Dm4OwNNh9HatpJ3hBxmXHiEi5ilD424E4KOM4k7o0d1wlLp83Jk8JEicsBuoszgg1C7Gia
	ziMwkt/mBt1ua72ZL2AN/IMGP/BvCrtlZwPWY4mOZca/lF0NXcJ9o1HF47Ng7Po3axsudq
	Xq2dSaorpm2775atGzi01+pQHTGe3bk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-j1YtUgbROwa9U2y3aHX1Rw-1; Mon, 08 Apr 2024 13:20:39 -0400
X-MC-Unique: j1YtUgbROwa9U2y3aHX1Rw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a51c6085bf0so70814166b.3
        for <bpf@vger.kernel.org>; Mon, 08 Apr 2024 10:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712596838; x=1713201638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50vujPDoJgDaPu8/wFGRO5CAScsruXRwyphlNNmfr0k=;
        b=YMXK+N55x+EAiQTrevoaOjvQbw+A0vlbQ6nDVewxssWg5T8ddLzRjUQJdq3KgTh1Ol
         q9yryCGccKlk7+ZOxo97SUC/+TPl+P/FRUjkbVuvKM7WDnG01dYnI+8mXamx4HP+6F0O
         dBzdgpuWvT2DRjYo88M05fXQ4BPvXxGg31/quyQPoIZn5Em/URlViH4yvxR5sO89GmFx
         w6Z3mcgHcfHPSMCLI1jXzO130epEq1cRZIFKiZ7sKDgzuLWQdI5SAwQR9M+ZL4Ny4/H0
         sxxNZ9j3AAZT4ntVAc3o+89XnUkELmfWav+re7LA128sxggDJ8IH+yhjjngf0lhlL2HX
         /1pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsO//Ljv3wO+kn2Z6XCBCjffYt6uAT4Lxg9OLnh1iJTHcKHs2TcY8cP/ZkspN1o66+ZvZzvH4GGb7FcN8hCWYLa91H
X-Gm-Message-State: AOJu0YwIRyahZ13VVfPAMSGbtTVtgcou9mIUEE8JBcDTW3wGahPJdsLl
	udEzpqbi4RI6cCz/HRVFgAIhLB9bLClY2kYwGn/WqWDuNKIV3azlrf4IdEyoCrktS4IN5SVOImy
	uiJn1R37dPO/ApjY7B/VMdU+3Sf9Z7RMhFUQy9YBJCF8e8nnf4znkD5G7kIS1wZghn3Mjr2bSak
	GLvzaq4Yd4PW2l/5+Bg+pzKZ6M
X-Received: by 2002:a17:907:6e86:b0:a51:cbd5:1d1a with SMTP id sh6-20020a1709076e8600b00a51cbd51d1amr3393915ejc.32.1712596838390;
        Mon, 08 Apr 2024 10:20:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC3zfnBvgT8CFgQ1ahTRlqU0oFuIAh3svUw9JLpurRNOrG7VxATpA8Ds4wI2ii68ghlo2+Ygos9fvYQkCBwrY=
X-Received: by 2002:a17:907:6e86:b0:a51:cbd5:1d1a with SMTP id
 sh6-20020a1709076e8600b00a51cbd51d1amr3393895ejc.32.1712596838037; Mon, 08
 Apr 2024 10:20:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org>
 <20240408-hid-bpf-sleepable-v6-1-0499ddd91b94@kernel.org> <65c249a6af45bfa5fe0f6c2331dcc1771a6f0b05.camel@gmail.com>
In-Reply-To: <65c249a6af45bfa5fe0f6c2331dcc1771a6f0b05.camel@gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Mon, 8 Apr 2024 19:20:26 +0200
Message-ID: <CAO-hwJ+0erX3iJcOh9KBG3f01UiYvGk_Gx+-zyFc4Vb5LCcHxA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v6 1/6] bpf/helpers: introduce sleepable bpf_timers
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 7:08=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2024-04-08 at 10:09 +0200, Benjamin Tissoires wrote:
>
> [...]
>
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 9234174ccb21..fd05d4358b31 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1096,12 +1096,19 @@ const struct bpf_func_proto bpf_snprintf_proto =
=3D {
> >   * freeing the timers when inner map is replaced or deleted by user sp=
ace.
> >   */
> >  struct bpf_hrtimer {
> > -     struct hrtimer timer;
> > +     union {
> > +             struct hrtimer timer;
> > +             struct work_struct work;
> > +     };
> >       struct bpf_map *map;
> >       struct bpf_prog *prog;
> >       void __rcu *callback_fn;
> >       void *value;
> > -     struct rcu_head rcu;
> > +     union {
> > +             struct rcu_head rcu;
> > +             struct work_struct sync_work;
>
> Nit:
> I find this name very confusing, the field is used to cancel timer
> execution, is it a convention to call such things '...sync...'?
>
> > +     };
> > +     u64 flags;
> >  };
> >
>
> [...]
>
> > +static void bpf_timer_sync_work_cb(struct work_struct *work)
> > +{
> > +     struct bpf_hrtimer *t =3D container_of(work, struct bpf_hrtimer, =
sync_work);
> > +
> > +     cancel_work_sync(&t->work);
> > +
> > +     kfree_rcu(t, rcu);
>
> Sorry, I might be wrong, but this looks suspicious.
> The 'rcu' field of 'bpf_hrtimer' is defined as follows:
>
> struct bpf_hrtimer {
>         ...
>         union {
>                 struct rcu_head rcu;
>                 struct work_struct sync_work;
>         };
>         ...
> };
>
> And for sleepable timers the 'sync_work' field is set as follows:
>
> BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map=
 *, map,
>            u64, flags)
> {
>         ...
>         INIT_WORK(&t->sync_work, bpf_timer_sync_work_cb);
>         ...
> }
>
> So, it looks like 'kfree_rcu' would be called for a non-rcu pointer.

That was my initial assumption too, but Alexei told me it was fine.
And I think he is correct because kfree_rcu doesn't need the rcu_head
to be initialized.

So in the end, we initialize the memory as a work_struct, and when
that work kicks in, we reuse that exact same memory as the rcu_head.
This is fine because that work will never be reused.

If I understand correctly, this is to save a few bytes as this is a
critical struct used in programs with a high rate usage, and every
byte counts.

Cheers,
Benjamin

>
> > +}
> > +
>
>


