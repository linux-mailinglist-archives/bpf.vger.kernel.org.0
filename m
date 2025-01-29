Return-Path: <bpf+bounces-50041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E885DA222F4
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 18:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A6BB7A149D
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 17:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F511E0B74;
	Wed, 29 Jan 2025 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPw+KBPd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB6028EB;
	Wed, 29 Jan 2025 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738171682; cv=none; b=Gd9Uz7/lBQ4eCNMLoS4pqVJz1TTLv4UreQ/hTdlBWnbjn6avBOcPDTHfubfZXU7KubxyC++me1j+mQE+NvzOCOXrYdVN7M6FP27iE0K5uNDE7SzZ7jt84m0Two5oGKMZ7/RRWR1+BjmIcjNTlSW4rSBAopAZhBtYSBo5Ib3ulqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738171682; c=relaxed/simple;
	bh=yZW1QwC+l0JQ5TqrVAhLNEjfHoq71wxzLMEz3t23Kf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDFEPIY+Z6G28J/lbnz0lfouV5tTnirgNKSCGL+goaHLaG/Vw6GPKw51Xoy8YByskOi6NcN1OjuSSuUmb5MQeYGmD1Cww9SqUFy1c+dJ818tU6eWyr/YV99keigmAEYlmH1w1DwegUoalF3wsVnfvvyT/jh9HAWQnrNXabXTaY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPw+KBPd; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71e2aa8d5e3so3780935a34.2;
        Wed, 29 Jan 2025 09:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738171679; x=1738776479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9DYF2bVd2WYr3RnZr8LmxQYUCwZNVcKB83e7JFc1AU=;
        b=BPw+KBPdX9lVBePQBkwJTz90LP6xd8PDwtsQmSvFrN8xmd/GQO8XG+cgmlc6T6t5/J
         5ijCOybrg0cepi3l1YTRLGh89lJ7/1QLkPyHUkoqvinek/BZiYz3JHMHbXn4i8xdfcTa
         2En3kl+W40vioR4dmj3kICA7dK2Kw43OVmuItpD4eAL/h0cF9s6syH/LGuQP1e/kIDnQ
         bz0vCNrLoBsCyjLf2yPRCkFch6w3Cizug3uKuexcaHD8h+MBnC20HgwJbGsZwT3R60Ga
         hEDMhrZ5qCWTKr0+UQXKRzcPH4rjwv7KOYd9Tf5tHWFIAX9Zd+rT3+oRXZ9SVJnviP+v
         fk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738171679; x=1738776479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9DYF2bVd2WYr3RnZr8LmxQYUCwZNVcKB83e7JFc1AU=;
        b=P6Bo6ivhEPea1eOcj2H9b5hoy02SlHFyFC9fR3w62+mKopSgrhOxGw4j0+0ADkK0sS
         w0FSkMLEJmg3qSio69Ek6N+PqwrGzn6B9DS82lPzuBTQ4WMLaQfARfQxO6hHBI9Wrmx4
         RCtAEc4RmHeTbUsxNdePWfHR8tFVGKwQeRKAvHrMT1b84Pu3j95YP/lB4eoSine3Fbzl
         sY6MWzV7XutObdCCuQI6o7ZZmXnM+yAqA+OPk3Vj4MkNCo+0uy84PioIT13ZNroy8JRY
         KgOJajfJMGY9ZQT9A/CPpGXdX4hALtSBGbK6yBTWxt3sU8q+9ORIrHCcWKx1ZJ9t0EWA
         K6zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyV+LDbBFJfnFjhwKHN5HY4/9HZsWm61pzil7YB2TlARAjK4yFQPf5eJSHwTdZYFavqq8=@vger.kernel.org, AJvYcCX+4ur8V3G3JZQBCg48x6BsbtTUQNsvzZm9n/aZRIIYh+yGTii91ufKDNi0rMYY4rYAQ+5ZDO29+R2yh/7T@vger.kernel.org, AJvYcCXknOL39obAFKT1MdCPWsze1nCFfs2E/kaET8827NwGShyAmTIKkVc1e/Exo831dfynyY8zYFCMAaQf@vger.kernel.org, AJvYcCXlBeiragPKzcDjXx9XMUBAmAgW1VAOwWTYZgME5Bzwr3bCiKphtYTtQUMQG9JU0LPFnnwjY6OK@vger.kernel.org, AJvYcCXsfzakpYXrJs+zZGufs7Z0Hs6McMJSXrFcSqXh/dD4OFmHBsypSU/G1I3enkUkY98Rs1pp8mG9MC9NTZenLlzQR0Wl@vger.kernel.org
X-Gm-Message-State: AOJu0YyGtVJB+oFPhwXWotRDWIev1Xci0Lj/2o1NFY64NY0dS2LFEXvX
	OZkCKLdwajRz4zu93czkYMn8BX3coqATbFeytECSSJe8MzdBlXPBy14tHoDVFro59rNlNPwpOpI
	II92OLtcJBy2p5jOMOfT8BoAvnxw=
X-Gm-Gg: ASbGncslzMp22MgbT+5Z0mPfbTQxMqxusnRffi3QP0TGLYSwJQQ6yA+WXujPL1q9v7/
	d6yIcMgIZt4AzEYEsVQ37/l5E1PVB36O0563+6uFI5rMOKCIi2CKWG6kVDoQbzgGX0mHtnp8xAu
	l0zEKvUtw=
X-Google-Smtp-Source: AGHT+IF1pXcGoJP6dVTYq0ejDryQaqkzioP0ZZgGSRGq8urNRacRLo/NAEqFz4POQb6pGT8s0i/QpSW2hsT7dCKY1jE=
X-Received: by 2002:a05:6871:8112:b0:29e:6ae2:442 with SMTP id
 586e51a60fabf-2b32f45dbdcmr2149959fac.32.1738171679347; Wed, 29 Jan 2025
 09:27:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128145806.1849977-1-eyal.birger@gmail.com> <202501281634.7F398CEA87@keescook>
In-Reply-To: <202501281634.7F398CEA87@keescook>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Wed, 29 Jan 2025 09:27:49 -0800
X-Gm-Features: AWEUYZmCw0iV7STxf7CnZJL9uiMoGQeT-yPO8VpRtz--JZkEalZYokGfejTEU88
Message-ID: <CAHsH6Gsv3DB0O5oiEDsf2+Go4O1+tnKm-Ab0QPyohKSaroSxxA@mail.gmail.com>
Subject: Re: [PATCH v2] seccomp: passthrough uretprobe systemcall without filtering
To: Kees Cook <kees@kernel.org>
Cc: luto@amacapital.net, wad@chromium.org, oleg@redhat.com, 
	mhiramat@kernel.org, andrii@kernel.org, jolsa@kernel.org, 
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net, 
	ast@kernel.org, andrii.nakryiko@gmail.com, rostedt@goodmis.org, rafi@rbk.io, 
	shmulik.ladkani@gmail.com, bpf@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the review!

On Tue, Jan 28, 2025 at 5:41=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Jan 28, 2025 at 06:58:06AM -0800, Eyal Birger wrote:
> > Note: uretprobe isn't supported in i386 and __NR_ia32_rt_tgsigqueueinfo
> > uses the same number as __NR_uretprobe so the syscall isn't forced in t=
he
> > compat bitmap.
>
> So a 64-bit tracer cannot use uretprobe on a 32-bit process? Also is
> uretprobe strictly an x86_64 feature?
>

My understanding is that they'd be able to do so, but use the int3 trap
instead of the uretprobe syscall.

> > [...]
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index 385d48293a5f..23b594a68bc0 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -734,13 +734,13 @@ seccomp_prepare_user_filter(const char __user *us=
er_filter)
> >
> >  #ifdef SECCOMP_ARCH_NATIVE
> >  /**
> > - * seccomp_is_const_allow - check if filter is constant allow with giv=
en data
> > + * seccomp_is_filter_const_allow - check if filter is constant allow w=
ith given data
> >   * @fprog: The BPF programs
> >   * @sd: The seccomp data to check against, only syscall number and arc=
h
> >   *      number are considered constant.
> >   */
> > -static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
> > -                                struct seccomp_data *sd)
> > +static bool seccomp_is_filter_const_allow(struct sock_fprog_kern *fpro=
g,
> > +                                       struct seccomp_data *sd)
> >  {
> >       unsigned int reg_value =3D 0;
> >       unsigned int pc;
> > @@ -812,6 +812,21 @@ static bool seccomp_is_const_allow(struct sock_fpr=
og_kern *fprog,
> >       return false;
> >  }
> >
> > +static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
> > +                                struct seccomp_data *sd)
> > +{
> > +#ifdef __NR_uretprobe
> > +     if (sd->nr =3D=3D __NR_uretprobe
> > +#ifdef SECCOMP_ARCH_COMPAT
> > +         && sd->arch !=3D SECCOMP_ARCH_COMPAT
> > +#endif
>
> I don't like this because it's not future-proof enough. __NR_uretprobe
> may collide with other syscalls at some point.

I'm not sure I got this point.

> And if __NR_uretprobe_32
> is ever implemented, the seccomp logic will be missing. I think this
> will work now and in the future:
>
> #ifdef __NR_uretprobe
> # ifdef SECCOMP_ARCH_COMPAT
>         if (sd->arch =3D=3D SECCOMP_ARCH_COMPAT) {
> #  ifdef __NR_uretprobe_32
>                 if (sd->nr =3D=3D __NR_uretprobe_32)
>                         return true;
> #  endif
>         } else
> # endif
>         if (sd->nr =3D=3D __NR_uretprobe)
>                 return true;
> #endif

I don't know if implementing uretprobe syscall for compat binaries is
planned or makes sense - I'd appreciate Jiri's and others opinion on that.
That said, I don't mind adding this code for the sake of future proofing.

>
> Instead of doing a function rename dance, I think you can just stick
> the above into seccomp_is_const_allow() after the WARN().

My motivation for the renaming dance was that you mentioned we might add
new syscalls to this as well, so I wanted to avoid cluttering the existing
function which seems to be well defined.

>
> Also please add a KUnit tests to cover this in
> tools/testing/selftests/seccomp/seccomp_bpf.c

I think this would mean that this test suite would need to run as
privileged. Is that Ok? or maybe it'd be better to have a new suite?

> With at least these cases combinations below. Check each of:
>
>         - not using uretprobe passes
>         - using uretprobe passes (and validates that uretprobe did work)
>
> in each of the following conditions:
>
>         - default-allow filter
>         - default-block filter
>         - filter explicitly blocking __NR_uretprobe and nothing else
>         - filter explicitly allowing __NR_uretprobe (and only other
>           required syscalls)

Ok.

>
> Hm, is uretprobe expected to work on mips? Because if so, you'll need to
> do something similar to the mode1 checking in the !SECCOMP_ARCH_NATIVE
> version of seccomp_cache_check_allow().

I don't know if uretprobe syscall is expected to run on mips. Personally
I'd avoid adding this dead code.

>
> (You can see why I really dislike having policy baked into seccomp!)

I definitely understand :)

>
> > +        )
> > +             return true;
> > +#endif
> > +
> > +     return seccomp_is_filter_const_allow(fprog, sd);
> > +}
> > +
> >  static void seccomp_cache_prepare_bitmap(struct seccomp_filter *sfilte=
r,
> >                                        void *bitmap, const void *bitmap=
_prev,
> >                                        size_t bitmap_size, int arch)
> > @@ -1023,6 +1038,9 @@ static inline void seccomp_log(unsigned long sysc=
all, long signr, u32 action,
> >   */
> >  static const int mode1_syscalls[] =3D {
> >       __NR_seccomp_read, __NR_seccomp_write, __NR_seccomp_exit, __NR_se=
ccomp_sigreturn,
> > +#ifdef __NR_uretprobe
> > +     __NR_uretprobe,
> > +#endif
>
> It'd be nice to update mode1_syscalls_32 with __NR_uretprobe_32 even
> though it doesn't exist. (Is it _never_ planned to be implemented?) But
> then, maybe the chances of a compat mode1 seccomp process running under
> uretprobe is vanishingly small.

It seems to me very unlikely. BTW, when I tested the "strict" mode change
my program was killed by seccomp. The reason wasn't the uretprobe syscall
(which I added to the list), it was actually the exit_group syscall which
libc uses instead of the exit syscall.

Thanks again,
Eyal.

