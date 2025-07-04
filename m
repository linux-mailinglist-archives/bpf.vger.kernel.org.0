Return-Path: <bpf+bounces-62360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EEDAF8557
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 03:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236DF1C83E3C
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 01:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7019D1DB377;
	Fri,  4 Jul 2025 01:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Czazct81"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7F01D435F;
	Fri,  4 Jul 2025 01:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751594151; cv=none; b=kMcl9/o9XJzdoY/AbWfvzcvqNUQ5EVOSv3gaP1VHf00rlZvY2fu+Ohu0QJkabxlOuA2vY1MNSBuYUIG4E4ipk04EWDBm86bTxHeKZ/mjFZqEVOUC6i7YhpWeAozAMjDbKu3fMOeeVBAxE5estTylK7stSh0xi7mbY64HHsGdcuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751594151; c=relaxed/simple;
	bh=pEmultk1+nA9RFvBXCqP9a+ME0lOAljA1PBudD8BF/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xf1+BM6RKsevW2nOETkP7LGq2DypylktCxLKWcgSi8Ne/djex4xh1i03nbVfhYB4brKbgS5MGmMIzuvDHh5LueKpRWdVUleWC2nB310AkYFXAFpO5HAillEGueviVjVGYWAmiORo49J8uAaOfNsHKWlYVL6V6Wxnd/MhwEk/5Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Czazct81; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-70e4b1acf41so3102457b3.3;
        Thu, 03 Jul 2025 18:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751594147; x=1752198947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3t22VweNcncjSb+FjN88apfoRhZQMQ+5wCq+oYE+aY=;
        b=Czazct81QjkC1p8l/P9kk2IlCbu97r5ZLXeYL86dxyzb2r4YVaKuMQkpLdmpjUKEZQ
         hiVMtESaUtcbWFAvzyFvoe9eaFWmWkOYdTneT8jK+H7qSBCGO65Xh5QShgLkrolLDqju
         1JgPe/79bdf9j1Hk3FD9hNbTJRs2CLDxuQwAPZNBUl0FVZVr2Ma50Et6e6RPlKuhDT7L
         +MvSeSFXFMqxhXVoTbJirCTCm8JOd+uz/k84SH+O2GyJVHG1Eo6aLitaLjqM7zNAiWFG
         cIfeeDI0RG9N3sXZmNx2zK3uJP+exN/bJWKvU/PiQfUVpRfzTr1WWgsgRG4ZKHdA/d76
         GkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751594147; x=1752198947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3t22VweNcncjSb+FjN88apfoRhZQMQ+5wCq+oYE+aY=;
        b=b8ra3rz6EYhlAwgDAYE6SYRv9Ol7VmhpIRNDvuRkLVYOof644TrLTXPs2gl/C5ARm+
         MWOrmLgZk+BvM0zuA8EV+CJq0L7quBhnTtl/CGDxwQPe+ogZNNiauDnhIJ5E+XJJ0nNV
         l1Tb7jbk1gwyqEf3q1JWFZzDd1A6o7sOfTfMv2UICcF+AjX4zfRiBSjn4phBPE1iBIoi
         kXg3itQe5fcjQOdesbexUcWZ4pdavzWsDMgKL9X853U287FXvmqFsKfUB2MUYuqAVrHV
         Uk2r+ACalTNV4rZbbgM0MKgmqntE+ot49klkNrXx947zcA055SQiI3qLLvq5TFS5+by5
         MQ8A==
X-Forwarded-Encrypted: i=1; AJvYcCU6VwIXBqzVLC+supkSqUms2Wl16yLRHUpGmU4OYN1b3sl7JPQt8lluhR1SiiQvKUmc/SGsqvHhoGU6H+Gq@vger.kernel.org, AJvYcCVGJw9VlhUqUJQSfrZyxiI8GMgeV48wt3MHFB6p6MPkNPcNdmbkiaC8KO68L9Qf9hYQMuJvS+RUkGDkoBpboXOn9D0y@vger.kernel.org, AJvYcCWdAdPE3X+MhcA0L5XuVWdc5hN4mdl/kBbrX1Ojh0HQaITJ6/gc7fkAXAk1s1XHRHS/ATA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTkMfhdWCjlv8MGv8ewaMtN7wvUxXlLmHVrqb4hw2wIuZ8NPSE
	yNADTHv1ALfMXwlFFXFEr6TSHbfpnFBjhzM8Z35bWcIkHHSFSTu250gOz3ORuYjYzf9ld5Y+nYu
	rkLgtUw2Afch3BudkeyBQUhbifhKry4g=
X-Gm-Gg: ASbGncvVLQrdisRVDWbGgnXt4PYRdGf8TuSPedlBawkIFPrVoyJ4j2dO+xmxLIFdfVH
	RwKTf1xYu1n/8+iw0ns9PofSWZi+ZZMlEOdfyNGOqxYt4W/JB9KV9w8VAbcwzlMtnms6RHTNfPh
	cmC66K2HWbYGkZrM1eU5BMDieXxWzeX9pmlr9tb3P2k0GjKJSbwAZpVg==
X-Google-Smtp-Source: AGHT+IETX3bvK8Zz6/tsilCbxIkhUiTOLt/IN6Dq7aGcr5MTUyfwgfYHXP8yeEsK4R4WmY0KZFI5mZGiA1NP3jW6hLU=
X-Received: by 2002:a05:690c:61c6:b0:70e:6333:64ac with SMTP id
 00721157ae682-71668d1e097mr12522037b3.10.1751594147537; Thu, 03 Jul 2025
 18:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-5-dongml2@chinatelecom.cn> <20250703113001.099dc88f@batman.local.home>
In-Reply-To: <20250703113001.099dc88f@batman.local.home>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 4 Jul 2025 09:54:52 +0800
X-Gm-Features: Ac12FXwq6zqBA6J8CY03lyhoFOurtKEYrBP813PzdawmrPY4ACc9V7Au-lp8Z9M
Message-ID: <CADxym3YaHGxQ7AORGka1CV+KpnPOknohP9a6zi=3RSPXYBKC-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 04/18] ftrace: add reset_ftrace_direct_ips
To: Steven Rostedt <rostedt@goodmis.org>
Cc: alexei.starovoitov@gmail.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	Menglong Dong <dongml2@chinatelecom.cn>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 11:30=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu,  3 Jul 2025 20:15:07 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
>
> Note, the tracing subsystem uses capitalization in the subject:
>
>   ftrace: Add reset_ftrace_direct_ips

Hi, Steven. Thanks for your feedback. I'll keep this point
in mind. I was wondering why Alexei changed the "make" to "Make"
in c11f34e30088 :/

>
>
> > For now, we can change the address of a direct ftrace_ops with
> > modify_ftrace_direct(). However, we can't change the functions to filte=
r
> > for a direct ftrace_ops. Therefore, we introduce the function
> > reset_ftrace_direct_ips() to do such things, and this function will res=
et
> > the functions to filter for a direct ftrace_ops.
> >
> > This function do such thing in following steps:
> >
> > 1. filter out the new functions from ips that don't exist in the
> >    ops->func_hash->filter_hash and add them to the new hash.
> > 2. add all the functions in the new ftrace_hash to direct_functions by
> >    ftrace_direct_update().
> > 3. reset the functions to filter of the ftrace_ops to the ips with
> >    ftrace_set_filter_ips().
> > 4. remove the functions that in the old ftrace_hash, but not in the new
> >    ftrace_hash from direct_functions.
>
> Please also include a module that can be loaded for testing.
> See samples/ftrace/ftrace-direct*
>
> But make it a separate patch. And you'll need to add a test in selftests.
> See tools/testing/selftests/ftrace/test.d/direct

Okay!

>
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  include/linux/ftrace.h |  7 ++++
> >  kernel/trace/ftrace.c  | 75 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 82 insertions(+)
> >
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index b672ca15f265..b7c60f5a4120 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -528,6 +528,8 @@ int modify_ftrace_direct_nolock(struct ftrace_ops *=
ops, unsigned long addr);
> >
> >  void ftrace_stub_direct_tramp(void);
> >
> > +int reset_ftrace_direct_ips(struct ftrace_ops *ops, unsigned long *ips=
,
> > +                         unsigned int cnt);
> >  #else
> >  struct ftrace_ops;
> >  static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
> > @@ -551,6 +553,11 @@ static inline int modify_ftrace_direct_nolock(stru=
ct ftrace_ops *ops, unsigned l
> >  {
> >       return -ENODEV;
> >  }
> > +static inline int reset_ftrace_direct_ips(struct ftrace_ops *ops, unsi=
gned long *ips,
> > +                                       unsigned int cnt)
> > +{
> > +     return -ENODEV;
> > +}
> >
> >  /*
> >   * This must be implemented by the architecture.
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index f5f6d7bc26f0..db3aa61889d3 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -6224,6 +6224,81 @@ int modify_ftrace_direct(struct ftrace_ops *ops,=
 unsigned long addr)
> >       return err;
> >  }
> >  EXPORT_SYMBOL_GPL(modify_ftrace_direct);
> > +
> > +/* reset the ips for a direct ftrace (add or remove) */
>
> As this function is being used externally, it requires proper KernelDoc
> headers.

Okay!

>
> What exactly do you mean by "reset"?

It means to reset the filter hash of the ftrace_ops to ips. In
the origin logic, the filter hash of a direct ftrace_ops will not
be changed. However, in the tracing-multi case, there are
multi functions in the filter hash and can change. This function
is used to change the filter hash of a direct ftrace_ops.

>
> > +int reset_ftrace_direct_ips(struct ftrace_ops *ops, unsigned long *ips=
,
> > +                         unsigned int cnt)
> > +{
> > +     struct ftrace_hash *hash, *free_hash;
> > +     struct ftrace_func_entry *entry, *del;
> > +     unsigned long ip;
> > +     int err, size;
> > +
> > +     if (check_direct_multi(ops))
> > +             return -EINVAL;
> > +     if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
> > +             return -EINVAL;
> > +
> > +     mutex_lock(&direct_mutex);
> > +     hash =3D alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> > +     if (!hash) {
> > +             err =3D -ENOMEM;
> > +             goto out_unlock;
> > +     }
> > +
> > +     /* find out the new functions from ips and add to hash */
>
> Capitalize comment: /* Find out ...
>
> > +     for (int i =3D 0; i < cnt; i++) {
> > +             ip =3D ftrace_location(ips[i]);
> > +             if (!ip) {
> > +                     err =3D -ENOENT;
> > +                     goto out_unlock;
> > +             }
> > +             if (__ftrace_lookup_ip(ops->func_hash->filter_hash, ip))
> > +                     continue;
> > +             err =3D __ftrace_match_addr(hash, ip, 0);
> > +             if (err)
> > +                     goto out_unlock;
> > +     }
> > +
> > +     free_hash =3D direct_functions;
>
> Add newline.
>
> > +     /* add the new ips to direct hash. */
>
> Again capitalize.
>
> > +     err =3D ftrace_direct_update(hash, ops->direct_call);
> > +     if (err)
> > +             goto out_unlock;
> > +
> > +     if (free_hash && free_hash !=3D EMPTY_HASH)
> > +             call_rcu_tasks(&free_hash->rcu, register_ftrace_direct_cb=
);
>
> Since the above is now used more than once, let's make it into a helper
> function so that if things change, there's only one place to change it:
>
>         free_ftrace_direct(free_hash);
>
> static inline void free_ftrace_direct(struct ftrace_hash *hash)
> {
>         if (hash && hash !=3D EMPTY_HASH)
>                 call_rcu_tasks(&free_hash->rcu, register_ftrace_direct_cb=
);
> }

Sounds nice~

>
> > +
> > +     free_ftrace_hash(hash);
> > +     hash =3D alloc_and_copy_ftrace_hash(FTRACE_HASH_DEFAULT_BITS,
> > +                                       ops->func_hash->filter_hash);
> > +     if (!hash) {
> > +             err =3D -ENOMEM;
> > +             goto out_unlock;
> > +     }
> > +     err =3D ftrace_set_filter_ips(ops, ips, cnt, 0, 1);
> > +
> > +     /* remove the entries that don't exist in our filter_hash anymore
> > +      * from the direct_functions.
> > +      */
>
> This isn't the network subsystem, we use the default comment style for mu=
ltiple lines:
>
> /*
>  * line 1
>  * line 2
>  * ...
>  */

Okay! I'll do the modification as your comment in this (and other)
patches.

Thanks!
Menglong Dong

>
> -- Steve
>
> > +     size =3D 1 << hash->size_bits;
> > +     for (int i =3D 0; i < size; i++) {
> > +             hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> > +                     if (__ftrace_lookup_ip(ops->func_hash->filter_has=
h, entry->ip))
> > +                             continue;
> > +                     del =3D __ftrace_lookup_ip(direct_functions, entr=
y->ip);
> > +                     if (del && del->direct =3D=3D ops->direct_call) {
> > +                             remove_hash_entry(direct_functions, del);
> > +                             kfree(del);
> > +                     }
> > +             }
> > +     }
> > +out_unlock:
> > +     mutex_unlock(&direct_mutex);
> > +     if (hash)
> > +             free_ftrace_hash(hash);
> > +     return err;
> > +}
> >  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
> >
> >  /**
>

