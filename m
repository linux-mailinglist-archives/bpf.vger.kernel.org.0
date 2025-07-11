Return-Path: <bpf+bounces-62992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCCAB010CD
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 03:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85271AA80BC
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 01:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166B984D02;
	Fri, 11 Jul 2025 01:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8EavvGU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9035E6F073;
	Fri, 11 Jul 2025 01:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752197270; cv=none; b=Dz4U2zMUaxouyO8dIZwcDQlpjXGGZWGQcjFJQkWAFv4AsZdHsC3nlolKbAimig49+kwfC0S72B56EhiPi3YcsGeMrUnnLaB95lb2uEDG2pfisnPi1LoK2sTQIpv4InPvAE5kX008U5vlQNMqTrjU7jhaFizJIcR8i7EUoJPg0cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752197270; c=relaxed/simple;
	bh=HFS+1dLZCMXLbRXybWkTOfr7F8qCGRXS+XIjE566oZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrSmENRorONL6Pz1fj9hXoPP25Ilw3IV1TpmX/FmAud8cYk0O7kShHXuDce32IMp/w5gPALVG5hG3e0OgUDmdDSDYJaeVHVVxBPi3HzMeG8tY4fySazhaa9+VdSegtEO1pAs/0ydIdzTXkAYpNrJgKk1soCqddARVPQx3deSRQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8EavvGU; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-70e767ce72eso15828687b3.1;
        Thu, 10 Jul 2025 18:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752197267; x=1752802067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KG9lxpLURaWwhvz42ij9wTJRd68a4iePoTZxhClKIzI=;
        b=f8EavvGUTzmlNo2nVtCahPKM1lCenuGT8JUbFjJc+niObPcSTu0FuGGX5hzMW5oSeR
         Esd+IEzszO0r9ePVH6eZE7pkkKVYeur9rfZC1I1DzBKdP9CVkj5onbF5LywxUflkD0G5
         HYOdpE/Jz/m5XjKzni3SdB8+aKfRiGSv9odzxzoh+LWp/7QDeeLERm2H9cvc2tji6dyM
         zGqy6zeELCipMw2RbJPjPTi/MJgCI6u5Tew9CDNgzt/pUVt9k4S+wfXce+ibiY+9N+sT
         KM+w6T4QCut+UOPWR2rZOJTYJQhSw4BySbnBK5YXcK0bBZbhbfGZXP2U3oPCPHkGWhxb
         afpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752197267; x=1752802067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KG9lxpLURaWwhvz42ij9wTJRd68a4iePoTZxhClKIzI=;
        b=AWfe5Bgtwzlii/lAaKwwIzN26751fJo6jvDSPnBVW9ozBTZuXUMDI7ERExNpidAt8V
         5rT+QHILCp2+zC4b9XMiVZk+mq6aW3HepIXJ0N+lDkj22euia/5ad9HRXV1cDTnU3DlF
         T2fytdNRNMC/14HlJDygiJtflLyDWDz61PhHjWlEuT3s0wtSGAFJWIfg8mUbms9nKrLg
         yM/AK2tP4RaMirNDG/hVmzeKRfGXxtm9vGsWkCSmc2PmMD7ID0++fJh2RCkvoL3tnbuj
         BGyMLudApJ8WSeQlNItpz9NqHay1OHtVvfpVOscr8URFIifINashuXsFn3Q/39nArTik
         QNzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbIIGjgYKmna6tZdBCt2G8Pqbv5mbYY2ZDvVOaSUOxEraPNVqcTMY6lemkAt1UWR72aN77jGU/uoQIkL/c@vger.kernel.org, AJvYcCWQPkHch8+O5DwGBbPBd3n491ZsQ7s9tQ2YInprtXukyKo9heoRMZvYewRPFO/jyuHK1F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWVnsS36NH2uSnWKHS78n07iM+27J0k4F06i5OgCvHe7Ijtw9k
	uP7kQ8NdgrX1/rmnxLjRxfTEUvuGhAwPz3jFCiYUTFuV8ViXnWTZrlV7a3LuXIWLQB43wBVwSoD
	6nP0eRTN5ak+y8d6xGPtWIzyI4Wo2z1Q=
X-Gm-Gg: ASbGnctBV5YbaTOJ9h4UOx3SK8UP9ByF/6Zp4trjKw/TT2yTkwiRruJWefV/XsyevIT
	yVxdkGrc1xRQZb07D42kOn7/dmNC+KhqLeqC0gaHVBfXgSqP8ANk5N32Wx2GvU3m/ibWI6aZdK7
	lOzTHTby2RwUdJQw9oPIlQ9Q+FECDs3pEKA6Jm6nERnrIuj2+qrRG4ee1dIA7fJm5styk1BKLs1
	XTbSsk=
X-Google-Smtp-Source: AGHT+IHA8KO4vFXJVj+xo0ubtjuUOVGSX3QHRDGnhbjsuAMjg9EJ9NlFwR2VmPglkjK8rdMruuD6J60xFlc4DxChEeU=
X-Received: by 2002:a05:690c:1d:b0:70e:1474:63f2 with SMTP id
 00721157ae682-717d5b8aee0mr25663137b3.7.1752197267199; Thu, 10 Jul 2025
 18:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710070835.260831-1-dongml2@chinatelecom.cn> <CAEf4BzZZRk0Ko64wy5E34wAa3psk07UhGg9DENU-CQYfLwT1ig@mail.gmail.com>
In-Reply-To: <CAEf4BzZZRk0Ko64wy5E34wAa3psk07UhGg9DENU-CQYfLwT1ig@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 11 Jul 2025 09:27:44 +0800
X-Gm-Features: Ac12FXyodyEcAzVBGP9SODuexdqRjklpsY2SoNP4_DywxeGM8SW-JtdFG9IyHFk
Message-ID: <CADxym3Y16eeQJtd0yi1nT28=NJHmsokuzQx+JuGNsf22vBUxNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: make the attach target more accurate
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 7:25=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jul 10, 2025 at 12:10=E2=80=AFAM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> >
> > For now, we lookup the address of the attach target in
> > bpf_check_attach_target() with find_kallsyms_symbol_value or
> > kallsyms_lookup_name, which is not accurate in some cases.
> >
> > For example, we want to attach to the target "t_next", but there are
> > multiple symbols with the name "t_next" exist in the kallsyms, which ma=
kes
> > the attach target ambiguous, and the attach should fail.
> >
> > Introduce the function bpf_lookup_attach_addr() to do the address looku=
p,
> > which will return -EADDRNOTAVAIL when the symbol is not unique.
> >
> > We can do the testing with following shell:
> >
> > for s in $(cat /proc/kallsyms | awk '{print $3}' | sort | uniq -d)
> > do
> >   if grep -q "^$s\$" /sys/kernel/debug/tracing/available_filter_functio=
ns
> >   then
> >     bpftrace -e "fentry:$s {printf(\"1\");}" -v
> >   fi
> > done
> >
> > The script will find all the duplicated symbols in /proc/kallsyms, whic=
h
> > is also in /sys/kernel/debug/tracing/available_filter_functions, and
> > attach them with bpftrace.
> >
> > After this patch, all the attaching fail with the error:
> >
> > The address of function xxx cannot be found
> > or
> > No BTF found for xxx
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v3:
> > - reject all the duplicated symbols
> > v2:
> > - Lookup both vmlinux and modules symbols when mod is NULL, just like
> >   kallsyms_lookup_name().
> >
> >   If the btf is not a modules, shouldn't we lookup on the vmlinux only?
> >   I'm not sure if we should keep the same logic with
> >   kallsyms_lookup_name().
> >
> > - Return the kernel symbol that don't have ftrace location if the symbo=
ls
> >   with ftrace location are not available
> > ---
> >  kernel/bpf/verifier.c | 71 ++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 66 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 53007182b46b..bf4951154605 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -23476,6 +23476,67 @@ static int check_non_sleepable_error_inject(u3=
2 btf_id)
> >         return btf_id_set_contains(&btf_non_sleepable_error_inject, btf=
_id);
> >  }
> >
> > +struct symbol_lookup_ctx {
> > +       const char *name;
> > +       unsigned long addr;
> > +};
> > +
> > +static int symbol_callback(void *data, unsigned long addr)
> > +{
> > +       struct symbol_lookup_ctx *ctx =3D data;
> > +
> > +       if (ctx->addr)
> > +               return -EADDRNOTAVAIL;
>
> #define ENOTUNIQ        76     /* Name not unique on network */
>
> fits a bit better, no?

Yeah, this looks much better. I'll use it instead of
EADDRNOTAVAIL in the next version.

Thanks!
Menglong Dong

>
> > +       ctx->addr =3D addr;
> > +
> > +       return 0;
> > +}
> > +
>
> [...]

