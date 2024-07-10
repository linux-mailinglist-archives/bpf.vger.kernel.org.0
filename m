Return-Path: <bpf+bounces-34400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC2792D4C2
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 17:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559F9284522
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 15:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3554E194131;
	Wed, 10 Jul 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YseaIVg4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1E218787A;
	Wed, 10 Jul 2024 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720624470; cv=none; b=ryv6IVwQO5Wz8Zr4/1shPjnVCtbb2Xh+P2BDXAgFvGa1JAukN4TihwRKT+YIH1ZNlNyyEQN0/PzWqY4wsOVNgBeueQJY1oB8ColP/e34TzMF9OQziwu7Tix6TQqx1wbnZBAWNn9GbZDKR0RalGu1OODwqXkTT4xn3eMLj/Hg95s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720624470; c=relaxed/simple;
	bh=UrbByBksEGd+eZN60frnExNhYd+ywJzm4Do45Eb5hq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMaosm2qLj+IjRAEsHVPu98DtKTHuO1+JCi9QPaeqp3EbMQAhNlLd7PnHwvuZujLNkjKOZ/mr6ewrtJsRHJof8kuGM27WGKZ/YP7T7BrCv2eY17fEZ0v3UAWNC7pLhKB82Xqmv7CCxWSKT8aLRour0ogrOC0lUnQrN1vDnfDAKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YseaIVg4; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77c25beae1so711467566b.2;
        Wed, 10 Jul 2024 08:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720624467; x=1721229267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FP9XHDkE847XSteYtGeQXsUShUZifWlfXE9dC/r6b4=;
        b=YseaIVg48fSUXwUB+MU4WMzrW2ON66ld0b55rvT5aS5wSbPkrQhOpREpVPzJu7EvBk
         fR+H6vc7kLt9hNIW4mlJxr6GR3UrBf2Hl//bPA4rIMo2IZJGoLtHja+VzPMqr+yG4GzT
         TCOOVxnuBHkpQVNcLme1T+yVztMZuZhC5x7l3ayEvsQZneeD2QTg4q//hL9t/Q4JbLMC
         SFy81VVr/l7RVTkTqeXcKosgSpKzZ/IRJLvAkTWFy+7AXklnOCc4IXl20WS8WkNd2kEF
         0QxmUj251qCV61l2UYHCXGalpXDw39MyulmxEbwQou219RDumY5fCZY9A7gQTcEoiW6B
         wKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720624467; x=1721229267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FP9XHDkE847XSteYtGeQXsUShUZifWlfXE9dC/r6b4=;
        b=vK2mckctnpEBuGE3IFJLm8kjjY4xGei+BYkwWh6oOBVKQpwVdUHflAkNG2ZjAFNDby
         gzqy1FMI4oxBXq1pyUkQJ2rulGsZjxwmPaEOC0p+AqBCzxi7y5HU4ETrq+GEiXEyB35w
         2HV8+EfFL/AzTMmXbIqcuV/CZQ2BCjMobgsrh2AMzl/Cu0q3evRfzA9PrkVdHrmGjQpI
         beRuvTcUPveI4gJBOLy20BjTTl5amJOZtXSEAWIhBBrRCP/6q5c2UZJfAnGJ5uVrGgbG
         4oQOawJM/8wRriGNq8s8Z2ySzT0Br5G/JdnugvX0i2YkSIsHKZzl4ro5wUBlfr3h3/jH
         QG2w==
X-Forwarded-Encrypted: i=1; AJvYcCVya473d9c1aVwoDx++4NDlyHADqKTuGFy2XQbYyVQLswAV0Qo7YUMTtC1l+IikP+98OUaOQjDFV0DbbMCtQf1TLB+6e2E7spzGAjdXcfAnzaR626/ZWFjgN4NVeDgeO+7s5fgiADgT
X-Gm-Message-State: AOJu0YzphCtncod7RC1cDnVR5ClRtI4UX8mNHDzrlFkA7gJ/aXNxws2p
	Zw/LksCCO2cGjm+690Q17jK4CgSRqIk/ziClNVbdLetoJYVUaF9fTufEEbW9SSr9rNtTVuot+oR
	B2DPWux4cIYObWz7RWnbSAYkiE4g=
X-Google-Smtp-Source: AGHT+IGZfnEJuGTgH9DTC+FizTzB0QXdloA9vZ/oMq8M5hXxP7kM3pc8s5xpnpn7gxkuujvthkgFDMxtiaTxBY2c5So=
X-Received: by 2002:a17:906:480d:b0:a77:c364:c4eb with SMTP id
 a640c23a62f3a-a780b6b164cmr350408466b.20.1720624467202; Wed, 10 Jul 2024
 08:14:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701223935.3783951-1-andrii@kernel.org> <20240701223935.3783951-2-andrii@kernel.org>
 <20240703113829.GA28444@redhat.com> <20240710133112.GA9228@redhat.com>
In-Reply-To: <20240710133112.GA9228@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jul 2024 08:14:12 -0700
Message-ID: <CAEf4BzYDPqVDkyt_Jagn8sRn_J7+f6eM1_H6o0T6-VpXbv6k-Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] uprobes: update outdated comment
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 6:33=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 07/03, Oleg Nesterov wrote:
> >
> > >     /*
> > > -    * The NULL 'tsk' here ensures that any faults that occur here
> > > -    * will not be accounted to the task.  'mm' *is* current->mm,
> > > -    * but we treat this as a 'remote' access since it is
> > > -    * essentially a kernel access to the memory.
> > > +    * 'mm' *is* current->mm, but we treat this as a 'remote' access =
since
> > > +    * it is essentially a kernel access to the memory.
> > >      */
> > >     result =3D get_user_pages_remote(mm, vaddr, 1, FOLL_FORCE, &page,=
 NULL);
> >
> > OK, this makes it less confusing, so
> >
> > Acked-by: Oleg Nesterov <oleg@redhat.com>
> >
> > ---------------------------------------------------------------------
> > but it still looks confusing to me. This code used to pass tsk =3D NULL
> > only to avoid tsk->maj/min_flt++ in faultin_page().
> >
> > But today mm_account_fault() increments these counters without checking
> > FAULT_FLAG_REMOTE, mm =3D=3D current->mm, so it seems it would be bette=
r to
> > just use get_user_pages() and remove this comment?
>
> Well, yes, it still looks confusing, imo.
>
> Andrii, I hope you won't mind if I redo/resend this and the next cleanup?
>
> The next one only updates the comment above uprobe_write_opcode(), but
> it would be nice to explain mmap_write_lock() in register_for_each_vma().
>

I don't mind a bit, thanks for sending the patches!

> Oleg.
>
>

