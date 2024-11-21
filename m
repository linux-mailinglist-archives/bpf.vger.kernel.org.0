Return-Path: <bpf+bounces-45389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE69D9D50C2
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 17:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86420B20EB0
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 16:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C04019F462;
	Thu, 21 Nov 2024 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UyoFesxE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0826513F43B
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732206751; cv=none; b=n/5ze4ZqeCv2wc+O3nnMZ8Yhpq3lH5D1mGCC4jnlIYPNbfeyNBsUFOvu2ik8bp4rrJBwYzijqbURAgeHimYgthOg+hRCXGbvXTATOPFXpPiuVe7DR8bZg1n935qw2WdTClntIWwW/YOVEVZpwPp6YrDK+zjxftiL+M5mN+iLrGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732206751; c=relaxed/simple;
	bh=0071SProcnj54azKnrgs9O4CTcBQWiKx7fiDtH0v6QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHsnHOYF0GJYDyaipX48VMVEmYxKQ6MojNEp9QjrKXdJJDnRratvjmAbiKiK7UttiwQWD8S0K4l9mngE1iaHQVB7+QzAWMZY4xvsGupZ8IEqKlJZTNNnCcgF4oYpFT6McpbiJQqzY28usw+MXKTqfACWA80fu70/YYSortrjcQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UyoFesxE; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460969c49f2so331511cf.0
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 08:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732206748; x=1732811548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KinxbNGywfMnxHwtq/MrCSYbQ52bStWS5PDW/rvFKDU=;
        b=UyoFesxE9cDB7mn3kizkXDUJUgVZl4iK/Ehl0kua6JRvLUfsVTibYxJKpa+KEjKRme
         b6OKsHSb2We7Ewtih4a5V5KHHX3gzuIlDEPPwdPYe29lfcJHR1MGijV+DSuMWqLeXQTt
         VfN38AyAOUdsidX08ezXwa+UV1FnQAqtyuw1QjBo5XalOg9NpB7CjkFD4fZL/N/bzztm
         KJ5k0toPx5p7VBnCvysRqeUgdAaW+uO3jUgCaDj9fDcGbNOYvMh1IoNKK0FKVYFQOdJB
         yw33w9TyTOtwVQfy5hv3xuMs0KtGHunY1PeIgJ1Cs5El4uNcAuzMh9FLbbBG105VONPI
         gvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732206748; x=1732811548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KinxbNGywfMnxHwtq/MrCSYbQ52bStWS5PDW/rvFKDU=;
        b=FnXpbysZ1srvBsVENcRYqVYiUWs2EjNY2Yz4m1UbWpeb56K2grrs4RvCO1ROU4/f7A
         q93w4CQ3WGk0zhF29t8XWcAai5ULt7DPShPl9McsBbe7U6QJUPN+bFwjvsCUX/e+5B02
         1TxyqjcMc6qFn91/BdD8gVKJHr4bDqeSUzqEzd//JMDfQucN2oUnSXU4FoTNtYNhDtSm
         HZewKm90GpgY93yIxvCD4uRTH8WaXDP5IwfylYhyJ1oR3NcHevZ0EtBrnmTQE0LGJ27o
         iks8RwM0qz/QE3B3YlBu/zdKGbTviBkPw39PGG+90TeMERwEeFZnGIBs8a+zJkdp5AEk
         VzBw==
X-Forwarded-Encrypted: i=1; AJvYcCVUnby9GeYDHa1OcTcCnp04iJYQZrbKukr3fENk2kyKoyRRGG3FLUM6CKqVkGWbnPIyJP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkcnsQU6S/jecYRjjllxFO0pAHe7ioxJIEo8m91fnDEUpMO8vr
	F5TqHO4aqCpcnO67JE8v3YyNJpVg4lyB02MuWE7EVtCKtUumyicCJnY8cpKBO9YaTYRXcUEcmhD
	UkguqBKTYKDWuID6iG2npWrmkUuNj8mzGZKni
X-Gm-Gg: ASbGncvyMKmfgyPVcJ3CAmK7T4Rs60X5PO23DdvkboCE5+FYhNdhhWIZQroWI2BzdCR
	91Y+fKuk0gBDZZnnlAjlfmlBnPkRDT0Svzo7KPgG6aPU7n3eniIL+U47RfEqy
X-Google-Smtp-Source: AGHT+IEAnK3ZNayNZX1MZKPWNaHHSfD9Gcs0HsfhavIX8PgOJ4JyzfKBkGAXcCXM+vNSiBpmS2gA+HMqANSVxnOf0r0=
X-Received: by 2002:a05:622a:1aaa:b0:465:31d8:6f1a with SMTP id
 d75a77b69052e-4653bd85a6emr194851cf.23.1732206747600; Thu, 21 Nov 2024
 08:32:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028010818.2487581-1-andrii@kernel.org> <20241028010818.2487581-3-andrii@kernel.org>
 <20241121144442.GL24774@noisy.programming.kicks-ass.net> <20241121152257.GN38972@noisy.programming.kicks-ass.net>
 <CAJuCfpE04MtnmRR+JYpYqC07-u9yXRUF0FB2mSaQatzwSkNNdw@mail.gmail.com>
In-Reply-To: <CAJuCfpE04MtnmRR+JYpYqC07-u9yXRUF0FB2mSaQatzwSkNNdw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 21 Nov 2024 08:32:16 -0800
Message-ID: <CAJuCfpHpDtis0+KwcUCb5oAbjNmgCtJB=K18Jr=MMRRE=Mkaig@mail.gmail.com>
Subject: Re: [PATCH v4 tip/perf/core 2/4] mm: Introduce mmap_lock_speculation_{begin|end}
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, 
	mhocko@kernel.org, vbabka@suse.cz, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	arnd@arndb.de, richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, 
	linmiaohe@huawei.com, viro@zeniv.linux.org.uk, hca@linux.ibm.com, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 7:36=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Nov 21, 2024 at 7:23=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Thu, Nov 21, 2024 at 03:44:42PM +0100, Peter Zijlstra wrote:
> >
> > > But perhaps it makes even more sense to add this functionality to
> > > seqcount itself. The same argument can be made for seqcount_mutex and
> > > seqcount_rwlock users.
> >
> > Something like so I suppose.
>
> Ok, let me put this all together. Thanks!

I posted the new version at
https://lore.kernel.org/all/20241121162826.987947-1-surenb@google.com/
The changes are minimal, only those requested by Peter, so hopefully
they can be accepted quickly.

>
> >
> > ---
> > diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> > index 5298765d6ca4..102afdf8c7db 100644
> > --- a/include/linux/seqlock.h
> > +++ b/include/linux/seqlock.h
> > @@ -318,6 +318,28 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    t=
rue,     mutex)
> >         __seq;                                                         =
 \
> >  })
> >
> > +/**
> > + * raw_seqcount_try_begin() - begin a seqcount_t read critical section
> > + *                            w/o lockdep and w/o counter stabilizatio=
n
> > + * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variant=
s
> > + *
> > + * Very like raw_seqcount_begin(), except it enables eliding the criti=
cal
> > + * section entirely if odd, instead of doing the speculation knowing i=
t will
> > + * fail.
> > + *
> > + * Useful when counter stabilization is more or less equivalent to tak=
ing
> > + * the lock and there is a slowpath that does that.
> > + *
> > + * If true, start will be set to the (even) sequence count read.
> > + *
> > + * Return: true when a read critical section is started.
> > + */
> > +#define raw_seqcount_try_begin(s, start)                              =
 \
> > +({                                                                    =
 \
> > +       start =3D raw_read_seqcount(s);                                =
   \
> > +       !(start & 1);                                                  =
 \
> > +})
> > +
> >  /**
> >   * raw_seqcount_begin() - begin a seqcount_t read critical section w/o
> >   *                        lockdep and w/o counter stabilization

